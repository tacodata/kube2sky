FROM google/debian:wheezy

RUN apt-get update
RUN apt-get -yy -q install iptables ca-certificates
COPY ./buildoutput/kube2sky /kube2sky
COPY ./buildoutput/kube2sky.go /kube2sky.go
RUN chmod a+rx /kube2sky

ENTRYPOINT ["/kube2sky"]
