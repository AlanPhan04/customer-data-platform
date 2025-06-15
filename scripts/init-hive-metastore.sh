#!/bin/bash
set -e

# Step 1: Initialize Hive metastore schema
echo "Running Hive schema initialization..."
schematool -dbType mysql -initSchema

# Step 2: Start Hive metastore
echo "Starting Hive metastore service..."
hive --service metastore