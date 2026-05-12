# Pala One Firmware for Heltec Vision Master E213

This folder is the modified firmware for the board from Amazon ASIN `B0DCBYK7M1`.

The board is a Heltec Vision Master E213 / `HT-VME213`:

- MCU: ESP32-S3R8
- Display: built-in 2.13 inch 250 x 122 black/white e-ink
- User button: GPIO21
- Battery read: GPIO7 with GPIO46 ADC control

## Files

- `HeltecVisionMasterE213_Pala_One_2_0/HeltecVisionMasterE213_Pala_One_2_0.ino` is the firmware to open in Arduino IDE.
- `HeltecVisionMasterE213_Pala_One_2_0/partitions.csv` is copied from the original firmware so the device has room for uploaded books.
- `HeltecVisionMasterE213_Pala_One_2_0/pala_one_sleep_black_icon_v4.h` is the sleep image used by the firmware.

## Install Arduino IDE

1. Install Arduino IDE 2.x from `https://www.arduino.cc/en/software`.
2. Open Arduino IDE.
3. Open `Arduino IDE > Settings`.
4. In `Additional boards manager URLs`, add:

   `https://github.com/Heltec-Aaron-Lee/WiFi_Kit_series/releases/latest/download/package_heltec_esp32_index.json`

5. Open `Tools > Board > Boards Manager`.
6. Search for `Heltec`.
7. Install `Heltec ESP32 Series Dev-boards`.

## Install Libraries

Open `Tools > Manage Libraries`, then install:

- `heltec-eink-modules`
- `Adafruit GFX Library`
- `U8g2`
- `U8g2_for_Adafruit_GFX`

If Arduino reports missing dependencies when you install these, accept the dependency install.

## Open and Upload the Firmware

1. Connect the board to your computer with a USB-C data cable.
2. In Arduino IDE, open:

   `VisionMasterE213_Work/HeltecVisionMasterE213_Pala_One_2_0/HeltecVisionMasterE213_Pala_One_2_0.ino`

3. Select `Tools > Board > Heltec ESP32 Series Dev-boards > Vision Master E213`.
4. Select the board's USB port under `Tools > Port`.
5. If available in `Tools`, set `USB CDC On Boot` to `Enabled`.
6. If you see `Tools > Partition Scheme`, choose `Custom` so Arduino uses the included `partitions.csv`.
7. If you do not see `Tools > Partition Scheme`, skip that step and click `Upload`.

Some Heltec board definitions hide the partition menu. That is okay for the first upload. If the firmware uploads and boots, you can start using it. If the upload fails with an error about sketch size, app partition size, or LittleFS/storage, use the fallback board settings below.

## If `Partition Scheme` Is Missing and Upload Fails

1. Open `Tools > Board > Boards Manager`.
2. Search for `esp32`.
3. Install `esp32 by Espressif Systems`.
4. Select `Tools > Board > esp32 > ESP32S3 Dev Module`.
5. Set these `Tools` options:

   - `Flash Size`: `8MB`
   - `PSRAM`: `OPI PSRAM` or `Enabled`, whichever your menu shows
   - `USB CDC On Boot`: `Enabled`
   - `Partition Scheme`: `Custom`

6. Select the board's USB port under `Tools > Port`.
7. Click `Upload`.

If upload fails because Arduino cannot connect:

1. Hold the board's `BOOT` button.
2. While holding `BOOT`, tap `RST`.
3. Release `BOOT`.
4. Click `Upload` again.
5. After the upload finishes, tap `RST` once.

## Board Controls

Use the `USER` button on the board for the reader controls. Do not use `BOOT` for normal reading.

- Short press: move forward / next item
- Double press: select / previous page in reader
- Long press: opens contents on a library book, or adds a bookmark while reading
- Triple press: return to library

Long press triggers as soon as the hold timer expires; you do not need to release first.

## Upload Books

1. On the device library screen, short-press until `Upload` is selected.
2. Double-press to enter upload mode.
3. On your computer or phone, connect to the Wi-Fi network named `PALA-xxxxxx`.
4. Password: `palaread`
5. Open `http://192.168.4.1` in a browser.
6. Upload `.txt` books from that page, or upload a normal DRM-free `.epub` and let the browser convert it.

EPUB conversion happens in the phone/computer browser. The device stores the converted book as normalized UTF-8 text with chapter markers for the on-device contents screen.

## Custom Sleep Wallpaper

The settings page accepts a raw 1-bit `.bin` sleep image:

- Size: 250 x 122 px
- File size: exactly 3904 bytes
- Format: raw XBM-style bytes, LSB-first, 32 bytes per row

Use a tool such as `image2cpp` and choose plain bytes / horizontal 1 bit per pixel.

## Settings

The web settings page includes:

- Font size
- Auto-sleep timeout
- Line spacing
- Wake to last page vs wake to home/library
- Custom sleep wallpaper upload

## Board Variant Note

The firmware defaults to `EInkDisplay_VisionMasterE213`.

If the back of your board says `E213 V1.1`, open the `.ino` file and change:

```cpp
#define PALA_VISION_MASTER_E213_V1_1 0
```

to:

```cpp
#define PALA_VISION_MASTER_E213_V1_1 1
```

Then upload again.
