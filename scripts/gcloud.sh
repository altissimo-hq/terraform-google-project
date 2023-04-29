#!/usr/bin/env bash
#
# This script is a wrapper around the gcloud command that returns the output as a JSON string.
#
# Example usage: ./gcloud.sh ./path/to/gcloud --project my-project compute instances list
#

# define the command to run
CMD="${*} --format=json"

# run the command and capture the output
DATA=$(${CMD})

# return the output as a JSON string
jq -n --arg data "${DATA}" '{"data": $data}'
