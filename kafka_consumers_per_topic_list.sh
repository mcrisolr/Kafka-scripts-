#/bin/bash

#set -x -e 

# Create file with consumer-id by topic and consumergroup

for t in `kafka-consumer-groups --bootstrap-server localhost:9092 --list 2>/dev/null`; do
    echo $t | xargs -I {} sh -c "kafka-consumer-groups --bootstrap-server localhost:9092 --describe --group {} 2>/dev/null | grep ^{} | awk '{print \$2\"\t\"\$1\"\t\"\$7\"\t\"\$8}' "
done > topics-consumer.txt



# Print consumer-id by topic and consumergroup 

kafka-consumer-groups --bootstrap-server localhost:9092 --list > consumer_groups.txt

while read -ra line; 
do
    for word in "${line[@]}";
    do
        echo "$word";
        kafka-consumer-groups --bootstrap-server localhost:9092 --describe --group $word | awk '{print $2 "       " $1 "      "  $7 "     " $8 "\n"}';
    done;
done < consumer_groups.txt
