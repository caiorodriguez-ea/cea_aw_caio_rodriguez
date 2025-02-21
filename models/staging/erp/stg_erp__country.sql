with
    country_region as (
        select
            upper(cast(countryregioncode as varchar)) as pk_country
            , initcap(cast(name as varchar)) as country_nm
        from {{ source('erp', 'countryregion') }}
    )

select *
from country_region
