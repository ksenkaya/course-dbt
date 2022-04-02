{% snapshot products_snapshot %}

  {{
    config(
      target_schema='dbt_kadir_s',
      unique_key='product_id',
      strategy='check',
      check_cols=['inventory', 'price'],
    )
  }}

  select * from {{ source('src_postgres', 'products') }}

{% endsnapshot %}