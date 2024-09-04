-- Data Exploration - Checking for data quality: After creating the titanic dataset and titanic table, I explored the data for null values in the age, cabin, and port columns.

SELECT
  COUNT(*)
FROM 
  `titanic-433918.titanic.titanic`
WHERE
  age IS NULL;

SELECT
  COUNT(*)
FROM 
  `titanic-433918.titanic.titanic`
WHERE
  cabin IS NULL;

SELECT
  COUNT(*)
FROM 
  `titanic-433918.titanic.titanic`
WHERE
  port IS NULL;

-- Data Exploration: After analyzing the data for nulls, I began exploring each column in the titanic table to better understand where I could focus my analysis. The queries below focus on the passenger_survived, gender, passenger_class, age, siblings_spouses, parents_children, fare, and port columns. I realized that the passenger_survived column would be key to my analysis as it would allow me to identify deceased passengers and survivors. Survivors are represented by 1 while deceased passengers have a 0 value in the passenger_survived column. This data exploration also gave me an idea of what data transformations would be necessary later in my analysis.  Some of these transformations included converting the 1 and 0 values in passenger_survived into string values that more clearly communicated whether a passenger survived or died, and transforming the values in the port column so that they contained the full name of the port in a string as opposed to C, Q, or S.

SELECT
  COUNT(*)
FROM 
  `titanic-433918.titanic.titanic`
WHERE
  passenger_survived = 1;

SELECT
  COUNT(*)
FROM 
  `titanic-433918.titanic.titanic`
WHERE
  passenger_survived = 0;

SELECT
  COUNT(*)
FROM 
  `titanic-433918.titanic.titanic`
WHERE
  gender = 'female';

SELECT
  COUNT(*)
FROM 
  `titanic-433918.titanic.titanic`
WHERE
  gender = 'male';

SELECT
  COUNT(*)
FROM 
  `titanic-433918.titanic.titanic`
WHERE
  passenger_survived = 1
AND
  gender = 'female';

SELECT
  COUNT(*)
FROM 
  `titanic-433918.titanic.titanic`
WHERE
  passenger_survived = 1
AND
  gender = 'male';

SELECT
  COUNT(*)
FROM 
  `titanic-433918.titanic.titanic`
WHERE
  passenger_class = 1;

SELECT
  COUNT(*)
FROM 
  `titanic-433918.titanic.titanic`
WHERE
  passenger_class = 2;

SELECT
  COUNT(*)
FROM 
  `titanic-433918.titanic.titanic`
WHERE
  passenger_class = 3;

SELECT
  COUNT(*)
FROM 
  `titanic-433918.titanic.titanic`
WHERE
  passenger_survived = 1
AND
  passenger_class = 1;

SELECT
  COUNT(*)
FROM 
  `titanic-433918.titanic.titanic`
WHERE
  passenger_survived = 1
AND
  passenger_class = 2;

SELECT
  COUNT(*)
FROM 
  `titanic-433918.titanic.titanic`
WHERE
  passenger_survived = 1
AND
  passenger_class = 3;

SELECT
  min(age) AS min_age,
  max(age) AS max_age,
  avg(age) AS mean_age
FROM 
  `titanic-433918.titanic.titanic`;

SELECT
  min(age) AS min_age,
  max(age) AS max_age,
  avg(age) AS mean_age
FROM 
  `titanic-433918.titanic.titanic`
WHERE
  passenger_survived = 1;

SELECT
  COUNT(*)
FROM 
  `titanic-433918.titanic.titanic`
WHERE
  siblings_spouses >= 1;

SELECT
  COUNT(*)
FROM 
  `titanic-433918.titanic.titanic`
WHERE
  siblings_spouses = 0;

SELECT
  COUNT(*)
FROM 
  `titanic-433918.titanic.titanic`
WHERE
  siblings_spouses >= 1
AND
  passenger_survived = 1;

SELECT
  COUNT(*)
FROM 
  `titanic-433918.titanic.titanic`
WHERE
  parents_children >= 1;

SELECT
  COUNT(*)
FROM 
  `titanic-433918.titanic.titanic`
WHERE
  parents_children = 0;

SELECT
  COUNT(*)
FROM 
  `titanic-433918.titanic.titanic`
WHERE
  parents_children >= 1
AND
  passenger_survived = 1;

SELECT
  min(fare) AS min_fare,
  max(fare) AS max_fare,
  avg(fare) AS mean_fare
FROM 
  `titanic-433918.titanic.titanic`

SELECT
  min(fare) AS min_fare,
  max(fare) AS max_fare,
  avg(fare) AS mean_fare
FROM 
  `titanic-433918.titanic.titanic`
WHERE
  passenger_survived = 1;

SELECT
  COUNT(*)
FROM 
  `titanic-433918.titanic.titanic`
WHERE
  port = 'C';

SELECT
  COUNT(*)
FROM 
  `titanic-433918.titanic.titanic`
WHERE
  port = 'Q';

SELECT
  COUNT(*)
FROM 
  `titanic-433918.titanic.titanic`
WHERE
  port = 'S';

SELECT
  COUNT(*)
FROM 
  `titanic-433918.titanic.titanic`
WHERE
  port = 'C'
AND
  passenger_survived = 1;

SELECT
  COUNT(*)
FROM 
  `titanic-433918.titanic.titanic`
WHERE
  port = 'C'
AND
  passenger_survived = 0;

SELECT
  COUNT(*)
FROM 
  `titanic-433918.titanic.titanic`
WHERE
  port = 'Q'
AND
  passenger_survived = 1;

SELECT
  COUNT(*)
FROM 
  `titanic-433918.titanic.titanic`
WHERE
  port = 'Q'
AND
  passenger_survived = 0;

SELECT
  COUNT(*)
FROM 
  `titanic-433918.titanic.titanic`
WHERE
  port = 'S'
AND
  passenger_survived = 1;

SELECT
  COUNT(*)
FROM 
  `titanic-433918.titanic.titanic`
WHERE
  port = 'S'
AND
  passenger_survived = 0;

-- Renaming titanic table to titanic_raw: After exploring the data and realizing that data transformations were necessary, I renamed the titanic table to titanic_raw. This allowed me to differentiate between the different tables contained in the titanic dataset.

ALTER TABLE
  titanic-433918.titanic.titanic
RENAME TO
  titanic_raw;

-- Creating titanic_stage table: In order to perform the necessary data transformations, I created the titanic_stage table using the titanic_raw table as a baseline.

CREATE TABLE
  titanic-433918.titanic.titanic_stage
AS
  SELECT
    *
  FROM
    titanic-433918.titanic.titanic_raw;

-- Adding the passenger_survived_new column to titanic_stage: The first data transformation that I wanted to perform was converting the values in the passenger_survived column from integers into string values. To do this, I created the passenger_survived_new column that would denote whether a passenger survived or was deceased.

ALTER TABLE
  titanic-433918.titanic.titanic_stage
ADD COLUMN
  passenger_survived_new string;

-- Data Transformation (passenger_survived_new): Now that the passenger_survived_new column was created in the titanic_stage table, I needed to populate the column with 'Survived' and 'Deceased' values. To do so, I used UPDATE, SET, and WHERE statements. After this query ran, the passenger_survived_new column contained either 'Survived' or 'Deceased'.

UPDATE
  titanic-433918.titanic.titanic_stage
SET
  passenger_survived_new = 'Survived'
WHERE
  passenger_survived = 1;

UPDATE
  titanic-433918.titanic.titanic_stage
SET
  passenger_survived_new = 'Deceased'
WHERE
  passenger_survived = 0;

-- Adding the passenger_survived_new column to titanic_stage: The next transformation that I wanted to perform was converting the 'C', 'Q', and 'S' values in the port column to 'Cherbourg', 'Queenstown', or 'Southampton'. To accomplish this, I added another column to the titanic_stage table named port_name.

ALTER TABLE
  titanic-433918.titanic.titanic_stage
ADD COLUMN
  port_name STRING;

-- Data Transformation (port_name): I populated the port_name column in titanic_stage with the updated string values using the UPDATE, SET, and WHERE statements that were used while updating the passenger_survived_new column. Now the port_name column only included values that were either 'Cherbourg', 'Queenstown', or 'Southampton'.

UPDATE
  titanic-433918.titanic.titanic_stage
SET
  port_name = 'Cherbourg'
WHERE
  port = 'C';

UPDATE
  titanic-433918.titanic.titanic_stage
SET
  port_name = 'Queenstown'
WHERE
  port = 'Q';

UPDATE
  titanic-433918.titanic.titanic_stage
SET
  port_name = 'Southampton'
WHERE
  port = 'S';

-- Adding the gender_new column to titanic_stage: The next column that I added to titanic_stage was the gender_new column. The gender_new column would contain 'Female' or 'Male' values that would be converted from the original lowercase strings contained in the titanic_raw table ('C', 'Q', or 'S').

ALTER TABLE 
  titanic-433918.titanic.titanic_stage
ADD COLUMN
  gender_new string;

-- Data Transformation (gender_new): Once again, I transformed the data in the same way that I updated the passenger_survived_new and port_name columns. Now the gender_new column listed string values of either 'Female' or 'Male'.

UPDATE
  titanic-433918.titanic.titanic_stage
SET
  gender_new = 'Female'
WHERE
  gender = 'female';

UPDATE
  titanic-433918.titanic.titanic_stage
SET
  gender_new = 'Male'
WHERE
  gender = 'male';

-- Creating titanic_final table: At this point, I thought that the data contained in titanic_stage was ready for analysis in Tableau. I created a new table named titanic_final so that it could serve as the target table used for creating visualizations in Tableau.

CREATE TABLE 
  titanic-433918.titanic.titanic_final AS
  SELECT
    passenger_id,
    passenger_survived_new AS passenger_survived,
    passenger_class,
    name,
    gender_new AS gender,
    age,
    siblings_spouses,
    parents_children,
    ticket_number,
    fare,
    cabin,
    port_name AS port
  FROM
    titanic-433918.titanic.titanic_stage;

-- Adding the family_onboard column to titanic_stage: At this point, I realized that I had ignored the siblings_spouses and parents_children columns in titanic_raw. I thought that combining these columns together could make for an interesting analysis to see whether passengers with family members onboard had a higher survival rate than those who did not. To accomplish this, I created the family_onboard column in titanic_stage.

ALTER TABLE
  `titanic-433918.titanic.titanic_stage`
ADD COLUMN
  family_onboard STRING;

-- Data Transformation (family_onboard): In order to populate the family_onboard column in titanic_stage, I used the logic shown below. Essentially, if a given passenger had one or more siblings, spouses, parents, or children onboard with them, the family_onboard column would reflect a 'Yes' string value. If a passenger had zero siblings, spouses, parents, or children onboard, they would be represented with a 'No' string in the family_onboard column.

UPDATE
  titanic-433918.titanic.titanic_stage
SET
  family_onboard = 'Yes'
WHERE
  siblings_spouses + parents_children > 0;

UPDATE
  titanic-433918.titanic.titanic_stage
SET
  family_onboard = 'No'
WHERE
  siblings_spouses + parents_children = 0;

-- Adding the family_onboard column to titanic_final: In order to prepare the titanic_final table for analysis in Tableau, I added the family_onboard column so that I could capture the 'Yes' and 'No' string values created in the previous step.

ALTER TABLE
  `titanic-433918.titanic.titanic_final`
ADD COLUMN
  family_onboard STRING;

-- Data Transformation (family_onboard): I used identical logic when populating the family_onboard column in the titanic_final table. Now that the titanic_final table contained all of the necessary data, it was ready to be exported into a csv file.

UPDATE
  titanic-433918.titanic.titanic_final
SET
  family_onboard = 'Yes'
WHERE
  siblings_spouses + parents_children > 0;

UPDATE
  titanic-433918.titanic.titanic_final
SET
  family_onboard = 'No'
WHERE
  siblings_spouses + parents_children = 0;

-- Creating target table for analysis in Tableau: The final step that I performed using SQL was exporting the data from titanic_final into a csv file. I ordered the passenger_id column in ascending order for readability purposes.

SELECT
  *
FROM
  titanic-433918.titanic.titanic_final
ORDER BY
  passenger_id;