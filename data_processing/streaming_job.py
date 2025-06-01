from pyspark.sql import SparkSession
from data_ingestion.kafka_consumer import create_kafka_stream
from data_processing.transformations import enrich_events

def run_streaming_job():
    spark = SparkSession.builder.appName("StreamingCDP").getOrCreate()

    kafka_bootstrap_servers = "localhost:9092"
    topic = "customer-events"

    raw_events = create_kafka_stream(spark, kafka_bootstrap_servers, topic)
    enriched_events = enrich_events(raw_events)

    query = enriched_events.writeStream \
        .format("console") \
        .outputMode("append") \
        .start()
    
    query.awaitTermination()

if __name__ == "__main__":
    run_streaming_job()
