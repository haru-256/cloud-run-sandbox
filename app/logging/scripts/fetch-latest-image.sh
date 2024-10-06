#!/usr/bin/env bash

set -eu

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <image-name>"
fi

image_name=$1

digest=$(gcloud artifacts docker images list ${image_name} \
  --sort-by=~create_time --format=json --quiet |
  jq -r .[0].version)

echo "latest image: ${image_name}@${digest}"
