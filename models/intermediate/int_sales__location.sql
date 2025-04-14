with
    city_info as (
        select *
        from {{ ref('stg_erp__address') }}
    )

    , state_province_info as (
        select *
        from {{ ref('stg_erp__state_province') }}
    )

    , territory_info as (
        select *
        from {{ ref('stg_erp__sales_territory') }}
    )

    , country_info as (
        select *
        from {{ ref('stg_erp__country') }}
    )

    , enriched_location as (
        select 
            city_info.pk_address
            , city_info.city_nm
            , state_province_info.state_province_nm
            , territory_info.territory_nm
            , country_info.country_nm
            , territory_info.region_nm
        from city_info
        left join state_province_info on city_info.fk_state_province = state_province_info.pk_state_province
        left join territory_info on state_province_info.fk_territory = territory_info.pk_territory
        left join country_info on state_province_info.fk_country = country_info.pk_country
    )

    , location_sk_gen as (
        select
            {{ dbt_utils.generate_surrogate_key(['city_nm', 'state_province_nm', 'territory_nm', 'country_nm', 'region_nm']) }} as sk_location
            , pk_address
            , city_nm
            , state_province_nm
            , territory_nm
            , country_nm
            , region_nm
        from enriched_location
    )

select *
from location_sk_gen