mortality.vector <- seq(from = 0, to = 0.5, by = 0.01)
frame.results <- data.frame(1:length(mortality.vector))
frame.results$noschool.vector <- rep(NA, nrow(frame.results))
frame.results$mort.value <- mortality.vector
frame.results$overall.mort.rate <-  rep(NA, nrow(frame.results))
country.mat <- matrix(nrow = length(mortality.vector), ncol = 10)
country.gdpscale <- data.frame(1:ncol(country.mat))
country.gdpscale$vals<- abs(rnorm(ncol(country.mat), mean = 0.05, sd = 0.05))


library(reshape2)

for (k in 1:ncol(country.mat)) {
  
for (j in 1:length(mortality.vector)) {
  
 prob.child.death <- mortality.vector[j]*country.gdpscale$vals[k]
  prob.child.death <-mortality.vector[j]
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
  high.wage <- rnorm(1000, mean = 10, sd = 5)
  low.wage <- 7
  cost <- abs(rnorm(1000, mean = 35, sd = 10))
  
  a.school.val <- function(child, adult, high.wage, f){ 
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
  
  
  a.noschool.val <- function(child, adult, high.wage, f){ 
    if(child == 0){
      val.noschool <- 0
    }
    if(child  == 1 & adult == 0){
      val.noschool <- low.wage*childhood
    }
    if(child  == 1 & adult == 1){
      val.noschool <- low.wage*(life.expect - childhood)
    }
    return(val.noschool)
  }
  
  id <- c(1:1000)
  people <-data.frame(id)
  people$noschool <- rep(NA, nrow(people))
  people$school <- rep(NA, nrow(people))
  people$high.wage <- rep(NA, nrow(people))
  people$cost <- rep(NA, nrow(people))
  people$choice <- rep(NA, nrow(people))
  
  
  for (i in 1:nrow(people)){
    people$yc[i] <- yc(prob.child.death)[i]
    people$ya[i] <- ya(prob.young.death, people$yc[i])[i]
    people$cost[i] <- cost[i]
    people$high.wage[i] <- high.wage[i]
    people$school[i] <- a.school.val(yc(prob.child.death)[i],ya(prob.young.death, yc(prob.child.death))[i],people$high.wage[i],  people$cost[i]  )
    people$noschool[i] <- a.noschool.val(yc(prob.child.death)[i],ya(prob.young.death, yc(prob.child.death)),people$high.wage[i],  people$cost[i]  )
  }
  
  for (i in 1:nrow(people)){
    if(people$school[i] >= people$noschool[i]){
      people$choice[i] <- 1
    }
    if(people$school[i] < people$noschool[i]){
      people$choice[i] <- 0
    }
    if(people$school[i] == 0){
      people$choice[i] <- 0
      
    }
  }
  
  frame.results$noschool.vector[j] <- 1 - mean(people$choice) 
}
 country.mat[,k] <-frame.results$noschool.vector

}

library(ggplot2)
plot.values <- ggplot(frame.results, aes(x = mort.value, y = noschool.vector)) + geom_point() + xlab("Probability of Childhood Death") + theme_bw() + ylab("Rate of Children Out of School")

country.df <- cbind(mortality.vector, na.omit(data.frame(country.mat)))
meltcountry.df <- melt(country.df, id = "mortality.vector")

plot.values.overall <-ggplot(meltcountry.df,aes(x=mortality.vector,y=value,colour="black")) + geom_point(color = "black") + stat_smooth() + theme_bw()+ xlab("Probability of Childhood Death") + ylab("Rate of Children Out of School")
final.plot <- plot.values.overall + theme_bw() +stat_smooth()
complete.plot <- final.plot + theme(legend.position = "none")
