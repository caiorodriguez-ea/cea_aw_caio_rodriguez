with
    dim_sales_reason_sk_gen as (
        select distinct
            {{ dbt_utils.generate_surrogate_key(['pk_sales_reason']) }} as sk_sales_reason
            , pk_sales_reason
            , sales_reason_nm
            , sales_reason_type
        from {{ ref('int_sales__reason') }}
    )

select *
from dim_sales_reason_sk_gen