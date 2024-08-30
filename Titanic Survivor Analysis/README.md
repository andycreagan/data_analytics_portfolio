# Titanic Survivor Analysis

## Summary
For this project, I wanted to analyze a dataset containing information about passengers of the Titanic. My objective was to identify traits or characteristics that were captured in the data that may have made certain passengers more likely to survive than others. In order to complete my analysis, I downloaded a dataset from Kaggle, loaded the dataset into BigQuery for data exploration and transformation using SQL, and created data visualizations in Tableau. In the upcoming sections of this README, I will dive into more detail regarding each step taken in this project.

### Step One: Acquiring the dataset
To start the project, I downloaded the [Titanic Dataset from Kaggle](https://www.kaggle.com/datasets/yasserh/titanic-dataset) in csv format.

### Step Two: Loading data into BigQuery
In order to explore the data, I created a new dataset in BigQuery. I created a table named titanic_raw which is where I loaded the data contained in the csv file.

### Step Three: Data transformation
Next, I created a staging table named titanic_stage where I created several new columns to support data transformations. My SQL code used to create the columns and transform the data are detailed in the .sql file in the repo.

Once the staging table contained the updated columns and transformed data, I created a target table named titanic_final. I exported the data contained in the target table in csv format so that the data could be connected to Tableau.

### Step Four: Creating data visualizations in Tableau
In order to have my visualizations make sense of the data, I compared each attribute in the data across passengers that survived and passengers that died when the Titanic sank.

My analysis found meaningful relationships between several attributes and the different passenger groups. The insights garnered from my visualizations are captured in the .pdf file in the repo.
