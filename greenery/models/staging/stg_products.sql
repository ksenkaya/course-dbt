with sourced as (

    select * from {{ source('src_postgres', 'products') }}

),

renamed as (

    select
        product_id,
        name as product_name,
        price as product_price,
        inventory as product_inventory

    from sourced

)

select * from renamed