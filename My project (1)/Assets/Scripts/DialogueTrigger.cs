using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;


public class DialogueTrigger : MonoBehaviour
{
    [SerializeField] private TextAsset ink;



    public void MyTurn()
    {
        DialogueManager.GetInstance().EnterDialogueMode(ink);
    }





}
