
library(tidyverse)
rm(list = ls())

sba.puma.xwalk <- list.files('~/R/local-data/'
           ,pattern = 'SBA-PUMA Crosswalk.csv'
           ,full.names = T) %>%
  vroom::vroom()


# write
usethis::use_data(sba.puma.xwalk
                  , overwrite = TRUE)
