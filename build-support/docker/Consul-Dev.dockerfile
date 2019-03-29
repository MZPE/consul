ARG CONSUL_BUILD_IMAGE
FROM ${CONSUL_BUILD_IMAGE}:latest as builder
# FROM golang:latest as builder
ARG GIT_COMMIT
ARG GIT_DIRTY
ARG GIT_DESCRIBE
# WORKDIR /go/src/github.com/hashicorp/consul
ENV CONSUL_DEV=1
ENV COLORIZE=0

# cache modules separately
COPY go.mod .
COPY go.sum .
RUN mkdir -p api sdk
COPY api/go.mod api
COPY api/go.sum api
COPY sdk/go.mod sdk
COPY sdk/go.sum sdk
RUN go mod download

# add the rest of the code
ADD . /consul/
RUN make dev


FROM consul:latest

COPY --from=builder /go/bin/consul /bin
