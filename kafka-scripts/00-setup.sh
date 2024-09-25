# Get Docker image
docker pull apache/kafka:3.8.0
# run Docker in the background
docker run -d  -p 9092:9092 apache/kafka:3.8.0 

# Setup Kafka Topic
kafka-topics --bootstrap-server localhost:9092 \
    --create --topic vault-transit \
    --if-not-exists --partitions 3 \
    --replication-factor 1