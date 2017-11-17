FROM golang:alpine

LABEL maintainer="Code Climate <hello@codeclimate.com>"

RUN adduser -u 9000 -D app

WORKDIR /usr/src/app

COPY engine.json /engine.json
COPY codeclimate-govet.go /usr/src/app/
RUN apk add --no-cache git && \
    go get -t -d -v ./... && \
    go build -o codeclimate-govet . && \
    rm -r /go/src/* && \
    apk del --no-cache git

USER app

VOLUME /code

CMD ["/usr/src/app/codeclimate-govet"]
