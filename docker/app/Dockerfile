FROM node:12.15-alpine AS build
LABEL stage=intermediate

COPY ./app /usr/src/app

WORKDIR /usr/src/app

RUN npm install --only-prod && npm run build

FROM node:12.15-alpine

ARG VERSION
LABEL maintainer="Jamie Ynonan <jamiea31@gmail.com>"
LABEL version=$VERSION

#RUN apk update && apk upgrade

ARG TIME_ZONE
RUN ln -snf /usr/share/zoneinfo/$TIME_ZONE /etc/localtime && echo $TIME_ZONE > /etc/timezone

COPY --from=build /usr/src/app/dist /usr/src/app/dist
COPY --from=build /usr/src/app/node_modules /usr/src/app/node_modules

USER node

ENTRYPOINT ["node", "/usr/src/app/dist/main"]
