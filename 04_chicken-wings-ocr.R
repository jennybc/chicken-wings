library(magick)
library(tesseract)
library(tidyverse)

#wings_source <- "chicken-wings-from-tweet-1054136447362629637.jpg"
wings_source <- "https://github.com/jennybc/chicken-wings/raw/master/chicken-wings-from-tweet-1054136447362629637.jpg"

wings_image <- image_read(wings_source)
wings_prices <- image_ocr(wings_image)

raw <- str_extract_all(
  wings_prices,
  "[A-Za-z0-9]+ Chicken Wings [0-9]+[.][0-9]+"
)[[1]]

## manual fix for an "11" that OCR'd as "Il"
raw <- str_replace(raw, "Il", "11")

## manual fix for a "B14"
raw <- str_replace(raw, "B14", "14")

wings <- tibble(raw)

wings <- wings %>%
  separate(
    raw,
    into = c("count", "chicken", "wings", "price"),
    sep = "[:space:]",
    convert = TRUE
  ) %>%
  select(-chicken, -wings) %>%
  arrange(count)
head(wings)

wings <- wings %>%
  mutate(
    wing_cost = price/count,
    marginal_wing_cost =
      (price - lag(price, default = 0)) / (count - lag(count, default = 0))
  )

# sanity check
ggplot(wings, aes(x = count, y = price)) +
  geom_point()

# cost per wing against total wings bought
# https://twitter.com/dataandme/status/1056343232735571969
ggplot(wings, aes(x = count, y = wing_cost)) +
  geom_path()

# marginal wing price
# https://twitter.com/alistaire/status/1056531627445231621
ggplot(wings, aes(x = count, y = marginal_wing_cost)) +
  geom_path()
