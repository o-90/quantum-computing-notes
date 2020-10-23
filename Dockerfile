FROM ubuntu:18.04

RUN set -ex \
  && ln -snf /usr/share/zoneinfo/Etc/UTC /etc/localtime \
  && apt-get update \
  && apt-get install -y \
    wget \
    xzdec \
    perl \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN set -ex \
  && mkdir -p build \
  && cd build \
  && wget https://mirror.lyrahosting.com/CTAN/systems/texlive/tlnet/install-tl-unx.tar.gz \
  && tar -xzvf install-tl-unx.tar.gz \
  && cd install-tl* \
  && printf 'I' | perl ./install-tl \
  && cd ../../ \
  && rm -rf build/

ENV PATH="/usr/local/texlive/2020/bin/x86_64-linux:${PATH}"

CMD ['/bin/bash']
