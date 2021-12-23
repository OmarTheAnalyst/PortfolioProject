select *
from Covid19..CovidDeath
order by 3,4



--quary(1)
select location, date, total_cases, new_cases, total_deaths,  population
from Covid19..CovidDeath
order by 1,2


--MAX_TOTAL_CASES VS MAX_TOTAL_DEATHS IN EACH COUNTRY

select location, MAX(total_cases)as maximum_cases, MAX(total_deaths) as maximum_deaths
from Covid19..CovidDeath
where continent is not null
group by location
order by 2 DESC


--persentage of total_deaths and total_cases
select location, date,total_cases, total_deaths, CONCAT(round((total_deaths/total_cases)*100,1),'%') as DeathPercentage
from Covid19..CovidDeath
where continent is not null
order by 2 DESC


--total_cases and total_death in Egypt (19/12/2021)
select location,MAX(date) as last_date,
MAX(total_cases) as maximum_cases,
MAX(total_deaths) as maximum_deaths
from Covid19..CovidDeath
where location = 'Egypt'
group by location

--total_cases and total_death in Egypt when covid19 is begined till 19/12/2021

select location,date,
total_cases,
total_deaths,
 CONCAT(round((total_deaths/total_cases)*100,1),'%') as DeathPercentage
from Covid19..CovidDeath
where location = 'Egypt'
order by date desc


-- total cases vs populations
-- showing what percentage of population has gotten covid(egypt)
select location,date,
total_cases,
population,
 CONCAT(round((total_cases/population)*100,1),'%') as CasesPercentage
from Covid19..CovidDeath
where location = 'Egypt'
order by date desc

-- Looking at countries with Highest infection Rate compared to population
select location,
max(total_cases) as HightestInfectionCount,
population,
round(MAX((total_cases/population)*100),1) as PercentPopulationInfected
from Covid19..CovidDeath
where continent is not null --and location='egypt'
group by location, population
order by PercentPopulationInfected desc

--Showing Countries with Highest Death Count per Population
select location,
max(cast(total_deaths as int)) as TotalDeathCount
from Covid19..CovidDeath
where continent is not null --and location='egypt'
group by location
order by TotalDeathCount desc

--Showing Continent with Hightest DeathCount

select location,
max(cast(total_deaths as int)) as TotalDeathCount
from Covid19..CovidDeath
where continent is null --and location='egypt'
group by location
order by TotalDeathCount desc



--globel numbers every_day till (19/12/2021)
select date,sum(new_cases) as world_new_cases,
sum(CAST(new_deaths as int)) as world_new_deaths
from Covid19..CovidDeath
where continent is not null
group by date
order by date asc

--showing vaccinations data
select *
from Covid19..CovidVaccinations

--population vs total_people_vaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, vac.people_vaccinated
From Covid19..CovidDeath dea
Join Covid19..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3

-- looking at Total Population Vs Vaccinations
WITH PopvsVac as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(bigint ,vac.new_vaccinations)) OVER (Partition by dea.Location order by dea.location, dea.Date) as RollingPeopleVaccinated --summation of new_vaccinations
--, (RollingPeopleVaccinated/population)*100 we can not use a vailable we have created into anoter operations  
From Covid19..CovidDeath dea
Join Covid19..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
)

Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac
--ALTER TABLE CovidDeath  ALTER COLUMN location  nvarchar(150)



-- Using Temp Table to perform Calculation on Partition By in previous query
DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(bigint ,vac.new_vaccinations)) OVER (Partition by dea.Location order by dea.location, dea.Date) as RollingPeopleVaccinated --summation of new_vaccinations
--, (RollingPeopleVaccinated/population)*100 we can not use a vailable we have created into anoter operations  
From Covid19..CovidDeath dea
Join Covid19..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac.date
--where dea.continent is not null

select *, (RollingPeopleVaccinated/Population)*100
from #PercentPopulationVaccinated

-- Creating View to store data for later visualizations
Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(bigint ,vac.new_vaccinations)) OVER (Partition by dea.Location order by dea.location, dea.Date) as RollingPeopleVaccinated --summation of new_vaccinations
--, (RollingPeopleVaccinated/population)*100 we can not use a vailable we have created into anoter operations  
From Covid19..CovidDeath dea
Join Covid19..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null