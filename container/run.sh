DIR=${PWD}
echo ${DIR}
docker run --name wpi \
       --rm -it --privileged -p 6006:6006 \
       --mount type=bind,src=${DIR},dst=/opt/ml/model \
       wpi-cpu-local
