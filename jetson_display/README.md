# Jetson Nano Interface for GPIO and 4-Digit 7-Segment Display


## GPIO usage
- To Turn on LED attached to GPIO pin 79
```
sh -x ./gpio.sh 1 
```

To Turn off LED attached to GPIO pin 79
```
sh -x ./gpio.sh 0 
```

## Seven Segment Setup 
- Dependencies 
```
- libi2c-dev 
- i2c-tools
```

- To Change i2c bus  (Default Bus 0)

```
HT16K33 *displayMatrix = new HT16K33() ;

// Add the following line

displayMatrix->kI2CBus = 0; // Use I2C bus 0

int err = displayMatrix->openHT16K33();
```

- To detect over i2c 
```
# Usage: i2cdetect [-y] [-a] [-q|-r] I2CBUS [FIRST LAST]
#       i2cdetect -F I2CBUS
#       i2cdetect -l
#  I2CBUS is an integer or an I2C bus name
#  If provided, FIRST and LAST limit the probing # range.
```

```
sudo i2cdetect -y -r 0 
```
OR 
```
sudo i2cdetect -y -r 1 
```



## License 

MIT License

Copyright (c) 2015-2018 JetsonHacks

Copyright (c) 2012 Adafruit Industries

Derived from the Adafruit LED Backpack Library at:

--> https://github.com/adafruit/Adafruit-LED-Backpack-Library

Redistribution code attribution from Adafruit:

This is a library for our I2C LED Backpacks

Designed specifically to work with the Adafruit LED Matrix backpacks

----> http://www.adafruit.com/products/

----> http://www.adafruit.com/products/

These displays use I2C to communicate, 2 pins are required to interface. There are multiple selectable I2C addresses. For backpacks with 2 Address Select pins: 0x70, 0x71, 0x72 or 0x73. For backpacks with 3 Address Select pins: 0x70 thru 0x77

Adafruit invests time and resources providing this open source code, please support Adafruit and open-source hardware by purchasing products from Adafruit!

Written by Limor Fried/Ladyada for Adafruit Industries. MIT license, all text above must be included in any redistribution
