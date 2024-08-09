# Time Series Forecasting for Call Volume and Handle Time

## Overview

This project demonstrates advanced time series forecasting techniques applied to real-world data from a fictitious inbound call handling group. The goal was to predict future call volumes and handle times to assist in workforce planning, ensuring sufficient staffing levels to meet demand.

## Project Objectives

1. **Monthly Volume Prediction**: Forecast the call volume for the next 18 months.
2. **Weekly Volume Prediction**: Forecast the call volume for the next 12 weeks.
3. **Handle Time Prediction**: Predict the average handle time (AHT) for the next year.

## Dataset Overview

1. **Date**: The specific date on which the data was recorded.
2. **Skill ID**: A numerical identifier for the skill or service line handling the calls.
3. **Group Name**: The name of the group or team responsible for handling the calls.
4. **Time**: The time at which the data was recorded, typically in 30-minute intervals.
5. **Contacts Received**: The number of calls or contacts received during the specified time interval.
6. **AHT of Handled Contacts**: The Average Handle Time (AHT) for the contacts received, representing the average time taken to handle each call.

## Tools and Libraries Used

- **Python**: The primary language used for data processing and modeling.
- **Pandas**: For data manipulation and analysis.
- **NumPy**: For numerical operations.
- **Matplotlib & Seaborn**: For data visualization.
- **Statsmodels**: For time series analysis and modeling (ARIMA, SARIMA).
- **pmdarima**: For automatic ARIMA model selection.
- **scikit-learn**: For machine learning model evaluation.
- **tqdm**: For progress visualization during model training.

## Project Structure

1. **Import Data**: Load and preprocess the data from the provided Excel file.
2. **Data Quality Check**: Perform checks on the data to ensure consistency, handle missing values, and validate assumptions.
3. **Exploratory Data Analysis (EDA)**: Visualize the data to understand patterns, trends, seasonality, and anomalies.
4. **Time Series Data Processing**: Decompose the time series data to analyze trends, seasonality, and noise.
5. **Modeling**: 
   - **ARIMA** and **SARIMA** models were used for forecasting.
   - Both models were applied to weekly and monthly data, with adjustments made to improve accuracy.
6. **Forecasting Results**: Generate forecasts for the next 12 weeks (weekly data) and 18 months (monthly data), as well as handle time predictions for the next year.

## Key Findings

- **Volume Trends**: The forecasted volume showed a consistent upward trend with seasonal peaks and troughs.
- **Handle Time**: The handle time prediction indicated an increase over the next year, highlighting the need for increased staffing during peak periods.
- **Model Performance**: The SARIMA model provided slightly better accuracy than ARIMA, particularly for longer-term forecasts.

## Conclusion

This project showcases the application of time series forecasting to real-world data, providing actionable insights for workforce planning in customer service operations. The models developed can be used to predict future call volumes and handle times, helping to optimize staffing levels and improve service delivery.
