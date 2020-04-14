library(retail)
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

API_KEY = Sys.getenv("RETAIL_KEY")

set_api_key(API_KEY)

retailers <- retailer()

stats_raw <- admin_stats_daily()

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

stats <- stats_raw %>%
  # Fill explicit missing values.
  complete(
    date = do.call(seq.Date, c(as.list(range(stats$date)), "day")),
    retailer_id,
    fill = list(count = 0)
  ) %>%
  # Remove current date.
  filter(date < max(date)) %>%
  mutate(
    price_mean = price_total / count
  ) %>%
  select(-price_total)

# Wide view.
#
if (interactive()) {
  stats %>% spread(retailer_id, count) %>% View()
}

# Sort out dates.
#
stats <- stats %>%
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
DOW_LEVELS <- stats %>%
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

stats <- stats %>%
  mutate(
    # Change order of "day of week" levels (most recent at end).
    dow = factor(dow, levels = DOW_LEVELS)
  )

# PLOT ----------------------------------------------------------------------------------------------------------------

retailer_week_boxplot <- function(id) {
  data_history <- stats %>% filter(retailer_id == id, current == FALSE)
  data_current <- stats %>% filter(retailer_id == id, current == TRUE)

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
      size = 2
    ) +
    labs(x = NULL, y = "Number of products") +
    theme_classic()

  data_history <- na.omit(data_history)
  data_current <- na.omit(data_current)

  plot_price <- ggplot(data_current, aes(x = dow, y = price_mean)) +
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
        yend=price_mean
      ),
      colour = COLOUR_ORANGE,
      size = 2
    ) +
    labs(x = NULL, y = glue("Average price ({retailer_currency(id)})")) +
    theme_classic()

  (plot_count / plot_price)  + plot_annotation(
    title = glue("{retailer_name(id)}")
  )
}
retailer_week_boxplot(5)
retailer_week_boxplot(9)

retailer_price <- function(id) {
  data <- stats %>% filter(retailer_id == id)

  data_week <- data %>% filter(dow == "Sun")

  plot_count <- ggplot(data, aes(x = date, y = count)) +
    geom_step() +
    geom_vline(data = data_week, aes(xintercept = date), lty = "dashed", colour = COLOUR_GREY) +
    labs(x = NULL, y = "Number of products") +
    theme_classic()

  plot_price <- ggplot(data, aes(x = date, y = price_mean)) +
    geom_step() +
    geom_vline(data = data_week, aes(xintercept = date), lty = "dashed", colour = COLOUR_GREY) +
    labs(x = NULL, y = glue("Average price ({retailer_currency(id)})")) +
    theme_classic()

  (plot_count / plot_price)  + plot_annotation(
    title = glue("{retailer_name(id)}")
  )
}
retailer_price(5)
retailer_price(9)
retailer_price(10)
