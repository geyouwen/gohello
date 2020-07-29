FROM golang:1.13.5-alpine3.10 AS builder

WORKDIR /build
RUN adduser -u 10001 -D app-runner

ENV GOPROXY https://goproxy.cn,direct
ENV GO111MODULE on
COPY go.mod .
COPY go.sum .
RUN go mod download
EXPOSE 8006
COPY . .
RUN CGO_ENABLED=0 GOARCH=amd64 GOOS=linux go build -a -o gohello .

FROM alpine:3.10 as final

WORKDIR /app
COPY --from=builder /build/gohello /app/
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

USER app-runner
ENTRYPOINT ["/app/gohello"]