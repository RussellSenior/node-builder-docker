Update 2018/01:

Made some updates here while getting back up to speed with node builds, so this
should once again work with current versions of things for now. Further
development will continue here:

https://github.com/keeganquinn/ptpwrt-builder

 - KeeganQuinn


Original documentation:

# ptp's openwrt build environment, dockerized

with Russell's help I've managed to cobble together a working build setup
his instructions can be found at https://personaltelco.net/wiki/FooCabFirmwareHowTo

 0. clone this repo locally
 1. first install docker `curl https://get.docker.com/ | sh`
 2. add the node information to the api using the datamanager https://personaltelco.net/datamanager
 3. then run `./run/run_docker.sh` and follow the instructions printed in the `usage`

That will result in 20 minute long build process.  If everything goes as it should, you'll be presented with a set of build images available at `run/volumes/bin`


Benjamin Foote   
bfoote@bnf.net   
December 2014
