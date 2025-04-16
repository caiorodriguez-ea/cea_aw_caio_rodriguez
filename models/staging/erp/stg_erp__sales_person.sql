with 
    sales_person as (
        select
            cast(businessentityid as int) as pk_sales_person
            , cast(territoryid as int) fk_territory
            {# , cast(salesquota as numeric) as sales_quota
            , cast(bonus as numeric) as sales_bonus
            , cast(commissionpct as numeric) as sales_comission
            , cast(salesytd as numeric) as sales_ytd
            , cast(saleslastyear as numeric) as sales_last_year
            , cast(modifieddate as date) as updated_at_dt #}
        from {{ source('erp', 'salesperson') }}
    )

select *
from sales_person