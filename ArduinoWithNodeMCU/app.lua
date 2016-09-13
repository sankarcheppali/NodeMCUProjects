local module = {}
m = nil
-- Sends a simple ping to the broker

local function send_ping()  
    m:publish(config.ENDPOINT .."/fromnode/","Hello From node",0,1)
    print("Published the status")
end

local function consume_data( payload )
    --we will parse the payload and excute it,publish the return value
    m:publish(config.ENDPOINT .."/fromnode/cr/",'{"codeResult":'..cjson.encode({pcall(loadstring(payload))})..'}',0,1)
end
-- Sends my id to the broker for registration
local function register_myself()
    print("Subcribing to the end point")
    m:subscribe(config.ENDPOINT.."/tonode/#" ,0,function(conn)
        print("Successfully subscribed to data endpoint")
        --send_ping()
    end)
end

local function mqtt_start()  
    m = mqtt.Client(config.ID, 120,config.USERNAME,config.PASSWORD)
    -- register message callback beforehand
    m:on("message", function(conn, topic, data) 
      if data ~= nil then
        print(topic .. ": " .. data)
        consume_data(data)
        -- do something, we have received a message
      end
    end)
    -- Connect to broker
    print("Connecting to broker")
    m:connect(config.HOST, config.PORT, 0, 1, function(con) 
      print("Connected to broker")
      register_myself()
    end,function(code,con) print('code :'..con) end)
end



local function listenToArduino()
  
  uart.on("data","\n",function(data)
  --send what ever comes from the arduino
  m:publish(config.ENDPOINT .."/fromnode/",data,0,1) 
  end,0)
end

function module.start() 
  counters={}
  print("Setting up the APP")
  mqtt_start()
  listenToArduino()
  --registerIOIntr()
end

return module
