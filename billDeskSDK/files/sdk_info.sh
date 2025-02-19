#!/bin/bash

timestamp=$(date +%Y%m%d%H)

echo "Building version:"
read version

echo "{\"version\":\"$version\",\"build\":$timestamp}" > info.json

json_file="info.json"

# Make the JSON file read-only
chmod 444 "$json_file"