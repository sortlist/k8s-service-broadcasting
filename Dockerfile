FROM busybox:latest
LABEL maintainer="FUSAKLA Martin Chodúr <m.chodur@seznam.cz>"


COPY k8s-service-broadcasting /bin/k8s-service-broadcasting
COPY Dockerfile /

RUN mkdir -p /k8s-service-broadcasting
WORKDIR /k8s-service-broadcasting

USER 65534

ENTRYPOINT ["/bin/k8s-service-broadcasting"]
CMD ["--help"]
