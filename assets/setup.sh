#!/bin/bash

cd /opt/alaveteli
bundle exec rake themes:install
bundle exec rake assets:precompile
bundle exec rake db:migrate
bundle exec rake xapian:rebuild_index models="PublicBody User InfoRequestEvent"

bundle exec unicorn_rails -c ./config/unicorn.rb
