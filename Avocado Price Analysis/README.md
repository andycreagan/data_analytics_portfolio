# Avocado Sales Analysis

## Summary

### Step One: Acquiring the dataset
I completed my analysis using the [Avocado Prices dataset](https://www.kaggle.com/datasets/neuromusic/avocado-prices) on Kaggle. I downloaded [avocado.csv](https://github.com/andycreagan/data_analytics_portfolio/blob/main/Avocado%20Price%20Analysis/data/avocado.csv) so that the data could be loaded into BigQuery.

### Step Two: Loading data into BigQuery
Prior to loading the data into BigQuery, I updated several column names from the original data. First, I named the first column id, as there was no column name in the original csv file. Then I renamed the 4046, 4225, and 4770 columns to plu_4046_sold, plu_4225_sold, and plu_4770_sold. I thought that the updated column names did a better job of indicating what data was contained in these columns and they prevented column names from starting with numeric characters. The csv file containing the updated column names was [avocado_copy.csv](https://github.com/andycreagan/data_analytics_portfolio/blob/main/Avocado%20Price%20Analysis/data/avocado_copy.csv) and it contained the data I loaded into BigQuery.

In BigQuery, I created a dataset named avocado_prices and loaded the data into a table named avocado_prices_raw.

### Step Three: Data exploration
Once data was loaded into avocado_prices_raw, I began to explore the data using SQL queries. The SQL code that I used is documented in [avocado_queries_with_comments.sql](https://github.com/andycreagan/data_analytics_portfolio/blob/main/Avocado%20Price%20Analysis/avocado_queries_with_comments.sql). Exploring the data allowed me to understand the data contained in each column, relationships between columns in the table, and necessary data transformations that would be needed for analysis. Exploring the data also allowed me to understand that there was likely seasonality in avocado sales and prices, which ended up being central to my overall analysis.

### Step Four: Data transformation
After my data exploration was complete, I created a table in BigQuery named avocado_prices_stage, so that I could perform transformations on the data. The SQL queries used to transform the data are contained in the sql file. A critical data transformation extracted months from the date column in the original dataset. When these values were extracted from the date column, they were of the integer data type. This required an additional transformation as I wanted to present months as string values so that they could be more easily interpreted in data visualizations. Once all of my data transformations were complete, I downloaded final extracts ([avocado_final.csv](https://github.com/andycreagan/data_analytics_portfolio/blob/main/Avocado%20Price%20Analysis/data/avocado_final.csv), [metropolitan_area_final.csv](https://github.com/andycreagan/data_analytics_portfolio/blob/main/Avocado%20Price%20Analysis/data/metropolitan_area_final.csv), and [region_final.csv](https://github.com/andycreagan/data_analytics_portfolio/blob/main/Avocado%20Price%20Analysis/data/region_final.csv)) so that I could connect to the files in Tableau to create visualizations of the data.

### Step Five: Creating data visualizations in Tableau
To complete my analysis, I created several data visualizations in Tableau. Using the transformed data, I was able to create visualizations that illustrated the seasonality of avocado prices and avocado sales, sales volume by metropolitan area, and sales volumes of different types and varieties of avocados. I compiled all of these data visualizations into the dashboard which is linked [here](https://public.tableau.com/app/profile/andy.creagan/viz/AvocadoSalesAnalysis/AvocadoSalesAnalysis).
