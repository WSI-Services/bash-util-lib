FROM ruby:latest

RUN gem install bashcov && \
    wget -qc https://raw.githubusercontent.com/kward/shunit2/v2.1.8/shunit2 -O /usr/local/bin/shunit2 && \
    chmod +x /usr/local/bin/shunit2

RUN useradd -ms /bin/bash ruby

USER ruby

WORKDIR /data
