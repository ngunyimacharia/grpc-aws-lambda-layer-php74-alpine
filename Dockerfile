FROM php:7.4-fpm-alpine

ARG AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION:-"af-south-1"}

ARG AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID:-""}

ARG AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY:-""}

ENV AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION}

ENV AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}

ENV AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}

ARG GRPC_VERSION=v1.36.4

# Install dependencies
RUN apk add --no-cache $PHPIZE_DEPS libstdc++ zlib-dev linux-headers

# Build gRPC
RUN CPPFLAGS="-Wno-maybe-uninitialized"  pecl install grpc

# Upload to AWS
RUN apk add --no-cache \
        zip \
        unzip \
        python3 \
        py3-pip \
    && pip3 install --upgrade pip \
    && pip3 install \
        awscli \
    && rm -rf /var/cache/apk/*

RUN aws --version   # Just to make sure its installed alright

RUN mkdir -p /opt/bref-extra \
    && mkdir -p /opt/bref/etc/php/conf.d/

RUN cp `php-config --extension-dir`/grpc.so /opt/bref-extra/grpc.so

RUN /bin/echo -e 'extension=/opt/bref-extra/grpc.so' > /opt/bref/etc/php/conf.d/ext-grpc.ini

RUN zip -r grpc.zip /opt

RUN zipinfo grpc.zip

RUN aws lambda publish-layer-version \
     --layer-name "php74-grpc-layer" \
     --region "af-south-1" \
     --zip-file "fileb:///var/www/html/grpc.zip"
