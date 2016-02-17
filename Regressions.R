#Let's get started here, BROS!
setwd("~/Desktop/data")
library(foreign)
library(ggplot2)
library(plm)
library(stargazer)
library(lmtest)
write.table(read.dta('fridaypm.dta'), file="output.csv", quote = FALSE, sep = ",")

# Read it into R #
data <- read.csv("output.csv", header = TRUE, row.names=NULL, na.strings=c("","NA"))

# Subset the data based on what we want
gavi00 <- subset(data, data$gavi_status_00== 1)
no.gavi00 <- subset(data, data$gavi_status_00== 0)

## Trying to run some regressions ##
## OLS ESTIMATES ## 
gavi.data <- pdata.frame(gavi00, index = c("pan_id", "year"), row.names = TRUE)
ols1 <- plm(formula = rateofoutofschoolMF ~ lag(mortality, 5) + loggni + logpop, data = gavi.data, model = "within", effect = "twoways", na.action = na.omit)
ols2 <- plm(formula = rateofoutofschoolMF ~ lag(mortality, 7) + loggni + logpop, data = gavi.data, model = "within", effect = "twoways", na.action = na.omit)
ols3 <- plm(formula = rateofoutofschoolMF ~ lag(mortality, 10) + loggni + logpop, data = gavi.data, model = "within", effect = "twoways", na.action = na.omit)
myvcov <- function(x) vcovG(x, cluster = "group", inner = "cluster")
coeftest(ols1, vcov=myvcov)

stargazer(ols1, ols2, ols3, ols4, title="OLS Estimates", align=TRUE)

## First stage ##
first.stage <- plm(formula = morality ~ unicefmcv1*)
