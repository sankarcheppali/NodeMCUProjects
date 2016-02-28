local module={}
function module.start()  
srv=net.createServer(net.TCP)
print("Server started");
srv:listen(80,"192.168.2.1",function(conn)
conn:on("receive",function(conn,payload)
 print(payload)
 conn:send("Hello from Node MCU");
 end)
end)
end
return module