FROM debian:buster-slim

RUN addgroup --gid 1029 bs-pangolin && adduser --ingroup bs-pangolin --uid 542576 bs-pangolin

WORKDIR /root

RUN mkdir /home/bs-pangolin/.ssh
RUN chown -R bs-pangolin:bs-pangolin /home/bs-pangolin/.ssh

RUN apt-get update && apt-get install -y vim wget lftp rsync gawk ssh git gpg expect

USER bs-pangolin
WORKDIR /app/
RUN mkdir -p setup
COPY pangolin_src/setup /app/setup
RUN /app/setup/setup.sh

USER root
COPY --chown=bs-pangolin:bs-pangolin pangolin_src /app/pangolin_src
USER bs-pangolin

WORKDIR /app/pangolin_src



ENTRYPOINT ["/app/pangolin_src/entrypoint.sh"]
#ENTRYPOINT [ "sleep", "10d" ]
