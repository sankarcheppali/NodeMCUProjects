local module = {}

module.SSID = {}
module.SSID["Ravindra-152"] = "goodjob1"

module.HOST = "m10.cloudmqtt.com"
module.PORT = 16019
module.USERNAME = "nodemcu"
module.PASSWORD = "pass01@23"
module.ID = node.chipid()

module.ENDPOINT = "/nodemcu/"..node.chipid().."/arduino"
return module
