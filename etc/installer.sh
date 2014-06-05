#!/bin/bash

echo 'Installing Ruby Bundler'
echo 'You may need to enter your password'
sleep 1
sudo gem install bundler

cat <<EOF > Gemfile
source 'https://rubygems.org'
gem 'guard-gradle'
EOF

echo 'Now installing required Guard::Gradle'
sleep 1
bundle install --path vendor

echo 'Initializing the Guard Nebula plugin'
sleep 1
bundle exec guard init nebula

echo 'This file will delete itself. Going forward to start Guard, run the guard.sh script'

cat <<EOF > guard.sh
bundle exec guard
EOF

chmod +x guard.sh

sleep 1

rm install-guard.sh