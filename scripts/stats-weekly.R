library(trundler)
library(lubridate)
library(dplyr)
library(tidyr)
library(glue)
library(ggplot2)
library(patchwork)
library(assertthat)

COLOUR_BLUE <- "#3498db"
COLOUR_ORANGE <- "#ffa330"
COLOUR_GREY <- "#8b9196"
COLOUR_GREY_LIGHT <- "#edeeee"

# DATA FROM API -------------------------------------------------------------------------------------------------------

API_KEY <- Sys.getenv("TRUNDLER_KEY")
set_api_key(API_KEY)

retailers <- retailer()

stats_daily_raw <- admin_stats_daily()
stats_raw <- admin_stats()

# UTILITY -------------------------------------------------------------------------------------------------------------

retailer_name <- function(id) {
  retailers %>%
    filter(retailer_id == id) %>%
    pull(retailer)
}

retailer_currency <- function(id) {
  retailers %>%
    filter(retailer_id == id) %>%
    pull(currency)
}

# WRANGLE -------------------------------------------------------------------------------------------------------------

stats_daily <- stats_daily_raw %>%
  # Fill explicit missing values.
  complete(
    date = do.call(seq.Date, c(as.list(range(.$date)), "day")),
    retailer_id,
    fill = list(count = 0)
  ) %>%
  # Remove current date.
  filter(date < max(date)) %>%
  # mutate(
  #   price_mean = price_total / count
  # ) %>%
  select(-price_sum)

# Wide view.
#
if (interactive()) {
  stats_daily %>% spread(retailer_id, count) %>% View()
}

# Sort out dates.
#
stats_daily <- stats_daily %>%
  mutate(
    dow = wday(date, label = TRUE),
    year = year(as.POSIXlt(date)),
    week = epiweek(as.POSIXlt(date)),
  ) %>%
  group_by(retailer_id) %>%
  arrange(desc(date)) %>%
  mutate(
    current = as.integer(Sys.Date() - date) <= 7
  ) %>%
  ungroup()

# Day of week order.
#
DOW_LEVELS <- stats_daily %>%
  select(date, dow) %>%
  unique() %>%
  # Probably not necessary since already sorted, but let's be safe!
  arrange(desc(date)) %>%
  pull(dow) %>%
  head(7) %>%
  rev() %>%
  as.character() %>%
  unique()

# Check that all days represented!
#
are_equal(length(DOW_LEVELS), 7)

stats_daily <- stats_daily %>%
  mutate(
    # Change order of "day of week" levels (most recent at end).
    dow = factor(dow, levels = DOW_LEVELS)
  )

# PLOT ----------------------------------------------------------------------------------------------------------------

retailer_plot <- function(id) {
  data <- stats_daily %>% filter(retailer_id == id)

  data_history <- data %>% filter(current == FALSE)
  data_current <- data %>% filter(current == TRUE)

  BAR_WIDTH <- 0.75

  plot_count <- ggplot(data_current, aes(x = dow, y = count)) +
    geom_boxplot(
      data = data_history,
      width = BAR_WIDTH,
      colour = COLOUR_GREY,
      fill = COLOUR_GREY_LIGHT
    ) +
    geom_text(aes(label = as.character(date)), vjust = -0.75, size = 3) +
    geom_segment(
      aes(
        x=as.numeric(dow) - BAR_WIDTH / 2,
        xend=as.numeric(dow) + BAR_WIDTH / 2,
        yend=count
      ),
      colour = COLOUR_BLUE,
      size = 2,
      alpha = 0.75
    ) +
    labs(x = NULL, y = "Number of products") +
    theme_classic()

  plot_price <- ggplot(data_current, aes(x = dow, y = price_avg)) +
    geom_boxplot(
      data = data_history,
      width = BAR_WIDTH,
      colour = COLOUR_GREY,
      fill = COLOUR_GREY_LIGHT,
      na.rm=TRUE
    ) +
    geom_text(aes(label = as.character(date)), vjust = -0.75, size = 3, na.rm=TRUE) +
    geom_segment(
      aes(
        x=as.numeric(dow) - BAR_WIDTH / 2,
        xend=as.numeric(dow) + BAR_WIDTH / 2,
        yend=price_avg
      ),
      colour = COLOUR_ORANGE,
      size = 2,
      alpha = 0.75,
      na.rm=TRUE
    ) +
    labs(x = NULL, y = glue("Average price ({retailer_currency(id)})")) +
    theme_classic()

  data_week <- data %>% filter(dow == "Sun")

  date_range <- range(data$date)

  plot_series_count <- ggplot(data, aes(x = date, y = count)) +
    geom_step() +
    geom_vline(data = data_week, aes(xintercept = date), lty = "dashed", colour = COLOUR_GREY) +
    labs(x = NULL, y = NULL) +
    scale_x_date(limits = date_range) +
    theme_classic() +
    theme(
      axis.ticks.x = element_blank(),
      axis.text.x = element_blank()
    )

  plot_series_price <- ggplot(data, aes(x = date, y = price_avg)) +
    geom_step(na.rm = TRUE) +
    geom_vline(data = data_week, aes(xintercept = date), lty = "dashed", colour = COLOUR_GREY) +
    labs(x = NULL, y = NULL) +
    scale_x_date(limits = date_range) +
    theme_classic() +
    theme(
      axis.ticks.x = element_blank(),
      axis.text.x = element_blank()
    )

  data <- stats_raw %>% filter(retailer_id == id)

  plot_overlap <- ggplot(data) +
    geom_segment(aes(x = start_time, xend = finish_time), y = 0, yend = 0, lwd = 5, alpha = 0.25, color = COLOUR_BLUE) +
    scale_y_continuous(limits = c(-0.5, 0.5)) +
    scale_x_datetime(limits = as.POSIXct(date_range)) +
    labs(x = NULL, y = NULL) +
    theme_classic() +
    theme(
      axis.ticks.y = element_blank(),
      axis.text.y = element_blank(),
      axis.line.y = element_blank()
    )

  plot_count + plot_price + plot_series_count + plot_series_price + plot_overlap +
    plot_layout(ncol = 1, nrow = 5, heights = c(6, 6, 2, 2, 1)) +
    plot_annotation(
      title = glue("{retailer_name(id)}")
    )
}
retailer_plot(1)
retailer_plot(5)
retailer_plot(9)
retailer_plot(38)
retailer_plot(57)
retailer_plot(58)

# ---------------------------------------------------------------------------------------------------------------------

retailers %>%
  slice(1:3) %>%
  select(retailer_id) %>%
  pmap(function(retailer_id) {
    retailer_plot(retailer_id)
  })


