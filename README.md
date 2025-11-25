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
