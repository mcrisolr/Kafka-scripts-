#/bin/bash
#Get all consumers-per-topic as a table of topictabconsumer 

set -x 

for t in `kafka-consumer-groups --bootstrap-server localhost:9092 --list 2>/dev/null`; do
    echo $t | xargs -I {} sh -c "kafka-consumer-groups --bootstrap-server localhost:9092 --describe --group {} 2>/dev/null | grep ^{} | awk '{print \$2\"\t\"\$1}' "
done > topics-consumer.txt

