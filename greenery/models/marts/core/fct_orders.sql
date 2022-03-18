with stg_orders as (

    select * from {{ ref('stg_orders') }}

),

final as (

select
  o.*,
  oi.product_id,
  oi.order_quantity,
  case when o.promo_id is not null then true else false end as has_promo,
  (p.promo_discount::float/100) as promo_discount_rate,
  p.promo_status,
  age(order_delivered_at, order_created_at) as days_to_deliver

from stg_orders o
left join {{ ref('stg_promos') }} p
  on o.promo_id = p.promo_id
left join {{ ref('stg_order_items') }} oi
  on o.order_id = oi.order_id

)


select * from final
