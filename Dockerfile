#FROM ligo/software
FROM containers.ligo.org/lscsoft/lalsuite:nightly
LABEL name="pmns-dev" \
      maintainer="James Alexander Clark <james.clark@ligo.org>" \
	  url="https://github.com/BNS-bursts/utils"

RUN apt-get remove -y python-numpy python-pyrxp python-bs4
RUN apt-get update && apt-get install -y git dvipng python-pip

RUN python -m pip install --upgrade setuptools pip \
    && python -m pip install --upgrade jupyter matplotlib sklearn scikit-image

#   RUN git clone https://github.com/lscsoft/lalsuite.git \
#       && cd lalsuite \
#       && ./00boot && ./configure --enable-swig-python && make -j install \
#       && cd .. && rm -r lalsuite

RUN python -m pip install git+https://github.com/ligo-cbc/pycbc@v1.9.0#egg=pycbc


# Update environment
ENV PYTHONPATH /utils:${PYTHONPATH}

# Additional jupyter permissions configuration
RUN mkdir -p -m 777 /jupyter
ENV HOME /jupyter

#CMD jupyter-notebook --ip="*" --no-browser --allow-root
ENTRYPOINT ["/bin/bash"]

