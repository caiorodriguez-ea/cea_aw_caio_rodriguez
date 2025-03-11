with
    product_info as (
        select *
        from {{ ref('stg_erp__product') }}
    )

    , product_subcategory_info as (
        select *
        from {{ ref('stg_erp__product_subcategory') }}
    )

    , product_category_info as (
        select *
        from {{ ref('stg_erp__product_category') }}
    )

    , product_model_info as (
        select *
        from {{ ref('stg_erp__product_model') }}
    )

    , enriched_product_info as (
        select
            product_info.pk_product
            , product_info.product_nm
            , product_subcategory_info.product_subcategory_nm
            , product_category_info.product_category_nm
            , product_model_info.product_model_nm
        from product_info
        left join product_subcategory_info on product_info.fk_product_subcategory = product_subcategory_info.pk_product_subcategory
        left join product_category_info on product_subcategory_info.fk_product_category = product_category_info.pk_product_category
        left join product_model_info on product_info.fk_product_model = product_model_info.pk_product_model
    )

select *
from enriched_product_info