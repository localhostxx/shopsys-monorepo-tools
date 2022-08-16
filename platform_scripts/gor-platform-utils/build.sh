#!/bin/bash
set -e
set -u
set -o pipefail

app="gor-platform-utils"
dependencies=()

source "../app_control.sh"