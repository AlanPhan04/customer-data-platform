SET execution.checkpointing.interval = 10s;
SET sql-client.execution.result-mode=TABLEAU;
-- SET pipeline.jars = 'file:///opt/flink/lib/flink-sql-connector-kafka-1.17.0.jar';

CREATE CATALOG hive_catalog WITH (
  'type' = 'hive',
  'default-database' = 'default',
  'hive-conf-dir' = '/opt/hive/conf'
);

USE CATALOG hive_catalog;

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


CREATE TABLE IF NOT EXISTS behavior_events_raw (
    event_id STRING,
    customer_id STRING,
    event_type STRING,
    `timestamp` TIMESTAMP(3),
    product_id STRING,
    device_type STRING,
    channel STRING,
    metadata MAP<STRING, STRING>
) WITH (
  'connector' = 'filesystem',
  'path' = 's3a://raw/behavior_events',
  'format' = 'json',
  'sink.partition-commit.trigger' = 'process-time',
  'sink.partition-commit.policy.kind' = 'metastore,success-file',
  'sink.partition-commit.delay' = '0s',
  'sink.rolling-policy.rollover-interval' = '5s',
  'sink.rolling-policy.check-interval' = '2s',
  'sink.rolling-policy.file-size' = '128kb',
  'sink.rolling-policy.inactivity-interval' = '5s',

  -- Tắt compaction
  'auto-compaction' = 'false'
);

CREATE TABLE customer_clv_raw (
    customer_id STRING,
    clv_score STRING,
    clv_tier STRING,
    calculated_at STRING,
    model_version STRING
) WITH (
  'connector' = 'filesystem',
  'path' = 's3a://raw/customer_clv',
  'format' = 'json',
  'sink.partition-commit.trigger' = 'process-time',
  'sink.partition-commit.policy.kind' = 'metastore,success-file',
  'sink.partition-commit.delay' = '0s',
  'sink.rolling-policy.rollover-interval' = '5s',
  'sink.rolling-policy.check-interval' = '2s',
  'sink.rolling-policy.file-size' = '128kb',
  'sink.rolling-policy.inactivity-interval' = '5s',

  -- Tắt compaction
  'auto-compaction' = 'false'
);

CREATE TABLE customer_profile_raw (
    customer_id STRING,
    full_name STRING,
    gender STRING,
    dob STRING,
    region STRING,
    signup_date STRING,
    preferred_channel STRING
) WITH (
  'connector' = 'filesystem',
  'path' = 's3a://raw/customer_profile',
  'format' = 'json',
  'sink.partition-commit.trigger' = 'process-time',
  'sink.partition-commit.policy.kind' = 'metastore,success-file',
  'sink.partition-commit.delay' = '0s',
  'sink.rolling-policy.rollover-interval' = '5s',
  'sink.rolling-policy.check-interval' = '2s',
  'sink.rolling-policy.file-size' = '128kb',
  'sink.rolling-policy.inactivity-interval' = '5s',

  -- Tắt compaction
  'auto-compaction' = 'false'
);

CREATE TABLE customer_loyalty_raw (
    customer_id STRING,
    tier STRING,
    loyalty_points STRING,
    joined_loyalty STRING
) WITH (
  'connector' = 'filesystem',
  'path' = 's3a://raw/customer_loyalty',
  'format' = 'json',
  'sink.partition-commit.trigger' = 'process-time',
  'sink.partition-commit.policy.kind' = 'metastore,success-file',
  'sink.partition-commit.delay' = '0s',
  'sink.rolling-policy.rollover-interval' = '5s',
  'sink.rolling-policy.check-interval' = '2s',
  'sink.rolling-policy.file-size' = '128kb',
  'sink.rolling-policy.inactivity-interval' = '5s',

  -- Tắt compaction
  'auto-compaction' = 'false'
);

CREATE TABLE product_catalog_raw (
    product_id STRING,
    product_name STRING,
    brand STRING,
    category STRING,
    unit_price STRING,
    is_active STRING
) WITH (
  'connector' = 'filesystem',
  'path' = 's3a://raw/product_catalog',
  'format' = 'json',
  'sink.partition-commit.trigger' = 'process-time',
  'sink.partition-commit.policy.kind' = 'metastore,success-file',
  'sink.partition-commit.delay' = '0s',
  'sink.rolling-policy.rollover-interval' = '5s',
  'sink.rolling-policy.check-interval' = '2s',
  'sink.rolling-policy.file-size' = '128kb',
  'sink.rolling-policy.inactivity-interval' = '5s',

  -- Tắt compaction
  'auto-compaction' = 'false'
);

CREATE TABLE customer_rfm_raw (
    customer_id STRING,
    recency_days STRING,
    frequency STRING,
    monetary STRING,
    score STRING,
    calculated_at STRING
) WITH (
  'connector' = 'filesystem',
  'path' = 's3a://raw/customer_rfm',
  'format' = 'json',
  'sink.partition-commit.trigger' = 'process-time',
  'sink.partition-commit.policy.kind' = 'metastore,success-file',
  'sink.partition-commit.delay' = '0s',
  'sink.rolling-policy.rollover-interval' = '5s',
  'sink.rolling-policy.check-interval' = '2s',
  'sink.rolling-policy.file-size' = '128kb',
  'sink.rolling-policy.inactivity-interval' = '5s',

  -- Tắt compaction
  'auto-compaction' = 'false'
);

-- 1. behavior_events -> behavior_events_raw
INSERT INTO behavior_events_raw
SELECT * FROM behavior_events;

-- 2. customer_clv -> customer_clv_raw
INSERT INTO customer_clv_raw
SELECT * FROM customer_clv;

-- 3. customer_profile -> customer_profile_raw
INSERT INTO customer_profile_raw
SELECT * FROM customer_profile;

-- 4. customer_loyalty -> customer_loyalty_raw
INSERT INTO customer_loyalty_raw
SELECT * FROM customer_loyalty;

-- 5. product_catalog -> product_catalog_raw
INSERT INTO product_catalog_raw
SELECT * FROM product_catalog;

-- 6. customer_rfm -> customer_rfm_raw
INSERT INTO customer_rfm_raw
SELECT * FROM customer_rfm;
