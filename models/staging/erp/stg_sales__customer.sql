with
    customer_rename as (
        select
            cast(customerid as int) as pk_customer
            , cast(storeid as int) as fk_store
            , cast(personid as int) as fk_person
           {#, cast(territoryid as int) as fk_territory
            , cast(modifieddate as date) as updated_at_dt#}
        from {{ source('erp', 'customer') }}
    )

select *
from customer_rename