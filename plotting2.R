# Data work #
# Covert data from STATA to CSV #
setwd("~/Desktop/UChicagoYear4/MetricsB/Paper")
library(foreign)
library(ggplot2)
library(plm)
library(stargazer)
write.table(read.dta('five_percent_sample12.dta'), file="MetricsGameSample.csv", quote = FALSE, sep = ",", col.names = NA)
write.table(read.dta('countrydata_merged12.dta'), file="MetricsGameCountryVariables.csv", quote = FALSE, sep = ",", col.names = NA)

# Read it into R #
thesis.data <- read.csv("output.csv", header = TRUE, row.names=NULL, na.strings=c("","NA"))

# Subsetting by income group # 
low <- subset(thesis.data, thesis.data$low == 1)
high <- subset(thesis.data, thesis.data$high == 1)
gavi00 <- subset(thesis.data, thesis.data$gavi_status_00== 1)
no.gavi00 <- subset(thesis.data, thesis.data$gavi_status_00== 0)

# Plot some things for poor countries # 
# Mean Schooling Rates, GAVI Countries, by year
gavi00.year.schoolingMF <- aggregate(gavi00$rateofoutofschoolMF, by=list(gavi00$year), 
                                    FUN=mean, na.rm=TRUE)

gavi00.school <- ggplot(na.omit(gavi00.year.schoolingMF), aes(x = Group.1, y = x)) +                    # basic graphical object
  geom_line(colour="green") + labs(x = "Year", y = "Rate of Out of School Children \n of Primary Age (%)") + 
  ggtitle("Schooling Trends Over Time, Poor Countries") + theme_bw()

# Total Measles Cases by Year, GAVI-countries

gavi00.year.measlescases <- aggregate(gavi00$measles_cases, by=list(gavi00$year), 
                                      FUN=sum, na.rm=TRUE)

# Total Measles cases by Year, All countries

data.year.measlescases.sum <- aggregate(data$measles_cases, by=list(data$year), 
                                        FUN=sum, na.rm=TRUE)

# Average Vaccine Coverage by year, All countries

data.year.mcv1 <- na.omit(aggregate(data$unicefmcv1, by=list(data$year), 
                                    FUN=mean, na.rm=TRUE))
mean.coverage <- ggplot(data.year.mcv1, aes(x = Group.1, y = x))+ geom_line()

# Measles Cases, All Countries -- yearly totals

total.measlescases <- ggplot(data.year.measlescases.sum, aes(x = Group.1, y =x)) + geom_bar(stat = "identity") + xlim(1980,2013) +xlab("Year")+ylab("Number of Measles Cases") + theme_bw()

# Measles Cases, GAVI Countries -- yearly totals

gavi00.measlescases <- ggplot(na.omit(gavi00.year.measlescases), aes(x = Group.1, y = x)) +                    # basic graphical object
  geom_line(colour="green") + labs(x = "Year", y = "Measles Cases (Count)") + 
  ggtitle("Measles Cases, GAVI-Countries") + theme_bw() + xlim(1980,2014)


gavi00.year.spending <- na.omit(aggregate(as.numeric(gavi00$vaxspending), by=list(gavi00$year), 
                                          FUN=mean, na.rm=TRUE))

# Takes means of change in coverage and mortality
gavi00.diff.mort.means <- aggregate(as.numeric(gavi00$diff_mortality), by=list(gavi00$year), 
                                          FUN=mean, na.rm=TRUE)

gavi00.diff.cov.means <- aggregate(as.numeric(gavi00$diff_mcv1coverage), by=list(gavi00$year), 
                                            FUN=mean, na.rm=TRUE)

# put 'em together and rename columns

diff.means <- cbind(gavi00.diff.mort.means, gavi00.diff.cov.means )
names(diff.means)[1] <- c()

# Plot means of changes in coverage and mortality

gavi00.diff.mort <- ggplot() +                    # basic graphical object
  geom_point(data = gavi00.diff.cov.means, aes(x = Group.1, y = x)) +
  geom_point(data = gavi00.diff.mort.means, aes(x = Group.1, y = x)) + 
  labs(x = "Change in Coverage", y = "Change in Mortality") + 
  ggtitle("") + theme_bw()

gavi00.year.meanmcv1cov <- aggregate(gavi00$diff_mcv1coverage, by=list(gavi00$year), 
                                     FUN=mean, na.rm=TRUE)

# Mean Changes in Coverage by Year, GAVI-supported Countries #

gavi00.diff.cov <- ggplot(gavi00.year.meanmcv1cov, aes(x = Group.1 , y = x)) +                    # basic graphical object
  geom_line() + labs(x = "year", y = "diff_mcv1coverage") + 
  ggtitle("Mean Changes in Coverage by Year") + theme_bw()

gavi00.coverage.mortality <- ggplot(gavi00, aes(x = Group.1, y = x)) +                    # basic graphical object
  geom_line(colour="green") + labs(x = "Year", y = "Percentage of Immunization Costs \n Covered by National Government") + 
  ggtitle("") + theme_bw()

# Plot Costs Covered by National Governments, Non-GAVI-Eligible 
no.gavi00.year.spending <- na.omit(aggregate(no.gavi00$vaxspending, by=list(no.gavi00$year), 
                                             FUN=mean, na.rm=TRUE))

no.gavi00.spending <- ggplot(no.gavi00.year.spending, aes(x = Group.1, y = x)) +                    # basic graphical object
  geom_line(colour="green") + labs(x = "Year", y = "Percentage of Immunization Costs \n Covered by National Government") + 
  ggtitle("") + theme_bw()

gavi00.natlbudget <- ggplot(gavi00, aes(natlbudget)) + geom_bar(stat = "count")

gavi00.year.mcv1 <- na.omit(aggregate(gavi00$unicefmcv1, by=list(gavi00$year), 
                                      FUN=mean, na.rm=TRUE))

# Average mortality and schooling rates by country 

mean.school <- aggregate(gavi00$interpolated_school, by=list(gavi00$code), 
                                      FUN=mean, na.rm=TRUE)
mean.mortality <- aggregate(gavi00$child_prob_death, by=list(gavi00$code), 
                                       FUN=mean, na.rm=TRUE)
# Combine 
means <- cbind(mean.school, mean.mortality)

# Relabel Columns
names(means)[1] <- c("code")
names(means)[2] <- c("mort")
names(means)[3] <- c("code")
names(means)[4] <- c("school")

# Plot averages of schooling and mortality
school.mortality.means <- ggplot(data = means, aes(x =school, y = mort, label = code)) + theme_bw()+xlab("Child Mortality, out of 1000 Live Births")+ylab("Rate of Children Out of School")
school.mortality.means + geom_point()+stat_smooth()

# Take Values from 1980 

gavi.1980.mort <- gavi00$child_prob_death[(gavi00$year == 1970)]
gavi.1980.school <- gavi00$interpolated_school[(gavi00$year == 1970)]

gavi.1980 <- data.frame(cbind(gavi.1980.mort, gavi.1980.school))

plotting1980 <- ggplot(data = gavi.1980, aes(x = gavi.1980.mort, y = gavi.1980.school))+geom_point()+theme_bw()
plotting1980 + xlab("Probability of Childhood Death") + ylab("Rate of Primary School-aged Children \n Out of School, 1980")

# Raw data -- mortality and schooling rates 
school.mortality <- ggplot(data = gavi00, aes(x = mortality, y = rateofoutofschoolMF)) + geom_point() + stat_smooth()+xlab("Child Mortality, out of 1000 Live Births")+ylab("Rate of Children Out of School") +theme_bw()

# Raw data -- child mortality and vaccine coverage rates
vaccine.mortality <-ggplot(data = gavi00, x = unicefmcv1, y = mortality) 

vaccine.budget.coverage <- 
  geom_line(data=gavi00.year.spending, aes(x=Group.1, y=x, color = "spending")) + 
  geom_line(data=gavi00.year.mcv1, aes(x=Group.1, y=x, color = "coverage")) + ggtitle("Average Vaccine Costs and MCV1 Coverage \n GAVI-Supported Countries") + xlim(1998, 2014) + xlab("Year")+ ylab("Percentage")+ scale_colour_manual("", 
                                                                                                                                                                                                                                        breaks = c("Percentage of Costs Covered", "MCV1 Coverage"))

# Plot vaccine spending for GAVI and non GAVI countries 

vaccine.budget <- ggplot() +
  geom_line(data=gavi00.year.spending, aes(x=Group.1, y=x),
            colour="blue") + 
  geom_line(data=no.gavi00.year.spending, aes(x=Group.1, y=x),
            colour="red") + xlab("Year") + ylab("Percentage of Immunization Costs \n Covered by National Government") +theme_bw()


gavi00.schooling <- na.omit(aggregate(gavi00$rateofoutofschoolMF, by=list(gavi00$year), 
                                      FUN=mean, na.rm=TRUE))

# Covered with measles vaccine subsets 
# Covered == reached Herd immune level 

gavi.sub.covered <- subset(gavi00, mcv_covered == 1)
gavi.sub.notcovered <- subset(gavi00, mcv_covered == 0)

gavi00.schooling.covered <- na.omit(aggregate(gavi.sub.covered$interpolated_school, by=list(gavi.sub.covered$year), 
                                              FUN=mean, na.rm=TRUE))

gavi00.schooling.notcovered <- na.omit(aggregate(gavi.sub.notcovered$interpolated_school, by=list(gavi.sub.notcovered$year), 
                                                 FUN=mean, na.rm=TRUE))
mean.year <- mean(na.omit(gavi00$index_year))
mean.year.covered <- mean(na.omit((gavi00[gavi00$mcv_covered == 0,])$index_year))

## Plot schooling rates over time based on coverage group ##

awesome.plot <- ggplot(data=gavi00.schooling.covered, aes(x=Group.1, y=x),
                       colour="black") + geom_line(linetype = "dotdash") + 
  geom_line(data=gavi00.schooling.notcovered, aes(x=Group.1, y=x),
            colour="black") + xlab("Year") + ylab("Percentage of Out of School Children \n Of Primary School Age") +theme_bw()+ xlim(1980, 2014)

## Ploting the Drop off Rate between levels of mortality ## 
library(reshape2)

write.table(read.dta('gavi_sat_am.dta'), file="lifetables_merged.csv", quote = FALSE, sep = ",")
lifetables.stata <- read.csv("lifetables_merged.csv", header = TRUE, row.names=NULL, na.strings=c("","NA"))

melted.mort <- melt(lifetables.stata, id=c("row.names"))
ggplot(data=melted.mort, aes(x=variable, y=value)) + geom_boxplot()+scale_x_discrete(name ="Age Group", labels = c("1-4yrs","10-14yrs",
                                                                                                                   "<1 yrs","5-9yrs")) + ylab("Probability of Death") + theme_bw()
                                  
# Motivating Plots 
low.school <- aggregate(low$interpolated_school, by=list(low$year), 
                                                 FUN=mean, na.rm=TRUE)

low.mortality <- aggregate(low$survival_rate, by=list(low$year), 
                                          FUN=mean, na.rm=TRUE)
low.gdpcap <- aggregate(low$gdpcap, by=list(low$year), 
                           FUN=mean, na.rm=TRUE)
low.gdpcap$loggedgdp<- log(low.gdpcap$x)

low.combined <- cbind(low.school, low.mortality, low.gdpcap)
colnames(low.combined) <- c("year" ,"school", "year" ,"mort", "year", "gdpcap", "loggdp")

low.years <- subset(low.combined, low.combined$year > 1979)

low.mort.plot <- ggplot(data = low.mortality, aes(x = low.mortality$Group.1, y = x)) + geom_point() + xlim(1980, 2015) + theme_bw() + ylab("Percentage of Children Born Who \n Survive Past 5") + xlab("Year")
low.schl.plot <- ggplot(data = low.school, aes(x = low.school$Group.1, y = x)) + geom_point() + xlim(1980, 2015) + theme_bw() + ylab("Percentage of Children Ages 6-11 \n Out of School") + xlab("Year")

low.schl.plot <- ggplot(data = low.school, aes(x = low.school$Group.1, y = x)) + geom_point() + xlim(1980, 2015) + theme_bw() + ylab("Percentage of Children Ages 6-11 \n Out of School") + xlab("Year")

combined.plot.mort <- ggplot(data = low.years, aes(x = mort, y = school))+geom_point() + theme_bw() + xlab("Percentage of Children Who Surive Past Age 5") + ylab("Percentage of Children Ages 6-11 \n Out of School")

combined.plot.gdp <- ggplot(data = low.years, aes(x = loggdp, y = school))+geom_point() + theme_bw() + xlab("Log GDP per Capita") + ylab("Percentage of Children Ages 6-11 \n Out of School")


## Section 2 Plots

gavi00.mortality <- aggregate(gavi00$survival_rate, by=list(gavi00$year), 
                           FUN=mean, na.rm=TRUE)
gavi00.lifeexpect <- aggregate(gavi00$lifeexpect, by=list(gavi00$year), 
                              FUN=mean, na.rm=TRUE)

gavi.life <- ggplot(data = gavi00.lifeexpect, aes(x = Group.1, y = x))+geom_point() + theme_bw() + xlab("Year") + ylab("Log Life Expectancy")+xlim(1980,2014)

gavi.mort <- ggplot(data = gavi00.mortality, aes(x = Group.1, y = x))+geom_point() + theme_bw() + xlab("Year") + ylab("Childhood Survival Rate") +xlim(1980,2014)


gavi00$adultsurvive <- (1 - (gavi00$adultmort/1000))*100


gavi00.adultsur <- aggregate(gavi00$adultsurvive, by=list(gavi00$year), 
                               FUN=mean, na.rm=TRUE)

gavi.mort <- ggplot(data = gavi00.adultsur, aes(x = Group.1, y = x))+geom_point() + theme_bw() + xlab("Year") + ylab("Adult Survival Rate") +xlim(1980,2014)

