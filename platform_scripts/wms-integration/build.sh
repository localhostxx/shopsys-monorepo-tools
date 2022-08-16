#!/bin/bash
set -e
set -u
set -o pipefail

app="wms-integration"
dependencies=(
    "wms-resource" 
    "wms-oms" 
    "wms-masterdata" 
    "wms-storage"
    "gor-platform-auth"
    )

source "../app_control.sh"
