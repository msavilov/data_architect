INSERT OR IGNORE INTO
    DWH_FACT_PRODUCTS (product_id, brand, product_line, product_class,
                       product_size, list_price, standard_cost,
                       product_first_sold_date)
SELECT
       cast(product_id as bigint) as product_id,
       brand,
       product_line,
       product_class,
       product_size,
       cast(list_price as real) as list_price,
       cast(standard_cost as real) as standard_cost,
       product_first_sold_date
FROM STG_TRANSACTIONS
GROUP BY product_id
ORDER BY product_id;
