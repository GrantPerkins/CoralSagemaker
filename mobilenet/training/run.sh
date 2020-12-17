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
cp ../dataset/mount/eval.record ./mount/eval.record
cp ../dataset/mount/train.record ./mount/train.record
cp ../dataset/mount/map.pbtxt ./mount/map.pbtxt

docker rm train
docker run --name train \
       --mount type=bind,src=${DIR},dst=/opt/ml/model \
       gcperkins/wpilib-ml-train:small
# --entrypoint "/bin/bash" -it