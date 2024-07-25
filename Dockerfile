# syntax=docker/dockerfile:1
FROM golang:1.21-alpine
WORKDIR /src
COPY go.mod go.sum .
RUN go mod download
COPY . .
RUN go build -o /bin/client ./cmd/client
RUN go build -o /bin/server ./cmd/server

FROM scratch
COPY --from=0 /bin/client /bin/server /bin/
ENTRYPOINT [ "/bin/server" ]





