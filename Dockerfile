FROM ruby:2.7.1

RUN apt-get update -qq && apt-get install -y nodejs build-essential postgresql-client
RUN mkdir /usr/src/app

WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/Gemfile
COPY Gemfile.lock /usr/src/app/Gemfile.lock
COPY vendor /usr/src/app/vendor

RUN gem install bundler && bundle install

COPY . /usr/src/app

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
