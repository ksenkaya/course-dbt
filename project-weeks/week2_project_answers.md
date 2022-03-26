## Week 2 Project - Answers

### Part 1 Models

#### 1 - What is our user repeat rate?
Answer: **0.798**

Query:
``` sql
with orders_per_user as (

select
  user_id,
  count(distinct order_id) as number_of_orders
from dbt.dbt_kadir_s.fct_user_orders
group by 1

)

select
  round(sum(case when number_of_orders >= 2 then 1 end) * 1.0
  / count(1) * 1.0, 3) as user_repeat_rate

from orders_per_user
```

#### 2 - What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?
Answer:
* Indicators of likely purchase again
    * number of previous purchases
    * purchase frequency - each week, two weeks or month
    * higher session length than average
    * higher pageviews than average
* Indicators of likely to not purchase again
    * low purchase frequency
    * lower pageviews than average
    * *higher* than average delivery time
    * order arrives *later* than expected delivery (`delivered_at < estimated_delivery_at`)
* Other features to look into
    * device type for each session
    * payment methods
    * user age and gender
    * UTM parameters to find where users come from e.g. through organic search, ads, blogpost etc.


#### 3 - Explain the marts models you added. Why did you organize the models in the way you did?
Answer: I created three folders by business unit, such as product, marketing and core for common models.
In core, I created `dim_products`, `dim_users`, `fct_events` and `fct_orders` to generate major core models and build one source of truth for each of these.
In marketing, I created `fct_user_orders` to find orders per user at `user_id` level.
In product, I built `int_session_events_aggregated` as an intermediate model to calculate sessions by event type and then use it in `fct_user_sessions` model to get all useful information about user sessions such as session length and specific activities like pageviews, checkout etc.


#### 4 - Use the dbt docs to visualize your model DAGs to ensure the model layers make sense.
![dbt-dag](https://github.com/ksenkaya/course-dbt/blob/dbt_dev/project-weeks/dbt-dag.png "dbt-dag")

### Part 2 Tests

#### 1 - What assumptions are you making about each model? (i.e. why are you adding each test?)
Some of the tests added in marts models:
`product_id` cannot be be null, or `product_price`, `order_quantity` must be positive and not null in `dim_products`.
`user_id`, `email`, `full_name` cannot be NULL or `session_length_mins` must be positive in `fct_user_sessions`.
`session_id`, `user_id` cannot be null or session activities must be positive in `fct_user_sessions`.


#### 2 - Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?
I didn't find necessarily bad data. I jsut noticed that `promo_discount` was not in decimal format, instead a number like 20, 70 etc. So I changed it to `promo_discount_rate`


#### 3 - Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.
I would set up scheduled jobs to run models, and tests. Besides that I would set up an alerting system so that we would immediately get notified when a job fails.
