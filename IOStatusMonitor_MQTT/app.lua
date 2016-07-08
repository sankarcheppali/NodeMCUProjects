local module = {}
m = nil
-- Sends a simple ping to the broker
local function monitorIO()
    print("Pollling the IO")
    local send=0
    for io=1,8 do
        local ios=gpio.read(io)
        if sts["p"..io][2] ~= ios then
            tsts["p"..io]=tsts["p"..io]+1
            if tsts["p"..io] > config.confidence then
                sts["p"..io][2] = ios
                tsts["p"..io]=0
                send=1
            end
        else tsts["p"..io]=0
        end
    end
    if send==1 then 
        send=0
        print("Sending the message :"..cjson.encode(sts))
        m:publish(config.ENDPOINT .."/fromnode",cjson.encode(sts),0,1)
        for io=1,8 do
            sts["p"..io][1]=sts["p"..io][2]
       end
     end
    print(cjson.encode(sts))
    print(cjson.encode(tsts))
    tmr.start(0)
end    

local function send_ping()  
    m:publish(config.ENDPOINT .."/fromnode",cjson.encode(sts),0,1)
    print("Published the status")
end

local function consume_data( payload )
    --we are not doing any thing with the payload
    send_ping()
end
-- Sends my id to the broker for registration
local function register_myself()  
    m:subscribe(config.ENDPOINT .. "/tonode",0,function(conn)
        print("Successfully subscribed to data endpoint")
        tmr.start(0)
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
    m:connect(config.HOST, config.PORT, 0, 1, function(con) 
        register_myself()
    end)
    print("Frequency "..config.frq);
    tmr.alarm(0, config.frq, tmr.ALARM_SEMI, monitorIO) 
end

function module.start() 
sts={}
tsts={}
for i=1,8 do
    gpio.mode(i,gpio.INPUT,gpio.PULLUP)
    sts["p"..i]={}
    sts["p"..i][1]=0
    tsts["p"..i]=0
end
  mqtt_start()
end
return module