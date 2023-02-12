FROM ruby:latest
RUN apt-get update -qq && apt-get install -y build-essential
ENV APP_DIR=/fetch
RUN mkdir -p $APP_DIR
WORKDIR $APP_DIR
ADD Gemfile $APP_DIR/Gemfile
ADD Gemfile.lock $APP_DIR/Gemfile.lock
RUN bundle install
ADD . $APP_DIR
ENTRYPOINT ["ruby", "main.rb"]