#install.packages("ggplot2")
#install.packages("ggmap")

if(!require("ggplot2") || !require("ggmap")){
  library(ggplot2)
  library(ggmap)
}

readStates <- function(){
  
  states <- read.csv("http://www2.census.gov/programs-surveys/popest/tables/2010-2011/state/totals/nst-est2011-01.csv")
  
  #Capture only the States and populations, ignoring the "NA" Values
  states <- states[9:59,1:5]
  
  #Set Up for Looping through and renaming
  startYear <- 2010
  oldColNames <- colnames(states)
  newColNames <- c("stateName",	 "base2010",	"base2011","Jul2010", "Jul2011")
  ???
  #Loop through for the length of the Column Names and rename
  for(i in 0:length(colnames(states))){
    names(states)[names(states) == oldColNames[i]] = newColNames[i]
  }
  
  return(states)
}


#Get the US States Map
us <- map_data("state")

dummyDF <- data.frame(state.name, stringsAsFactors = FALSE)
dummyDF$state <- tolower(dummyDF$state.name)
map.simple <- ggplot(dummyDF, aes(map_id=state))

#Create Map Geometry

map.simple <- map.simple + geom_map(map=us, fill="White", color="black")
map.simple <- map.simple + expand_limits(x=us$long, y=us$lat)
map.simple <- map.simple + coord_map() + ggtitle("Basic Map of USA")

map.simple


#Show Population per state color code
dfStates <- readStates()

#remove 'dot' from state name and make sure everything is lowercase
dfStates$state <- gsub("\\.", "", dfStates$state)
dfStates$state <- tolower(dfStates$state)

#Add Fill and color
map.popColor <- ggplot(dfStates, aes(map_id = state))
map.popColor <- map.popColor + geom_map(map=us, aes(fill=base2010))
map.popColor <- map.popColor + expand_limits(x=us$long, y = us$lat)
map.popColor <- map.popColor + coord_map() + ggtitle("State Population")



#place a point on the map

map.simple<- map.simple + geom_point(aes(x=-100, y=30))
map.simple<- map.simple +geom_point(aes(x=-100, y=30), color="darkred", shape=1)
map.popColor<- map.popColor +geom_point(aes(x=-100, y=30), color="darkred", shape=1)


#show a logical position
#latlon <- geocode("syracuse university, syracuse, ny")
latlon
map.popColor<-map.popColor + geom_point(aes(x=latlon$lon, y=latlon$lat), color="darkred", size = 3)
map.popColor

#show a second point

