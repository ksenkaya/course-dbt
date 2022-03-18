
with session_length as (

select
  session_id,
  min(event_created_at) as first_session_created_at,
  max(event_created_at) as last_session_created_at
  
from {{ ref('fct_events') }}
group by 1

),

final as (

select 
  i.session_id,
  i.user_id,
  u.full_name,
  u.email,
  i.add_to_cart,
  i.checkout,
  i.page_view,
  i.package_shipped,
  extract(epoch from s.last_session_created_at - s.first_session_created_at) / 60 as session_length_mins  


from {{ ref('int_session_events_aggregated') }} i
left join {{ ref('dim_users') }} u 
  on i.user_id = u.user_id
left join session_length s
  on i.session_id = s.session_id

)

select * from final