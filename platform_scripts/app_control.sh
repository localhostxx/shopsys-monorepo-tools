#!/bin/bash
#This file contains the main logic being used by other app level scripts to compile

app=`pwd`
log_file=$app/log

echo "Building $app" > $log_file

# Normal Behaviour is run install
# Install Cores
for dep in ${dependencies[@]}; do
  cd ../${dep}
  core=`ls -d *core*`
  echo "Building $core" >> $log_file
  mvn clean install -pl $core -am
  if [[ "$?" -ne 0 ]] ; then
      echo "${core} tests failed">> $log_file; exit 1 
  fi
done

cd "${app}"
core=`ls -d *core*`
echo "Building $core" >> $log_file
mvn clean install -pl $core -am
if [[ "$?" -ne 0 ]] ; then
    echo "${core} tests failed">> $log_file; exit 1 
fi

# Install Clients
for dep in ${dependencies[@]}; do
  cd ../$dep
  client=`ls -d *client*`
  echo "Building $client">> $log_file
  mvn clean install -pl $client -am
  if [[ "$?" -ne 0 ]] ; then
      echo "${client} tests failed">> $log_file; exit 1 
  fi
done

cd "${app}"
client=`ls -d *client*`
echo "Building $client">> $log_file
mvn clean install -pl $client -am
if [[ "$?" -ne 0 ]] ; then
    echo "${client} tests failed">> $log_file; exit 1
fi

# Install Everything (root POM)
for dep in ${dependencies[@]}; do
  cd ../${dep}
  
  echo "Building $dep">> $log_file
  mvn clean install 
  if [[ "$?" -ne 0 ]] ; then
      echo "${dep} tests failed">> $log_file; exit 1 
  fi
done

cd "${app}"
echo "Building $app">> $log_file
mvn clean install
if [[ "$?" -ne 0 ]] ; then
    echo "${app} tests failed">> $log_file; exit 1
fi
