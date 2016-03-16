## Takes in raw life table data 
library(ggplot2)
library(xtable)
# Load in the WHO data set, which comes from an API pull of GHO/Life 029
setwd("~/Desktop/data")
lifetables <- read.csv("complete_lifetables.csv", header = TRUE, row.names=NULL, na.strings=c("","NA"))

# Drop stupid variables 
lifetables$PUBLISHSTATE <- NULL
lifetables$GHO <- NULL
lifetables$REGION <- NULL
lifetables$WORLDBANKINCOMEGROUP <- NULL
lifetables$prob_death <- 1 - lifetables$prob_death 


# Keep only MALE observations
lifetables.male <- lifetables[("MLE" == lifetables$SEX),]
lifetables.male90 <-  subset(lifetables.male, lifetables.male$YEAR == 1990)
lifetables$SEX <- NULL
lifetables.male90$YEAR <- NULL

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
lifetables$ageid[lifetables$AGEGROUP  == "AGE45-49"] <- 10
lifetables$ageid[lifetables$AGEGROUP  == "AGE50-54"] <- 11
lifetables$ageid[lifetables$AGEGROUP  == "AGE55-59"] <- 12
lifetables$ageid[lifetables$AGEGROUP  == "AGE60-64"] <- 13
lifetables$ageid[lifetables$AGEGROUP  == "AGE65-69"] <- 14
lifetables$ageid[lifetables$AGEGROUP  == "AGE70-74"] <- 15
lifetables$ageid[lifetables$AGEGROUP  == "AGE75-79"] <- 16
lifetables$ageid[lifetables$AGEGROUP  == "AGE80-84"] <- 17
lifetables$ageid[lifetables$AGEGROUP  == "AGE85-89"] <- 18
lifetables$ageid[lifetables$AGEGROUP  == "AGE90-94"] <- 19
lifetables$ageid[lifetables$AGEGROUP  == "AGE95-99"] <- 20
lifetables$ageid[lifetables$AGEGROUP  == "AGE100+"] <- 21

# Keep only observations for under age 50
lifetables <- na.omit(lifetables)

# Melt data down into long format
melted.mort <- melt(lifetables, id=c("AGEGROUP", "COUNTRY", "YEAR", "ageid"))

melted.mort$YEAR <- NULL
melted.mort$ageid <- NULL
melted.mort$variable <- NULL
melted.mort$COUNTRY <- 1


# Reshape long to wide 

data.reshaped <- reshape(melted.mort, idvar = "AGEGROUP", timevar = "COUNTRY", direction = "wide")

xtable(cor(data.reshaped), use="pairwise.complete.obs")


# Aggregate values by year and country for ages 5-14
# New dataframe is called youngmort 
write.csv(melted.mort, file = "formatted_lifetables.csv")

# Aggregate data by age group
value.bygroup <- na.omit(aggregate(melted.mort$value, by=list(melted.mort$ageid), 
                                      FUN=mean, na.rm=TRUE))

# Plot! 
ggplot(data=value.bygroup, aes(x=Group.1, y=x)) + geom_bar( stat="identity") +scale_x_discrete(name ="Age Group") + ylab("Probability of Making it to \n the Next Bracket")
                                                                                                                   

## LIFETABLES FOR UK, HISTORICAL

uklife <- read.csv("UK_lifetablesdeath.csv", header = TRUE, row.names=NULL, na.strings=c("","NA"))
melted.uklife <- melt(uklife, by= "age year")
melted.uklife$variable <- NULL

melted.uklife$ageid <- rep(NA, nrow(lifetables))
melted.uklife$ageid[melted.uklife$age  == "0"] <- 0
melted.uklife$ageid[melted.uklife$age  == "1-4"] <- 1
melted.uklife$ageid[melted.uklife$age  == "5-9"] <- 2
melted.uklife$ageid[melted.uklife$age  == "10-14"] <- 3
melted.uklife$ageid[melted.uklife$age  == "15-19"] <- 4
melted.uklife$ageid[melted.uklife$age  == "20-24"] <- 5
melted.uklife$ageid[melted.uklife$age  == "25-30"] <- 6
melted.uklife$ageid[melted.uklife$age  == "30-34"] <- 7
melted.uklife$ageid[melted.uklife$age  == "35-39"] <- 8
melted.uklife$ageid[melted.uklife$age  == "40-44"] <- 9
melted.uklife$ageid[melted.uklife$age  == "45-49"] <- 10
melted.uklife$ageid[melted.uklife$age  == "50-54"] <- 11
melted.uklife$ageid[melted.uklife$age  == "55-59"] <- 12
melted.uklife$ageid[melted.uklife$age  == "60-64"] <- 13
melted.uklife$ageid[melted.uklife$age  == "65-69"] <- 14
melted.uklife$ageid[melted.uklife$age  == "70-74"] <- 15


melted.uklife$age <- factor(melted.uklife$age, levels = melted.uklife$age[order(melted.uklife$ageid)])


k <- ggplot(na.omit(melted.uklife), aes(x = age, y = value)) + geom_point() + facet_wrap(~year) + theme_bw() + xlab("Age Group") + ylab("Probability of death between ages x and x+n") + theme(axis.text.x  = element_text(angle=90))


## Plotting lag numbers

effect <- c( -0.0329,  -0.0591,  -0.0318,  -0.0309, -0.0304, -0.0299, -0.0254, -0.0442,  -0.0224, -0.0254, -0.0377, -0.0135, 0, 0,0)
lag <- c(0:14)

ols.survive = data.frame(effect, lag)

ols.survive.plot <- ggplot(data = ols.survive, aes(x =lag, y = effect)) + geom_line() + theme_bw() + xlab("Lead on Schooling")+ylab("Effect of Childhood Survival") + theme(axis.title.x = element_text(size = rel(1.3)), axis.title.y = element_text(size = rel(1.3)))

effect2 <- c(-.763,-1.499,-1.013,-1.433,-1.332,-1.400,-1.211,-1.80,0,0,0,0,0,0,0)

ols.life = data.frame(effect2, lag)

ols.life.plot <- ggplot(data = ols.life, aes(x =lag, y = effect2)) + geom_line() + theme_bw() + xlab("Lead on Schooling")+ylab("Effect of Life Expectancy")+theme(axis.title.x = element_text(size = rel(1.3)), axis.title.y = element_text(size = rel(1.3)))

