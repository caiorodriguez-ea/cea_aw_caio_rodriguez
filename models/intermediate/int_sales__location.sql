with
    city_info as (
        select *
        from {{ ref('stg_erp__address') }}
    )

    state_province_info as (
        select *
        from {{ ref('stg_erp__state_province') }}
    )

    {# country_info as (
        select *
        from {{ ref('stg_erp__country') }}
    ) #}

    enriched_location as (
        select 
            city_info.pk_address
            , state_province_info.country_abv
            , city_info.city_nm
            , state_province_info.state_province_nm
            , state_province_info.state_provinve_abv
        from city_info
        left join state_province_info on city_info.fk_state_province = state_province_info.pk_state_province
    )

select *
from enriched_location