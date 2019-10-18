FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs
WORKDIR /app
COPY Gemfile* /app/
RUN bundle
COPY . /app

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]