
# IMPORTING REQUIRED PYTHON LIBRARIES
# -----------------------------------------

import os  # Built-in module to interact with the operating system (for folder and file handling)
import pandas as pd  # Powerful library for reading, manipulating, and analyzing data
from sqlalchemy import create_engine   # create_engine Used to connect Python to MySQL databases using SQLAlchemy(-SQLAlchemy is a powerful Python library that lets you connect to databases and run SQL queries using both raw SQL and Pythonic ORM-style code.).
from sqlalchemy.engine import URL   # URL is a special helper class in SQLAlchemy used to safely and correctly build database connection strings — especially when your password or other parts contain special characters (like @, :, #, etc.).



# Path to the folder where your CSV files are stored
file_path= "../OLA Dataset/OLA_Bookings.csv" 


# =========== CONNECT TO MYSQL USING SQLALCHEMY =============
# -----------------------------------------

try:
    # Use SQLAlchemy's URL builder
    url = URL.create(   
        drivername="mysql+mysqlconnector",
        username="root",
        password="---",  # write your actual password while connecting
        host="localhost",
        database="ola"
    )
    engine = create_engine(url)   # Connect to MySQL local server considering 'OLA' database
except Exception as e:
    raise  # Stop script if connection fails






# ============== Ingest dataframes (raw csv files) into database tables ==============
# -----------------------------------------------------------------------
def ingest_db(df, table_name, engine):  # Called inside below 'load_raw_data' function.
    
    # df.to_sql(name=table_name, con=engine, index=False, if_exists='replace')  # --> Was unable to handle very large file like 30 lakhs or crore data records
    
    with engine.begin() as connection:   #  engine.begin() → Ensures transactions are handled properly
        df.to_sql(name=table_name, con=connection, index=False, if_exists='replace', chunksize=10000, method='multi')  
                 # chunksize=10000 → Sends data in smaller, safer batches
                 # method='multi' → Executes multiple inserts per batch (faster)




# ============== LOAD/PROCESS EACH CSV FILE IN THE FOLDER ==============
# -----------------------------------------
def load_raw_data():     # Using functional programming approach
    df = pd.read_csv(file_path)

    table_name = "ola_bookings"
    # Upload DataFrame to MySQL as a new table or overwrite existing one
    ingest_db(df, table_name, engine)  # Call to function that actually injects this to DB table
    print("All files have been processed. Check 'logs/ingestion_log.txt' for detailed logs.")


#======================== Calling it
if __name__ == "__main__":   # Run Only run this part of the script if the script is being run directly (like python ingestion_db.py in terminal)— not run when it’s imported somewhere else and then run that script (i.e, if it is called here directly then work, But when some else is imported our script like 'from ingestion_db import load_raw_data', then this part should not work.).
    load_raw_data()
#== ended here
