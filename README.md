# ESP 8266 plus BMP180 plus BH1750 
Connecting BMP 180 (temperature and pressure) and BH1750 (light sensor) to ESP8266 and reporting the values to the syslog server. 

# Requirements
Hardware:
* ESP8266 with Lua image
* I2C Light sensor BH1750 from https://www.mysensors.org/build/light-bh1750
* I2C Temperature and pressuer sensor BMP180 from https://www.adafruit.com/product/1603

Libraries: 
* bmp180 from https://github.com/javieryanez/nodemcu-modules/tree/master/bmp180
* bh1750 from https://github.com/nodemcu/nodemcu-firmware/blob/master/lua_modules/bh1750/bh1750.lua


## init.lua
initial file (start file) to blink the internal LED, connect to WiFi and starting the sensor readout

## mbp180client.lua
the sensor readout and syslog reporting. I chose 514/UDP to the nearest syslog since it is easy to catch on the syslog server. 

