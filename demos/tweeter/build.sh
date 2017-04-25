#!/usr/bin/env bash

while [[ $# > 0 ]]
do
key="$1"
case $key in
    -w|--working-tree)
    USE_WORKING_TREE=1
    ;;
    *)
            # unknown option
    ;;
esac
shift # past argument or value
done

# Exit on error (e.g., "Not a git repository")
set -e
TOP_LEVEL=$(git rev-parse --show-toplevel)
set +e

PWD=$(pwd)

echo "\$PWD => ${PWD}"

RELATIVE_PATH="${PWD#*$TOP_LEVEL/}"

echo "\$RELATIVE_PATH => ${RELATIVE_PATH}"

REPO_NAME='aisrael/tweeter'

CURRENT_BRANCH=$(git symbolic-ref --short HEAD)

if [[ -z "$TMP" ]]; then
  TMP=$(mktemp -d)
else
  mkdir -p "$TMP"
fi

WORK_DIR="$TMP/$RELATIVE_PATH"
echo "WORK_DIR => ${WORK_DIR}"

if [ -z ${USE_WORKING_TREE+x} ]; then
  echo git checkout-index --prefix="$TMP/" -a
  git checkout-index --prefix="$TMP/" -a
else
  mkdir -p "$WORK_DIR"
  echo rsync -a . "$WORK_DIR" --exclude .git --exclude node_modules --exclude tmp
  rsync -a . "$WORK_DIR" --exclude .git --exclude node_modules --exclude tmp
fi

echo git submodule foreach --quiet 'git checkout-index --prefix="'$TMP'/$path/" -a'
git submodule foreach --quiet 'git checkout-index --prefix="'$TMP'/$path/" -a'

if ! [ -z ${USE_WORKING_TREE+x} ]; then
  echo rm -rf "$TMP/.git"
  rm -rf "$TMP/.git"
fi

if [ -z ${USE_WORKING_TREE+x} ] && [ ! "$CURRENT_BRANCH" = "develop" -a ! "$CURRENT_BRANCH" = "master" ]; then
  IMAGE_TAG=$(basename "$CURRENT_BRANCH")

  echo docker build -t "$REPO_NAME:$IMAGE_TAG" "$WORK_DIR"
  docker build -t "$REPO_NAME:$IMAGE_TAG" "$WORK_DIR"
else
  if [ "$CURRENT_BRANCH" = "develop" ]; then
    IMAGE_TAG=$(git rev-parse HEAD)

    echo docker build -t "$REPO_NAME:latest"-t "$REPO_NAME:$IMAGE_TAG" "$WORK_DIR"
    docker build -t "$REPO_NAME:latest" -t "$REPO_NAME:$IMAGE_TAG" "$WORK_DIR"
  else
    echo docker build -t "$REPO_NAME" "$WORK_DIR"
    docker build -t "$REPO_NAME" "$WORK_DIR"
  fi
fi
