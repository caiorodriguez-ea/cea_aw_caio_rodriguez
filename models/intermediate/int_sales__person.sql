with
    sales_person_ids as (
        select *
        from {{ ref('stg_erp__sales_person') }}
    )

    , employee_info as (
        select *
        from {{ ref('stg_erp__employee') }}
    )

    , person_info as (
        select *
        from {{ ref('stg_erp__person') }}
    )

    , sales_territory_info as (
        select *
        from {{ ref('stg_erp__sales_territory') }}
    )

    , enriched_sales_person as (
        select
            sales_person_ids.pk_sales_person
            , person_info.full_name
            , employee_info.job_title
            , employee_info.is_salaried
        from sales_person_ids
        left join employee_info on sales_person_ids.pk_sales_person = employee_info.pk_employee
        left join person_info on sales_person_ids.pk_sales_person = person_info.pk_person
    )

select *
from enriched_sales_person