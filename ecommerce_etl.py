'''import pandas as pd
import requests
import os

from sqlalchemy import create_engine

print("Libraries imported successfully!")

import pandas as pd
import os

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
INPUT_DIR = os.path.join(BASE_DIR, "input")

customers = pd.read_csv(os.path.join(INPUT_DIR, "customers.csv"))

print("CUSTOMER DATA LOADED SUCCESSFULLY")

# 1. Find missing customer names
missing_name = customers[customers["customer_name"].isnull()]

print("\n1. Missing Customer Names:")
print(missing_name)


# 2. Find missing emails
missing_email = customers[customers["email"].isnull()]

print("\n2. Missing Emails:")
print(missing_email)


# 3. Find duplicate customers using customer_id
duplicate_customer = customers[
    customers.duplicated(subset=["customer_id"], keep=False)
]

print("\n3. Duplicate Customers:")
print(duplicate_customer)


# 4. Find extra spaces in customer data
space_columns = ["customer_id", "customer_name", "email", "city"]

for column in space_columns:
    mask = customers[column].astype("string").str.contains(
        r"^\s|\s$", na=False
    )

    print(f"\n4. Extra Spaces in {column}:")
    print(customers[mask])


# 5. Find different capitalization in customer names
print("\n5. Customer Names with Different Capitalization:")

name_case = customers[
    customers["customer_name"].notna() &
    (customers["customer_name"] != customers["customer_name"].str.title())
]

print(name_case[["customer_id", "customer_name"]])


# 6. Find invalid email formats
email_pattern = r"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"

invalid_email = customers[
    customers["email"].notna() &
    ~customers["email"].str.strip().str.match(email_pattern, na=False)
]

print("\n6. Invalid Email Formats:")
print(invalid_email[["customer_id", "email"]])


# 7. Find missing cities
missing_city = customers[customers["city"].isnull()]

print("\n7. Missing Cities:")
print(missing_city)


print("\nCUSTOMER DATA QUALITY CHECK COMPLETED")

#STEP 3 — Create products.csv
import pandas as pd
import os

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
INPUT_DIR = os.path.join(BASE_DIR, "input")

products = pd.read_csv(os.path.join(INPUT_DIR, "products.csv"))

print("PRODUCT DATA LOADED SUCCESSFULLY")
print(products)
# 1. Find duplicate products using product_id
duplicate_products = products[
    products.duplicated(subset=["product_id"], keep=False)
]

print("\n1. DUPLICATE PRODUCTS:")
print(duplicate_products)


# 2. Find missing category
missing_category = products[products["category"].isnull()]

print("\n2. MISSING CATEGORY:")
print(missing_category)


# 3. Find negative stock
negative_stock = products[products["stock"] < 0]

print("\n3. NEGATIVE STOCK:")
print(negative_stock)


# 4. Find missing price
missing_price = products[products["price"].isnull()]

print("\n4. MISSING PRICE:")
print(missing_price)


# 5. Find extra spaces
space_columns = ["product_id", "product_name", "category"]

for column in space_columns:
    extra_spaces = products[
        products[column].astype("string").str.contains(
            r"^\s|\s$", na=False
        )
    ]

    print(f"\n5. EXTRA SPACES IN {column.upper()}:")
    print(extra_spaces)


# 6. Find different capitalization in category
different_case = products[
    products["category"].notna() &
    (products["category"] != products["category"].str.title())
]

print("\n6. DIFFERENT CAPITALIZATION IN CATEGORY:")
print(different_case[["product_id", "category"]])


print("\nPRODUCT DATA QUALITY CHECK COMPLETED")

#STEP 4 — Create orders.csv
import pandas as pd
import os

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
INPUT_DIR = os.path.join(BASE_DIR, "input")

customers = pd.read_csv(os.path.join(INPUT_DIR, "customers.csv"))
products = pd.read_csv(os.path.join(INPUT_DIR, "products.csv"))
orders = pd.read_csv(os.path.join(INPUT_DIR, "orders.csv"))

print("ALL CSV FILES LOADED SUCCESSFULLY")

# 1. Find invalid customer IDs
invalid_customer = orders[
    ~orders["customer_id"].isin(customers["customer_id"])
]

print("\n1. INVALID CUSTOMER IDs:")
print(invalid_customer)


# 2. Find invalid product IDs
invalid_product = orders[
    ~orders["product_id"].isin(products["product_id"])
]

print("\n2. INVALID PRODUCT IDs:")
print(invalid_product)


# 3. Find quantity equal to zero
zero_quantity = orders[orders["quantity"] == 0]

print("\n3. ZERO QUANTITY:")
print(zero_quantity)


# 4. Find negative quantity
negative_quantity = orders[orders["quantity"] < 0]

print("\n4. NEGATIVE QUANTITY:")
print(negative_quantity)


# 5. Find missing order date
missing_date = orders[orders["order_date"].isnull()]

print("\n5. MISSING ORDER DATE:")
print(missing_date)


# 6. Find invalid date formats or values
parsed_dates = pd.to_datetime(
    orders["order_date"],
    format="mixed",
    errors="coerce"
)

invalid_date = orders[
    orders["order_date"].notna() & parsed_dates.isna()
]

print("\n6. INVALID ORDER DATE:")
print(invalid_date)


# 7. Find negative price
negative_price = orders[orders["price"] < 0]

print("\n7. NEGATIVE PRICE:")
print(negative_price)


# 8. Find duplicate order IDs
duplicate_order = orders[
    orders.duplicated(subset=["order_id"], keep=False)
]

print("\n8. DUPLICATE ORDER IDs:")
print(duplicate_order)


# 9. Find extra spaces in status
extra_spaces = orders[
    orders["status"].astype("string").str.contains(
        r"^\s|\s$", na=False
    )
]

print("\n9. EXTRA SPACES IN STATUS:")
print(extra_spaces)


print("\nORDER DATA QUALITY CHECK COMPLETED")


#PART 2 — EXTRACT AND CLEAN

#STEP 5 — Import Required Python Libraries
# Data Processing
import pandas as pd

# API Requests
import requests

# MySQL Connectivity
from sqlalchemy import create_engine
import pymysql

print("ALL REQUIRED LIBRARIES IMPORTED SUCCESSFULLY")'''

#STEP 6 — Read the Three CSV Files
import pandas as pd
import os

# Define input folder path
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
INPUT_DIR = os.path.join(BASE_DIR, "input")

# Read CSV files into separate DataFrames
customers_df = pd.read_csv(
    os.path.join(INPUT_DIR, "customers.csv")
)

products_df = pd.read_csv(
    os.path.join(INPUT_DIR, "products.csv")
)

orders_df = pd.read_csv(
    os.path.join(INPUT_DIR, "orders.csv")
)

print("ALL THREE CSV FILES LOADED SUCCESSFULLY")

print("\nTOTAL ROWS")

print("Customers:", customers_df.shape[0])
print("Products:", products_df.shape[0])
print("Orders:", orders_df.shape[0])
print("\nTOTAL COLUMNS")

print("Customers:", customers_df.shape[1])
print("Products:", products_df.shape[1])
print("Orders:", orders_df.shape[1])
dataframes = {
    "Customers": customers_df,
    "Products": products_df,
    "Orders": orders_df
}

print("\nDATAFRAME VERIFICATION")

for name, df in dataframes.items():
    print("\n", name)
    print("Rows:", df.shape[0])
    print("Columns:", df.shape[1])
    print("Column Names:", df.columns.tolist())

#STEP 7 — Profile the Raw Data

def profile_data(df, table_name):

    print("\n===================================")
    print(table_name, "DATA PROFILING")
    print("===================================")

    # 1. Number of rows
    print("\nTotal Rows:", df.shape[0])

    # 2. Number of columns
    print("Total Columns:", df.shape[1])

    # 3. Column names
    print("\nColumn Names:")
    print(df.columns.tolist())

    # 4. Data types
    print("\nData Types:")
    print(df.dtypes)

    # 5. Missing values
    print("\nMissing Values:")
    print(df.isnull().sum())

    # 6. Duplicate records
    print("\nDuplicate Records:", df.duplicated().sum())


# Profile all three DataFrames

profile_data(customers_df, "CUSTOMERS")

profile_data(products_df, "PRODUCTS")

profile_data(orders_df, "ORDERS")

print("\nRAW DATA PROFILING COMPLETED")

#STEP 8 — Clean Customer Data
# STEP 8: CUSTOMER DATA CLEANING

# Create a copy of original data
customers_clean = customers_df.copy()

print("CUSTOMER DATA CLEANING STARTED")

# Remove leading and trailing spaces
text_columns = ["customer_id", "customer_name", "email", "city"]

for column in text_columns:
    customers_clean[column] = customers_clean[column].str.strip()

print("EXTRA SPACES REMOVED")
# Standardize customer names and cities
customers_clean["customer_name"] = customers_clean["customer_name"].str.title()

customers_clean["city"] = customers_clean["city"].str.title()

# Convert email to lowercase
customers_clean["email"] = customers_clean["email"].str.lower()

print("CAPITALIZATION STANDARDIZED")

     #Step 5: Remove duplicate customer IDs
# Identify duplicate customer IDs
duplicate_customers = customers_clean[
    customers_clean.duplicated(
        subset=["customer_id"], keep="first"
    )
].copy()

# Keep the first customer record
customers_clean = customers_clean.drop_duplicates(
    subset=["customer_id"], keep="first"
)

print("DUPLICATE CUSTOMERS IDENTIFIED AND REMOVED")     

          #Step 6: Find missing and invalid values
# Email validation pattern
email_pattern = r"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"

# Check missing customer name
missing_name = customers_clean["customer_name"].isnull()

# Check missing email
missing_email = customers_clean["email"].isnull()

# Check missing city
missing_city = customers_clean["city"].isnull()

# Check invalid email
invalid_email = (
    customers_clean["email"].notna() &
    ~customers_clean["email"].str.match(email_pattern, na=False)
)

# Combine all rejection conditions
reject_condition = (
    missing_name |
    missing_email |
    missing_city |
    invalid_email
)

# Store rejected records separately
rejected_customers = customers_clean[reject_condition].copy()

# Keep only valid customer records
customers_clean = customers_clean[~reject_condition].copy()

print("INVALID CUSTOMER RECORDS IDENTIFIED")         

      #Step 7: Save cleaned and rejected records
# Create output folder if it does not exist
OUTPUT_DIR = os.path.join(BASE_DIR, "output")
os.makedirs(OUTPUT_DIR, exist_ok=True)

# Save cleaned customer data
customers_clean.to_csv(
    os.path.join(OUTPUT_DIR, "customers_clean.csv"),
    index=False
)

# Save rejected customer data
rejected_customers.to_csv(
    os.path.join(OUTPUT_DIR, "rejected_customers.csv"),
    index=False
)

# Save duplicate customer records
duplicate_customers.to_csv(
    os.path.join(OUTPUT_DIR, "duplicate_customers.csv"),
    index=False
)

print("\nCUSTOMER DATA CLEANING COMPLETED")
print("Valid Customers:", len(customers_clean))
print("Rejected Customers:", len(rejected_customers))
print("Duplicate Customers:", len(duplicate_customers))  

#STEP 9 — Clean Product Data
# STEP 9: PRODUCT DATA CLEANING

# Create a copy of original product data
products_clean = products_df.copy()

print("PRODUCT DATA CLEANING STARTED")

# Remove leading and trailing spaces
text_columns = ["product_id", "product_name", "category"]

for column in text_columns:
    products_clean[column] = products_clean[column].str.strip()

print("EXTRA SPACES REMOVED")

# Standardize product names and categories
products_clean["product_name"] = (
    products_clean["product_name"].str.title()
)

products_clean["category"] = (
    products_clean["category"].str.title()
)

print("CAPITALIZATION STANDARDIZED")
# Identify duplicate product IDs
duplicate_products = products_clean[
    products_clean.duplicated(
        subset=["product_id"],
        keep="first"
    )
].copy()

# Keep the first occurrence
products_clean = products_clean.drop_duplicates(
    subset=["product_id"],
    keep="first"
)

print("DUPLICATE PRODUCTS IDENTIFIED")

# Convert price and stock into numeric values
products_clean["price"] = pd.to_numeric(
    products_clean["price"],
    errors="coerce"
)

products_clean["stock"] = pd.to_numeric(
    products_clean["stock"],
    errors="coerce"
)

# Check missing product ID
missing_id = products_clean["product_id"].isnull()

# Check missing product name
missing_name = products_clean["product_name"].isnull()

# Check missing category
missing_category = products_clean["category"].isnull()

# Check missing or invalid price
invalid_price = (
    products_clean["price"].isnull() |
    (products_clean["price"] <= 0)
)

# Check missing or negative stock
invalid_stock = (
    products_clean["stock"].isnull() |
    (products_clean["stock"] < 0)
)

# Combine all rejection conditions
reject_condition = (
    missing_id |
    missing_name |
    missing_category |
    invalid_price |
    invalid_stock
)

# Store rejected records
rejected_products = products_clean[
    reject_condition
].copy()

# Keep valid products
products_clean = products_clean[
    ~reject_condition
].copy()

print("PRODUCT VALIDATION COMPLETED")

# Create output folder
OUTPUT_DIR = os.path.join(BASE_DIR, "output")
os.makedirs(OUTPUT_DIR, exist_ok=True)

# Save valid products
products_clean.to_csv(
    os.path.join(OUTPUT_DIR, "products_clean.csv"),
    index=False
)

# Save rejected products
rejected_products.to_csv(
    os.path.join(OUTPUT_DIR, "rejected_products.csv"),
    index=False
)

# Save duplicate products
duplicate_products.to_csv(
    os.path.join(OUTPUT_DIR, "duplicate_products.csv"),
    index=False
)

print("\nPRODUCT DATA CLEANING COMPLETED")

print("Original Products:", len(products_df))
print("Valid Products:", len(products_clean))
print("Rejected Products:", len(rejected_products))
print("Duplicate Products:", len(duplicate_products))

#STEP 10 — Clean Order Data
# STEP 10: ORDER DATA CLEANING

# Create a copy of original order data
orders_clean = orders_df.copy()

print("ORDER DATA CLEANING STARTED")
# Remove leading and trailing spaces
text_columns = ["order_id", "customer_id", "product_id", "status"]

for column in text_columns:
    orders_clean[column] = orders_clean[column].str.strip()

print("EXTRA SPACES REMOVED")
# Identify duplicate order IDs
duplicate_orders = orders_clean[
    orders_clean.duplicated(
        subset=["order_id"],
        keep="first"
    )
].copy()

# Keep only the first occurrence
orders_clean = orders_clean.drop_duplicates(
    subset=["order_id"],
    keep="first"
)

print("DUPLICATE ORDERS IDENTIFIED")
# Get valid customer IDs
valid_customer_ids = customers_clean["customer_id"]

# Get valid product IDs
valid_product_ids = products_clean["product_id"]

# Check whether customer ID exists
invalid_customer = ~orders_clean["customer_id"].isin(
    valid_customer_ids
)

# Check whether product ID exists
invalid_product = ~orders_clean["product_id"].isin(
    valid_product_ids
)

print("CUSTOMER AND PRODUCT ID VALIDATION COMPLETED")
# Convert quantity and price into numeric values
orders_clean["quantity"] = pd.to_numeric(
    orders_clean["quantity"],
    errors="coerce"
)

orders_clean["price"] = pd.to_numeric(
    orders_clean["price"],
    errors="coerce"
)

# Quantity must be greater than zero
invalid_quantity = (
    orders_clean["quantity"].isnull() |
    (orders_clean["quantity"] <= 0)
)

# Price must not be negative
invalid_price = (
    orders_clean["price"].isnull() |
    (orders_clean["price"] < 0)
)

print("QUANTITY AND PRICE VALIDATION COMPLETED")
# Convert order_date into proper date format
orders_clean["order_date"] = pd.to_datetime(
    orders_clean["order_date"],
    format="mixed",
    errors="coerce"
)

# Find missing or invalid dates
invalid_date = orders_clean["order_date"].isnull()

print("ORDER DATE VALIDATION COMPLETED")
# Combine all rejection conditions
reject_condition = (
    invalid_customer |
    invalid_product |
    invalid_quantity |
    invalid_price |
    invalid_date
)

# Store rejected orders separately
rejected_orders = orders_clean[
    reject_condition
].copy()

# Keep only valid orders
orders_clean = orders_clean[
    ~reject_condition
].copy()

print("ORDER VALIDATION COMPLETED")
# Create output folder if it does not exist
OUTPUT_DIR = os.path.join(BASE_DIR, "output")
os.makedirs(OUTPUT_DIR, exist_ok=True)

# Save valid orders
orders_clean.to_csv(
    os.path.join(OUTPUT_DIR, "orders_clean.csv"),
    index=False
)

# Save rejected orders
rejected_orders.to_csv(
    os.path.join(OUTPUT_DIR, "rejected_orders.csv"),
    index=False
)

# Save duplicate orders
duplicate_orders.to_csv(
    os.path.join(OUTPUT_DIR, "duplicate_orders.csv"),
    index=False
)

print("\nORDER DATA CLEANING COMPLETED")

print("Original Orders:", len(orders_df))
print("Valid Orders:", len(orders_clean))
print("Rejected Orders:", len(rejected_orders))
print("Duplicate Orders:", len(duplicate_orders))


#PART 3 — API HANDLING

#STEP 11 — Send API Request-Connect Python to JSONPlaceholder using requests.get().

import requests

api_url = "https://jsonplaceholder.typicode.com/users"

response = requests.get(api_url)

print("API REQUEST SENT SUCCESSFULLY")

#STEP 12 — Check API Response- Verify whether the API request was successful using the status code.


print("Status Code:", response.status_code)

if response.status_code == 200:
    print("API RESPONSE SUCCESSFUL")
else:
    print("API REQUEST FAILED")

# STEP 13: EXTRACT JSON DATA

if response.status_code == 200:

    api_data = response.json()

    print("API DATA EXTRACTED SUCCESSFULLY")

    print(api_data)

# STEP 14: CONVERT JSON INTO DATAFRAME

if response.status_code == 200:

    api_users_df = pd.json_normalize(api_data)

    print("\nAPI DATAFRAME")
    print(api_users_df.head())

    print("\nTotal API Records:", len(api_users_df))

    print("Total API Columns:", len(api_users_df.columns))


# STEP 15: SAVE API DATA

if response.status_code == 200:

    OUTPUT_DIR = os.path.join(BASE_DIR, "output")
    os.makedirs(OUTPUT_DIR, exist_ok=True)

    api_users_df.to_csv(
        os.path.join(OUTPUT_DIR, "api_users.csv"),
        index=False
    )

    print("API DATA SAVED SUCCESSFULLY")

#STEP 11 — Understand the API Requirement


# STEP 11: UNDERSTAND THE API REQUIREMENT

api_url = "https://jsonplaceholder.typicode.com/users"

# Required information from API
required_columns = ["id", "name", "email", "address.city"]

print("API URL:", api_url)
print("Required API Fields:", required_columns)
print("Purpose: Retrieve additional information from an external API")



# STEP 12: SEND API REQUEST AND RECEIVE RESPONSE

api_url = "https://jsonplaceholder.typicode.com/users"

# Send GET request
response = requests.get(api_url)

# Inspect response status
print("Response Status:", response.status_code)

# Inspect response content
print("\nResponse Content:")
print(response.text)

# Inspect response data type
print("\nResponse Data Type:")
print(type(response))


# STEP 13: CONVERT API RESPONSE INTO USABLE DATA

if response.status_code == 200:

    # Extract JSON data from API response
    api_data = response.json()

    # Convert API data into DataFrame
    api_df = pd.json_normalize(api_data)

    # Select only required columns and rename them
    api_customers_df = api_df[
        ["id", "name", "email", "address.city"]
    ].copy()

    api_customers_df = api_customers_df.rename(columns={
        "id": "api_customer_id",
        "name": "api_customer_name",
        "email": "api_email",
        "address.city": "api_city"
    })

    print("\nAPI CUSTOMER DATAFRAME")
    print(api_customers_df)

    print("\nTotal API Records:", len(api_customers_df))
    print("\nRequired Columns:")
    print(api_customers_df.columns.tolist())

else:
    print("API request failed. Status Code:", response.status_code)


# STEP 14: COMPARE API DATA WITH CUSTOMER DATA

# 1. Find IDs available in both sources
common_ids = set(customers_df["customer_id"].dropna()) & set(
    api_customers_df["api_customer_id"].dropna()
)

# 2. Find IDs available only in CSV
csv_only_ids = set(customers_df["customer_id"].dropna()) - set(
    api_customers_df["api_customer_id"].dropna()
)

# 3. Find IDs available only in API
api_only_ids = set(api_customers_df["api_customer_id"].dropna()) - set(
    customers_df["customer_id"].dropna()
)

print("\nCOMMON CUSTOMER IDs:")
print(common_ids)

print("\nCUSTOMER IDs ONLY IN CSV:")
print(csv_only_ids)

print("\nCUSTOMER IDs ONLY IN API:")
print(api_only_ids)


# STEP 15: ENRICH CUSTOMER DATA USING API INFORMATION

# Create a copy of cleaned customer data
enriched_customers_df = customers_clean.copy()

# Select required customer columns
enriched_customers_df = enriched_customers_df[
    ["customer_id", "customer_name", "email", "city"]
]

# Display enriched customer data
print("\nENRICHED CUSTOMER DATA")
print(enriched_customers_df)

print("\nTotal Enriched Customers:",
      len(enriched_customers_df))

print("\nEnriched Customer Columns:")
print(enriched_customers_df.columns.tolist())

# Save enriched customer data
enriched_customers_df.to_csv(
    os.path.join(OUTPUT_DIR, "enriched_customers.csv"),
    index=False
)

print("\nENRICHED CUSTOMER DATA SAVED SUCCESSFULLY")


#PART 4 — TRANSFORMATION

# STEP 16: SELECT ONLY VALID COMPLETED ORDERS

# Select only orders with Completed status
valid_sales_orders = orders_clean[
    orders_clean["status"].str.strip().str.lower() == "completed"
].copy()

# Display valid sales orders
print("\nVALID COMPLETED SALES ORDERS")
print(valid_sales_orders)

# Display total records
print("\nTotal Valid Sales Orders:", len(valid_sales_orders))

# Display excluded orders
print("\nCancelled Orders:",
      len(orders_clean) - len(valid_sales_orders))

# Save valid sales orders

valid_sales_orders.to_csv(
    os.path.join(OUTPUT_DIR, "valid_sales_orders.csv"),
    index=False
)

print("\nVALID SALES ORDERS SAVED SUCCESSFULLY")

#STEP 17 — Join Orders with Products

# STEP 17: JOIN ORDERS WITH PRODUCTS

# 1. Check columns in valid sales orders
print("\nORDERS COLUMNS:")
print(valid_sales_orders.columns.tolist())

# 2. Check columns in cleaned products
print("\nPRODUCT COLUMNS:")
print(products_clean.columns.tolist())


# 3. Merge orders with product information
sales_products_df = pd.merge(
    valid_sales_orders,
    products_clean,
    on="product_id",
    how="inner"
)


# 4. Check merged DataFrame columns
print("\nMERGED DATAFRAME COLUMNS:")
print(sales_products_df.columns.tolist())


# 5. Select only required columns
required_columns = [
    "order_id",
    "customer_id",
    "product_id",
    "quantity",
    "price",
    "order_date",
    "status",
    "product_name",
    "category",
    "stock"
]

# Check whether all required columns exist
missing_columns = [
    column for column in required_columns
    if column not in sales_products_df.columns
]

if missing_columns:
    print("\nMISSING COLUMNS:", missing_columns)

else:
    sales_products_df = sales_products_df[required_columns]

    # 6. Display final merged data
    print("\nORDERS JOINED WITH PRODUCTS")
    print(sales_products_df)

    print("\nTOTAL RECORDS:", len(sales_products_df))
    print("TOTAL COLUMNS:", len(sales_products_df.columns))

    # 7. Save merged data
    sales_products_df.to_csv(
        os.path.join(OUTPUT_DIR, "sales_products.csv"),
        index=False
    )

    print("\nSALES AND PRODUCT DATA SAVED SUCCESSFULLY")


# STEP 18: JOIN WITH CUSTOMER DATA

# STEP 18: JOIN WITH CUSTOMER DATA

# 1. Check sales and product columns
print("\nSALES PRODUCT COLUMNS:")
print(sales_products_df.columns.tolist())

# 2. Check customer columns
print("\nCUSTOMER COLUMNS:")
print(customers_clean.columns.tolist())

# 3. Correct the price column name
if "price_x" in sales_products_df.columns:
    sales_products_df = sales_products_df.rename(
        columns={"price_x": "price"}
    )

# If price_y exists, remove it because we are keeping order price
if "price_y" in sales_products_df.columns:
    sales_products_df = sales_products_df.drop(
        columns=["price_y"]
    )

# 4. Select required customer columns
customer_details = customers_clean[
    ["customer_id", "customer_name", "email", "city"]
].copy()

# 5. Merge sales and customer data
final_sales_df = pd.merge(
    sales_products_df,
    customer_details,
    on="customer_id",
    how="inner"
)

# 6. Check final merged columns
print("\nFINAL MERGED COLUMNS:")
print(final_sales_df.columns.tolist())

# 7. Select required columns
required_columns = [
    "order_id",
    "customer_id",
    "customer_name",
    "email",
    "city",
    "product_id",
    "product_name",
    "category",
    "quantity",
    "price",
    "stock",
    "order_date",
    "status"
]

missing_columns = [
    column for column in required_columns
    if column not in final_sales_df.columns
]

if missing_columns:
    print("\nMISSING COLUMNS:", missing_columns)

else:
    final_sales_df = final_sales_df[required_columns]

    print("\nFINAL CUSTOMER SALES DATA")
    print(final_sales_df)

    print("\nTOTAL RECORDS:", len(final_sales_df))
    print("TOTAL COLUMNS:", len(final_sales_df.columns))

    # 8. Save final dataset
    final_sales_df.to_csv(
        os.path.join(OUTPUT_DIR, "final_sales_data.csv"),
        index=False
    )

    print("\nFINAL SALES DATA SAVED SUCCESSFULLY")


# STEP 19: CREATE SALES CALCULATIONS

# 1. Convert quantity and price into numeric values
final_sales_df["quantity"] = pd.to_numeric(
    final_sales_df["quantity"], errors="coerce"
)

final_sales_df["price"] = pd.to_numeric(
    final_sales_df["price"], errors="coerce"
)

# 2. Calculate sales amount
final_sales_df["sales_amount"] = (
    final_sales_df["quantity"] * final_sales_df["price"]
)

# 3. Display sales calculations
print("\nSALES AMOUNT CALCULATION")
print(
    final_sales_df[
        ["order_id", "quantity", "price", "sales_amount"]
    ]
)

# 4. Check invalid sales amounts
invalid_sales = (
    final_sales_df["sales_amount"].isna()
    | (final_sales_df["sales_amount"] < 0)
)

invalid_sales_df = final_sales_df[invalid_sales].copy()

# 5. Display invalid records
print("\nINVALID SALES RECORDS")
print(invalid_sales_df)

print("\nTotal Invalid Sales Records:", len(invalid_sales_df))

# 6. Display valid sales records
valid_sales_amount_df = final_sales_df[~invalid_sales].copy()

print("\nVALID SALES RECORDS")
print(valid_sales_amount_df)

print("\nTotal Valid Sales Records:", len(valid_sales_amount_df))

# 7. Calculate total sales
print(
    "\nTOTAL SALES AMOUNT:",
    valid_sales_amount_df["sales_amount"].sum()
)

# 8. Save calculated sales data
valid_sales_amount_df.to_csv(
    os.path.join(OUTPUT_DIR, "sales_amount_data.csv"),
    index=False
)

print("\nSALES AMOUNT DATA SAVED SUCCESSFULLY")


# STEP 20: CREATE BUSINESS SUMMARY

# Use valid sales data from STEP 19
sales_df = valid_sales_amount_df.copy()


# ==========================================
# 1. OVERALL BUSINESS SUMMARY
# ==========================================

total_completed_orders = sales_df["order_id"].nunique()

total_quantity_sold = sales_df["quantity"].sum()

total_sales = sales_df["sales_amount"].sum()

overall_summary = pd.DataFrame({
    "total_completed_orders": [total_completed_orders],
    "total_quantity_sold": [total_quantity_sold],
    "total_sales": [total_sales]
})

print("\nOVERALL BUSINESS SUMMARY")
print(overall_summary)


# ==========================================
# 2. PRODUCT-LEVEL SUMMARY
# ==========================================

product_summary = sales_df.groupby(
    "product_name"
).agg(
    quantity_sold=("quantity", "sum"),
    total_sales=("sales_amount", "sum")
).reset_index()

product_summary = product_summary.sort_values(
    by="total_sales", ascending=False
)

print("\nPRODUCT-LEVEL SUMMARY")
print(product_summary)


# ==========================================
# 3. CITY-LEVEL SUMMARY
# ==========================================

city_summary = sales_df.groupby(
    "city"
).agg(
    total_sales=("sales_amount", "sum")
).reset_index()

city_summary = city_summary.sort_values(
    by="total_sales", ascending=False
)

print("\nCITY-LEVEL SUMMARY")
print(city_summary)


# ==========================================
# 4. CATEGORY-LEVEL SUMMARY
# ==========================================

category_summary = sales_df.groupby(
    "category"
).agg(
    total_sales=("sales_amount", "sum")
).reset_index()

category_summary = category_summary.sort_values(
    by="total_sales", ascending=False
)

print("\nCATEGORY-LEVEL SUMMARY")
print(category_summary)


# ==========================================
# 5. FIND HIGHEST SALES AUTOMATICALLY
# ==========================================

highest_sales_product = product_summary.loc[
    product_summary["total_sales"].idxmax()
]

highest_sales_city = city_summary.loc[
    city_summary["total_sales"].idxmax()
]

highest_sales_category = category_summary.loc[
    category_summary["total_sales"].idxmax()
]

print("\nHIGHEST SALES ANALYSIS")

print(
    "Product with Highest Sales:",
    highest_sales_product["product_name"],
    "- ₹",
    highest_sales_product["total_sales"]
)

print(
    "City with Highest Sales:",
    highest_sales_city["city"],
    "- ₹",
    highest_sales_city["total_sales"]
)

print(
    "Category with Highest Sales:",
    highest_sales_category["category"],
    "- ₹",
    highest_sales_category["total_sales"]
)


# ==========================================
# 6. SAVE BUSINESS SUMMARY FILES
# ==========================================

overall_summary.to_csv(
    os.path.join(OUTPUT_DIR, "overall_summary.csv"),
    index=False
)

product_summary.to_csv(
    os.path.join(OUTPUT_DIR, "product_summary.csv"),
    index=False
)

city_summary.to_csv(
    os.path.join(OUTPUT_DIR, "city_summary.csv"),
    index=False
)

category_summary.to_csv(
    os.path.join(OUTPUT_DIR, "category_summary.csv"),
    index=False
)

print("\nALL BUSINESS SUMMARY FILES SAVED SUCCESSFULLY")


# ==========================================
# STEP 21: FINAL DATA QUALITY VALIDATION
# ==========================================

print("\n======================================")
print("FINAL DATA QUALITY VALIDATION")
print("======================================")


# Function to display validation results
def check_result(check_name, condition):
    if condition:
        print("PASS:", check_name)
    else:
        print("FAIL:", check_name)


# ==========================================
# 1. CUSTOMER DATA VALIDATION
# ==========================================

print("\n--- CUSTOMER DATA VALIDATION ---")

# No duplicate customer IDs
check_result(
    "No duplicate customer IDs",
    customers_clean["customer_id"].is_unique
)

# Valid customer ID format (example: C101)
check_result(
    "No invalid customer IDs",
    customers_clean["customer_id"].str.fullmatch(
        r"C\d{3}", na=False
    ).all()
)

# No missing required customer values
required_customer_columns = [
    "customer_id", "customer_name", "email", "city"
]

check_result(
    "No missing customer values",
    customers_clean[required_customer_columns].notna().all().all()
)

# No unnecessary leading or trailing spaces
customer_text_columns = [
    "customer_id", "customer_name", "email", "city"
]

customer_spaces = customers_clean[customer_text_columns].apply(
    lambda column: column.astype("string").eq(
        column.astype("string").str.strip()
    )
).all().all()

check_result(
    "No unnecessary customer spaces",
    customer_spaces
)


# ==========================================
# 2. PRODUCT DATA VALIDATION
# ==========================================

print("\n--- PRODUCT DATA VALIDATION ---")

# No duplicate product IDs
check_result(
    "No duplicate product IDs",
    products_clean["product_id"].is_unique
)

# Valid product ID format (example: P101)
check_result(
    "No invalid product IDs",
    products_clean["product_id"].str.fullmatch(
        r"P\d{3}", na=False
    ).all()
)

# No negative stock
check_result(
    "No negative stock",
    products_clean["stock"].notna().all()
    and (products_clean["stock"] >= 0).all()
)

# No missing or non-positive prices
check_result(
    "No missing or invalid product prices",
    products_clean["price"].notna().all()
    and (products_clean["price"] > 0).all()
)


# ==========================================
# 3. ORDER DATA VALIDATION
# ==========================================

print("\n--- ORDER DATA VALIDATION ---")

# No duplicate order IDs
check_result(
    "No duplicate order IDs",
    orders_clean["order_id"].is_unique
)

# Valid order ID format (example: O1001)
check_result(
    "No invalid order IDs",
    orders_clean["order_id"].str.fullmatch(
        r"O\d{4}", na=False
    ).all()
)

# No invalid customer IDs
check_result(
    "No invalid customer IDs in orders",
    orders_clean["customer_id"].isin(
        customers_clean["customer_id"]
    ).all()
)

# No invalid product IDs
check_result(
    "No invalid product IDs in orders",
    orders_clean["product_id"].isin(
        products_clean["product_id"]
    ).all()
)

# No zero or negative quantity
check_result(
    "No zero or negative quantity",
    orders_clean["quantity"].notna().all()
    and (orders_clean["quantity"] > 0).all()
)

# No negative price
check_result(
    "No negative order price",
    orders_clean["price"].notna().all()
    and (orders_clean["price"] >= 0).all()
)

# No invalid or missing order dates
check_result(
    "No invalid order dates",
    orders_clean["order_date"].notna().all()
)

# No unwanted spaces in order status
status_clean = orders_clean["status"].astype("string")

check_result(
    "No unwanted status spaces",
    status_clean.eq(status_clean.str.strip()).all()
)


# ==========================================
# 4. SALES DATA VALIDATION
# ==========================================

print("\n--- SALES DATA VALIDATION ---")

# Sales amount column must exist
check_result(
    "Sales amount column exists",
    "sales_amount" in valid_sales_amount_df.columns
)

# Check sales amount calculation
if "sales_amount" in valid_sales_amount_df.columns:

    expected_sales = (
        valid_sales_amount_df["quantity"]
        * valid_sales_amount_df["price"]
    )

    check_result(
        "Sales amount calculation is correct",
        valid_sales_amount_df["sales_amount"].notna().all()
        and valid_sales_amount_df["sales_amount"].eq(
            expected_sales
        ).all()
    )

    # No negative sales amount
    check_result(
        "No negative sales amount",
        valid_sales_amount_df["sales_amount"].notna().all()
        and (valid_sales_amount_df["sales_amount"] >= 0).all()
    )

# Only completed orders should exist
sales_status = (
    valid_sales_amount_df["status"]
    .astype("string")
    .str.strip()
    .str.lower()
)

check_result(
    "Only completed orders exist",
    sales_status.eq("completed").all()
)


# ==========================================
# 5. FINAL VALIDATION SUMMARY
# ==========================================

print("\n======================================")
print("FINAL DATA QUALITY VALIDATION COMPLETED")
print("======================================")



# ==========================================
# STEP 22: GENERATE OUTPUT CSV FILES
# ==========================================

print("\n===================================")
print("GENERATING FINAL OUTPUT CSV FILES")
print("===================================")

# 1. Create output folder
OUTPUT_DIR = os.path.join(BASE_DIR, "output")
os.makedirs(OUTPUT_DIR, exist_ok=True)

# 2. Save cleaned customer data
customers_clean.to_csv(
    os.path.join(OUTPUT_DIR, "cleaned_customers.csv"),
    index=False
)

# 3. Save cleaned product data
products_clean.to_csv(
    os.path.join(OUTPUT_DIR, "cleaned_products.csv"),
    index=False
)

# 4. Save cleaned order data
orders_clean.to_csv(
    os.path.join(OUTPUT_DIR, "cleaned_orders.csv"),
    index=False
)

# 5. Save final sales data
valid_sales_amount_df.to_csv(
    os.path.join(OUTPUT_DIR, "final_sales.csv"),
    index=False
)

# 6. Save overall sales summary
overall_summary.to_csv(
    os.path.join(OUTPUT_DIR, "sales_summary.csv"),
    index=False
)

# 7. Save API customer data separately
api_customers_df.to_csv(
    os.path.join(OUTPUT_DIR, "api_customers.csv"),
    index=False
)

print("\nALL OUTPUT FILES GENERATED SUCCESSFULLY")

print("\nFILES CREATED:")
print("1. cleaned_customers.csv")
print("2. cleaned_products.csv")
print("3. cleaned_orders.csv")
print("4. final_sales.csv")
print("5. sales_summary.csv")
print("6. api_customers.csv")

#STEP 24 — Connect Python to MySQL and Load the Data

import pandas as pd
import requests
from sqlalchemy import create_engine
import pymysql
import os
from sqlalchemy.engine import URL
import getpass

print("\n===================================")
print("CONNECTING PYTHON TO MYSQL")
print("===================================")

mysql_password = getpass.getpass("Enter MySQL root password: ")

connection_url = URL.create(
    drivername="mysql+pymysql",
    username="root",
    password=mysql_password,
    host="localhost",
    port=3306,
    database="ecommerce_dw"
)

engine = create_engine(connection_url)

print("MySQL connection details configured successfully!")
print("\n===================================")
print("TESTING MYSQL CONNECTION")
print("===================================")

try:
    connection = engine.connect()

    print("MySQL Connection Successful!")

    connection.close()

except Exception as e:
    print("MySQL Connection Failed!")
    print("Error:", e)

    print("\n===================================")
print("PREPARING SALES DATA FOR MYSQL")
print("===================================")

sales_load_df = valid_sales_amount_df[
    [
        "order_id",
        "customer_id",
        "customer_name",
        "city",
        "product_id",
        "product_name",
        "category",
        "quantity",
        "price",
        "sales_amount",
        "order_date",
        "status"
    ]
].copy()

print("Sales DataFrame prepared successfully!")
print("\nSales Records:", len(sales_load_df))
print("\nSales Columns:")
print(sales_load_df.columns.tolist())

print("\n===================================")
print("LOADING DATA INTO MYSQL")
print("===================================")

connection = engine.connect()
transaction = connection.begin()

try:

    # Load Customers
    customers_clean.to_sql(
        name="customers",
        con=connection,
        if_exists="append",
        index=False
    )
    print("Customers data loaded successfully!")

    # Load Products
    products_clean.to_sql(
        name="products",
        con=connection,
        if_exists="append",
        index=False
    )
    print("Products data loaded successfully!")

    # Load Orders
    orders_clean.to_sql(
        name="orders",
        con=connection,
        if_exists="append",
        index=False
    )
    print("Orders data loaded successfully!")

    # Load Sales
    sales_load_df.to_sql(
        name="sales",
        con=connection,
        if_exists="append",
        index=False
    )
    print("Sales data loaded successfully!")

    # Commit transaction
    transaction.commit()

    print("\nAll data committed successfully!")

except Exception as e:

    transaction.rollback()

    print("\nData loading failed!")
    print("Error:", e)

finally:

    connection.close()
    engine.dispose()

    print("\nMySQL connection closed!")

    print("\n======================================")
print("STEP 25 - FINAL ETL PIPELINE VALIDATION")
print("======================================")

# Python record counts
python_customers_count = len(customers_clean)
python_products_count = len(products_clean)
python_orders_count = len(orders_clean)
python_sales_count = len(valid_sales_amount_df)

# Python total sales
python_total_sales = valid_sales_amount_df["sales_amount"].sum()

# Connect to MySQL and retrieve counts
with engine.connect() as connection:

    mysql_customers_count = pd.read_sql_query(
        "SELECT COUNT(*) AS total FROM customers",
        connection
    ).iloc[0, 0]

    mysql_products_count = pd.read_sql_query(
        "SELECT COUNT(*) AS total FROM products",
        connection
    ).iloc[0, 0]

    mysql_orders_count = pd.read_sql_query(
        "SELECT COUNT(*) AS total FROM orders",
        connection
    ).iloc[0, 0]

    mysql_sales_count = pd.read_sql_query(
        "SELECT COUNT(*) AS total FROM sales",
        connection
    ).iloc[0, 0]

    mysql_total_sales = pd.read_sql_query(
        "SELECT SUM(sales_amount) AS total FROM sales",
        connection
    ).iloc[0, 0]


# Compare Python and MySQL values
print("\n--- RECORD COUNT VALIDATION ---")

checks = [
    ("Customer Count", python_customers_count, mysql_customers_count),
    ("Product Count", python_products_count, mysql_products_count),
    ("Order Count", python_orders_count, mysql_orders_count),
    ("Sales Count", python_sales_count, mysql_sales_count),
]

for name, python_count, mysql_count in checks:

    print(f"\n{name}")
    print("Python:", python_count)
    print("MySQL:", mysql_count)

    if python_count == mysql_count:
        print("PASS: Counts Matched")
    else:
        print("FAIL: Counts Not Matched")


# Compare total sales
print("\n--- TOTAL SALES VALIDATION ---")

print("Python Total Sales:", python_total_sales)
print("MySQL Total Sales:", mysql_total_sales)

if round(float(python_total_sales), 2) == round(float(mysql_total_sales), 2):
    print("PASS: Total Sales Matched")
else:
    print("FAIL: Total Sales Not Matched")


print("\nFINAL ETL COUNT AND SALES VALIDATION COMPLETED")