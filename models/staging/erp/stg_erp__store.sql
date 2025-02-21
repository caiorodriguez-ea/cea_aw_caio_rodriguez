with
    store_info as (
        select
            cast(businessentityid as int) as pk_store
            , cast(salespersonid as int) as fk_sales_person
            , initcap(cast(name as varchar)) as store_nm
            {# , cast(modifieddate as varchar) as updated_at_dt #}
        from {{ source('erp', 'store') }}
    )

select *
from store_info