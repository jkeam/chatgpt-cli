FROM registry.access.redhat.com/ubi9/ruby-33:9.5-1743514808

USER root

COPY Gemfile* .
RUN bundle

USER 1001

COPY lib ./lib
COPY app.rb .

CMD ["ruby", "app.rb"]
