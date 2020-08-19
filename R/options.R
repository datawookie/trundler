options.trundler <- list(
  trundler.chatty = TRUE
)

trundler_option <- function(option) {
  option <- paste0("trundler.", option)

  result <- getOption(option)
  if (!is.null(result)) {
    # Get option (if set).
    result
  } else {
    # Get default.
    options.trundler[[option]]
  }
}

trundler_chatty <- function() {
  trundler_option("chatty")
}
