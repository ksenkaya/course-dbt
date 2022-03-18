
with stg_users as (

    select * from {{ ref('stg_users') }}

)

select
  u.*,
  concat_ws(' ', u.first_name, u.last_name) as full_name,
  a.state,
  a.country
from stg_users u
left join {{ ref('stg_addresses') }} a
  on u.address_id = a.address_id