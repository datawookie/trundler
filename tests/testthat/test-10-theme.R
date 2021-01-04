context("theme")

plot_data <- product_prices(product_id) %>% mutate(date = as.Date(time))

p <- ggplot(plot_data, aes(x = date, y = price, colour = product_id)) +
  geom_line() +
  labs(title = "Trundler Title",
       subtitle = "Trundler Subtitle",
       caption = "Trundler Caption") +
  theme_trundler()

test_that("theme", {
  skip_on_cran()

  expect_true(length(p$theme) > 0)
})

test_that("theme trundler title", {
  skip_on_cran()

  p <- p + theme_trundler_title()

  textbox_class <- c("element_textbox", "element_text", "element")

  expect_equal(class(p$theme$plot.title), textbox_class)
  expect_equal(class(p$theme$plot.subtitle), textbox_class)
  expect_equal(class(p$theme$plot.caption), textbox_class)
})

test_that("theme trundler watermark", {
  skip_on_cran()

  p <- p + theme_trundler_watermark()

  expect_equal(class(p[["layers"]][[2]][["geom"]]),
               c("GeomCustomAnn", "Geom", "ggproto", "gg"))
})
