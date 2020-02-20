library(hexSticker)
library(showtext)

# Load Google font.
#
font_add_google("Roboto Slab", "roboto_slab")
showtext_auto()

sticker(here::here("inst/hex/cash-register.png"),
        # Image
        s_x = 0.95,
        s_y = 1.15,
        s_width = 0.6,
        s_height = 0.6,
        # Package name
        package = "retail",
        p_size =48,
        p_y = 0.45,
        p_color = "#000000",
        p_family = "roboto_slab",
        # Hex
        h_fill = "#ffffff",
        h_color = "#000000",
        # Spotlight
        spotlight = FALSE,
        # l_y = 0.45,
        # l_alpha = 0.4,
        # Output
        filename = here::here("man/figures/retail-hex.png"),
        dpi = 600
)
