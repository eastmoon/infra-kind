## Declare alias
isa() {
  bash isa ${@}
}
## Execute script
#
echo "----- Check and list infrastructure environment status. -----"
isa infra
#
echo "----- Show all infrastructure container information. -----"
isa infra ps
#
echo "----- Show all infrastructure container resource usage statistics. -----"
isa infra stats
