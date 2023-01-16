# assumes codes are known beforehand
codes <- c("ABT",   "ABBV", "ACE") #,  "ACN",  "ACT",  "ADBE", "ADT",  "AES",  "AET",  "AFL",  "AMG",  "A",    "GAS",  "APD",  "ARG",  "AKAM", "AA")
urls <- paste0("http://www.google.com/finance/historical?q=NASDAQ:",
               codes,"&output=csv")
paths <- paste0(codes,".csv")
missing <- !(paths %in% dir(".", full.name = TRUE))
missing

# simple error handling in case file doesn't exists
downloadFile <- function(url, path, ...) {
    # remove file if exists already
    if(file.exists(path)) file.remove(path)
    # download file
    tryCatch(
        download.file(url, path, ...), error = function(c) {
            # remove file if error
            if(file.exists(path)) file.remove(path)
            # create error message
            c$message <- paste(substr(path, 1, 4),"failed")
            message(c$message)
        }
    )
}
# wrapper of mapply
Map(downloadFile, urls[missing], paths[missing])

var <- function(x) {
    m <- mean(x, na.rm = T)
    n <- length(x)
    
    v <- 1/(n-1) * sum((x-m)**2, na.rm = T)
    
    return(v)
}

skew <- function(x) {
    v <- var(x)
    m <- mean(x, na.rm = T)
    n <- length(x)
    s <- 1/(n-2) * sum((x-m)**3, na.rm = T)/(v**(3/2))
}

both_na <- function(x,y) {
    if (!length(x) == length(y)) stop("not same length")
    x.na <- which(is.na(x))
    y.na <- which(is.na(y))

    intersect(x.na, y.na)
}

tempFeelsLike <- function(x) {
   lvl <- cut(x, c(-100, 0, 10, 20, 30, 100), right = F,
              labels = c("freezing", "cold", "cool", "warm", "hot"))
   return(as.character(lvl))
   # switch(as.numeric(lvl), 
   #        "freezing",
   #        "cold",
   #        "cool",
   #        "warm",
   #        "hot",
   #        "out_of_range")
}

switchTest <- function(x) {
    switch(x,
           a = ,
           b = "ab",
           c = ,
           d = "cd")
}

t1 <- now()
sd <- ymd("20200318")
ds <- sd

#case <- vector("integer", 61)
#case[1] <- 202
case <- 202
for(n in 1:1000) {
    ds <- c(ds, sd + days(n))
    case <- c(case, 202 * ((1 + 0.11) ** n))
    
}
df <- data.frame(date = ds, case = case)
t2 <- now()
cat(t2-t1)


findDist <- function(a, data) {
    y0 = a[1] * data$x + a[2]
    
    sum((data$y - y0) ** 2)
}

result <- list()
for(i in 1: 10) {
    label <- str_c("sim", i)
    sim1a <- tibble(x = rep(1:10, each = 100), y = x * 1.5 + 6 + rt(length(x), df=2))
    min_dist <- optim(c(0,0),findDist, data = sim1a)
    mod <- sprintf("y = %.2f * x + %.2f", min_dist$par[1], min_dist$par[2])
    sim1a <- sim1a %>% 
        mutate(label = rep(mod, nrow(sim1a)),
            a = rep(min_dist$par[1], nrow(sim1a)),
            b = rep(min_dist$par[2], nrow(sim1a)))
    
    result[[label]] <- sim1a
}

data <- reduce(result, bind_rows)

ggplot(data, aes(x, y, group = label)) + 
    geom_point() + 
    facet_grid(.~label) + 
    geom_abline(aes(intercept = b, slope = a))

result <- list()
for(i in 1:10) {
    sim_a <- tibble(x = rep(1:30, each = 3), y = x * 1.5 + 6 + rt(length(x), df=2))
    mod <- lm(sim_a$y ~ sim_a$x)
    
    sim_a <- sim_a %>%
        add_predictions(mod) %>%
        add_residuals(mod) %>%
        mutate(label = rep(sprintf("sim%d", i), 90))
    
    result[[i]] <- sim_a
}

data <- reduce(result, bind_rows)

ggplot(data, aes(x, y)) +
    geom_point() + 
    geom_line(aes(y = pred), col = "red") + 
    geom_point(aes(y = resid), col = "lightblue") + 
    geom_ref_line(h = 0, colour = "lightblue", size = 0.5) + 
    facet_grid(. ~ label)


ggplot(data, aes(resid)) + 
    geom_freqpoly(binwidth = 0.5) +
    facet_grid(label ~ .)
