git_user_name=Shubham_Kumar_GreyOrange

repo_list=(
    wms-super
    wms-common
    wms-serviceregistry
    wms-configserver
    api-gateway
    wms-integration
    gor-platform-auth
    wms-storage
    wms-masterdata
    wms-resource
    wms-oms
    wms-notification
    wms-process
    gor-platform-utils
    dashboard-bff
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

git remote add github https://github.com/greyorange/platform-test

# Add platform scripts
cp -R "../platform_scripts/*" "."
git commit -m "[ADD] platform scripts"

echo "Github handle is named as 'github'"
echo "Push: git push github <branch-name>"

# Remove wms-reports target directory 
git rm -r --cached wms=reports/report-service/target
git rm -r --cached wms=reports/report-core/target
git rm -r --cached wms=reports/report-client/target
git commit -m "[REMOVE] wms-reports target directory unversioned"

# Remove .classpath files from wms-process
git rm -r --cached wms-process/process-exception/.classpath
git rm -r --cached wms-process/process-pack/.classpath
git rm -r --cached wms-process/process-put-notification/.classpath
git commit -m "[REMOVE] wms-process .classpath unversioned"
