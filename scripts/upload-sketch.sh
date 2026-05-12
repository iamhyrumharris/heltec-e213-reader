#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

CLI="$ROOT_DIR/.tools/bin/arduino-cli"
CONFIG="$ROOT_DIR/.arduino-cli/arduino-cli.yaml"
SKETCH="$ROOT_DIR/VisionMasterE213_Work/HeltecVisionMasterE213_Pala_One_2_0"
BUILD_PATH="$ROOT_DIR/.arduino-cli/build/vision-master-e213"
FQBN="Heltec-esp32:esp32:heltec_vision_master_e_213"
PORT="${1:-${PORT:-/dev/cu.usbmodem1101}}"

if [[ ! -x "$CLI" ]]; then
  echo "Missing Arduino CLI at $CLI" >&2
  echo "Run the workspace Arduino CLI setup before uploading." >&2
  exit 1
fi

"$SCRIPT_DIR/test-sketch.sh"

exec "$CLI" --config-file "$CONFIG" upload \
  --fqbn "$FQBN" \
  --port "$PORT" \
  --build-path "$BUILD_PATH" \
  --board-options EraseFlash=all \
  "$SKETCH"
