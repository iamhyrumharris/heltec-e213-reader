# Heltec E213 Reader

Community firmware for a small ESP32-S3 e-ink reader based on the Heltec Vision Master E213 / HT-VME213.

This repo started as a modified Pala One reader build for the Heltec E213 V1.1 board. It includes firmware changes for the board variant, battery reporting, expanded flash storage, EPUB-to-text upload from the device web page, custom sleep wallpapers, and a simple table of contents flow.

## Current Target Hardware

- Board: Heltec Vision Master E213 / HT-VME213
- MCU: ESP32-S3R8
- Flash: 16 MB
- PSRAM: 8 MB
- Display: 2.13 inch 250 x 122 black/white e-ink
- Main user button: GPIO21
- Battery ADC: GPIO7 with GPIO46 ADC control

## Repository Layout

- `VisionMasterE213_Work/` - active firmware and setup notes.
- `VisionMasterE213_Work/HeltecVisionMasterE213_Pala_One_2_0/` - Arduino sketch to compile/upload.
- `scripts/test-sketch.sh` - local Arduino CLI compile check.
- `scripts/upload-sketch.sh` - local Arduino CLI upload helper.

## Firmware Highlights

- Custom 16 MB flash partition layout with a large LittleFS book storage partition.
- Web upload mode from the device access point.
- Plain `.txt` upload support.
- Browser-side EPUB conversion for normal DRM-free EPUB files.
- Custom sleep wallpaper upload from the settings page.
- Battery voltage and percent display.
- Optional wake behavior: return to last page or open the home/library screen.
- On-device contents view generated from EPUB chapter markers.

## Build Quickly

The easiest path is Arduino IDE. See [VisionMasterE213_Work/README.md](VisionMasterE213_Work/README.md) for detailed board/package/library setup.

If the local Arduino CLI tooling is installed, compile with:

```sh
scripts/test-sketch.sh
```

Upload with:

```sh
scripts/upload-sketch.sh /dev/cu.usbmodem1101
```

Adjust the serial port as needed.

## Notes for Contributors

- Keep generated Arduino cores, libraries, build caches, local tool installs, CAD files, and case files out of git.
- Do not commit books, private EPUBs, credentials, or local device caches.
- The firmware currently stores books internally as normalized UTF-8 text, even when uploaded from EPUB.
- EPUB conversion is intentionally browser-side to keep the ESP32 firmware simpler.

## Adding Another Board

Board ports are welcome. For now, keep each new board in its own sketch folder so one board does not break another board's upload flow.

Recommended layout:

```text
boards/
  your-board-name/
    YourBoardReader.ino
    partitions.csv
    README.md
```

If you add a board port, include a short `README.md` with:

- Exact board name and revision.
- MCU, flash size, and PSRAM details.
- Display model/driver and resolution.
- Button pins and wake pin.
- Battery ADC/control pins, if supported.
- Required Arduino board package and libraries.
- Upload settings and partition assumptions.
- Any known limitations.

Please keep the current Heltec E213 build working. Shared code can be refactored into common headers later, after there are a few working board ports and the duplicated pieces are clear.

## Licensing

This firmware is licensed under the [Apache License 2.0](LICENSE).
