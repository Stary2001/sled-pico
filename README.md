A wrapper project for [sled](https://github.com/shinyblink/sled) on the Raspberry Pi Pico.  
Contains CMake crimes.  
Currently, `git clone https://github.com/Stary2001/sled.git` in the root directory of the repo, copy `sled/Makefiles/sledconf.pico` to `sled/sledconf`, then build. Changes inside sled might need you to manually clean, as dependencies aren't set up properly.  
Works for me, ymmv.  

ws2812b and st7789 outputs are supported. ws2812b is hardcoded to output on GP3, and st7789 is hardcoded as in the example code:
```
#define PIN_DIN 0
#define PIN_CLK 1
#define PIN_CS 2
#define PIN_DC 3
#define PIN_RESET 4
#define PIN_BL 5
```
Depending on your display, you may need to adjust the clock polarity (swap `side 1` and `side 0` inside st7789_lcd.pio). This should probably be made configurable later.
