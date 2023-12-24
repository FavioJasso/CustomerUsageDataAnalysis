# CustomerUsageDataAnalysis
I used R to create a linear regression model with a single variable and multivariable analysis for an Ecommerce Customer Device Usage Data Set. The following visuals were done in the "ggplot2" library. 

## CREATATION OF PLOTS AND SEARCHING FOR INSIGHTS ##

**AVERAGE SESSION LENGTH VS YEARLY AMOUNT SPENT** 

![Preview](https://github.com/FavioJasso/CustomerUsageDataAnalysis/blob/main/AvgSessionLengthVSYearlyAmountSpent.png) 

**TIME ON WEBSITE VS YEARLY AMOUNT SPENT** 

![Preview](https://github.com/FavioJasso/CustomerUsageDataAnalysis/blob/main/TimeOnWebsiteVsYearlyAmountSpent.png) 

**PAIR PLOT OF ALL CONTINUOUS VARIABLES**

![Preview](https://github.com/FavioJasso/CustomerUsageDataAnalysis/blob/main/Pair%20Plot%20of%20continuous%20variables.png)


### FITTING A LINEAR MODEL ### 

![Preview](https://github.com/FavioJasso/CustomerUsageDataAnalysis/blob/main/FittingLinearModel.png)

**RESIDUALS ANALYSIS**

![Preview](https://github.com/FavioJasso/CustomerUsageDataAnalysis/blob/main/NormalQQPlot.png)


**EVALUATING THE MULTIPLE REGRESSION MODEL FINDINGS**

By using a multiple linear model, we have created a much more accurate predictor of the response variable.

- R2 went from 0.65 to 0.98
- Mean Absolute Percentage Error 0.07 to 0.01 
- The Root Mean Square Errorwent from 47.14 to 9.97 dollars.

To get better insight and understanding on the Regression Model, I suggest checking Main.R for the source code. All my code is properly documented throughout my project. 

