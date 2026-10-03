import sqlite3
import pandas as pd

# Connect to SQLite database
conn = sqlite3.connect("database/olist.db")

# Load raw CSV files
customers = pd.read_csv("data/raw/olist_customers_dataset.csv")
orders = pd.read_csv("data/raw/olist_orders_dataset.csv")
order_items = pd.read_csv("data/raw/olist_order_items_dataset.csv")
products = pd.read_csv("data/raw/olist_products_dataset.csv")
payments = pd.read_csv("data/raw/olist_order_payments_dataset.csv")
reviews = pd.read_csv("data/raw/olist_order_reviews_dataset.csv")
sellers = pd.read_csv("data/raw/olist_sellers_dataset.csv")
translation = pd.read_csv("data/raw/product_category_name_translation.csv")

# Load tables into SQLite
customers.to_sql("customers", conn, if_exists="replace", index=False)
orders.to_sql("orders", conn, if_exists="replace", index=False)
order_items.to_sql("order_items", conn, if_exists="replace", index=False)
products.to_sql("products", conn, if_exists="replace", index=False)
payments.to_sql("payments", conn, if_exists="replace", index=False)
reviews.to_sql("reviews", conn, if_exists="replace", index=False)
sellers.to_sql("sellers", conn, if_exists="replace", index=False)
translation.to_sql("translation", conn, if_exists="replace", index=False)

conn.close()

print("All tables loaded successfully.")