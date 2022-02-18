
library(tidyverse)
# load data Melanie entried
eps.zips <- '.local data/EPS_Zips.csv'
eps.zips <- vroom::vroom(eps.zips)
eps.zips <- eps.zips %>%
  rename_with( ~tolower(make.names(.x)) )


usethis::use_data(eps.zips, overwrite = TRUE)
