#!/usr/bin/env bash
#
# This script is a wrapper around the gcloud command that returns the output as a JSON string.
#
# Example usage: ./gcloud.sh ./path/to/gcloud --project my-project compute instances list
#

# define the command to run
CMD="${*} --format=json"

# run the command and capture the output
# DATA=$(${CMD})

# return the output as a JSON string
# jq -n --arg data "${DATA}" '{"data": $data}'

# the above solution runs into "Argument list too long" error when the input is too large

# this solution compacts the output and can handle large inputs
${CMD} | jq -c | jq -R '{"data": .}'
