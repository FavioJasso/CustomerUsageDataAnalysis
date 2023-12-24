# ---------------------------------------------------------------------------
# IMPORT DATA AND SETUP
# ---------------------------------------------------------------------------
data <- read.csv("./data/ecommerce-users")
View(data)

str(data)
summary(data) 

# ---------------------------------------------------------------------------
# CREATE PLOTS AND SEARCH FORM INSIGHTS
# ---------------------------------------------------------------------------
library(ggplot2)

# correlation between time on website and yearly amount spent? 
ggplot(data, aes(x=Time.on.Website, y=Yearly.Amount.Spent)) + 
  geom_point(color="blue") + 
  ggtitle("Time on website vs. Yearly amount spent") +
  xlab("Time on website") +
  ylab("Yearly amount spent")

# avg session length vs yearly amount spent
ggplot(data, aes(x=Avg..Session.Length, y=Yearly.Amount.Spent)) + 
  geom_point(color="blue") + 
  ggtitle("Session Length vs. Yearly amount spent") +
  xlab("Session Length") +
  ylab("Yearly amount spent")

## pair plot of all continuous variables
pairs(data[c("Avg..Session.Length",
             "Time.on.Website",
             "Time.on.App",
             "Length.of.Membership",
             "Yearly.Amount.Spent"
             )],
      col="blue",
      pch=16,
      main="Pair Plot of all continuous variables"
      )
# ---------------------------------------------------------------------------
# EXPLORING THE SELECTED VARIABLES 
# ---------------------------------------------------------------------------

#is the variable normally distributed?
hist(data$Length.of.Membership)
ggplot(data, aes(x=Length.of.Membership)) +
  geom_histogram(
    color="white",
    fill="orange",
    binwidth = 0.5
  )

boxplot(data$Length.of.Membership)
ggplot(data, aes(x=Length.of.Membership)) +
  geom_boxplot(fill="orange")

# ---------------------------------------------------------------------------
# FITTING A LINEAR MODEL 
# ---------------------------------------------------------------------------

attach(data)
lm.fit1 <- lm(Yearly.Amount.Spent ~ Length.of.Membership)

summary(lm.fit1)

plot(Yearly.Amount.Spent~Length.of.Membership)
abline(lm.fit1, col="red")

# ---------------------------------------------------------------------------
# RESIDUALS ANALYSIS 
# ---------------------------------------------------------------------------
hist(residuals(lm.fit1))

qqnorm(residuals(lm.fit1))
qqline(residuals(lm.fit1), col="red")

shapiro.test(residuals(lm.fit1))

# ---------------------------------------------------------------------------
# EVALUATING THE MODEL
# ---------------------------------------------------------------------------
set.seed(1) 
row.number <- sample(1:nrow(data), 0.8*nrow(data))
train <- data[row.number,]
test <- data[-row.number,]

# estimate the linear fit with the training set 
lm.fit0.8 <- lm(Yearly.Amount.Spent ~ Length.of.Membership, data=train)
summary(lm.fit0.8)

# predict in the test data set
predict0.8 <- predict(lm.fit0.8, newdata = test)

err0.8 <- predict0.8 - test$Yearly.Amount.Spent

# root mean square error
rmse <- sqrt(mean(err0.8^2))
#mean absolute percentage error
mape <- mean(abs(err0.8/test$Yearly.Amount.Spent))

c(RMSE=rmse,mape=mape,R2=summary(lm.fit0.8)$r.squared)

# ---------------------------------------------------------------------------
#MULTIPLE REGRESSION
# ---------------------------------------------------------------------------

attach(data)
lm.fit <- lm(Yearly.Amount.Spent ~Avg..Session.Length +
               Time.on.Website +
               Time.on.App +
               Length.of.Membership)
summary(lm.fit)
# --------------
# findings :
# 3 of the 4 variables studied seem to have an positive impact on the
# response variable. the most important remains length of membership, with 
# a coefficient 1.5 and 2.4 higher than Time on App and Avg Session Length 
# respectively. 
# Time on website seems to have little impact in the response. 

# ---------------------------------------------------------------------------
# EVALUATING THE MULTIPLE REGRESSION MODEL
# ---------------------------------------------------------------------------
set.seed(1) 
row.number <- sample(1:nrow(data), 0.8*nrow(data))
train <- data[row.number,]
test <- data[-row.number,]

# estimate the linear fit with the training set 
multi.lm.fit0.8 <- lm(Yearly.Amount.Spent ~Avg..Session.Length +
               Time.on.Website +
               Time.on.App +
               Length.of.Membership, data=train)
summary(multi.lm.fit0.8)

# predict in the test data set
predict0.8 <- predict(multi.lm.fit0.8, newdata = test)

err0.8 <- predict0.8 - test$Yearly.Amount.Spent

# root mean square error
rmse <- sqrt(mean(err0.8^2))
#mean absolute percentage error
mape <- mean(abs(err0.8/test$Yearly.Amount.Spent))

c(RMSE=rmse,mape=mape,R2=summary(lm.fit0.8)$r.squared) # to print the 3 parameters
# --------
# findings
# by using a multiple linear model, we have created a much more accurate
# predictor of the response variable. R2 went from 0.65 to 0.98
# and the RSE went from 47.14 to 9.97 dollars.