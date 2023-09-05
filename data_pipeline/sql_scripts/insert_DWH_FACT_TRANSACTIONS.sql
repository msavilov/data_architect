INSERT OR IGNORE INTO
    DWH_FACT_TRANSACTIONS (transaction_id,product_id,customer_id,transaction_date,
                           online_order,order_status,brand,product_line,
                           product_class,product_size,list_price,standard_cost,
                           product_first_sold_date
                           )
SELECT cast(transaction_id as bigint) as transaction_id,
       cast(product_id as bigint) as product_id,
       cast(customer_id as bigint) as customer_id,
       datetime(transaction_date) as transaction_date,
       online_order,
       order_status,
       brand,
       product_line,
       product_class,
       product_size,
       cast(list_price as real) as list_price,
       cast(standard_cost as real) as standard_cost,
       product_first_sold_date
FROM STG_TRANSACTIONS
ORDER BY transaction_id;