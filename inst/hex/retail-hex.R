library(hexSticker)
library(showtext)

# Load Google font.
#
font_add_google("Raleway", "raleway")
showtext_auto()

IMAGE = "shopping-bag-red.png"
# IMAGE = "shopping-bag-brown.png"

sticker(
        # Image
        here::here("inst/hex/", IMAGE),
        s_width = 1395 * 0.0005,
        s_height = 1600 * 0.0005,
        s_x = 1.00,
        s_y = 1.10,

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
        spotlight = TRUE,
        l_x = 0.95,
        l_y = 0.80,
        l_width = 2.5,
        l_height = 2.5,
        l_alpha = 0.3,
        # Output
        filename = here::here("man/figures/retail-hex.png"),
        dpi = 600,
        angle = 30
)
