FROM maven AS builder

COPY pom.xml .
COPY src/ /src/
RUN mvn package

FROM confluentinc/cp-kafka-connect:7.4.3

ENV CONNECT_PLUGIN_PATH="/usr/share/confluent-hub-components"

COPY --from=builder target/kinesis-kafka-connector.jar /usr/share/confluent-hub-components/kinesis/kinesis-kafka-connector.jar

COPY --from=builder target/libs /usr/share/confluent-hub-components/kinesis/libs