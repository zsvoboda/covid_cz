--- infections KPI
select 
		sum(covid_event_cnt) 
	from covid_event ce
	where covid_event_type = 'I';

--- deaths KPI
select 
		sum(covid_event_cnt) 
	from covid_event ce
	where covid_event_type = 'D';
	

--- deaths and infections trend by month
with infections as (
	select 
			covid_event_date as dt,
			sum(covid_event_cnt) as infections
		from covid_event ce 
		where covid_event_type = 'I'
		group by dt),
deaths as (
	select 
			covid_event_date as dt, 
			sum(covid_event_cnt) as deaths
		from covid_event ce 
		where covid_event_type = 'D'
		group by dt) 
select 
		cast(extract(year from d.dt) as text) || '-' || LPAD(cast(extract(month from d.dt) as text), 2, '0') as mnth,
		sum(infections) as infections, 
		sum(deaths) as deaths 
	from deaths d 
	join infections i on d.dt = i.dt
	group by 1 
	order by 1;
	
--- deaths and infections trend by month with district for filtering
with infections as (
	select 
			covid_event_date as dt,
			district_id,
			sum(covid_event_cnt) as infections
		from covid_event ce 
		where covid_event_type = 'I'
		group by dt, district_id),
deaths as (
	select 
			covid_event_date as dt, 
			district_id,
			sum(covid_event_cnt) as deaths
		from covid_event ce 
		where covid_event_type = 'D'
		group by dt, district_id) 
select 
		cast(extract(year from deaths.dt) as text) || '-' || LPAD(cast(extract(month from deaths.dt) as text), 2, '0') as mnth,
		district_name,
		sum(infections) as infections, 
		sum(deaths) as deaths 
	from deaths  
	join infections on deaths.dt = infections.dt and deaths.district_id = infections.district_id
	join district on district.district_id = infections.district_id
	where district_name = 'Praha'
	group by mnth, district_name 
	order by 1;

--- infections and deaths by district filtered by county
with infections as (
	select 
			covid_event_date as dt,
			district_id,
			sum(covid_event_cnt) as infections
		from covid_event ce 
		where covid_event_type = 'I'
		group by dt, district_id),
deaths as (
	select 
			covid_event_date as dt, 
			district_id,
			sum(covid_event_cnt) as deaths
		from covid_event ce 
		where covid_event_type = 'D'
		group by dt, district_id) 
select 
		district_name,
		sum(infections) as infections, 
		sum(deaths) as deaths 
	from deaths  
	join infections on deaths.dt = infections.dt and deaths.district_id = infections.district_id
	join district on district.district_id = infections.district_id
	join county on county.county_id = district.county_id 
	where county.county_id IN ('CZ020', 'CZ010') and deaths.dt between '2021-09-01' and '2021-12-31'
	group by district_name 
	order by 1;

--- deaths per capita by district filtered by county
with deaths as (
	select 
			covid_event_date as dt, 
			district_id,
			sum(covid_event_cnt) as deaths
		from covid_event ce 
		where covid_event_type = 'D'
		group by dt, district_id),
population as (
	select  
			district.district_id as district_id,
			district.district_name as district_name,
			sum(city_population) as population
		from demography 
		join city on city.city_id = demography.city_id 
		join district on district.district_id = city.district_id
		group by district.district_id, district.district_name), 
aggregation as (select 
		district_name,
		population as population,
		sum(deaths) as deaths 
	from deaths  
	join population on population.district_id = deaths.district_id	 
	group by district_name, population)
select 
		district_name,
		round(100 * deaths / population, 2) as death_per_capita
from aggregation
order by death_per_capita desc;

