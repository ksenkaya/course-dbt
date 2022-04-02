{% snapshot users_snapshot %}

  {{
    config(
      target_schema='dbt_kadir_s',
      unique_key='user_id',
      strategy='timestamp',
      updated_at='updated_at',
    )
  }}

  select * from {{ source('src_postgres', 'users') }}

{% endsnapshot %}