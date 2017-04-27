//
// 50 Hz Generator for AC-less PAL-C64.
//
// Needed:      Fuse CKSEL = 0b00 (external clock)!
// Needed:      Fuse CKDIV8 = 0b0 (enabled)!
// Recommended: Fuse BODLEVEL = 0xb00 (4,3 V)
// Recommended: Fuse SUT = 0xb00 (BOD enabled)
// Recommended: Fuse RSTDISBL = 0xb0 (external reset enabled)
// Recommended: Fuse WDTON = 0xb1 (watchdog always enabled)
//
// Pin 1 /RESET
// Pin 2 CLKI <- o2 (input) = 985248,6 Hz
// Pin 3 NC
// Pin 4 GND
// Pin 5 OC0A -> TOD-CLK (ouput) ~= 50 Hz
// Pin 6 NC
// Pin 7 NC
// Pin 8 5V
//
// Timer 0 TOP = 154:
// 985248,6 Hz / 8 (CKDIV8) / 8 (prescaler) / 154 = 99,96 Hz ~= 100 Hz
// Doubled target frequency due to toggle mode.

.include "tn13def.inc"

.cseg

start:         cli                              ; No interrupts needed
               wdr                              ; make sure, that watch dog does not trigger

               ldi  R16, 0b00000001             ; OC0A as output
			   out  DDRB, R16
               ldi  R16, 0b00111110             ; 50 Hz = 0, pullups active for unused bits 
			   out  PORTB, R16

               ldi  R16, 154                    ; TOP = 154 -> ~100 Hz
			   out  OCR0A, R16
               ldi  R16, 0b01000011             ; WGM = 0b111 (see below), toggle OC0A, OC0B disabled
               out  TCCR0A, R16
               ldi  R16, 0b1010                 ; Prescaler for timer 0 = /8
               out  TCCR0B, R16
               ldi  R16, 0                      ; reset timer 0
			   out  TCNT0, R16

loop:          wdr                               ; make sure, that watch dog does not trigger
               rjmp loop                         ; endless loop
