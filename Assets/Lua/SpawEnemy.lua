--[[
    生成怪物
]]
local SpawEnemy = BaseClass("spawEnemy")


function SpawEnemy:__init()
    self.EnemyParent = GameObject.Find("SpawEnemy")
    for i = 1, 10 do
        local enemy = GameObject.Instantiate(Resources.Load("Role/7", typeof(GameObject)), self.EnemyParent.transform)
        local pos = Random.insideUnitCircle * 6
        enemy.transform.position = Vector3(pos.x, 0, pos.y)
        local ScptEnemy = require("Enemy").New(enemy)
        table.insert(Global.EnemyList, ScptEnemy)
    end
end

function SpawEnemy:GetMinDisEnemy()
    if #Global.EnemyList <= 0 then
        return
    end
    local mindis = Vector3.Distance(Global.Player.transform.position, Global.EnemyList[1].Go.transform.position)
    local TargetEnemy = Global.EnemyList[1]
    for i = 1, #Global.EnemyList do
        local dis = Vector3.Distance(Global.Player.transform.position, Global.EnemyList[i].Go.transform.position)
        if mindis > dis then
            mindis = dis
            TargetEnemy = Global.EnemyList[i]
        end
    end
    return mindis, TargetEnemy
end

return SpawEnemy
