import random
import uuid
from datetime import datetime, timedelta
import json

DATA_PATH = "C:\\Users\\Alan Phan\\Desktop\\Bach Khoa Studies\\Tools\\DataPlatform\\customer-data-platform\\data\\raw"
random.seed(1234)
# Helper functions
def random_date(start, end):
    return start + timedelta(days=random.randint(0, (end - start).days))

def random_timestamp():
    return datetime.now() - timedelta(minutes=random.randint(0, 10000))

def random_items(product_ids):
    return [
        {
            "product_id": random.choice(product_ids),
            "qty": str(random.randint(1, 5)),
            "unit_price": str(round(random.uniform(5_000, 50_000), 2))
        }
        for _ in range(random.randint(1, 3))
    ]

# Sample data
product_ids = [f"P{str(i).zfill(3)}" for i in range(1, 4)]
customer_ids = [f"C{str(i).zfill(4)}" for i in range(1, 5)]
regions = ["North", "South", "Central"]
categories = ["beverage", "snack", "personal care"]
tiers = ["Bronze", "Silver", "Gold", "Platinum"]
event_types = ["view_product", "add_to_cart", "search"]

# Generate fake data
purchase_events = []
customer_profile = []
loyalty_data = []
product_catalog = []
behavior_events = []
rfm_scores = []
clv_scores = []

# product_catalog
for pid in product_ids:
    product_catalog.append({
        "product_id": pid,
        "product_name": f"Product {pid}",
        "brand": f"Brand {random.randint(1, 5)}",
        "category": random.choice(categories),
        "unit_price": str(round(random.uniform(5_000, 50_000), 2)),
        "is_active": str(random.choice([True, True, False]))
    })

with open(f"{DATA_PATH}\\product_catalog.json", 'w') as f:
    json.dump(product_catalog, f, indent=4)

# customer_profile & loyalty_data
for cid in customer_ids:
    profile = {
        "customer_id": cid,
        "full_name": f"Customer {cid}",
        "gender": random.choice(["male", "female"]),
        "dob": str(random_date(datetime(1980, 1, 1), datetime(2005, 1, 1)).date()),
        "region": random.choice(regions),
        "signup_date": str(random_date(datetime(2020, 1, 1), datetime(2023, 1, 1)).date()),
        "preferred_channel": random.choice(["web", "app", "store"])
    }
    loyalty = {
        "customer_id": cid,
        "tier": random.choice(tiers),
        "loyalty_points": str(random.randint(0, 5000)),
        "joined_loyalty": profile["signup_date"]
    }
    customer_profile.append(profile)
    loyalty_data.append(loyalty)

with open(f"{DATA_PATH}\\customer_profile.json", 'w') as f:
    json.dump(customer_profile, f, indent=4)

with open(f"{DATA_PATH}\\loyalty_data.json", 'w') as f:
    json.dump(loyalty_data, f, indent=4)

# purchase_events
for _ in range(100000):
    cid = random.choice(customer_ids)
    items = random_items(product_ids)
    total = sum(int(i["qty"]) * float(i["unit_price"]) for i in items)
    purchase_events.append({
        "transaction_id": str(uuid.uuid4()),
        "customer_id": cid,
        "timestamp": str(random_timestamp())[:-3],
        "store_id": f"STORE_{random.randint(1,5)}",
        "items": items,
        "total_amount": str(round(total, 2)),
        "payment_method": random.choice(["cash", "card", "e-wallet"])
    })

with open(f"{DATA_PATH}\\purchase_events.json", 'w') as f:
    json.dump(purchase_events, f, indent=4)

# behavior_events
for _ in range(100000):
    cid = random.choice(customer_ids)
    behavior_events.append({
        "event_id": str(uuid.uuid4()),
        "customer_id": cid,
        "event_type": random.choice(event_types),
        "timestamp": str(random_timestamp()),
        "product_id": random.choice(product_ids),
        "device_type": random.choice(["mobile", "desktop", "tablet"]),
        "channel": random.choice(["web", "app", "facebook", "zalo"]),
        "metadata": {"ref": "promo2025"}
    })

with open(f"{DATA_PATH}\\behavior_events.json", 'w') as f:
    json.dump(behavior_events, f, indent=4)

# rfm_scores & clv_scores
for cid in customer_ids:
    rfm = {
        "customer_id": cid,
        "recency_days": str(random.randint(1, 90)),
        "frequency": str(random.randint(1, 20)),
        "monetary": str(round(random.uniform(50_000, 5_000_000), 2)),
        "score": str(round(random.uniform(1, 10), 2)),
        "calculated_at": str(datetime.now())
    }
    clv = {
        "customer_id": cid,
        "clv_score": str(round(random.uniform(500_000, 20_000_000), 2)),
        "clv_tier": random.choice(["Low", "Medium", "High", "Very High"]),
        "calculated_at": str(datetime.now()),
        "model_version": "v1.0"
    }
    rfm_scores.append(rfm)
    clv_scores.append(clv)

with open(f"{DATA_PATH}\\rfm_scores.json", 'w') as f:
    json.dump(rfm_scores, f, indent=4)

with open(f"{DATA_PATH}\\clv_scores.json", 'w') as f:
    json.dump(clv_scores, f, indent=4)

# Return as dictionary for export
{
    "purchase_events": purchase_events[:2],
    "customer_profile": customer_profile[:2],
    "loyalty_data": loyalty_data[:2],
    "product_catalog": product_catalog[:2],
    "behavior_events": behavior_events[:2],
    "rfm_scores": rfm_scores[:2],
    "clv_scores": clv_scores[:2],
}

