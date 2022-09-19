#' Format plot title, subtitle and caption
#'
#' This is a separate function so that it can be applied to plots which are
#' constructed using {patchwork}.
#'
#' @param subtitle Set to TRUE by default.  If FALSE, then increase the margin size to prevent collisions between the title and the plot.
#'
#' @export
theme_trundler_title <- function(subtitle = TRUE) {
  theme(
    plot.title.position = "plot",
    plot.caption.position = "plot",
    plot.title = element_textbox_simple(
      size = rel(22 / 11),
      lineheight = 1,
      padding = margin(7.5, 5.5, 5.5, 5.5),
      margin = margin(0, 0, ifelse(subtitle, 0, 5.5), 0),
      fill = TRUNDLER_SLATE,
      colour = "white"
    ),
    plot.subtitle = element_textbox_simple(
      size = rel(11 / 11),
      face = "italic",
      lineheight = 1,
      padding = margin(0, 5.5, 5.5, 5.5),
      margin = margin(0, 0, 10.5, 0),
      fill = TRUNDLER_SLATE,
      colour = "white"
    ),
    plot.caption = element_textbox_simple(
      size = rel(11 / 11),
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
#' @param base_size Base font size (in pts)
#'
#' @export
theme_trundler <- function(base_size = 11) {
  theme_classic(base_size = base_size) +
    theme(
      axis.text.y = element_text(size = rel(10 / 11), angle = 90, hjust = 0.5),
      axis.text.x = element_text(size = rel(10 / 11)),
      axis.title.y = element_text(size = rel(15 / 11)),
      axis.title.x = element_text(size = rel(15 / 11)),
      legend.text = element_text(size = rel(12 / 11))
    )
}

#' Add watermark to plot
#'
#' Make this the first layer in the plot so that it's below all the content.
#'
#' @param label Text for watermark
#' @param fontsize Font size for watermark
#'
#' @export
theme_trundler_watermark <- function(label = "WIP", fontsize = 256) {
  text_grob <- grid::grobTree(
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
