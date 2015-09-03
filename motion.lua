inpin=6
gpio.mode(inpin, gpio.INT)

start=tmr.time()

function motionStart()
  start=tmr.time()
  print('Motion detected!')
  tmr.delay(1000000)
  gpio.trig(inpin, "down", motionStop)
end

function motionStop()
  duration = tmr.time() - start
  print('motion ended after '..duration..' seconds.')
  tmr.delay(1000000)
  gpio.trig(inpin, "up", motionStart)
end

gpio.trig(inpin, "up", motionStart)
