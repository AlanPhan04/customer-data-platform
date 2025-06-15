kafka-topics.sh --bootstrap-server localhost:9092 --topic behavior_events --delete
kafka-topics.sh --bootstrap-server localhost:9092 --topic clv_scores --delete
kafka-topics.sh --bootstrap-server localhost:9092 --topic customer_profile --delete
kafka-topics.sh --bootstrap-server localhost:9092 --topic loyalty_data --delete
kafka-topics.sh --bootstrap-server localhost:9092 --topic product_catalog --delete
kafka-topics.sh --bootstrap-server localhost:9092 --topic purchase_events --delete
kafka-topics.sh --bootstrap-server localhost:9092 --topic rfm_scores --delete


### Raw Topic

kafka-topics.sh --bootstrap-server localhost:9092 --topic behavior_events --create --partitions 3 --replication-factor 1
kafka-topics.sh --bootstrap-server localhost:9092 --topic clv_scores --create --partitions 3 --replication-factor 1
kafka-topics.sh --bootstrap-server localhost:9092 --topic customer_profile --create --partitions 3 --replication-factor 1
kafka-topics.sh --bootstrap-server localhost:9092 --topic loyalty_data --create --partitions 3 --replication-factor 1
kafka-topics.sh --bootstrap-server localhost:9092 --topic product_catalog --create --partitions 3 --replication-factor 1
kafka-topics.sh --bootstrap-server localhost:9092 --topic purchase_events --create --partitions 3 --replication-factor 1
kafka-topics.sh --bootstrap-server localhost:9092 --topic rfm_scores --create --partitions 3 --replication-factor 1



### Clean Topic

kafka-topics.sh --bootstrap-server localhost:9092 --topic behavior_events_gold --delete
kafka-topics.sh --bootstrap-server localhost:9092 --topic clv_scores_gold --delete
kafka-topics.sh --bootstrap-server localhost:9092 --topic customer_profile_gold --delete
kafka-topics.sh --bootstrap-server localhost:9092 --topic loyalty_data_gold --delete
kafka-topics.sh --bootstrap-server localhost:9092 --topic product_catalog_gold --delete
kafka-topics.sh --bootstrap-server localhost:9092 --topic purchase_events_gold --delete
kafka-topics.sh --bootstrap-server localhost:9092 --topic rfm_scores_gold --delete

kafka-topics.sh --bootstrap-server localhost:9092 --topic behavior_events_gold --create --partitions 3 --replication-factor 1
kafka-topics.sh --bootstrap-server localhost:9092 --topic clv_scores_gold --create --partitions 3 --replication-factor 1
kafka-topics.sh --bootstrap-server localhost:9092 --topic customer_profile_gold --create --partitions 3 --replication-factor 1
kafka-topics.sh --bootstrap-server localhost:9092 --topic loyalty_data_gold --create --partitions 3 --replication-factor 1
kafka-topics.sh --bootstrap-server localhost:9092 --topic product_catalog_gold --create --partitions 3 --replication-factor 1
kafka-topics.sh --bootstrap-server localhost:9092 --topic purchase_events_gold --create --partitions 3 --replication-factor 1
kafka-topics.sh --bootstrap-server localhost:9092 --topic rfm_scores_gold --create --partitions 3 --replication-factor 1


### Segment Topic

kafka-topics.sh --bootstrap-server localhost:9092 --topic customer_segment_profile --delete
kafka-topics.sh --bootstrap-server localhost:9092 --topic customer_segment_profile --create --partitions 3 --replication-factor 1

