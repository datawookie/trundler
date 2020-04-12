library(retail)
library(lubridate)
library(dplyr)
library(tidyr)
library(ggplot2)

API_KEY = Sys.getenv("RETAIL_KEY")

set_api_key(API_KEY)

stats_raw <- admin_stats_daily()

stats <- stats_raw %>%
  # Fill explicit missing values.
  complete(
    date = do.call(seq.Date, c(as.list(range(stats$date)), "day")),
    retailer_id,
    fill = list(count = 0)
  ) %>%
  # Remove current date.
  filter(date < max(date))

# Wide view.
#
if (interactive()) {
  stats %>% spread(retailer_id, count) %>% View()
}

stats <- stats %>%
  mutate(
    dow = wday(date, label = TRUE),
    year = year(as.POSIXlt(date)),
    week = epiweek(as.POSIXlt(date)),
  ) %>%
  group_by(retailer_id) %>%
  arrange(desc(date)) %>%
  mutate(
    current = week == max(week) & year == max(year)
  ) %>%
  ungroup()

stats_aggregate <- stats %>%
  filter(!current) %>%
  group_by(retailer_id, dow) %>%
  summarise(
    min = min(count),
    max = max(count),
    avg = mean(count)
  )

stats_current <- stats %>%
  filter(current)

ggplot(stats_aggregate, aes(x = dow, group = retailer_id)) +
  geom_ribbon(aes(ymin = min, ymax = max), fill = "lightblue", alpha = 0.5) +
  geom_line(aes(y = avg), colour = "darkblue") +
  geom_line(data = stats_current, aes(y = count)) +
  facet_wrap(~ retailer_id)
