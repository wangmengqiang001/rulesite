#!/bin/bash

#CODERULE project name
CODERULE_PROJECT=jekyll-theme-chirpy-master

#locate the site path
CODERULE_BASE=$PWD/../$CODERULE_PROJECT/_site

#test running it in script folder or root
SITE_BASE=$PWD
if [ ! -e $SITE_BASE/scripts/run.sh ]; then
   SITE_BASE=$PWD/..
   CODERULE_BASE=$PWD/../../$CODERULE_PROJECT/_site
fi

if [ ! -d $CODERULE_BASE ]; then
   echo 'Cannot find coderule in' $CODERULE_BASE
   exit 10
fi

#stop siterule first

if [[ -n $(docker ps |grep siterule) ]]
then
   docker stop siterule
fi

docker run --rm --name siterule -d -p 8270:80 \
 -v $CODERULE_BASE:/usr/share/nginx/site \
 -v $SITE_BASE/nginx/default.conf:/etc/nginx/conf.d/default.conf \
 -v $SITE_BASE/plugins:/usr/share/nginx/plugins nginx
