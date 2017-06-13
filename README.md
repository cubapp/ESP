# ESP 8266 plus BMP180 plus BH1750 
Connecting BMP 180 (temperature and pressure) and BH1750 (light sensor) to ESP8266 and reporting the values to the syslog server. 

## init.lua
initial file (start file) to blink the internal LED, connect to WiFi and starting the sensor readout

## mbp180client.lua
the sensor readout and syslog reporting. I chose 514/UDP to the nearest syslog since it is easy to catch on the syslog server. 

