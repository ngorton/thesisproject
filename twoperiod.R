# prob = probability of success #
library(reshape2)

mortality.vector <- seq(from = 0, to =0.4, by = 0.01)
frame.results <- data.frame(1:length(mortality.vector))
frame.results$noschool.vector <- rep(NA, nrow(frame.results))
frame.results$mort.value <- mortality.vector
frame.results$overall.mort.rate <-  rep(NA, nrow(frame.results))
country.mat <- matrix(nrow = length(mortality.vector), ncol = 15)

#for (k in 1:ncol(country.mat)) {
  
  for (j in 1:length(mortality.vector)) {
    
    #country.gdpscale <- abs(rnorm(1, mean = 0.05, sd = 0.05))
    
   # prob.child.death <- abs(mortality.vector[j]-country.gdpscale)
    prob.child.death <- 1-mortality.vector[j]
    prob.young.death <- 0.2
    childhood <- 10
    life.expect <- 70
    yc <- function(prob.child.death) { 
      rbinom(1000, 1, prob.child.death) 
    }
    
  
    life.expect <- 70
    high.wage <- rnorm(1000, mean = 10, sd = 3)
    low.wage <- 5
    cost <- abs(rnorm(1000, mean = 30, sd = 8))
    
    a.school.val <- function(child, high.wage, f){ 
      if(child == 1){
        val.school <- -f*childhood
      }
      if(child == 0){
        val.school <- -f*childhood + high.wage*(life.expect-childhood)
      }
      return(val.school)
    }
    
    
    a.noschool.val <- function(child, high.wage, f){ 
      if(child  == 1){
        val.noschool <- low.wage*childhood
      }
      if(child  == 0){
        val.noschool <- low.wage*life.expect
      }
      return(val.noschool)
    }
    
    id <- c(1:1000)
    people <-data.frame(id)
    people$noschool <- rep(NA, nrow(people))
    people$school <- rep(NA, nrow(people))
    people$high.wage <- rep(NA, nrow(people))
    people$choice <- rep(NA, nrow(people))
    people$cost <- rep(NA, nrow(people))
    
    
    
    for (i in 1:nrow(people)){
      people$yc[i] <- yc(prob.child.death)[i]
      people$high.wage[i] <- high.wage[i]
      people$cost[i] <-cost[i]
      people$school[i] <- a.school.val(yc(prob.child.death)[i],people$high.wage[i],people$cost[i] )
      people$noschool[i] <- a.noschool.val(yc(prob.child.death)[i],people$high.wage[i],people$cost[i] )
    
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
# country.mat[,k] <-frame.results$noschool.vector
#}

library(ggplot2)

country.df <- cbind(mortality.vector, na.omit(data.frame(country.mat)))
meltcountry.df <- melt(country.df, id = "mortality.vector")

plot.values.overall <-ggplot(meltcountry.df,aes(x=mortality.vector,y=value,colour="black")) + geom_point(color = "black") + stat_smooth() + theme_bw()+ xlab("Probability of Childhood Death") + ylab("Rate of Children Out of School")
final.plot <- plot.values.overall + theme_bw() +stat_smooth()
complete.plot <- final.plot + theme(legend.position = "none")

plot.values <- ggplot(frame.results, aes(mort.value, noschool.vector)) + geom_bar(stat = "identity") + xlab("Probability of Childhood Death") + theme_bw() + ylab("Rate of Children Out of School")



### Do the same thing for life expectancy ### 
