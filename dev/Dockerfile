FROM ruby:latest

RUN gem install bashcov && \
    wget -qc https://raw.githubusercontent.com/kward/shunit2/v2.1.8/shunit2 -O /usr/local/bin/shunit2 && \
    chmod +x /usr/local/bin/shunit2 && \
    curl -sLo- http://get.bpkg.sh | bash

COPY --from=koalaman/shellcheck:latest /bin/shellcheck /usr/bin/shellcheck

RUN useradd -ms /bin/bash shell

ENV PS4=+%N:%i>

USER shell

WORKDIR /data
