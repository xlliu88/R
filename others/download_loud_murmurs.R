library(xml2)
library(tidyr)
library(stringr)
library(lubridate)

destdir <- "Loud_Murmurs"
if(!file.exists(file.path(".", destdir))) dir.create(destdir)

home <- "https://loudmurmursfm.com/feed/audio.xml"
cont <- read_xml(home)

titles <- xml_find_all(cont, "//title") %>% 
  xml_text() %>% 
  trimws()

titles <- titles[!str_detect(titles, "Murmurs")] %>% 
  str_replace(" E", "E") %>% 
  str_replace("/", "")

ti <- str_extract(titles, "^S\\dE\\d{1,2}")
ti[1] <- "S5E1_final_note"
ti[11] <- "S3E19_reload"
ti[16] <- "S3E4_reload"
ti[32] <- "S3E21_reload"
ti[34] <- "S0E1_try"



date <- xml_find_all(cont, "//pubDate") %>% 
  xml_text()
date <- date[2:length(date)]

des <- xml_find_all(cont, "//description") %>% 
  xml_text()
des <- des[2:length(des)]


lnk <- xml_find_all(cont, "//enclosure") %>% 
  xml_attr("url")

for (i in 1:length(ti)) {
  if (i == 26) next
  fn_audio <- sprintf("%d.%s.mp3", i, ti[i])
  fn_des <- sprintf("%d.%s_description.txt", i, ti[i])
  message("file: ", ti[i])
  download.file(lnk[i], destfile = enc2utf8(file.path(destdir, fn_audio)), mode = "wb")
  
  desfile <- file(file.path(destdir, enc2utf8(fn_des)))
  writeLines(c(date[i], titles[i], des[i]), con = desfile, useBytes = T)
  close(desfile)
  
}

