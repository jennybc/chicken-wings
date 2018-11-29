library(tidyverse)

wings <- tribble(
  ~count, ~price,
  4,   4.55,
  5,    5.7,
  6,    6.8,
  7,   7.95,
  8,    9.1,
  9,   10.2,
  10,  11.35,
  11,   12.5,
  12,   13.6,
  13,  14.75,
  14,   15.9,
  15,     17,
  16,  18.15,
  17,   19.3,
  18,   20.4,
  19,  21.55,
  20,   22.7,
  21,   23.8,
  22,  24.95,
  23,   26.1,
  24,  27.25,
  25,   27.8,
  26,  28.95,
  27,   30.1,
  28,   31.2,
  29,  32.35,
  30,   33.5,
  35,  39.15,
  40,   44.8,
  45,   50.5,
  50,   55.6,
  60,     67,
  70,   78.3,
  75,  83.45,
  80,   89.1,
  90, 100.45,
  100, 111.25,
  125,    139,
  150, 166.85,
  200,  222.5
)
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
