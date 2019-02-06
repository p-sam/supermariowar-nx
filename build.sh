#!/bin/bash

set -eo pipefail

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "$ROOT_DIR/_env.sh"

if [[ -z "$DEVKITPRO" ]]; then
	echo "env var DEVKITPRO is missing" 1>&2
	exit 1
fi
export SDL2DIR="$DEVKITPRO/portlibs/switch"

mkdir -p "$ROOT_DIR/build"
mkdir -p "$ROOT_DIR/out"

cd "$ROOT_DIR/build"
cmake "$ROOT_DIR" -DCMAKE_TOOLCHAIN_FILE="$ROOT_DIR/Toolchain.cmake"
make enetshim $MAKE_OPTS
make smw $MAKE_OPTS

"$DEVKITPRO/tools/bin/nacptool" --create "$APP_TITLE" "$APP_AUTHOR" "$APP_VERSION" "$ROOT_DIR/build/smw.nacp"
"$DEVKITPRO/tools/bin/elf2nro" "$ROOT_DIR/build/Binaries/Release/smw" "$ROOT_DIR/out/smw.nro" \
	--nacp="$ROOT_DIR/build/smw.nacp" \
	--icon="$ROOT_DIR/icon.jpg"

unzip -o -q "$ROOT_DIR/supermariowar/data.zip" -d "$ROOT_DIR/out"