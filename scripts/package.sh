#!/bin/bash
# check target folder

if [ ! -d _site ]; then
   echo 'folder site does not exist!'
   exit 10
fi

if [ -d target ]; then
  if [ -e target/codeRules.zip ]; then
     rm -f ./target/codeRules.zip
  fi
else
  mkdir target
fi


# zip the files 
mv _site site
# Maybe, zip is not installed
zip -rv ./target/codeRules.zip nginx site plugins deploy.txt
mv site _site
