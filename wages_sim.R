#Also, this is the Brad Paisley concert: http://www.ticketmaster.com/brad-paisley-crushin-it-world-tour-bloomington-illinois-03-12-2016/event/07004F6C1F9C86C1?artistid=714837&majorcatid=10001&minorcatid=2&tm_link=artist_msg-0_07004F6C1F9C86C1
childhood=10
lifeexp=70
lowwage = 1
library(data.table)
setNumericRounding(0)

wages.vector <- seq(from = 1, to = 100, by = 5)
country.mat <- matrix(nrow = length(mortality.vector), ncol = 50)
wages.mat <- matrix(nrow = length(wages.vector), ncol = 1)

for (j in 1:length(wages.vector)) {
  
  data = data.table(highwage=rnorm(1000, wages.vector[j], 15), cost=rnorm(1000, 25, 15), yc=rbinom(1000, 1, 0.6), ya=rbinom(1000, 1, 0.8))
  data[yc==0, ':='(
    val_school = 0,
    val_noschool = 0
  )]
  data[yc==1 & ya==0, ':='(
    val_school= -1*cost*childhood,
    val_noschool = lowwage*childhood
  )]
  data[yc== 1 & ya==1, ':='(
    val_school= -1*cost*childhood + highwage*(lifexp-childhood),
    val_noschool = lowwage*lifeexp
  )]
  data[val_school > val_noschool, ':='(
    choice = 1
  )]
  data[val_school <= val_noschool, ':='(
    choice = 0
  )]
  wages.mat[k] <- 1-mean(data$choice)
}
wages.values <- cbind(wages.mat, wages.vector)
wages.df <- melt(data.frame(wages.values), id = "wages.vector")
plot.wages <- ggplot(data = wages.df, aes(x= wages.vector, y = value )) + geom_point() + xlab("Expected Skilled Wage") + ylab("Rate of Children Out of School")+theme_bw()
