#Also, this is the Brad Paisley concert: http://www.ticketmaster.com/brad-paisley-crushin-it-world-tour-bloomington-illinois-03-12-2016/event/07004F6C1F9C86C1?artistid=714837&majorcatid=10001&minorcatid=2&tm_link=artist_msg-0_07004F6C1F9C86C1
childhood=10
lifeexp=80
lowwage = 20 
library(data.table)
setNumericRounding(0)

## Create values for parameters
mortality.vector <- seq(from = 0, to = 0.4, by = 0.01)
wages.scale<- seq(from = 20, to = 100, by = 5)

## Create some places to hold the data
wages.mat <- matrix(nrow = length(mortality.vector), ncol = 1)
results <- data.frame(1:length(mortality.vector))
results$rates <- rep(NA, nrow(results))
results$mort <- mortality.vector

## A function that takes in a mortality rate and a high wage
## and returns the rate of out of school kids

wage <- function(highwage, mortality.vector) {
data = data.table(cost=rnorm(1000, 700, 10), lowwage=rnorm(1000, 50, 10), highwage=rnorm(1000, highwage, 30),yc=rbinom(1000, 1, 1-mortality.vector))
data[yc==0, ':='(
  val_school = -1*cost*childhood*mortality.vector,
  val_noschool = lowwage*(lifeexp-childhood)*mortality.vector
  )]
data[yc== 1, ':='(
  val_school= (-1*cost*childhood)*mortality.vector+ highwage*(lifeexp-childhood)*(1-mortality.vector),
  val_noschool = lowwage*lifeexp*(1-mortality.vector)
  )]
data[val_school > val_noschool, ':='(
  choice = 1
)]
data[val_school <= val_noschool, ':='(
  choice = 0
)]
return(1-mean(data$choice[data$yc == 1]))
}



# A function that takes a high wage and returns
# a matrix of schooling rates based on mortality level

mort.func <- function(wages) {
  for (k in 1:length(mortality.vector)){
  wages.mat[k] <- wage(wages, mortality.vector[k]) 
  }
  return(wages.mat)
}

# A function that takes a variety of different wages and constructs 
# a matrix with length # mortality rates and width # of wage parameters
wages.scale<-100
wages.mat.complete <- matrix(nrow = length(mortality.vector), ncol = length(wages.scale))

## Loop through a vector of wages and fill the columns of a matrix

for (k in 1:length(wages.scale)){
  wages.mat.complete[,k] <- mort.func(wages.scale[k])
}

# Convert this great matrix to a dataframe
wages.mat.combined <- data.frame(cbind(mortality.vector, wages.mat.complete))
wages.df <- melt(wages.mat.combined, id = "mortality.vector")

## Plot! 
plot.rates <- ggplot(data = wages.df, aes(x = mortality.vector, y = value)) + geom_point() + xlab("Probability of Childhood Death") + ylab("Rate of Children Out of School")+theme_bw()+stat_smooth()
plot.rates <- ggplot(data = wages.df, aes(x = mortality.vector, y = value)) + geom_point() + xlab("Probability of Childhood Death") + ylab("Rate of Children Out of School")+theme_bw()+stat_smooth()

plot.rates
