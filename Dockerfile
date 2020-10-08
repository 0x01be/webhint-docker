FROM alpine as build

RUN apk add --no-cache --virtual webhint-build-dependecies \
    npm \
    python3

RUN mkdir -p /usr/lib/node_modules/hint/node_modules/canvas/.node-gyp
RUN npm install -g --loglevel verbose \
    hint

FROM alpine

COPY --from=build /usr/lib/node_modules/ /usr/lib/node_modules/
RUN ln -s /usr/lib/node_modules/hint/dist/src/bin/hint.js /usr/bin/hint

RUN apk add --no-cache --virtual webhint-runtime-dependencies \
    nodejs

RUN adduser -D -u 1000 webhint

USER webhint

CMD hint

