local module={}

function module.start()
wifi.setmode(wifi.SOFTAP)
cfg={}
cfg.ssid="esp"
cfg.pwd="88888888"
cfg.channel=6
wifi.ap.config(cfg)
cfd ={}
cfd.ip="192.168.2.1"
cfd.netmask="255.255.255.0"
cfd.gateway="192.168.2.1"
wifi.ap.setip(cfd)
print(wifi.ap.getip())
print(wifi.ap.getmac())
app.start()
end

return module