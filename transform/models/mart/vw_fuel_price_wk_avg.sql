with weekly_fuel_prices as (

  select * from {{ ref('stg_weekly_fuel_prices') }}

),

-- calculate and union all weekly energy price inputs
fuel_price_calc_vat as (

  select
    round(ulsd / ( 1 + ulsd_vat_pc), 2) as ulsd_ex_vat, 
    round(ulsp / ( 1 + ulsp_vat_pc), 2) as ulsp_ex_vat, 
    *
  from weekly_fuel_prices

),

fuel_price_wk_avg as (

  select
    (ulsd - ulsd_ex_vat) as ulsd_vat, 
    (ulsp - ulsp_ex_vat) as ulsp_vat, 
    (ulsd_ex_vat - ulsd_duty) as ulsd_ex, 
    (ulsp_ex_vat - ulsp_duty) as ulsp_ex, 
    *
  from fuel_price_calc_vat

)

select * from fuel_price_wk_avg

