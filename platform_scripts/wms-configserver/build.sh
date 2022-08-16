#!/bin/bash
set -e
set -u
set -o pipefail

app="wms-configserver"
dependencies=()

source "../app_control.sh"
