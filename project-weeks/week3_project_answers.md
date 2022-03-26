## Week 3 Project - Answers

### Part 1

#### 1 - What is our overall conversion rate?
Answer: **0.62**

Query:
``` sql
-- overall conversion rate: # of sessions with checkout / total of # sessions
with cvr as (

select
  count(distinct case when event_type = 'checkout' then session_id else null end) number_of_sessions_purchased,
  count(distinct session_id) as number_of_sessions
from dbt_kadir_s.fct_sessions

)

select round((number_of_sessions_purchased::decimal / number_of_sessions), 2) as overall_cvr
from cvr
```


#### 2 - What is our conversion rate by product?
Answer:
|    product_name     | cvr  |
|---------------------|------|
| String of pearls    | 0.61 |
| Arrow Head          | 0.56 |
| Cactus              | 0.55 |
| Bamboo              | 0.54 |
| ZZ Plant            | 0.54 |
| Rubber Plant        | 0.52 |
| Calathea Makoyana   | 0.51 |
| Monstera            | 0.51 |
| Fiddle Leaf Fig     | 0.50 |
| Majesty Palm        | 0.49 |
| Aloe Vera           | 0.49 |
| Devil's Ivy         | 0.49 |
| Jade Plant          | 0.48 |
| Philodendron        | 0.48 |
| Pilea Peperomioides | 0.47 |
| Dragon Tree         | 0.47 |
| Spider Plant        | 0.47 |
| Money Tree          | 0.46 |
| Bird of Paradise    | 0.45 |
| Orchid              | 0.45 |
| Ficus               | 0.43 |
| Birds Nest Fern     | 0.42 |
| Pink Anthurium      | 0.42 |
| Peace Lily          | 0.41 |
| Boston Fern         | 0.41 |
| Alocasia Polly      | 0.41 |
| Snake Plant         | 0.40 |
| Ponytail Palm       | 0.40 |
| Angel Wings Begonia | 0.39 |
| Pothos              | 0.34 |
Query:
``` sql
-- product conversion rate: # sessions with checkout per product / total # of sessions per product
with sessions_per_product as (

select
  product_name,
  count(distinct case when event_type = 'checkout' then session_id else null end) number_of_sessions_purchased,
  count(distinct session_id) as number_of_sessions
from dbt_kadir_s.fct_sessions
group by 1

)

select
  product_name,
  round((number_of_sessions_purchased::decimal / number_of_sessions), 2) as cvr
from sessions_per_product
order by 2 desc
```


#### 3 - Why might certain products be converting at higher/lower rates than others? Note: we don't actually have data to properly dig into this, but we can make some hypotheses.
Answer:
* user reviews
* campaigns/ads
* price
