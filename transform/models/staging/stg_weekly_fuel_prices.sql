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
		CAST(source.ulsd AS DECIMAL) as ulsd, 
		CAST(source.ulsd_duty AS DECIMAL) as ulsd_duty, 
		round((CAST(source.ulsd AS DECIMAL) * (CAST(source.ulsd_vat AS DECIMAL) / 100)), 2) as ulsd_vat, 
		CAST(source.ulsd_vat AS DECIMAL) as ulsd_vat_pc, 
		CAST(source.ulsp AS DECIMAL) as ulsp, 
		CAST(source.ulsp_duty AS DECIMAL) as ulsp_duty, 
		round((CAST(source.ulsp AS DECIMAL) * (CAST(source.ulsp_vat AS DECIMAL) / 100)), 2) as ulsp_vat, 
		CAST(source.ulsp_vat AS DECIMAL) as ulsp_vat_pc 
	from source
	where TO_DATE(source.date,'DD/MM/YYYY') is not null -- drop any bad data
),

renamed as (
    
    select
        *
    from cleaned

)

select * from renamed
