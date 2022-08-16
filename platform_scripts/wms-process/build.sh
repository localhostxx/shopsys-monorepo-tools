#!/bin/bash
set -e
set -u
set -o pipefail

app="wms-process"
dependencies=()

source "../app_control.sh"
