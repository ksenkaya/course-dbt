{{
  config(
    materialized='table'
  )
}}

-- set event_types variables
{% 
  set event_types = dbt_utils.get_query_results_as_dict(
    "select distinct event_type from" ~ ref('fct_events')
  )
%}

with fct_events as (

    select * from {{ ref('fct_events') }}

),

session_per_event_type as (

select
  session_id,
  user_id,
  event_created_at::date as event_created_date,
  {% for event_type in event_types['event_type'] %}
  sum(case when event_type = '{{event_type}}' then 1 else 0 end) as {{event_type}}_events,
  {% endfor %}
  sum(1) as total_events  
from fct_events

{{dbt_utils.group_by(3) }}

)

select * from session_per_event_type