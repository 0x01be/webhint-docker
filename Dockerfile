FROM alpine as build

RUN apk add --no-cache --virtual webhint-build-dependecies \
    git \
    nodejs-dev \
    npm \
    yarn

ENV WEBHINT_REVISION master
RUN git clone --depth 1 --branch ${WEBHINT_REVISION} https://github.com/webhintio/hint.git /webhint

WORKDIR /webhint

RUN yarn
RUN yarn build

