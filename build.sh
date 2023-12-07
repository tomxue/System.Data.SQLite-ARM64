#!/usr/bin/env bash

set -o errexit
set -o nounset
[[ ${DEBUG-} =~ ^1|yes|true$ ]] && set -o xtrace

readonly SCRIPT_PATH="$(readlink --canonicalize "${0}")"
readonly SCRIPT_NAME="$(basename "${SCRIPT_PATH}")"
readonly SCRIPT_DIRECTORY_PATH="$(dirname "${SCRIPT_PATH}")"

readonly DOCKER_OUTPUT_PATH="${SCRIPT_DIRECTORY_PATH}/docker-out"
readonly TARGET_OUTPUT_PATH="my-other-project-using-these-artifacts/sqlite-artifacts"

cd "$SCRIPT_DIRECTORY_PATH" \
	|| { echo "'$SCRIPT_NAME' could not change to directory '$SCRIPT_DIRECTORY_PATH'"; exit 1; }

docker \
	build \
	--progress=plain \
	--no-cache=false \
	--output type=local,dest="$DOCKER_OUTPUT_PATH" \
	. \
&& cp \
	--verbose \
	"${DOCKER_OUTPUT_PATH}/output/"* \
	"$TARGET_OUTPUT_PATH"/

md5sum "$TARGET_OUTPUT_PATH"/*
md5sum "$DOCKER_OUTPUT_PATH"/output/*
file "$DOCKER_OUTPUT_PATH"/output/*