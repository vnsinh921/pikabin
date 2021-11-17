#!/usr/bin/env sh
export RAILS_ENV=development
SECRET_KEY_BASE=$(bundle exec rake secret) bundle exec puma -C config/puma.rb
