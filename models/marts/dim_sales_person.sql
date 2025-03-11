with
    dim_sales_person_sk_gen as (
        select
            {{ dbt_utils.generate_surrogate_key(['pk_sales_person']) }} as sk_sales_person
            , pk_sales_person
            , full_name
            , job_title
            , is_salaried
        from {{ ref('int_sales__person') }}
    )

select *
from dim_sales_person_sk_gen

