# Step : base
FROM golang:bookworm

# Step : Install Python
RUN apt update -y && apt install -y \
    python3 \
    python3-pip \
    python3-venv \
    python-is-python3

# Step : Install docker-cli
RUN apt update -y && apt install -y \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    curl \
    gnupg
RUN curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
RUN chmod a+r /etc/apt/keyrings/docker.asc
RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt update -y && apt install -y \
    docker-ce-cli \
    docker-compose-plugin

# Step : Python FastAPI
## Install FastAPI
RUN apt update -y && apt install -y \
    python3-fastapi \
    python3-uvicorn

# Step : Command line interface
## Install python libraries
RUN apt update -y && apt install -y \
    python3-yaml \
    python3-requests

## Install CLI & API
ADD ./cli /usr/local/isa/cli
ADD ./api /usr/local/isa/api
RUN cat <<EOF > /bin/isa
CLI_FILE=\${BASH_SOURCE##*/}
export PYTHON_CLI_NAME=\${CLI_FILE%.*}
cd /usr/local/isa/cli
python main.py \${@}
EOF
RUN chmod +x /bin/isa

# Step : Install Kubernetes in Docker
RUN go install sigs.k8s.io/kind@v0.30.0
## Install kubectl
RUN curl -L -s https://dl.k8s.io/release/stable.txt > stable.txt
RUN curl -LO "https://dl.k8s.io/release/$(cat stable.txt)/bin/linux/amd64/kubectl"
RUN curl -LO "https://dl.k8s.io/release/$(cat stable.txt)/bin/linux/amd64/kubectl.sha256"
RUN echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
RUN install -o root -g root -m 0755 kubectl /bin/kubectl
RUN rm stable.txt kubectl.sha256 kubectl

# Step : Install contents and setting container environment
## Copy contents
ADD ./modules /usr/local/modules
ADD ./configs /usr/local/configs
ADD ./docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +rx /docker-entrypoint.sh

## Setting container startup
WORKDIR /usr/local/configs
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["apiserver"]
