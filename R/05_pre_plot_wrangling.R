#posts-------------------------------------

#by year
PostsByYr <- Posts %>%
  group_by(timestamp_year) %>%
  summarise(count = n()) %>%
  ungroup()

#additional locations data--------------------

#map data
WorldMap <- ne_countries(scale = "medium", returnclass = "sf")
