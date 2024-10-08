# Repast4py Container
This project aims to create a vesioned docker container that can run Repast4py in a HPC environment. This would required:

  - A dockerfile showing build instructions
  - A docker image hosted in an online repository
  - The image must allow conversion to a Singularity container
  - The image must contain all the required libraries to allow agent basd modelling

The production environment is a combination of user computers (for testing) and a Slurm based HPC cluster for full runs.

### Build
The docker image is build process is defined in the ./github/workflows/docker-build.yml file. This builds and publishes a docker image whenever a new commit is made to main with a tag:

```
git pull
<some code is changed and a new release needs to be created>
git commit -am "some commit message"
git tag <some tag>
git push tag <some tag>
```
### Testing on Your Local Machine
Running code inside the Docker image would require mounting the folder into the container. This can either be done by writing another Docker file that inherits from this one or to mount the code in as a Docker Volume, either using docker commands or the more readable Docker Compose format.

```
git clone git@github.com:GMU-GeoSciences/repast4py-container.git
cd repast4py-container.git
<edit the mount path in the docker compose file to point to your code>
docker compose build
docker compose up
```

### Deploy on HPC Cluster

GMU's HPC Cluster (Hopper) expects a Singularity file instead of a Docker image. They can be [converted fairly easily](https://wiki.orc.gmu.edu/mkdocs/Containerized_jobs_on_Hopper/#building-your-own-containers). 

```
# On Hopper
cd /containers/hopper/UserContainers/$USER
module load singularity
singularity build repast4py_latest.sif docker:ghcr.io/gmu-geosciences/repast4py-container:latest
# This takes some time...
cd /$HOME/path/to/script
salloc -p normal -q normal -n 1 --ntasks-per-node=24 --mem=50GB
singularity run --nv /containers/hopper/UserContainers/$USER/repast4py_latest.sif mpirun -n 4 python rndwalk.py random_walk.yaml
```

Running custom code using the Repast4py Singularity container is also easy. By default there are certain paths that are mounted into the container on run. 

```
# On Hopper

```
