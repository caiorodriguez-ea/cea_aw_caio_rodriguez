with
    product_category_rename as (
        select
        	cast(productcategoryid as int) as pk_product_category
            , cast(name as varchar) as product_category_nm
            {#, cast(modifieddate as date) as updated_at_dt#}
        from {{ source('erp', 'productcategory') }}
    )

select *
from product_category_rename