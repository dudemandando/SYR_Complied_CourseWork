zoo <- read.csv("C:\\Users\\danbu\\Desktop\\Applied Machine Learning\\Week 4\\zoo.csv")
length(colnames(zoo))

zoo_noLabel <- zoo[,2:17]

model_r <- kmeans(zoo_noLabel,5)

model_r
model_r$centers

#Cluster Assignment
cluster_assignment <-data.frame(zoo, model_r$cluster)
View(cluster_assignment)

library(cluster)
clusplot(zoo_noLabel, model_r$cluster, color=TRUE, shade=TRUE, labels=2, lines=0)

d= dist(as.matrix(cluster_assignment))
hc=hclust(d)
plot(hc)


scaledZoo <- as.data.frame(scale(zoo_noLabel))

summary(scaledZoo)

dist_mat <- dist(scaledZoo, method='euclidean')

hclust_complete <- hclust(dist_mat, method = 'complete')

ut_com <- cutree(hclust_complete, k = 5)
plot(hclust_complete)
rect.hclust(hclust_complete , k = 5, border = 2:6)
abline(h = 5, col = 'red')

hclust_single <- hclust(dist_mat, method='single')
ut_single <- cutree(hclust_single, k = 5)
plot(hclust_single)
rect.hclust(hclust_single , k = 5, border = 2:6)
abline(h = 3, col = 'red')
library(dplyr)
zoo_df_cl <- mutate(zoo_noLabel, cluster = ut_com)