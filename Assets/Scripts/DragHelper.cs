using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public class DragHelper : MonoBehaviour, IBeginDragHandler, IDragHandler, IEndDragHandler
{
    public Action<PointerEventData> LuaBeginDrag;
    public Action<PointerEventData> LuaDrag;
    public Action<PointerEventData> LuaEndDrag;

    public void OnBeginDrag(PointerEventData eventData)
    {
        LuaBeginDrag?.Invoke(eventData);
    }

    public void OnDrag(PointerEventData eventData)
    {
        LuaDrag?.Invoke(eventData);
    }

    public void OnEndDrag(PointerEventData eventData)
    {
        LuaEndDrag?.Invoke(eventData);
    }

    public static DragHelper Get(GameObject gameObject)
    {
        DragHelper  dragHelper;
        if (!gameObject.TryGetComponent(out dragHelper))
        {
            dragHelper = gameObject.AddComponent<DragHelper>();
        }
        return dragHelper;
    }
}
