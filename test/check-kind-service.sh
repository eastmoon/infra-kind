## Declare alias
## Execute script
echo "----- Show nodes in cluster. -----"
KIND_NODE_NAME=$(kind get nodes --name $(kind get clusters | head -n 1))
echo ${KIND_NODE_NAME}
echo "----- Show nginx page in target node. -----"
curl http://${KIND_NODE_NAME}:30080
