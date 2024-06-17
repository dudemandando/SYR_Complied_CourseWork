x <- c(1:10)
y <- c(1:10)
df <- data.frame(x,y)
plot(df$x,df$y)

m <- lm(formula=y ~x, data=df)
summary(m)
abline(m)

x <- c(1,2,3,4,5)
y <- c(0.2,2.2,3.8,4.9,5.1)

df <- data.frame(x,y)
plot(df$x, df$y)
m1 <- lm(formula=y ~ x, data=df)

g <- ggplot(df, aes(x=x, y=y)) + geom_point()
g
g + stat_smooth(method = lm, "col" = "red")

w <- c(1,3,4,4.5,5,6.1,7.3, 7.9, 9.2,10.05)
df <- data.frame(x,y,w)
plot(df$x, df$w)

m1 <- lm(formula=w ~ x, data=df)
summary(m1)
abline(m1)

g <- ggplot(df, aes(x=x, y=w)) + geom_point()
g
g + stat_smooth(method = lm, "col" = "red")

x <- sample(1:100, 10, replace = FALSE)
y <- sample(1:100, 10, replace = FALSE)

df <- data.frame(x,y)
plot(x,y)
m1<- lm(formula = x ~ y, data=df)
summary(m1)
abline(m1)
