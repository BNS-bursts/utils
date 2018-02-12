#!/bin/bash -x
docker run \
    -it -u $(id -u):$(id -g) \
    --rm --name jupyter_session \
    -v /home/jclark/tmp:/work \
    -v /home/jclark/Projects/lvcnr-matter:/lvcnr-matter \
    -v /home/jclark/Dropbox/repositories:/repos \
    -v /home/jclark/Dropbox/repositories/BNS-bursts/utils:/utils \
    -v /etc/group:/etc/group:ro -v /etc/passwd:/etc/passwd:ro \
    -w /utils -p 8888:8888 jclarkastro/tfmaps
