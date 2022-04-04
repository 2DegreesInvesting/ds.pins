pins_url <- function() {
  "https://www.dropbox.com/work/2%C2%B0%20Investing%20Team/People/Mauro"
}

pins_path <- function(...) {
  team <- paste0("2", r2dii.utils::degrees(), " Team")
  r2dii.utils::path_dropbox_2dii(team, "People", "Mauro", "pins", ...)
}
