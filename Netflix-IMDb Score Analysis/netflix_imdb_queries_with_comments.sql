-- Data Exploration - Checking for data quality: I began my exploration of the dataset by counting the number of null values in each column of the netflix_imdb_scores_raw table. Since a runtime of zero would indicate a data quality issue, I queried the table to show a count of movies and shows with a 0 value in the runtime column.

SELECT
  COUNT(*)
FROM 
  `netflix-imdb-scores.netflix_imdb_scores.netflix_imdb_scores_raw`
WHERE
  description IS NULL;

SELECT
  COUNT(*)
FROM 
  `netflix-imdb-scores.netflix_imdb_scores.netflix_imdb_scores_raw`
WHERE
  release_year IS NULL;

SELECT
  COUNT(*)
FROM 
  `netflix-imdb-scores.netflix_imdb_scores.netflix_imdb_scores_raw`
WHERE
  age_certification IS NULL;

SELECT
  COUNT(*)
FROM 
  `netflix-imdb-scores.netflix_imdb_scores.netflix_imdb_scores_raw`
WHERE
  runtime = 0;

SELECT
  COUNT(*)
FROM 
  `netflix-imdb-scores.netflix_imdb_scores.netflix_imdb_scores_raw`
WHERE
  imdb_score IS NULL;

SELECT
  COUNT(*)
FROM 
  `netflix-imdb-scores.netflix_imdb_scores.netflix_imdb_scores_raw`
WHERE
  imdb_votes IS NULL;

-- Data Exploration - Querying columns to better understand the data: Next, I performed several queries to better understand the data values stored in each column. By using SELECT DISTINCT on the type column, I discovered that there were two values in this column: "SHOW" and "MOVIE". I also used SELECT DISTINCT to identify all age certifications in the dataset. I found that movies and shows had different age certifications associated with them.

SELECT
  DISTINCT(type)
FROM 
  `netflix-imdb-scores.netflix_imdb_scores.netflix_imdb_scores_raw`;

SELECT
  DISTINCT(age_certification)
FROM 
  `netflix-imdb-scores.netflix_imdb_scores.netflix_imdb_scores_raw`;

SELECT
  DISTINCT(age_certification)
FROM 
  `netflix-imdb-scores.netflix_imdb_scores.netflix_imdb_scores_raw`
WHERE
  type = 'SHOW';

SELECT
  DISTINCT(age_certification)
FROM 
  `netflix-imdb-scores.netflix_imdb_scores.netflix_imdb_scores_raw`
WHERE
  type = 'MOVIE'
ORDER BY
  age_certification;

-- Data Exploration - Summary statistics: Next, I calculated min, max, and avg for the numeric columns in netflix_imdb_scores_raw. This allowed me to see the variance between values in these columns.

SELECT
  min(release_year) AS min_release_year,
  max(release_year) AS max_release_year
FROM 
  `netflix-imdb-scores.netflix_imdb_scores.netflix_imdb_scores_raw`;

SELECT
  avg(release_year)
FROM 
  `netflix-imdb-scores.netflix_imdb_scores.netflix_imdb_scores_raw`;

SELECT
  min(runtime) AS min_runtime,
  max(runtime) AS max_runtime,
  avg(runtime) as avg_runtime
FROM 
  `netflix-imdb-scores.netflix_imdb_scores.netflix_imdb_scores_raw`;

SELECT
  min(imdb_score) AS min_imdb_score,
  max(imdb_score) AS max_imdb_score,
  avg(imdb_score) AS avg_imdb_score
FROM 
  `netflix-imdb-scores.netflix_imdb_scores.netflix_imdb_scores_raw`;

SELECT
  min(imdb_votes) AS min_imdb_votes,
  max(imdb_votes) AS max_imdb_votes,
  avg(imdb_votes) AS avg_imdb_votes
FROM 
  `netflix-imdb-scores.netflix_imdb_scores.netflix_imdb_scores_raw`;

-- Creating netflix_imdb_scores_stage table: In order to transform the values in the type column, I created the netflix_imdb_scores_stage table using the netflix_imdb_scores_raw table as a baseline.

CREATE TABLE 
  netflix-imdb-scores.netflix_imdb_scores.netflix_imdb_scores_stage AS (
  SELECT
    *
  FROM
    netflix-imdb-scores.netflix_imdb_scores.netflix_imdb_scores_raw
  );

-- Data Transformation (type): In the staging table, I transformed the "MOVIE" and "SHOW" strings into "Movie" and "Show".

UPDATE
  netflix-imdb-scores.netflix_imdb_scores.netflix_imdb_scores_stage
SET
  type = 'Movie'
WHERE
  type = 'MOVIE';

UPDATE
  netflix-imdb-scores.netflix_imdb_scores.netflix_imdb_scores_stage
SET
  type = 'Show'
WHERE
  type = 'SHOW';

-- Creating netflix_imdb_scores_final table: Now that I was done exploring and transforming the data, it was time to create a target table that could connect with Tableau. I created the netflix_imdb_scores_final table as the target table that would be used to create visualizations in Tableau.

CREATE TABLE
  netflix-imdb-scores.netflix_imdb_scores.netflix_imdb_scores_final AS (
  SELECT
    *
  FROM
    netflix-imdb-scores.netflix_imdb_scores.netflix_imdb_scores_stage
  );

SELECT  
  *
FROM 
  `netflix-imdb-scores.netflix_imdb_scores.shows_final`
ORDER BY
  index;

-- Creating movies_final and shows_final tables: In order to more easily focus my analysis on just movies or shows, I filtered the data in netflix_imdb_scores_raw by type. This allowed me to create two tables named movies_final and shows_final. I mistakenly created the shows_final table by filtering for movies, so I updated the table to be named movies_final using the ALTER TABLE statement.

CREATE TABLE
  netflix-imdb-scores.netflix_imdb_scores.shows_final AS
  SELECT
    *
  FROM
    netflix-imdb-scores.netflix_imdb_scores.netflix_imdb_scores_raw
  WHERE
    type = 'MOVIE'

ALTER TABLE
  netflix-imdb-scores.netflix_imdb_scores.shows_final
RENAME TO
  movies_final;

CREATE TABLE
  netflix-imdb-scores.netflix_imdb_scores.shows_final AS
  SELECT
    *
  FROM
    netflix-imdb-scores.netflix_imdb_scores.netflix_imdb_scores_raw
  WHERE
    type = 'SHOW';

SELECT  
  *
FROM 
  `netflix-imdb-scores.netflix_imdb_scores.movies_final`
ORDER BY
  index;

SELECT  
  *
FROM 
  `netflix-imdb-scores.netflix_imdb_scores.shows_final`
ORDER BY
  index;