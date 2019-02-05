#!/bin/bash

set -eo pipefail

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [[ -z "$DEVKITPRO" ]]; then
	echo "env var DEVKITPRO is missing" 1>&2
	exit 1
fi

cd "$ROOT_DIR"
git submodule update --init --force --recursive
git submodule foreach --recursive 'git reset --hard; git clean -d -x -f'

cd "$ROOT_DIR/supermariowar"
git apply "$ROOT_DIR/patches/cmakelist-submodule-root.patch"
git apply "$ROOT_DIR/patches/smw-switch-input.patch"
git apply "$ROOT_DIR/patches/smw-switch-res.patch"

mkdir -p "$ROOT_DIR/build"

cd "$ROOT_DIR/build"
cmake "$ROOT_DIR" -DCMAKE_TOOLCHAIN_FILE="$ROOT_DIR/Toolchain.cmake"
make smw $MAKE_OPTS

source "$ROOT_DIR/_env.sh"

"$DEVKITPRO/tools/bin/nacptool" --create "$APP_TITLE" "$APP_AUTHOR" "$APP_VERSION" "$ROOT_DIR/build/smw.nacp"
"$DEVKITPRO/tools/bin/elf2nro" "$ROOT_DIR/build/Binaries/Release/smw" "$ROOT_DIR/out/smw.nro" \
	--nacp="$ROOT_DIR/build/smw.nacp" \
	--icon="$ROOT_DIR/icon.jpg"
unzip -o -q "$ROOT_DIR/supermariowar/data.zip" -d "$ROOT_DIR/out"