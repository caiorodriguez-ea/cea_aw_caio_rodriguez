with
    product_subcategory_rename as (
        select
            cast(productsubcategoryid as int) as pk_product_subcategory
            , cast(productcategoryid as int) as fk_product_category 
            , cast(name as varchar) as product_subcategory_nm
            {#, cast(modifieddate as date) as updated_at_dt#}
        from {{ source('erp', 'productsubcategory') }}
    )

select *
from product_subcategory_rename