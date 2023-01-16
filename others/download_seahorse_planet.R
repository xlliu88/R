library(xml2)
library(tidyr)
library(stringr)
library(lubridate)

destdir <- "SeahorsePlanet"
log_file <- file.path(destdir, "download_log.txt")
if(!file.exists(file.path(".", destdir))) dir.create(destdir)
downloaded_eps <- readLines(log_file)

home <- "https://seahorseplanet.net/"
# home <- "https://open.spotify.com/show/0JO0qK4stSWLU390lTkvG1"

for(p in 1:20) {
  home <- sprintf("https://seahorseplanet.net/page/%d/", p)
  cont <- read_html(home)
  eps_lnks <- xml_find_all(cont, "//div//h2//a") %>% 
    xml_attr("href")
  count <- 0
  for(lnk in eps_lnks) {
    if(lnk %in% downloaded_eps) {
      message("Episode downloaded")
      next
    }
    ## extract_episode
    eps_page <- read_html(lnk)
    title <- xml_find_all(eps_page, "//meta") %>% 
      `[`(., grepl("title",.)) %>% 
      xml_attr("content")
    date <- xml_find_all(eps_page, "//div//div//span") %>% 
      `[`(., grepl("blog-meta-date",.)) %>% 
      xml_text() %>% 
      as.Date("%d. %B %Y")
    ddlnk <- xml_find_all(eps_page, "//aside//p//a") %>% 
      `[`(., grepl("ref=download", .)) %>% 
      xml_attr("href")
    
    des <- xml_find_all(eps_page, "//div//div//div//div//p") %>% 
      `[`(., !grepl("comment", .)) %>% 
      xml_text() %>% 
      `[`(., !grepl("SecondLineThemes|(new window)", ., ignore.case = T))  #%>% 
   
     eps_fn <- sprintf("%s.mp3", date)
    eps_des_fn <- sprintf("%s - description.txt", date)
    cat(sprintf("download... \n%s - %s", date, title))
    download.file(ddlnk, destfile = file.path(destdir, enc2utf8(eps_fn)), mode = "wb")
    desfile <- file(file.path(destdir, eps_des_fn))
    writeLines(enc2utf8(c(as.character(date), title, des)), con = desfile, useBytes = T)
    close(desfile) 
    ## end extracting
    
    count <- count + 1
    write(lnk, log_file, append = TRUE)
    downloaded_eps <- c(downloaded_eps, lnk)
    
  }
  message(sprintf("totle downloaded... %s", count))
  # if(count == 0) break
  
  # next_page <- xml_find_all(cont, "//div//div//a") %>% 
  #   `[`(., grepl("More Episodes", ., ignore.case = T)) %>% 
  #   xml_attr("href")
  # home <- next_page

}

close(log_file)

# titles <- xml_find_all(cont, "//title") %>% 
#   xml_text() %>% 
#   trimws()
# 
# titles <- titles[!str_detect(titles, "Murmurs")] %>% 
#   str_replace(" E", "E") %>% 
#   str_replace("/", "")
# 
# ti <- str_extract(titles, "^S\\dE\\d{1,2}")
# ti[1] <- "S5E1_final_note"
# ti[11] <- "S3E19_reload"
# ti[16] <- "S3E4_reload"
# ti[32] <- "S3E21_reload"
# ti[34] <- "S0E1_try"
# 
# 
# 
# date <- xml_find_all(cont, "//pubDate") %>% 
#   xml_text()
# date <- date[2:length(date)]
# 
# des <- xml_find_all(cont, "//description") %>% 
#   xml_text()
# des <- des[2:length(des)]
# 



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

