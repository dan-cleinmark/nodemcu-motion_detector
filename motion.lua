inpin=6
gpio.mode(inpin, gpio.INT)

function motion()
  print("Motion detected!")
  tmr.delay(1000000)
end

gpio.trig(inpin, "high", motion)
