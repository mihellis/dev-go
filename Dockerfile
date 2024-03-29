# docker build --target bin --output bin/ --platform local .

FROM --platform=${BUILDPLATFORM} golang:1.14.3-alpine AS build
WORKDIR /src
ENV CGO_ENABLED=0
COPY go.* .
RUN go mod download
COPY . .
ARG TARGETOS
ARG TARGETARCH
RUN GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -o /out/example .

FROM scratch AS bin
COPY --from=build /out/example /example.exe