SELECT *
FROM covid_deaths
Order by 3,4


--SELECT *
--FROM CovidVaccinations
--Order by 3,4

select location, 
       date, 
	   population, 
	   total_cases, 
	   new_cases, 
	   total_deaths, 
	   population
from covid_deaths
Where continent is not null
order by 1,2

---Looking into total_cases vs total_deaths

Select location,
       sum(total_cases) as total_cases,
       sum(total_deaths) as total_deaths,
from covid_deaths
group by 1
order by 1

--- Looking into the total deaths percentage

select location, 
       date, 
	   total_cases, 
	   total_deaths, 
	   (total_deaths/total_cases) * 100 as percentage_of_deaths
from covid_deaths
where location = 'Bangladesh'
order by 1,2

--- total_cases vs populations
--- Percentage of population who got covid

select location, 
       date, 
	   population, 
	   total_cases, 
	   (total_cases/population) * 100 as totalcases_percentage
from covid_deaths
where location like '%Kingdom%'
order by 1,2

--Countries with highest percentage of total cases
select location,
       population,
	   MAX(total_cases) as HighestCovidCount,  
	   (MAX(total_cases)/population) * 100 as totalcases_percentage
from covid_deaths
Group by location,population
HAVING (MAX(total_cases) / population) * 100 IS NOT NULL
order by totalcases_percentage desc

--Countries with highest percentage of death cases
select location,
       population,
	   total_cases,
	   MAX(total_deaths) as HighestCovidDeath,  
	   (MAX(total_deaths)/total_cases) * 100 as totaldeaths_percentage
from covid_deaths
Group by location,population, total_cases
HAVING (MAX(total_deaths) /total_cases) * 100 IS NOT NULL
order by totaldeaths_percentage desc

--Showing countries with highest death per population
select location,  
	   population,  
	   Max(total_deaths) as maximum_deaths,
	   Max((total_deaths/population)) * 100 as highest_death_per_population
from covid_deaths
where continent is not null
Group by location,  
	   population
Having Max((total_deaths/population)) * 100 IS NOT NULL
Order by 4 desc

----
select continent,   
	   Max(total_deaths) as maximum_deaths
from covid_deaths
where continent is not null
group by 1
order by maximum_deaths desc

---- Show the continents with highest death count
select continent,   
	   Max(total_deaths) as maximum_deaths
from covid_deaths
where continent is not null
group by 1
order by maximum_deaths desc

--Show the continents and location with highest death count
select continent,
       location,
	   Max(total_deaths) as maximum_deaths
from covid_deaths
where continent is not null
group by 1,2
Having Max(total_deaths) is not null
order by 1,3 desc

--Global Numbers by date
select date, 
	   sum(new_cases) AS total_cases, 
	   sum(total_deaths) AS total_deaths,
	   (sum(total_deaths)/ sum(new_cases)) * 100 AS Death_Percentage
from covid_deaths
--Where continent is not null
group by date
having sum(new_cases) <> 0
order by 1

--Global total cases
select  
	   sum(new_cases) AS total_cases, 
	   sum(total_deaths) AS total_deaths,
	   (sum(total_deaths)/ sum(new_cases)) * 100 AS Death_Percentage
from covid_deaths
--Where continent is not null
--group by date
having sum(new_cases) <> 0
order by 1 desc

-- Vaccination Table
SELECT * 
FROM CovidVaccinations

--Looking at Location VS Vaccination

Select deaths.continent, deaths.location, deaths.date, deaths.population, deaths.new_cases, deaths.new_deaths,
sum(deaths.new_deaths) Over (Partition BY deaths.location ORDER BY deaths.date) AS deaths_locations,
vaccine.new_vaccinations,
sum(vaccine.new_vaccinations) Over (Partition BY deaths.location ORDER BY deaths.date) AS vaccinations_locations
From covid_deaths deaths
Join CovidVaccinations vaccine
on
deaths.location = vaccine.location
AND
deaths.date = vaccine.date
Where deaths.continent is not null
Order by 2,3

--Population VS Vaccination
With popvsvacc (continent, location, date, population, new_vaccination, rollingPeopleVaccinations)
AS(
Select deaths.continent, deaths.location, deaths.date, deaths.population,
vaccine.new_vaccinations, sum(vaccine.new_vaccinations) Over (Partition BY deaths.location ORDER BY deaths.date) AS vaccinations_locations
From covid_deaths deaths
Join CovidVaccinations vaccine
on
deaths.location = vaccine.location
AND
deaths.date = vaccine.date
Where deaths.continent is not null
--Order by 2,3
)

Select *, (rollingPeopleVaccinations/population) * 100 AS VaccinatedPercentage
From
popvsvacc