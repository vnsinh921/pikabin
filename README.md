pikabin
=======

Paste tool with inline commenting support.

Installation
------------

```bash
# Cloning repo
git clone git@github.com:vnsinh921/pikabin.git
cd pikabin/

#Install package on Ubuntu-20.04
apt-get update
apt-get install -y curl gnupg build-essential software-properties-common
apt-add-repository ppa:brightbox/ruby-ng
apt-get install -y sqlite3 libsqlite3-dev ruby-bundler libgmp3-dev ruby ruby-dev  zlib1g-dev liblzma-dev patch

# Setup
export RAILS_ENV=development
bundle update activesupport
bundle install

# Config db
vim config/database.yml
cat config/database.yml
development:
  adapter: sqlite3
  pool: 5
  timeout: 5000
  database: db/pikabin_development.sqlite3

# Migrate DB
dpkg -r --force-depends ruby-thor && gem install thor
bundle exec rake db:migrate
bundle exec rake assets:precompile

# Start service with puma
SECRET_KEY_BASE=$(bundle exec rake secret) bundle exec puma
# Listening on tcp://0.0.0.0:8080
```

RUN on Docker
-------------
```bash
# Docker build image:
docker build -t pikabin .
# Docker run container
docker run -d -p 8080:8080 --name pikabin pikabin:latest
```
API
---

```bash
curl -X POST -H "content-type: application/json" -d '{ "document": { "content": "sinhtv" } }' "http://localhost:8080"

# Response
{"message":"","uri":"http://localhost:8080/31037f223195e451e0ebe56e8e041d0c756fe"}
```
Source
------
Clone: https://github.com/tunglam14/pikabin [@tunglam14](https://github.com/tunglam14)  

Edit & update: https://github.com/vnsinh921/pikabin [@vnsinh921](https://github.com/vnsinh921)

Wanna contribute?
-----------------

Your contribution are welcome, desired features are in [TODO.md](https://github.com/vnsinh921/pikabin/blob/master/TODO.md)
