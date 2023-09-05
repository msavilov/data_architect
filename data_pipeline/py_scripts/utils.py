import kaggle
import os
import pandas as pd

from py_scripts.connection import Connection
from py_scripts.creds import DB_PATH, tables_info
from py_scripts.elt_task import EtlTask


def create_db():
    if not os.path.exists(DB_PATH):
        with open(DB_PATH, 'w'): pass


def download_data(dataset: str, input_path: str):
    """Download dataset from Kaggle"""
    kaggle.api.authenticate()
    kaggle.api.dataset_download_files(dataset,
                                      path=input_path,
                                      unzip=True)


def read_data(path: str) -> pd.DataFrame:
    """Choice method for read files"""
    name = path.split('.')
    if name[-1] == 'xlsx':
        return pd.read_excel(path)
    elif name[-1] == 'txt':
        return pd.read_csv(path, sep=';')
    elif name[-1] == 'dump':
        return read_data(".".join(name[:-1]))


def check_default_field(df: pd.DataFrame) -> None:
    """Check and del trash field"""
    if 'default' in df.columns.values.tolist():
        df.drop('default', axis=1, inplace=True)


def make_files(folder_path: str, sheets: list,
               file_name: str, date: str) -> None:
    """Make files for each sheets in dataset"""
    for sheet in sheets:
        df = pd.read_excel(f'{folder_path}{file_name}', sheet_name=sheet)
        check_default_field(df)
        df.to_excel(f'{folder_path}{sheet}-{date}.xlsx',
                    sheet_name='sheet', index=False)


def create_new_dwh():
    """CREATE NEW DWH TABLES IN DB"""
    conn = Connection(DB_PATH)
    new_tables = ['CUSTOMERS', 'PRODUCTS']
    for i in new_tables:
        conn.read_sql_script(tables_info[i]['dwh_create'])
        conn.read_sql_script(tables_info[i]['dwh_insert'])


def stg_and_dwh(folder_path, file_name):
    """Make table and insert date in DB"""
    data = read_data(f'{folder_path}{file_name}')
    task = EtlTask(DB_PATH)
    if 'Address' in file_name:
        table_stg = 'STG_CUSTOMER_ADDRESS'
        dwh_create_scr = tables_info['CUSTOMER_ADDRESS']['dwh_create']
        dwh_insert_scr = tables_info['CUSTOMER_ADDRESS']['dwh_insert']
    elif 'Demographic' in file_name:
        table_stg = 'STG_CUSTOMER_DEMOGRAPHIC'
        dwh_create_scr = tables_info['CUSTOMER_DEMOGRAPHIC']['dwh_create']
        dwh_insert_scr = tables_info['CUSTOMER_DEMOGRAPHIC']['dwh_insert']
    else:
        table_stg = 'STG_TRANSACTIONS'
        dwh_create_scr = tables_info['TRANSACTIONS']['dwh_create']
        dwh_insert_scr = tables_info['TRANSACTIONS']['dwh_insert']

    task.initialize_stg(table_stg)
    task.ist_data_to_stg(table_stg, data)
    task.make_dwh(dwh_create_scr)
    task.make_dwh(dwh_insert_scr)
