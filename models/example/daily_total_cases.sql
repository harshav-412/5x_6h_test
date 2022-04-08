
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

with daily_data as (

    select  to_date(date) as reported_date, sum(new_cases) as confirmed_cases, sum(new_active_cases) as active_cases,
sum(new_recovered) as recovered_cases, sum(new_deaths) as deceased_cases from FIVETRAN_DB.GOOGLE_SHEETS.COVID_19_INDONESIA_HARSHA_VARDHAN
group by to_date(date)   
)
,total_data as(
    select  to_date(date) as reported_date, sum(total_cases) as total_cases , sum(total_active_cases) as total_active_cases, 
sum(total_recovered) as total_recovered, sum(total_deaths) as total_deceased_cases
from FIVETRAN_DB.GOOGLE_SHEETS.COVID_19_INDONESIA_HARSHA_VARDHAN
group by to_date(date)
)

select b.*,confirmed_cases, active_cases, recovered_cases, deceased_cases
from daily_data a join total_data b on a.reported_date = b.reported_date order by a.reported_date

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
