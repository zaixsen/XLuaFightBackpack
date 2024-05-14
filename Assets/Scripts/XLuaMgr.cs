using System;
using System.IO;
using UnityEngine;
using UnityEngine.AI;
using XLua;
public class XLuaMgr : MonoBehaviour
{
    LuaEnv luaEnv;
    public Action LuaStart;
    public Action LuaUpdate;

    private void Awake()
    {
        luaEnv = new LuaEnv();
        luaEnv.AddLoader(GetLuaFile);
        luaEnv.DoString("require 'Main'");
        LuaStart = luaEnv.Global.Get<Action>("LuaStart");
        LuaUpdate = luaEnv.Global.Get<Action>("LuaUpdate");
    }

    private byte[] GetLuaFile(ref string filepath)
    {
        return File.ReadAllBytes(Application.dataPath + "/Lua/" + filepath + ".lua");
    }

    private void Start()
    {
        LuaStart?.Invoke();
    }

    private void Update()
    {
        LuaUpdate?.Invoke();
    }

}
