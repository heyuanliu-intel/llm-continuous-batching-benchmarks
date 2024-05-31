#!/bin/bash
OS="ubuntu22.04"

IMAGE_NAME="tgi_gaudi"

# Pull
#docker pull ${IMAGE_NAME}

# Run
CONTAINER_NAME=tgi_image_name
PRIVILEGED_USER="--user root --privileged=true"

EXTRA_CAPS="--cap-add SYS_PTRACE"
#EXTRA_CAPS="--cap-add SYS_ADMIN --cap-add SYS_PTRACE"

#EXTRA_VOLUMES=
EXTRA_VOLUMES="-v /mnt/:/mnt -v /root/:/workspace -v /sys/kernel/debug:/sys/kernel/debug -v /dev:/dev -v /tmp:/tmp"

#PROXY_SETTING=
PROXY_SETTING="-e http_proxy=${http_proxy} -e https_proxy=${https_proxy}"
DEVICE_SETTING="--device=/dev:/dev"

LOG_SETTINGS=
#LOG_SETTINGS="-e LOG_LEVEL_ALL=6"

#ULIMIT_SETTINGS=
ULIMIT_SETTINGS="--ulimit memlock=-1:-1"

HABANA_RUNTIME=
#HABANA_RUNTIME="--runtime=habana"

## PyTorch
docker run ${HABANA_RUNTIME} --name=${CONTAINER_NAME} ${PRIVILEGED_USER} -it -e HABANA_VISIBLE_DEVICES=all -e OMPI_MCA_btl_vader_single_copy_mechanism=none --cap-add=sys_nice ${EXTRA_CAPS} --ipc=host --net=host ${EXTRA_VOLUMES} ${DEVICE_SETTING} ${PROXY_SETTING} ${LOG_SETTINGS} ${ULIMIT_SETTINGS} ${IMAGE_NAME} /bin/bash

## if you want to run tgi profile
docker run ${HABANA_RUNTIME} \
--name=${CONTAINER_NAME} ${PRIVILEGED_USER} -it \
-e HABANA_VISIBLE_DEVICES=all \
-e OMPI_MCA_btl_vader_single_copy_mechanism=none \
-e PROF_WAITSTEP=2 \
-e PROF_WARMUPSTEP=2 \
-e PROF_PATH=/nfs/chaofanl/tgi/hpu_profile \
-e PROF_STEP=2 \
-e PROF_RANKS=0 \
-e PROF_RECORD_SHAPES=FAlse \
--cap-add=sys_nice ${EXTRA_CAPS} \
--ipc=host --net=host ${EXTRA_VOLUMES} ${DEVICE_SETTING} ${PROXY_SETTING} ${LOG_SETTINGS} ${ULIMIT_SETTINGS} ${IMAGE_NAME} /bin/bash