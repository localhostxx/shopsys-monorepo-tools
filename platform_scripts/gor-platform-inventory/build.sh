#!/bin/bash
set -e
set -u
set -o pipefail

app="gor-platform-inventory"
dependencies=()

source "../app_control.sh"