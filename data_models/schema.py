from pyspark.sql.types import StructType, StructField, StringType, IntegerType, TimestampType

customer_event_schema = StructType([
    StructField("customer_id", StringType()),
    StructField("event_type", StringType()),
    StructField("event_time", TimestampType()),
    StructField("purchase_count", IntegerType()),
    StructField("product_id", StringType())
])
