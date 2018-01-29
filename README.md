# utils
Some utilities for general plotting and post-processing


## Docker Containers

 * To build the docker image: 
    ```python
    cd <directory with dockerfile>
    docker build -t pmns-dev ./
    ```

### Jupyter

To launch a jupyter server where:
 * `/home/jclark/Projects` is mounted to `/work`
 * The process being executed starts in `/work`
 * Port 8888 in the container is mapped to port 8888 on the localhost: required for jupyter-notebooks
 * Run as the current user so that files are created with sensible permissions:
 ```bash
 docker run -it -u $(id -u):$(id -g) --rm --name jupyter_session -v /home/jclark/Projects:/work -w /work -p 8888:8888 pmns-dev
 ```
 * Connect to that container (for e.g., jupyter-console --existing) with:
 ```bash
 docker exec -i  -u $(id -u):$(id -g) -t jupyter_session /bin/bash
 ```

