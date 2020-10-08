FROM alpine as build

RUN apk add --no-cache --virtual webhint-build-dependecies \
    npm

RUN npm install -g hint

FROM alpine

COPY --from=build /usr/lib/node_modules/ /usr/lib/node_modules/

RUN apk add --no-cache --vitual webhint-runtime-dependencies \
    nodejs

RUN adduser -D -u 1000 webhint

USER webhint

CMD hint

