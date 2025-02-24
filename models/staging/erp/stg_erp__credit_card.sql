with
    credit_card_rename as (
        select
            cast(creditcardid as int) as pk_credit_card
            , cast(cardtype as varchar) as card_type_nm
            {#, cast(cardnumber as int) as card_number
            , cast(expmonth as int) as card_exp_month
            , cast(expyear as int) as card_exp_year
            , cast(modifieddate as date) as updated_at_dt #}
        from {{ source('erp', 'creditcard') }}
    )

select *
from credit_card_rename