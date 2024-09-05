import os
from pathlib import Path
import psycopg2


# === CONFIGURATION SECTION ===
# Main admin account credentials
SQL_HOST: str = os.getenv("SQL_HOST")
SQL_PORT: int = int(os.getenv("SQL_PORT", 5432))
SQL_DATABASE: str = os.getenv("SQL_DATABASE")
SQL_USER: str = os.getenv("SQL_USER")
SQL_PASSWORD: str = os.getenv("SQL_PASSWORD")
# Username of the student (propagates as the database name)
STUDENT_ACCOUNT: str = os.getenv("STUDENT_ACCOUNT")
STUDENT_PASSWORD: str = os.getenv("STUDENT_PASSWORD")
# Path to the file with CREATE statements for the database
TABLE_CREATE_STATEMENTS_PATH: Path = Path("default-data/create_statements.sql")
TABLE_INSERT_STATEMENTS_PATH: Path = Path("default-data/insert_statements.sql")
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# === CREATE CONNECTOR ===
connection = psycopg2.connect(
    database=SQL_DATABASE,
    user=SQL_USER,
    password=SQL_PASSWORD,
    host=SQL_HOST,
    port=SQL_PORT
)
cursor = connection.cursor()
connection.autocommit = True
# ~~~~~~~~~~~~~~~~~~~~~~~~

# === CREATE A DATABASE ===
create_database_sql: str = f"CREATE DATABASE {STUDENT_ACCOUNT};"
cursor.execute(create_database_sql)
# ~~~~~~~~~~~~~~~~~~~~~~~~~

# === CREATE A USER AND GRANT PRIVILEGES TO DB ==
cursor.execute(f"""CREATE USER {STUDENT_ACCOUNT} WITH ENCRYPTED PASSWORD '{STUDENT_PASSWORD}';
GRANT ALL PRIVILEGES ON DATABASE {STUDENT_ACCOUNT} TO {STUDENT_ACCOUNT};""")
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# === CLOSE CONNECTION ===
cursor.close()
connection.close()
# ~~~~~~~~~~~~~~~~~~~~~~~~

# === CREATE CONNECTOR ===
connection = psycopg2.connect(
    database=STUDENT_ACCOUNT,
    user=SQL_USER,
    password=SQL_PASSWORD,
    host=SQL_HOST,
    port=SQL_PORT
)
cursor = connection.cursor()
connection.autocommit = True
# ~~~~~~~~~~~~~~~~~~~~~~~~


# === CREATE A USER AND GRANT PRIVILEGES TO DB ==
cursor.execute(f"""GRANT ALL ON SCHEMA public TO {STUDENT_ACCOUNT};""")
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# === CLOSE CONNECTION ===
cursor.close()
connection.close()
# ~~~~~~~~~~~~~~~~~~~~~~~~

# === CREATE CONNECTOR ===
connection = psycopg2.connect(
    database=STUDENT_ACCOUNT,
    user=STUDENT_ACCOUNT,
    password=STUDENT_PASSWORD,
    host=SQL_HOST,
    port=SQL_PORT
)
cursor = connection.cursor()
connection.autocommit = True
# ~~~~~~~~~~~~~~~~~~~~~~~~

# === CREATE TABLES INSIDE DATABASE ===
create_tables_sql: str = TABLE_CREATE_STATEMENTS_PATH.open().read()
cursor.execute(create_tables_sql)
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# === INSERT ROWS INSIDE TABLES ===
insert_statements_sql: str = TABLE_INSERT_STATEMENTS_PATH.open().read()
cursor.execute(insert_statements_sql)
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# === CLOSE CONNECTION ===
cursor.close()
connection.close()
# ~~~~~~~~~~~~~~~~~~~~~~~~
