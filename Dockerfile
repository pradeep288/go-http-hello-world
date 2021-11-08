FROM image-registry.openshift-image-registry.svc:5000/openshift/golang:latest as builder

WORKDIR /build
ADD . /build/


RUN mkdir /tmp/cache
RUN CGO_ENABLED=0 GOCACHE=/tmp/cache go build  -mod=vendor -v -o /tmp/hello-world .

FROM scratch

WORKDIR /app
COPY --from=builder /tmp/hello-world /app/hello-world

EXPOSE 80

CMD [ "/app/hello-world" ]
