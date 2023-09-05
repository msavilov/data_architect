tables_info = {
    'TRANSACTIONS': {
        'std': './sql_scripts/create_STG_TRANSACTIONS.sql',
        'dwh_create': './sql_scripts/create_DWH_FACT_TRANSACTIONS.sql',
        'dwh_insert': './sql_scripts/insert_DWH_FACT_TRANSACTIONS.sql',
    },
    'CUSTOMER_ADDRESS': {
        'std': './sql_scripts/create_STG_CUSTOMER_ADDRESS.sql',
        'dwh_create': './sql_scripts/create_DWH_FACT_CUSTOMER_ADDRESS.sql',
        'dwh_insert': './sql_scripts/insert_DWH_FACT_CUSTOMER_ADDRESS.sql',
    },
    'CUSTOMER_DEMOGRAPHIC': {
        'std': './sql_scripts/create_STG_CUSTOMER_DEMOGRAPHIC.sql',
        'dwh_create': './sql_scripts/create_DWH_FACT_CUSTOMER_DEMOGRAPHIC.sql',
        'dwh_insert': './sql_scripts/insert_DWH_FACT_CUSTOMER_DEMOGRAPHIC.sql',
    },
    'CUSTOMERS': {
        'dwh_create': './sql_scripts/create_DWH_FACT_CUSTOMERS.sql',
        'dwh_insert': './sql_scripts/insert_DWH_FACT_CUSTOMERS.sql',
    },
    'PRODUCTS': {
        'dwh_create': './sql_scripts/create_DWH_FACT_PRODUCTS.sql',
        'dwh_insert': './sql_scripts/insert_DWH_FACT_PRODUCTS.sql',
    },
}

DB_PATH = 'mydb.db'
