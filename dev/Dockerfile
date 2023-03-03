ARG SHELLCHECK_VERSION=0.9.0
ARG SHUNIT2_VERSION=2.1.8
ARG BASHCOV_VERSION=1.8.2

FROM koalaman/shellcheck:v${SHELLCHECK_VERSION} as shellcheck

FROM ruby:latest

ARG SHELLCHECK_VERSION
ARG SHUNIT2_VERSION
ARG BASHCOV_VERSION

RUN gem install bashcov -v ${BASHCOV_VERSION} && \
    wget -qc https://raw.githubusercontent.com/kward/shunit2/v${SHUNIT2_VERSION}/shunit2 -O /usr/local/bin/shunit2 && \
    chmod +x /usr/local/bin/shunit2 && \
    curl -sLo- http://get.bpkg.sh | bash

COPY --from=shellcheck /bin/shellcheck /usr/bin/shellcheck

RUN useradd -ms /bin/bash shell

ENV SHELLCHECK_VERSION=${SHELLCHECK_VERSION}
ENV BASHCOV_VERSION=${BASHCOV_VERSION}
ENV SHUNIT2_VERSION=${SHUNIT2_VERSION}
ENV PS4=+%N:%i>

USER shell

WORKDIR /data
