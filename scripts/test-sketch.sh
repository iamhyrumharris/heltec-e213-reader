#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

CLI="$ROOT_DIR/.tools/bin/arduino-cli"
CONFIG="$ROOT_DIR/.arduino-cli/arduino-cli.yaml"
SKETCH="$ROOT_DIR/VisionMasterE213_Work/HeltecVisionMasterE213_Pala_One_2_0"
BUILD_PATH="$ROOT_DIR/.arduino-cli/build/vision-master-e213"
FQBN="Heltec-esp32:esp32:heltec_vision_master_e_213"

if [[ ! -x "$CLI" ]]; then
  echo "Missing Arduino CLI at $CLI" >&2
  echo "Run the workspace Arduino CLI setup before testing." >&2
  exit 1
fi

if [[ ! -f "$CONFIG" ]]; then
  echo "Missing Arduino CLI config at $CONFIG" >&2
  exit 1
fi

exec "$CLI" --config-file "$CONFIG" compile \
  --fqbn "$FQBN" \
  --build-path "$BUILD_PATH" \
  --build-property build.flash_size=16MB \
  --build-property upload.maximum_size=2097152 \
  --warnings all \
  "$SKETCH"
