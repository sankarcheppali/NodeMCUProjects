local module = {}
m = nil
-- Sends a simple ping to the broker
local function send_ping()
    m:publish(config.ENDPOINT .."/fromnode",gpio.read(1)..gpio.read(2)..gpio.read(3)..gpio.read(4),0,1)
    print("Published the status")
end

local function consume_data( payload )
  --do someting with the payload and send responce
    send_ping()
end
-- Sends my id to the broker for registration
local function register_myself()
    m:subscribe(config.ENDPOINT .. "/tonode",0,function(conn)
        print("Successfully subscribed to data endpoint")
        send_ping()
    end)
end

local function mqtt_start()
    m = mqtt.Client(config.ID, 120,config.USERNAME,config.PASSWORD)
    -- register message callback beforehand
    m:on("message", function(conn, topic, data)
      if data ~= nil then
        print(topic .. ": " .. data)
        consume_data(data)
      end
    end)
    -- Connect to broker
    m:connect(config.HOST, config.PORT, 0, 1, function(con)
        register_myself()
    end)

end

function module.start()
  mqtt_start()
end

return module
