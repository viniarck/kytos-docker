# kytos-docker

[Kytos-NG SDN Platform](https://github.com/kytos-ng/) in a docker container with the main Napps used by [AmLight/AMPATH](https://www.amlight.net).

**NOTE: Since Kytos project is in a "shutdown" phase, our docker image is based on the fork of the project - Kytos-NG (https://github.com/kytos-ng). The naming convention inside the docker image remains the same, but eventually they will be changed to kytos-ng in the future.**

## Usage

After pull or build the image, you can run:

	docker run -d --name kytos -p 8181:8181 -p 6653:6653 amlight/kytos:latest

You can also run the kytos daemon as the main container process (the default is to run a `tail -f /dev/null` as the main process and kytos runs as an additional process):

	docker run -d --name kytos -p 8181:8181 -p 6653:6653 -it amlight/kytos:latest /usr/local/bin/kytosd -E -f

Help:
```
prompt$ docker run --rm amlight/kytos:latest --help
docker run amlight/kytos [options]
    -h, --help                    display help information
    /path/program ARG1 .. ARGn    execute the specfified local program
    --ARG1 .. --ARGn              execute Kytos with these arguments
```
