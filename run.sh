#!/usr/bin/env bash

echo Start TaskRunner.jar 
java -jar TaskRunner.jar \
    --workerGroup=${WORKER_GROUP} \
    --region=${REGION} \
    --logUri=${LOG_URI}&
echo TaskRunner.jar started.
