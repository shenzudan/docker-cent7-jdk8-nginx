FROM centos:7
LABEL maintainer="Stan<admin@stanwind.com>"

ENV LANG="en_US.UTF-8" \
    LANGUAGE="en_US:en" \
    LC_ALL="en_US.UTF-8"

ENV JAVA_VERSION="1.8"

ENV JAVA_HOME="/usr/local/jdk${JAVA_VERSION}"
ENV PATH="${PATH}:${JAVA_HOME}/bin"

# Do not use alias cp
RUN \cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && yum update -y \
    && yum install -y zip unzip tar curl \
    && echo "alias l='ls -al'" >> /root/.bashrc

# install jdk1.8
RUN curl --fail --location --retry 3 \
        http://dist.stanwind.com/jdk1.8.zip \
        -o /tmp/jdk.zip \
         && unzip -o /tmp/jdk.zip -d /usr/local/ \
         && \rm -f /tmp/jdk.zip ${JAVA_HOME}/src.zip ${JAVA_HOME}/javafx-src.zip


# Install nginx
RUN curl --fail --location --retry 3 \
        http://dist.stanwind.com/nginx-1.15.6.tar.gz \
        -o /tmp/nginx.tar.gz \
    && tar -zxf /tmp/nginx.tar.gz -C /usr/local/ \
    && \rm -f /tmp/nginx.tar.gz \
    && yum -y install pcre-devel openssl-devel gcc-c++ \
    && cd /usr/local/nginx-1.15.6/ \
    && ./configure --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module \
    && make && make install


# Overwrite nginx conf
COPY nginx.conf /usr/local/nginx/conf/
COPY vhost /usr/local/nginx/conf/

# Run nginx
#RUN /usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf
#ENTRYPOINT ["/usr/local/nginx/sbin/nginx","-c", "/usr/local/nginx/conf/nginx.conf"]


#EXPOSE 80