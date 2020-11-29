#!/usr/bin/env bash

set -x  # Print commands and their arguments as they are executed
set -e  # Exit immediately if a command exits with a non-zero status

echo "Build stage CI/CD"

# docker build -f ./ci/server . -t server:1.0.0