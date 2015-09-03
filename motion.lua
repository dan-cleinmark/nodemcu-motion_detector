inpin=6
gpio.mode(inpin, gpio.INT)

counter=0
datetime="nope"


function motionStart()
  now=getDateTime()
  print("Motion detected at "..now)
  tmr.delay(1000000)
  gpio.trig(inpin, "down", motionStop)
end

function motionStop()
  now=getDateTime()
  print("Motion stopped at "..now)
  tmr.delay(1000000)
  gpio.trig(inpin, "up", motionStart)
end

function getDateTime()
  conn=net.createConnection(net.TCP, 0)
  conn:on("connection",function(conn, payload)
            conn:send("HEAD / HTTP/1.1\r\n".. 
                      "Host: google.com\r\n"..
                      "Accept: */*\r\n"..
                      "User-Agent: Mozilla/4.0 (compatible; esp8266 Lua;)"..
                      "\r\n\r\n") 
            end)
            
  conn:on("receive", function(conn, payload)
    datetime=string.sub(payload,string.find(payload,"Date: ")
            +6,string.find(payload,"Date: ")+35)
    print('\nRetrieved in '..((tmr.now()-t)/1000)..' milliseconds.')
    print('Google says it is '..datetime)
    conn:close()
    end) 
  
  t = tmr.now()    
  conn:connect(80,'google.com') 
  return datetime
end
  

gpio.trig(inpin, "up", motionStart)
