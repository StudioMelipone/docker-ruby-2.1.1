#!/bin/sh
cd /rails_app
bundle install --path ./docker/bundle
bundle exec rake db:create
bundle exec rake db:migrate
/rails_app/docker/run.sh
