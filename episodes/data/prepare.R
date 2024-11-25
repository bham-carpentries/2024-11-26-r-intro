library(tidyverse)
options(stringsAsFactors = FALSE)

replace_na_with_mode <- function(x) {
  if (is.character(x)) {
    mode_value <- names(sort(table(x), decreasing = TRUE))[1]
    x[is.na(x)] <- mode_value
  }
  return(x)
}

# prepare penguins data for teaching
df_penguins <- read_csv("episodes/data/penguins.csv")

# Modify Column Name
df_penguins <-
  df_penguins |>
  mutate(year = as.character(year)) |>
  # Impute missing values with column mean / mode
  mutate(across(where(is.numeric), ~ ifelse(is.na(.), mean(., na.rm = TRUE), .))) |>
  mutate(across(where(is.character), replace_na_with_mode))

write_csv(df_penguins, "episodes/data/penguins_teaching.csv")


weather_orig <- data.frame(island = c("torgersen", "biscoe", "dream"), temperature = c(1.6, 1.5, -2.6), snowfall = c(0, 0, 1), stringsAsFactors = FALSE)
weather_bad <- data.frame(island = c("torgersen", "biscoe", "dream","deception"), temperature = c(1.6, 1.5, -2.6, "-3.4 or 3.5"), snowfall = c(1, 0, 1, 1), stringsAsFactors = FALSE)
weather <- weather_orig
write.csv(weather_orig, "episodes/data/weather-data.csv")
write.csv(weather_bad, "episodes/data/weather-data_v2.csv")
