using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public class ClickThreeDHelper : MonoBehaviour, IPointerClickHandler
{
    public Action<PointerEventData> luaOnClickPoint;
    public void OnPointerClick(PointerEventData eventData)
    {
        Debug.Log("µã»÷ÁË" + name);
        luaOnClickPoint?.Invoke(eventData);
    }

    public static ClickThreeDHelper Get(GameObject gameObject)
    {
        ClickThreeDHelper clickThreeDHelper;
        if (!gameObject.TryGetComponent(out clickThreeDHelper))
        {
            clickThreeDHelper = gameObject.AddComponent<ClickThreeDHelper>();
        }
        return clickThreeDHelper;
    }

}
