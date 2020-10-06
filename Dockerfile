FROM 0x01be/webhint:build as build

FROM alpine

RUN mkdir -p /opt/webhint

COPY --from=build /webhint/* /opt/webhint/

RUN apk add --no-cache --virtual webhint-build-dependecies \
    nodejs \
    npm \
    yarn

RUN adduser -D -u 1000 webhint

USER webhint

ENV PATH ${PATH}:/opt/webhint/bin/

