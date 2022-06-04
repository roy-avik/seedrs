# README

# Seedrs Mini API


* Ruby version
```
2.7.6
```

* Database creation and running server
for running in local dev
fix the database_url in the .env

```
RUN gem install bundler
RUN bundle install
RUN rails db:setup
RUN rails s
```
* How to run the test suite
```
RUN rspec
```
* DOCKER COMPOSE
From CMD or Bash
```
docker-compose build

docker-compose up
```

* or

simply run the ./start.sh from BASH
