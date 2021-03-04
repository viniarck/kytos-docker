FROM debian:buster-slim
MAINTAINER Italo Valcy <italovalcy@gmail.com>

RUN apt-get update && apt-get install -y --no-install-recommends \
	python3-setuptools python3-pip rsyslog iproute2 procps curl git-core \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

RUN sed -i '/imklog/ s/^/#/' /etc/rsyslog.conf

RUN python3 -m pip install --upgrade pip setuptools wheel
RUN python3 -m pip install https://github.com/kytos/python-openflow/archive/master.zip
RUN python3 -m pip install https://github.com/kytos/kytos-utils/archive/master.zip
RUN python3 -m pip install https://github.com/kytos/kytos/archive/master.zip

RUN python3 -m pip install -e git+https://github.com/kytos/storehouse#egg=kytos-storehouse
RUN python3 -m pip install -e git+https://github.com/kytos/of_core#egg=kytos-of_core
RUN python3 -m pip install -e git+https://github.com/kytos/flow_manager#egg=kytos-flow_manager
RUN python3 -m pip install -e git+https://github.com/kytos/topology#egg=kytos-topology
RUN python3 -m pip install -e git+https://github.com/kytos/of_lldp#egg=kytos-of_lldp
RUN python3 -m pip install -e git+https://github.com/kytos/pathfinder#egg=kytos-pathfinder
RUN python3 -m pip install -e git+https://github.com/kytos/mef_eline#egg=kytos-mef_eline
RUN python3 -m pip install -e git+https://github.com/kytos/maintenance#egg=kytos-maintenance
RUN python3 -m pip install -e git+https://github.com/amlight/coloring#egg=amlight-coloring
RUN python3 -m pip install -e git+https://github.com/amlight/sdntrace#egg=amlight-sdntrace

WORKDIR /
COPY docker-entrypoint.sh /docker-entrypoint.sh

EXPOSE 6653
EXPOSE 8181

ENTRYPOINT ["/docker-entrypoint.sh"]
