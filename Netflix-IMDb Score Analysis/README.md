# Netflix-IMDb Score Analysis

## Summary
In this project, I analyzed a dataset containing movies and shows on the streaming platform Netflix. The dataset contained general information about the movies and shows such as their title, release year, and age certification. Several columns in the dataset were from the Internet Movie Database or IMDb website. I was particularly interested in the IMDb scores that were listed in the data, as this information represented audience reviews from people who watched a given movie or show. In this analysis, I was curious to discover which characteristics of a movie or show on Netflix were associated with higher IMDb scores.

To determine what if any attributes in the data were related to movies and shows that scored well on IMDb, I performed the following steps:

### Step One: Acquiring the dataset
To perform this analysis, I used the [Netflix IMDB Scores dataset](https://www.kaggle.com/datasets/thedevastator/netflix-imdb-scores) on Kaggle. The data downloaded as a csv file which I named [Netflix TV Shows and Movies.csv](https://github.com/andycreagan/data_analytics_portfolio/blob/main/Netflix-IMDb%20Score%20Analysis/data/original_dataset/Netflix%20TV%20Shows%20and%20Movies.csv).

### Step Two: Prepping the data
Next, I wanted to load the data into BigQuery so that I could analyze it using SQL. However, I was unable to upload the data, as the raw data contained in the csv file had several movies and shows that were spread over multiple rows in the file. In order to load the data into BigQuery, I cleaned the original csv file by ensuring that each value had all of its data listed on an individual row. The resulting file was named [Netflix TV Shows and Movies_updated.csv](https://github.com/andycreagan/data_analytics_portfolio/blob/main/Netflix-IMDb%20Score%20Analysis/data/original_dataset/Netflix%20TV%20Shows%20and%20Movies_updated.csv), which I was able to load into BigQuery.

### Step Three: Loading data into BigQuery
Now that I had an updated csv file, I was able to load the data into BigQuery. The data was loaded into a table that I named netflix_imdb_scores_raw, and this table was located in a dataset named netflix_imdb_scores.

### Step Four: Data exploration
With the data loaded into the netflix_imdb_scores_raw table, I began exploring the data using SQL. The queries that I used to explore the data as well as all queries related to this project are compiled in [netflix_imdb_queries_with_comments.sql](https://github.com/andycreagan/data_analytics_portfolio/blob/main/Netflix-IMDb%20Score%20Analysis/netflix_imdb_queries_with_comments.sql).

Exploring the data allowed me to identify data quality issues including finding null values and movies and shows with a zero value in the runtime column. I was also able to better understand the columns in the dataset that I would be analyzing in relation to IMDb scores. I  also calculated summary statistics on the data including minimum, maximum, and average to better understand the spread of values within columns with numeric values. Finally, I identified the data transformation I needed to make in order to present the data in the way that I wanted.

### Step Five: Data transformation
Since the dataset was relatively clean, there were not many transformations required. I did however transform the text strings that appeared in the type column, so that the text 'MOVIE' and 'SHOW' was not in all caps. I created a new table named netflix_imdb_scores_stage to support this data transformation. Once this was completed, I created another table named netflix_imdb_scores_final to prep the data for analysis in Tableau. I used the netflix_imdb_scores_final to generate the [shows_and_movies_final.csv](https://github.com/andycreagan/data_analytics_portfolio/blob/main/Netflix-IMDb%20Score%20Analysis/data/final_data/shows_and_movies_final.csv) file which was one of three files that I connected to Tableau.

I created the remaining two files by filtering the data in the netflix_imdb_scores_raw table by type. This resulted in a file that only included data for movies with another separate file that contained all data for shows in the dataset. These files were named [movies_final.csv](https://github.com/andycreagan/data_analytics_portfolio/blob/main/Netflix-IMDb%20Score%20Analysis/data/final_data/movies_final.csv) and [shows_final.csv](https://github.com/andycreagan/data_analytics_portfolio/blob/main/Netflix-IMDb%20Score%20Analysis/data/final_data/shows_final.csv).

### Step Six: Creating data visualizations in Tableau
To complete my analysis, I used Tableau to create data visualizations that measured each of the attributes in the dataset against the IMDb score column. These visualizations are documented in the [presentation linked here](https://github.com/andycreagan/data_analytics_portfolio/blob/main/Netflix-IMDb%20Score%20Analysis/Netflix%20-%20IMDb%20Scores%20Analysis.pdf) and on [Tableau Public](https://public.tableau.com/app/profile/andy.creagan/viz/Netflix-IMDbScoreAnalysis/Netflix-IMDbScoreAnalysis).
