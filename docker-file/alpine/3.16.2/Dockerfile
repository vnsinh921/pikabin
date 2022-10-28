FROM alpine:3.16.2 

# Update package
RUN apk update && apk upgrade

# Install package
RUN apk add bash tzdata curl gnupg build-base ruby-bundler ruby-dev 

#Config timezone 
ENV TZ=Asia/Ho_Chi_Minh
RUN ln -s /usr/share/zoneinfo$TZ /etc/localtime

# Create working dir
RUN pwd
RUN mkdir -p /app
WORKDIR /app
COPY ./ /app
# Replace sqlite3 version
RUN sed -i 's/1.4.2/1.5.3/g' Gemfile && rm -rf /app/Gemfile.lock

#Install gem package
ENV RAILS_ENV=development
RUN bundler install && rm -rf /var/cache/* 

# Expose port
EXPOSE 8080
#Entrypoint
ENTRYPOINT ["/bin/bash","entrypoint.sh"]
