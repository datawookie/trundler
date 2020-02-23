library(hexSticker)
library(showtext)

# Load Google font.
#
font_add_google("Raleway", "raleway")
showtext_auto()

sticker(here::here("inst/hex/cash-register.png"),
        # Image
        s_x = 0.85,
        s_y = 1.10,
        s_width = 0.675,
        s_height = 0.675,
        # Package name
        package = "retail",
        p_size = 64,
        p_x = 1.350,
        p_y = 0.425,
        p_color = "#000000",
        p_family = "raleway",
        # Hex
        h_fill = "#cccccc",
        h_color = "#000000",
        # Spotlight
        # spotlight = TRUE,
        # l_x = 0.85,
        # l_y = 1.10,
        # l_alpha = 0.4,
        # Output
        filename = here::here("man/figures/retail-hex.png"),
        dpi = 600,
        angle = 30
)
