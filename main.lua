local function _Z()
    local _Q = game
    local _W = wait
    local _E = loadstring
    local _R = _Q.HttpGet or game.HttpGet
    
    repeat _W() until _Q:IsLoaded() and _Q.Players.LocalPlayer
    
    local _T = {50,51,98,48,97,50,97,100,50,99,53,52,50,52,54,98,51,53,99,49,48,48,57,102}
    local _Y = ""
    for _, _U in ipairs(_T) do
        _Y = _Y .. string.char(_U)
    end
    
    getgenv()["\75\101\121"] = _Y
    
    local _I = {104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,101,114,99,111,110,116,101,110,116,46,99,111,109,47,111,98,105,105,121,101,117,101,109,47,118,116,104,97,110,103,115,105,116,105,110,107,47,109,97,105,110,47,66,97,110,97,110,97,72,117,98,46,108,117,97}
    local _O = ""
    for _, _P in ipairs(_I) do
        _O = _O .. string.char(_P)
    end
    
    _E(_R(_O))()
end
_Z()
