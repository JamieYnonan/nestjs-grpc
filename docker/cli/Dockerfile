FROM node:12.15-alpine

ARG VERSION
LABEL maintainer="Jamie Ynonan <jamiea31@gmail.com>"
LABEL version=$VERSION

RUN apk update && apk upgrade

ARG TIME_ZONE
RUN ln -snf /usr/share/zoneinfo/$TIME_ZONE /etc/localtime && echo $TIME_ZONE > /etc/timezone

RUN npm i -g @nestjs/cli

USER node
