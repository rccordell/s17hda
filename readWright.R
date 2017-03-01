WRIGHT = list.files("data/wright-txt",full.names = TRUE)

readWRIGHTtext = function(file) {
  message(file)
  text = paste(scan(file, sep="\n",what="raw",strip.white = TRUE))
  WRIGHT = tibble(fileID=file,text=text) %>% group_by(fileID) %>% summarise(text = paste(text, collapse = " "))
  WRIGHTregex <- regexpr("[A-Z][a-z]+.+\\ \\.", WRIGHT$text)
  WRIGHT$title <- regmatches(WRIGHT$text, WRIGHTregex)
  WRIGHT = select(WRIGHT, title, text)
  return(WRIGHT)
}

allWRIGHTtext = tibble(title=WRIGHT) %>% 
  group_by(title) %>% 
  do(readWRIGHTtext(.$title)) 