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
  database: db/sqlite/pikabin_development.sqlite3

# Migrate DB
dpkg -r --force-depends ruby-thor && gem install thor
bundle exec rake db:migrate
bundle exec rake assets:precompile

# Start service with puma
SECRET_KEY_BASE=$(bundle exec rake secret) bundle exec puma -C config/puma.rb
# Listening on tcp://0.0.0.0:8080
```
RUN on Docker
-------------
```bash
# Docker build image:
docker build -t pikabin .
# Docker run container
docker run -d -p 8080:8080 --name pikabin pikabin:latest
# or
docker run -d -p 8080:8080 --volume $PIKA_HOME:/app/db/sqlite --name pikabin pikabin:latest
```
API
---

```bash
curl -X POST -H "content-type: application/json" -d '{ "document": { "content": "Insert content" } }' "http://localhost:8080"

# Response
{"message":"","uri":"http://localhost:8080/31037f223195e451e0ebe56e8e041d0c756bc"}
```

### Request

Header:

    * Conten-type: application/json

Body:

```json
{
  "document": {
    "content": "Paste content",
    "title": "Paste title | can be empty | Default: empty",
    "expired_at": "Expiration time in minute | 0: delete after reading | -1: No expire | Default: 0",
    "syntax": "Paste color syntax | See more: https://github.com/tunglam14/pikabin/blob/master/config/initializers/00contants.rb#L1 | Default: plain"
  }
}
```

### Response

#### Success

Code: `201`

Body:

```json
{
  "message": "",
  "uri": "https://pikab.in/e90e9f9ff807091bb589b0e4db203bc3e92c4"
}
```

#### Error

Code: `400`

Body:

```json
{
  "message": [
    "Content can't be blank"
  ],
  "uri": ""
}
```


### Show document

raw:

```bash
curl https://pikab.in/936279c6f3.raw
Insert content
```

json:

```bash
curl https://pikab.in/936279c6f3.json
{"content_decrypted":"Insert content ","title":"","expired_at":"-1","syntax":"plain"}
```
Source
------

* Clone: https://github.com/tunglam14/pikabin [@tunglam14](https://github.com/tunglam14)  

* Edit & update: https://github.com/vnsinh921/pikabin [@vnsinh921](https://github.com/vnsinh921)  

Client
------

* Python: [pikapy](https://github.com/tunglam14/pikapy) by [@kinhvan017](https://github.com/kinhvan017)
* Golang: [pikago](https://github.com/Gnouc/pikago) by [@Gnouc](https://github.com/Gnouc)

Star point
----------

* Security:

    - Encrypt content with random password: [[...]](https://github.com/tunglam14/pikabin/blob/master/lib/cryptor.rb#L12)
    - [Don't log password](https://github.com/tunglam14/pikabin/blob/master/config/initializers/filter_parameter_logging.rb#L4), [request URI](https://github.com/tunglam14/pikabin/blob/master/config/environments/production.rb#L49) in production environment
    - Remove expired document immediately [[...]](https://github.com/tunglam14/pikabin/blob/master/app/models/document.rb#L114)
    - Remove document after reading

* UI:

    - Front-end framework: Semantic-UI
    - Editor: ACE Editor
    - Syntax highlighting: SyntaxHighlighter

Wanna contribute?
-----------------

Your contribution are welcome, desired features are in [TODO.md](https://github.com/tunglam14/pikabin/blob/master/TODO.md)
