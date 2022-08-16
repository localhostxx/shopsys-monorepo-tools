git_user_name=Shubham_Kumar_GreyOrange

repo_list=(
    wms-super
    wms-common
    wms-serviceregistry
    wms-configserver
    # wms-gateway
    wms-integration
    # gor-platform
    wms-storage
    wms-masterdata
    wms-resource
    wms-oms
    wms-notification
    wms-process
    gor-platform-utils
    dashboard-bff
    gor-platform-inventory
    gor-platform-transformer
    validation_engine
    wms-reports
    wms-billing
)
if [ ! -d "./workspace" ]; then
  mkdir ./workspace
fi

cd ./workspace

if [ -d ".git"]; then
    rm -r .git
fi

git init

for f in ${repo_list[@]}
do
    echo $f
    git remote add $f "https://$git_user_name@bitbucket.org/gorcode/$f.git"
done

echo Fetching
git fetch --all --no-tags

bash ../monorepo_build.sh "${repo_list[@]}"