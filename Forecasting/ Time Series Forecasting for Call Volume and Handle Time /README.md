# Time Series Forecasting for Call Volume and Handle Time

## Overview

This project demonstrates advanced time series forecasting techniques applied to real-world data from Square Inc's inbound call handling group. The goal was to predict future call volumes and handle times to assist in workforce planning, ensuring sufficient staffing levels to meet demand.

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

- **Weekly Volume Forecast**: The ARIMA model forecasts an upward trend in weekly call volumes over the next 12 weeks, ranging from approximately 2,145 to 3,970 calls per week. A significant spike is expected in early November.
- **Monthly Volume Forecast**: For the next 18 months, monthly call volumes are projected to increase steadily, starting from around 11,845 in September 2023 and potentially reaching over 20,376 by October 2024.
- **Average Handle Time (AHT) Forecast**: The AHT is anticipated to gradually rise over the next year, from about 1,052 seconds in September 2023 to approximately 1,196 seconds by December 2024.
- **Total Handled Time (HT) Projection**: Combining the volume and AHT forecasts, the total handled time is expected to escalate, indicating a growing workload for the call center. For example, HT is forecasted to increase from approximately 12.4 million seconds in September 2023 to over 24 million seconds by October 2024.
- **Model Performance**: The ARIMA models demonstrated strong predictive capabilities, with low mean absolute errors (MAE) and mean absolute percentage errors (MAPE), ensuring reliable and accurate forecasts.

## Conclusion

This project showcases the application of time series forecasting to real-world data, providing actionable insights for workforce planning in customer service operations. The models developed can be used to predict future call volumes and handle times, helping to optimize staffing levels and improve service delivery.
