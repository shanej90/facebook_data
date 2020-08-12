#read data function------------------------
read_fb_data <- function(.directory) {
  
  #directory
  directory <- here::here("data", .directory)
  
  #filenames
  filenames <- list.files(path = directory, pattern = "*.json")
  
  #read data
  data <- lapply(glue("{directory}/{filenames}"), read_json)
  
  
}
