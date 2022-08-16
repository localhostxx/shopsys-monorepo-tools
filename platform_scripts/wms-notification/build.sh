#!/bin/bash
set -e
set -u
set -o pipefail

app="wms-oms"
dependencies=("wms-resource")

source "../app_control.sh"
