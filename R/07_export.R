#friends graph------------
ggsave(
  filename = "outputs/friend_plot.jpeg",
  plot = FriendPlot,
  dpi = 300
)

#maps-------------------------------

#world
ggsave(
  filename = "outputs/world_plot.jpeg",
  plot = LocMap,
  dpi = 300
)

#ukire
ggsave(
  filename = "outputs/uk_ire.jpeg",
  plot = UkIreMap,
  dpi = 300
  )

#app use----------------

#by app
ggsave(
  filename = "outputs/by_app.jpeg",
  plot = OverallAppPlot,
  dpi = 300
)

#by month
ggsave(
  filename = "outputs/apps_by_month.jpeg",
  plot = ByMonthAppPlot,
  dpi = 300
)
