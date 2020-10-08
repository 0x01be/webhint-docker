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
    nodejs \
    grep \
    chromium \
    xvfb

RUN adduser -D -u 1000 webhint
RUN mkdir -p /usr/lib/node_modules/hint/node_modules/@hint/formatter-html/dist/src/assets/js/scan/
RUN chown -R webhint:webhint /usr/lib/node_modules/hint/node_modules/@hint/formatter-html/dist/src/assets/js/scan/

USER webhint

WORKDIR /home/webhint/

ENV DISPLAY :99

RUN echo "Xvfb ${DISPLAY} -dpi 100 -screen 0 1024x768x24 &" > ./init.sh 

ENV TARGET http://localhost:3000

CMD ["/bin/sh","-c","sh init.sh && hint ${TARGET}"]

