#!/bin/bash
CHEF_VERSION="12.10.24"
if rpm -qa | grep chef | grep $VERSION; then
   exit
elif rpm -qa | grep chef | grep -v $CHEF_VERSION; then
   rpm -e chef && curl -L "http://www.opscode.com/chef/download?p=el&pv=6&m=x86_64&v=$CHEF_VERSION" -o chef-install && rpm -Uvh chef-install
else
   curl -L "http://www.opscode.com/chef/download?p=el&pv=6&m=x86_64&v=$CHEF_VERSION" -o chef-install && rpm -Uvh chef-install
fi