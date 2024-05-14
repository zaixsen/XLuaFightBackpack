using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AnimatorAtkHelper : MonoBehaviour
{
    public Action LuaAnimAtk;
    public Action LuaAnimDead;

    private void Dead()
    {
        LuaAnimDead.Invoke();
    }

    private void Atk()
    {
        LuaAnimAtk?.Invoke();
    }

    public static AnimatorAtkHelper Get(GameObject gameObject)
    {
        AnimatorAtkHelper animatorAtkHelper;
        if (!gameObject.TryGetComponent(out animatorAtkHelper))
        {
            animatorAtkHelper = gameObject.AddComponent<AnimatorAtkHelper>();
        }
        return animatorAtkHelper;
    }




}
