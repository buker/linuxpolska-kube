FROM ruby:2.2

MAINTAINER Łukasz Żułnowski "lzulnowski@gmail.com"
RUN apt-get update && apt-get install -y  \
    build-essential \
    wget \
    nginx \
    && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /app
ADD  ./ /app
RUN gem install bundler
WORKDIR /app
RUN bundler install && \
    bundle exec jekyll build
RUN rm -rf /etc/nginx/sites-enabled/default && \
    cp /app/nginx.conf /etc/nginx/sites-enabled/default
EXPOSE 80

CMD nginx -g 'daemon off;'
