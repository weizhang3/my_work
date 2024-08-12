# **ETL Inventory Updating Pipeline**

## Overview
This project implements a local ETL (Extract, Transform, Load) pipeline to automate the processing and updating of inventory data from various sources, including Shopify, Walmart, Sportsman Warehouse, Tractor Supply, DSCO, and Amazon. The pipeline is designed to extract data from multiple sources, transform the data to ensure consistency and accuracy, and load it into a centralized system for easy management and analysis.

## Project Objectives
- To automate the extraction of order and inventory data from various platforms.
- To transform the data by standardizing formats, handling missing values, and correcting discrepancies.
- To load the cleaned and standardized data into a centralized system for inventory management. The standardized data includes the daily order list, pick list, and order report. (Please see output examples in the Data folder).
- SKU Updating System: Implement a feature that enables manual adding and removing of SKUs with quantities, providing flexibility in case of inventory stockouts.
- To ensure real-time updates to inventory levels based on incoming orders.


## Datasets Overview
The project uses the following datasets:
1. **Shopify Order Data (CSV):** Contains order details from the Shopify platform, including financial status, fulfillment status, customer details, and payment information.
2. **Walmart Order Data (XLSX):** Contains order and shipment details from Walmart, including customer information, order status, and fulfillment details.
3. **Sportsman Warehouse Data (CSV):** Contains detailed records of orders fulfilled through the Sportsman Warehouse, including product SKUs, customer addresses, and order dates. The data is sourced from the DataTrans Solutions EDI platform.
4. **Tractor Supply Data (CSV):** Similar to the Sportsman Warehouse data, includes order records, product details, and shipping information. This data is also sourced from the DataTrans Solutions EDI platform.
5. **Order Form Data (XLSX):** A compiled list of orders, including order numbers, dates, and customer details, used to cross-reference and update the inventory system. This form is designed internally for our external sales representatives.
6. **DSCO Order Data (XLS):** Detailed order information from the DSCO platform, including product details, order quantities, shipping information, and gift messages.
7. **Amazon Order Data (TXT):** Amazon order details, including order IDs, item details, buyer information, and shipping details.

### Handling Different Data Formats and Structures
The datasets in this project come from diverse sources and are in varying formats, presenting unique challenges for data processing:

- **Sportsman Warehouse and Tractor Supply Data:** These datasets are sourced from the DataTrans Solutions EDI platform and are formatted as CSV files. Unlike typical CSVs, they contain structured EDI transaction data with fields specific to order fulfillment, such as line item details, EDI trace numbers, and specific shipping instructions. This structure requires careful parsing and transformation to align with the standardized format used in our centralized system.

- **Order Form Data:** The Order Form is designed internally and provided as an XLSX file. It differs from other datasets in that it is structured to capture orders from external sales representatives in a format tailored for human readability rather than automated processing. This required developing custom parsers to extract the relevant information, transform it into a machine-readable format, and integrate it with other datasets.

- **Other Data Sources:** The other datasets, such as those from Shopify, Walmart, DSCO, and Amazon, each have their unique structures and formats (CSV, XLSX, TXT). The pipeline is designed to handle these variations, ensuring that data is accurately extracted, transformed, and loaded regardless of its original format.

### Data Integration Capabilities
This project highlights my ability to handle various data formats and structures, ensuring that each dataset is appropriately processed and standardized. Whether dealing with EDI transactions, custom-designed order forms, or platform-specific data formats, the ETL pipeline is equipped to manage these complexities. This ensures seamless integration and accurate inventory management across multiple sources and platforms.

## Tools and Libraries Used
- **Python**: Core programming language used for the ETL pipeline.
- **Pandas**: Used for data manipulation and transformation.
- **Openpyxl**: Used for reading and writing Excel files.
- **NumPy**: Utilized for numerical operations and handling missing data.
- **Jupyter Notebook**: Environment for developing and testing the ETL pipeline.

## Project Structure
- **data/**: Contains all the raw datasets used in the project.
- **notebooks/**: Contains the Jupyter Notebook files used to develop and test the ETL pipeline.
- **scripts/**: Contains Python scripts used to automate the ETL process.
- **outputs/**: Contains the final, processed datasets ready for use in inventory management.

## Key Findings
- **Data Consistency**: Ensured consistency across multiple data sources by standardizing SKU formats, handling missing values, and correcting discrepancies in order details.
- **Real-time Inventory Updates**: Successfully automated the real-time updating of inventory levels based on new incoming orders from multiple platforms.
- **Error Handling**: Implemented robust error handling to manage missing or inconsistent data, ensuring the ETL pipeline runs smoothly without interruptions.

## Conclusion
This ETL pipeline provides a streamlined and automated approach to managing inventory data across multiple platforms. By standardizing and centralizing the data, the system ensures accurate and real-time updates to inventory levels, enabling better inventory management and reducing the risk of stockouts or overstocking.

## Future Work
- **Integration with Additional Platforms**: Expand the pipeline to include more e-commerce platforms.
- **Data Visualization**: Develop dashboards to visualize inventory levels and trends over time.
- **Machine Learning Integration**: Implement predictive analytics to forecast inventory needs based on historical order data.
