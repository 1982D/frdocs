

# Kafka Metrics

FusionReactor tracks a variety of metrics for **Kafka consumers**. Each consumer has its own set of metrics, which can be selected using the menu in the top-right corner of the page.

Tracked metrics include (but are not limited to):

* **Assigned Partitions**  -  Number of partitions assigned to the consumer.
* **Commit Rate**  -  Frequency of offset commits.
* **Heartbeat Rate**  -  Frequency of heartbeat messages sent to the broker.
* **Commit Latency Average**  -  Average time taken to commit offsets.
* **Bytes Consumed Rate**  -  Rate of bytes consumed from Kafka.
* **Record Consumed Rate**  -  Number of records consumed per unit time.
* **Fetch Size Average**  -  Average size of fetch requests.
* **Request Size Average**  -  Average size of requests sent to the broker.
* **Outgoing and Incoming Byte Rate**  -  Network throughput to and from the Kafka broker.


!!! info "Learn more"
    [Kafka monitoring](http://docs.confluent.io/current/kafka/monitoring.html)

## Kafka Node Metrics


The **Kafka Node Metrics** page displays metrics for individual brokers. Each consumer tracks the brokers it is connected to separately, allowing detailed monitoring of broker-specific activity.



!!! info "Learn more"
    [Kafka monitoring per broker metrics](http://docs.confluent.io/current/kafka/monitoring.html#per-broker-metrics)

___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.
