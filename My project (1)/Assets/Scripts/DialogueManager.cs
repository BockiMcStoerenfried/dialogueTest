using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Ink.Runtime;
using UnityEngine.EventSystems;
using UnityEngine.UI;


public class DialogueManager : MonoBehaviour
{

    [Header("Dialogue UI")]
    [SerializeField] private GameObject dialoguePanel;
    [SerializeField] private Text dialogueText;




    [Header("Choices UI")]
    [SerializeField] private GameObject[] choices;
    [SerializeField] private Text[] choicesText;



    private Story currentStory; 

   
    public bool dialogueIsPlaying { get; private set; }
    public bool choicesEnabled = false;






    private void Start()
    {
        dialogueIsPlaying = false;
        dialoguePanel.SetActive(false);

        choicesText = new Text[choices.Length];

        int index = 0;
        foreach (GameObject choice in choices)
        {
            choicesText[index] = choice.GetComponentInChildren<Text>();
            index++;
        }
    }

    private void Update()
    {
        if (!dialogueIsPlaying)
        {
            return;
        }
        else if (Input.GetKeyDown(KeyCode.Space))
        {
             ContinueStory();
      
        }
    }


    public void EnterDialogueMode(TextAsset inkJSON) 
    {    
        currentStory = new Story(inkJSON.text);
        dialoguePanel.SetActive(true);

        if (dialogueIsPlaying == false)
        {
            ContinueStory();
            
        }    
        dialogueIsPlaying = true;
    }

    private void ExitDialogueMode()
    {
        dialogueIsPlaying = false;
        dialoguePanel.SetActive(false);
        dialogueText.text = "";
    }

    public void ContinueStory()
    {
        if (currentStory.canContinue)
        {
            
            dialogueText.text = currentStory.Continue();
            
            DisplayChoices();

        }
        else if(currentStory.canContinue == false && choicesEnabled == false)
        {
            TagHandler();
            ExitDialogueMode();
        }
    }

    private void DisplayChoices()
    {
        List<Choice> currentChoices = currentStory.currentChoices;

        if (!currentStory.canContinue)
        {
            choicesEnabled = true;
        }

        if (currentChoices.Count > choices.Length)
        {
            Debug.LogError("More choiches than possible");

        }

    
        int index = 0;
        foreach (Choice choice in currentChoices)
        {
            choices[index].gameObject.SetActive(true);
            choicesText[index].text = choice.text; 
            index++;
        }
            
        

        for (int i = index; i < choices.Length; i++)
        {
            choices[i].gameObject.SetActive(false);
        } 

        StartCoroutine(SelectFirstChoice());
    }

    public void MakeChoice(int choiceIndex)
    {
        currentStory.ChooseChoiceIndex(choiceIndex);
        ContinueStory();
        choicesEnabled = false;

    }

    private IEnumerator SelectFirstChoice()
    {
        EventSystem.current.SetSelectedGameObject(null);
        yield return new WaitForEndOfFrame();

        EventSystem.current.SetSelectedGameObject(choices[0].gameObject);

    }



    public void TagHandler()
    {
        if (currentStory.currentTags != null)
        {
            List<string> tags = currentStory.currentTags;

            Debug.Log(tags[0]);

            if (tags[0] == "loser")
            {
                Debug.Log("You lost, yey");
            }
            else if (tags[0] == "winner")
            {
                Debug.Log("You won, lul");
            }
        }
 
        
    }


    

}
