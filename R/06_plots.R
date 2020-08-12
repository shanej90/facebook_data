#friends plot----------------------------------------

FriendPlot <- ggplot(
  data = Friends,
  aes(
    x = year,
    y = count
  )
) +
  geom_col(position = "dodge", fill = "#cb4b16") +
  geom_text(aes(label = count), vjust = -0.5) +
  xlab("Year") +
  ylab("Friends") +
  theme_gdocs() +
  theme(axis.title = element_text(face = "bold"))

#map-----------------------------------------------------------

#all locations
LocMap <- ggplot(data = WorldMap) +
  geom_sf(fill = "#859900") +
  coord_sf(xlim = c(-130, 5), ylim = c(40, 60)) +
  geom_point(
    data = Locations %>%
      #group to get count of times
      group_by(location_name, latitude, longitude, year) %>%
      summarise(count = n()) %>%
      ungroup(),
    aes(
      x = longitude,
      y = latitude,
      size = sqrt(count)
      ),
    fill = "#b58900"
    ) +
  scale_size_continuous(name = "Number of visits", breaks = sqrt(c(1, 2, 3)), labels = c(1, 2, 3)) +
  theme_gdocs() +
  theme(
    axis.text = element_blank(),
    axis.title = element_blank(),
    panel.grid.major = element_blank()
  )

#uk/eire only
UkIreMap <- ggplot(data = WorldMap) +
  geom_sf(fill = "#859900") +
  coord_sf(xlim = c(-10, 0), ylim = c(50, 54)) +
  geom_point(
    data = Locations %>%
      #group to get count of times
      group_by(location_name, latitude, longitude, year) %>%
      summarise(count = n()) %>%
      ungroup(),
    aes(
      x = longitude,
      y = latitude
    ),
    fill = "#b58900"
  ) +
  theme_solarized() +
  theme(
    axis.text = element_blank(),
    axis.title = element_blank(),
    panel.grid.major = element_blank()
  )

#app usage----------------------------------------------

#overall
OverallAppPlot <- ggplot(
  AppUse %>%
    mutate(name = str_wrap(name, 25)) %>%
    group_by(name) %>%
    summarise(events = n()) %>%
    ungroup() %>%
    mutate(name = fct_reorder(name, events)) %>%
    filter(events > 100),
  aes(
    x = name,
    y = events
  )
) +
  geom_col(fill = "#cb4b16") +
  xlab("App") +
  ylab("Events") +
  geom_text(aes(label = events)) +
  theme_gdocs() +
  theme(
    panel.grid.major.x = element_blank(),
    axis.text.x = element_text(angle = 45, vjust = 0.4),
    axis.title = element_text(face = "bold")
  )

#by month app plot
ByMonthAppPlot <- ggplot(
  AppUse %>%
    group_by(year_month) %>%
    summarise(events = n()) %>%
    ungroup() %>%
    filter(!year_month %in% c("2019-07", "2020-08")),
  aes(
    x = year_month,
    y = events
    )
  ) +
  geom_col(fill = "#cb4b16") +
  xlab("Month") +
  ylab("Events") +
  geom_text(aes(label = events), vjust = .01) +
  theme_gdocs() +
  theme(
    panel.grid.major.x = element_blank(),
    axis.title = element_text(face = "bold")
  )


