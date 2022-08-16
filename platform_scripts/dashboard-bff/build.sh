#!/bin/bash
set -e
set -u
set -o pipefail

app="dashboard-bff"
dependencies=()

source "../app_control.sh"