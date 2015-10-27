FROM mbrt/rust:min-nightly
MAINTAINER Michele Bertasi

# install rustfmt
RUN cargo install --git https://github.com/nrc/rustfmt      && \
    mv /root/.cargo/bin/rustfmt /usr/local/bin              && \
# cleanup
    rm -rf /root/.cargo /tmp/*

CMD ["/usr/local/bin/rustfmt"]
