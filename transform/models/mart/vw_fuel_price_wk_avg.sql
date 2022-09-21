with weekly_fuel_prices as (

  select * from {{ ref('stg_weekly_fuel_prices') }}

),

-- union all weekly energy price inputs
fuel_price_wk_avg as (

  select
    *
  from weekly_fuel_prices

)

select * from fuel_price_wk_avg

