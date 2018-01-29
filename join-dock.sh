#!/bin/bash -x
docker exec -i  -u $(id -u):$(id -g) -t jupyter_session /bin/bash
