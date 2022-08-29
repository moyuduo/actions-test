FROM golang:1.17 as builder

WORKDIR /workspace

ENV GO111MODULE=on CGO_ENABLED=0 GOOS=linux GOARCH=amd64 GOPROXY=https://goproxy.cn,direct

COPY . .

RUN go mod download
RUN go build -o app main.go

FROM alpine:3.11

WORKDIR /

COPY --from=builder /workspace/app .

USER 65532:65532

ENTRYPOINT ["/app"]