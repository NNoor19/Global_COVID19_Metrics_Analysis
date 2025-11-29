# Global_COVID19_Metrics_Analysis
Project Overview
This repository contains the SQL scripts for a robust Data Exploration (EDA) project focused on analyzing global COVID-19 case, death, and vaccination data. This project serves as a key deliverable for a data analyst portfolio, demonstrating practical application of fundamental and advanced SQL techniques.
The primary goal was to transform raw data into calculated insights, utilizing Joins, Partitioned Window Functions, Common Table Expressions (CTEs), and permanent Views. The resulting structured data is finalized for direct use in the subsequent data visualization stage using Tableau.
Data Source
The analysis utilizes a global dataset encompassing metrics over time. The project imports and analyzes data from two primary tables:
• covid_deaths
• CovidVaccinations
The data used for analysis includes location, date, population, total_cases, new_cases, total_deaths, and new_vaccinations.
Tools and Technologies
• Database Management System (DBMS): PostgreSQL (PgAdmin 4) (This environment was used to execute the scripts and manage the database).
• SQL Environment: SQL.
• Visualization Target: Tableau Public (The final views are prepared for visualization).
Methodology and Data Preparation
The code demonstrates several steps taken to ensure data integrity and query accuracy:
1. Initial Selection and Ordering: Queries begin by selecting essential columns from the covid_deaths table and ordering the results by location and date.
2. Crucial Data Filtering: To focus exclusively on country-level statistics and exclude aggregated data (e.g., 'World' totals), the clause Where continent is not null is consistently applied across several queries.
3. Data Type Handling: The script relies on performing arithmetic on derived columns. While not explicitly cited in the provided sources, the successful execution of sums and percentages implies necessary data type casting or conversion was handled for numeric fields like total_deaths and new_cases.
Key SQL Concepts Demonstrated
The provided SQL script systematically explores the data, showcasing proficiency across various technical areas:
1. Basic Exploratory Calculations
These calculations establish foundational metrics for risk and prevalence:
• Death Percentage: Calculates the percentage of reported cases that resulted in death, demonstrating the likelihood of dying if infected.
    ◦ Formula: (total_deaths/total_cases) * 100.
    ◦ Focus Example: This calculation is shown specifically for the location 'Bangladesh'.
• Percent Population Infected: Determines the percentage of a country's population that has been confirmed to have contracted COVID.
    ◦ Formula: (total_cases/population) * 100.
    ◦ Focus Example: This calculation is shown for locations matching %Kingdom%.
2. Aggregate Analysis and Ranking
The script utilizes aggregate functions (MAX, SUM) with GROUP BY to derive ranking statistics:
• Highest Infection Rate: Identifies countries by their MAX(total_cases) relative to their population, using Group by location, population and ordering the result in descending order by totalcases_percentage. The query includes a HAVING clause to filter out null percentages.
• Highest Death Rate (Case Fatality): Identifies countries with the highest death rate calculated as a percentage of total cases, using (MAX(total_deaths)/total_cases) * 100.
• Highest Death per Population: Identifies countries with the maximum death count relative to their population size, ordering the results in descending order.
• Continental Death Count: Shows the maximum death counts broken down by continent. A more detailed query also groups by both continent and location.
3. Global Statistical Aggregation
The code determines worldwide statistics by aggregating new daily counts:
• Global Daily Numbers: Calculates global totals for sum(new_cases) and sum(total_deaths) grouped by date. It also calculates the resulting Death_Percentage.
• Global Overall Totals: Calculates the total worldwide cases, total deaths, and the overall global death percentage across the entire dataset, requiring the exclusion of rows where sum(new_cases) <> 0.
4. Advanced Data Manipulation and Window Functions
• Table Joins: The covid_deaths and CovidVaccinations tables are joined using a JOIN clause, matching records on both deaths.location = vaccine.location AND deaths.date = vaccine.date.
• Partitioned Window Function: A cumulative sum is performed to calculate the running total of vaccinated people over time:
• The use of Partition BY deaths.location ensures the cumulative sum resets for each country, creating an accurate rollingPeopleVaccinations count.
5. Data Structuring: Common Table Expressions (CTEs)
The project utilizes a CTE to structure complex calculations for final analysis:
• Creating the CTE (popvsvacc): A CTE is established to temporarily store the results of the join and the rolling vaccination calculation.
• Calculating Vaccination Percentage: The subsequent query selects from the CTE to calculate the percentage of the population that has been vaccinated using the derived rolling count:
Conclusion and Future Steps
This script successfully cleans, explores, and structures the COVID-19 data, providing comprehensive analytical results.
The final output of this SQL project—specifically the logic demonstrated within the CTE and final selection—is designed to serve as the data source for the next portfolio installment, which will focus on data visualization in Tableau. The entire SQL file should be committed to this repository to showcase mastery of the detailed techniques outlined above.
The next stage of the portfolio series involves connecting Tableau Public to these extracted datasets to create four core visualizations (Global Numbers, Continental Death Count Bar Chart, Map of Percent Population Infected, and Time Series Line Graph) and combine them into a shareable, interactive dashboard
1. Tableau Setup and Data Import
After completing the SQL project (Project 1), the visualization stage required specific setup steps:
• Software Download: You downloaded and set up Tableau Public.
• Data Limitation: You encountered the limitation that Tableau Public cannot connect directly to a database or SQL server. This necessitated the highly manual but necessary step of exporting your cleaned query results.
• Manual Data Export: You executed the final four queries, and for each result set, you copied the data along with the headers (using ctrl shift c).
• Creating Flat Files: You pasted these four sets of results into separate Excel workbooks, saving them individually as tableau table 1, tableau table 2, tableau table 3, and tableau table 4. The reason for separating them was that they could not all be joined together within one Excel sheet based on common columns like date, continent, or location.
• Importing Data: You then opened Tableau Desktop and imported each of the four separate Excel files as new data sources.
2. Visualization Creation (Sheet by Sheet)
The project focused on creating four specific visualizations and combining them into a simplified, beginner-friendly dashboard.
Sheet 1: Global Numbers (Text Table)
This was the simplest visualization, using data from Tableau Table 1.
• Metrics: It used total cases, total deaths, and the average death percentage.
• Visualization Type: A Text Table was used (Show Me option).
• Formatting Details: You demonstrated how to customize the visual appeal, including adjusting the size and color of the text (marks), applying shading to the headers (columns) and the pane (rows), and adding simple grid lines to separate the figures.
• Accuracy Refinement: Crucially, you adjusted the Death Percentage format to show two decimal places (e.g., 2.11%) instead of rounding to the nearest whole number (2%) by modifying the format within the Measure Values settings, specifically under Numbers > Number Custom.
Sheet 2: Continental Death Count (Bar Chart)
This visualization used data from Tableau Table 2 to compare total deaths across continents.
• Setup: You dragged location (which was renamed to Continent for clarity) to the columns and Total Death Count to the rows.
• Ordering: You manually sorted the visualization in descending order (highest to lowest death count), placing Europe at the top.
• Customization: You demonstrated changing colors (e.g., to an orange palette) and adjusting the size of the bars.
• Axis Editing: You showed how to edit the numerical axis for the death count, demonstrating options for customizing tick marks and scale.
Sheet 3: Percent Population Infected (Map)
This visualization used data from Tableau Table 3 and was considered the project creator's favorite.
• Geographic Role: Since the map options did not automatically open, you had to explicitly assign the location field a Geographic Role of Country/Region. This generated the necessary longitude and latitude fields.
• Map Creation: You placed the generated Longitude on the columns and Latitude on the rows to display the map.
• Color Mapping: You mapped the Percent Population Infected measure to the Color mark, creating a heat map effect showing infection rates by country.
• Background and Style: You used the Outdoors background map style and demonstrated changing the color palette (e.g., using reds/oranges/gold) to convey the 'scary' nature of infection rates.
• Labeling: You showed how to add the location field to the Detail mark, and then optionally to the Label mark, though the creator preferred the cleaner look without the default labels.
• Legend Refinement: You edited the title of the color legend to clarify that it represents the Percent Population Infected per Country, emphasizing that the value is not an aggregate sum.
Sheet 4: Time Series Data (Line Chart)
This visualization used data from Tableau Table 4 to show the progression of the average infection rate over time.
• Initial Setup: You placed Date on the columns to show progression and Percent Population Infected (using the Average aggregation) on the rows.
• Date Granularity: You adjusted the date hierarchy, preferring to view the data by Month rather than by Year or Day for simplicity.
• Breaking by Location: To separate the data, you dragged the Location field to the Color mark, which instantly generated a separate line and color for each country and created a legend.
• Filtering: You filtered the Location field to display only a select few countries (e.g., United States, United Kingdom, Mexico, India, China) to keep the visualization manageable.
• Forecasting (Predictive Analysis): You added a forecast by going to Analysis > Forecast > Show Forecast. This added projected numbers into the future (until March of the following year), relying on at least 12 months of prior data.
3. Dashboard Creation and Sharing
The final step was combining all four sheets onto a single dashboard.
• Dashboard Sizing: You set the dashboard size to Automatic to maximize the display size.
• Layout: You arranged the four sheets (Global Numbers, Continental Deaths, Map, and Time Series) into a coherent visual layout.
• Title Renaming: You ensured the visualizations had clear titles (e.g., renaming Sheet 2 to Total Deaths per Continent).
• Saving and Sharing: The process concluded by saving the finished dashboard to Tableau Public (File > Save to Tableau Public As). This automatically uploads the dashboard to your online account and generates a shareable URL, which is essential for including the project in your portfolio
