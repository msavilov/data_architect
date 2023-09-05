CREATE TABLE if not exists DWH_FACT_PRODUCTS(
product_id bigint,
brand varchar(128),
product_line varchar(128),
product_class varchar(128),
product_size varchar(128),
list_price real,
standard_cost real,
product_first_sold_date varchar(128),
create_dt date,
update_dt date
);

CREATE TRIGGER if not exists update_trigger_DWH_FACT_PRODUCTS AFTER UPDATE
    ON DWH_FACT_PRODUCTS
    BEGIN
        update DWH_FACT_PRODUCTS SET update_dt = current_timestamp WHERE
        product_id = NEW.product_id;
    END;

CREATE TRIGGER if not exists insert_trigger_DWH_FACT_PRODUCTS AFTER INSERT
    ON DWH_FACT_PRODUCTS
    BEGIN
        update DWH_FACT_PRODUCTS SET (create_dt, update_dt) =
        (current_timestamp, current_timestamp) WHERE
        product_id = NEW.product_id;
    END;