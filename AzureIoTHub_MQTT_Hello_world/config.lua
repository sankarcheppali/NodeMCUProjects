--file name: config.lua
local module = {}
module.SSID = {}
module.SSID["SSID"] = "WiFi PASSWORD"
module.HOST = "Azure iot hub host name"
module.PORT = 8883
module.USERNAME = "iot hub host name/device id"
module.PASSWORD = "SAS token"
module.ID = node.chipid()
module.ENDPOINT = "devices/"..node.chipid().."/messages"
return module
