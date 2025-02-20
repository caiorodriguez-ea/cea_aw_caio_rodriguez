with
    sales_order_header as (
        select
            cast(salesorderid as int) as pk_sales_order
            , cast(customerid as int) as fk_customer
            , cast(salespersonid as int) as fk_sales_person
            , cast(territoryid as int) as fk_location
            , cast(shiptoaddressid as int) as fk_ship_address
            , cast(creditcardid as int) as fk_credit_card
            , cast(currencyrateid as int) as fk_currency_rate
            , cast(orderdate as date) as sales_order_dt
            , cast(duedate as date) as sales_order_due_dt
            , cast(shipdate as date) as sales_order_ship_dt
            , cast(subtotal as numeric) as sales_order_value
            , cast(taxamt as numeric) as sales_order_taxes_value
            , cast(freight as numeric) as sales_order_freight_value
            , cast(totaldue as numeric) as sales_order_total_value
            , cast(onlineorderflag as boolean) as is_online_order
        from {{ source('erp', 'salesorderheader') }}
    )

select *
from sales_order_header