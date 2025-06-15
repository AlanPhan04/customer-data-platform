SET execution.checkpointing.interval = 10s;
SET sql-client.execution.result-mode=TABLEAU;
SET pipeline.jars = 'file:///opt/flink/lib/flink-sql-connector-kafka-1.17.0.jar';


CREATE TABLE IF NOT EXISTS behavior_events (
    event_id STRING,
    customer_id STRING,
    event_type STRING,
    `timestamp` TIMESTAMP(3),
    product_id STRING,
    device_type STRING,
    channel STRING,
    metadata MAP<STRING, STRING>
)  WITH (
    'connector' = 'kafka',
    'topic' = 'behavior_events',
    'properties.bootstrap.servers' = 'kafka:9092',
    'properties.group.id' = 'flink-sql-group',
    'scan.startup.mode' = 'earliest-offset',
    'format' = 'json',
    'json.map-null-key.mode' = 'LITERAL',
    'json.ignore-parse-errors' = 'true'
);

CREATE TABLE customer_clv (
    customer_id STRING,
    clv_score STRING,
    clv_tier STRING,
    calculated_at STRING,
    model_version STRING
) WITH (
    'connector' = 'kafka',
    'topic' = 'customer_clv',
    'properties.bootstrap.servers' = 'kafka:9092',
    'properties.group.id' = 'flink-sql-group',
    'scan.startup.mode' = 'earliest-offset',
    'format' = 'json',
    'json.map-null-key.mode' = 'LITERAL',
    'json.ignore-parse-errors' = 'true'
);

CREATE TABLE customer_profile (
    customer_id STRING,
    full_name STRING,
    gender STRING,
    dob STRING,
    region STRING,
    signup_date STRING,
    preferred_channel STRING
) WITH (
    'connector' = 'kafka',
    'topic' = 'customer_profile',
    'properties.bootstrap.servers' = 'kafka:9092',
    'properties.group.id' = 'flink-sql-group',
    'scan.startup.mode' = 'earliest-offset',
    'format' = 'json',
    'json.map-null-key.mode' = 'LITERAL',
    'json.ignore-parse-errors' = 'true'
);

CREATE TABLE customer_loyalty (
    customer_id STRING,
    tier STRING,
    loyalty_points STRING,
    joined_loyalty STRING
) WITH (
    'connector' = 'kafka',
    'topic' = 'customer_loyalty',
    'properties.bootstrap.servers' = 'kafka:9092',
    'properties.group.id' = 'flink-sql-group',
    'scan.startup.mode' = 'earliest-offset',
    'format' = 'json',
    'json.map-null-key.mode' = 'LITERAL',
    'json.ignore-parse-errors' = 'true'
);

CREATE TABLE product_catalog (
    product_id STRING,
    product_name STRING,
    brand STRING,
    category STRING,
    unit_price STRING,
    is_active STRING
) WITH (
    'connector' = 'kafka',
    'topic' = 'product_catalog',
    'properties.bootstrap.servers' = 'kafka:9092',
    'properties.group.id' = 'flink-sql-group',
    'scan.startup.mode' = 'earliest-offset',
    'format' = 'json',
    'json.map-null-key.mode' = 'LITERAL',
    'json.ignore-parse-errors' = 'true'
);

CREATE TABLE customer_rfm (
    customer_id STRING,
    recency_days STRING,
    frequency STRING,
    monetary STRING,
    score STRING,
    calculated_at STRING
) WITH (
    'connector' = 'kafka',
    'topic' = 'customer_rfm',
    'properties.bootstrap.servers' = 'kafka:9092',
    'properties.group.id' = 'flink-sql-group',
    'scan.startup.mode' = 'earliest-offset',
    'format' = 'json',
    'json.map-null-key.mode' = 'LITERAL',
    'json.ignore-parse-errors' = 'true'
);


CREATE TABLE IF NOT EXISTS behavior_events_gold (
    event_id STRING,
    customer_id STRING,
    event_type STRING,
    `timestamp` TIMESTAMP(3),
    product_id STRING,
    device_type STRING,
    channel STRING,
    metadata MAP<STRING, STRING>
)  WITH (
    'connector' = 'kafka',
    'topic' = 'behavior_events_gold',
    'properties.bootstrap.servers' = 'kafka:9092',
    'properties.group.id' = 'flink-sql-group',
    'scan.startup.mode' = 'earliest-offset',
    'format' = 'json',
    'json.map-null-key.mode' = 'LITERAL',
    'json.ignore-parse-errors' = 'true'
);

CREATE TABLE customer_clv_gold (
    customer_id STRING,
    clv_score DOUBLE,
    clv_tier STRING,
    calculated_at TIMESTAMP(3),
    model_version STRING
) WITH (
    'connector' = 'kafka',
    'topic' = 'customer_clv_gold',
    'properties.bootstrap.servers' = 'kafka:9092',
    'properties.group.id' = 'flink-sql-group',
    'scan.startup.mode' = 'earliest-offset',
    'format' = 'json',
    'json.map-null-key.mode' = 'LITERAL',
    'json.ignore-parse-errors' = 'true'
);

CREATE TABLE customer_profile_gold (
    customer_id STRING,
    full_name STRING,
    gender STRING,
    dob DATE,
    region STRING,
    signup_date DATE,
    preferred_channel STRING
) WITH (
    'connector' = 'kafka',
    'topic' = 'customer_profile_gold',
    'properties.bootstrap.servers' = 'kafka:9092',
    'properties.group.id' = 'flink-sql-group',
    'scan.startup.mode' = 'earliest-offset',
    'format' = 'json',
    'json.map-null-key.mode' = 'LITERAL',
    'json.ignore-parse-errors' = 'true'
);

CREATE TABLE customer_loyalty_gold (
    customer_id STRING,
    tier STRING,
    loyalty_points INT,
    joined_loyalty DATE
) WITH (
    'connector' = 'kafka',
    'topic' = 'customer_loyalty_gold',
    'properties.bootstrap.servers' = 'kafka:9092',
    'properties.group.id' = 'flink-sql-group',
    'scan.startup.mode' = 'earliest-offset',
    'format' = 'json',
    'json.map-null-key.mode' = 'LITERAL',
    'json.ignore-parse-errors' = 'true'
);

CREATE TABLE product_catalog_gold (
    product_id STRING,
    product_name STRING,
    brand STRING,
    category STRING,
    unit_price DOUBLE,
    is_active BOOLEAN
) WITH (
    'connector' = 'kafka',
    'topic' = 'product_catalog_gold',
    'properties.bootstrap.servers' = 'kafka:9092',
    'properties.group.id' = 'flink-sql-group',
    'scan.startup.mode' = 'earliest-offset',
    'format' = 'json',
    'json.map-null-key.mode' = 'LITERAL',
    'json.ignore-parse-errors' = 'true'
);

CREATE TABLE customer_rfm_gold (
    customer_id STRING,
    recency_days INT,
    frequency INT,
    monetary DOUBLE,
    score DOUBLE,
    calculated_at TIMESTAMP(3)
) WITH (
    'connector' = 'kafka',
    'topic' = 'customer_rfm_gold',
    'properties.bootstrap.servers' = 'kafka:9092',
    'properties.group.id' = 'flink-sql-group',
    'scan.startup.mode' = 'earliest-offset',
    'format' = 'json',
    'json.map-null-key.mode' = 'LITERAL',
    'json.ignore-parse-errors' = 'true'
);


---- SEGMENT PROFILE

CREATE TABLE customer_segment_profile (
    customer_id STRING,
    full_name STRING,
    gender STRING,
    age INT,
    region STRING,
    preferred_channel STRING,
    loyalty_tier STRING,
    loyalty_points INT,
    signup_date DATE,
    rfm_score DOUBLE,
    clv_score DOUBLE,
    clv_tier STRING,
    segment_tags ARRAY<STRING>,
    last_updated TIMESTAMP(3),
    WATERMARK FOR last_updated AS last_updated - INTERVAL '5' SECOND
) WITH (
    'connector' = 'kafka',
    'topic' = 'customer_segment_profile',
    'properties.bootstrap.servers' = 'kafka:9092',
    'properties.group.id' = 'flink-sql-group',
    'scan.startup.mode' = 'earliest-offset',
    'format' = 'json',
    'json.map-null-key.mode' = 'LITERAL',
    'json.ignore-parse-errors' = 'true'
);


-- INSERT INTO customer_segment_profile
-- SELECT
--     p.customer_id,
--     p.full_name,
--     p.gender,
--     TIMESTAMPDIFF(YEAR, p.dob, CURRENT_DATE) AS age,
--     p.region,
--     p.preferred_channel,
--     l.tier AS loyalty_tier,
--     l.loyalty_points,
--     p.signup_date,
--     r.score AS rfm_score,
--     c.clv_score,
--     c.clv_tier,
    
--     -- Gợi ý gán tag phân khúc dựa trên điều kiện
--     ARRAY[
--         CASE WHEN r.score >= 4.5 THEN 'high_value' END,
--         CASE WHEN c.clv_tier = 'High' THEN 'premium' END,
--         CASE WHEN r.recency_days > 60 THEN 'at_risk' END
--     ] AS segment_tags,

--     CURRENT_TIMESTAMP AS last_updated

-- FROM customer_profile_gold p
--     JOIN customer_loyalty_gold l ON p.customer_id = l.customer_id
--     JOIN customer_rfm_gold r ON p.customer_id = r.customer_id
--     JOIN customer_clv_gold c ON p.customer_id = c.customer_id;

-- SELECT * FROM customer_segment_profile;

-- SELECT
--     *
-- FROM customer_profile_gold p
--     JOIN customer_loyalty_gold l ON p.customer_id = l.customer_id;