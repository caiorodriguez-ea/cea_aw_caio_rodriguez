with
    rename as (
        select
            cast(businessentityid as int) as pk_person
            , upper(cast(persontype as varchar)) as person_type
            , initcap(cast(title as varchar)) as person_title
            , initcap(cast(firstname as varchar)) as person_first_name
            , initcap(cast(middlename as varchar)) as person_middle_name
            , initcap(cast(lastname as varchar)) as person_last_name
            {# , cast(suffix as varchar) as person_suffix
            , cast(namestyle as boolean)
            , cast(emailpromotion as int) as person_email_promotion
            , cast(additionalcontactinfo as varchar) as person_aditional_info
            , cast(modifieddate as date) as updated_at_dt #}
        from {{ source('erp', 'person') }}
    ),

    coalesce_required_columns as (
        select
            pk_person
            , person_type
            , coalesce(person_first_name, '') as person_first_name
            , coalesce(person_middle_name, '') as person_middle_name
            , coalesce(person_last_name, '') as person_last_name
            , person_title
        from rename
    ),

    person_info as (
        select
            pk_person
            , person_type
            , person_first_name
            , person_middle_name
            , person_last_name
            , concat_ws(' ', person_first_name, person_middle_name, person_last_name) as full_name
            , person_title
        from coalesce_required_columns
    )

    select *
    from person_info