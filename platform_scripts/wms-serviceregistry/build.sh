#!/bin/bash
set -e
set -u
set -o pipefail

app="wms-serviceregistry"
dependencies=()

source "../app_control.sh"
