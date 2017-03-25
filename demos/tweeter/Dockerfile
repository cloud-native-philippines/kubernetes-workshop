FROM ruby:2.4.0

MAINTAINER Alistair Israel <alistair@agsx.net>

ENV RAILS_ENV production
ENV RACK_ENV production
ENV RAILS_SERVE_STATIC_FILES true

ENV NPM_CONFIG_LOGLEVEL info
ENV NODE_VERSION 7.2.0

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]

RUN mkdir -p /usr/src/app/client

WORKDIR /usr/src/app

# From https://github.com/nodejs/docker-node/blob/6a984d5b1f27b0344cbbab20019e77e6c0420b91/6.3/Dockerfile

RUN set -ex \
  && for key in \
    9554F04D7259F04124DE6B476D5A82AC7E37093B \
    94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
    0034A06D9D9B0064CE8ADF6BF1747F4AD2306D93 \
    FD3A5288F042B6850C66B31F09FE44734EB7990E \
    71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
    DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
    B9AE9905FFD7803F25714661B63B535A4C206CA9 \
    C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
  ; do \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
  done

RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" \
  && curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
  && gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc \
  && grep " node-v$NODE_VERSION-linux-x64.tar.xz\$" SHASUMS256.txt | sha256sum -c - \
  && tar -xJf "node-v$NODE_VERSION-linux-x64.tar.xz" -C /usr/local --strip-components=1 \
  && rm "node-v$NODE_VERSION-linux-x64.tar.xz" SHASUMS256.txt.asc SHASUMS256.txt
# throw errors if Gemfile has been modified since Gemfile.lock

RUN bundle config --global frozen 1

RUN mkdir config

# since we don't change JS libraries as much, do this first
# COPY package.json ./
RUN npm install

# COPY client /usr/src/app/client
# WORKDIR /usr/src/app/client
RUN npm install
WORKDIR /usr/src/app

# Gems don't change much either
COPY Gemfile Gemfile.lock ./

RUN gem install bundler
# RUN bundle install --without development test
RUN bundle install

# From hereon, this will almost always create new images
COPY . ./

# Precompile Rails assets
RUN bundle exec rake assets:precompile
# RUN bundle exec rake react_on_rails:assets:webpack
