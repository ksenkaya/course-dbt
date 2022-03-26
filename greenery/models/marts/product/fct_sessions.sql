
with fct_events as (

    select 
      {{ dbt_utils.star(from=ref('fct_events'), except=["event_id", "event_page_url"]) }}
    from {{ ref('fct_events') }}

),

sessions_per_product as (

select
  e.session_id,
  e.user_id,
  e.event_created_at,
  e.event_type,
  e.order_id,
  coalesce(e.product_id, o.product_id) as product_id,
  p.product_name

from fct_events e
left join {{ ref('fct_orders') }} o 
  on e.order_id = o.order_id
left join {{ ref('dim_products') }} p
  on coalesce(e.product_id, o.product_id) = p.product_id

)

select * from sessions_per_product