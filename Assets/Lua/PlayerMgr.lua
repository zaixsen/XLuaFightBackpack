--[[
    玩家操作
]]
local playerMgr = BaseClass("playerMgr")

function playerMgr:__init()
    Global.Player = GameObject.Instantiate(Resources.Load("Role/1", typeof(GameObject)), Global.playerParent)
    self.Hp = Global.Player.transform:Find("Canvas/Hp"):GetComponent(typeof(UI.Slider))
    self.Anim = Global.Player:GetComponent(typeof(Animator))
    self.IsDie = false
    self.RecoverTime = 3
    CS.AnimatorAtkHelper.Get(Global.Player).LuaAnimAtk = function()
        if self.TargetEnemy.Hp.value > 0 then
            self.TargetEnemy:SetHp(10)
        end
    end
end

function playerMgr:Update()
    --死了3秒复活
    if self.IsDie then
        self.RecoverTime = self.RecoverTime - Time.deltaTime
        if self.RecoverTime <= 0 then
            Global.Player = Global.playerParent:GetChild(0).gameObject
            Global.Player:SetActive(true)
            Global.Player.Hp.value = 100
            self.IsDie = false
        end
    end

    if Global.Player == nil then
        return
    end
    self:Move()
    self:CameraFollow()
    self:Attack()
end

function playerMgr:SetHp(value)
    self.Hp.value = self.Hp.value - value
    if self.Hp.value <= 0 then
        Global.Player:SetActive(false)
        Global.Player = nil
        print("销毁")
        self.IsDie = true
    end
end

function playerMgr:Attack()
    if Input.GetKeyDown(KeyCode.Space) then
        --获取最近的敌人
        local dis, targetEnemy = Global.EnemySpaw:GetMinDisEnemy()
        if dis ~= nil and dis <= 3 then
            self.Anim:SetTrigger("Atk")
            self.TargetEnemy = targetEnemy;
        end
    end
end

function playerMgr:CameraFollow()
    self.Hp.transform:LookAt(Camera.main.transform)
    Camera.main.transform:LookAt(Global.Player.transform)
    Camera.main.transform.position = Global.Player.transform.position + Vector3(0, 8, -10)
end

function playerMgr:Move()
    local pos = Global.uimgr:GetPos()
    if pos ~= Vector3.zero then
        self.Anim:SetBool("Move", true)
        Global.Player.transform.position = Global.Player.transform.position + pos * Time.deltaTime * 6
        Global.Player.transform.forward = Vector3.Lerp(Global.Player.transform.forward, pos, Time.deltaTime * 10)
    else
        self.Anim:SetBool("Move", false)
    end
end

return playerMgr
