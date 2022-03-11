with sourced as (

    select * from {{ source('src_postgres', 'users') }}

),

renamed as (

    select
        user_id,
        first_name,
        last_name,
        email,
        phone_number,
        created_at as user_created_at,
        updated_at as user_updated_at,
        address_id

    from sourced

)

select * from renamed