FROM debian:buster-slim
MAINTAINER Italo Valcy <italovalcy@gmail.com>

RUN apt-get update && apt-get install -y --no-install-recommends \
	python3-setuptools python3-pip rsyslog iproute2 procps curl jq git-core patch \
        openvswitch-switch mininet iputils-ping vim tmux less \
        python-pytest python-requests python-mock python-pytest-timeout \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

RUN sed -i '/imklog/ s/^/#/' /etc/rsyslog.conf

RUN git config --global url."https://github.com".insteadOf git://github.com

RUN python3 -m pip install setuptools==60.2.0
RUN python3 -m pip install pip==21.3.1
RUN python3 -m pip install wheel==0.37.1
RUN python3 -m pip install https://github.com/kytos-ng/python-openflow/archive/master.zip
RUN python3 -m pip install https://github.com/kytos-ng/kytos-utils/archive/master.zip
RUN python3 -m pip install https://github.com/kytos-ng/kytos/archive/master.zip

RUN python3 -m pip install -e git+https://github.com/kytos-ng/storehouse@fix/install_req_deps#egg=kytos-storehouse
RUN python3 -m pip install -e git+https://github.com/kytos-ng/of_core#egg=kytos-of_core
RUN python3 -m pip install -e git+https://github.com/kytos-ng/flow_manager#egg=kytos-flow_manager
RUN python3 -m pip install -e git+https://github.com/kytos-ng/topology#egg=kytos-topology
RUN python3 -m pip install -e git+https://github.com/kytos-ng/of_lldp#egg=kytos-of_lldp
RUN python3 -m pip install -e git+https://github.com/kytos-ng/pathfinder@fix/install_req_deps#egg=kytos-pathfinder
RUN python3 -m pip install -e git+https://github.com/kytos-ng/mef_eline@fix/install_req_deps#egg=kytos-mef_eline
RUN python3 -m pip install -e git+https://github.com/kytos-ng/maintenance#egg=kytos-maintenance
RUN python3 -m pip install -e git+https://github.com/amlight/coloring@fix/install_req_deps#egg=amlight-coloring
RUN python3 -m pip install -e git+https://github.com/amlight/sdntrace@fix/install_req_deps#egg=amlight-sdntrace

# disable sdntrace and coloring by default, you can enable them again by running:
# 	kytos napps enable amlight/coloring
#	kytos napps enable amlight/sdntrace
RUN unlink /var/lib/kytos/napps/amlight/coloring
RUN unlink /var/lib/kytos/napps/amlight/sdntrace

COPY ./apply-patches.sh  /tmp/
COPY ./patches /tmp/patches

RUN cd /tmp && ./apply-patches.sh && rm -rf /tmp/*

WORKDIR /
COPY docker-entrypoint.sh /docker-entrypoint.sh

EXPOSE 6653
EXPOSE 8181

ENTRYPOINT ["/docker-entrypoint.sh"]
