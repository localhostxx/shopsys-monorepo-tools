#!/bin/bash
set -e
set -u
set -o pipefail

app="wms-common"
dependencies=()

source "../app_control.sh"