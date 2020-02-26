library(hexSticker)
library(showtext)

# Load Google font.
#
# font_add_google("Raleway", "raleway")
# showtext_auto()

# SCALE = 0.0005 # shopping_bag_PNG6389.png
SCALE = 0.0005 # dorinda-clip-handbag-1.png

sticker(
        # Image


        # here::here("inst/hex/cash-register.png"),
        # s_width = 0.675,
        # s_height = 0.675,
        # here::here("inst/hex/tie-dye.jpg"),
        # s_width = 1.0,
        # s_height = 1.0,
        # here::here("inst/hex/6353ef1e14f68d8d609392fee28cf9c5.png"),
        # s_width = 0.8,
        # s_height = 0.8,
        # here::here("inst/hex/77452129dbce067abf80043ec24960ff.jpg"),
        # s_width = 0.9,
        # s_height = 0.6,
        # here::here("inst/hex/background-with-colorful-shopping-bags-discount-vector-3347126.jpg"),
        # s_width = 0.9,
        # s_height = 0.6,
        # here::here("inst/hex/Cartoon-shopping-woman-vector.jpg"),
        # s_width = 0.9,
        # s_height = 0.6,
        # here::here("inst/hex/kissclipart-cartoon-girl-shopping-png-clipart-shopping-6b2c60c6992c4638.png"),
        # s_width = 0.9,
        # s_height = 0.6,
        #
        #
        #
        # here::here("inst/hex/dorinda-clip-handbag-1.png"),
        # s_x = 1.00,
        # s_y = 1.20,

        here::here("inst/hex/shopping-bag-red.png"),
        # here::here("inst/hex/shopping-bag-brown.png"),
        # s_width = 1193 * SCALE,
        # s_height = 1404 * SCALE,
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
        # spotlight = TRUE,
        # l_x = 0.85,
        # l_y = 1.10,
        # l_alpha = 0.4,
        # Output
        filename = here::here("man/figures/retail-hex.png"),
        dpi = 600,
        angle = 30
)
