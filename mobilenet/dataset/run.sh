DIR=$PWD/mount
while [[ $# -gt 0 ]]; do
  case "$1" in
    --mount)
      DIR=$DIR/$2
      shift 2 ;;
    --*)
      echo "Unknown flag $1"
      exit 1 ;;
  esac
done

mkdir -p $DIR
cp ../../params/hyperparameters.json ./mount/hyperparameters.json
cp ../../full_data.tar ./mount/full_data.tar
cp ../../grant.tar ./mount/grant.tar
docker rm dataset
docker run --name dataset \
       --mount type=bind,src=${DIR},dst=/opt/ml/model \
       gcperkins/wpilib-ml-dataset:small
# --entrypoint "/bin/bash" -it
