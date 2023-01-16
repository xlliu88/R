library(dplyr)
## probobility problem
## in a 2:1 segeration population, how many do you have to pick to get 
## at least 1 of the minority.
## 
## 

## settings
popsize <- 100000
labels <- c("HT", "HM")
ratio <- c(256,1)
wanted <- "HM"
min_sample_size <- 1000
max_sample_size <- 2000
step <- 50
ntarget <- 3

ntest <- 1000

## 
pop <- unname(unlist(mapply(rep, labels, ratio)))
pop <- rep(pop, floor(popsize/sum(ratio)))

## 3:1 segragation
# range <- min_sample_size:max_sample_size
range <- seq(min_sample_size, max_sample_size, step)
probabilities <- vector(length = length(range))
names(probabilities) <- range
result <- matrix(ncol = length(range), nrow = ntest)
colnames(result) <- range
for(ss in range) {
    idx <- (ss - min_sample_size)/step + 1
    for(t in 1:ntest) {
        sel <- sample(pop, ss, replace = F)
        result[t, idx] <- sum(sel == wanted)
    }
    probabilities[idx] <- mean(result[,idx] >= ntarget) * 100
}
x <- names(probabilities) %>% as.numeric()
plot(x, probabilities, 
     xaxt = "n",
     yaxt = "n",
     #breaks = seq(from = min_sample_size, to = max_sample_size, by = 20), 
     ylim = c(45,105), pty = "l", pch = 16, 
     ylab = "probability (%)", 
     xlab = "sample size",
     cex = 1.5, cex.lab = 2)
axis(side = 1, at = seq(from = min_sample_size, to = max_sample_size, by = step), cex.axis = 2)
axis(side = 2, at = seq(from = 50, to = 100, by = 10), cex.axis = 2)
title(main = sprintf("Chances of getting at least %d %s \n in a %s population", 
                     ntarget, wanted, paste0(ratio, collapse = ":")))
# text(1:length(probabilities), probabilities + 5, cex = 0.75,
#      labels = sprintf("%.1f%%", probabilities))
abline(h = 100, col = "gray75", lwd = 2)
abline(h = 90, col = "red", lty = 2, lwd = 2)
abline(h = 75, col = "red", lty = 2, lwd = 2)
abline(h = 50, col = "red", lty = 2, lwd = 2)
