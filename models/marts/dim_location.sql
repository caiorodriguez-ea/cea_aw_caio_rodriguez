with
    dim_location_sk_gen as (
        select
            {{ dbt_utils.generate_surrogate_key(['pk_address']) }} as sk_address
            , pk_address
            , city_nm
            , state_province_nm
            , territory_nm
            , country_nm
            , region_nm
        from {{ ref('int_sales__location') }}
    )

select *
from dim_location_sk_gen