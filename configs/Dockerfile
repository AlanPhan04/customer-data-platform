FROM apache/flink:1.17.0-scala_2.12

# Cài đặt Python và PyFlink
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    pip3 install apache-flink

# Tạo thư mục để chứa job
WORKDIR /opt/pyflink_jobs

# (Tùy chọn) Copy job vào container
# COPY ./pyflink_jobs /opt/pyflink_jobs

        # "C:\\Users\\Alan Phan\\Desktop\\Bach Khoa Studies\\Tools\\DataPlatform\\customer-data-platform\\src\\jars\\flink-sql-connector-kafka-1.17.0.jar"
