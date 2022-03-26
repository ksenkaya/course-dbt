with fct_orders as (

    select * from {{ ref('fct_orders') }}

),

final as (

select
  o.user_id,
  o.order_id,
  u.email,
  u.full_name,
  u.state,
  u.country,
  o.order_created_at::date as order_created_date,
  o.order_status,
  o.shipping_service,
  o.has_promo,
  o.order_quantity, 
  o.order_total, 
  o.days_to_deliver 

from fct_orders o

left join {{ ref('dim_users') }} u
  on o.user_id = u.user_id

)


select * from final