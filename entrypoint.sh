#!/usr/bin/env sh
export RAILS_ENV=development
bundle exec rake db:migrate
bundle exec rake assets:precompile
SECRET_KEY_BASE=$(bundle exec rake secret) bundle exec puma -C config/puma.rb
