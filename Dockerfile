FROM postgres:14

RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
    && sed -i 's|security.debian.org/debian-security|mirrors.ustc.edu.cn/debian-security|g' /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends wget bzip2 gcc gawk make libc6-dev git ca-certificates postgresql-server-dev-14 \
    && wget -q -O - http://www.xunsearch.com/scws/down/scws-1.2.3.tar.bz2 | tar xjf - \
    && cd scws-1.2.3 ; ./configure ; make install \
    && git clone https://github.com/amutu/zhparser.git \
    && cd  zhparser ; make && make install \
    && apt-get purge -y wget bzip2 gcc gawk make libc6-dev git ca-certificates postgresql-server-dev-14 \
    && apt-get autoremove --purge -y \
    && rm -rf /scws-1.2.3 /var/lib/apt/lists/*
