FROM debian:bullseye-slim

RUN addgroup --gid 1029 bs-pangolin && adduser --ingroup bs-pangolin --uid 514896 bs-pangolin

WORKDIR /root

RUN mkdir /home/bs-pangolin/.ssh
RUN chown -R bs-pangolin:bs-pangolin /home/bs-pangolin/.ssh

RUN apt-get update && apt-get install -y vim wget lftp rsync gawk ssh git gpg expect

USER bs-pangolin
WORKDIR /app/
RUN mkdir -p setup
COPY ./setup /app/setup
RUN /app/setup/setup.sh

USER root
COPY --chown=bs-pangolin:bs-pangolin . /app/fgcz_sync

USER bs-pangolin

WORKDIR /app/fgcz_sync



ENTRYPOINT ["/app/fgcz_sync/entrypoint.sh"]
