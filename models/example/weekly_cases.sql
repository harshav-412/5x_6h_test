
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

with source_data as (

    select  yearofweek(TO_DATE(DATE))|| WEEK(TO_DATE(DATE)) as reported_week, sum(total_cases) as total_cases , sum(total_active_cases) as total_active_cases, 
sum(total_recovered) as total_recovered, sum(total_deaths) as total_deceased_cases
from FIVETRAN_DB.GOOGLE_SHEETS.COVID_19_INDONESIA_HARSHA_VARDHAN
group by  yearofweek(TO_DATE(DATE))|| WEEK(TO_DATE(DATE))
order by reported_week 

)

select *
from source_data

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
