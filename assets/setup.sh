#!/bin/bash

cd /opt/alaveteli

rm -rf lib/acts_as_xapian/xapiandbs/production

mkdir -p $XAPIAN_MOUNT_PATH/$RAILS_ENV
ln -s $XAPIAN_MOUNT_PATH/$RAILS_ENV lib/acts_as_xapian/xapiandbs/$RAILS_ENV

bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake themes:install
bundle exec rake assets:precompile

# Uncomment to rebuild the index on every launch of the container
# bundle exec rake xapian:rebuild_index models="PublicBody User InfoRequestEvent"

chown -R $(whoami) /data

bundle exec unicorn_rails -c ./config/unicorn.rb
