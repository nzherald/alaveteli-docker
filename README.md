# alaveteli-docker

Dockerfile for building Alaveteli

You need:

1. a .env file that the docker image can use which has all the relevant
   `config/general/yml` settings you might expect in an Alaveteli
   installation

Checkout the `.env-sample`, fill in the values, and rename it `.env`

Current status: *work in progress*

### How to use:

`git clone https://github.com/nzherald/alaveteli-docker.git`

`cd alaveteli-docker`

`docker build -t nzherald/alaveteli-docker`
