
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

with source_data as (

    select distinct continent,country,province,location_level,location,location_iso_code,latitude,longitude,population,
population_density,area_km_2_ area_in_square_km,total_urban_villages,total_rural_villages
 from FIVETRAN_DB.GOOGLE_SHEETS.COVID_19_INDONESIA_HARSHA_VARDHAN
 
)

select *
from source_data

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
