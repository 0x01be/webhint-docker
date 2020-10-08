FROM alpine

RUN apk add --no-cache --virtual webhint-build-dependecies \
    nodejs \
    npm \
    yarn

RUN npm install -g hint

RUN adduser -D -u 1000 webhint

USER webhint

CMD hint

