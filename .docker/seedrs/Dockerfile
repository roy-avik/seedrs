FROM ruby:2.7.6

# Register Yarn package source.
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Install additional packages.
RUN apt update -qq
RUN apt install -y postgresql-client nodejs yarn
RUN apt-get install -y build-essential

# Prepare working directory.
WORKDIR /
COPY . .
RUN gem install bundler
RUN gem install ffi -v 1.15.5
RUN bundle install --path vendor/bundle
# RUN rails db:setup

# Configure endpoint.
# COPY ./.docker/seedrs/entrypoint.sh /usr/bin/
# RUN chmod 777 ./.docker/seedrs/entrypoint.sh
# ENTRYPOINT ["./.docker/seedrs/entrypoint.sh"]
EXPOSE 3000

# Start app server.
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
