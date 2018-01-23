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

## Development notes
Some notes regarding the BayesWave gitlab & containerization

```
James:

I've made some changes that slow down the conversion but make it more reliable at the scale of your image size. It is available at:

/cvmfs/ligo-containers.opensciencegrid.org/james-clark/bayeswave:o2_online

With the caveat that I'm actively poking at things, this will be updated every time you run GitLab CI and update the image on containers.ligo.org. Give it
maybe an hour or 2 at most and you'll see it in a CVMFS client.

All that said, here are a few comments:

https://git.ligo.org/james-clark/bayeswave/blob/O2_online-branch/.gitlab-ci.yml

1. You are running "docker login" twice for every job because it's present in "before_script" which is run prior to every instance of "script".
2. If you're intending the image to only be built on branch X, you should have an entry for each job like:

  only:
    - X

See https://docs.gitlab.com/ce/ci/yaml/README.html#only-and-except-simplified

3. You don't need to clone the repo within your Dockerfile. Your Dockerfile "build context" is the repo itself! What you want is a file named ".dockerignore"
that has a single entry of ".git".

You can configure CI to only clone the most recent commit with a "variables" entry in the CI.

https://docs.gitlab.com/ce/ci/yaml/README.html#shallow-cloning

4. You should target not building "FROM ligo/software". The intent of that is to simulate running tests as though it were on a cluster (or just running code
with the production packages on the OSG). Once you're building your own code, you should do something a bit more custom and reduce the image size.

It looks to me like your only real dependency is lalsuite (and its dependencies). So you could easily build from something like

containers.ligo.org/lscsoft/lalsuite:nightly

But I see a couple problems with reaching that target (why I'm CC'ing Adam)

A. You need an docker lalsuite image tagged for O2.
B. `pkg-config --libs lal` returns a path with /builds in it. This is an artifiact of how we are building lalsuite in GitLab CI. It might be fixable.

Another route that we should consider is something like multi-stage builds:

https://docs.docker.com/engine/userguide/eng-image/multistage-build/#use-multi-stage-builds

which will reduce some of the clutter. Might even consider static compilation?

Anyhow, you're up and going but I'd like to see smaller images as a real target for the coming months.
```
