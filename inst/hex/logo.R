library(hexSticker)
library(showtext)
library(here)

# Load Google font.
#
font_add_google("Cantarell", "cantarell")
showtext_auto()

IMAGE = tempfile(fileext = ".svg")
#
IMAGE = path.expand(IMAGE)
#
download.file("https://raw.githubusercontent.com/datawookie/www-trundler-dev-academic/dev/assets/images/trolley-branding.svg", IMAGE)

LOGO_PATH = here("man/figures/")
LOGO_FILE = file.path(LOGO_PATH, "logo.png")

dir.create(LOGO_PATH, recursive = TRUE)

sticker(
        # Image
        # here::here("inst/hex/", IMAGE),
        IMAGE,
        s_width = 1395 * 0.0006,
        s_height = 1600 * 0.0006,
        s_x = 0.95,
        s_y = 1.00,
        # Package name
        package = "trundler",
        p_size = 36,
        p_x = 1.370,
        p_y = 0.365,
        p_color = "#000000",
        p_family = "cantarell",
        # Hex
        h_fill = "#ffffff",
        h_color = "#000000",
        # Spotlight
        spotlight = FALSE,
        # Output
        filename = here("man/figures/logo.png"),
        dpi = 600,
        angle = 30
)
