--[[
    装备Drop
]]

local equipDrop = BaseClass('equipDrop')

function equipDrop:__init(Go, path)
    self.Go = Go
    CS.ColliderEnterHelper.Get(self.Go).LuaCollsionEnter = function(collision)
        if collision.transform:CompareTag("Player") then
            GameObject.Destroy(self.Go)
            --添加背包
            table.insert(Global.MyBackpack, self.Go.name)
        end
    end
    CS.ClickThreeDHelper.Get(self.Go).luaOnClickPoint = function()
        GameObject.Destroy(self.Go)
        --添加背包
        table.insert(Global.MyBackpack, self.Go.name)
    end
end

return equipDrop
