FROM ruby:2.7

ADD . /app

RUN bundle install --without development test

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
