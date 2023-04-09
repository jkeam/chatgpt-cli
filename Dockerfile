FROM registry.access.redhat.com/ubi9/ruby-31@sha256:4f5acbdec609b4e89233c5df6093eb269af5ec9117f0da91804610b8bad9c754

USER root

COPY Gemfile* .
RUN bundle

USER 1001

COPY lib ./lib
COPY app.rb .
copy run.sh .

CMD ["ruby", "app.rb"]
