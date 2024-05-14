--[[
    UIMgr
]]

local uiMgr = BaseClass("UIMgr")

function uiMgr:__init()
    self.ETC = Global.Canvas:Find("EtcBg/ETC"):GetComponent(typeof(CS.ETCDragHelper))
    self.Btn_Backpack = Global.Canvas:Find("BtnBackpack"):GetComponent(typeof(UI.Button))
    self.Backpack = Global.Canvas:Find("Backpack").transform
    self.BagItemParent = self.Backpack:Find("View/Viewport/Content").transform
    self.BagItemTemp = self.BagItemParent:Find("BagItemTemp")
    self.EquipBar = Global.Canvas:Find("Backpack/EquipBar").transform
    self.Top = Global.Canvas:Find("Top")
    self.IsOpen = false
    self.BagItemTemp.gameObject:SetActive(false)

    self.Btn_Backpack.onClick:AddListener(function()
        self.IsOpen = not self.IsOpen
        self.Backpack.gameObject:SetActive(self.IsOpen)
        self:ShowBackpack()
    end)
end

--获取位置
function uiMgr:GetPos()
    local x = self.ETC:GetAxis("H")
    local z = self.ETC:GetAxis("V")
    return Vector3(x, 0, z)
end

--展示背包
function uiMgr:ShowBackpack()
    for i = 1, self.BagItemParent.childCount - 1 do
        GameObject.Destroy(self.BagItemParent:GetChild(i).gameObject)
    end

    for i = 1, #Global.MyBackpack do
        local icon = GameObject.Instantiate(self.BagItemTemp, self.BagItemParent)
        icon.gameObject:SetActive(true)
        icon = icon:GetChild(0):GetComponent(typeof(Image))
        icon.name = Global.MyBackpack[i]
        icon.sprite = Resources.Load("Icon/" .. Global.MyBackpack[i], typeof(Sprite))
        local UIDrag = icon:GetComponent(typeof(CS.DragHelper))
        UIDrag.LuaBeginDrag = function(eventData)
            self.CurrentParent = icon.transform.parent
            icon.raycastTarget = false
            icon.transform:SetParent(self.Top)
        end
        UIDrag.LuaDrag = function(eventData)
            icon.transform.position = Input.mousePosition
        end
        UIDrag.LuaEndDrag = function(eventData)
            local go = eventData.pointerCurrentRaycast.gameObject
            icon.raycastTarget = true
            if go ~= nil then
                if go.name == icon.name then
                    icon.transform:SetParent(go.transform)
                    icon.transform.localPosition = Vector3.zero
                else
                    icon.transform:SetParent(self.CurrentParent)
                    icon.transform.localPosition = Vector3.zero
                end
            else
                icon.transform:SetParent(self.CurrentParent)
                icon.transform.localPosition = Vector3.zero
            end
        end
    end
end

return uiMgr
