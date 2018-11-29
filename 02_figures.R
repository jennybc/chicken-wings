library(tidyverse)
conflicted::conflict_prefer("lag", "dplyr")

wings <- read_csv("chicken-wings.csv")

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
