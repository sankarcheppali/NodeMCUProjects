--file name: config.lua
local module = {}
module.SSID = {}
module.SSID["ssid"] = "wifi password"
module.HOST = "mqtt host name"
module.PORT = mqtt port 
module.USERNAME = "mqtt user name"
module.PASSWORD = "mqtt user password"
module.ID = node.chipid()
module.ENDPOINT = "/node/v1/"..node.chipid().."/code"
return module
