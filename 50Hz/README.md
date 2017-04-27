# 50 Hz Generator for C64

For using a C64 with DC voltage it needs a 50 Hz generator for the real time clocks.
For a detailed german description see [C64 / Reparator / 50 Hz Umbau](https://markusheiden.de/c64/reparatur.html?start=2).

## Pin layout

ATtiny13 pins:
* Pin 1: /RESET
* Pin 2: o2: 985248,6 Hz (Eingang)
* Pin 3: NC
* Pin 4: GND
* Pin 5: TOD-CLK: 50 Hz (Ausgang)
* Pin 6: NC
* Pin 7: NC
* Pin 8: 5V

## Burning

For burning the [hex file](50Hz.hex) you need to configure the fuses manually:
* CKSEL: 0b00
* CKDIV8: 0b0
* BODLEVEL: 0b00
* SUT: 0b00
* RSTDISBL: 0b0
* WDTON: 0b1

