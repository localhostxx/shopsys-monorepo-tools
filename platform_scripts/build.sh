#!/bin/bash

log_file="log"
rootdir=$(pwd)
extra_args="$@"

# Remove the .m2 folder
# rm -rf ~/.m2/repository/com/gor/platform/
# mkdir -p ~/.m2/repository/com/gor/platform/
# cp -r ./Bootstrap/* ~/.m2/repository/com/gor/platform/

# Install platform parent
now=`date +"%m/%d/%Y %H:%M:%S"`
echo "[${now}]: wms-super" > $log_file
cd "wms-super/"
mvn clean install $extra_args
cd ../

cores=(
    "wms-common/common-core/"
    "wms-common/common-data/"
    "wms-common/common-kafka/"
    "wms-notification/notification-core/" 
    "wms-integration/integration-core/"
    "validation_engine/validation-core/"
    "wms-billing/billing-core/"
    "gor-platform-auth/auth-core/"
    "wms-storage/storage-core/"
    "wms-masterdata/mdm-core/"
    "wms-oms/srms-core/"
    "wms-resource/resources-core/"
    "wms-process/process-core/"
    "gor-platform-utils/utils-core/"
    "dashboard-bff/dashboard-core/"
    "wms-reports/report-core/"
    )

clients=(
    "wms-common/common-rest-client/"
    "wms-notification/notification-client/"
    "wms-common/common-rest-client/"
    "wms-integration/integration-client/"
    "wms-billing/billing-client/"
    "gor-platform-auth/auth-client/"
    "wms-storage/storage-client/"
    "wms-masterdata/mdm-client/"
    "wms-resource/resources-client/"
    "wms-oms/srms-client/"
    "gor-platform-utils/utils-client/"
    "dashboard-bff/dashboard-client/"
    "wms-process/process-client/"
    "validation_engine/validation-client/"
    "wms-reports/report-client/"
    )

app=(
    "wms-common/"
    "wms-notification/" 
    "wms-integration/"
    "validation_engine/"
    "wms-billing/"
    "gor-platform-auth/"
    "wms-storage/"
    "wms-masterdata/"
    "wms-oms/"
    "wms-resource/"
    "wms-process/"
    "gor-platform-utils/"
    "dashboard-bff/"
    "wms-reports/"
    )

function install() {
    # $1: repo to run
    arr=("$@")
    for ele in ${arr[@]}; do

        dir=(${ele//// })

        now=`date +"%m/%d/%Y %H:%M:%S"`
        echo "[${now}]: $ele ${#dir[@]}" >> $log_file

        if [[ ${#dir[@]} -eq 2 ]]; then
            cd ${dir[0]}
            mvn clean install -pl ${dir[1]} -am $extra_args
            status=$?              
        else
            cd ${dir[0]}
            mvn clean install $extra_args
            status=$?
        fi
        
        cd $rootdir
        
        if [[ $status -ne 0 ]] ; then
            echo "[Error code: $status]: in installing $ele" >> $log_file
            exit 1
        fi
    done
}


# Install core
now=`date +"%m/%d/%Y %H:%M:%S"`
echo "[${now}]: Installing Cores" >> $log_file
install ${cores[@]} 

# Install client
now=`date +"%m/%d/%Y %H:%M:%S"`
echo "[${now}]: Installing Clients" >> $log_file
install ${clients[@]} 

# Install service
now=`date +"%m/%d/%Y %H:%M:%S"`
echo "[${now}]: Installing Service" >> $log_file
install ${app[@]} 
