#giant list of data-------------------------------

#get directory names
FbDirectories <- list.files(here::here("data"))

#create nested list
FbData <- lapply(FbDirectories, read_fb_data)
names(FbData) <- FbDirectories
