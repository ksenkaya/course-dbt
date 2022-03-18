
with stg_events as (

    select * from {{ ref('stg_events') }}

)

select * from stg_events