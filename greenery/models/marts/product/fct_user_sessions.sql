
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
  u.full_name,
  u.email,
  i.session_id,
  {{ dbt_utils.star(from=ref('int_session_events_aggregated'), except=["total_events", "session_id"]) }},
  extract(epoch from s.last_session_created_at - s.first_session_created_at) / 60 as session_length_mins  


from {{ ref('int_session_events_aggregated') }} i
left join {{ ref('dim_users') }} u 
  using (user_id)
left join session_length s
  using (session_id)

)

select * from final