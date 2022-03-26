{{ config(
    indexes=[
      {'columns': ['event_id'], 'type': 'hash'},
      {'columns': ['event_type', 'session_id']},
    ]
)}}

with sourced as (

    select * from {{ source('src_postgres', 'events') }}

),

renamed as (

    select
        event_id,
        session_id,
        user_id,
        page_url as event_page_url,
        created_at as event_created_at,
        event_type,
        order_id,
        product_id

    from sourced

)

select * from renamed