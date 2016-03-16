FROM alpine:3.2

# install common packages
RUN echo "http://mirrors.ustc.edu.cn/alpine/v3.2/main/" > /etc/apk/repositories
RUN apk add --update-cache curl bash sudo && rm -rf /var/cache/apk/*

RUN curl -sSL -o /usr/local/bin/etcdctl http://sinacloud.net/hehe/etcd/etcdctl-v0.4.9 \
	&& chmod +x /usr/local/bin/etcdctl

# install confd
RUN curl -sSL -o /usr/local/bin/confd http://sinacloud.net/hehe/confd/confd-0.11.0-linux-amd64 \
	&& chmod +x /usr/local/bin/confd

# ADD build.sh /tmp/build.sh
# RUN DOCKER_BUILD=true /tmp/build.sh

RUN apk add --update-cache \
  build-base \
  curl \
  file \
  gcc \
  git \
  libffi-dev \
  libxml2-dev \
  libxslt-dev \
  openssl-dev \
  postgresql \
  postgresql-client

RUN mkdir -p /etc/postgresql/main /var/lib/postgresql

RUN chown -R root:postgres /etc/postgresql/main /var/lib/postgresql

# define the execution environment
WORKDIR /app
CMD ["/app/bin/boot"]
EXPOSE 5432
ADD . /app

ENV DEIS_RELEASE 1.13.0-dev
