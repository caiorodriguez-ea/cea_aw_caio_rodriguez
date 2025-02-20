with min_max_dates as (
    select 
        min(sales_order_dt) as min_sales_order_dt
        , max(sales_order_dt) as max_sales_order_dt
    from {{ ref('stg_erp__sales_order_header') }}
),

calendar_range as (
    select 
        min_sales_order_dt as pk_date
    from min_max_dates
    union all
    select 
        dateadd(day, 1, pk_date) as pk_date
    from calendar_range
    where pk_date < (select max_sales_order_dt from min_max_dates)
),

final_calendar as (
    select 
    pk_date 
    , extract(year from pk_date) as year
    , concat('Q', extract(quarter from pk_date)) as quarter
    , extract(month from pk_date) as month

    , initcap(
        case extract(month from pk_date)
            when 1 then 'Jan'
            when 2 then 'Feb'
            when 3 then 'Mar'
            when 4 then 'Apr'
            when 5 then 'May'
            when 6 then 'Jun'
            when 7 then 'Jul'
            when 8 then 'Aug'
            when 9 then 'Sep'
            when 10 then 'Oct'
            when 11 then 'Nov'
            when 12 then 'Dec'
        end
    ) as month_nm
    , extract(day from pk_date) as day
from calendar_range
)

select *
from final_calendar

