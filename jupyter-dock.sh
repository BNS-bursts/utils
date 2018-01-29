#!/bin/bash -x
docker run \
    -it -u $(id -u):$(id -g) \
    --rm --name jupyter_session \
    -v /home/jclark/Projects:/work \
    -v /home/jclark/Projects/BNS-bursts/utils:/utils \
    -w /work -p 8888:8888 pmns-dev
