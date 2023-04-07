#!/usr/bin/env bash

docker run --rm \
    -u "$(id -u)"  \
    -v "$(pwd):/terraform-docs" \
    quay.io/terraform-docs/terraform-docs:0.16.0 \
    markdown /terraform-docs
