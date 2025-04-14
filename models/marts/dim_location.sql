with
    dim_location_sk_gen as (
        select distinct
            sk_location
            , city_nm
            , state_province_nm
            , territory_nm
            , country_nm
            , region_nm
        from {{ ref('int_sales__location') }}
    )

select *
from dim_location_sk_gen