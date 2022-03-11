## Week 1 Project - Answers

### 1 - How many users do we have?
Answer: **130**

Query:
``` sql
select
  count(user_id)
from dbt.dbt_kadir_s.stg_users
```

### 2 - On average, how many orders do we receive per hour?
Answer: **7.52**

Query:
``` sql
with order_per_hour as (
    select
        date_trunc('hour', order_created_at),
        count(order_id) as cnt
    from dbt.dbt_kadir_s.stg_orders
    group by 1
)

select round(avg(cnt),2) from order_per_hour
```

## 3 - On average, how long does an order take from being placed to being delivered?
Answer: **3 days 21:24:11s**

Query:
``` sql
select avg(order_delivered_at - order_created_at)
from dbt.dbt_kadir_s.stg_orders
where order_status = 'delivered'
```

### 4 - How many users have only made one purchase? Two purchases? Three+ purchases?
Answer:
| purchases   | number_of_users |
|-------------|-----------------|
|            1|       25        |
|            2|       28        |
|           3+|       71        |

Query:
``` sql
with orders_per_user as (
    select
        user_id,
        count(order_id) as cnt
    from dbt.dbt_kadir_s.stg_orders
    group by 1
)

select
    case
        when cnt >= 3 then '3+'
        when cnt = 2 then '2'
        else '1'
    end as purchases,
    count(distinct user_id) as number_of_users
from orders_per_user
group by 1
order by 1
```

### 5 - On average, how many unique sessions do we have per hour?
Answer: **16.33**

Query:
``` sql
with sessions_per_hour as (
    select
        date_trunc('hour', event_created_at),
        count(distinct session_id) as cnt
    from dbt.dbt_kadir_s.stg_events
    group by 1
)

select round(avg(cnt), 2) as avg_sessions
from sessions_per_hour
```