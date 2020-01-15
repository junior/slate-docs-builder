FROM ruby:2.7

RUN apt-get update && \
  apt-get install -y nodejs && \
  apt-get clean && \ 
  rm -rf /var/lib/apt/lists/*

WORKDIR /src/docs
COPY ./Gemfile* /src/docs

RUN gem install bundler
RUN bundle install --jobs 4 --retry 3

COPY . /src/docs
VOLUME /src/docs

RUN bundle exec middleman build --clean

EXPOSE 4567
CMD ["bundle", "exec", "middleman", "server", "--watcher-force-polling"]
