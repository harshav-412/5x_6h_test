
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

with source_data as (

    select location,TO_DATE(DATE) as reported_date, avg(case_recovered_rate) as recovered_rate, avg(case_fatality_rate) as
  fatality_rate from FIVETRAN_DB.GOOGLE_SHEETS.COVID_19_INDONESIA_HARSHA_VARDHAN
  group by location,TO_DATE(DATE)
  order by TO_DATE(DATE),location

)

select *
from source_data

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
