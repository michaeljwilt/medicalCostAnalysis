# Statistical Modeling

# **Tasks:**
# 1. Import Packages
# 2. Load in Data
# 3. Data Wrangling (if necessary)
# 4. Assumption Testing
# * Normality
# * Homogeneity of Variance
# * Sample Size
# * Independence
# 5. ANOVA
# 6. Post Hoc
# 7. Conclusion

#Import Packages
library("dplyr")
library("rcompanion")
library("car")
library("ggplot2")
library("IDPmisc")
library("readr")

#import data
insurance <- read_csv("Datasets/insuranceForStats.csv")
View(insurance)


###########################
#####  Data Wrangling #####
###########################
#Recoded children into dummy code for ANOVA analysis
insurance$childrenR <- ifelse(insurance$children == 0, 0, 1)


###########################
###  Assumption Testing ###
###########################

##Normality

plotNormalHistogram(insurance$ageR)
plotNormalHistogram(insurance$bmiR)
#Since other code is Dummy code, we have met the Assumption of normality


## Homogeneity of Variance
bartlett.test(charges ~ ageR, data=insurance)
# Bartlett's K-squared = 3.0791, df = 4, p-value = 0.5447
bartlett.test(charges ~ bmiR, data=insurance)
# Bartlett's K-squared = 238.52, df = 4, p-value < 2.2e-16
bartlett.test(charges ~ childrenR, data=insurance)
# Bartlett's K-squared = 0.05922, df = 1, p-value = 0.8077
bartlett.test(charges ~ sexDummy, data=insurance)
# Bartlett's K-squared = 15.585, df = 1, p-value = 7.887e-05

#sex and bmi have violated the homgeneity of variance
#I will perform 2 ANOVAS moving forward. One will correct for this violation.





###########################
########## ANOVA ##########
###########################

#Normal Two-Way Anova

#Null Hypothesis: Age and Children does not impact the medical charges
#Alternative Hypothesis: Age and Children does impact the medical charges

model <- aov(charges ~ ageR * childrenR, insurance)
summary(model)
# ageR              1 1.765e+10 1.765e+10 132.603 <2e-16 ***
# childrenR         1 7.302e+08 7.302e+08   5.484 0.0193 *  
# ageR:childrenR    1 8.470e+07 8.470e+07   0.636 0.4252    
# Residuals      1334 1.776e+11 1.331e+08         

# We can see that both variables have a significant impact
# We accept the alternative hypothesis


#Unequal Variance Two-Way ANOVA

#Null Hypothesis: BMI and Sex does not impact the medical charges
#Alternative Hypothesis: BMI and Sex does impact the medical charges

ANOVA <- lm(charges ~ bmiR * sexDummy, data=insurance)
Anova(ANOVA, Type="II", white.adjust=TRUE)
# bmiR             1 57.0059 8.021e-14 ***
# sexDummy         1  0.5835   0.44507    
# bmiR:sexDummy    1  4.8089   0.02849 *  
# Residuals     1334             

#We can see that bmi has significant impact on the charges for a person while sex does not
#However, the interaction between sex and bmi is significant enough to warrant us using sex in our final prediction model
# We accept the alternative hypothesis



###########################
####  Post Hoc Testing ####
###########################

#AgeR
pairwise.t.test(insurance$charges, insurance$ageR, p.adjust="bonferroni")
#     1       2       3       4     
#   2 0.0536  -       -       -     
#   3 6.7e-08 0.0786  -       -     
#   4 1.1e-14 2.5e-05 0.3366  -     
#   5 < 2e-16 4.5e-12 1.1e-06 0.0024

#Age Categories
# 18 - 29
# 30-39
# 40-49
# 50-59
# 60 and over

#We can see that from one category to the next, there is not a significant difference in charges
#but when you skip from one category to the next you see a significant difference in charges
#However, once you go from 50s-60s, there is a significant difference in charges


#childrenR
pairwise.t.test(insurance$charges, insurance$childrenR, p.adjust="bonferroni")
# 0    
# 1 0.018

#There is a significant difference in charges between kids and no kids

#bmiR
pairwise.t.test(insurance$charges, insurance$bmiR, p.adjust="bonferroni", pool.sd = FALSE)
#     0      1       2       3     
#   1 1.0000 -       -       -     
#   2 1.0000 1.0000  -       -     
#   3 0.0609 2.9e-05 0.0002  -     
#   4 0.0023 2.2e-09 1.6e-08 0.2320

#BMI Categories
# Underweight - BMI under 18.5 kg/m^2.
# Normal weight - BMI greater than or equal to 18.5 to 24.9 kg/m^2.
# Overweight – BMI greater than or equal to 25 to 29.9 kg/m^2.
# Obesity – BMI greater than or equal to 30 kg/m^2 to 34.9 kg/m^2.
# Severe Obesity - BMI greater than or equal to 35 kg/m^2.

#We see that there is no significance in charges until we cross the obesity threshold.
#Once we pass into obesity there is a significance in charges difference until we go from obesity to severe obesity

#Sex
pairwise.t.test(insurance$charges, insurance$sexDummy, p.adjust="bonferroni", pool.sd = FALSE)
# 0    
# 1 0.036

#There is a significant difference in charges between the sexes



###########################
####### Conclusions #######
###########################


#1. Individually all of our variables have significant impact on charges except for sex, which has significance in regards to BMI
#2. Through our post hoc testing, we have a glimpse into how our ML Model can predict charges between different variable categories
#3. We will proceed with our model building with all current variables











