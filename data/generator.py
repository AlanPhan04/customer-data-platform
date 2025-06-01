from faker import Faker # type: ignore
import random, os, json, pandas as pd
from datetime import datetime, timedelta
from extra_generator import *
from sqlalchemy import create_engine, text
from pymongo import MongoClient # type: ignore

faker = Faker()

DATA_PATH = "data/raw"

pos = []
web = []
crm = []
mobile = []
# email_mkt = []
ecommerce = []

# Mobile source
screen_names = [
    "SplashScreen",
    "LoginScreen",
    "SignupScreen",
    "HomeScreen",
    "SearchScreen",
    "ProductDetailScreen",
    "CartScreen",
    "CheckoutScreen",
    "OrderHistoryScreen",
    "ProfileScreen",
    "SettingsScreen",
    "NotificationScreen",
    "HelpCenterScreen",
    "WishlistScreen",
    "MessageScreen"
]
actions = ["view", "click", "swipe", "scroll", "submit", "back"]
device_types = ["Android", "iOS", "Tablet"]

# E-commerce transactions source
payment_methods = ["Credit Card", "PayPal", "Bank Transfer", "Cash on Delivery"]
delivery_statuses = ["Pending", "Shipped", "Delivered", "Cancelled", "Returned"]

product_catalog = [
    {"ProductID": "P001", "ProductName": "Milk", "Price": 25000},
    {"ProductID": "P002", "ProductName": "Water", "Price": 8000},
    {"ProductID": "P003", "ProductName": "Snack", "Price": 12000},
    {"ProductID": "P004", "ProductName": "Instant Noodles", "Price": 3000},
    {"ProductID": "P005", "ProductName": "Cookies", "Price": 35000},
]


Faker.seed(1234)
random.seed(1234)
for i in range(10000):
    # customer_id = id_generate()
    # product_id = id_generate()

    
    # POS SOURCE
    transaction_id = id_generate()
    store_id = id_generate()
    pos.append({
        "TransactionID": transaction_id,
        "CustomerID": id_generate(),
        "ProductID": id_generate(),
        "Quantity": random.randint(1, 20),
        "Price": random.randint(10000, 500000),
        "Timestamp": str(datetime.now() + timedelta(microseconds=i)), 
        "StoreID": store_id
    })

    # WEB SOURCE
    session_id = id_generate()
    web_url = faker.url()
    web.append({
        "SessionID": session_id,
        "CustomerID": id_generate(),
        "PageVisited": web_url,
        "TimeSpent": timedelta(seconds=random.randint(15, 300)),
        "ClickedProductId": id_generate(),
        "TimeSramp": str(datetime.now() + timedelta(microseconds=i))
    })

    mobile.append({
        "UserID": id_generate(),
        "ScreenName": random.choice(screen_names),
        "Action": random.choice(actions),
        "Timestamp": faker.date_time_between(start_date="-30d", end_date="now").isoformat(),
        "DeviceType": random.choice(device_types),
        "Location": faker.city() + ", " + faker.country()
    })

    # CRM SOURCE
    full_name = faker.name()
    email = faker.email()
    phone_number = faker.phone_number()
    birthday = faker.date_of_birth(minimum_age=18, maximum_age=65).strftime('%Y-%m-%d')

    crm.append({
        "CustomerID": id_generate(),
        "FullName": full_name,
        "Email": email,
        "Phone": phone_number,
        "Birthday": birthday,
        "LoyaltyLevel": random.choice(["Bronze", "Silver", "Gold", "Platinum"]),
        "JoinedDate": faker.date_this_decade().strftime('%Y-%m-%d')
    })

    # email_mkt.append({
    #     "EmailID": email,
    #     "CustomerID": id_generate(),
    #     "CampaignID": id_generate(),
    #     "Opened": random.choices(["Yes", "No"]),
    #     "Clicked": random.choices(["Yes", "No"]),
    #     "Timestamp": str(datetime.now() + timedelta(microseconds=i))
    # })
    
    # E-commerce SOURCE

    selected_products = random.choices(product_catalog, k=random.randint(1, 5))
    product_list = [
        {
            "ProductID": p["ProductID"],
            "ProductName": p["ProductName"],
            "Quantity": random.randint(1, 3),
            "UnitPrice": p["Price"]
        }
        for p in selected_products
    ]

    total_price = sum(item["Quantity"] * item["UnitPrice"] for item in product_list)

    ecommerce.append({
        "OrderID": id_generate(),
        "CustomerID" : id_generate(), 
        "ProductList" : product_list, 
        "TotalPrice": total_price, 
        "PaymentMethod": payment_methods[random.randint(0,3)], 
        "Timestamp":  str(datetime.now() + timedelta(microseconds=i)), 
        "DeliveryStatus": delivery_statuses[random.randint(0,4)]
    })

# POS JSON File
with open(f"{DATA_PATH}/pos/pos.json", "w") as f:
    json.dump(pos, f, indent = 4)

# Web Parquet File
df_web = pd.DataFrame(web)
df_web.to_parquet(f"{DATA_PATH}/web/web.parquet")

# Mobile Postgre Database
df_mobile = pd.DataFrame(mobile)
engine = create_engine("postgresql+psycopg2://myuser:mypassword@localhost:5432/mydb")
df_mobile.to_sql("Mobile", con=engine, if_exists="replace", schema="mobile_app", index=False)

# CRM CSV File
df_crm = pd.DataFrame(crm)
df_crm.to_csv(f"{DATA_PATH}/crm/crm.csv")

# E-commerce MongoDB Database
df_ecommerce = pd.DataFrame(ecommerce)
client = MongoClient("mongodb://mongoadmin:secret@localhost:27017/")
db = client["mydb"]
orders = db["orders"]
orders.delete_many({})
orders.insert_many(ecommerce)

print("Generate Fake Data Successfully!")