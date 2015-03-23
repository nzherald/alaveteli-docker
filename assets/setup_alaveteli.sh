#!/bin/bash

cd /opt

cd /opt/alaveteli
git submodule init
git submodule update

bundle install
