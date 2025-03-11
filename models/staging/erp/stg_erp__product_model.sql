with
    product_model_rename as (
        select
            cast(productmodelid as int) as pk_product_model
            , cast(name as varchar) as product_model_nm
            {#, cast(catalogdescription as varchar) as product_catalog_description
            , cast(instructions as varchar) as instructions
            , cast(modifieddate as date) as updated_at_dt#}
        from {{ source('erp', 'productmodel') }}
    )

select *
from product_model_rename