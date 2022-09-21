--
-- Form a 'clean' weekly_fuel_prices
--
{{ config(materialized='view') }}
with source as (
    
        select * from "{{var('schema')}}".weekly_fuel_prices
    
),

cleaned as (

	select
		TO_DATE(source.date,'DD/MM/YYYY') as price_date,
		source.*
	from source
	where TO_DATE(source.date,'DD/MM/YYYY') is not null -- drop any bad data
),

renamed as (
    
    select
        *
    from cleaned

)

select * from renamed
