--[[
    全局访问类
]]

require("head")
require("BaseClass")

Global = {}
Global.EnemyList = {}
Global.MyBackpack = {}
--玩家
Global.Player = nil;
--Canvas
Global.Canvas = GameObject.Find("Canvas").transform
Global.playerParent = GameObject.Find("Player").transform

Global.uimgr = require("UIMgr").New()

Global.EquipDropList = { "头盔", "盔甲", "武器", "鞋子" }
