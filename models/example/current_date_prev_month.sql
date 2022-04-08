
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

with source_data as (

    select a.*, nvl(prev_mnth_confirmed_cases,0) prev_mnth_confirmed_cases, nvl(prev_mnth_active_cases,0) prev_mnth_active_cases,
nvl(prev_mnth_recovered_cases,0) prev_mnth_recovered_cases, nvl(prev_mnth_deceased_cases,0) prev_mnth_deceased_cases
from
(select  to_date(date) as reported_date, sum(new_cases) as confirmed_cases, sum(new_active_cases) as active_cases,
sum(new_recovered) as recovered_cases, sum(new_deaths) as deceased_cases from FIVETRAN_DB.GOOGLE_SHEETS.COVID_19_INDONESIA_HARSHA_VARDHAN
group by to_date(date)) a 
left outer join
(select  to_date(date) as reported_date, sum(new_cases) as prev_mnth_confirmed_cases, sum(new_active_cases) as prev_mnth_active_cases,
sum(new_recovered) as prev_mnth_recovered_cases, sum(new_deaths) as prev_mnth_deceased_cases from FIVETRAN_DB.GOOGLE_SHEETS.COVID_19_INDONESIA_HARSHA_VARDHAN
group by to_date(date) ) b on a.reported_date = DATEADD(month, 1, b.reported_date)
order by a.reported_date

)

select *
from source_data

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
