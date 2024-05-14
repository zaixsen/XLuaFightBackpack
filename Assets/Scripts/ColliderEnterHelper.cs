using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ColliderEnterHelper : MonoBehaviour
{
    public Action<Collision> LuaCollsionEnter;

    private void OnCollisionEnter(Collision collision)
    {
        LuaCollsionEnter?.Invoke(collision);
    }

    public static ColliderEnterHelper Get(GameObject gameObject)
    {
        ColliderEnterHelper colliderEnterHelper;
        if (!gameObject.TryGetComponent(out colliderEnterHelper))
        {
            colliderEnterHelper = gameObject.AddComponent<ColliderEnterHelper>();
        }
        return colliderEnterHelper;
    }
}
