using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public class ETCDragHelper : MonoBehaviour, IDragHandler, IEndDragHandler
{

    RectTransform rectTransform;
    private float R = 150;
    Vector3 StartPos;
    private void Start()
    {
        rectTransform = transform as RectTransform;
        StartPos = transform.position;
    }

    public void OnDrag(PointerEventData eventData)
    {
        transform.position = Vector3.ClampMagnitude(Input.mousePosition - StartPos, R) + StartPos;
    }

    public float GetAxis(string axis)
    {
        if (axis == "H")
        {
            return rectTransform.anchoredPosition.x / R;
        }
        else if (axis == "V")
        {
            return rectTransform.anchoredPosition.y / R;
        }
        else
        {
            return 0;

        }
    }

    public void OnEndDrag(PointerEventData eventData)
    {
        transform.position = StartPos;
    }
}
