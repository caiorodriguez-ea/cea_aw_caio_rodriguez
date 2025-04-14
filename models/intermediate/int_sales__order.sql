with
    sales_order_header_info as (
        select *
        from {{ ref('stg_erp__sales_order_header') }}
    )

    , sales_order_details as (
        select *
        from {{ ref('stg_erp__sales_order_detail') }}
    )

    , credit_card_type_info as (
        select *
        from {{ ref('stg_erp__credit_card') }}
    )

    , sales_customer_info as (
        select *
        from {{ ref('int_sales__customer') }}
    )

    , location_info as (
        select *
        from {{ ref('int_sales__location') }}
    )

    , sales_order_header_joined as (
        select
            sales_order_header_info.pk_sales_order
            , sales_order_header_info.fk_sales_person
            , location_info.sk_location
            , sales_order_details.fk_product
            , sales_order_header_info.sales_order_dt
            , sales_order_header_info.sales_order_due_dt
            , sales_order_header_info.sales_order_ship_dt
            , sales_customer_info.customer_nm
            , credit_card_type_info.card_type_nm
            , sales_order_details.order_qtd
            , sales_order_details.unit_price
            , sales_order_details.unit_price_discount
            , sales_order_header_info.sales_order_value
            , sales_order_header_info.sales_order_taxes_value
            , sales_order_header_info.sales_order_freight_value
            , sales_order_header_info.sales_order_total_value
            , sales_order_header_info.order_status
            , sales_order_header_info.is_online_order
        from sales_order_header_info
        inner join sales_order_details on sales_order_header_info.pk_sales_order = sales_order_details.fk_sales_order
        left join credit_card_type_info on sales_order_header_info.fk_credit_card = credit_card_type_info.pk_credit_card
        left join sales_customer_info on sales_order_header_info.fk_customer = sales_customer_info.pk_customer
        left join location_info on sales_order_header_info.fk_ship_address = location_info.pk_address
    ),

    sales_order_header_metrics as (
        select
            pk_sales_order
            , fk_product
            , fk_sales_person
            , sk_location
            , sales_order_dt
            , sales_order_due_dt
            , sales_order_ship_dt
            , customer_nm
            , card_type_nm
            , order_qtd
            , unit_price
            , unit_price * order_qtd as gross_total
            , unit_price * (1 - unit_price_discount) * order_qtd as net_total
            , sales_order_freight_value / count(*) over(partition by pk_sales_order) as partial_sales_order_freight_value
            , unit_price_discount
            , sales_order_value / count(*) over(partition by pk_sales_order) as partial_sales_order_value
            , sales_order_taxes_value / count(*) over(partition by pk_sales_order) as partial_sales_order_taxes_value
            , sales_order_total_value / count(*) over(partition by pk_sales_order) as partial_sales_order_total_value
            , order_status
            , is_online_order
        from sales_order_header_joined
    )

select *
from sales_order_header_metrics