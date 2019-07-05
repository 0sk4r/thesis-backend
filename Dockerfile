FROM ruby:2.6.2-alpine

RUN apk update && apk add build-base nodejs postgresql-dev tzdata

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install --binstubs

COPY . .

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["sh", "/usr/bin/entrypoint.sh"]
EXPOSE 3000

CMD ["bundle","exec", "rails", "s", "-b", "0.0.0.0"]