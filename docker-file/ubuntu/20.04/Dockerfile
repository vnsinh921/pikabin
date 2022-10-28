FROM ubuntu:20.04

#Config timezone 
ENV TZ=Asia/Ho_Chi_Minh
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#Install package
RUN sed -i 's/archive/vn.archive/g' /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y curl gnupg build-essential software-properties-common
RUN apt-add-repository ppa:brightbox/ruby-ng
RUN apt-get install -y sqlite3 libsqlite3-dev ruby-bundler libgmp3-dev ruby ruby-dev zlib1g-dev liblzma-dev patch
RUN bundle -v && bundler -v
RUN mkdir -p /app
WORKDIR /app
COPY . /app 

#Install 
ENV RAILS_ENV=development
RUN bundler install && dpkg -r --force-depends ruby-thor && gem install thor --version 1.1.0 && rm -rf /var/cache/* /tmp/* /var/log/*
EXPOSE 8080
#Entrypoint
ENTRYPOINT ["/bin/bash","entrypoint.sh"]
