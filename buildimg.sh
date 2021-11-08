#!/bin/bash

#CODERULE project name

if [ -z $CODERULE_PROJECT ]; then
   CODERULE_PROJECT=jekyll-theme-chirpy-master
fi

#locate the site path
CODERULE_BASE=$PWD/../$CODERULE_PROJECT/_site

#test running it in script folder or root
SITE_BASE=$PWD
if [ ! -e $SITE_BASE/scripts/run.sh ]; then
   CODERULE_BASE=$PWD/../../$CODERULE_PROJECT/_site
fi

if [ ! -d $CODERULE_BASE ]; then
   echo 'Cannot find coderule in' $CODERULE_BASE
   exit 10
fi

# copy $CODERULE_BASE to site
# if exists, then rm first
if [ -d site ]; then
  rm -rf site
fi

echo '_site from' $CODERULE_BASE

cp -r $CODERULE_BASE _site

# rm the local image 
 
if [ ! -z $(docker images -q siterule:latest) ]; then 
   echo 'removed the previous version first'
   docker rmi siterule:latest  
   if [ $? != 0 ]; then
     echo 'removed image failed' 
     exit 2

   fi
fi

#build image
docker build -t siterule:latest .

#call package
./scripts/package.sh

echo 'remove _site'
rm -rf _site

