with
    state_province_info as (
        select
            cast(stateprovinceid as int) as pk_state_province
            , cast(territoryid as int) as fk_territory
            , upper(cast(countryregioncode as varchar)) as fk_country
            , initcap(cast(name as varchar)) as state_province_nm
            , upper(cast(stateprovincecode as varchar)) as state_province_abv
        from {{ source('erp', 'stateprovince') }}
    )

select *
from state_province_info