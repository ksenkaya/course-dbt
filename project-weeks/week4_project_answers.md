## Week 4 Project - Answers

### Part 1. dbt Snapshots

I created snapshots/orders_snapshot.sql and below is the changes after running the snapshot.
![dbt-snapshot](https://github.com/ksenkaya/course-dbt/blob/dbt_dev/project-weeks/dbt_snapshot_changes.png "dbt-snapshot")


###  Part 2. Modeling challenge

#### 1 - How are our users moving through the product funnel? Which steps in the funnel have largest drop off points?
23% of the users after add_to_cart don't convert to checkout.
Please see the models/marts/produc/fct_product_funnel.sql

|    step     | step_count | drop_off_rate |
|-------------|------------|---------------|
| page_view   | 578        |               |
| add_to_cart | 467        |      0.19     |
| checkout    | 361        |      0.23     |

Exposures: Please see models/marts/exposures.yml and updated DAG below:
![dbt-dag](https://github.com/ksenkaya/course-dbt/blob/dbt_dev/project-weeks/dbt-dag.png "dbt-dag")