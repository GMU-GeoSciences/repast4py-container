FROM nvcr.io/nvidia/distroless/python:3.12-v3.4.2
# ==========================================================================================
# NOTE: Repast4py might not work with Python > 3.8, but nvcr doesn't have images that old...
# - Taken from: https://github.com/Repast/repast4py/blob/master/Dockerfile
# - https://catalog.ngc.nvidia.com/orgs/nvidia/teams/distroless/containers/python/tags
# - https://github.com/GoogleContainerTools/distroless/blob/main/examples/python3/Dockerfile
# ==========================================================================================

RUN apt-get update && \
    apt-get install -y  mpich \
        && rm -rf /var/lib/apt/lists/*

# Install the python requirements
COPY ./requirements.txt ./requirements.txt
RUN pip install -r ./requirements.txt

# Install repast4py
RUN env CC=mpicxx CXX=mpicxx pip install repast4py

# Set the PYTHONPATH to include the /repast4py folder which contains the core folder
ENV PYTHONPATH=/repast4py/src