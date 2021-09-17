FROM alpine:3.13

MAINTAINER Artem Protsenko <ArtProPy@gmail.com>

ENV BRANCH main

ENV HOME /root

COPY id_rsa "${HOME}"

COPY id_rsa.pub "${HOME}"

RUN echo https://mirror.yandex.ru/mirrors/alpine/v3.12/main/       > /etc/apk/repositories \
 && echo https://mirror.yandex.ru/mirrors/alpine/v3.12/community/ >> /etc/apk/repositories \
 && apk --update add \
    gcc \
    git \
    linux-headers \
    musl-dev \
    openssh \    
    postgresql-dev \
    python3 \
    python3-dev \
    py3-pip \
 \
 && mkdir "${HOME}"/.ssh \
 && mv "${HOME}"/id_rsa "${HOME}"/.ssh \
 && mv "${HOME}"/id_rsa.pub "${HOME}"/.ssh \
 && ssh-keyscan github.com > "${HOME}"/.ssh/known_hosts \
 \
 && mkdir /var/www/ \
 && cd /var/www \
 && git clone -b $BRANCH --depth 1 git@github.com:ArtProPy/mysite.git \
 \
 && adduser --disabled-password --home /var/www www-data \
 && chown -R www-data:www-data /var/www \
 \
 && cd mysite \
 \
 && pip install -r requirements.txt \
 && apk del \
    gcc \
    git \
    openssh \
 && rm -rf /var/cache/apk/*

USER www-data

WORKDIR /var/www/mysite

COPY ./config/uwsgi.ini /var/www/mysite 

COPY docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
