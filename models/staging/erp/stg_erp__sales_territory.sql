with
    sales_territory_info as (
        select
            cast(territoryid as int) as pk_territory
            , cast(name as varchar) as territory_nm
            , upper(cast(countryregioncode as varchar)) as country_abv
            , initcap(cast("group" as varchar)) as region_nm
            {# , cast(salesytd as numeric) as sales_ytd
            , cast(saleslastyear as numeric) as sales_last_year
            , cast(costytd as numeric) as cost_ytd
            , cast(costlastyear as numeric) as cost_last_year
            , cast(modifieddate as date) as updated_at_dt #}
        from {{ source('erp', 'salesterritory') }}
    )

select *
from sales_territory_info