with
    address_info as (
        select
            cast(addressid as int) as pk_address
            , cast(stateprovinceid as int) as fk_state_province
            , initcap(cast(city as varchar)) as city_nm
        from {{ source('erp', 'address') }}
    )

select *
from address_info