VAR drunk = 0
VAR win = 0
VAR loop = 0
VAR attack = 0
VAR defense = 0


VAR score = false

Flinta: Give me your Best
--> MAIN



== MAIN ==

{drunk == 5:  -> LOSE} 

{win == 5: -> WIN}

{loop == 4: Flinta: My Turn! | Regina: My Turn!}

{ loop:
- "0": -> INSULT1
- "1": -> INSULT2
- "2": -> INSULT3
- "3": -> INSULT4
- "4": -> INSULT_CHOICES
}


== INSULT1 ==  


Regina: A 

+Flinta: a
    ~win += 1
    ~loop = 4
+Flinta: b
    ~drunk += 1
    ~loop = RANDOM(0,3)
+Flinta: c
    ~drunk += 1
    ~loop = RANDOM(0,3)
+Flinta: d
    ~drunk += 1
    ~loop = RANDOM(0,3)
    
--> MAIN 




== INSULT2 ==


Regina: B

+Flinta: a
    ~drunk += 1
    ~loop = RANDOM(0,3)
+Flinta: b
    ~win += 1
    ~loop = 4
+Flinta: c
    ~drunk += 1
    ~loop = RANDOM(0,3)
+Flinta: d
    ~drunk += 1
    ~loop = RANDOM(0,3)
    
--> MAIN



== INSULT3 ==


Regina: C

+Flinta: a
    ~drunk += 1
    ~loop = RANDOM(0,3)
+Flinta: b
    ~drunk += 1
    ~loop = RANDOM(0,3)
+Flinta: c
    ~win += 1
    ~loop = 4
+Flinta: d
    ~drunk += 1
    ~loop = RANDOM(0,3)
--> MAIN




== INSULT4 ==


Regina: D

+Flinta: a
    ~drunk += 1
    ~loop = RANDOM(0,3)
+Flinta: b
    ~drunk += 1
    ~loop = RANDOM(0,3)
+Flinta: c
    ~drunk += 1
    ~loop = RANDOM(0,3)
+Flinta: d
    ~win += 1
    ~loop = 4
--> MAIN



== INSULT_CHOICES ==

{drunk == 5:  -> LOSE} 

{win == 5: -> WIN}

+Flinta: A
    ~attack = 0
    ~defense = RANDOM(0,3)
+Flinta: B
    ~attack = 1
    ~defense = RANDOM(0,3)
+Flinta: C
    ~attack = 2
    ~defense = RANDOM(0,3)
+Flinta: D
    ~attack = 3
    ~defense = RANDOM(0,3)
--> RESPONSE




== RESPONSE ==

{defense == 0: Regina: a }
{defense == 1: Regina: b }
{defense == 2: Regina: c }
{defense == 3: Regina: d }

{defense == attack:  -> LOST_INSULT | -> WON_INSULT }


== WON_INSULT ==

Flinta: Drink up!
    ~win += 1

--> MAIN



== LOST_INSULT ==

Regina: Drink up!
    ~drunk += 1
    ~loop = RANDOM(0,3)

--> MAIN




== LOSE ==

lost #loser

-> END


== WIN ==

won #winner

-> END
