with
    store_info as (
        select *
        from {{ ref('stg_erp__store') }}
    ),

    business_address_info as (
        select *
        from {{ ref('stg_erp__business_address') }}
    ),

    enriched_store_info as (
        select
            store_info.fk_sales_person
            , business_address_info.fk_address as fk_store_address
            , store_info.store_nm
        from store_info
        left join business_address_info on store_info.pk_store = business_address_info.fk_business_entity
    )

select *
from enriched_store_info