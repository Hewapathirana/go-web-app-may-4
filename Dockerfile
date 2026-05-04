FROM golang:1.22.5 as base

WORKDIR /app

COPY go.mod .

RUN go mod download

COPY . .

RUN go build -o main .

# final stage with - Distroless image
#sine below a distroless image this secureed sine no shell,no pkg manager and not run as root
#but this is not good for dev or local best for prod ---> need to learn this why
FROM gcr.io/distroless/base

COPY --from=base /app/main .
COPY --from=base /app/static ./static

EXPOSE 8080

CMD ["./main"]
