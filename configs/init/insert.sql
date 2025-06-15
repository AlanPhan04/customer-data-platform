
INSERT INTO behavior_events_gold
SELECT
  event_id,
  customer_id,
  event_type,
  `timestamp`,
  product_id,
  device_type,
  channel,
  metadata
FROM behavior_events;

INSERT INTO customer_clv_gold
SELECT
  customer_id,
  CAST(clv_score AS DOUBLE),
  clv_tier,
  TO_TIMESTAMP_LTZ(CAST(calculated_at AS BIGINT), 3),
  model_version
FROM customer_clv;

INSERT INTO customer_profile_gold
SELECT
  customer_id,
  full_name,
  gender,
  CAST(dob AS DATE),
  region,
  CAST(signup_date AS DATE),
  preferred_channel
FROM customer_profile;

INSERT INTO customer_loyalty_gold
SELECT
  customer_id,
  tier,
  CAST(loyalty_points AS INT),
  CAST(joined_loyalty AS DATE)
FROM customer_loyalty;

INSERT INTO product_catalog_gold
SELECT
  product_id,
  product_name,
  brand,
  category,
  CAST(unit_price AS DOUBLE),
  CASE LOWER(is_active)
    WHEN 'true' THEN TRUE
    WHEN 'false' THEN FALSE
    ELSE NULL
  END
FROM product_catalog;

INSERT INTO customer_rfm_gold
SELECT
  customer_id,
  CAST(recency_days AS INT),
  CAST(frequency AS INT),
  CAST(monetary AS DOUBLE),
  CAST(score AS DOUBLE),
  TO_TIMESTAMP_LTZ(CAST(calculated_at AS BIGINT), 3)
FROM customer_rfm;

SELECT * FROM behavior_events_gold;