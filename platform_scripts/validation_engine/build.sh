#!/bin/bash
set -e
set -u
set -o pipefail

app="validation_engine"
dependencies=()

source "../app_control.sh"