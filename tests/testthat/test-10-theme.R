context("theme")

plot_data <- product_prices(product_id) %>% mutate(date = as.Date(time))

p <- ggplot(plot_data, aes(x = date, y = price, colour = product_id)) +
  geom_line() +
  labs(title = "Trundler Title",
       subtitle = "Trundler Subtitle",
       caption = "Trundler Caption") +
  theme_trundler() +
  theme_trundler_title() +
  theme_trundler_watermark()

test_that("theme", {
  skip_on_cran()

  expect_equal(as.numeric(p$theme$axis.text.x$size), 10/11)
  expect_equal(as.numeric(p$theme$axis.text.y$size), 10/11)
  expect_equal(as.numeric(p$theme$axis.title.x$size), 15/11)
  expect_equal(as.numeric(p$theme$axis.title.y$size), 15/11)
  expect_equal(as.numeric(p$theme$legend.text$size), 12/11)
})

test_that("theme trundler title", {
  skip_on_cran()

  textbox_class <- c("element_textbox", "element_text", "element")

  expect_equal(class(p$theme$plot.title), textbox_class)
  expect_equal(class(p$theme$plot.subtitle), textbox_class)
  expect_equal(class(p$theme$plot.caption), textbox_class)
})

test_that("theme trundler watermark", {
  skip_on_cran()

  expect_equal(class(p[["layers"]][[2]][["geom"]]),
               c("GeomCustomAnn", "Geom", "ggproto", "gg"))
})
