--[[
    怪物生成
    怪物每隔0.5s 攻击一次 
]]
local enemy = BaseClass("enemy")

function enemy:__init(Go)
    self.Go = Go
    self.Nav = self.Go:GetComponent(typeof(NavMeshAgent))
    self.Anim = self.Go:GetComponent(typeof(Animator))
    self.Hp = self.Go.transform:Find("Canvas/Hp"):GetComponent(typeof(UI.Slider))
    self.IsMove = false
    self.IsAtk = true
    --攻击间隔时间
    self.AtkIntervalTime = 2
    self.IdleTime = 0
    CS.AnimatorAtkHelper.Get(self.Go).LuaAnimAtk = function()
        if Global.Player ~= nil and Global.PlayerMgr.Hp.value >= 0 then
            Global.PlayerMgr:SetHp(5)
        end
    end
end

function enemy:Update()
    self.Hp.transform:LookAt(Camera.main.transform)
    local dis = 10000
    if Global.Player ~= nil then
        dis = Vector3.Distance(Global.Player.transform.position, self.Go.transform.position)
    end


    if dis <= 1 then --攻击
        if self.IsAtk then
            self.Anim:SetBool("Move", false);
            self.Anim:SetTrigger("Atk");
            if self.Anim:GetCurrentAnimatorStateInfo(0).length >= 0.99 then
                self.IsAtk = false
            end
        end
        if not self.IsAtk then
            self.AtkIntervalTime = self.AtkIntervalTime - Time.deltaTime
            if self.AtkIntervalTime <= 0 then
                self.AtkIntervalTime = 2
                self.IsAtk = true
            end
        end
    elseif dis <= 3 then --追击
        self.Anim:SetBool("Move", true);
        self.Nav:SetDestination(Global.Player.transform.position)
    else --巡逻
        self.Anim:SetBool("Move", true);
        if self.Nav.remainingDistance <= self.Nav.stoppingDistance then
            self.Anim:SetBool("Move", false);
            self.IdleTime = self.IdleTime - Time.deltaTime
            if self.IdleTime <= 0 then
                self.Anim:SetBool("Move", true);
                self.IdleTime = 2
                local pos = Random.insideUnitCircle * 6
                self.Nav:SetDestination(Vector3(pos.x, 0, pos.y))
            end
        end
    end
end

function enemy:SetHp(value)
    self.Hp.value = self.Hp.value - value
    if self.Hp.value <= 0 then
        --销毁
        self:RemoveSelf()
        GameObject.Destroy(self.Go)

        -- 生成随机装备
        local equipIndex = math.random(1, #Global.EquipDropList)
        local equip_Go = GameObject.Instantiate(Resources.Load("player/" .. Global.EquipDropList[equipIndex],
            typeof(GameObject)))
        equip_Go.name = Global.EquipDropList[equipIndex]
        equip_Go.transform.position = self.Go.transform.position
        require("EquipDrop").New(equip_Go)
    end
end

function enemy:RemoveSelf()
    for i = 1, #Global.EnemyList do
        if Global.EnemyList[i] == self then
            table.remove(Global.EnemyList, i)
            break;
        end
    end
end

return enemy
