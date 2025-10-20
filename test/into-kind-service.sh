## Declare alias
## Execute script
echo "----- Show nodes in cluster. -----"
KIND_NODE_NAME=$(kind get nodes --name $(kind get clusters | head -n 1))
echo ${KIND_NODE_NAME}
echo "----- Into target node. -----"
docker exec -ti ${KIND_NODE_NAME} bash
