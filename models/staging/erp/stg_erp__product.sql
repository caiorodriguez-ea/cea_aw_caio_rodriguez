with
    product_rename as (
        select
            cast (productid as int) as pk_product
            , cast(productsubcategoryid as int) as fk_product_subcategory
            , cast(productmodelid as int) as fk_product_model
            , cast(name as varchar) as product_nm
            {#, cast(productnumber as varchar) as product_number
            , cast(makeflag as boolean) as is_make
            , cast(finishedgoodsflag as boolean) as is_finished_goods
            , cast(color as varchar) as product_color
            , cast(safetystocklevel as numeric) as product_safety_stock_lvl
            , cast(reorderpoint as int) as product_reorder_point
            , cast(standardcost as numeric) as product_standart_cost
            , cast(listprice as numeric) as product_list_price
            , cast(size as varchar) as product_size
            , cast(sizeunitmeasurecode as varchar) as product_size_unit_measure
            , cast(weightunitmeasurecode as varchar) as product_weight_unit_measure
            , cast(weight as numeric) as product_weight
            , cast(daystomanufacture as int) as days_to_manufacture
            , cast(productline as varchar) as product_line
            , cast(class as varchar) as product_class
            , cast(style as varchar) as product_style
            , cast(sellstartdate as date) as sell_start_dt
            , cast(sellenddate as date) as sell_end_dt
            , cast(discontinueddate as date) as discontinued_dt
            , cast(modifieddate as date) as updated_at_dt#}
        from {{ source('erp', 'product') }}
    )

select *
from product_rename