-- Data Exploration: To start my analysis using SQL in BigQuery, I wanted to explore the data so that I could better understand the data contained in avocado_prices_raw. As an example, I used SELECT DISTINCT to identify all dates stored in the date column. This query allowed me to see that data was collected weekly starting in January 2015 running through March 2018.

SELECT  
  DISTINCT(date)
FROM 
  `avocado-prices-435314.avocado_prices.avocado_prices_raw`
ORDER BY
  date;

-- Data Exploration - Calculating summary statistics: Next, I used the MIN, MAX, and AVG functions on several of the numeric columns contained in the table. I did this to better understand the range of values contained in each column and identify potential outliers in the data.

SELECT
  min(average_price) AS min_price,
  max(average_price) AS max_price,
  avg(average_price) AS avg_price
FROM
  `avocado-prices-435314.avocado_prices.avocado_prices_raw`;

SELECT
  min(total_volume) AS min_volume,
  max(total_volume) AS max_volume,
  avg(total_volume) AS avg_volume
FROM
  `avocado-prices-435314.avocado_prices.avocado_prices_raw`;

-- Data Exploration - Understanding column relationships: As I explored the data in avocado_prices_raw, I wanted to understand relationships between columns in the table. As an example, I was curious to know if total_volume was equal to the sum of plu_4046_sold, plu_4225_sold, and plu_4770_sold. I also wanted to see if total_bags was equal to the sum of the small_bags, large_bags, and xlarge_bags columns. By running the latter query, I determined that total_bags was in fact equal to small_bags, large_bags, and xlarge_bags combined.

SELECT
  total_volume,
  plu_4046_sold + plu_4225_sold + plu_4770_sold AS sum_plu_sold
FROM
  `avocado-prices-435314.avocado_prices.avocado_prices_raw`;

SELECT
  total_bags,
  small_bags + large_bags + xlarge_bags AS sum_bags
FROM
  `avocado-prices-435314.avocado_prices.avocado_prices_raw`;

-- Data Exploration - Understanding proportion of total_volume: After exploring the total_volume and plu_sold columns in the query above, I was curious as to why plu_4046, plu_4225, and plu_4770 were featured in the dataset. In the queries below, I sought to understand what proportion of total_volume was made up of plu_4046, plu_4225, and plu_4770 sales. I discovered that on average, avocados with these three plu values made up just over 59% of total sales or volume.

SELECT
  plu_4046_sold + plu_4225_sold + plu_4770_sold AS sum_plu_sold,
  total_volume,
  ((plu_4046_sold + plu_4225_sold + plu_4770_sold)/total_volume) * 100 AS pct_plu_sold
FROM
  `avocado-prices-435314.avocado_prices.avocado_prices_raw`;

SELECT
  AVG(((plu_4046_sold + plu_4225_sold + plu_4770_sold)/total_volume) * 100) AS avg_pct_plu_sold
FROM
  `avocado-prices-435314.avocado_prices.avocado_prices_raw`;

-- Data Exploration - Grouping data by month to look for seasonality: After exploring the date, average_price, total_volume, and total_bags columns, I wondered if the data indicated any seasonality in average price or quantity of avocados sold. Looking at the resulting data, there appeared to be seasonal trends across all columns so this finding provided me with something to drill into for my analysis. I also uncovered a necessary data transformation as I needed to convert the integer values in the month column to string values that displayed the month name (e.g. 'January', 'February').

SELECT
  EXTRACT(MONTH FROM date) AS month,
  avg(average_price) AS avg_price,
  avg(total_volume) AS avg_volume,
  avg(total_bags) AS avg_bags
FROM
  `avocado-prices-435314.avocado_prices.avocado_prices_raw`
GROUP BY
  month
ORDER BY
  month;

-- Data Exploration - Exploring remaining columns: To wrap up my exploration of the data, I queried the remaining columns so that I could better understand the data contained in them. I used SELECT DISTINCT to identify the distinct values in the type, year, and region columns. As expected, I found that the year column contained 2015, 2016, 2017, and 2018 which was consistent with the date range found in the date column. I also discovered that an additional data transformation would be required, as several values in the region column combined multiple cities into one string (e.g. 'BaltimoreWashington', 'BuffaloRochester', etc.)

SELECT DISTINCT
  type
FROM
  `avocado-prices-435314.avocado_prices.avocado_prices_raw`;

SELECT DISTINCT
  year
FROM
  `avocado-prices-435314.avocado_prices.avocado_prices_raw`;

SELECT DISTINCT
  region
FROM
  `avocado-prices-435314.avocado_prices.avocado_prices_raw`;

-- Create table avocado_prices_stage: After exploring the data contained in avocado_prices_raw and identifying several required data transformations, I created a new table named avocado_prices_stage that could accommodate additional columns and transformed data values.

CREATE TABLE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage` AS (
    SELECT
      *
    FROM
      `avocado-prices-435314.avocado_prices.avocado_prices_raw`
  );

-- Data transformation - Extracting months from the date column: In order to analyze the data for seasonality, I needed to extract months from the date column. I did this by creating the month_integer column and by using the EXTRACT statement to extract months from the date column in avocado_prices_stage. I created month_integer because BigQuery extracted months using an integer data type. I then used a series of UPDATE statements to populate the month column with string values based on the integer values captured in month_integer.

ALTER TABLE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
ADD COLUMN
  month STRING;

ALTER TABLE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
ADD COLUMN
  month_integer INTEGER;

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  month_integer = EXTRACT(MONTH FROM date)
WHERE
  date IS NOT NULL;

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  month = "January"
WHERE
  month_integer = 1;

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  month = "February"
WHERE
  month_integer = 2;

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  month = "March"
WHERE
  month_integer = 3;

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  month = "April"
WHERE
  month_integer = 4;

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  month = "May"
WHERE
  month_integer = 5;

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  month = "June"
WHERE
  month_integer = 6;

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  month = "July"
WHERE
  month_integer = 7;

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  month = "August"
WHERE
  month_integer = 8;

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  month = "September"
WHERE
  month_integer = 9;

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  month = "October"
WHERE
  month_integer = 10;

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  month = "November"
WHERE
  month_integer = 11;

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  month = "December"
WHERE
  month_integer = 12;

-- Data transformation - Updating strings in the type column: Next, I wanted to update the 'conventional' and 'organic' strings in the type column to be in title case. To do this, I used the same UPDATE, SET, WHERE statements that I used to update the month column with string values.

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  type = "Conventional"
WHERE
  type = 'conventional';

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  type = "Organic"
WHERE
  type = 'organic';

-- Data transformation - Updating strings in the region column: To finish transforming the data, I needed to update the strings in the region column so that regions containing multiple cities had a space between the city names. Similarly, there were some regions containing multiple words that were combined into a single word in the region column such as 'Northern New England'. I transformed these strings so that they were formatted in a way that would look better in a presentation or visualization.

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  region = "Baltimore - Washington D.C."
WHERE
  region = 'BaltimoreWashington';

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  region = "Buffalo - Rochester"
WHERE
  region = 'BuffaloRochester';

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  region = "Cincinnati - Dayton"
WHERE
  region = 'CincinnatiDayton';

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  region = "Dallas - Fort Worth"
WHERE
  region = 'DallasFtWorth';

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  region = "Grand Rapids"
WHERE
  region = 'GrandRapids';

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  region = "Great Lakes"
WHERE
  region = 'GreatLakes';

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  region = "Harrisburg - Scranton"
WHERE
  region = 'HarrisburgScranton';

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  region = "Hartford - Springfield"
WHERE
  region = 'HartfordSpringfield';

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  region = "Las Vegas"
WHERE
  region = 'LasVegas';

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  region = "Los Angeles"
WHERE
  region = 'LosAngeles';

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  region = "Miami - Fort Lauderdale"
WHERE
  region = 'MiamiFtLauderdale';

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  region = "Mid South"
WHERE
  region = 'Midsouth';

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  region = "New Orleans - Mobile"
WHERE
  region = 'NewOrleansMobile';

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  region = "New York"
WHERE
  region = 'NewYork';

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  region = "North East"
WHERE
  region = 'Northeast';

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  region = "Northern New England"
WHERE
  region = 'NorthernNewEngland';

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  region = "Phoenix - Tucson"
WHERE
  region = 'PhoenixTucson';

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  region = "Raleigh - Greensboro"
WHERE
  region = 'RaleighGreensboro';

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  region = "Richmond - Norfolk"
WHERE
  region = 'RichmondNorfolk';

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  region = "San Diego"
WHERE
  region = 'SanDiego';

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  region = "San Francisco"
WHERE
  region = 'SanFrancisco';

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  region = "South Carolina"
WHERE
  region = 'SouthCarolina';

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  region = "South Central"
WHERE
  region = 'SouthCentral';

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  region = "South East"
WHERE
  region = 'Southeast';

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  region = "St. Louis"
WHERE
  region = 'StLouis';

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  region = "Total US"
WHERE
  region = 'TotalUS';

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  region = "West Texas - New Mexico"
WHERE
  region = 'WestTexNewMexico';

-- Data exploration - Exploring Total US region: While I was cleaning the strings in the region column, I noticed that there was a 'Total US' region listed. I wanted to see if the 'Total US' region aggregated all data from the other regions contained in the column. To validate this, I calculated the sum of the total_volume and total_bags columns for all regions that were not equal to 'Total US' and compared it to total_volume and total_bags for the 'Total US' region. After running the two queries listed below, I found that the sum of all 'Total US' rows did not equal the sum of non-Total US rows.

SELECT
  SUM(total_volume) AS volume_total_us,
  SUM(total_bags) AS bags_total_us
FROM
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
WHERE
  region = 'Total US';

SELECT
  SUM(total_volume) AS total_volume_other,
  SUM(total_bags) AS total_bags_other
FROM
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
WHERE
  region <> 'Total US';

-- Create table avocado_prices_stage: Now that the data was transformed for analysis in Tableau, I created a target table named avocado_prices_final. Then, I downloaded the data contained in avocado_prices_final so that I could connect to the csv file using Tableau.

CREATE TABLE
  `avocado-prices-435314.avocado_prices.avocado_prices_final` AS (
    SELECT
      id,
      date,
      month,
      year,
      average_price,
      total_volume,
      plu_4046_sold,
      plu_4225_sold,
      plu_4770_sold,
      total_bags,
      small_bags,
      large_bags,
      xlarge_bags,
      type,
      region
    FROM
      `avocado-prices-435314.avocado_prices.avocado_prices_stage`
  );

SELECT
  *
FROM
  `avocado-prices-435314.avocado_prices.avocado_prices_final`;

-- Data transformation - Grouping by metropolitan area or region: After I connected to the data in Tableau, I realized that the region column contained a combination of metropolitan areas and regions. I wanted to differentiate between the two, because the values in the total_volume and total_bags columns were significantly higher in what would be considered regions (e.g. Great Lakes, Mid South, etc.) compared to metropolitan areas. To differentiate the two, I created a new column in avocado_prices_stage named metropolitan_region. With the metropolitan_region column created, I used UPDATE, SET, and WHERE statements to populate the column with either 'Metropolitan Area' or 'Region'.

ALTER TABLE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
ADD COLUMN
  metropolitan_region STRING;

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  metropolitan_region = 'Region'
WHERE
  region IN ('California', 'Great Lakes', 'Mid South', 'North East', 'Northern New England', 'Plains', 'South Central', 'South East');

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_stage`
SET
  metropolitan_region = 'Metropolitan Area'
WHERE
  metropolitan_region IS NULL;

-- Updating avocado_prices_final: After adding the metropolitan_region column to avocado_prices_stage, I needed to update avocado_prices_final so that it included this data. To do this, I repeated the same queries as above but in the avocado_prices_final table.

ALTER TABLE
  `avocado-prices-435314.avocado_prices.avocado_prices_final`
ADD COLUMN
  metropolitan_region STRING;

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_final`
SET
  metropolitan_region = 'Region'
WHERE
  region IN ('California', 'Great Lakes', 'Mid South', 'North East', 'Northern New England', 'Plains', 'South Central', 'South East');

UPDATE
  `avocado-prices-435314.avocado_prices.avocado_prices_final`
SET
  metropolitan_region = 'Metropolitan Area'
WHERE
  metropolitan_region IS NULL;

-- Creating final data extracts for analysis in Tableau: With my final data transformation completed, it was time to export the data from avocado_prices_final so that it could be used for analysis in Tableau. I also created two new tables named metropolitan_area_final and region_final. These tables contained subsets of the dataset filtered by the values in the metropolitan_region column. I thought that filtering for 'Metropolitan Area' and 'Region' could allow for easier analysis in Tableau if I wanted to have a more granular view of the data.

SELECT
  *
FROM
  `avocado-prices-435314.avocado_prices.avocado_prices_final`;

CREATE TABLE
  `avocado-prices-435314.avocado_prices.metropolitan_area_final` AS (
    SELECT
      *
    FROM
      `avocado-prices-435314.avocado_prices.avocado_prices_final`
    WHERE
      metropolitan_region = 'Metropolitan Area'
  );

CREATE TABLE
  `avocado-prices-435314.avocado_prices.region_final` AS (
    SELECT
      *
    FROM
      `avocado-prices-435314.avocado_prices.avocado_prices_final`
    WHERE
      metropolitan_region = 'Region'
  );

SELECT
  *
FROM
  `avocado-prices-435314.avocado_prices.metropolitan_area_final`;

SELECT
  *
FROM
  `avocado-prices-435314.avocado_prices.region_final`;