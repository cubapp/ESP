LED_PIN = 4
--gpio.mode(LED_PIN, gpio.OUTPUT)
DELAY = 500

pwm.setup(LED_PIN,80,100) -- port,clock,duty max 1023
pwm.start(LED_PIN)

value = true
print ("ESP TPL 8266 Cuba has just started: wait 10s")

--
tmr.alarm(0, 10000, 1, function ()

    print ("blik start")
    for i = 1,1023 do 
        pwm.setduty(LED_PIN,1024-i)
        tmr.delay(2*DELAY)
    end

    for i = 1,1023 do 
        pwm.setduty(LED_PIN,i)
        tmr.delay(DELAY)
    end
end)

print ("Connecting to WiFi:")

wifi.setmode(wifi.STATION)
wifi.sta.config("myWifiSSID","myWiFiPassword")
wifi.sta.connect()
tmr.alarm(1, 1000, 1, function()
if wifi.sta.getip()== nil then
    print("Waiting for IP...")
else
    tmr.stop(1)
    print("Your IP is "..wifi.sta.getip())
end
end)

print ("Poustime TPL proceduru: plus 20s")
tmr.alarm(0,20000,0,function() dofile('bmp180client.lua') end)


