#!/bin/bash
set -e
set -u
set -o pipefail

app="wms-storage"
dependencies=()

source "../app_control.sh"