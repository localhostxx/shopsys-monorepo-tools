#!/bin/bash
set -e
set -u
set -o pipefail

app="wms-super"
dependencies=()

source "../app_control.sh"
