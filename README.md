# alaveteli-docker

Dockerfile for building Alaveteli

You need:

1. a .env file that the docker image can use which has all the relevant
   `config/general/yml` settings you might expect in an Alaveteli
   installation

Checkout the `.env-sample`, fill in the values, and rename it `.env`

This is designed to be run with a mounted volume for sharing the socket
file with a webserver like nginx.

Run with docker like this:

```
docker --run -v /data/alaveteli:/data/alaveteli \
  --env-file=/path/to/your/environment/file \
  nzherald/alaveteli
```

### How to customise:

`git clone https://github.com/nzherald/alaveteli-docker.git`

`cd alaveteli-docker`

`docker build -t nzherald/alaveteli-docker`
