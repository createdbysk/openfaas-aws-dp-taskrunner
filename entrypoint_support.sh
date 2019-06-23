#!/usr/bin/env bash

function entrypoint::populate_environment() {
    # Payload is a json object that looks like
    # {"ENVIRONMENT_VARIABLE_NAME1": "VALUE1", "ENVIRONMENT_VARIABLE_NAME2": "VALUE2"}
    local payload=$1
    echo payload, ${payload}
    # Create an array of key value pairs from the given json input.
    # key_value_pairs resolves to 
    # (ENVIRONMENT_VARIABLE_NAME1=VALUE1 ENVIRONMENT_VARIABLE_NAME2=VALUE2)
    local key_value_pairs=$(echo ${payload} | jq -r 'keys[] as $k | "\($k)=\(.[$k])"')
    echo KEY_VALUE, ${key_value_pairs[@]}
    # Export the environment variables so it becomes part of the environment.
    # The for loop executes
    # 
    #   export ENVIRONMENT_VARIABLE_NAME1=VALUE1
    #   export ENVIRONMENT_VARIABLE_NAME2=VALUE2
    for key_value_pair in ${key_value_pairs[@]}
    do
        export ${key_value_pair}
    done
}
