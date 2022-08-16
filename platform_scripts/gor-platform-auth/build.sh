#!/bin/bash
set -e
set -u
set -o pipefail

app="gor-platform-auth"
dependencies=("wms-storage")

source "../app_control.sh"
