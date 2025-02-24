with
    customer_info as (
        select *
        from {{ ref('stg_sales__customer') }}
    ),

    person_info as (
        select *
        from {{ ref('stg_erp__person') }}
    ),

    store_info as (
        select *
        from {{ ref('stg_erp__store') }}
    ),

    enriched_customer_info as (
        select
            customer_info.pk_customer
            , coalesce(person_info.full_name, store_info.store_nm) as customer_nm

        from customer_info
        left join person_info on customer_info.fk_person = person_info.pk_person
        left join store_info on customer_info.fk_store = store_info.pk_store
    )

select *
from enriched_customer_info