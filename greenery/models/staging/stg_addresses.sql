with sourced as (

    select * from {{ source('src_postgres', 'addresses') }}

),

renamed as (

    select
      address_id,
      address,
      zipcode,
      state,
      country

    from sourced

)

select * from renamed