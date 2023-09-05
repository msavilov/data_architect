import datetime
import os
import shutil
from py_scripts.utils import (
    create_db,
    create_new_dwh,
    download_data,
    make_files,
    stg_and_dwh,
)


DATASET_NAME = 'tforsyth/99bikes-sales-data'
SHEETS = ['Transactions', 'CustomerDemographic', 'CustomerAddress']
FILE_NAME = '99Bikers_Raw_data.xlsx'
CUR_DT = str(datetime.datetime.now().date())


def main():

    input_path = 'input_data/'
    archive_path = 'archive/'

    create_db()
    download_data(DATASET_NAME, input_path)
    make_files(input_path, SHEETS, FILE_NAME, CUR_DT)
    input_files = os.listdir(input_path)
    archive_files = os.listdir(archive_path)

    new_files = [x for x in input_files if x
                 + f'-{CUR_DT}.dump' not in archive_files]
    for i in new_files:
        stg_and_dwh(input_path, i)
        shutil.copy(f"{input_path}{i}", f"{archive_path}{i}.dump")
    create_new_dwh()


if __name__ == '__main__':
    main()
