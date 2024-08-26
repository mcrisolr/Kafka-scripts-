#/bin/bash

set -v -x -e 

for t in `kafka-consumer-groups --bootstrap-server localhost:9092 --list 2>/dev/null`; do
    echo $t | xargs -I {} sh -c "kafka-consumer-groups --bootstrap-server localhost:9092 --describe --group {} 2>/dev/null | grep ^{} | awk '{print \$2\"\t\"\$1\"\t\"\$7\"\t\"\$8}' "
done > topics-consumer.txt
