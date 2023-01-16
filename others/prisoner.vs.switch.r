## prisoner vs switch
# problem description.
# The warden meets with 23 new prisoners when they arrive. He tells them, “You may meet today and plan a strategy. But after today, you will be in isolated cells and will have no communication with one another.
# In the prison is a switch room, which contains two light switches labeled A and B, each of which can be in either the on or the off position. I am not telling you their present positions. The switches are not connected to anything.
# After today, from time to time whenever I feel so inclined, I will select one prisoner at random and escort him to the switch room. This prisoner will select one of the two switches and reverse its position. He must move one, but only one of the switches. He can't move both but he can't move none either. Then he'll be led back to his cell.
# No one else will enter the switch room until I lead the next prisoner there, and he'll be instructed to do the same thing. I'm going to choose prisoners at random. I may choose the same guy three times in a row, or I may jump around and come back.
# But, given enough time, everyone will eventually visit the switch room as many times as everyone else. At any time anyone of you may declare to me, 'We have all visited the switch room.'
# If it is true, then you will all be set free. If it is false, and somebody has not yet visited the switch room, you will be fed to the alligators.”
# Here's the question:
# What is the strategy that the prisoners devise?
prisonerSwitchProblem <- function(n) {
	inmates <- seq(1:n)
	switch.status <- c(sample(c(0,1),1), sample(c(0,1),1))

	counter <- sample(inmates, 1)
	call.count <- 0
	loops <- 0
	inmates.status <- rep(0, n)
	flipped.A <- rep(0, n)
	while(1) {
	  loops <- loops + 1
		pick <- sample(inmates, 1)
		inmates.status[pick] <- inmates.status[pick] + 1
		write(sprintf("Inmates called: %s", pick), file = log, append=T)
		if(pick == counter) {
		  write("  [counter picked]",file = log, append = T)
			if(switch.status[1] == 1) {
			  flipped.A[pick] <- flipped.A[pick] + 1
			  if(flipped.A[pick] == (2*(n-1))) break
				switch.status[1] <- 0
			} else {
				switch.status[2] <- abs(switch.status[2] - 1)
			}
				
		} else {
			if(switch.status[1] == 0 & flipped.A[pick] < 2) {
				switch.status[1] <- 1
				flipped.A[pick] <- flipped.A[pick] + 1
			} else {
				switch.status[2] <- abs(switch.status[2] - 1)
			}
		 
		}
    write(sprintf("  Switch status:\t%s", paste0(switch.status, collapse = "\t")), file = log, append = T, sep = "\n")
    write(sprintf("  Times  Called:\t%s", paste0(inmates.status, collapse = "\t")), file = log, append = T, sep = "\n")
    write(sprintf("  Times  Flip A:\t%s", paste0(flipped.A, collapse = "\t")), file = log, append = T, sep = "\n")
    #if(loops > 10) break
	}
	write(sprintf("  -- > Counter Called, Total loops: %s", loops), file = log, append = T)
	if(all(inmates.status > 0)) return(c(1, loops))
	return(c(0, loops))
}

tests <- 1000
log <- "PrisonerSwitch.result.txt"
write("", file = log, append = F)
n <- vector()
loops <- vector()
for(t in 1:tests) {
  
  n.inmates <- sample(2:100,1)
  cat(sprintf("===== Test %d; Inmates: %d =====\n", t, n.inmates))
	write(sprintf("=== Test %d Inmates: %d ======", t, n.inmates), file = log, append = TRUE, sep = "\n")
	
	call <- prisonerSwitchProblem(n.inmates)
	inmates.fate <- ifelse(call[1], "Free", "Alligator")
	write(sprintf("=== Results: %s ==== \n", inmates.fate), file = log, append = TRUE)
	cat("==== Results: ", inmates.fate, "======\n")
	n <- c(n, n.inmates)
	loops <- c(loops, call[2])
}

plot(n, loops^(1/2), pch = 19)
	