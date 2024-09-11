# Avocado Price Analysis

## Summary

### Step One: Acquiring the dataset
I completed my analysis using the [Avocado Prices dataset](https://www.kaggle.com/datasets/neuromusic/avocado-prices) on Kaggle. I downloaded [avocado.csv](https://github.com/andycreagan/data_analytics_portfolio/blob/main/Avocado%20Price%20Analysis/data/avocado.csv) so that the data could be loaded into BigQuery.

### Step Two: Loading data into BigQuery
Prior to loading the data into BigQuery, I updated several column names from the original data. First, I named the first column id, as there was no column name in the original csv file. Then I renamed the 4046, 4225, and 4770 columns to plu_4046_sold, plu_4225_sold, and plu_4770_sold. I thought that the updated column names did a better job of indicating what data was contained in these columns and they prevented column names from starting with numeric characters. The csv file containing the updated column names was [avocado_copy.csv](https://github.com/andycreagan/data_analytics_portfolio/blob/main/Avocado%20Price%20Analysis/data/avocado_copy.csv) and it contained the data I loaded into BigQuery.

In BigQuery, I created a dataset named avocado_prices and loaded the data into a table named avocado_prices_raw.

### Step Three: Data exploration
