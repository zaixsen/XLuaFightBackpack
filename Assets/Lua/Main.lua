--[[
    主入口
]]
require("Global")

function LuaStart()
    Global.PlayerMgr = require("PlayerMgr").New()
    Global.EnemySpaw = require("SpawEnemy").New()
end

function LuaUpdate()
    if Global.PlayerMgr ~= nil then
        Global.PlayerMgr:Update()
    end

    for i = 1, #Global.EnemyList do
        Global.EnemyList[i]:Update()
    end
end


