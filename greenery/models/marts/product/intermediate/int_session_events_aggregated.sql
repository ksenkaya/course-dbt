{{
  config(
    materialized='ephemeral'
  )
}}


with fct_events as (

    select * from {{ ref('fct_events') }}

),

session_per_event_type as (

select
  session_id,
  user_id,
  event_created_at::date as event_created_date,
  sum(case when event_type = 'add_to_cart' then 1 else 0 end) as add_to_cart,
  sum(case when event_type = 'checkout' then 1 else 0 end) as checkout,
  sum(case when event_type = 'page_view' then 1 else 0 end) as page_view,
  sum(case when event_type = 'package_shipped' then 1 else 0 end) as package_shipped

from fct_events

group by 1,2,3

)

select * from session_per_event_type