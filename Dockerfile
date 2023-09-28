FROM debian:buster-slim

RUN echo 'Acquire::http::Proxy "http://proxy.ethz.ch:3128/";' > /etc/apt/apt.conf.d/proxy.conf
RUN apt-get update && apt-get install -y vim ssh faketime wget dnsutils lftp rsync gawk
RUN mkdir -p /root/pangolin/setup
COPY pangolin_src/setup /root/pangolin/setup
RUN /root/pangolin/setup/setup.sh

COPY pangolin_src /root/pangolin
WORKDIR /root/pangolin

#ENTRYPOINT ["/root/pangolin/entrypoint.sh"]
ENTRYPOINT ["sleep", "10d" ]
