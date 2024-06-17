hist(mtc$mpg, breaks = 4)
ggplot(mtc, aes(x=mpg)) + geom_histogram(bins=5)
ggplot(mtc, aes(x=mpg)) + geom_histogram(bins=5, color="black", fill="white")
g <- ggplot(mtc, aes(x=mpg)) + geom_histogram(bins=5, color="black", fill="white")
g + ggtitle("mpg buckets")
g <- ggplot(mtc, aes(x=mpg)) + geom_histogram(binwidth=0.5, color="black", fill="white")

timeToNYC <- c(4,4.5,3.5,5,4.6,4.3)
timeToNYCWeek2 <- c(4.5,5,3.8,5.2,4.6,4.3)

day <- c("mon", "tues","wed", "thurs", "fri", "sat")
week1 <- c(1,1,1,1,1,1)
week2 <- c(2,2,2,2,2,2)
time <- c(timeToNYC, timeToNYCWeek2)
week <- as.factor(c(week1, week2))
dayOfWeek <- c(day, day)
df <- data.frame(day, timeToNYC, timeToNYCWeek2)

g <- ggplot(df, aes(x=day, y=timeToNYC, group=1)) + geom_line(color="red", linetype="dashed", size=1)

g<- g + geom_point()
g <- g+ geom_point(color="blue", size=4)
g <- g+ geom_point(color="blue", size=4) + ylab("Time to NYC (in hours)")
g

#and if we want a scatter chart
ggplot(df, aes(x=day, y=timeToNYC, group=1)) + geom_point(color="Blue", size=7)

df <-data.frame(dayOfWeek, time,week)

df <-data.frame(dayOfWeek, time, week)
g<- ggplot(df, aes(x=dayOfWeek, group=week, color=week)) + geom_line(aes(y=time))
g <- g +ylab("Time to NYC (in hours) ") + ggtitle("comparing weekly times")

g




