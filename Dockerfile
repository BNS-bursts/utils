FROM ligo/builder:jessie
#texlive-latex-extra dvipng
RUN apt-get update && apt-get install -y lscsoft-all dvipng \
	&& python -m pip install --upgrade setuptools pip \
	&& python -m pip install jupyter sklearn \
	&& python -m pip install git+https://github.com/ligo-cbc/pycbc@v1.9.0#egg=pycbc \
	&& python -m pip install -U matplotlib \
    && python -m pip install -U scikit-image

RUN mkdir -p -m 777 /jupyter
ENV HOME /jupyter
ENV PYTHONPATH /utils

CMD jupyter-notebook --ip="*" --no-browser --allow-root


