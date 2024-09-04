# Titanic Survivor Analysis

## Summary
For this project, I analyzed a dataset containing information about passengers on the Titanic. My objective was to identify characteristics in the data that were shared by passengers who survived. 

To perform my analysis, I carried out the steps listed below.

### Step One: Acquiring the dataset
My analysis was based on the [Titanic Dataset](https://www.kaggle.com/datasets/yasserh/titanic-dataset) on Kaggle. I downloaded [Titanic-Dataset.csv](https://github.com/andycreagan/data_analytics_portfolio/blob/main/Titanic%20Survivor%20Analysis/data/Titanic-Dataset.csv) so that the data could be loaded into BigQuery.

### Step Two: Loading data into BigQuery
To explore the data using SQL, I created a dataset and table in BigQuery named titanic. I loaded the data contained in Titanic-Dataset.csv into the titanic table.

### Step Three: Data exploration
In order to identify areas where I could focus my analysis, I wrote several SQL queries that allowed me to better understand data quality, key columns in the dataset, and required data transformations. These queries as well as the queries used in the following steps are documented in [titanic_queries_with_comments.sql](https://github.com/andycreagan/data_analytics_portfolio/blob/main/Titanic%20Survivor%20Analysis/titanic_queries_with_comments.sql).

### Step Four: Data transformation
Next, I created a table named titanic_stage so that I could have a table that could be used for data transformations. Many of these transformations converted values from the original dataset into updated text strings. As an example, I transformed the 1 and 0 values in the passenger_survived column into either 'Survived' or 'Deceased'. All of the transformations and their corresponding code are documented in the sql file.

After the additional columns and transformed data values were added into titanic_stage, I created another table named titanic_final that was used as a target table for creating visualizations in Tableau. I exported the data from titanic_final in [titanic_final.csv](https://github.com/andycreagan/data_analytics_portfolio/blob/main/Titanic%20Survivor%20Analysis/data/titanic_final.csv).

### Step Five: Creating data visualizations in Tableau
Once the data was connected to Tableau, I created several visualizations that outlined trends between the attributes in the data and the groups of passengers who survived or were deceased. These visualizations are captured in [Titanic Survivor Analysis.pdf](https://github.com/andycreagan/data_analytics_portfolio/blob/main/Titanic%20Survivor%20Analysis/Titanic%20Survivor%20Analysis.pdf) and the [presentation linked on Tableau Public](https://public.tableau.com/app/profile/andy.creagan/viz/TitanicSurvivorAnalysis_17253842939940/TitanicSurvivorAnalysis).
