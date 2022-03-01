library(tidyverse)
library(sf)

#' From NYC Open data
#' https://data.cityofnewyork.us/Business/Zip-Code-Boundaries/i8iw-xf4u
#'
#' (not census b/c they don't update often and ZIPs change. I.e.,
#' https://about.usps.com/news/state-releases/ny/2011/ny_2011_0603.htm)
zipsf <- st_read('ZIP_CODE_040114/ZIP_CODE_040114.shp')

zipsf <- zipsf %>%
  rename_with( tolower ) %>%
  select(zip = zipcode,
         state, county, geometry)

zipsf[1] %>% plot()

zipsf <- zipsf %>% st_transform(4326)

# write ------------------------------------------------------------------------

usethis::use_data(zipsf)

