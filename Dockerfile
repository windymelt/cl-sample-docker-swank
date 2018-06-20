FROM ubuntu:16.04

ENV libs 'automake libcurl4-gnutls-dev make gcc curl bzip2 locales libev-dev bison libbison-dev'
RUN apt-get update \
  && apt-get install -y ${libs}

ENV roswell_archive_url 'https://github.com/roswell/roswell/archive/release.tar.gz'
RUN echo 'install roswell' \
  && curl -SL ${roswell_archive_url} \
  | tar -xzC /tmp/ \
  && cd /tmp/roswell-release \
  && sh bootstrap \
  && ./configure \
  && make \
  && make install \
  && rm -rf /tmp/roswell-release

# locale setting
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
COPY sbclrc /root/.sbclrc

RUN ros setup
RUN ros install qlot
RUN ros install clack
ENV PATH /root/.roswell/bin:/usr/local/bin:$PATH

# Assuming whole application directory is mounted as /app
WORKDIR /app/

CMD [ \
  "qlot", "exec", "ros", \
  "-e", "(ql:quickload :swank)", \
  "-e", "(setf swank::*loopback-interface* \"0.0.0.0\")", \
  "-e", "(swank:create-server :port 6005 :dont-close t :style :spawn)", \
  "-l", "bundle-libs/bundle.lisp", \
  "-S", ".", "~/.roswell/bin/clackup", "--server", ":woo", "--address", "0.0.0.0", "--port", "5000", "app.lisp" \
]
