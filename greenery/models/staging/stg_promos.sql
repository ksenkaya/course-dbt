with sourced as (

    select * from {{ source('src_postgres', 'promos') }}

),

renamed as (

    select
        promo_id,
        discount as promo_discount,
        status as promo_status

    from sourced

)

select * from renamed