# Data work #
# Covert data from STATA to CSV #
setwd("~/Desktop/data")
library(foreign)
write.table(read.dta('saturdaymorning.dta'), file="output.csv", quote = FALSE, sep = ",")

# Read it into R #
data <- read.csv("output.csv", header = TRUE, row.names=NULL, na.strings=c("","NA"))

library(ggplot2)

# Subsetting by income group # 
low <- subset(data, data$low == 1)
high <- subset(data, data$high == 1)
gavi00 <- subset(data, data$gavi_status_00== 1)
no.gavi00 <- subset(data, data$gavi_status_00== 0)

# Plot some things for poor countries # 



gavi00.year.diff.coverage.mean <-aggregate(gavi00$diff_mcv1coverage, by=list(gavi00$year), 
                           FUN=mean, na.rm=TRUE)

gavi00.mcv1.mean <- ggplot(low.year.diff.coverage.mean, aes(Group.1, x))
gavi00.mcv1.mean + geom_line() + labs(x = "Year", y = "Change in MCV1 coverage (percentage point)") + 
  ggtitle("Average Annual Change in MCV1 Coverage Over Time \n Low-Income Countries") + theme_bw()

gavi00.year.schoolingM <- aggregate(gavi00$rateofoutofschoolM, by=list(gavi00$year), 
                             FUN=mean, na.rm=TRUE)

gavi00.school <- ggplot(na.omit(gavi00.year.schoolingM), aes(x = Group.1, y = x)) +                    # basic graphical object
  geom_line(colour="green") + labs(x = "Year", y = "Rate of Out of School Boys \n of Primary Age (%)") + 
  ggtitle("Schooling Trends Over Time, Poor Countries") + theme_bw()


gavi00.year.measlescases <- aggregate(gavi00$measles_cases, by=list(gavi00$year), 
                                    FUN=mean, na.rm=TRUE)

data.year.measlescases.sum <- aggregate(data$measles_cases, by=list(data$year), 
                                      FUN=sum, na.rm=TRUE)

data.year.mcv1 <- na.omit(aggregate(data$unicefmcv1, by=list(data$year), 
                                    FUN=mean, na.rm=TRUE))

total.measlescases <- ggplot(data.year.measlescases.sum, aes(x = Group.1, y =x)) + geom_bar(stat = "identity") + xlim(1980,2013) 

average.cov <- ggplot() + geom_line(data = data.year.mcv1, aes(x = data.year.mcv1$Group.1, y = data.year.mcv1$x)) + geom_line(data = data.year.mcv1, aes(x = data.year.mcv1$Group.1, y = data.year.mcv1$x))

gavi00.measlescases <- ggplot(na.omit(gavi00.year.measlescases), aes(x = Group.1, y = x)) +                    # basic graphical object
  geom_line(colour="green") + labs(x = "Year", y = "Measles Cases (Count)") + 
  ggtitle("Schooling Trends Over Time, Poor Countries") + theme_bw()


gavi00.year.spending <- na.omit(aggregate(as.numeric(gavi00$vaxspending), by=list(gavi00$year), 
                                      FUN=mean, na.rm=TRUE))

gavi00.diff.mort <- ggplot(gavi00, aes(x = diff_mcv1coverage, y = diff_cases)) +                    # basic graphical object
  geom_point() + labs(x = "Change in Coverage", y = "Change in Mortality") + 
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


no.gavi00.year.spending <- na.omit(aggregate(no.gavi00$vaxspending, by=list(no.gavi00$year), 
                                  FUN=mean, na.rm=TRUE))

no.gavi00.spending <- ggplot(no.gavi00.year.spending, aes(x = Group.1, y = x)) +                    # basic graphical object
  geom_line(colour="green") + labs(x = "Year", y = "Percentage of Immunization Costs \n Covered by National Government") + 
  ggtitle("") + theme_bw()

gavi00.natlbudget <- ggplot(gavi00, aes(natlbudget)) + geom_bar(stat = "count")

gavi00.year.mcv1 <- na.omit(aggregate(gavi00$unicefmcv1, by=list(gavi00$year), 
                                             FUN=mean, na.rm=TRUE))

school.mortality <- ggplot(data = gavi00, aes(x = mortality, y = rateofoutofschoolMF)) + geom_point() + stat_smooth()+xlab("Child Mortality, out of 1000 Live Births")+ylab("Rate of Children Out of School") +theme_bw()

vaccine.mortality <-ggplot(data = gavi00, x = unicefmcv1, y = mortality) 

vaccine.budget.coverage <- 
  geom_line(data=gavi00.year.spending, aes(x=Group.1, y=x, color = "spending")) + 
  geom_line(data=gavi00.year.mcv1, aes(x=Group.1, y=x, color = "coverage")) + ggtitle("Average Vaccine Costs and MCV1 Coverage \n GAVI-Supported Countries") + xlim(1998, 2014) + xlab("Year")+ ylab("Percentage")+ scale_colour_manual("", 
                                 breaks = c("Percentage of Costs Covered", "MCV1 Coverage"),
                                 values = c("black", "blue"), guide = guide_legend()) +theme_bw() +   theme(legend.position = "bottom") 

vaccine.budget.coverage
vaccine.budget <- ggplot() +
  geom_line(data=gavi00.year.spending, aes(x=Group.1, y=x),
            colour="blue") + 
  geom_line(data=no.gavi00.year.spending, aes(x=Group.1, y=x),
            colour="red") + xlab("Year") + ylab("Percentage of Immunization Costs \n Covered by National Government") +theme_bw()


gavi00.schooling <- na.omit(aggregate(gavi00$rateofoutofschoolMF, by=list(gavi00$year), 
                                      FUN=mean, na.rm=TRUE))

gavi.sub.covered <- subset(gavi00, mcv_covered == 1)
gavi.sub.notcovered <- subset(gavi00, mcv_covered == 0)

gavi00.schooling.covered <- na.omit(aggregate(gavi.sub.covered$rateofoutofschoolMF, by=list(gavi.sub.covered$year), 
                                      FUN=mean, na.rm=TRUE))

gavi00.schooling.notcovered <- na.omit(aggregate(gavi.sub.notcovered$rateofoutofschoolMF, by=list(gavi.sub.notcovered$year), 
                                              FUN=mean, na.rm=TRUE))
mean.year <- mean(na.omit(gavi00$index_year))
mean.year.covered <- mean(na.omit((gavi00[gavi00$mcv_covered == 0,])$index_year))

group.vals <- gavi00$pan_id
  gavi00$index_year_R <- gavi00[gavi00$diff_dummy_coverage == 1,]$year

awesome.plot <- ggplot(data=gavi00.schooling.covered, aes(x=Group.1, y=x),
                                    colour="black") + geom_line(linetype = "dotdash") + 
  geom_line(data=gavi00.schooling.notcovered, aes(x=Group.1, y=x),
            colour="black") + xlab("Year") + ylab("Percentage of Out of School Children \n Of Primary School Age") +theme_bw()+ xlim(1980, 2014) +  geom_vline(xintercept = 1992)



# Plot similar things for rich countries # 
high.year.diff.coverage.mean <-aggregate(high$diff_coverage, by=list(high$year), 
                                        FUN=mean, na.rm=TRUE)
high.mcv1.mean <- ggplot(high.year.diff.coverage.mean, aes(Group.1, x))
high.mcv1.mean + geom_line() + labs(x = "Year", y = "Change in MCV1 coverage (percentage point)") + 
  ggtitle("Average Annual Change in MCV1 Coverage Over Time \n High-Income Countries") + theme_bw()

high.year.schooling.unesco <- aggregate(high$rateofoutofschoolM, by=list(high$year), 
                                       FUN=mean, na.rm=TRUE)

high.school <- ggplot(na.omit(high.year.schooling.unesco), aes(x = Group.1, y = x)) +                    # basic graphical object
  geom_line(colour="green") + labs(x = "Year", y = "Rate of Out of School Boys \n of Primary Age (%)") + 
  ggtitle("Schooling Trends Over Time, Rich Countries") + theme_bw()


high.year.measlescases <- aggregate(high$measles_cases, by=list(high$year), 
                                      FUN=mean, na.rm=TRUE)

high.measlescases <- ggplot(na.omit(high.year.measlescases), aes(x = Group.1, y = x)) +                    # basic graphical object
  geom_line(colour="green") + labs(x = "Year", y = "Measles Cases (Count)") + theme_bw()

## Calcuate some things ##

# Difference in schooling rates and mortality before 1980 between 
# High-covered GAVI countries and low-covered ones 


