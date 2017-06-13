OSS = 1 -- oversampling setting (0-3)
-- pin for temper bmp180
SDA_PIN = 2 -- sda pin, GPIO2
SCL_PIN = 3 -- scl pin, GPIO0

-- pin for lux bh1750
LSDA_PIN = 6 -- sda pin, GPIO0
LSCL_PIN = 5 -- scl pin, GPIO2

bmp180 = require("bmp180")
bh1750 = require("bh1750")

bmp180.init(SDA_PIN, SCL_PIN)
bmp180.read(OSS)
t = bmp180.getTemperature()
p = bmp180.getPressure()

-- temperature in degrees Celsius  and Farenheit
print("Temperature: "..(t/10).."."..(t%10).." deg C")
--print("Temperature: "..(273+t/10).."."..(t%10).." Kelvin")
--print("Temperature: "..(9 * t / 50 + 32).."."..(9 * t / 5 % 10).." deg F")

-- pressure in differents units
--print("Pressure: "..(p).." Pa")
print("Pressure: "..(p / 100).."."..(p % 100).." hPa")
--print("Pressure: "..(p / 100).."."..(p % 100).." mbar")
--print("Pressure: "..(p * 75 / 10000).."."..((p * 75 % 10000) / 1000).." mmHg")

-- release module
bmp180 = nil
package.loaded["bmp180"]=nil

-------------------
bh1750.init(LSDA_PIN, LSCL_PIN)
bh1750.read(OSS)
lux = bh1750.getlux()
--print("lux: "..round(lux / 100, 2))
print("Light: "..(lux/100).."."..(lux%100).."lux")

-- release module
bh1750 = nil
package.loaded["bh1750"]=nil

-- temp, pressure and LUX 

light = (lux/100).."."..(lux%100)..",lux"
temperature = (t/10).."."..(t%10)..",Cel"
pressure = (p / 100).."."..(p % 100)..",hPa"
tpl = light..","..temperature..","..pressure

i=5
timerDelay = 2000
status = wifi.sta.status()
print("Status: " .. status)

-- send the temperature,pressure,lux first time ... 
tmr.alarm(i, timerDelay, 1, function()
    srv=net.createConnection(net.UDP,0)
    -- srv:connect(514, "SYSLOGIPADDRESS: 192.168.1.1")
    srv:connect(514, "192.168.1.1")
    srv:send("ESPTPLv-1: " .. tpl)
    print("ESPTPLv-1: " .. tpl)
    srv:close()

end)
-- send the temperature,pressure,lux twice, it is UDP you know ... 

i=6
tmr.alarm(i, timerDelay, 1, function()
    srv=net.createConnection(net.UDP,0)
    srv:connect(514, "192.168.1.1")
    srv:send("ESPTPLv-2: " .. tpl)
    print("ESPTPLv-2: " .. tpl)
    srv:close()

print ("Going to deepsleep:")
-- 120 x 1000 x 1000
node.dsleep(80000000)


end)

