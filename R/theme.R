#' Format plot title, subtitle and caption
#'
#' @param title Plot title
#' @param subtitle Plot subtitle
#' @param caption Plot caption
#'
#' @export
theme_trundler_title <- function(title = TRUE, subtitle = TRUE, caption = TRUE) {
  theme(
    plot.title.position = "plot",
    plot.caption.position = "plot",
    plot.title = element_textbox_simple(
      size = rel(2),
      lineheight = 1,
      padding = margin(7.5, 5.5, 5.5, 5.5),
      margin = margin(0, 0, ifelse(subtitle, 0, 5.5), 0),
      fill = TRUNDLER_SLATE,
      colour = "white"
    ),
    plot.subtitle = element_textbox_simple(
      size = rel(1),
      face = "italic",
      lineheight = 1,
      padding = margin(0, 5.5, 5.5, 5.5),
      margin = margin(0, 0, 10.5, 0),
      fill = TRUNDLER_SLATE,
      colour = "white"
    ),
    plot.caption = element_textbox_simple(
      size = rel(1),
      face = "italic",
      hjust = 1,
      halign = 1,
      lineheight = 1,
      padding = margin(7.5, 5.5, 5.5, 5.5),
      margin = margin(7.5, 0, 0, 0),
      fill = TRUNDLER_SLATE,
      colour = "white"
    )
  )
}

#' Trundler theme
#'
#' @export
theme_trundler <- function(base_size = 11) {
  theme_classic(base_size = base_size) +
    theme(
      axis.text.y = element_text(size = 10, angle = 90, hjust = 0.5),
      axis.text.x = element_text(size = 10),
      axis.title.y = element_text(size = 15),
      axis.title.x = element_text(size = 15),
      legend.text = element_text(size = 12)
    )
}

#' Add watermark to plot
#'
#' Make this the first layer in the plot so that it's below all the content.
#'
#' @param label
#'
#' @export
theme_trundler_watermark <- function(label = "WIP", fontsize = 256) {
  text_grob = grid::grobTree(
    grid::textGrob(
      label,
      x = 0.5, y = 0.5,
      hjust = 0.5, vjust = 0.5,
      gp = grid::gpar(
        col = TRUNDLER_SLATE,
        alpha = 0.25,
        fontsize = fontsize
      )
    )
  )

  annotation_custom(text_grob, xmin = -Inf, ymin = -Inf, xmax = Inf, ymax = Inf)
}
