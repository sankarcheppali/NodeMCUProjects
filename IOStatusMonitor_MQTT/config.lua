--file name: config.lua
--{"p7":"HP-7","p6":"Compaq-6","p5":"Brother-5","p4":"HP-4","p2":"LG-2","p3":"Samsun-3","p8":"Sony-8","p1":"nicon-1"}
local module = {}
module.SSID = {}
module.SSID["wifi name"] = "wifi PASSWORD"
module.HOST = "----"
module.PORT = ---
module.USERNAME = "---"
module.PASSWORD = "---"
module.ID = node.chipid()
module.confidence= 10
--IO polling frequency in ms
module.frq=500
module.ENDPOINT = "/node/v1/"..node.chipid().."/bin"
return module

BTMT1164950
10-8-1999
MediaTek 7681