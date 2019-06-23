#!/usr/bin/env bash

source ./entrypoint_support.sh

# Parse the environment variables out of the payload
# The payload to the function is provided over stdin.
# cat with no parameters outputs stdin. 
# The payload is expected to be a json object that looks like
# {"ENVIRONMENT_VARIABLE_NAME1": "VALUE1", "ENVIRONMENT_VARIABLE_NAME2": "VALUE2"}
PAYLOAD=$(cat)
entrypoint::populate_environment "${PAYLOAD}"

make run
