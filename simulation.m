

highwage = normrnd(0, 1);
lowwage = 3;
lifeexpect = 70;
childdeath =  normrnd(0.5, 0.5) + 0.5;
schoolcost = 2;
childhood = 15;

schoolval = -schoolcost*childhood*childdeath +(lifeexpect-childhood)*highwage;
noschoolval = childhood*lowwage*childdeath + (lifeexpect-childhood)*lowwage;

plot(schoolval, highwage)