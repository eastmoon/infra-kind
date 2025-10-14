## Declare alias
## Execute script
#
echo "----- Kind create cluster. -----"
kind create cluster --config /usr/local/configs/kube/work/kind-cluster-config.yaml
#
echo "----- Show all cluster. -----"
kind get clusters
#
echo "----- Show nodes in cluster. -----"
KIND_NODE_NAME=$(kind get nodes --name $(kind get clusters | head -n 1))
echo ${KIND_NODE_NAME}
#
echo "----- Link network to nodes. -----"
CONTAINER_HOSTNAME=$(cat /etc/hostname)
CONTAINER_NAME=$(isa infra ps | grep ${CONTAINER_HOSTNAME} | awk '{print $1}')
NETWORK_NAME=$(docker inspect -f '{{range $net,$v := .NetworkSettings.Networks}}{{printf "%s" $net}}{{end}}' ${CONTAINER_NAME})
docker network connect ${NETWORK_NAME} ${KIND_NODE_NAME}
#
echo "----- Modify kubectl configuration -----"
sed -i "s/127.0.0.1/${KIND_NODE_NAME}/g" ~/.kube/config
#
echo "----- Show kubectl cluster information"
kubectl cluster-info
