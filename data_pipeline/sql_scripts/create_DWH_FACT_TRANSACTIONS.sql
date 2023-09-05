CREATE TABLE if not exists DWH_FACT_TRANSACTIONS(
transaction_id bigint primary key,
product_id bigint,
customer_id bigint,
transaction_date date,
online_order varchar(128),
order_status varchar(128),
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

CREATE TRIGGER if not exists update_trigger_DWH_FACT_TRANSACTIONS AFTER UPDATE
    ON DWH_FACT_TRANSACTIONS
    BEGIN
        update DWH_FACT_TRANSACTIONS SET update_dt = current_timestamp WHERE
        transaction_id = NEW.transaction_id;
    END;

CREATE TRIGGER if not exists insert_trigger_DWH_FACT_TRANSACTIONS AFTER INSERT
    ON DWH_FACT_TRANSACTIONS
    BEGIN
        update DWH_FACT_TRANSACTIONS SET (create_dt, update_dt) =
        (current_timestamp, current_timestamp) WHERE
        transaction_id = NEW.transaction_id;
    END;