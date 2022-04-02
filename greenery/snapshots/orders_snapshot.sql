{% snapshot orders_snapshot %}

  {{
    config(
      target_schema='dbt_kadir_s',
      unique_key='order_id',
      strategy='check',
      check_cols=['status'],
    )
  }}

  select * from {{ source('src_postgres', 'orders') }}

{% endsnapshot %}