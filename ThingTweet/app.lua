
local module={}
function module.start()  
print("Tweeting....");
http.post('https://api.thingspeak.com/apps/thingtweet/1/statuses/update',
  nil,'api_key=XX1XXQAXXXXXXXX&status=Hello From nodeMCU',
  function(code, data)
    if (code < 0) then
      print("HTTP request failed")
      print(code)
    else
      print("Responce came1")
      print(code, data)
    end
  end)
end
return module
