FROM ruby:3.1.4-alpine

# Add tzdata for timezone data required by TZInfo gem
RUN apk add --no-cache build-base mongodb-tools tzdata

ENV APP_HOME /web-crawler
ENV GEM_HOME="/usr/local/bundle"
ENV PATH $GEM_HOME/bin:$GEM_HOME/gems/bin:$APP_HOME/:$PATH

COPY devops/docker/entrypoint.sh /
COPY Gemfile* $APP_HOME/

WORKDIR $APP_HOME

RUN bundle install

COPY . $APP_HOME

ENTRYPOINT ["sh", "/entrypoint.sh"]
