from pyspark.sql import DataFrame
from pyspark.sql.functions import expr

def enrich_events(df: DataFrame) -> DataFrame:
    # Ví dụ thêm cột phân loại khách hàng dựa vào số lần mua
    return df.withColumn("customer_segment", expr(
        "CASE WHEN purchase_count > 5 THEN 'loyal' WHEN purchase_count > 1 THEN 'potential' ELSE 'new' END"
    ))
