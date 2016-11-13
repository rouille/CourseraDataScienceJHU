library(jsonlite)
library(plyr)
library(dplyr)
library(googleVis)
library(networkD3)

nobel  <- fromJSON("http://api.nobelprize.org/v1/laureate.json")
prizes <- ldply(nobel$laureates$prizes, as.data.frame)

count <- sapply(nobel$laureates$prizes, function(x) nrow(x) )

prizes$id <- rep(nobel$laureates$id, count)
prizes$gender <- rep(nobel$laureates$gender, count)
prizes$born <- rep(nobel$laureates$born, count)
prizes$bornCountry <- rep(nobel$laureates$bornCountry, count)
prizes$bornCountryCode <- rep(nobel$laureates$bornCountryCode, count)
prizes$diedCountry <- rep(nobel$laureates$diedCountry, count)
prizes$diedCountryCode <- rep(nobel$laureates$diedCountryCode, count)

prizes$age <- as.numeric(as.Date(paste(prizes$year,"12-31",sep = "-"),"%Y-%m-%d")-as.Date(prizes$born,"%Y-%m-%d") )/365
for(i in c("2","3","4") ) prizes$share[which(prizes$share == i)] <- paste("1",i,sep = "/")

prizes <- prizes[!is.na(prizes$category), ]