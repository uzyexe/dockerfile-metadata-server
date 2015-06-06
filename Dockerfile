FROM ruby:2.2.2-slim

RUN gem install sinatra --no-ri --no-rdoc

WORKDIR /metadata
VOLUME /metadata/public

ADD server.rb /metadata/server.rb

ENTRYPOINT ["ruby", "/metadata/server.rb"]

EXPOSE 4567
