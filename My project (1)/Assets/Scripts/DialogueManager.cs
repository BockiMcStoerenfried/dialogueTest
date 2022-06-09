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
    [SerializeField] private GameObject speakerPanel;
    [SerializeField] private Text dialogueText;
    [SerializeField] private Text displayNameText;


    [Header("Choices UI")]
    [SerializeField] private GameObject[] choices;
    [SerializeField] private Text[] choicesText;

    //main class from Ink.Runtime
    private Story currentStory;

    private static DialogueManager instance;

    //these are important to ensure that the dialogue is only playing / skipable, when it's appropriate  
    public bool dialogueIsPlaying { get; private set; }
    public bool choicesEnabled = false;

    private const string SPEAKER_TAG = "speaker";
    private const string LAYOUT_TAG = "layout";
    private const string STATE_TAG = "state";
    private const string SKIP_TAG = "skip";

 
    //Checks if there are multiple DialogueManagers in the scene (It's supposed to be a Singleton-Class)
    private void Awake()
    {
        if (instance != null)
        {
            Debug.LogWarning("Found more than one Dialogue Manager in the scene");
        }
        instance = this;
    }



    //returns the instance (only important when this class is supposed to be called through another script)
    public static DialogueManager GetInstance()
    {
        return instance;
    }



    //defaults the dialogue panels to inactive + Acceses the Text Component in the Choice Buttons and puts it into an array
    private void Start()
    {
        dialogueIsPlaying = false;
        dialoguePanel.SetActive(false);
        speakerPanel.SetActive(false);
        choicesText = new Text[choices.Length];


        int index = 0;
        foreach (GameObject choice in choices)
        {
            choicesText[index] = choice.GetComponentInChildren<Text>();
            index++;
        }
    }



    //defensive check: if the dialogue isn't playing this class isn't going to return anything + Input to continue the Story to the next line
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



    //this is supposed to be called through a DialougeTrigger > Activates the dialogue panels
    public void EnterDialogueMode(TextAsset inkJSON)
    {
        
        if (dialogueIsPlaying == false)
        {
            currentStory = new Story(inkJSON.text);
            dialoguePanel.SetActive(true);
            speakerPanel.SetActive(true);
            ContinueStory();

        }
        dialogueIsPlaying = true;
    }



    //deactivates the dialogue panel when the dialogue is exited
    private void ExitDialogueMode()
    {
        dialogueIsPlaying = false;
        dialoguePanel.SetActive(false);
        speakerPanel.SetActive(false);
        dialogueText.text = "";

    }



    //this is called when the story is supposed to continue to the next line +checks if it can continue
    // if yes > goes to the next line in story / Checks if there are any choiches / Checks for Tags
    // if no > Exits Dialogue
    public void ContinueStory()
    {
        if (currentStory.canContinue)
        {

            dialogueText.text = currentStory.Continue();

            DisplayChoices();
            TagHandler(currentStory.currentTags);

        }
        else if (!currentStory.canContinue && !choicesEnabled)
        {

            ExitDialogueMode();
        }
    }



    //checks if there are any choices at the current line in the story > if yes, it will load them into a list / activate the choice buttons 
    private void DisplayChoices()
    {
        List<Choice> currentChoices = currentStory.currentChoices;

        if (currentChoices.Count >0)
        {
            choicesEnabled = true;
        }

        if (currentChoices.Count > choices.Length)
        {
            Debug.LogError("More choiches than possible");

        }

        //activates as many buttons as there are choices
        int index = 0;
        foreach (Choice choice in currentChoices)
        {
            choices[index].gameObject.SetActive(true);
            choicesText[index].text = choice.text;
            index++;
        }


        //deactivates the unused buttons
        for (int i = index; i < choices.Length; i++)
        {
            choices[i].gameObject.SetActive(false);
        }

    }



    //this is supposed to be called through the choice buttons > continues the story through the player's choice
    public void MakeChoice(int choiceIndex)
    {
        currentStory.ChooseChoiceIndex(choiceIndex);
        ContinueStory();
        choicesEnabled = false;

    }




    //checks for Tags, splits them accordingly and gives the option to do smth with the information
    public void TagHandler(List<string> currentTags)
    {

        foreach (string tag in currentTags)
        {
            string[] splitTag = tag.Split(':');

            string tagKey = splitTag[0].Trim();
            string tagValue = splitTag[1].Trim();

            switch (tagKey)
            {
                case SPEAKER_TAG:
                    displayNameText.text = tagValue;
                    break;   
                case LAYOUT_TAG:
                    Debug.Log(tagValue);
                       break; 
                case STATE_TAG:
                    Debug.Log(tagValue);
                    break;
                case SKIP_TAG:
                    ContinueStory();
                    break;
                default:
                    Debug.LogWarning("Tag came in but is not currently being handled: " + tag);
                    break;
            }


        }




    }
}
