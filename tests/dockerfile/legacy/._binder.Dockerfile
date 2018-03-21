FROM andrewosh/binder-base

USER root

# Add Julia dependencies
RUN apt-get update
RUN apt-get install -y julia libnettle4 && apt-get clean

USER main

# Install Julia kernel
RUN julia -e 'Pkg.add("IJulia")'
RUN julia -e 'Pkg.add("Gadfly")' && julia -e 'Pkg.add("RDatasets")'

ADD verify verify


USER root
COPY . /home/main/notebooks
RUN chown -R main:main /home/main/notebooks
USER main
WORKDIR /home/main/notebooks
ENV PATH /home/main/anaconda2/envs/python3/bin:$PATH
RUN conda install -yq -n python3 notebook==5.0.0 ipykernel==4.6.0 && \
    conda remove -yq -n python3 nb_conda_kernels && \
    conda install -yq -n root ipykernel==4.6.0 && \
    /home/main/anaconda2/envs/python3/bin/ipython kernel install --sys-prefix && \
    /home/main/anaconda2/bin/ipython kernel install --prefix=/home/main/anaconda2/envs/python3 && \
    /home/main/anaconda2/bin/ipython kernel install --sys-prefix
ENV JUPYTER_PATH /home/main/anaconda2/share/jupyter:$JUPYTER_PATH
CMD jupyter notebook --ip 0.0.0.0

RUN echo "appendix" > /tmp/appendix
