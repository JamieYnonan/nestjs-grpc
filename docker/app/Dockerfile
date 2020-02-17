FROM node:12.15-alpine AS build

RUN mkdir -p /app && chown node /app
USER node

COPY ./app /app/
WORKDIR /app

RUN npm install --no-cache --only-prod && npm run build

FROM node:12.15-alpine

ARG VERSION
LABEL maintainer="Jamie Ynonan <jamiea31@gmail.com>"
LABEL version=$VERSION

ARG TIME_ZONE
RUN ln -snf /usr/share/zoneinfo/$TIME_ZONE /etc/localtime && echo $TIME_ZONE > /etc/timezone

COPY --from=build /app/dist /app/dist
COPY --from=build /app/node_modules /app/node_modules

USER node
ENTRYPOINT ["node", "/app/dist/main"]
