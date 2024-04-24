#!/bin/bash

EB_APP_STAGING_DIR=$(sudo /opt/elasticbeanstalk/bin/get-config platformconfig -k AppStagingDir)
cd $EB_APP_STAGING_DIR

gem install bundler --no-document -v 2.5.3
