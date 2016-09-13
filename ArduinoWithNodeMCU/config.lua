local module = {}

module.SSID = {}
module.SSID["SSID"] = "PASS"

module.HOST = "HOST"
module.PORT = PORT
module.USERNAME = "username"
module.PASSWORD = "password"
module.ID = node.chipid()

module.ENDPOINT = "/nodemcu/"..node.chipid().."/arduino"
return module
