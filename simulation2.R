# prob = probability of success #
library(reshape2)

mortality.vector <- seq(from = 0, to = 1, by = 0.02)
frame.results <- data.frame(1:length(mortality.vector))
frame.results$noschool.vector <- rep(NA, nrow(frame.results))
frame.results$mort.value <- mortality.vector
frame.results$overall.mort.rate <-  rep(NA, nrow(frame.results))
country.mat <- matrix(nrow = length(mortality.vector), ncol = 15)

for (k in 1:ncol(country.mat)) {

for (j in 1:length(mortality.vector)) {
  
<<<<<<< HEAD
country.gdpscale <- abs(rnorm(1, mean = 0.15, sd = 0.03))
=======
country.gdpscale <- abs(rnorm(1, mean = 0.15, sd = 0.07))
>>>>>>> ec43410... first commit in a while. usually make this message informative
  
prob.child.death <- abs(mortality.vector[j]-country.gdpscale)
prob.young.death <- 0.2
childhood <- 10
life.expect <- 80
yc <- function(prob.child.death) { 
  rbinom(1000, 1, prob.child.death) 
}

ya <- function(prob.young.death,yc) {
  yc * rbinom(1000, 1, prob.young.death) 
}

life.expect <- 70
high.wage <- rnorm(1000, mean = 10, sd = 0.5)+0.9
low.wage <- 2
f <- 5

a.school.val <- function(child, adult, high.wage){ 
  if(child == 0){
    val.school <- 0
  }
  if(child == 1 & adult == 0){
    val.school <- -f*childhood
      }
  if(child == 1 & adult == 1){
    val.school <- -f*childhood + high.wage*(life.expect-childhood)
  }
  return(val.school)
}


a.noschool.val <- function(child, adult, high.wage){ 
  if(child == 0){
    val.noschool <- 0
  }
  if(child  == 1 & adult == 0){
    val.noschool <- low.wage*childhood
  }
  if(child  == 1& adult == 1){
    val.noschool <- low.wage*(life.expect - childhood)
  }
  return(val.noschool)
}

id <- c(1:1000)
people <-data.frame(id)
people$noschool <- rep(NA, nrow(people))
people$school <- rep(NA, nrow(people))
people$high.wage <- rep(NA, nrow(people))
people$choice <- rep(NA, nrow(people))


for (i in 1:nrow(people)){
  people$yc[i] <- yc(prob.child.death)[i]
  people$ya[i] <- ya(prob.young.death, people$yc[i])[i]
  people$high.wage[i] <- high.wage[i]
  people$school[i] <- a.school.val(yc(prob.child.death)[i],ya(prob.young.death, yc(prob.child.death))[i],people$high.wage[i] )
  people$noschool[i] <- a.noschool.val(yc(prob.child.death)[i],ya(prob.young.death, yc(prob.child.death)),people$high.wage[i] )
}

for (i in 1:nrow(people)){
  if(people$school[i] >= people$noschool[i]){
    people$choice[i] <- 1
  }
  if(people$school[i] < people$noschool[i]){
    people$choice[i] <- 0
  }
}
frame.results$noschool.vector[j] <- 1 - mean(people$choice)
}
country.mat[,k] <-frame.results$noschool.vector
}

country.df <- cbind(mortality.vector, na.omit(data.frame(country.mat)))
meltcountry.df <- melt(country.df, id = "mortality.vector")

plot.values.overall <-ggplot(meltcountry.df,aes(x=mortality.vector,y=value,colour="black")) + geom_point(color = "black") + stat_smooth() + theme_bw()+ xlab("Probability of Childhood Death") + ylab("Rate of Children Out of School")
final.plot <- plot.values.overall + theme_bw() +stat_smooth()
complete.plot <- final.plot + theme(legend.position = "none")

plot.values <- ggplot(frame.results, aes(mort.value, noschool.vector)) + geom_bar(stat = "identity") + xlab("Probability of Childhood Death") + theme_bw() + ylab("Rate of Children Out of School")



### Do the same thing for life expectancy ### 
