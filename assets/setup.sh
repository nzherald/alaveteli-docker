#!/bin/bash

if [ -z "$NEWRELIC_LICENSE_KEY" ]; then

  nrsysmond-config --set license_key=$NEWRELIC_LICENSE_KEY
  /etc/init.d/newrelic-sysmond start

fi

cd /opt/alaveteli

rm -rf /opt/alaveteli/lib/acts_as_xapian/xapiandbs/production

mkdir /opt/alaveteli/lib/acts_as_xapian/xapiandbs

echo "making $XAPIAN_MOUNT_PATH/$RAILS_ENV"
mkdir -p $XAPIAN_MOUNT_PATH/$RAILS_ENV

echo "linking $XAPIAN_MOUNT_PATH/$RAILS_ENV/ to /opt/alaveteli/lib/acts_as_xapian/xapiandbs/$RAILS_ENV/"
ln -s $XAPIAN_MOUNT_PATH/$RAILS_ENV/ /opt/alaveteli/lib/acts_as_xapian/xapiandbs/$RAILS_ENV

bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake themes:install
bundle exec rake assets:precompile

rm -rf /data/alaveteli/public
cp -rf /opt/alaveteli/public /data/alaveteli

chown -R $(whoami) /data

bundle exec unicorn_rails -c ./config/unicorn.rb
