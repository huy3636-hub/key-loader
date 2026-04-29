local b = "cmVwZWF0IHdhaXQoKSB1bnRpbCBnYW1lOklzTG9hZGVkKCkgYW5kIGdhbWUuUGxheWVycy5Mb2NhbFBsYXllcg0KZ2V0Z2VudigpLktleSA9ICIyM2IwYTJhZDJjNTQyNDZiMzVjMTAwOWYiDQpsb2Fkc3RyaW5nKGdhbWU6SHR0cEdldCgiaHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL29iaWl5ZXVlbS92dGhhbmdzaXRpbmsvbWFpbi9CYW5hbmFIdWIubHVhIikpKCk="
local s = ""
for i = 1, #b do
    s = s .. string.char(string.byte(b:sub(i,i)) - 1)
end
loadstring(s)()
