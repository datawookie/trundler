.onAttach <- function(libname, pkgname) {
  invisible()
}

.onLoad <- function(libname, pkgname) {
  # Handlers for {progressr}.
  #
  # handlers(list(
  #   handler_progress(
  #     format   = ":spin :current/:total [:bar] :percent in :elapsed ETA: :eta",
  #     width    = 80,
  #     complete = "+"
  #   )
  # ))

  invisible()
}

.onUnload <- function(libname, pkgname) {
}
