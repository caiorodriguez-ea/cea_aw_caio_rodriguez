with
    sales_order_detail_rename as (
        select
            cast(salesorderid as int) as fk_sales_order
            , cast(productid as int) as fk_product
            , cast(orderqty as numeric(18,2)) as order_qtd
            , cast(unitprice as numeric(18,2)) as unit_price
            , cast(unitpricediscount as numeric(18,2)) as unit_price_discount
            {#, cast(salesorderdetailid as int) as pk_sales_order_detail
            , cast(specialofferid as int) as fk_special_offer
            , cast(carriertrackingnumber as varchar) as tracking_number
            , cast(modifieddate as date) as updated_at_dt #}
        from {{ source('erp', 'salesorderdetail') }}
    )

select *
from sales_order_detail_rename