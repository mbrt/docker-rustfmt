FROM debian:jessie
MAINTAINER Michele Bertasi

ENV RUST_VERSION=nightly

# install pagkages
RUN apt-get update                                                                                  && \
    apt-get install -y --no-install-recommends build-essential curl ca-certificates                 && \
# install rust binaries
    cd /tmp                                                                                         && \
    curl -sO https://static.rust-lang.org/dist/rust-$RUST_VERSION-x86_64-unknown-linux-gnu.tar.gz   && \
    tar -xvzf rust-$RUST_VERSION-x86_64-unknown-linux-gnu.tar.gz                                    && \
    ./rust-$RUST_VERSION-x86_64-unknown-linux-gnu/install.sh --without=rust-docs                    && \
# install rustfmt
    cargo install --git https://github.com/nrc/rustfmt                                              && \
    mv /root/.cargo/bin/rustfmt /usr/local/bin                                                      && \
# cleanup
    apt-get remove --purge -y build-essential curl ca-certificates                                  && \
    apt-get autoremove -y && apt-get autoclean && apt-get clean                                     && \
    /usr/local/lib/rustlib/uninstall.sh                                                             && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /root/.cargo

CMD ["/usr/local/bin/rustfmt"]
