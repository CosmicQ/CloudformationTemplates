#!/bin/bash

TEMPLATES=`ls |grep -v answers|grep json`

for i in $TEMPLATES; do
  echo "Checking Template: $i"
  aws cloudformation validate-template --template-body file://$i
  if [ $? != 0 ]; then
    exit
  fi
done
