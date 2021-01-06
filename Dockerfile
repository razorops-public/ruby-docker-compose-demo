FROM ruby:2.7

RUN apt-get update -qq && apt-get install -y libsqlite3-dev libpq-dev

WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN gem install bundler:1.17.2 && bundle install
COPY . /app

EXPOSE 3000

# Start the main process.
CMD ["bundle", "exec", "rake", "server"]
