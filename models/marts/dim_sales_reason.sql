with
    dim_sales_reason_sk_gen as (
        select
            {{ dbt_utils.generate_surrogate_key(['fk_sales_order']) }} as sk_sales_order
            , fk_sales_order
            , sales_reason_nm
            , sales_reason_type
        from {{ ref('int_sales__reason') }}
    )

select *
from dim_sales_reason_sk_gen