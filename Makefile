guard-%:
	@ if [ "${${*}}" = "" ]; then \
        echo "Environment variable $* not set"; \
        echo "Did you pass $* as part of the payload to the function call?"; \
        exit 1; \
	fi

build:
	curl -o TaskRunner.jar \
		https://s3.amazonaws.com/datapipeline-us-east-1/us-east-1/software/latest/TaskRunner/TaskRunner-1.0.jar

run: guard-WORKER_GROUP guard-REGION guard-LOG_URI
	java -jar TaskRunner.jar \
    --workerGroup=${WORKER_GROUP} \
    --region=${REGION} \
    --logUri=${LOG_URI}
