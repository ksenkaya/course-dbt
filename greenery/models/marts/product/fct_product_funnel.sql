with page_views as (

  select
    session_id,
    min(event_created_at) as min_time
  from {{ ref('fct_sessions') }}
  where event_type = 'page_view'
  group by 1
  
),


add_to_carts as (

  select 
    distinct s.session_id,
    min(s.event_created_at) as min_time
  from page_views p 
  inner join dbt_kadir_s.fct_sessions s
  on s.session_id = p.session_id
  where event_type = 'add_to_cart'
  group by 1
  
),


checkouts as (

  select 
    distinct s.session_id,
    min(s.event_created_at) as min_time
  from add_to_carts a
  inner join dbt_kadir_s.fct_sessions s
  on s.session_id = a.session_id
  where event_type = 'checkout'
  group by 1
  
),


steps as (

  select 'page_view' as step, count(*) as step_count from page_views
  union all
  select 'add_to_cart' as step, count(*) as step_count from add_to_carts
  union all
  select 'checkout' as step, count(*) as step_count from checkouts
  order by 2 desc 
  
)
  
  select
    step,
    step_count,
    round((1.0 - step_count::numeric / lag(step_count, 1) over ()), 2) as drop_off_rate
  from steps