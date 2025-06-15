#!/bin/bash

CONF_FILE="/opt/flink/conf/flink-conf.yaml"
CUSTOM_JARS_PATH="file:/opt/flink/extra-jars/*"

# Thêm dòng nếu chưa có
if ! grep -q "pipeline.classpaths" "$CONF_FILE"; then
  echo "Appending pipeline.classpaths to flink-conf.yaml"
  echo "pipeline.classpaths: ${CUSTOM_JARS_PATH}" >> "$CONF_FILE"
fi

# Gọi entrypoint gốc của Flink
exec /docker-entrypoint.sh "$@"
