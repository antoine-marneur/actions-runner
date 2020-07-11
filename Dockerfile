FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
	jq \
	curl \
	docker \
	docker-compose \
	ansible

RUN mkdir actions-runner

WORKDIR /actions-runner

RUN curl -O -L https://github.com/actions/runner/releases/download/v2.263.0/actions-runner-linux-x64-2.263.0.tar.gz

RUN tar xzf ./actions-runner-linux-x64-2.263.0.tar.gz

CMD GITHUB_ACTIONS_TOKEN=$(curl -X POST -H "Authorization: token ${GITHUB_TOKEN}" "https://api.github.com/repos/${GITHUB_REPO}/actions/runners/registration-token" | jq -r '.| .token') && ./config.sh --unattended --url "https://github.com/${GITHUB_REPO}" --token "${GITHUB_ACTIONS_TOKEN}" && ./run.sh
