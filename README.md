# kytos-docker

[Kytos SDN Platform](https://kytos.io) in a docker container with the main Napps used by [AmLight/AMPATH](https://www.amlight.net).

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
