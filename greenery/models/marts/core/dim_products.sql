
with stg_products as (

    select * from {{ ref('stg_products') }}

)

select
  p.*,
  oi.order_id,
  oi.order_quantity
from stg_products p
left join {{ ref('stg_order_items') }} oi
  on p.product_id = oi.product_id