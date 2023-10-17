docker run -it -v /data:/data -v /mnt/cluster/:/mnt/cluster -v $(pwd)/ssh:/root/.ssh test faketime '4 weeks ago' ${1:-./carillon.sh}
