# alaveteli-docker

Dockerfile for building Alaveteli

This dockerfile submodules the Alaveteli git repo at tagged release
commits.

How to use:

`git clone https://github.com/nzherald/alaveteli-docker.git`

`cd alaveteli-docker`

`git submodule init`

`git submodule update`

`docker build -t nzherald/alaveteli-docker`
