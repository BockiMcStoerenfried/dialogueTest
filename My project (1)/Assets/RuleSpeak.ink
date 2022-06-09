VAR attack = 0
VAR roundattack = 0

VAR defense = 0
VAR winchance = 0

VAR roundCount = 0
VAR roundCountF = 0

VAR Ycounter = 0

VAR 5syl = "a"
VAR 7syl = ""


VAR rounds_won = 0
VAR rounds_lost = 0


Die Regäln sind einfasch: #speaker:c

1. Fünf Silben, dann sieben, dann fünf
2. Nach 3 Zeilen kommt ein "yo-ho-ho" und dann nach fünf ein "und ne Budel voll Rum"


-> ROUND_1R

=== ROUND_1R ===
~Ycounter +=1
~roundCount +=1
~winchance +=1
-> ATTACK_HANDLER



=== REGINA_CHECKER ===

{attack: 
- 1: Die Schuhe stinken #speaker:c
- 2: Du Leichtmatrose #speaker:c
- 3: Spiegel hassen dich #speaker:c
- 4: Ich klatsch dir eine #speaker:c
- 5: 5.5 #speaker:c
- 6: Davy Jones' Kiste wartet schon #speaker:c
- 7: Dein Holzbein wird verfeuert #speaker:c
- 8: 7.3
- 9: 7.4
- 10: 7.5
- 11: Yo-'o-'o #speaker:c 
- 12: Yo-'o-'o #speaker:c 
- 13: Yo-'o-'o #speaker:c
- 14: Yo-'o-'o #speaker:c
- 15: Yo-'o-'o #speaker:c
- 16: Und ne Budel voll Rüm #speaker:c
- 17: Und ne Budel voll Rüm #speaker:c
- 18: Und ne Budel voll Rüm #speaker:c
- 19: Und ne Budel voll Rüm #speaker:c
- 20: Und ne Budel voll Rüm #speaker:c
}

{roundCount:
- 1: -> COUNT_HANDLER3
- 2: -> COUNT_HANDLER4
- else: -> COUNT_HANDLER5
}



=== CHOICES_R1 ===

{Ycounter == 3: -> COUNT_HANDLER1}
{Ycounter == 5: -> COUNT_HANDLER2 | -> CHOICES_R2 }


=== CHOICES_W ===

{Ycounter == 3: -> COUNT_HANDLER1}
{Ycounter == 5: -> COUNT_HANDLER2 | -> ROUND_WON}

=== CHOICES_R2 ===

~roundCount +=1
~Ycounter +=1

{roundCount:
- 1: -> COUNT_HANDLER6
- 2: -> COUNT_HANDLER7
- else: -> COUNT_HANDLER8
}


=== CHOICES_R3 ===

~5syl = RANDOM(1,5)
~7syl = RANDOM(1,5)

+ {5syl == 1} 5.a #speaker:f
    ~defense = 1
    {Ycounter == 3: -> ROUND_LOST}
    {Ycounter == 5: -> ROUND_LOST}
    {roundCountF == defense: -> ROUND_1R | -> ROUND_LOST}
    
+ {5syl == 2} 5.b #speaker:f
    ~defense = 1
    {Ycounter == 3: -> ROUND_LOST}
    {Ycounter == 5: -> ROUND_LOST}
    {roundCountF == defense: -> ROUND_1R | -> ROUND_LOST}
    
+ {5syl == 3} 5.c #speaker:f
    ~defense = 1
    {Ycounter == 3: -> ROUND_LOST}
    {Ycounter == 5: -> ROUND_LOST}
    {roundCountF == defense: -> ROUND_1R | -> ROUND_LOST}
    
+ {5syl == 4} 5.d #speaker:f
    ~defense = 1
    {Ycounter == 3: -> ROUND_LOST}
    {Ycounter == 5: -> ROUND_LOST}
    {roundCountF == defense: -> ROUND_1R | -> ROUND_LOST}
    
+ {5syl == 5} 5.e #speaker:f
    ~defense = 1
    {Ycounter == 3: -> ROUND_LOST}
    {Ycounter == 5: -> ROUND_LOST}
    {roundCountF == defense: -> ROUND_1R | -> ROUND_LOST}
    
    
    
    
+ {7syl == 1} 7.a #speaker:f
    ~defense = 2
    {Ycounter == 3: -> ROUND_LOST}
    {Ycounter == 5: -> ROUND_LOST}
    {roundCountF  == defense: -> ROUND_1R | -> ROUND_LOST}
    
+ {7syl == 2} 7.b #speaker:f
    ~defense = 2
    {Ycounter == 3: -> ROUND_LOST}
    {Ycounter == 5: -> ROUND_LOST}
    {roundCountF  == defense: -> ROUND_1R | -> ROUND_LOST}  
    
+ {7syl == 3} 7.c #speaker:f
    ~defense = 2
    {Ycounter == 3: -> ROUND_LOST}
    {Ycounter == 5: -> ROUND_LOST}
    {roundCountF  == defense: -> ROUND_1R | -> ROUND_LOST}
    
+ {7syl == 4} 7.d #speaker:f
    ~defense = 2
    {Ycounter == 3: -> ROUND_LOST}
    {Ycounter == 5: -> ROUND_LOST}
    {roundCountF  == defense: -> ROUND_1R | -> ROUND_LOST}
    
+ {7syl == 5} 7.e #speaker:f
    ~defense = 2
    {Ycounter == 3: -> ROUND_LOST}
    {Ycounter == 5: -> ROUND_LOST}
    {roundCountF  == defense: -> ROUND_1R | -> ROUND_LOST}    
  
  
  
    
+ Yo-ho-ho! #speaker:f

    {Ycounter == 3: -> ROUND_1R}
    {Ycounter == 5: -> ROUND_LOST | -> ROUND_LOST}  


    
+ Und ne Budel voll Rum! #speaker:f

    {Ycounter == 3: -> ROUND_LOST}
    {Ycounter == 5: -> COUNT_HANDLER5Y | -> ROUND_LOST}







=== ATTACK_HANDLER ===
{Ycounter:
-3: {rando1()} 
-5: {rando2()} 
}
{Ycounter:
-3: -> REGINA_CHECKER
-5: -> REGINA_CHECKER
}
{winchance:
- 1: -> ATTACK_HANDLER1
- 2: -> ATTACK_HANDLER2
- else: -> ATTACK_HANDLER3
}



=== ATTACK_HANDLER1 ===

{roundCount:
- 1: -> ATTACK_SENDER1
- 2: -> ATTACK_SENDER2
-else: -> ATTACK_SENDER1
}

=== ATTACK_SENDER1 ==

~attack = RANDOM(1,5)

-> REGINA_CHECKER

=== ATTACK_SENDER2 ===

~attack = RANDOM(6,10)

-> REGINA_CHECKER







=== ATTACK_HANDLER2 ===

{roundCount:
- 1: -> ATTACK_SENDER3
- 2: -> ATTACK_SENDER4
- else: -> ATTACK_SENDER3
}


=== ATTACK_SENDER3 ===

~attack = RANDOM(1,7)

-> REGINA_CHECKER


=== ATTACK_SENDER4 ===

~attack = RANDOM(3,10)

-> REGINA_CHECKER






=== ATTACK_HANDLER3 ===

{roundCount:
- 1: -> ATTACK_SENDER5
- 2: -> ATTACK_SENDER6
- 3: -> ATTACK_SENDER5
}


=== ATTACK_SENDER5 ===


~attack = RANDOM(1,8)

-> REGINA_CHECKER


=== ATTACK_SENDER6 ===


~attack = RANDOM(5,10)

-> REGINA_CHECKER



=== ATTACK_HANDLERY1 ===
{rando1()} 
-> REGINA_CHECKER


=== ATTACK_HANDLERY2 ===
{rando2()} 
-> REGINA_CHECKER




=== function rando1() ===

~attack = RANDOM(11,16)
~return

=== function rando2() ===

~attack = RANDOM(15,20)
~return






=== COUNT_HANDLER1 === //Ycounter

{attack:
- 11: -> CHOICES_R2
- 12: -> CHOICES_R2
- 13: -> CHOICES_R2
- 14: -> CHOICES_R2
- 15: -> CHOICES_R2
- else: -> ROUND_WON
}

=== COUNT_HANDLER2 === //Ycounter

~Ycounter = 0
{attack:
- 16: -> CHOICES_R2
- 17: -> CHOICES_R2
- 18: -> CHOICES_R2
- 19: -> CHOICES_R2
- 20: -> CHOICES_R2
- else: -> ROUND_WON
}

=== COUNT_HANDLER3 === //5 Silben

{attack:
- 1: -> CHOICES_R1
- 2: -> CHOICES_R1
- 3: -> CHOICES_R1
- 4: -> CHOICES_R1
- 5: -> CHOICES_R1
- else: -> CHOICES_W
}


=== COUNT_HANDLER4 === //7 Silben

{attack:
- 6: -> CHOICES_R1
- 7: -> CHOICES_R1
- 8: -> CHOICES_R1
- 9: -> CHOICES_R1
- 10: -> CHOICES_R1
- else: -> CHOICES_W
}

=== COUNT_HANDLER5 === //5 Silben + roundCount Reset

~roundCount = 0

{attack:
- 1: -> CHOICES_R1
- 2: -> CHOICES_R1
- 3: -> CHOICES_R1
- 4: -> CHOICES_R1
- 5: -> CHOICES_R1
- else: -> CHOICES_W
}

=== COUNT_HANDLER6 ===

~roundCountF = 1

-> CHOICES_R3


=== COUNT_HANDLER7 ===

~roundCountF = 2

-> CHOICES_R3

=== COUNT_HANDLER8 ===

~roundCountF = 1
~roundCount = 0

-> CHOICES_R3


=== COUNT_HANDLER5Y ===

~Ycounter = 0

-> ROUND_1R


=== ROUND_WON ===

Haha, drink up! #speaker:f

~rounds_won += 1
~Ycounter = 0
~roundCount = 0

{rounds_won == 5: -> STOP}

-> CHOICES_R1



=== ROUND_LOST ===

Ah oui, trink! #speaker:c
~rounds_lost += 1
~Ycounter = 0
~roundCount = 0

{rounds_lost == 5: -> STOP}

-> ROUND_1R



=== STOP ===

end of game

-->END