#!/bin/bash

# Build the Docker image
docker build -t kafka-test-runner .

# Run the container to execute the specified test once
docker run -v "$(pwd):/app" -v gradle_cache:/home/gradle/.gradle kafka-test-runner
