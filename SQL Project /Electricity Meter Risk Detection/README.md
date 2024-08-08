#### SQL Data Analysis Project: Detecting Tampering Based on Service Disconnects for Non-Payment


### Overview

This SQL project focuses on creating a robust and automated daily report to identify potential tampering at customer premises based on service disconnects for non-payment (DNP). By integrating data from multiple sources and applying complex filtering criteria, the project aims to provide a comprehensive view of suspicious activities that may indicate tampering.

### Data Sources

The project utilizes six key tables from the "YOURSCHEMA" schema:

1. **T_STG_EAI_SVC_ORDERS_HIST**: Contains historical data of service orders, including DNP information.
2. **T_MOBILE_DATA_CREW_ONSITE_HIST**: Provides details of crew onsite activities.
3. **PREMISE_CHAR**: Holds customer premise information.
4. **METER_CHAR**: Contains details about customer meters.
5. **INTERVAL_F**: Records electric usage data.
6. **SDP_D**: Maps usage data with service delivery points (WID and UDC_ID).

### Business Requirements

The main objectives of this project, as defined by the Business Requirements Document (BRD), are:

1. **Include Essential Data Elements**: ESIID, CIS Account Number, Meter Number, Customer Information, Service Center, Account Status, DNP details, Last Crew Onsite details, Route Number, and Billing Cycle.
2. **Daily Report Generation**: Identify premises with tampering based on specific patterns.
3. **DNP Date Criteria**: Focus on accounts with DNP occurring three days prior.
4. **Account Status**: Ensure the account is still active.
5. **No Recent Reconnect/Move**: The disconnect should not be followed by a reconnect, move-in, or move-out within three days.
6. **Usage Threshold**: Ensure there are at least two months of usage greater than 200 KWH prior to the DNP date.
7. **Daily Refresh**: The data should be refreshed daily for accuracy.

### Methodology

The SQL query involves several steps to meet the above requirements:

1. **Extract DNP Data**: Pull all DNP accounts occurring three days from the current date and ensure the status is not canceled.
2. **Filter Out Recent Activities**: Exclude accounts with recent reconnects, move-ins, or move-outs.
3. **Identify Last Crew Onsite**: Retrieve the most recent crew onsite details for each DNP account.
4. **Join Customer and Meter Information**: Merge DNP data with customer and meter information to enrich the dataset.
5. **Electric Usage Verification**: Ensure the account has consistent electric usage above the threshold for the past two months.
6. **Final Filtering**: Apply final filters to meet the criteria of no recent reconnect/move activities and ensure the account status is active.

### Conclusion

This project demonstrates the ability to integrate and analyze complex datasets to provide actionable insights. By automating the detection of potential tampering based on service disconnects, the project helps in maintaining the integrity of the service network and prevents revenue losses. The detailed and structured approach ensures that all business requirements are met effectively, making this an invaluable tool for utility service providers.

This project showcases my expertise in SQL, data integration, and automated report generation, highlighting my ability to deliver complex data analysis solutions in a business context.
