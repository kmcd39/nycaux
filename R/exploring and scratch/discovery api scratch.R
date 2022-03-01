
# notes ------------------------------------------------------------------------

#' see i.e.,
#'
#' https://socratadiscovery.docs.apiary.io/#
#'
#' Datasets can be found by keywords, high-level categorizations, tags, and much
#' more. This API, then, is a powerful way to access and explore all public metadata
#' published on the Socrata platform.
#'
#' (socrata hosts NYC open data and many other govt datasets)
#'
#'
#' he production API endpoints for the public version of this API are at
#' https://api.us.socrata.com/api/catalog/v1 for domains in North America and
#' https://api.eu.socrata.com/api/catalog/v1 for all other domains.
#'
#' For example, to query for datasets categorized as 'Public Safety', you could use
#' the following query:
#' http://api.us.socrata.com/api/catalog/v1?categories=public%20safety
#'
#' Also see R package
#' https://dev.socrata.com/connectors/rsocrata.html
#'
#'


# use Rsocrata to check nyc datasets -------------------------------------------

nyc.open.data <- RSocrata::ls.socrata('https://data.cityofnewyork.us/')

nyc.open.data %>% class()
nyc.open.data <- tibble(nyc.open.data)


# peaks ------------------------------------------------------------------------


nyc.open.data %>% head()

nyc.open.data %>% glimpse()

nyc.open.data[1,] %>%
  select(title, description, distribution)
nyc.open.data[1,]$distribution
nyc.open.data[1,]$description

nyc.open.data %>% select(title, description)



# all SNAP ---------------------------------------------------------------------

snaps <-  nyc.open.data %>%
  filter(grepl('SNAP', title) |
           grepl('SNAP', description)) %>%
  count(title, description)

snaps

snd <- nyc.open.data  %>%
  filter(title %in% snaps$title)

snd %>% glimpse()

snaps

to.query <-snd[grepl('SNAP Population'
                     ,snd$title),]
tmp.urls <- to.query$landingPage

tmps <- map(tmp.urls,
            RSocrata::read.socrata) %>%
  map(tibble) %>%
  setNames(to.query$title)

tmps

# practice w the soql -----------------------------------------------------------

tmp <- RSocrata::validateUrl(tmp.urls[2]
                             ,app_token = Sys.getenv('nycopendata'))

tmp %>% paste0('&boro=BRONX') %>%
  RSocrata::read.socrata() %>%
  count(boro)

# so cool!
