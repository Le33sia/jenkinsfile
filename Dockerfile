FROM golang:1.20 AS build-stage
WORKDIR /app
COPY . .
RUN go get
COPY *.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -o gogs
FROM debian:bullseye-slim
RUN apt-get update && apt-get install -y git
WORKDIR /app
COPY --from=build-stage /app/gogs /gogs                           
EXPOSE 22 3000
ENTRYPOINT ["/gogs", "web"]
