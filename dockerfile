FROM quay.io/pawsey/hpc-python:3.11-ubuntu23.04
#https://pawseysc.github.io/containers-astro-python-workshop/3.hpc/index.html
#docker pull quay.io/pawsey/mpich-basequay.io/pawsey/mpich-base
#RUN apt-get update && \
#    apt-get install -y  mpich \
#        && rm -rf /var/lib/apt/lists/*

# Install the python requirements
COPY ./requirements.txt ./requirements.txt
RUN pip3 --no-cache-dir install --break-system-packages -r ./requirements.txt

# FROM nvcr.io/nvidia/distroless/python:3.12-v3.4.2
# ==========================================================================================
# NOTE: Repast4py might not work with Python > 3.8, but nvcr doesn't have images that old...
# - Taken from: https://github.com/Repast/repast4py/blob/master/Dockerfile
# - https://catalog.ngc.nvidia.com/orgs/nvidia/teams/distroless/containers/python/tags
# - https://github.com/GoogleContainerTools/distroless/blob/main/examples/python3/Dockerfile
# ==========================================================================================

# Install repast4py
RUN env CC=mpicxx CXX=mpicxx pip3 --no-cache-dir install --break-system-packages repast4py

# Set the PYTHONPATH to include the /repast4py folder which contains the core folder
ENV PYTHONPATH=/repast4py/src
