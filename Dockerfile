FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
	curl \
	docker \
	docker-compose

RUN mkdir actions-runner

WORKDIR /actions-runner

RUN curl -O https://githubassets.azureedge.net/runners/2.162.0/actions-runner-linux-x64-2.162.0.tar.gz

RUN tar xzf ./actions-runner-linux-x64-2.162.0.tar.gz

CMD ./config.sh \
	--url ${GITHUB_ACTIONS_URL} \
	--token ${GITHUB_ACTIONS_TOKEN} \
	--agent $(hostname) \
	--work "_work" \
	&& ./run.sh
