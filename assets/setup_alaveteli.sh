#!/bin/bash

cd /opt/alaveteli
git submodule init
git submodule update

bundle install --deployment --without development test
