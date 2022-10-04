#FROM alpine
FROM ubuntu:18.04
LABEL maintainer="https://github.com/rastasheep"

RUN apt-get update

COPY ./app /app
WORKDIR /app

RUN chmod +x ./web ./web.sh

CMD ./web.sh
