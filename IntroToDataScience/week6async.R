#install.packages("ggplot2")
library(ggplot2)

mtc <- mtcars
ggplot(mtc, aes(x=factor(0), mpg)) + geom_boxplot()

#grouped by cylinders
ggplot(mtc, aes(group=cyl,x=cyl, mpg)) + geom_boxplot()

#flip the axis of the box plot
ggplot(mtc, aes(group=cyl,x=cyl, mpg)) + geom_boxplot() + coord_flip()

car.names <-rownames(mtc)


g <- ggplot(mtc, aes(x=car.names, y=wt))



g <- ggplot(mtc, aes(x=car.names, y=wt)) + geom_bar(stat="identity")

g <- g + theme(axis.text.x=element_text(angle=90, hjust=1))


ggplot(mtc, aes(x=mpg, y=wt)) + geom_point(aes(size=qsec))


#encoding by size and color
ggplot(mtc, aes(x=mpg, y=wt)) + geom_point(aes(size=qsec, color=qsec))

#names on the y axis mpg on the x axis 
ggplot(mtc, aes(x=mpg, y=car.names)) + geom_point(size=3)
#same but ordering by mpg
ggplot(mtc, aes(x=mpg, y=reorder(car.names, mpg))) + geom_point(size=3)