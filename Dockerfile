FROM alpine:3.12.0 as builder

RUN apk add build-base

COPY . /workdir

RUN cd /workdir && ./configure && make

FROM alpine:3.12.0

COPY --from=builder /workdir/adjtimex /usr/bin/
