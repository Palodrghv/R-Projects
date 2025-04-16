# Load necessary libraries
library(forecast)
library(tidyverse)
library(lubridate)

# Read the data
data<- My_data

# Convert the 'Month' column to a date format and set it as a ts object
data$Month <- as.Date(data$Month)
ts_data <- ts(data$`Solar Energy Consumption (Trillion Btu)`, start=c(2001, 1), frequency=12)

# Plotting time series data
plot(ts_data, main="Time Series Plot of Solar Energy Consumption", xlab="Year", ylab="Consumption (Trillion Btu)")

# Seasonal plot
ggseasonplot(ts_data, year.labels=TRUE, main="Seasonal Plot")

# Subseries plot
ggsubseriesplot(ts_data, main="Subseries Plot")

# Lag plot
lag.plot(ts_data, lags=12, main="Lag Plot")

# ACF plot
Acf(ts_data, main="Autocorrelation Function")

# Fitting a linear model
fit <- lm(ts_data ~ time(ts_data))
summary(fit)
ts.plot(ts_data, fitted(fit), col=1:2, main="Observed vs Fitted Values from Linear Model")

# Moving Average
ma <- ma(ts_data, order=12)
plot(ma, main="12-Month Moving Average")

# Single Exponential Smoothing
ses <- ses(ts_data, h=12)
plot(ses, main="Single Exponential Smoothing Forecast")

# Holt's Linear Trend
holt <- holt(ts_data, h=12)
plot(holt, main="Holt's Linear Trend Forecast")

# Holt-Winters Seasonal Method
hw <- HoltWinters(ts_data)
plot(hw, main="Holt-Winters Forecast")


# Assuming ts_data is your time series object from the previous example
plot(ts_data, main="Time Series Plot of Solar Energy Consumption", xlab="Year", ylab="Consumption (Trillion Btu)")
plot(decompose(ts_data))

# Using Augmented Dickey-Fuller test to check for stationarity
library(tseries)
adf.test(ts_data, alternative = "stationary")

# Difference the series
diff_ts_data <- diff(ts_data, differences = 1)

# Re-run the Augmented Dickey-Fuller test
adf.test(diff_ts_data, alternative = "stationary")

# Autocorrelation and Partial Autocorrelation plots
Acf(diff_ts_data, main="ACF of Solar Energy Consumption")
Pacf(diff_ts_data, main="PACF of Solar Energy Consumption")

# Fit initial models
library(forecast)


model1 <- Arima(ts_data, order=c(1, 1, 1), seasonal=c(1, 1, 1))
model2 <- Arima(ts_data, order=c(1, 1, 2), seasonal=c(1, 1, 2))
model3 <- Arima(ts_data, order=c(2, 1, 1), seasonal=c(2, 1, 1))
model4 <- Arima(ts_data, order=c(1, 1, 3), seasonal=c(1, 1, 3))
summary(model1)
summary(model2)
summary(model3)
summary(model4)
# Forecasting with the selected model
best_model <- model1  # assuming model1 was the best
forecast <- forecast(best_model, h=12)
plot(forecast)

