import os
import psycopg2


# === CONFIGURATION SECTION ===
# Main admin account credentials
SQL_HOST: str = os.getenv("SQL_HOST")
SQL_PORT: int = int(os.getenv("SQL_PORT", 5432))
SQL_DATABASE: str = os.getenv("SQL_DATABASE")
SQL_USER: str = os.getenv("SQL_DATABASE")
SQL_PASSWORD: str = os.getenv("SQL_PASSWORD")
# Username of the student (propagates as the database name)
STUDENT_ACCOUNT: str = os.getenv("STUDENT_ACCOUNT")
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

# === DROP A DATABASE ===
create_database_sql: str = f"DROP DATABASE {STUDENT_ACCOUNT};"
cursor.execute(create_database_sql)
# ~~~~~~~~~~~~~~~~~~~~~~~

# === CREATE A USER AND GRANT PRIVILEGES TO DB ==
cursor.execute(f"""DROP USER {STUDENT_ACCOUNT};""")
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# === CLOSE CONNECTION ===
cursor.close()
connection.close()
# ~~~~~~~~~~~~~~~~~~~~~~~~
