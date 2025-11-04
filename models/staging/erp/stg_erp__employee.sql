with
    employee_info as (
        select
            cast(businessentityid as int) as pk_employee
            , initcap(cast(jobtitle as varchar)) as job_title
            , cast(salariedflag as boolean) is_salaried
            {# , cast(nationalidnumber as int) as person_national_id
            , cast(loginid as varchar) as person_login_id
            , cast(birthdate as date) as person_birthdate
            , cast(maritalstatus as varchar) person_marital_status
            , cast(gender as varchar) as gender
            , cast(hiredate as date) as hired_date
            , cast(vacationhours as int) vacation_hours
            , cast(sickleavehours as int) sick_leave_hours
            , cast(currentflag as boolean) is_current
            , cast(modifieddate as date) updated_dt #}
        from {{ source('erp', 'employee') }}
    )

select *
from employee_info
