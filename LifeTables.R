## Takes in raw life table data 

# Load in the WHO data set, which comes from an API pull of GHO/Life 029
setwd("~/Desktop/data")
lifetables <- read.csv("complete_lifetables.csv", header = TRUE, row.names=NULL, na.strings=c("","NA"))

# Drop stupid variables 
lifetables$PUBLISHSTATE <- NULL
lifetables$GHO <- NULL
lifetables$REGION <- NULL
lifetables$WORLDBANKINCOMEGROUP <- NULL

# Keep only MALE observations
lifetables <- lifetables[("MLE" == lifetables$SEX),]
lifetables$SEX <- NULL

# Load some packages
library(reshape2)
library(ggplot2)

# Categorize Age Groups into Numbers
lifetables$ageid <- rep(NA, nrow(lifetables))
lifetables$ageid[lifetables$AGEGROUP  == "AGELT1"] <- 0
lifetables$ageid[lifetables$AGEGROUP  == "AGE1-4"] <- 1
lifetables$ageid[lifetables$AGEGROUP  == "AGE5-9"] <- 2
lifetables$ageid[lifetables$AGEGROUP  == "AGE10-14"] <- 3
lifetables$ageid[lifetables$AGEGROUP  == "AGE15-19"] <- 4
lifetables$ageid[lifetables$AGEGROUP  == "AGE20-24"] <- 5
lifetables$ageid[lifetables$AGEGROUP  == "AGE25-30"] <- 6
lifetables$ageid[lifetables$AGEGROUP  == "AGE30-34"] <- 7
lifetables$ageid[lifetables$AGEGROUP  == "AGE35-39"] <- 8
lifetables$ageid[lifetables$AGEGROUP  == "AGE40-44"] <- 9
lifetables$ageid[lifetables$AGEGROUP  == "AGE45-50"] <- 10

# Keep only observations for under age 50
lifetables <- na.omit(lifetables)

# Melt data down into long format
melted.mort <- melt(lifetables, id=c("AGEGROUP", "COUNTRY", "YEAR", "ageid"))

# Aggregate values by year and country for ages 5-14
# New dataframe is called youngmort 
write.csv(melted.mort, file = "formatted_lifetables.csv")

# Aggregate data by age group
value.bygroup <- na.omit(aggregate(melted.mort$value, by=list(melted.mort$AGEGROUP), 
                                      FUN=mean, na.rm=TRUE))

# Plot! 
ggplot(data=value.bygroup, aes(x=Group.1, y=x)) + geom_bar( stat="identity") +scale_x_discrete(name ="Age Group") + ylab("Probability of Making it to \n the Next Bracket")
                                                                                                                   







