with
    dim_product_sk_gen as (
        select
            {{ dbt_utils.generate_surrogate_key(['pk_product']) }} as sk_product
            , pk_product
            , product_nm
            , product_subcategory_nm
            , product_category_nm
            , product_model_nm
        from {{ ref('int_sales__product') }}
    )

select *
from dim_product_sk_gen

