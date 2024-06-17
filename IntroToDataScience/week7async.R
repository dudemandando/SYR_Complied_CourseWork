library(ggplot2)
dummyDF <- data.frame(state.name, stringsAsFactors = FALSE)
dummyDF$state <-tolower(dummyDF$state.name)
us <- map_data("state")

map.simple <- ggplot(dummyDF,aes(map_id =state))
map.simple <- map.simple + geom_map(map=us, fill="black", color="white")

map.simple <- map.simple + expand_limits(x=us$long, y=us$lat)

map.simple <- map.simple + coord_map()+ ggtitle("Dan Burke's Basic Map of USA")

#map.simple <- map.simple + geom_point(aes(x=-100, y=30))

#map.simple <- map.simple + geom_point(aes(x=-120, y=47), color="white")

#map.simple

#miami point 25.780683, -80.197285
#I used the same Dummy Data Frame from previous 

dummyDF <- data.frame(state.name, stringsAsFactors = FALSE)
dummyDF$state <-tolower(dummyDF$state.name)

miamiMap <- ggplot(dummyDF, aes(map_id=state))
miamiMap <- miamiMap + geom_map(map=us, fill= "white", color="black")
miamiMap <- miamiMap +  expand_limits(x=us$long, y=us$lat)
miamiMap <- miamiMap + xlim(-83,-78) + ylim(25, 27) + coord_map()
miamiMap <- miamiMap + geom_point(aes(x=-80.197285, y=25.780683),color="red", size=6)

#miamiMap


cities <-c("Manhattan, NY", "Boston, MA", "Philadelphi, PA", "Tampa, FL", "Chicago, IL", "Boise, ID", "San Francisco, CA", "Seattle, WA", "Houston, TX")
bus <-c(10,7,6,5,7,3,10,7,5)
weather<-c(5,3,6,7,3,6,10,7,2)
living <- c(7,6,6,7,5,4,6,8,2)

city.df <- data.frame(cities, bus, weather, living)
#city.df$state <- statesFake
city.df$geoCode <- geoCode(cities)


map.simple <- map.simple + geom_point(data=city.df, aes(x=geoCode$lon, y=geoCode$lat, size=bus, color=weather))
map.simple




