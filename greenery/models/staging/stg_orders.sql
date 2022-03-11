with sourced as (

    select * from {{ source('src_postgres', 'orders') }}

),

renamed as (

    select
      order_id,
      user_id,
      promo_id,
      address_id,
      created_at as order_created_at,
      order_cost,
      shipping_cost,
      order_total,
      tracking_id as order_tracking_id,
      shipping_service,
      estimated_delivery_at as order_estimated_delivery_at,
      delivered_at as order_delivered_at,
      status as order_status

    from sourced

)

select * from renamed