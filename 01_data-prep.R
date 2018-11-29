library(tidyverse)

source("chicken-wings-via-tribble-mara.R")

wings

wings <- wings %>%
  select(-item)

library(datapasta)

#tribble_paste(wings)
#dpasta(wings)
writeLines(tribble_construct(wings), "chicken-wings-via-tribble.R")


write_csv(wings, "chicken-wings.csv")
