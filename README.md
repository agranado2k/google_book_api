[![Build Status](https://travis-ci.org/agranado2k/google_book_api.svg?branch=master)](https://travis-ci.org/agranado2k/google_book_api)
[![Maintainability](https://api.codeclimate.com/v1/badges/a7d0cfaf2b86b9df97af/maintainability)](https://codeclimate.com/github/agranado2k/google_book_api/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/a7d0cfaf2b86b9df97af/test_coverage)](https://codeclimate.com/github/agranado2k/google_book_api/test_coverage)
# Google Book API 

You can access the project in the demo environment on [heroku here](https://thawing-crag-46147.herokuapp.com).

## Pre requirement
You need to install [docker compose](https://docs.docker.com/compose/install/).

## How to build the image
In the project's root folder execute the command:
```shell
docker-compose build
```

## How to run test
In the project's root folder execute the command
```shell
docker-compose run web bundle exec rake
```
If you want only execute RSpec, you can also execute the command
```shell
docker-compose run web bundle exec rspec
```

## How to run the project locally
In the project's root folder execute the command
```shell
docker-compose up web
```
And open in browser [http://localhost:3000](http://localhost:3000)

## How to deploy to Heroku
First you have to sign in [Heroku](https://heroku.com) and install [Heroku Cli](https://devcenter.heroku.com/articles/heroku-cli). After execute the command in project's folder:
- Login the Cli tool
```shell
heroku login
```
- Create application in heroku
```shell
heroku create
```
- Set Env Variables **RAILS_MASTER** and **GOOGLE_BOOK_API_KEY**
```shell
heroku config:set GOOGLE_BOOK_API_KEY={your google api key here}
heroku config:set RAILS_MASTER_KEY=`cat config/master.key`
```
- Login in Heroku container ([learn more here](https://devcenter.heroku.com/articles/container-registry-and-runtime))
```shell
heroku container:login
```
- Push the project to container
```shell
heroku container:push web
```
- Release the application
```shell
heroku container:release web
```
- Once it is done, open the application
```shell
heroku open
```


### Continuous Integration and Continuous Deployment
The `rake` command execute some code analysis:
- [Rubocop](https://github.com/rubocop-hq/rubocop) - a Ruby static code analyzer (a.k.a. linter) and code formatter. Out of the box it will enforce many of the guidelines outlined in the community.
- [Brakeman](https://brakemanscanner.org/) - Brakeman is a free vulnerability scanner specifically designed for Ruby on Rails applications. It statically analyzes Rails application code to find security issues at any stage of development. 
- [Bundle Audit](https://github.com/rubysec/bundler-audit) - Patch-level verification for bundler to check vulnerable versions of gems in Gemfile.lock, amongst other verifications.

In the project we're using [Travis-CI.org](https://travis-ci.org/agranado2k/google_book_api) as continuous integration tools that deploy on Heroku everytime we got green test's bar. Check the history [here](https://travis-ci.org/agranado2k/google_book_api).
Also we're deploying the project on [Heroku Container](https://devcenter.heroku.com/categories/deploying-with-docker) using [ruby:2.6-alpine](https://hub.docker.com/_/ruby) as image base.

### Important consideration
In this project we're using the design pattern [repository](https://martinfowler.com/eaaCatalog/repository.html) ([BookRepository](https://github.com/agranado2k/google_book_api/blob/master/app/repositories/book_repository.rb)), and design pattern [gateway](https://martinfowler.com/eaaCatalog/gateway.html) (that I called as [GoogleBookApiService](https://github.com/agranado2k/google_book_api/blob/master/app/services/google_book_api_service.rb)).

## Development draft

### Configuration

##### Step 1
- Create Docker image to ruby (alpine)
- Create Ruby project web without db and coffee script
- Install RSpec to Rails and create first dummy test
- Deploy in Heroku to docker container
- Configure secret key in Heroku env
- Configure Google Book Api key 
- Configure travisCI to CI/CD

##### Step 2
- Include and configure Rubocop
- Include gem audit
- Create README with badgets and first project description

### Pre-Development
- play with Google Books API
- get credentials
- configure credentials in Heroku environment
- configure credentials in Docker container to local environment

### Develpment
##### Features
- use [Google Books API](https://developers.google.com/books/docs/overview)
- Type in a query and display a list of books matching that query.
- Each item in the list should include the book's author, title, and publishing company, as well as a
picture of the book.
- From each list item, you should also be able to navigate to more information about the book,
but this information does not necessarily need to appear on a page within your application.
jIn other words, this could link out to an external site with more information about that particular book.

##### Request Call Example
https://www.googleapis.com/books/v1/volumes?q=sail&maxResults=10&startIndex=10&key={api_key}
use maxResults and startIndex to paginate
pay attention to q, it can have multiple term ==> sail+"atlantico sul"

