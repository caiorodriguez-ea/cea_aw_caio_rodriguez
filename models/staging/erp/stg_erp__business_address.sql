with
    business_address_rename as (
        select
            cast(businessentityid as int) as fk_business_entity
            , cast(addressid as int) as fk_address
            {# , cast(addresstypeid as int) as fk_address_type
            , cast(modifieddate as date) as updated_at_dt #}
        from {{ source('erp', 'businessentityaddress') }}
    )

select *
from business_address_rename