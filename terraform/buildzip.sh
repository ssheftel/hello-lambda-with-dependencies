#!/bin/bash

cd "$(dirname "$0")/.."

NAME=$1
VERSION=0.1.0

rm -rf target/content
mkdir -p target/content

cp requirements.txt target/content
docker run --volume $PWD/target/content:/venv --workdir /venv python:3.6 pip install --quiet -t /venv -r requirements.txt
cp -r src/* target/content

docker run --volume $PWD/target/content:/venv --workdir /venv python:3.6 python -m compileall -q -f .

find target/content -type d | xargs  chmod ugo+rx
find target/content -type f | xargs  chmod ugo+r


pushd target/content
zip --quiet -9r ../../target/$NAME-$VERSION.zip  *
popd

chmod ugo+r target/$NAME-$VERSION.zip

mkdir -p terraform/.terraform/archive_files

cp target/$NAME-$VERSION.zip terraform/.terraform/archive_files/
chmod ugo+r terraform/.terraform/archive_files/$NAME-$VERSION.zip