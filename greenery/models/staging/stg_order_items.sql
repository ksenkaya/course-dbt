with sourced as (

    select * from {{ source('src_postgres', 'order_items') }}

),

renamed as (

    select
        order_id,
        product_id,
        quantity as order_quantity

    from sourced

)

select * from renamed