#friends data--------------------------
Friends <- map_df(FbData[["friends"]][[1]], .f = ~as.data.table(x = .x)) %>%
  #turn into tall format
  pivot_longer(
    cols = everything(),
    names_to = "col_number",
    values_to = "data"
  ) %>%
  #group data by original column
  group_by(col_number) %>%
  mutate(row = row_number()) %>%
  ungroup() %>%
  #wider format
  pivot_wider(
    names_from = row,
    values_from = data
  ) %>%
  select(-col_number) %>%
  #rename
  setNames(c("name", "timestamp", "contact")) %>%
  #clear duplicates and change timestamp format to posixct
  mutate(
    contact = ifelse(unlist(name) == unlist(contact), NA_character_, unlist(contact)),
    timestamp = as.POSIXct(unlist(timestamp), origin = "1970-01-01"),
    year = year(timestamp)
    ) %>%
  group_by(year) %>%
  summarise(count = n()) %>%
  ungroup()

#posts data-------------------------------
Posts <- map_df(FbData[["posts"]][[1]], .f = ~as.data.table(x = .x)) %>%
  mutate(post_id = str_pad(row_number(), width = 3, side = "left", pad = "0")) %>%
  #unnest
  unnest_wider(data) %>%
  unnest_wider(attachments) %>%
  unnest_wider(data) %>%
  unnest_wider(...1) %>%
  unnest_wider(place) %>%
  unnest_wider(media, names_repair = janitor::make_clean_names) %>%
  unnest_wider(event, names_repair = janitor::make_clean_names) %>%
  unnest_wider(coordinate) %>%
  unnest_wider(media_metadata) %>%
  unnest_wider(photo_metadata) %>%
  unnest_wider(external_context, names_repair = janitor::make_clean_names) %>%
  #set timestamps
  mutate(
    across(contains("timestamp"), function(x) as.POSIXct(x, origin = "1970-01-01")),
    across(contains("timestamp"), function(x) year(x), .names = "{col}_year")
    )

#location data------------------------------------
Locations <- map_df(FbData[["location"]][[1]], .f = ~as.data.table(x = .x)) %>%
  #turn into tall format
  pivot_longer(
    cols = everything(),
    names_to = "col_number",
    values_to = "data"
  ) %>%
  #group data by original column
  group_by(col_number) %>%
  mutate(row = row_number()) %>%
  ungroup() %>%
  #wider format
  pivot_wider(
    names_from = row,
    values_from = data
  ) %>%
  select(-col_number) %>%
  setNames(c("location_name", "coordinates", "timestamp")) %>%
  unnest_wider(coordinates) %>%
  #convert timestamp
  mutate(
    timestamp = as.POSIXct(unlist(timestamp), origin = "1970-01-01"),
    year = year(timestamp)
  )


#app use--------------------------------------------

AppUse <- map_df(FbData[["ads_and_businesses"]][[4]][["off_facebook_activity"]], .f = ~as.data.table(x = .x)) %>%
  unnest_wider(events) %>%
  #convert timestamp
  mutate(
    timestamp = as.POSIXct(unlist(timestamp), origin = "1970-01-01"),
    year = year(timestamp),
    month = month(timestamp),
    year_month = glue("{year}-{str_pad(month, width = 2, side = 'left', pad = '0')}")
  ) 
  
 
