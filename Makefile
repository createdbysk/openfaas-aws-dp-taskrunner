guard-%:
	@ if [ "${${*}}" = "" ]; then \
        echo "Environment variable $* not set"; \
        echo "Did you pass $* as part of the payload to the function call?"; \
        exit 1; \
	fi

build:
	# chown app /var/spool/cron/atjobs
	chmod +x ./run.sh
	curl -o TaskRunner.jar \
		https://s3.amazonaws.com/datapipeline-us-east-1/us-east-1/software/latest/TaskRunner/TaskRunner-1.0.jar

run: guard-WORKER_GROUP guard-REGION guard-LOG_URI
	echo Schedule ./run.sh to run 1 minute from now.
	at now +1 minutes -f ./run.sh
	echo Schedule created.