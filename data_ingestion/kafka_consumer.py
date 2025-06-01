from pyspark.sql import SparkSession
from pyspark.sql.functions import from_json, col
from data_models.schemas import customer_event_schema

def create_kafka_stream(spark: SparkSession, kafka_bootstrap_servers: str, topic: str):
    df = spark.readStream \
        .format("kafka") \
        .option("kafka.bootstrap.servers", kafka_bootstrap_servers) \
        .option("subscribe", topic) \
        .option("startingOffsets", "latest") \
        .load()
    
    # Parse JSON value
    json_df = df.select(from_json(col("value").cast("string"), customer_event_schema).alias("data")).select("data.*")
    
    return json_df
