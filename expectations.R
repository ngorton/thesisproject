#Also, this is the Brad Paisley concert: http://www.ticketmaster.com/brad-paisley-crushin-it-world-tour-bloomington-illinois-03-12-2016/event/07004F6C1F9C86C1?artistid=714837&majorcatid=10001&minorcatid=2&tm_link=artist_msg-0_07004F6C1F9C86C1
childhood=10
lifeexp=80
library(data.table)
setNumericRounding(0)

mortality.vector <- seq(from = 0, to = 0.4, by = 0.01)
country.mat <- matrix(nrow = length(mortality.vector), ncol = 50)
results <- data.frame(1:length(mortality.vector))
results$rates <- rep(NA, nrow(results))
results$mort <- mortality.vector

create.data <- function(mortality.number) {
    data = data.table(highwage=rnorm(1000, 20, 10), cost=rnorm(1000, 50, 10), prob.dead=rnorm(1000, mortality.vector[j], 0.01), indic=c(1:1000), lowwage = rnorm(1000, 5, 2), country.gdp = rnorm(1000, 50, 5))
    data[indic>0, ':='(
      val_school = ((-1*cost*childhood+highwage*(lifeexp - childhood))*(1-prob.dead) +  (prob.dead)*(-1*cost*childhood))+ country.gdp,
      val_noschool= ((1-prob.dead)*lowwage*lifeexp+0*(prob.dead)) + country.gdp,
      choice = 0
 ) ]
    data[val_school > val_noschool, ':='(
      choice = 1
    )]
    data[val_school <= val_noschool, ':='(
      choice = 0
    )]
    }
    

for (j in 1:length(mortality.vector)){
  results$rates[j] <- create.data(mortality.vector[j])
}

country.scale <- rnorm(50, 0.1, 0.01)

for (k in 1:50){
  country.mat[,k] <- (results$rates)*100
}


plot.rates <- ggplot(data = results, aes(x= mort, y =  rates)) + geom_point() + xlab("Probability of Childhood Death") + ylab("Rate of Children Out of School")+theme_bw()+stat_smooth()

country.df <- cbind(mortality.vector, na.omit(data.frame(country.mat)))
meltcountry.df <- melt(country.df, id = "mortality.vector")

plot.values.overall <-ggplot(meltcountry.df,aes(x=mortality.vector,y=value,colour="black")) + geom_point(color = "black") + stat_smooth() + theme_bw()+ xlab("Probability of Childhood Death") + ylab("Rate of Children Out of School")
final.plot <- plot.values.overall + theme_bw() +stat_smooth()
complete.plot <- final.plot + theme(legend.position = "none")