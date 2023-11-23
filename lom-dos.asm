; The Lords of Midnight - DOS Disassembly
;
; Disassembled by Michael R. Cook, 2023
;
; Copyright (c) 1991 Chris Wild (PC Version)
; Copyright (c) 1984 Beyond Software
; LOM was designed and developed by Mike Singleton
;
; Many of the labels and comments are taken directly from the data
; and code released by Chris Wild on https://www.icemark.com

;
; Constants
;

; Objects
NoObjectAtAll  EQU 00h
Wolves         EQU 01h
Dragons        EQU 02h
IceTrolls      EQU 03h
Skulkrin       EQU 04h
WildHorses     EQU 05h
Shelter        EQU 06h
Guidance       EQU 07h
ShadowsOfDeath EQU 08h
WatersOfLife   EQU 09h
HandOfDark     EQU 0Ah
CupOfDreams    EQU 0Bh
WolfSlayer     EQU 0Ch
DragonSlayer   EQU 0Dh
IceCrown       EQU 0Eh
MoonRing       EQU 0Fh
Fawkrin        EQU 10h
FarFlame       EQU 1Fh
Logrim         EQU 12h
LakeMirrow     EQU 13h

; Terrain Types
Mountain       EQU 00h
Citadel        EQU 01h
Forest         EQU 02h
Henge          EQU 03h
Tower          EQU 04h
Village        EQU 05h
Downs          EQU 06h
Keep           EQU 07h
SnowHall       EQU 08h
Lake           EQU 09h
FrozenWaste    EQU 0Ah
Ruin           EQU 0Bh
Lith           EQU 0Ch
Cavern         EQU 0Dh
Army           EQU 0Eh
Plains         EQU 0Fh

; Races
DoomDark       EQU 00h
Free           EQU 01h
Fey            EQU 02h
Targ           EQU 03h
Wise           EQU 04h
Morkin         EQU 05h
Skulkrin1      EQU 06h
Dragon         EQU 07h

; Other constants
ArmyDoomDark                 EQU  0C8h
ArmyRiders                   EQU  000h
ArmyUshgarak                 EQU  006h
ArmyXajorkith                EQU  060h
CharacterIsAlive             EQU  000h
CharacterIsHidden            EQU  000h
CharFeyOnHorse               EQU  00Fh
Display_DoomDarks_Riders     EQU  002h
Display_DoomDarks_Warriors   EQU  009h
MaxIceFear                   EQU 01FFh
PalaceGuardBitFlag           EQU  080h
SelectedCorleth              EQU  002h
SelectedLuxor                EQU  000h
SelectedMorkin               EQU  001h
SelectedRorthron             EQU  003h
TimeDawn                     EQU  010h
TimeNight                    EQU  040h
TotalArmyCount               EQU  066h
TotalCharacterCount          EQU  020h
TotalDirectionsCount         EQU  008h
TotalDoomDarksEliteArmyCount EQU  080h
WeAreHidden                  EQU  000h

StartGame:
    CALL        Initialise
    JMP         MainGameLoop
    ds "the Lords of Midnight, (c) Copyright Mike Singleton. \r"
    ds "PC Version by Chris Wild. \r"
    ds "Version 1.10 - 06/11/03\r"
    dw SaveGameArea                            ; = "Lords of Midnight.  Save Game.\r\n"

; Customisable features!
;
; NOTE: DEFAULT = 0, any other value enables cheat!
PrinterFlag:       db 00h                      ; Printer Available
DirectionKeyStyle: db 00h                      ; Direction Key Style Uses Numeric Keypad
RecruitedAll:      db 00h                      ; All Characters are start Recruited
RecruitAnyone:     db 00h                      ; Any Character can recruit any other
MoveAndSave:       db 00h                      ; Force Single Slot Save, i.e. Save after every Move/Night/Fight etc.
HealthCheat:       db 00h                      ; Stop Health being reduced after movement
RecruitSoldiers:   db 00h                      ; Recruit soldiers of differing races from keep/citadel

; Keyboard controls.
;
; Customise these as desired
K_Escape:      db   01Bh
K_Move:        char 'q'
K_Look:        char 'e'
K_Think:       char 'r'
K_Choose:      char 't'
K_Night:       char 'u'
K_Save:        char 's'
K_Load:        char 'd'
K_Direction:   char 'l'
K_Printer:     char 'k'
K_Copy:        char 'z'
K_Select:      char 'm'
K_Yes:         char 'g'
K_No:          char 'j'
K_Luxor:       char 'c'
K_Morkin:      char 'v'
K_Corleth:     char 'b'
K_Rorthron:    char 'n'
K_RotateLeft:  char '-'
K_RotateRight: char '='

; The Select Character screen keys.
;
; You may only wish to change the first four keys to
; coincide with the main screen character selection keys.
;
; NOTE:
; Be careful not to use the SELECT key in this list, the
; keyboard routine can be a bit sensative.
;
CharKeysTable:
    ds "cvbn1234567890qwertyuiopasdfghjk"
K_CharPrev:
    char        '['
K_CharNext:
    char        ']'


ForceLoad:
    JMP         LoadGameFromTape


Select:
    CALL        DisplayPressAKey
    MOV         BX,K_RotateRight               ; = '='
    PUSH        BX
    XOR         AL,AL
L6086:
    MOV         [TempCharacterNo],AL
    CALL        CopyCharDetails
    POP         BX
    INC         BX
    PUSH        BX
    CMP         byte ptr [RecruitedAll],0x0    ; CHEAT:
    JNZ         LAB_0000_01d1
    MOV         AL,[CharAvailable]
    CMP         AL,0x1                         ; Can We Select?
    JNZ         L60BC                          ; No
LAB_0000_01d1:
    MOV         AH,0x23
    MOV         AL,[CharTimeOfDay]
    OR          AL,AL
    JNZ         LAB_0000_01dc
    MOV         AH,0x7c
LAB_0000_01dc:
    MOV         AL,[CharEnergyStatus]
    OR          AL,AL
    JNZ         LAB_0000_01e5
    MOV         AH,0x7f
LAB_0000_01e5:
    MOV         AL,[CharLifeStatus]
    OR          AL,AL
    JNZ         LAB_0000_01ee
    MOV         AH,0x7d
LAB_0000_01ee:
    MOV         AL,AH
    CALL        AddLiteralToBuffer
    MOV         AL,byte ptr [BX]
    CMP         AL,0x61
    JC          L60A0
    SUB         AL,0x20                        ; Make Uppercase
L60A0:
    CALL        AddLiteralToBuffer
    CALL        FirstNameToBuffer
    CALL        SetTokenToLowerCase
    CALL        FlushPrintBuffer
    MOV         AL,[ViewPoint_Row]
    CMP         AL,0x12
    JNZ         L60BC
    CALL        DefineViewPoint
    db 010h,002h,010h,01Fh,03Ah,000h
L60BC:
    MOV         AL,[TempCharacterNo]
    INC         AL
    CMP         AL,0x20
    JNZ         L6086
    CALL        Trans_Screen
    CALL        SelectCharacter
    POP         BX
    MOV         AL,[TempCharacterNo]
    MOV         [SaveCurChar],AL
    JMP         MainGameLoop


ResetLASTK:
    XOR         AL,AL
    MOV         [LASTK],AL
    RET


ClrScrDoMessage:
    PUSH        BX
    CALL        ClearAllScreen
    POP         BX
    CALL        FillPrintBuffer
    JMP         FlushPrintBuffer


AddressMinusB:
    CMP         byte ptr [HealthCheat],0x0     ; CHEAT:
    JZ          ReduceHealthAfterMovement      ; If cheat not enabled, reduce the health
    RET
ReduceHealthAfterMovement:
    MOV         AL,byte ptr [BX]
    SUB         AL,CH
    JNC         LAB_0000_0251
    XOR         AL,AL                          ; If less than Zero...Make Zero
LAB_0000_0251:
    MOV         byte ptr [BX],AL
    RET

; Save Game
SaveGameToTape:
    CMP         byte ptr [MoveAndSave],0x0
    JZ          LAB_0000_0261
    CALL        SAVE_SLOT_ONE
    JMP         MainGameLoop
LAB_0000_0261:
    MOV         byte ptr [LoadSaveFlag],0x0
    CALL        SelectLoadGame
    CMP         byte ptr [LoadSaveFlag],0xff
    JZ          LAB_0000_0273
    CALL        SA_BYTES
LAB_0000_0273:
    JMP         MainGameLoop

; Load Game
LoadGameFromTape:
    CMP         byte ptr [MoveAndSave],0x0
    JZ          LAB_0000_0283
    CALL        LOAD_SLOT_ONE
    JMP         MainGameLoop
LAB_0000_0283:
    MOV         byte ptr [LoadSaveFlag],0x1
    CALL        SelectLoadGame
    CMP         byte ptr [LoadSaveFlag],0xff
    JZ          LAB_0000_0298
    CALL        LD_BYTES
    CALL        CalcDoomDarksCitadels
LAB_0000_0298:
    JMP         MainGameLoop


ShouldWeSave:
    CMP         byte ptr [MoveAndSave],0x0
    JNZ         SAVE_SLOT_ONE
    RET


ClearAllScreen:
    CALL        DoWindowOne
    CALL        DefineViewPoint
    db 000h,005h,000h,01Fh,03Ah,000h
    RET


CheckGameKeys:
    CALL        CheckKeyCase
    CMP         AL,byte ptr [K_Escape]         ; = 01Bh
    JZ          Quit
    CMP         AL,byte ptr [K_Move]           ; = 'q'
    JZ          MoveForward
    CMP         AL,byte ptr [K_Look]           ; = 'e'
    JZ          MainGameLoop
    CMP         AL,byte ptr [K_Think]          ; = 'r'
    JZ          Think
    CMP         AL,byte ptr [K_Choose]         ; = 't'
    JZ          Choose
    CMP         AL,byte ptr [K_Night]          ; = 'u'
    JZ          Night
    CMP         AL,byte ptr [K_Save]           ; = 's'
    JZ          SaveGameToTape
    CMP         AL,byte ptr [K_Load]           ; = 'd'
    JZ          LoadGameFromTape
    CMP         AL,byte ptr [K_CharNext]       ; = ']'
    JZ          SelectNextChar
    CMP         AL,byte ptr [K_CharPrev]       ; = '['
    JZ          SelectPrevChar
    CMP         AL,byte ptr [K_Direction]      ; = 'l'
    JNZ         LAB_0000_030f
    NOT         byte ptr [DirectionKeyStyle]
    JMP         CheckGameKeys
LAB_0000_030f:
    CMP         AL,byte ptr [K_Printer]        ; = 'k'
    JNZ         LAB_0000_031b
    NOT         byte ptr [PrinterFlag]
    JMP         CheckGameKeys
LAB_0000_031b:
    CMP         AL,byte ptr [K_Copy]           ; = 'z'
    JNZ         LAB_0000_032b
    CALL        CopyScreen
    MOV         byte ptr [LASTK],0x0
    JMP         CheckGameKeys
LAB_0000_032b:
    CMP         AL,byte ptr [K_Select]         ; = 'm'
    JZ          Select
    CMP         AL,byte ptr [K_Luxor]          ; = 'c'
    JZ          ChooseLuxor
    CMP         AL,byte ptr [K_Morkin]         ; = 'v'
    JZ          ChooseMorkin
    CMP         AL,byte ptr [K_Corleth]        ; = 'b'
    JZ          ChooseCorleth
    CMP         AL,byte ptr [K_Rorthron]       ; = 'n'
    JZ          ChooseRorthron
    MOV         AL,[KeyReturnStatus]
    CMP         AL,0x1
    JNZ         LAB_0000_0355
    JMP         MainGameLoop::PollDirectionKeys
LAB_0000_0355:
    CMP         AL,0x3
    JNZ         LAB_0000_035c
    JMP         Choose::PollTableOfKeys
LAB_0000_035c:
    JMP         CheckGameKeys
ChooseLuxor:
    XOR         AL,AL
    JMP         SaveChoice
ChooseMorkin:
    MOV         AL,SelectedMorkin
    JMP         SaveChoice
ChooseCorleth:
    MOV         AL,SelectedCorleth
    JMP         SaveChoice
ChooseRorthron:
    MOV         AL,SelectedRorthron
SaveChoice:
    MOV         AH,byte ptr [SaveCurChar]
    MOV         [SaveCurChar],AL
    CALL        GetLatestCharInfo
    MOV         AL,[CharAvailable]             ; Bug Fix
    CMP         AL,0x1                         ; Available?
    JZ          MainGameLoop                   ; No
    MOV         byte ptr [SaveCurChar],AH
    JMP         MainGameLoop
SelectNextChar:
    MOV         AL,[SaveCurChar]
NextChar:
    INC         AL
    CMP         AL,0x20
    JNZ         LAB_0000_0392
    XOR         AL,AL
LAB_0000_0392:
    MOV         [TempCharacterNo],AL
    CALL        CopyCharDetails
    CMP         byte ptr [RecruitedAll],0x0
    JNZ         LAB_0000_03a8
    MOV         AH,byte ptr [CharAvailable]
    CMP         AH,0x1
    JNZ         NextChar
LAB_0000_03a8:
    MOV         [SaveCurChar],AL
    JMP         MainGameLoop
SelectPrevChar:
    MOV         AL,[SaveCurChar]
PrevChar:
    SUB         AL,0x1
    JNC         LAB_0000_03b7
    MOV         AL,0x1f
LAB_0000_03b7:
    MOV         [TempCharacterNo],AL
    CALL        CopyCharDetails
    CMP         byte ptr [RecruitedAll],0x0
    JNZ         LAB_0000_03cd
    MOV         AH,byte ptr [CharAvailable]
    CMP         AH,0x1
    JNZ         PrevChar
LAB_0000_03cd:
    MOV         [SaveCurChar],AL
    JMP         MainGameLoop

; End of day, the player turn is over.
Night:
    CALL        CheckSpecialConditions
    CALL        Bytes_Print_Buffer
    db 0FCh,071h,08Ah,0ABh,087h,000h           ; 'Night Has Fallen And The'
    db 0FCh,0ACh,0AEh,0ADh                     ; 'Foul Are Abroad'
    db 0FEh,021h,0FCh,0FFh                     ; '.'
    INC         word ptr [GameDays]
    MOV         BX,word ptr [GameDays]
    CALL        NumberToString
    MOV         AL,0x6e                        ; 'Day'
    CALL        PluralToken
    CALL        HaveOrHas
    MOV         BX,TokensEndOfDayMsg
    CALL        FillPrintBuffer
    CALL        FlushPrintBuffer
    CALL        Trans_Screen
    CALL        CalcDoomDarksCitadels
    CALL        CalcNightActivity
    CALL        ShouldWeSave
    MOV         AL,0x4
    MOV         [Print_Attr],AL
    CALL        Bytes_Print_Buffer
    db 0FBh,0FCh,08Ch,08Dh,08Eh,03Dh            ; 'Do You Want Dawn'
    db 0FEh,03Fh,0FFh                           ; '?'
    CALL        FlushPrintBuffer
    CALL        Trans_Screen
L6268:
    CALL        CheckKeyCase
    CMP         AL,byte ptr [K_Yes]            ; = 'g'
    JNZ         L6268
    CALL        GetLatestCharInfo              ; BUG FIX
    MOV         AL,[CharAvailable]
    CMP         AL,0x1                         ; Available?
    JZ          MainGameLoop                   ; Yes
    JMP         CheckGameKeys::ChooseLuxor


MainGameLoop:
    CALL        GetLatestCharInfo
    MOV         AL,[CharLifeStatus]
    CMP         AL,CharacterIsAlive            ; is the character still alive?
    JNZ         LAB_0000_0448                  ; Can't carry on if not!
    JMP         Think
LAB_0000_0448:
    CALL        DrawMainScreen
    CALL        PrintWhoEversInFront
    CALL        Trans_Screen
    CALL        GetLatestCharInfo
    MOV         AL,0x1
    MOV         [KeyReturnStatus],AL
    MOV         [LASTK],AL
PollDirectionKeys:
    CALL        CheckKeyCase
    MOV         CH,0xff
    CMP         AL,byte ptr [K_RotateRight]    ; = '='
    JZ          LAB_0000_046f
    MOV         CH,0x1
    CMP         AL,byte ptr [K_RotateLeft]     ; = '-'
    JNZ         LAB_0000_0478
LAB_0000_046f:
    MOV         AL,[CharLookDirection]
    SUB         AL,CH
    AND         AL,0x7
    JMP         SaveDir
LAB_0000_0478:
    CMP         AL,'1'
    JNS         LAB_0000_047f
    JMP         CheckGameKeys
LAB_0000_047f:
    CMP         AL,'9'
    JLE         LAB_0000_0486
    JMP         CheckGameKeys
LAB_0000_0486:
    SUB         AL,0x31                        ; Make keypress into direction
    CALL        SwapKeys
    MOV         CH,AL
    MOV         AL,[CurrentlyLooking]
    CMP         AL,CH                          ; Are we already looking that way?
    JNZ         LAB_0000_0496                  ; Yes
    JMP         PollDirectionKeys
LAB_0000_0496:
    MOV         AL,CH
SaveDir:
    MOV         [CharLookDirection],AL         ; Change View
    CALL        SaveCharDetails
    JMP         MainGameLoop


MoveForward:
    CALL        GetLatestCharInfo
    MOV         AL,[CharLifeStatus]
    CMP         AL,CharacterIsAlive
    JNZ         LAB_0000_04ad
    JMP         Think
LAB_0000_04ad:
    MOV         AL,[CanCharMoveForward]
    CMP         AL,0x0                         ; are there any reasons that should'nt move?
    JZ          LAB_0000_04b7
    JMP         Think
LAB_0000_04b7:
    MOV         AL,[CharEnergyStatus]
    CMP         AL,0x0                         ; Any Energy left?
    JNZ         LAB_0000_04c1
    JMP         Think
LAB_0000_04c1:
    MOV         AL,[CharTimeOfDay]
    CMP         AL,0x0                         ; Is it Night?
    JNZ         LAB_0000_04cb
    JMP         Think
LAB_0000_04cb:
    CMP         AL,TimeDawn                    ; Is It Dawn
    JZ          L62EF
    MOV         AL,[DoomDarksArmyPosInTable]
    CMP         AL,0x0                         ; Any of DoomDarks Army Here?
    JZ          L62EF
    JMP         Think
L62EF:
    MOV         AL,[CharHideFlag]
    CMP         AL,WeAreHidden                 ; Are we Hidden?
    JZ          LAB_0000_04e3
    JMP         Choose
LAB_0000_04e3:
    MOV         AL,[LocationObject]
    CMP         AL,NoObjectAtAll               ; Anything in this location?
    JZ          WalkForward                    ; Horses are exceptable
    CMP         AL,WildHorses
    JNC         WalkForward                    ; Between 1-5, we must fight so we can't Move
    JMP         Choose


WalkForward:
    MOV         BX,word ptr [LocationToMoveTo]
    MOV         word ptr [CharLocation],BX
    CALL        SaveCharDetails                ; Re-Write info
    CALL        SetResetCharsArmy
    MOV         BX,word ptr [LocationToMoveTo]
    MOV         word ptr [CurrentLocation],BX
    CALL        SetResetCharsArmy
    CALL        UpdateCharsVars
    MOV         CH,0x2                         ; Process Char energy drains!
    MOV         AL,[CurrentlyLooking]          ; Are we looking in a
    AND         AL,0x1                         ; Diagonaly direction?
    ADD         AL,CH                          ; Makes a difference if we are!
    MOV         CH,AL
    MOV         AL,[CharHasAHorse]
    CMP         AL,0x0                         ; Have We got a horse?
    JNZ         L632D                          ; Yes
    SHL         CH,0x1                         ; No. Makes a difference!
L632D:
    MOV         AL,[LocationFeature]
    CMP         AL,Downs                       ; Are we currently on downs?
    JNZ         L6335
    INC         CH                             ; Yes. Makes a difference
L6335:
    CMP         AL,Mountain                    ; Are we on Mountain?
    JNZ         L633D
    INC         CH                             ; OOOOOH!!!
    INC         CH                             ; Really makes a difference!
    INC         CH
    INC         CH
L633D:
    CMP         AL,Forest                      ; Are we in a forest
    JNZ         L634B                          ; No
    MOV         AL,[CharRace]
    CMP         AL,Fey                         ; Are we a Fey?
    JZ          L634B                          ; Yes
    INC         CH                             ; Makes a difference if we are not a fey but in a forest
    INC         CH
    INC         CH
L634B:
    MOV         AL,[TempCharacterNo]
    CMP         AL,FarFlame                    ; are we Farflame?
    JNZ         L6354                          ; No
    MOV         CH,0x1                         ; Yes. Then forget all the above!!!
L6354:
    MOV         BX,CharTimeOfDay
    CALL        AddressMinusB
    MOV         BX,CharEnergyStatus
    CALL        AddressMinusB
    MOV         BX,CharRidersEnergyStatus
    CALL        AddressMinusB
    MOV         BX,CharWarriorsEnergyStatus
    CALL        AddressMinusB
    CALL        SaveCharDetails
    CALL        ShouldWeSave
    JMP         MainGameLoop


SetResetCharsArmy:
    CALL        WorkOutLocationDetails
    MOV         AL,[TotalNoOfArmiesHere]
    JMP         SetLocationPlainsArmy          ; How many armies are still here or already here?


Think:
    CALL        GetLatestCharInfo
    CALL        CalcCharsCourage
DisplayThinkInfo:
    MOV         AL,[CharTimeOfDay]
    MOV         [TempVar],AL
    CALL        DrawMainFeature                ; Print the feature
    CALL        DisplayCharThink               ; Display the text
    CALL        DisplayThinkAgain
    CALL        Trans_Screen
    CALL        ResetLASTK
    JMP         CheckGameKeys


Choose:
    CALL        GetLatestCharInfo
    CALL        CalcCharsCourage
    MOV         AL,[CharLifeStatus]
    CMP         AL,CharacterIsAlive
    JNZ         LAB_0000_05a7                  ; Can't choose if the character is stone DEAD!
    JMP         Think
LAB_0000_05a7:
    CALL        DisplayPressAKey
    MOV         AL,0xff
    CALL        InitialiseChoices
    CALL        SetTokenToLowerCase
    CALL        FlushPrintBuffer
    CALL        Trans_Screen
    CALL        GetLatestCharInfo
    MOV         AL,0x3
    MOV         [KeyReturnStatus],AL
    CALL        ResetLASTK
PollTableOfKeys:
    CALL        CheckKeyCase
    MOV         CL,AL
    MOV         CH,0x7
    MOV         BX,ChooseKeyTable
L63C6:
    MOV         AL,byte ptr [BX]
    CMP         AL,CL
    JZ          SelectRoutine
    INC         BX
    DEC         CH
    JNZ         L63C6
    JMP         CheckGameKeys
SelectRoutine:
    SUB         AL,0x31
    ADD         AL,AL
    MOV         CL,AL
    MOV         CH,0x0
    MOV         BX,SelectRoutineJumpTable      ; = 5F1h
    ADD         BX,CX
    MOV         DL,byte ptr [BX]
    INC         BX
    MOV         DH,byte ptr [BX]
    XCHG        BX,DX
    PUSH        BX
    RET


CharacterSeek:
    XOR         AL,AL
    MOV         [WhatObjectFlag],AL
    MOV         [WhatObject],AL
    MOV         AL,[LocationObject]
    CMP         AL,WildHorses
    JNC         LAB_0000_0603                  ; if there's Nasties Here
    JMP         Think::DisplayThinkInfo
LAB_0000_0603:
    MOV         [WhatObject],AL                ; Current Object
    JNZ         CheckGuidance                  ; is there any Horses?
    MOV         AL,[CharRace]                  ; is there any Horses?
    CMP         AL,Skulkrin1                   ; Skulkrins & dragons
    JC          LAB_0000_0612                  ; Can't Have Horses!?
    JMP         Think::DisplayThinkInfo
LAB_0000_0612:
    MOV         AL,0x1
    MOV         [CharHasAHorse],AL
    MOV         [WhatObjectFlag],AL
    CALL        CalcCharsGraphicType
    JMP         FinishCharacterAlter
CheckGuidance:
    CMP         AL,Guidance
    JNZ         CheckShelter                   ; Not guidance
    CALL        RandomishNumber                ; Pick a Number
    AND         AL,0x1f                        ; between 0 - 31
    MOV         [WhatObjectFlag],AL            ; Store it away
    JMP         ClearObjectsLocation
CheckShelter:
    CMP         AL,Shelter
    JNZ         CheckHandOfDark
    CALL        IncrementStatusBy_10
    JMP         ClearObjectsLocation
CheckHandOfDark:
    CMP         AL,HandOfDark
    JNZ         CheckCupOfDreams
    XOR         AL,AL
    MOV         [CharTimeOfDay],AL
    JMP         ClearObjectsLocation
CheckCupOfDreams:
    CMP         AL,CupOfDreams
    JNZ         CheckWaterOfLife
    MOV         AL,TimeDawn
    MOV         [CharTimeOfDay],AL
    JMP         ClearObjectsLocation
CheckWaterOfLife:
    CMP         AL,WatersOfLife
    JNZ         CheckShadowsOfDeath
    MOV         AL,0x78
SetCharacterStatus:
    MOV         [CharEnergyStatus],AL
    MOV         [CharWarriorsEnergyStatus],AL
    MOV         [CharRidersEnergyStatus],AL
    JMP         ClearObjectsLocation
CheckShadowsOfDeath:
    CMP         AL,ShadowsOfDeath
    JNZ         CheckIceCrownBusters
    XOR         AL,AL
    JMP         SetCharacterStatus
DropTheObject:
    MOV         AL,[CharObjectCarrying]
    MOV         [LocationObject],AL
    MOV         AL,CH
    MOV         [CharObjectCarrying],AL
    JMP         FinishLocationAlter
ClearObjectsLocation:
    XOR         AL,AL
    MOV         [LocationObject],AL
FinishLocationAlter:
    CALL        AlterLocationContents
FinishCharacterAlter:
    CALL        SaveCharDetails
    CALL        ShouldWeSave
    JMP         Think::DisplayThinkInfo
CheckIceCrownBusters:
    MOV         CH,AL
    CMP         AL,IceCrown
    JNC         L6473                          ; Fawkrin,Farflame,Logrim,Lake Mirrow
    MOV         AL,[CharObjectCarrying]
    CMP         AL,IceCrown
    JC          DropTheObject                  ; What are we carrying other than IceCrown
    JMP         L647A
L6473:
    MOV         AL,[SaveCurChar]
    CMP         AL,SelectedMorkin              ; Is It Morkin?
    JZ          DropTheObject                  ; Yes
L647A:
    XOR         AL,AL
    MOV         [WhatObject],AL
    MOV         [WhatObjectFlag],AL
    JMP         Think::DisplayThinkInfo
HideCharacter:
    MOV         AL,[CharHideFlag]
    XOR         AL,0x1
    MOV         [CharHideFlag],AL
SaveDetails:
    CALL        SaveCharDetails
    CALL        ShouldWeSave
    JMP         Think


StartFight:
    MOV         AL,[FreeArmyPosInTable]
    CMP         AL,0x0
    JNZ         L64BB                          ; There's armies here
    MOV         AL,[CharObjectCarrying]
    SUB         AL,0xb
    MOV         CH,AL
    MOV         AL,[LocationObject]
    CMP         AL,CH
    JZ          L64BB
    CALL        CharacterLosesWhat
    MOV         AL,[CharLifeStatus]
    CMP         AL,CharacterIsAlive
    JNZ         L64BB
    MOV         AL,[LocationObject]
    MOV         [CharDeathStatus],AL
    JMP         SaveDetails
L64BB:
    MOV         AL,[LocationObject]
    MOV         [WhatObject],AL
    MOV         [WhatObjectFlag],AL
    XOR         AL,AL
    MOV         [LocationObject],AL
    JMP         CharacterSeek::FinishLocationAlter
RecruitCharacter:
    MOV         AL,[CharInLocation]
    MOV         [SaveCurChar],AL
    CALL        GetLatestCharInfo
    MOV         AL,0x1
    MOV         [CharAvailable],AL             ; Make character now Available
    CALL        SaveCharDetails
    CALL        ShouldWeSave
    JMP         MainGameLoop


RecruitOrGuardMen:
    MOV         AL,[HowManyGuardsThePlace]
    SUB         AL,CH                          ; Increase/Decrease
    MOV         [HowManyGuardsThePlace],AL
    MOV         AL,[WhoGuardsThePlace]
    CMP         AL,0x0                         ; Riders?
    JNZ         L64F6                          ; Yes deal with them.
    MOV         AL,[CharNoWarriors]            ; No
    ADD         AL,CH                          ; Change the amount of the characters Warriors accordingly.
    MOV         [CharNoWarriors],AL
    JMP         L64FD
L64F6:
    MOV         AL,[CharNoRiders]
    ADD         AL,CH                          ; Alter the amount of the characters riders.
    MOV         [CharNoRiders],AL
L64FD:
    CALL        StoreArmy_Table1
    JMP         SaveDetails


RecruitMen:
    MOV         CH,0x14
    JMP         RecruitOrGuardMen


Guardmen:
    MOV         CH,0xec
    JMP         RecruitOrGuardMen


Battle:
    JMP         WalkForward

; Display Whom we're looking at.
PrintWhoEversInFront:
    MOV         AL,0x17
    MOV         [Row],AL                       ; Starting Row
    MOV         AL,0x7f                        ; Assume day time
    MOV         [Window_Attr],AL
    XOR         AL,AL
    MOV         [Print_Ink],AL
    MOV         [Print_Mask],AL
    MOV         [PrintCharacterCount],AL
    MOV         AL,[CharTimeOfDay]             ; What Time?
    CMP         AL,0x0                         ; is it night
    JNZ         L6534
    MOV         AL,TimeNight                   ; This is Night
    MOV         [Window_Attr],AL
    INC         AL
    MOV         [Print_Ink],AL
L6534:
    MOV         BX,word ptr [DesirableLocation]; Where are we?
    MOV         word ptr [LocationToMoveTo],BX
    CALL        CheckLocationInfront
    MOV         CH,0x0                         ; Reset Count
    MOV         AL,[LocationFeature]           ; What's in front?
    CMP         AL,FrozenWaste
    JNZ         L6547                          ; No Skip next instruction
    INC         CH                             ; Increment Count
L6547:
    MOV         AL,[FreeArmyPosInTable]        ; How Many Armies of the free are here?
    CMP         AL,29                          ; Less than 29?
    JC          L654F                          ; Skip next instruction if so.
    INC         CH                             ; Increment Count.
L654F:
    MOV         AL,[DoomDarksArmyPosInTable]
    OR          AL,CH                          ; Combine the no of DoomDarks armies with the count
    MOV         [CanCharMoveForward],AL        ; Well if B<>0 then Sorry! No.
    MOV         AL,[NoInCharHereTable]
    CMP         AL,0x0                         ; How Many Characters are in front of us?
    JZ          AnyDoomDarksRidersInFront      ; None. Well Check Armies!
    XOR         AL,AL                          ; Start of with none in front.
L655E:
    MOV         [CharInHereTable],AL
    CALL        GetFromCharHereTable           ; Who Is here?
    MOV         AL,[CharGraphicType]
    CALL        PI                             ; Print him!
    MOV         AL,[NoInCharHereTable]         ; Check the size of table
    MOV         CH,AL
    MOV         AL,[CharInHereTable]
    INC         AL                             ; increment our count.
    CMP         AL,CH                          ; are we at the end?
    JNZ         L655E                          ; Loop if not.
AnyDoomDarksRidersInFront:
    MOV         BX,word ptr [DoomDarks_Riders]
    MOV         AL,BH                          ; Any Riders?
    OR          AL,BL
    CMP         AL,0x0
    MOV         AL,Display_DoomDarks_Riders    ; Set AL to Display Riders
    JZ          AnyDoomDarksWarriorsInFront    ; What A Label!
    JMP         PVIII                          ; Do Display
AnyDoomDarksWarriorsInFront:
    MOV         BX,word ptr [DoomDarks_Warriors]
    MOV         AL,BH                          ; Any Warriors?
    OR          AL,BL
    CMP         AL,0x0
    JZ          DisplayMeaniesEtc              ; No. Check Nasties.
    MOV         AL,Display_DoomDarks_Warriors  ; Set AL to Display Warriors
    JMP         PVIII                          ; Do Display
DisplayMeaniesEtc:
    MOV         AL,[LocationObject]
    CMP         AL,0x0                         ; Not Set
    JNZ         LAB_0000_07cc
    RET
LAB_0000_07cc:
    CMP         AL,0x6                         ; Greater than 6
    JC          LAB_0000_07d1
    RET
LAB_0000_07d1:
    DEC         AL                             ; Minus one
    MOV         BX,MeaniesDataTable            ; Point to Table
    MOV         CL,AL
    MOV         CH,0x0                         ; Get info from table
    ADD         BX,CX
    MOV         AL,byte ptr [BX]
    CMP         AL,0x6
    JZ          PII
    JMP         PIV

; Do Display
PVIII:
    CALL        PIV


PIV:
    CALL        PII


PII:
    CALL        PI

; Print a character to the screen
PI:
    MOV         [CharacterToPrint],AL
    PUSH        AX
    PUSHF
    MOV         AL,[PrintCharacterCount]       ; How Many So Far?
    MOV         CL,AL
    INC         AL                             ; Printing one more
    CMP         AL,0x9                         ; Loop Eight Times MAX.
    JNC         L65CD
    MOV         [PrintCharacterCount],AL
    MOV         CH,0x0
    MOV         BX,PositionTable               ; Reference Position Table
    ADD         BX,CX
    MOV         AL,byte ptr [BX]
    MOV         [Column],AL                    ; get the Column Position
    CALL        DisplayCharacter
L65CD:
    POPF
    POP         AX
    RET


CalcCharsCourage:
    MOV         BX,word ptr [IceFear]
    MOV         AL,0x7
    CALL        HowManyUnitsOf_A
    MOV         AL,[CharCowardess]
    SUB         AL,BL
    JNC         L65EB
    XOR         AL,AL
L65EB:
    SHR         AL,0x1
    SHR         AL,0x1
    SHR         AL,0x1
    CMP         AL,0x8
    JC          L65F7                          ; Can't be more than eight
    MOV         AL,0x7                         ; must be seven if it is.
L65F7:
    MOV         [CharCourageStatus],AL
    CALL        SaveCharDetails
    MOV         CH,0x10
    MOV         AL,[LocationObject]
    CMP         AL,NoObjectAtAll
    JZ          L660B
    CMP         AL,Shelter
    JNC         L660B
    MOV         CH,AL
L660B:
    MOV         AL,CH
    MOV         [WhatObject],AL
    XOR         AL,AL
    MOV         [WhatObjectFlag],AL
    RET


CalcDoomDarksCitadels:
    XOR         AL,AL
    MOV         [DoomDarksCitadels],AL
L6618:
    MOV         [Army_Details],AL
    CALL        GetArmyDetails
    MOV         AL,[WhoseRaceIsArmy]
    CMP         AL,DoomDark                    ; Army is DoomGuard?
    JNZ         L6640                          ; No
    MOV         BX,word ptr [ArmyLocation]     ; Yes
    MOV         word ptr [WorkingLocation],BX
    CALL        CalcMapLocation
    MOV         CH,0x5
    MOV         AL,[LocationFeature]
    CMP         AL,Citadel
    JZ          L6639
    MOV         CH,0x2
L6639:
    MOV         AL,[DoomDarksCitadels]
    ADD         AL,CH
    MOV         [DoomDarksCitadels],AL
L6640:
    MOV         AL,[Army_Details]              ; get next army
    INC         AL
    CMP         AL,TotalArmyCount              ; is it the last?
    JNZ         L6618                          ; No. Loop
    RET


SetLocSpecial:
    MOV         word ptr [WorkingLocation],BX
    CALL        CalcMapLocation
    MOV         AL,0x80                        ; Set The Bit
    MOV         [LocSpecialFlag],AL
    JMP         AlterLocationContents          ; Write it


ResetLocSpecial:
    MOV         word ptr [CurrentLocation],BX
    MOV         word ptr [WorkingLocation],BX
    CALL        CalcMapLocation
    MOV         AL,[LocSpecialFlag]
    PUSH        AX                             ; Store it away for a mo
    PUSHF
    XOR         AL,AL                          ; Reset The Bit
    MOV         [LocSpecialFlag],AL
    CALL        AlterLocationContents          ; Write the Change
    POPF
    POP         AX
    CMP         AL,0x0                         ; Was it actually Set?
    JNZ         LAB_0000_08b8                  ; No
    RET
LAB_0000_08b8:
    CALL        WorkOutLocationDetails
    MOV         AL,[DoomDarksArmyPosInTable]
    CMP         AL,0x0                         ; Are there any of doomdarks here?
    JNZ         LAB_0000_08c3                  ; if Not then return
    RET
LAB_0000_08c3:
    JMP         ItsKillingTime                 ; Yes - we must Battle


CalcNightActivity:
    XOR         AL,AL
L667C:
    MOV         [TempCharacterNo],AL           ; Character to deal with
    CALL        AlterCharDetails               ; Update all his status's
    MOV         AL,[TempCharacterNo]
    INC         AL                             ; next Character
    CMP         AL,TotalCharacterCount         ; is it the last?
    JNZ         L667C                          ; No. Loop until
    XOR         AL,AL                          ; Start with Luxor Again
L668B:
    MOV         [TempCharacterNo],AL
    CALL        CopyCharDetails                ; Mark all characters onto the map
    MOV         AL,[CharLifeStatus]
    CMP         AL,CharacterIsAlive            ; is character alive?
    JZ          L66A5                          ; if not can't deal with
    MOV         AL,[CharHideFlag]
    CMP         AL,CharacterIsHidden           ; is character hidden?
    JNZ         L66A5                          ; if so can't deal with
    MOV         BX,word ptr [CharLocation]     ; Location at
    CALL        SetLocSpecial                  ; Set the special flag
L66A5:
    MOV         AL,[TempCharacterNo]
    INC         AL                             ; Next Character
    CMP         AL,TotalCharacterCount         ; are we on the last
    JNZ         L668B                          ; loop if not
    XOR         AL,AL                          ; Start with army 0
L66AE:
    MOV         [Army_Details],AL
    CALL        GetArmyDetails                 ; Mark all the free armies on the map
    MOV         AL,[WhoseRaceIsArmy]
    CMP         AL,DoomDark                    ; Does this army belonging to DoomDark
L66C1:
    JZ          LAB_0000_0913                  ; If so can't deal with it yet.
    MOV         BX,word ptr [ArmyLocation]     ; Where is the army
    CALL        SetLocSpecial                  ; Set special flag
LAB_0000_0913:
    MOV         AL,[Army_Details]
    INC         AL                             ; Next army
    CMP         AL,TotalArmyCount              ; Last One
    JNZ         L66AE                          ; Loop if not
    CALL        ProcessAllArmies
    XOR         AL,AL                          ; Start with Luxor again
    MOV         [NoOfDeathsDescribed],AL
L66D0:
    PUSH        AX                             ; Remove All Characters
    PUSHF
    MOV         [TempCharacterNo],AL           ; from the map????
    CALL        CopyCharDetails                ; Reset the Special Location flag
    MOV         BX,word ptr [CharLocation]     ; at the location that
    CALL        ResetLocSpecial                ; the character is at!
    POPF
    POP         AX
    INC         AL
    CMP         AL,0x20
    JNZ         L66D0
    XOR         AL,AL                          ; Start with Army 0
L66E4:
    PUSH        AX                             ; Remove all armies from
    PUSHF
    MOV         [Army_Details],AL              ; the map
    CALL        GetArmyDetails                 ; Reset the Special Location
    MOV         BX,word ptr [ArmyLocation]     ; flag at the location that
    CALL        ResetLocSpecial                ; the army is at!
    POPF
    POP         AX
    INC         AL
    CMP         AL,0x66
    JNZ         L66E4
    CALL        CopyScreen
    JMP         UpdateCharsVars


AlterCharDetails:
    CALL        CopyCharDetails
    MOV         AL,[CharTimeOfDay]             ; What time of day is it
    SHR         AL,0x1                         ; Multiply by 2
    MOV         CH,AL
    CALL        IncrementStatusBy_B            ; Increment all status's
    MOV         AL,TimeDawn                    ; make Dawn
    MOV         [CharTimeOfDay],AL
    MOV         AL,[CharLifeStatus]
    CMP         AL,CharacterIsAlive            ; is the character alive?
    JZ          L672A                          ; can't process if Not
    MOV         AL,0xff
    MOV         [CharBattleStatus],AL
    INC         AL
; Reset all status's
    MOV         [CharRidersLost],AL
    MOV         [CharWarriorsLost],AL
    MOV         [CharSlew],AL
    MOV         [CharRidersSlew],AL
    MOV         [CharWarriorsSlew],AL
L672A:
    JMP         SaveCharDetails


AddOn_B:
    ADD         AL,CH
    CMP         AL,0x80
    JNC         LAB_0000_0993
    RET
LAB_0000_0993:
    MOV         AL,0x7f
    RET


IncrementStatusBy_10:
    MOV         CH,0x10


IncrementStatusBy_B:
    MOV         AL,[CharEnergyStatus]
    ADD         AL,0x9
    CALL        AddOn_B
    MOV         [CharEnergyStatus],AL
    MOV         AL,[CharRidersEnergyStatus]
    ADD         AL,0x6
    CALL        AddOn_B
    MOV         [CharRidersEnergyStatus],AL
    MOV         AL,[CharWarriorsEnergyStatus]
    ADD         AL,0x4
    CALL        AddOn_B
    MOV         [CharWarriorsEnergyStatus],AL
    RET


DoReverseSwap:
    CMP         AL,0x20
    JC          LAB_0000_09bf
    RET
LAB_0000_09bf:
    XCHG        BX,DX
    JMP         CopyCharDetails::LFC64


CheckLocBreakCrown:
    MOV         AL,CH
    CMP         AL,BH
    JZ          LAB_0000_09cb
    RET
LAB_0000_09cb:
    MOV         AL,CL
    CMP         AL,BL
    JZ          LAB_0000_09d2
    RET
LAB_0000_09d2:
    MOV         AL,0x1
    MOV         [IceCrownFlag],AL
    RET


FindSpecificChars:
    MOV         AL,0x2
L8E8E:
    MOV         [TempCharacterNo],AL
    PUSH        CX
    CALL        CopyCharDetails
    POP         CX
    MOV         AL,[CharAvailable]
    CMP         AL,CH
    JNZ         L8EA6
    XOR         AL,0x2
    MOV         [CharAvailable],AL
    PUSH        CX
    CALL        SaveCharDetails
    POP         CX
L8EA6:
    MOV         AL,[TempCharacterNo]
    INC         AL
    CMP         AL,0x20
    JNZ         L8E8E
    RET


CheckSpecialConditions:
    CALL        DoWindowFive
    XOR         AL,AL
    MOV         [LuxorMorkinFlag],AL
    MOV         [IceCrownFlag],AL
    MOV         [TempCharacterNo],AL           ; Check Luxor
    CALL        CopyCharDetails
    MOV         AL,[CharLifeStatus]
    CMP         AL,CharacterIsAlive            ; Is He Dead?
    JNZ         L8EEE                          ; Yes
    INC         AL
    MOV         [LuxorMorkinFlag],AL           ; Set Flag to say Luxor is dead.
    MOV         AL,[CharObjectCarrying]
    CMP         AL,MoonRing                    ; Was luxor carrying the Moon Ring?
    JNZ         L8EEE                          ; No
    XOR         AL,AL
    MOV         [CharObjectCarrying],AL        ; Drop Moon Ring.
    CALL        SaveCharDetails
    MOV         BX,word ptr [CharLocation]
    MOV         word ptr [WorkingLocation],BX
    CALL        CalcMapLocation
    MOV         AL,MoonRing
    MOV         [LocationObject],AL            ; Put Moon Ring in current Location
    CALL        AlterLocationContents
    MOV         CH,0x1                         ; Toggle all commanded Lords
    CALL        FindSpecificChars              ; as we can't use the.
L8EEE:
    MOV         AL,SelectedMorkin
    MOV         [TempCharacterNo],AL           ; Check Morkin
    CALL        CopyCharDetails
    MOV         AL,[CharLifeStatus]
    CMP         AL,CharacterIsAlive            ; Is he Dead?
    JNZ         L8F07                          ; Yes
    MOV         AL,[LuxorMorkinFlag]           ; Set Flag to Say so
    XOR         AL,0x2
    MOV         [LuxorMorkinFlag],AL
    JMP         CheckGameOver
L8F07:
    MOV         AL,[CharObjectCarrying]
    CMP         AL,MoonRing                    ; is Morkin carrying the Moon Ring?
    JNZ         L8F15
    MOV         CH,0x3                         ; Toggle All Commanded Lords
    CALL        FindSpecificChars              ; so we can use them
    JMP         CheckGameOver
L8F15:
    CMP         AL,IceCrown                    ; Has Morkin got the Ice Crown
    JNZ         CheckGameOver                  ; Yes
    MOV         CX,word ptr [CharLocation]     ; is he at Lake Mirrow?
    MOV         BX,0x1209
    CALL        CheckLocBreakCrown
    MOV         AL,0x1d                        ; Check Fawkrin,Lorgrim,Farlame
L8F25:
    MOV         [TempCharacterNo],AL
    PUSH        CX
    CALL        CopyCharDetails
    POP         CX
    MOV         AL,[CharLifeStatus]
    CMP         AL,CharacterIsAlive            ; Character still alive?
    JZ          L8F3A                          ; if not then next character
    MOV         BX,word ptr [CharLocation]     ; Check if character is at
    CALL        CheckLocBreakCrown             ; the same location as the Crown!
L8F3A:
    MOV         AL,[TempCharacterNo]
    INC         AL
    CMP         AL,TotalCharacterCount         ; Last Character?
    JNZ         L8F25                          ; Loop if not
CheckGameOver:
    MOV         AL,[LuxorMorkinFlag]
    CMP         AL,0x3                         ; Luxor & Morkin Dead
    JZ          LuxorIsDead
    CMP         AL,0x2                         ; Morkin Dead
    JNZ         L8F5C
    MOV         AL,ArmyXajorkith               ; Army at Xajorkith
    MOV         [Army_Details],AL
    CALL        GetArmyDetails                 ; Get the army
    MOV         AL,[WhoseRaceIsArmy]
    CMP         AL,DoomDark                    ; is the army DoomGuard?
    JZ          XajorkithFallen                ; If so then Xajorkith has fallen
L8F5C:
    MOV         AL,ArmyUshgarak                ; Army at Ushgarak
    MOV         [Army_Details],AL
    CALL        GetArmyDetails                 ; get the army
    MOV         AL,[WhoseRaceIsArmy]
    CMP         AL,DoomDark                    ; is the army DoomGuard
    JNZ         UshgarakFallen                 ; if not then Ushgarak has fallen
    MOV         AL,[IceCrownFlag]
    CMP         AL,0x0                         ; check if the Ice Crown is still in the game!
    JNZ         IceCrownDestroyed
    RET
LuxorIsDead:
    CALL        Bytes_Print_Buffer
    db 0FCh,072h,070h,008h,0FFh                 ; 'Luxor Is Dead'
    JMP         MorkinIsDead
XajorkithFallen:
    CALL        Bytes_Print_Buffer
    db 0FCh,035h,08Ah,0ABh,0FFh                ; 'Xajorkith Has Fallen'
MorkinIsDead:
    CALL        Bytes_Print_Buffer
    db 087h,0FCh,073h,070h,008h,0FEh,02Eh      ; 'And Morkin Is Dead.'
    db 0FCh,0CAh,05Ch,0FCh,00Ch,0FDh,0A0h      ; 'Victory To DoomDark.'
    db 0FEh,021h,0FFh
    JMP         EndOfGame
UshgarakFallen:
    CALL        Bytes_Print_Buffer
    db 0FCh,00Fh,08Ah,0ABh,0FFh                 ; 'Ushgarak Has Fallen'
    JMP         DoVictoryMessage
IceCrownDestroyed:
    CALL        Bytes_Print_Buffer
    db 0FCh,000h,0FCh,09Bh                      ; 'The Ice'
    db 0FCh,0EAh,08Ah,08Bh                      ; 'Crown Has Been'
    db 0EBh,0FEh,065h,0FEh,064h,0FFh            ; 'Destroyed'
DoVictoryMessage:
    CALL        Bytes_Print_Buffer
    db 0FEh,02Eh,0FCh,0CAh,05Ch,000h            ; '.Victory To The'
    db 0FCh,09Fh,0FEh,021h,0FFh                 ; 'Free!'
EndOfGame:
    CALL        FlushPrintBuffer
    CALL        Trans_Screen
    CALL        CopyScreen
L8FCB:
    CALL        CheckKeyCase
    CMP         AL,byte ptr [K_Load]           ; = 'd'
    JNZ         L8FCB
    POP         BX
    MOV         BX,ForceLoad
    PUSH        BX=>ForceLoad
    RET


DescribeBattle:
    CALL        Bytes_Print_Buffer
    db 0FCh,054h,000h,0FCh,0C3h,040h,0FFh       ; 'In The Battle Of'
    MOV         AL,[CharBattleArea]
    MOV         [LocationArea],AL
    CALL        DescribeLocationArea           ; Where?
    CALL        CommaToBuffer
    MOV         CH,0x0
    MOV         AL,[CharNoRiders]
    CMP         AL,0x0
    JNZ         LDFD1
    MOV         CL,AL
    MOV         AL,[CharRidersLost]
    CMP         AL,CL
    JNZ         LDFD1
    INC         CH
LDFD1:
    MOV         AL,[CharNoWarriors]
    CMP         AL,0x0
    JNZ         LDFE1
    MOV         CL,AL
    MOV         AL,[CharWarriorsLost]
    CMP         AL,CL
    JNZ         LDFE1
    INC         CH
    INC         CH
LDFE1:
    MOV         AL,CH
    MOV         [WhichMenDidCharLose],AL
    CMP         AL,0x3
    JZ          LE013
    CALL        FirstNameToBuffer
    MOV         AL,0x7                         ; 'Lost'
    CALL        A_IntoPrintBuffer
    MOV         AL,[WhichMenDidCharLose]
    CMP         AL,0x1
    JZ          LE00A
    MOV         AL,[CharRidersLost]
    CALL        HowManyRiders
    MOV         AL,[WhichMenDidCharLose]
    CMP         AL,0x2
    JZ          LE010
    MOV         AL,0x87                        ; 'And'
    CALL        A_IntoPrintBuffer
LE00A:
    MOV         AL,[CharWarriorsLost]
    CALL        HowManyWarriors
LE010:
    CALL        StopToBuffer
LE013:
    CALL        FirstNameToBuffer
    CALL        Bytes_Print_Buffer
    db 0C6h,0C7h,0FFh                           ; 'Alone Slew'
    MOV         AL,[CharSlew]
    CALL        DisplayHowManyOf
    CALL        Bytes_Print_Buffer
    db 040h,000h,0FCh,0C8h,0FEh,02Eh,0FFh       ; 'Of The Enemy.'
    MOV         AL,[WhichMenDidCharLose]
    CMP         AL,0x3
    JZ          LE064
    CMP         AL,0x1
    JZ          LE04A
    CALL        Bytes_Print_Buffer
    db 0FCh,0CFh,0C4h,0FEh,073h,0C7h,0FFh       ; 'His Riders Slew'
    MOV         AL,[CharRidersSlew]
    CALL        DisplayHowManyOf
    CALL        StopToBuffer
LE04A:
    MOV         AL,[WhichMenDidCharLose]
    CMP         AL,0x2
    JZ          LE064
    CALL        Bytes_Print_Buffer
    db 0FCh,0CFh,0C5h,0FEh,073h,0C7h,0FFh       ; 'His Warriors Slew'
    MOV         AL,[CharWarriorsSlew]
    CALL        DisplayHowManyOf
    CALL        StopToBuffer
LE064:
    MOV         AL,[CharBattleStatus]
    CMP         AL,0x0
    JZ          BattleStillOn
    CALL        Bytes_Print_Buffer
    db 0FCh,0CAh,0CBh,05Ch,000h,0FCh,0FFh       ; 'Victory Went To The'
    MOV         AL,[CharBattleStatus]
    CALL        A_IntoPrintBuffer
    JMP         PlinkToBuffer
BattleStillOn:
    CALL        Bytes_Print_Buffer
    db 0FCh,000h,0C3h,092h,0FEh,073h,0FEh,021h,0FFh ; 'The Battle Continues!'
    RET


HowManyWarriors:
    MOV         BL,AL
    MOV         BH,0x0


HowManyWarriors_1:
    CALL        NumberOf
    MOV         AL,0xc5                        ; 'Warrior'
LE093:
    CALL        A_IntoPrintBuffer
    JMP         SToBuffer


HowManyRiders:
    MOV         BL,AL
    MOV         BH,0x0


HowManyRiders_1:
    CALL        NumberOf
    MOV         AL,0xc4                        ; 'Rider'
    JMP         HowManyWarriors_1::LE093


Mult_HL_5:
    PUSH        BX
    ADD         BX,BX
    ADD         BX,BX
    POP         DX
    ADD         BX,DX
    RET


DisplayHowManyOf:
    MOV         BL,AL
    MOV         BH,0x0
    CMP         AL,0x0
    JNZ         NumberOf
    MOV         AL,0xcc                        ; 'None'
    JMP         A_IntoPrintBuffer


NumberOf:
    CALL        Mult_HL_5
    JMP         NumberToString


HowMuch_What:
    CMP         AL,0x5
    JNC         LE0C0
    MOV         CH,CL
LE0C0:
    MOV         CL,0xd1
    CMP         AL,0x0
    JZ          UtterlyAffected
    CMP         AL,0x7
    JZ          UtterlyAffected
    CMP         AL,0x1
    JZ          VeryAffected
    CMP         AL,0x6
    JZ          VeryAffected
    CMP         AL,0x3
    JZ          QuiteAffected
    CMP         AL,0x4
    JZ          SlightlyAffected
    JMP         LE0E3
QuiteAffected:
    INC         CL
SlightlyAffected:
    INC         CL
VeryAffected:
    INC         CL
UtterlyAffected:
    MOV         AL,CL
    CALL        A_IntoPrintBuffer
LE0E3:
    MOV         AL,CH
LE0E4:
    JMP         A_IntoPrintBuffer


ReportCharStatus:
    PUSH        AX
    PUSHF
    SHR         AL,0x1
    SHR         AL,0x1
    SHR         AL,0x1
    SHR         AL,0x1
    MOV         CH,0xd6                        ; 'Invigorated'
    MOV         CL,0xd5                        ; 'Tired'
    CALL        HowMuch_What
    POPF
    POP         AX
    CMP         AL,0x0
    JZ          LAB_0000_0c9a
    RET
LAB_0000_0c9a:
    CALL        Bytes_Print_Buffer
    db 087h,0D8h,092h,0FFh                      ; 'And Cannot Continue'
    RET


DisplayArmyStatus:
    CALL        FullCharTitle
    MOV         AL,0xd7                        ; 'Command'
    CALL        A_IntoPrintBuffer
    CALL        SToBuffer
    MOV         DH,0x0
    MOV         DL,0x87                        ; 'And'
    MOV         AL,[CharNoRiders]
    CMP         AL,0x0
    JZ          LE11A                          ; No Riders
    INC         DH
LE11A:
    MOV         AL,[CharNoWarriors]
    CMP         AL,0x0
    JZ          LE123                          ; No Warriors
    INC         DH
    INC         DH
LE123:
    MOV         AL,DH
    CMP         AL,0x0
    JZ          LE12E                          ; None of Anything
    CMP         AL,0x3
    JZ          LE12E                          ; Riders & Warriors
    MOV         DL,0xce                        ; 'But'
LE12E:
    MOV         AL,[CharNoWarriors]
    PUSH        DX
    CALL        HowManyWarriors
    POP         DX
    PUSH        DX
    MOV         AL,DL
    CALL        A_IntoPrintBuffer
    MOV         AL,[CharNoRiders]
    CALL        HowManyRiders
    CALL        StopToBuffer
    POP         DX
    MOV         AL,DH
    CMP         AL,0x0                         ; None
    JNZ         LAB_0000_0cf0
    RET
LAB_0000_0cf0:
    CMP         AL,0x1                         ; Riders or Warriors?
    JZ          DisplayRidersStatus
DisplayWarriorsStatus:
    CALL        Bytes_Print_Buffer
    db 0FCh,0CFh,0C5h,0FEh,073h,0AEh,0FFh       ; 'His Warriors Are'
    MOV         AL,[CharWarriorsEnergyStatus]
    CALL        ReportCharStatus
    CALL        StopToBuffer
DisplayRidersStatus:
    MOV         AL,DH
    CMP         AL,0x2
    JNZ         LAB_0000_0d0e
    RET
LAB_0000_0d0e:
    CALL        Bytes_Print_Buffer
    db 0FCh,0CFh,0C4h,0FEh,073h,0AEh,0FFh       ; 'His Riders Are'
    MOV         AL,[CharRidersEnergyStatus]
    CALL        ReportCharStatus
    JMP         StopToBuffer


HowManyUnitsOf:
    MOV         AL,0xa


HowManyUnitsOf_A:
    MOV         CH,0x10
    MOV         CL,AL
    XOR         AL,AL
LE17D:
    ADC         BX,BX
    RCL         AL,0x1                         ; A*2
    CMP         AL,CL
    JC          LE185                          ; A<C?
    SUB         AL,CL
LE185:
    CMC
    DEC         CH
    JNZ         LE17D
    ADC         BX,BX
    RET


BreakNumberInParts:
    CALL        HowManyUnitsOf
    MOV         [NoOfUnits],AL
    CALL        HowManyUnitsOf
    MOV         [NoOfTens],AL
    CALL        HowManyUnitsOf
    MOV         [NoOfHundreds],AL
    CALL        HowManyUnitsOf
    MOV         [NoOfThousands],AL
    CALL        HowManyUnitsOf
    MOV         [NoOfMillions],AL
    RET


CalcBaseNumber:
    MOV         AL,CH
    CMP         AL,0x0
    JZ          LessThanTen
    CMP         AL,0x1
    JZ          LessThanTwenty
    CMP         AL,0x2
    JZ          LessThanThirty
    SUB         AL,0x3                         ; Thirty Over
    MOV         DL,AL
    MOV         DH,0x0
    MOV         BX,NumberTable2
    ADD         BX,DX
    MOV         AL,byte ptr [BX]
    CALL        A_IntoPrintBuffer
    MOV         AL,CH
    CMP         AL,0x8                         ; Special Eighty
    JZ          AddTheY
    MOV         AL,0x74                        ; AddThe
    CALL        AddLiteralToBuffer
AddTheY:
    MOV         AL,0x79
    CALL        AddLiteralToBuffer
LastPartOfNumber:
    MOV         AL,CL
    CMP         AL,0x0
    JNZ         LAB_0000_0d8f                  ; Any more?
    RET
LAB_0000_0d8f:
    CALL        Bytes_Print_Buffer
    db 0FEh,02Dh,0FDh,0FFh                      ; '-'
LessThanTen:
    MOV         AL,CL


BaseNumber:
    ADD         AL,0x62
    JMP         A_IntoPrintBuffer
LessThanThirty:
    MOV         AL,0xb9                        ; 'Twenty'
    CALL        A_IntoPrintBuffer
    JMP         LastPartOfNumber
LessThanTwenty:
    MOV         DL,CL
    MOV         DH,0x0                         ; DE=Number
    MOV         BX,NumberTable1                ; HL=Table
    ADD         BX,DX                          ; Position in table
    MOV         AL,byte ptr [BX]               ; A=Token
    CALL        A_IntoPrintBuffer
    MOV         AL,CL
    CMP         AL,0x3
    JNS         LAB_0000_0db9                  ; Ends Less Than Three
    RET
LAB_0000_0db9:
    CMP         AL,0x8                         ; But No Eight
    JZ          LE203
    MOV         AL,0xb8                        ; 'Teen' - add to the End
    JMP         AddTokenWithConnect
LE203:
    CALL        Bytes_Print_Buffer             ; Special case for EightEEN
    db 0FEh,065h,0FEh,065h,0FEh,06Eh,0FFh      ; 'een'
    RET


NumberToString:
    CALL        BreakNumberInParts
    MOV         AL,0x1
    MOV         [QuantityFlag],AL
    MOV         CX,word ptr [NoOfThousands]
    MOV         DX,word ptr [NoOfUnits]
    MOV         AL,[NoOfHundreds]
    ADD         AL,CH                          ; Add up all parts
    ADD         AL,CL                          ; to see if there
    MOV         BH,AL                          ; is a number at all.
    MOV         AL,DL
    ADD         AL,DH                          ; H=ThousandsMillions
    MOV         BL,AL                          ; L=TensUnits
    ADD         AL,BH
    CMP         AL,0x0                         ; Any amount?
    JNZ         TensHundredsThousands
    MOV         AL,0xbc                        ; 'No'
    JMP         A_IntoPrintBuffer
TensHundredsThousands:
    CMP         AL,0x1
    JNZ         GreaterThanHundred
    CMP         AL,DL
    JNZ         GreaterThanHundred
    MOV         AL,0x0
    MOV         [QuantityFlag],AL
GreaterThanHundred:
    MOV         AL,BH
    CMP         AL,0x0                         ; is it greater than 100?
    JZ          CalcTensUnits                  ; No
    MOV         AL,0x0
    ADD         AL,CH                          ; How Many Thousands
    ADD         AL,CL
    CMP         AL,0x0                         ; Any At all?
    JZ          AnyHundreds ; No
    PUSH        BX
    CALL        CalcBaseNumber
    POP         BX
    MOV         AL,0xbb                        ; 'Thousand'
    CALL        A_IntoPrintBuffer
AnyHundreds:
    MOV         AL,[NoOfHundreds]
    CMP         AL,0x0
    JZ          AnyExtras
    CALL        BaseNumber
    MOV         AL,0xba                        ; 'Hundred'
    CALL        A_IntoPrintBuffer
AnyExtras:
    MOV         AL,BL
    CMP         AL,0x0
    JNZ         AddAnAnd
    RET
AddAnAnd:
    MOV         AL,0x87
    CALL        A_IntoPrintBuffer
CalcTensUnits:
    MOV         CX,word ptr [NoOfUnits]
    JMP         CalcBaseNumber


HaveOrHas:
    MOV         AL,[QuantityFlag]
    CMP         AL,0x0
    JZ          ItsHas
    MOV         AL,0xbd                        ; ItsHave
    JMP         A_IntoPrintBuffer
ItsHas:
    MOV         AL,0x8a
    JMP         A_IntoPrintBuffer


MoveTowardsSomeOne:
    MOV         CH,0x0
    MOV         CL,CH
    MOV         AL,[CurrentLocation]           ; Compare Row of SomeOne
    MOV         DH,AL                          ; against Row of Army
    MOV         AL,[ArmyToMoveLocation]
    CMP         AL,DH
    JZ          LE2AB                          ; If it's the same then no need to alter
    JNC         LAB_0000_0e65                  ; If their's is less then do decrement
    JMP         LE2AA
LAB_0000_0e65:
    INC         CH                             ; Increment Army's Row count,
    JMP         LE2AB                          ; Skip Next instruction
LE2AA:
    DEC         CH                             ; Decrement Army's Row count
LE2AB:
    MOV         AL,[CurrentLocation+1]         ; Compare Column of SomeOne
    MOV         DH,AL                          ; against column of army.
    MOV         AL,[ArmyToMoveLocation+1]
    CMP         AL,DH
    JZ          LE2BB                          ; If it's the same then no need to alter
    JC          LE2BA                          ; If their's is less then Do Decrement
    INC         CL                             ; Increment army's column count
    JMP         LE2BB                          ; Skip Next instruction
LE2BA:
    DEC         CL                             ; Decrement army's column count
LE2BB:
    MOV         BX,DirectionLookTable          ; Start Looking North
    MOV         AL,0x0
LE2C0:
    MOV         [CurrentlyLooking],AL
    MOV         AL,byte ptr [BX]               ; Reference the DirectionLookTable
    INC         BX
    CMP         AL,CH                          ; is this the Row move we want?
    JNZ         LE2CC                          ; No. Think about another direction.
    MOV         AL,byte ptr [BX]
    CMP         AL,CL                          ; is this the Column move we want?
    JZ          LE2D5                          ; Yes. Process it
LE2CC:
    INC         BX                             ; think about next Direction
    MOV         AL,[CurrentlyLooking]
    INC         AL
    CMP         AL,TotalDirectionsCount        ; have we tried all Directions?
    JNZ         LE2C0                          ; No. Loop until we have.
LE2D5:
    MOV         AL,[CurrentlyLooking]          ; this is the Direction we want!
    MOV         [Route_One],AL                 ; This is the Exact Way!
    MOV         [Route_Two],AL                 ; So this
    DEC         AL
    AND         AL,0x7                         ; This isn't Quite so exact
    MOV         [Route_Three],AL
    INC         AL
    INC         AL
    AND         AL,0x7
    MOV         [Route_Four],AL                ; Neither is this
    MOV         CH,0x8                         ; We'll Try this 8 times
LE2ED:
    CALL        RandomishNumber                ; Random Number
    AND         AL,0x3                         ; Between 0-3
    MOV         DH,0x0
    MOV         DL,AL
    MOV         BX,Route_One                   ; Reference the moves picked
    ADD         BX,DX                          ; Which one are we going to use?
    MOV         AL,byte ptr [BX]               ; this one of course!
    MOV         [CurrentlyLooking],AL          ; Done.
    PUSH        CX
    CALL        FindLookingTowards ; move to something we're looking at.
    MOV         BX,word ptr [DesirableLocation]; Yes we are!!!!
    MOV         word ptr [WorkingLocation],BX
    CALL        CalcMapLocation                ; Were in the data though?
    POP         CX
    MOV         AL,[LocationFeature]           ; What's here?
    CMP         AL,Mountain
    JZ          LE319                          ; Can't walk through mountains!
    CMP         AL,Forest
    JZ          LE319                          ; Don't like Forests!
    CMP         AL,FrozenWaste                 ; Bit impassible!
    JZ          LE319                          ; That'll do.
    RET
LE319:
    DEC         CH
    JNZ         LE2ED
    CMP         AL,FrozenWaste                 ; We didn't get a desired Direction.
    JZ          LAB_0000_0ef5                  ; anything other than frozen waste will do!
    RET
LAB_0000_0ef5:
    MOV         AL,0x8                         ; Or Nowhere
    MOV         [CurrentlyLooking],AL
    RET


FullScaleBattle:
    MOV         AL,[LastFreeArmyInTable]
    CMP         AL,0x0                         ; How many Free Armies still Here?
    JNZ         LAB_0000_0f03                  ; Return if none at all
    RET
LAB_0000_0f03:
    MOV         AL,[LastDoomDarksArmyInTable]
    CMP         AL,0x0                         ; How Many of doomdarks armies here?
    JNZ         LAB_0000_0f0b                  ; Return if none at all
    RET
LAB_0000_0f0b:
    MOV         AL,0xff                        ; Set this for a while
    MOV         [CharInHereTable],AL
    XOR         AL,AL                          ; Start with army Zero
LE336:
    MOV         [FreeArmyPosInTable],AL
    CALL        GetFreeArmy                    ; Get the required army
    MOV         AL,[HowManyFreeArmy]
    CMP         AL,0x0                         ; How many here?
    JZ          MinorSkirmish::LE384           ; None is not worth bothering about.
    MOV         CH,AL
    MOV         AL,[FreeArmySuccessChance]
    MOV         CL,AL


MinorSkirmish:
    PUSH        CX
    CALL        RandomishNumber                ; Pick a number
    CMP         AL,CL                          ; Compare it agains free's success
    JNC         LE378                          ; if A>=C then no Fighting!
    CALL        RandomishNumber
    MOV         BL,AL
    MOV         BH,0x0
    MOV         AL,[LastDoomDarksArmyInTable]
    CALL        HowManyUnitsOf_A
    MOV         [DoomDarksArmyPosInTable],AL
    CALL        GetDoomDarksArmy
    CALL        RandomishNumber
    MOV         CL,AL
    MOV         AL,[DoomDarksArmySuccessChance]; What's the chance of success?
    CMP         AL,CL
    JNC         LE378                          ; if a>=c then no loss
    MOV         AL,[NoOfDoomDarksDead]         ; How Many are already Dead?
    CMP         AL,0xff                        ; Are they all dead?
    JZ          LE376                          ; Yes. can't kill anymore then
    INC         AL                             ; Add one more to the count
    MOV         [NoOfDoomDarksDead],AL
LE376:
    JMP         LE390
LE378:
    POP         CX
    DEC         CH                             ; Next Soldier!
    JNZ         MinorSkirmish
    MOV         AL,[CharInHereTable]           ; Was this a full battle
    CMP         AL,0xff                        ; or a minor skirmish?
    JZ          LAB_0000_0f68                  ; return if a minor skirmish
    RET
LAB_0000_0f68:
    CALL        StoreFreeArmy
LE384:
    MOV         AL,[LastFreeArmyInTable]       ; How many entry's in the table?
    MOV         CH,AL
    MOV         AL,[FreeArmyPosInTable]        ; How many have we done?
    INC         AL                             ; Next.
    CMP         AL,CH                          ; Are we past the last one?
    JNZ         FullScaleBattle::LE336         ; Loop until we are.
    RET
LE390:
    MOV         AL,[HowManyDoomDarksArmy]
    DEC         AL                             ; Reduce the amount of the Enemy
    MOV         [HowManyDoomDarksArmy],AL
    CALL        StoreDoomDarksArmy             ; Store away the results
    MOV         AL,[HowManyDoomDarksArmy]
    CMP         AL,0x0                         ; Are there any left?
    JNZ         LE378                          ; loop until there isn't
    MOV         AL,[LastDoomDarksArmyInTable]  ; Well that's one full army down!
    DEC         AL                             ; Decrease the Last one
    MOV         [LastDoomDarksArmyInTable],AL
    CMP         AL,0x0                         ; Any Armies left at location?
    JNZ         ShuffleArmytable               ; Yes.
    POP         CX                             ; No. well that's that then!!
    RET
ShuffleArmytable:
    MOV         CH,AL
    MOV         AL,[DoomDarksArmyPosInTable]   ; B=Last Entry in table
    CMP         AL,CH                          ; a=Where are we in that table?
    JZ          LE378                          ; Loop if they're the same
    MOV         BX,word ptr [HowManyDoomDarksArmy] ; We want to store away
    PUSH        BX                             ; these for A while.
    MOV         BX,word ptr [NoOfFreeDead]
    PUSH        BX
LE3BD:
    INC         AL
    MOV         [DoomDarksArmyPosInTable],AL
    CALL        GetDoomDarksArmy               ; get Next army in the table!
    MOV         AL,[DoomDarksArmyPosInTable]
    DEC         AL                             ; and position it one entry back
    MOV         [DoomDarksArmyPosInTable],AL
    CALL        StoreDoomDarksArmy             ; Store away the details
    MOV         AL,[LastDoomDarksArmyInTable]  ; How many in the table?
    MOV         CH,AL
    MOV         AL,[DoomDarksArmyPosInTable]
    INC         AL                             ; Increment which one we're dealing with
    CMP         AL,CH                          ; Have we done them all?
    JNZ         LE3BD                          ; Loop until we have.
    POP         BX                             ; restore the variables we saved.
    MOV         word ptr [NoOfFreeDead],BX
    POP         BX
    MOV         word ptr [HowManyDoomDarksArmy],BX ; Store as the last entry!!!(?)
    MOV         [DoomDarksArmyPosInTable],AL
    CALL        StoreDoomDarksArmy
    JMP         LE378                          ; back to battle!


LocateDoomDarksArmy:
    MOV         CX,word ptr [StartOfDoomDarksTable]
    MOV         DX,HowManyDoomDarksArmy
    MOV         AL,[DoomDarksArmyPosInTable]
    JMP         HL_Equal_AMult4PlusBC


LocateFreeArmy:
    MOV         CX,word ptr [StartofFreeTable]
    MOV         DX,HowManyFreeArmy
    MOV         AL,[FreeArmyPosInTable]


HL_Equal_AMult4PlusBC:
    MOV         BL,AL
    MOV         BH,0x0
    ADD         BX,BX
    ADD         BX,BX
    ADD         BX,CX
    RET


GetFreeArmy:
    CALL        LocateFreeArmy
    JMP         RetrieveFourBytes


StoreFreeArmy:
    CALL        LocateFreeArmy
    JMP         StoreDoomDarksArmy::StoreFourBytes


GetDoomDarksArmy:
    CALL        LocateDoomDarksArmy
    JMP         RetrieveFourBytes


StoreDoomDarksArmy:
    CALL        LocateDoomDarksArmy
StoreFourBytes:
    XCHG        BX,DX


RetrieveFourBytes:
    MOV         CX,0x4
    MOV         SI,BX
    MOV         DI,DX
    MOVSB.REP   ES:DI,SI
    MOV         BX,SI
    MOV         DX,DI
    RET


CalcCharsKillRate:
    MOV         AL,[NoInCharHereTable]
    CMP         AL,0x0                         ; Are there any Chars here?
    JNZ         LAB_0000_102c                  ; return if not
    RET
LAB_0000_102c:
    XOR         AL,AL                          ; Start with the first.
LE426:
    MOV         [CharInHereTable],AL
    MOV         AL,[LastDoomDarksArmyInTable]
    CMP         AL,DoomDark                    ; Any of Doomdarks army here?
    JNZ         LAB_0000_1039                  ; Return if not.
    RET
LAB_0000_1039:
    CALL        GetFromCharHereTable           ; get the character.
    MOV         AL,0x0
    MOV         [NoOfDoomDarksDead],AL         ; Have'nt killed any yet!
    MOV         AL,[CharFightStrength]
    MOV         CH,AL                          ; work out our worth in soldiers.
    MOV         AL,[CharEnergyStatus]
    ADD         AL,0x80
    MOV         CL,AL
    CALL        MinorSkirmish
    MOV         AL,[NoOfDoomDarksDead]
    MOV         [CharSlew],AL                  ; Character Killed a few
    CALL        SaveCharDetails
    MOV         AL,[NoInCharHereTable]
    MOV         CH,AL                          ; How Many Characters are here?
    MOV         AL,[CharInHereTable]           ; Select the next character
    INC         AL                             ; that's in this location.
    CMP         AL,CH                          ; Have we Done them all?
    JNZ         LE426                          ; Loop if Not.
    RET


LocateArmy_DoomDarksElite:
    MOV         CX,ArmyTable3
    MOV         DX,DoomDarksElite_Location
    MOV         AL,[Army_DoomDarksElite]
    JMP         HL_Equal_AMult4PlusBC


GetArmy_DoomDarksElite:
    CALL        LocateArmy_DoomDarksElite
    CALL        RetrieveFourBytes
    MOV         AL,[DoomDarksElite_Location]
    MOV         CH,AL
    AND         AL,0x3f
    MOV         [DoomDarksElite_Location],AL
    MOV         AL,CH
    AND         AL,0xc0
    MOV         [DoomDarksElite_Orders],AL
    MOV         AL,[DoomDarksElite_Location+1]
    MOV         CH,AL
    AND         AL,0x3f
    MOV         [DoomDarksElite_Location+1],AL
    MOV         AL,CH
    AND         AL,0x80
    MOV         [DoomDarksElite_Type],AL
    RET


StoreArmy_DoomDarksElite:
    MOV         AL,[DoomDarksElite_Location]
    MOV         CH,AL
    MOV         AL,[DoomDarksElite_Orders]
    OR          AL,CH
    MOV         [DoomDarksElite_Location],AL
    MOV         AL,[DoomDarksElite_Location+1]
    MOV         CH,AL
    MOV         AL,[DoomDarksElite_Type]
    OR          AL,CH
    MOV         [DoomDarksElite_Location+1],AL
    CALL        LocateArmy_DoomDarksElite
    JMP         StoreDoomDarksArmy::StoreFourBytes


GetArmy_Table2:
    MOV         CX,ArmyTable2
    MOV         DX,Headquarters_Location
    MOV         AL,[Army_Headquarters]
    CALL        HL_Equal_AMult4PlusBC
    JMP         RetrieveFourBytes


GetArmyDetails:
    MOV         AL,[Army_Details]
    MOV         [Army_Headquarters],AL
    CALL        GetArmy_Table2
    MOV         BX,word ptr [Headquarters_Location]
    MOV         word ptr [ArmyLocation],BX
    CALL        LocateArmy_Table1
    MOV         AL,byte ptr [BX]
    MOV         CH,AL
    AND         AL,Targ
    MOV         [WhoseRaceIsArmy],AL
    MOV         AL,CH
    AND         AL,0x4
    MOV         [WhoGuardsThePlace],AL
    INC         BX
    MOV         AL,byte ptr [BX]
    MOV         [HowManyGuardsThePlace],AL
    RET


LocateArmy_Table1:
    MOV         AL,[Army_Details]
    MOV         CL,AL
    MOV         CH,0x0
    SHL         CL,0x1
    MOV         BX,ArmyTable1
    ADD         BX,CX
    RET


StoreArmy_Table1:
    CALL        LocateArmy_Table1
    MOV         AL,[WhoseRaceIsArmy]
    MOV         CH,AL
    MOV         AL,[WhoGuardsThePlace]
    OR          AL,CH
    MOV         byte ptr [BX],AL
    INC         BX
    MOV         AL,[HowManyGuardsThePlace]
    MOV         byte ptr [BX],AL
    RET


WorkOutLocationDetails:
    MOV         BX,word ptr [CurrentLocation]
    MOV         word ptr [WorkingLocation],BX
    CALL        CalcMapLocation
    MOV         CH,0x40
    MOV         AL,[LocationFeature]
    CMP         AL,Mountain
    JNZ         LE601
    MOV         CH,0x20
LE601:
    MOV         AL,CH
    MOV         [IncRidersEnergyBy],AL
    MOV         BX,CharHereTable
    MOV         word ptr [PosInCharHereTable],BX=>CharHereTable
    MOV         BX,WorkSpaceArea
    MOV         word ptr [StartOfDoomDarksTable],BX=>WorkSpaceArea
    MOV         BX,WorkSpaceArea[128]
    MOV         word ptr [StartofFreeTable],BX=>WorkSpaceArea[128]
    MOV         BX,0x0
    MOV         word ptr [DoomDarks_Warriors],BX
    MOV         word ptr [DoomDarks_Riders],BX
    XOR         AL,AL
    MOV         [FreeArmyHere],AL
    MOV         [DoomDarksArmyHere],AL
    MOV         [NoInCharHereTable],AL
    MOV         [TempCharacterNo],AL
    MOV         [FreeArmyPosInTable],AL
    MOV         [DoomDarksArmyPosInTable],AL
    MOV         [Army_Details],AL
    MOV         [Army_DoomDarksElite],AL
    CALL        CalculateIceFear
    MOV         AL,[WorkingLocation]           ; Set BC to equal
    MOV         CH,AL                          ; current Location.
    MOV         AL,[WorkingLocation+1]         ; This will be referenced
    MOV         CL,AL                          ; loads of times!
LE644:
    PUSH        CX
    CALL        GetArmyDetails
    POP         CX
    MOV         AL,[HowManyGuardsThePlace]
    CMP         AL,0x0                         ; AnyBody?
    JZ          LE65C                          ; Skip rest if not!
    MOV         AL,[ArmyLocation]
    CMP         AL,CH                          ; is the army at this location?
    JNZ         LE65C
    MOV         AL,[ArmyLocation+1]
    CMP         AL,CL
    JZ          AddArmyToBattleTable           ; Yes
LE65C:
    MOV         AL,[Army_Details]              ; No. Think about the next army
    INC         AL
    MOV         [Army_Details],AL
    CMP         AL,TotalArmyCount              ; is it the last?
    JNZ         LE644                          ; Loop if not
LE667:
    PUSH        CX
    CALL        GetArmy_DoomDarksElite
    POP         CX
    MOV         AL,[DoomDarksElite_Total]
    CMP         AL,0x0                         ; Any Actual army?
    JZ          LE680                          ; If Not Skip this
    MOV         AL,[DoomDarksElite_Location]
    CMP         AL,CH                          ; is the army at the current Location?
    JNZ         LE680
    MOV         AL,[DoomDarksElite_Location+1]
    CMP         AL,CL
    JNZ         LE680                          ; Yes. Do this routine!
    CALL        AddArmyToDoomDarksBattleTable
LE680:
    MOV         AL,[Army_DoomDarksElite]
    INC         AL                             ; Next Army
    MOV         [Army_DoomDarksElite],AL
    CMP         AL,TotalDoomDarksEliteArmyCount; Was it the last?
    JNZ         LE667                          ; Loop until it was
LE68B:
    PUSH        CX
    CALL        CopyCharDetails
    POP         CX
    MOV         AL,[CharLifeStatus]
    CMP         AL,CharacterIsAlive            ; is the character alive?
    JZ          LE6AB
    MOV         AL,[CharHideFlag]
    CMP         AL,CharacterIsHidden           ; Is character Hidden? 0=No
    JNZ         LE6AB                          ; Yes. skip the rest
    MOV         AL,[CharLocation]
    CMP         AL,CH                          ; is the character at the current Location?
    JNZ         LE6AB
    MOV         AL,[CharLocation+1]
    CMP         AL,CL
    JNZ         LE6AB                          ; yes. Do this
    CALL        AddCharToBattleTable
LE6AB:
    MOV         AL,[TempCharacterNo]
    INC         AL                             ; Next Character
    MOV         [TempCharacterNo],AL
    CMP         AL,TotalCharacterCount         ; Is it the last?
    JNZ         LE68B                          ; Loop until it is
    MOV         AL,[DoomDarksArmyPosInTable]
    MOV         [LastDoomDarksArmyInTable],AL
    MOV         CH,AL
    MOV         AL,[FreeArmyPosInTable]
    MOV         [LastFreeArmyInTable],AL
    MOV         CL,AL
    MOV         AL,[NoInCharHereTable]
    ADD         AL,CL
    MOV         [NoOfFreeArmiesAndChars],AL
    MOV         AL,CH
    ADD         AL,CL
    MOV         [TotalNoOfArmiesHere],AL
    RET
AddArmyToBattleTable:
    MOV         DL,0x10
    MOV         AL,[LocationFeature]
    CMP         AL,Citadel                     ; is the army at a Citadel?
    JNZ         LE6DC                          ; No.
    MOV         DL,0x20
LE6DC:
    MOV         AL,[WhoseRaceIsArmy]
    CMP         AL,DoomDark                    ; is it the DoomGuard?
    JNZ         LE70A                          ; No.
    MOV         AL,DL                          ; Yes
    MOV         [DoomDarksArmyHere],AL         ; Set to 10/20 depending if citadel!
    MOV         AL,[Army_Details]
    OR          AL,PalaceGuardBitFlag
    MOV         [WhichDoomDarksArmy],AL        ; We neet to know which army number
    MOV         AL,[WhoGuardsThePlace]         ; What type guard the place
    MOV         DH,AL
    MOV         AL,[HowManyGuardsThePlace]     ; And how many
    MOV         [HowManyDoomDarksArmy],AL
    CALL        IncDoomDarksArmy
    MOV         AL,0x0
    MOV         [NoOfFreeDead],AL
    MOV         AL,[WhoGuardsThePlace]
    CALL        AddArmyToDoomDarksTable
    JMP         LE667                          ; Loop next army
LE70A:
    MOV         AL,[Army_Details]
    OR          AL,PalaceGuardBitFlag          ; Army at Keep or Citadel.
    MOV         [WhichFreeArmy],AL             ; We need to know which army number
    MOV         AL,DL
    MOV         [FreeArmyHere],AL              ; Set depending on wether its a citadel
    MOV         AL,[HowManyGuardsThePlace]
    MOV         [HowManyFreeArmy],AL
    MOV         AL,0x0
    MOV         [NoOfDoomDarksDead],AL
    MOV         AL,[WhoGuardsThePlace]
    MOV         DH,0x40
    CMP         AL,0x0
    JZ          LE72C
    MOV         DH,0x60
LE72C:
    MOV         AL,DH
    MOV         [FreeArmySuccessChance],AL
    PUSH        CX
    CALL        StoreFreeArmy
    POP         CX
    MOV         AL,[FreeArmyPosInTable]
    INC         AL
    MOV         [FreeArmyPosInTable],AL
    JMP         LE667                          ; Loop next army


AddArmyToDoomDarksBattleTable:
    MOV         AL,[Army_DoomDarksElite]
    MOV         [WhichDoomDarksArmy],AL
    MOV         AL,[DoomDarksElite_Type]
    MOV         DH,AL
    MOV         AL,[DoomDarksElite_Total]
    MOV         [HowManyDoomDarksArmy],AL
    CALL        IncDoomDarksArmy
    XOR         AL,AL
    MOV         [NoOfFreeDead],AL
    MOV         AL,[DoomDarksElite_Type]
    JMP         AddArmyToDoomDarksTable


AddCharToBattleTable:
    MOV         AL,[TempCharacterNo]
    PUSH        CX                             ; Which character
    MOV         BX,word ptr [PosInCharHereTable]
    MOV         byte ptr [BX],AL               ; Add character to character here table!
    INC         BX
    MOV         word ptr [PosInCharHereTable],BX
    MOV         AL,[NoInCharHereTable]
    INC         AL                             ; Increase how many characters are here
    MOV         [NoInCharHereTable],AL
    MOV         AL,[CharNoRiders]
    CMP         AL,0x0                         ; Has the character got any riders?
    JZ          LE78C
    MOV         [HowManyFreeArmy],AL           ; Set how many.
    MOV         AL,[TempCharacterNo]           ; get character no
    OR          AL,0x40                        ; and set bit 5 to say riders
    MOV         [WhichFreeArmy],AL
    MOV         AL,[CharRidersEnergyStatus]
    MOV         DH,AL                          ; Riders energy Status
    MOV         AL,[IncRidersEnergyBy]         ; Riders increment amount
    ADD         AL,DH                          ; Total them
    CALL        AddIntoBattleTable
LE78C:
    MOV         AL,[CharNoWarriors]
    CMP         AL,0x0                         ; Any Warriors?
    JZ          LE7A2
    MOV         [HowManyFreeArmy],AL           ; Set how many
    MOV         AL,[TempCharacterNo]
    MOV         [WhichFreeArmy],AL             ; Set who
    MOV         AL,[CharWarriorsEnergyStatus]  ; Warriors energy status
    CALL        AddIntoBattleTable
LE7A2:
    POP         CX
    RET


AddIntoBattleTable:
    MOV         DH,AL
    MOV         AL,[FreeArmyHere]              ; how many Here?
    ADD         AL,DH                          ; Add in our new figure
    MOV         DH,AL
    MOV         AL,[LocationFeature]           ; where are we?
    CMP         AL,Forest                      ; In a forest?
    JNZ         LE7BC
    MOV         AL,[CharGraphicType]
    CMP         AL,CharFeyOnHorse              ; is the character a fey on a horse
    JC          LE7BC                          ; No
    MOV         AL,0x40
    ADD         AL,DH                          ; Add loads on if he is
    MOV         DH,AL
LE7BC:
    MOV         AL,DH
    SHR         AL,0x1                         ; Multiply by two
    ADD         AL,0x18                        ; add some more
    MOV         [FreeArmySuccessChance],AL     ; Success chance!
    MOV         AL,0x0
    MOV         [NoOfDoomDarksDead],AL         ; Reset.
    CALL        StoreFreeArmy
    MOV         AL,[FreeArmyPosInTable]
    INC         AL                             ; One more to the table
    MOV         [FreeArmyPosInTable],AL
    RET


AddArmyToDoomDarksTable:
    PUSH        CX
    CMP         AL,0x0
    MOV         BX,word ptr [IceFear]
    JNZ         LE7E3
    MOV         AL,0x5
    CALL        HowManyUnitsOf_A
    JMP         LE7E8
LE7E3:
    MOV         AL,0x4
    CALL        HowManyUnitsOf_A
LE7E8:
    MOV         AL,[DoomDarksArmyHere]
    ADD         AL,BL
    MOV         [DoomDarksArmySuccessChance],AL
    PUSH        CX
    CALL        StoreDoomDarksArmy
    POP         CX
    MOV         AL,[DoomDarksArmyPosInTable]
    INC         AL
    MOV         [DoomDarksArmyPosInTable],AL
    POP         CX
    RET


CalculateIceFear:
    MOV         AL,SelectedMorkin
    MOV         [TempCharacterNo],AL           ; get Morkins Details
    CALL        CopyCharDetails
    MOV         AL,[CharLifeStatus]
    CMP         AL,CharacterIsAlive            ; is he alive?
    JNZ         LE810                          ; Yes.
    MOV         AL,0x7f                        ; NO. Start with 127 life status
    JMP         LE81E
LE810:
    CALL        CalcDiffinLocations
    MOV         DX,word ptr [PositionOfTowerOfDespair]                      ; Was there A Difference
    CMP         AL,0x0                         ; No. Character is either with morkin or is morkin.
    JZ          CalcMorkinsIceFear
    CALL        CalcDiffin_BC_DE               ; Calc distance from tower!
LE81E:
    MOV         BL,AL                          ; HL = Difference
    MOV         BH,0x0
    MOV         word ptr [IceFear],BX          ; IceFear's Initial setting!
; Check to see if Luxor is still alive!
    MOV         AL,SelectedLuxor
    MOV         [TempCharacterNo],AL
    CALL        CopyCharDetails
    MOV         AL,[CharLifeStatus]
    CMP         AL,CharacterIsAlive            ; Is Luxor still alive?
    JZ          LE838                          ; Ooops! No he's Not
    CALL        CalcDiffinLocations            ; Yes he is!
    JMP         LE83A
; Recalculate the IceFear Accordingly!
LE838:
    MOV         AL,0x7f
LE83A:
    MOV         CH,0x0
    MOV         CL,AL
    MOV         BX,word ptr [IceFear]
    ADD         BX,CX
    MOV         CL,0x30                        ; Some for Good Measure!
    ADD         BX,CX
    MOV         AL,[DoomDarksCitadels]
    MOV         CL,AL                          ; Add on the number of Citadels
    ADD         BX,CX                          ; currently held by Doomdark!
LE849:
    MOV         word ptr [IceFear],BX
    XOR         AL,AL                          ; Start back with Luxor
    MOV         [TempCharacterNo],AL
    RET


ItsKillingTime:
    MOV         AL,[LocationArea]
    MOV         [TempVar],AL
    MOV         AL,[LastFreeArmyInTable]
    MOV         [FreeArmyStillLeft],AL
    MOV         AL,[LastDoomDarksArmyInTable]
    MOV         [DoomDarksArmyStillLeft],AL
    CALL        CalcCharsKillRate
    CALL        DoBothSidesBattling
    CALL        DoBothSidesBattling
    CALL        WhoWonThisBattle
    JMP         BeenSomeDeaths

; Do the battle for both sides!
DoBothSidesBattling:
    CALL        DoBattle

; Do the battling for a side (func name was LE8A1)
DoBattle:
    CALL        FullScaleBattle
; Swap over variables so that we can do all the work with
; one set of variables. Keeps life much simpler!!
    MOV         AL,[LastFreeArmyInTable]
    MOV         CH,AL
    MOV         AL,[LastDoomDarksArmyInTable]
    MOV         [LastFreeArmyInTable],AL
    MOV         AL,CH
    MOV         [LastDoomDarksArmyInTable],AL
    MOV         BX,word ptr [StartofFreeTable]
    MOV         DX,word ptr [StartOfDoomDarksTable]
    MOV         word ptr [StartofFreeTable],DX
    MOV         word ptr [StartOfDoomDarksTable],BX
    RET


WhoWonThisBattle:
    MOV         AL,[LastDoomDarksArmyInTable]
    CMP         AL,0x0                         ; Has Doomdark still got any armies?
    JNZ         LE8CC                          ; Yes. he didn't lose then.
    MOV         AL,0x9f                        ; 'Free'
    JMP         LE8D8
LE8CC:
    MOV         AL,[LastFreeArmyInTable]
    CMP         AL,0x0                         ; Has the free got any armies left?
    JNZ         LE8D7                          ; Yes. they didn't lose then
    MOV         AL,0xc8                        ; 'Enemy'
    JMP         LE8D8
LE8D7:
    XOR         AL,AL                          ; Still fighting!
LE8D8:
    MOV         [BattleVictory],AL             ; Set who won, or didn't
    XOR         AL,AL                          ; Reset
    MOV         [FreeArmyPosInTable],AL        ; ...these
    MOV         [DoomDarksArmyPosInTable],AL   ; ...these
    MOV         AL,[FreeArmyStillLeft]
    CMP         AL,0x0                         ; How many Free armies?
    JNZ         LAB_0000_1436                  ; No More free left.
    JMP         LE9E
LAB_0000_1436:
    MOV         CH,AL
LE8EB:
    PUSH        CX
    CALL        GetFreeArmy
    MOV         AL,[HowManyFreeArmy]
    MOV         DL,AL                          ; Army Total
    MOV         AL,[WhichFreeArmy]             ; Who are they
    MOV         CL,AL
    CMP         AL,0x80                        ; C>=80 if at a citadel or keep
    JC          CalcCharsArmyLoses             ; otherwise belongs to a character
    CALL        MakeArmyChangeSides
    JMP         LE951
CalcCharsArmyLoses:
    AND         AL,0x40
    MOV         DH,AL
    MOV         AL,CL                          ; Army number
    AND         AL,0x1f
    MOV         [TempCharacterNo],AL           ; Select Character
    PUSH        DX
    CALL        CopyCharDetails                ; get his details
    POP         DX
    MOV         AL,[HowManyFreeArmy]           ; How Many Armies Here?
    MOV         CH,AL
    MOV         AL,DH                          ; Who Are They.
    CMP         AL,ArmyRiders                  ; Riders?
    JNZ         LE935                          ; Yes. Skip the Rest
    MOV         AL,[CharNoWarriors]            ; No. Warriors
    SUB         AL,CH                          ; Lost A Lot.
    MOV         [CharWarriorsLost],AL          ; Save Away how many lost.
    MOV         AL,CH
    MOV         [CharNoWarriors],AL            ; Save away how many Left.
    MOV         AL,[NoOfDoomDarksDead]         ; Warriors killed Some?
    MOV         [CharWarriorsSlew],AL
    MOV         AL,[CharWarriorsEnergyStatus]
    SUB         AL,0x18                        ; They lose some Energy
    JNC         LE930                          ; Have they any Left?
    XOR         AL,AL                          ; No Less than Zero.
LE930:
    MOV         [CharWarriorsEnergyStatus],AL  ; Store Away.
    JMP         LE951
LE935:
    MOV         AL,[CharNoRiders]              ; deal with Riders.
    SUB         AL,CH                          ; Lost a lot Again.
    MOV         [CharRidersLost],AL            ; Store how many lost.
    MOV         AL,CH
    MOV         [CharNoRiders],AL              ; Store how many left.
    MOV         AL,[NoOfDoomDarksDead]         ; Riders killed a few.
    MOV         [CharRidersSlew],AL            ; How Many?
    MOV         AL,[CharRidersEnergyStatus]
    SUB         AL,0x18                        ; lost Some energy.
    JNC         LE94E                          ; Have they any left?
    XOR         AL,AL                          ; No Less than zero.
LE94E:
    MOV         [CharRidersEnergyStatus],AL    ; Store Away
LE951:
    CALL        SaveCharDetails                ; Save Characters details.
    MOV         AL,[FreeArmyPosInTable]
    INC         AL                             ; Next.
    MOV         [FreeArmyPosInTable],AL
    POP         CX
    DEC         CH
    JNZ         LE99B                          ; Loop Until Finished.
LE9E:
    MOV         AL,[DoomDarksArmyStillLeft]    ; how many Doomdarks army are left?
    MOV         CH,AL
LE962:
    PUSH        CX
    CALL        GetDoomDarksArmy
    MOV         AL,[HowManyDoomDarksArmy]
    MOV         DL,AL
    MOV         AL,[WhichDoomDarksArmy]
    CMP         AL,PalaceGuardBitFlag          ; Does his army guard the place?
    JC          LE976                          ; No.
    CALL        MakeArmyChangeSides
    JMP         LE985
LE976:
    MOV         [Army_DoomDarksElite],AL       ; Get the army we want
    CALL        GetArmy_DoomDarksElite
    MOV         AL,[HowManyDoomDarksArmy]
    MOV         [DoomDarksElite_Total],AL      ; make alterations to the totals
    CALL        StoreArmy_DoomDarksElite
LE985:
    MOV         AL,[DoomDarksArmyPosInTable]   ; deal with the next army.
    INC         AL
    MOV         [DoomDarksArmyPosInTable],AL
    POP         CX
    DEC         CH
    JNZ         LE962
    CALL        UpdateCharsBattleStats
    MOV         AL,[BattleVictory]             ; Who won?
    CMP         AL,ArmyDoomDark                ; Was it DoomDark?
    JZ          LAB_0000_14fb                  ; return if it wasn't
    RET
LAB_0000_14fb:
    JMP         WhatHappensToFreeLords
LE99B:
    JMP         LE8EB                          ; Rather long jump


MakeArmyChangeSides:
    AND         AL,0x7f                        ; Army that we want.
    MOV         [Army_Details],AL
    PUSH        DX
    CALL        GetArmyDetails                 ; Get the army.
    POP         DX
    MOV         AL,[BattleVictory]
    CMP         AL,0x0                         ; Check who one
    JZ          LE9D0                          ; No one
    CMP         AL,ArmyDoomDark                ; Did Doomdark Win?
    JZ          LE9C3                          ; Yes.
    MOV         AL,[WhoseRaceIsArmy]           ; No. Who do the army belong to?
    CMP         AL,DoomDark                    ; Doomdark?
    JNZ         LE9D0                          ; Yes
    MOV         AL,Free                        ; No.
    MOV         [WhoseRaceIsArmy],AL           ; make the army belong to Free.
    MOV         DL,0x28
    JMP         LE9D0
LE9C3:
    MOV         AL,[WhoseRaceIsArmy]
    CMP         AL,DoomDark                    ; Does the army belong to to Doomdark?
    JZ          LE9D0                          ; don't do anything if it does.
    XOR         AL,AL                          ; Make the Army belong to Doomdark!
    MOV         [WhoseRaceIsArmy],AL
    MOV         DL,0x32
LE9D0:
    MOV         AL,DL                          ; How many of the army left?
    CMP         AL,0x0
    JNZ         LE9D7                          ; there are some.
    MOV         AL,0x4                         ; if none the start with this
LE9D7:
    MOV         [HowManyGuardsThePlace],AL
    CALL        StoreArmy_Table1               ; Rewrite the army away
    RET


CharacterLosesWhat:
    MOV         AL,[CharLifeStatus]
    CMP         AL,CharacterIsAlive            ; Is the Character Alive?
    JNZ         LAB_0000_154a                  ; No. Return
    RET
LAB_0000_154a:
    PUSH        AX
    PUSHF
    MOV         AL,[CharHasAHorse]
    CMP         AL,0x0                         ; Has the Character got a horse?
    JZ          WillCharacterDie               ; No. Forget the next bit!
    CALL        RandomishNumber                ; Between Zero & One
    AND         AL,0x1                         ; see if he'll lose his horse
    MOV         [CharHasAHorse],AL             ; 50/50 Characters not got a horse
    CALL        CalcCharsGraphicType
WillCharacterDie:
    CALL        RandomishNumber                ; Pick a number
    MOV         CH,AL
    MOV         AL,[CharEnergyStatus]          ; What's his energy like?
    SHR         AL,0x1                         ; Divide by two
    SUB         AL,0x40                        ; then subtract 64
    MOV         CL,AL                          ; Store this a mo
    POPF                                       ; get back his life status
    POP         AX
    ADD         AL,CL                          ; Add it to his energy
    CMP         AL,CH                          ; if A>B  then character
    JC          LAB_0000_1575                  ; lives.....
    RET
LAB_0000_1575:
    XOR         AL,AL
    MOV         [CharLifeStatus],AL            ; DEAD!!
    RET


WhatHappensToFreeLords:
    MOV         AL,[NoInCharHereTable]
    CMP         AL,0x0                         ; Any Character in location
    JNZ         LAB_0000_1583                  ; return if none!
    RET
LAB_0000_1583:
    XOR         AL,AL                          ; Start with first.
LEA13:
    MOV         [CharInHereTable],AL           ; Character we want
    CALL        GetFromCharHereTable           ; get his details
    CALL        CharacterLosesWhat
    MOV         AL,[CharLifeStatus]            ; Did he lose his life?
    CMP         AL,0x0
    JZ          LEA41                          ; Skip next bit
LEA23:
    CALL        RandomishNumber                ; Move character somewhere!!!
    AND         AL,0x7                         ; Pick A Direction
    MOV         [CurrentlyLooking],AL          ; We'll look there
    CALL        FindLookingTowards ; Anything upto three locations?
    MOV         BX,word ptr [DesirableLocation]
    MOV         word ptr [WorkingLocation],BX  ; Move There
    MOV         word ptr [CharLocation],BX     ; Store Away
    CALL        CalcMapLocation                ; Calculate New Position in Map
    MOV         AL,[LocationFeature]           ; What's there?
    CMP         AL,FrozenWaste                 ; Anywhere but Frozen waste
    JZ          LEA23                          ; Yes, do it all again.
LEA41:
    CALL        SaveCharDetails                ; Save away any changes
    MOV         AL,[NoInCharHereTable]         ; How many in the table
    MOV         CH,AL
    MOV         AL,[CharInHereTable]
    INC         AL                             ; Which one are we on.
    CMP         AL,CH                          ; have we processed them all?
    JNZ         LEA13                          ; Loop until we have.
    RET


UpdateCharsBattleStats:
    MOV         AL,[NoInCharHereTable]
    CMP         AL,0x0                         ; Any characters here?
    JNZ         LAB_0000_15d0                  ; return if not.
    RET
LAB_0000_15d0:
    XOR         AL,AL                          ; Start with first.
LEA57:
    MOV         [CharInHereTable],AL           ; The character we want.
    CALL        GetFromCharHereTable           ; get his deatils
    MOV         AL,[BattleVictory]
    MOV         [CharBattleStatus],AL          ; Say Who Won the battle
    MOV         AL,[TempVar]
    MOV         [CharBattleArea],AL            ; Say what are the battle was
    MOV         AL,[CharEnergyStatus]
    SUB         AL,0x14                        ; get rid of some energy
    JNC         LEA71
    XOR         AL,AL                          ; Can't have less than zero
LEA71:
    MOV         [CharEnergyStatus],AL
    CALL        SaveCharDetails                ; Store away the changes
    MOV         AL,[NoInCharHereTable]
    MOV         CH,AL                          ; how many in the table
    MOV         AL,[CharInHereTable]
    INC         AL                             ; Which are we upto?
    CMP         AL,CH                          ; The last one?
    JNZ         LEA57                          ; Loop until it is
    RET


CalcCharsGraphicType:
    MOV         AL,[CharRace]
    DEC         AL
    MOV         CL,AL
    MOV         CH,0x0
    SHL         CL,0x1
    MOV         AL,[CharHasAHorse]
    ADD         AL,CL
    MOV         CL,AL
    MOV         BX,RaceImageTable
    ADD         BX,CX
    MOV         AL,byte ptr [BX]
    MOV         [CharGraphicType],AL
    RET


AlterLocationContents:
    MOV         CX,word ptr [WorkingLocation]
    CALL        CalcMapHL                      ; Calc Offset in map
    MOV         AL,[LocationFeature]           ; Get the feature
    MOV         CH,AL
    MOV         AL,[LocationObject]            ; get the object
    ADD         AL,AL                          ; Move object into
    ADD         AL,AL                          ; high order bits
    ADD         AL,AL
    ADD         AL,AL
    ADD         AL,CH                          ; Put feature in low
    MOV         byte ptr [BX],AL               ; Store it away
    MOV         CX,0xf40                       ; Reference Description map
    ADD         BX,CX
    MOV         AL,[LocationArea]              ; get the area
    MOV         CH,AL
    MOV         AL,[LocDomainFlag]             ; the domain flag
    MOV         CL,AL
    MOV         AL,[LocSpecialFlag]            ; and special flag
    OR          AL,CH                          ; Combine them
    OR          AL,CL                          ; Combine them
    MOV         byte ptr [BX],AL               ; and store away
    RET


ResetToOriginalArmy:
    MOV         AL,[ArmyLoopCurrent]
    MOV         [Army_DoomDarksElite],AL
    CALL        GetArmy_DoomDarksElite
    MOV         BX,word ptr [DoomDarksElite_Location]
    MOV         word ptr [WorkingLocation],BX
    CALL        CalcMapLocation
    RET
AttemptFollow:
    MOV         BX,word ptr [Headquarters_Location]
    MOV         AL,[DoomDarksElite_Location+1] ; Do we need to move anywhere to
    CMP         AL,BH                          ; get to the desired location?
    JNZ         LEAF1                          ; Yes. Start the process.
    MOV         AL,[DoomDarksElite_Location]
    CMP         AL,BL
    JZ          AnnounceArmyIsHere             ; We're here then.
LEAF1:
    MOV         word ptr [ArmyToMoveLocation],BX ; Set the location we're at
    CALL        MoveTowardsSomeOne
    JMP         LEB4E
AnnounceArmyIsHere:
    CALL        ResetToOriginalArmy
    MOV         AL,0x1                         ; Set location feature to
    CALL        SetLocationPlainsArmy          ; army if we can
LEB01:
    MOV         AL,0x8
    MOV         [EnemyMoveCount],AL
    RET


MoveArmySomewhere:
    CALL        ResetToOriginalArmy
    MOV         AL,[DoomDarksElite_Total]
    CMP         AL,0x0                         ; is there actually any soldiers?
    JZ          LEB01                          ; Finish if not.
    MOV         AL,[LocSpecialFlag]
    CMP         AL,0x0                         ; Anything special here?
    JNZ         AnnounceArmyIsHere             ; Yes. - We'll Stay Here then!
    XOR         AL,AL                          ; Look North.
LEB19:
    MOV         [CurrentlyLooking],AL
    CALL        FindLookingTowards ; Have a look forwards a couple
    MOV         BX,word ptr [DesirableLocation]; of locations.
    MOV         word ptr [WorkingLocation],BX  ; Move to that location.
    CALL        CalcMapLocation
    MOV         AL,[LocSpecialFlag]
    CMP         AL,0x0                         ; Anything Special here?
    JNZ         LEB4E                          ; Yes. Check it out!
    MOV         AL,[CurrentlyLooking]          ; check next direction
    INC         AL
    CMP         AL,0x8
    JNZ         LEB19                          ; loop until looked everywhere
    MOV         AL,[DoomDarksElite_Orders]
    CMP         AL,0x0                         ; What will this army do?
    JNZ         LAB_0000_16ce                  ; Guess what!
    JMP         FollowAnotherArmy
LAB_0000_16ce:
    CMP         AL,0x40
    JNZ         LAB_0000_16d5                  ; aimlessly wander around!
    JMP         MoveArmyToNewLocation
LAB_0000_16d5:
    CMP         AL,0x80
    JNZ         LAB_0000_16dc
    JMP         FollowACharacter
LAB_0000_16dc:
    CMP         AL,0xc0
    JNZ         LEB4E
    JMP         FollowArmyThenPickAnother
LEB4E:
    MOV         AL,[CurrentlyLooking]
    CMP         AL,0x8                         ; Are we still looking anywhere
    JZ          AnnounceArmyIsHere             ; No. Doesn't look like it.
    MOV         BX,word ptr [DesirableLocation]; so just say the army is here.
    MOV         word ptr [CurrentLocation],BX
    CALL        WorkOutLocationDetails
    MOV         AL,[LastDoomDarksArmyInTable]
    CMP         AL,0x1f                        ; How many armies are here?
    JNC         AnnounceArmyIsHere             ; We'll stay here then!
    CALL        ResetToOriginalArmy            ; We're not going to stay here!
    MOV         AL,[TempTotalOfArmies]
    DEC         AL                             ; One Less in this location
    CALL        SetLocationPlainsArmy          ; Set terrain to Whatever
    MOV         AL,[TotalNoOfArmiesHere]       ; This is for new location
    INC         AL                             ; One more here than before
    MOV         [TempTotalOfArmies],AL         ; Set temp as well.
    MOV         BX,word ptr [CurrentLocation]
    MOV         word ptr [DoomDarksElite_Location],BX
    CALL        StoreArmy_DoomDarksElite       ; Store army away.
    CALL        ResetToOriginalArmy
    MOV         CH,0x2                         ; Start with two moves.
    MOV         AL,[LocationFeature]           ; What's here?
    CMP         AL,Mountain                    ; is it a mountain.
    JZ          LEB8F                          ; Yes. Bad Move!
    CMP         AL,Forest                      ; is it a forest? - Hope Not!
    JNZ         LEB91                          ; No. Still only two moves then
LEB8F:
    MOV         CH,0x8                         ; Bad Move, took us eight!
LEB91:
    MOV         AL,[DoomDarksElite_Type]
    CMP         AL,0x0                         ; Warriors?
    JZ          LEB9A                          ; Yes.
    SHR         CH,0x1                         ; Multiply by two for riders!
LEB9A:
    MOV         AL,[EnemyMoveCount]            ; Add on our number of moves
    ADD         AL,CH
    MOV         [EnemyMoveCount],AL
    JMP         SetLocationPlainsArmy          ; State that we're here!
FollowAnotherArmy:
    MOV         AL,[DoomDarksElite_ID]         ; Get the Armypointed to
    MOV         [Army_Headquarters],AL
    CALL        GetArmy_Table2
    MOV         BX,word ptr [Headquarters_Location] ; Record their postion
    MOV         word ptr [WorkingLocation],BX
    CALL        CalcMapLocation
    MOV         AL,[LocSpecialFlag]
    CMP         AL,0x0                         ; Anything Special there?
    JNZ         LAB_0000_175e                  ; No. We'll stay here then
    JMP         AnnounceArmyIsHere
LAB_0000_175e:
    JMP         AttemptFollow                  ; Yes. lets head towards them.
MoveArmyToNewLocation:
    CALL        RandomishNumber
    AND         AL,0x7                         ; Pick a direction
    MOV         [CurrentlyLooking],AL          ; Look that way
    CALL        FindLookingTowards ; find something to look towards
    MOV         BX,word ptr [DesirableLocation]; Move there
    MOV         word ptr [WorkingLocation],BX
    CALL        CalcMapLocation
    MOV         AL,[LocationFeature]           ; what's there?
    CMP         AL,FrozenWaste                 ; if it's frozen waste then
    JZ          MoveArmyToNewLocation          ; find another location
    JMP         LEB4E
FollowACharacter:
    MOV         AL,[DoomDarksElite_ID]
    MOV         [TempCharacterNo],AL           ; Pick up on character
    CALL        CopyCharDetails                ; get his info
    MOV         AL,[CharLifeStatus]
    CMP         AL,CharacterIsAlive            ; is he alive?
    JNZ         LEC07                          ; Yes. Skip next bit
    XOR         AL,AL                          ; No. Set character to Luxor!
LEBF0:
    MOV         [DoomDarksElite_ID],AL         ; Set ID to New Character
    MOV         [TempCharacterNo],AL
    CALL        StoreArmy_DoomDarksElite       ; Store Army Details
    CALL        CopyCharDetails                ; get characters info
    MOV         AL,[CharLifeStatus]
    CMP         AL,CharacterIsAlive            ; Is he alive
    JNZ         LEC07                          ; Yes. Skip Next bit
    MOV         AL,SelectedMorkin              ; Set character to Morkin!
    JMP         LEBF0                          ; And retry.
LEC07:
    MOV         BX,word ptr [CharLocation]     ; Move ArmyTable2
    MOV         word ptr [Headquarters_Location],BX ; to New characters Location
    JMP         AttemptFollow
FollowArmyThenPickAnother:
    MOV         AL,[DoomDarksElite_ID]
    MOV         [Army_Headquarters],AL
    CALL        GetArmy_Table2
    MOV         CX,word ptr [Headquarters_Location]
    MOV         AL,[DoomDarksElite_Location]
    CMP         AL,CL                          ; Are they at the same Location?
    JNZ         LEC45                          ; No
    MOV         AL,[DoomDarksElite_Location+1]
    CMP         AL,CH
    JNZ         LEC45                          ; No
    MOV         AL,[Headquarters_ArmyOne]      ; Yes they are so pick another army.
    MOV         CH,AL
    CALL        RandomishNumber                ; Pick a Number, Any Number
    CMP         AL,0x80                        ; What was it compared to 128
    JC          LEC38
    MOV         AL,[Headquarters_ArmyTwo]
    MOV         CH,AL
LEC38:
    MOV         AL,CH
    MOV         [DoomDarksElite_ID],AL         ; Point ArmyDoomDarksElite at the selection
    MOV         [Army_Headquarters],AL
    CALL        StoreArmy_DoomDarksElite       ; Store it and get the army
    CALL        GetArmy_Table2                 ; read to deal with.
LEC45:
    JMP         AttemptFollow


SetLocationPlainsArmy:
    MOV         CH,Army
    CMP         AL,0x0                         ; if a=0 then Set to Plains
    JNZ         LEC50                          ; Else set to army
    MOV         CH,Plains                      ; Reset to Plains
LEC50:
    MOV         AL,[LocationFeature]
    CMP         AL,Army                        ; Can only be Army or Plains.
    JNC         LAB_0000_1802
    RET
LAB_0000_1802:
    MOV         AL,CH                          ; Make New Feature
    MOV         [LocationFeature],AL
    JMP         AlterLocationContents


ProcessAllArmies:
    XOR         AL,AL
LEC5E:
    MOV         [ArmyLoopCurrent],AL
    MOV         [Army_DoomDarksElite],AL
    CALL        GetArmy_DoomDarksElite
    MOV         BX,word ptr [DoomDarksElite_Location]
    MOV         word ptr [CurrentLocation],BX
    CALL        WorkOutLocationDetails
    MOV         AL,[TotalNoOfArmiesHere]
    MOV         [TempTotalOfArmies],AL
    XOR         AL,AL
    MOV         [EnemyMoveCount],AL
LEC7A:
    CALL        MoveArmySomewhere
    MOV         AL,[EnemyMoveCount]
    CMP         AL,0x6                         ; Army can have upto six moves
    JC          LEC7A                          ; loop until they've had them.
    MOV         AL,[ArmyLoopCurrent]           ; Process the next army
    INC         AL
    CMP         AL,0x80                        ; Loop 128 times
    JNZ         LEC5E                          ; Done it!!!!
    RET


IncDoomDarksArmy:
    MOV         DL,AL
    MOV         AL,DH                          ; E=Number, A=Type
    MOV         DH,0x0                         ; Reset D
    CMP         AL,0x0                         ; are they Warriors
    JNZ         LEDE9                          ; If not then do riders
    MOV         BX,word ptr [DoomDarks_Warriors] ; else
    ADD         BX,DX                          ; Increment the number of Warriors
    MOV         word ptr [DoomDarks_Warriors],BX
LAB_0000_1853:
    RET
LEDE9:
    MOV         BX,word ptr [DoomDarks_Riders] ; Deal with the Riders.
    ADD         BX,DX                          ; Increment the number of Riders
    MOV         word ptr [DoomDarks_Riders],BX
    RET


BeenSomeDeaths:
    MOV         AL,[NoOfDeathsDescribed]
    INC         AL
    MOV         [NoOfDeathsDescribed],AL
    CMP         AL,0x1
    JNZ         LEE04
    MOV         BX,TokensDeathMessage
    CALL        FillPrintBuffer
    JMP         LEE09
LEE04:
    MOV         AL,0x87
    CALL        A_IntoPrintBuffer
LEE09:
    MOV         AL,0x40
    CALL        A_IntoPrintBuffer
    MOV         AL,[TempVar]
    MOV         [LocationArea],AL
    CALL        DescribeLocationArea
    JMP         FlushPrintBuffer
CalcMorkinsIceFear:
    CALL        CalcDiffin_BC_DE
    MOV         BX,MaxIceFear                  ; Maximum Ice fear
    ADD         AL,AL                          ; A=Distance from Tower*2
    MOV         CL,AL                          ; BC=A
    MOV         CH,0x0
    SHL         CX,0x1                         ; BC=BC*2
    XOR         AL,AL                          ; Reset A and Carry
    SBB         BX,CX                          ; HL=HL-BC
    JMP         LE849


CalcDiffinLocations:
    MOV         CX,word ptr [CharLocation]
    MOV         DX,word ptr [WorkingLocation]


CalcDiffin_BC_DE:
    MOV         AL,CH
    SUB         AL,DH
    JNC         LE874
    NEG         AL
LE874:
    MOV         BL,AL
    MOV         AL,CL
    SUB         AL,DL
    JNC         LE87B
    NEG         AL
LE87B:
    ADD         AL,BL
    RET


DisplayThinkAgain:
    CALL        Bytes_Print_Buffer
    db 0FBh,0FCh,055h,0FFh                     ; 'He'
    CALL        FlushPrintBuffer
    MOV         AL,0x3c
    MOV         [Print_Attr],AL
    MOV         AL,0xc9                        ; 'Thinks'
    CALL        A_IntoPrintBuffer
    CALL        FlushPrintBuffer
    MOV         AL,0x3a
    MOV         [Print_Attr],AL
    CALL        Bytes_Print_Buffer
    db 094h,0FEh,02Eh,0FEh,02Eh,0FEh,02Eh      ; 'Again ....'
    db 0FEh,02Eh,0FFh
    JMP         FlushPrintBuffer


DescribeAnObject:
    MOV         AL,[ObjectToDescribe]
    MOV         CL,AL
    MOV         CH,0x0
    SHL         CL,0x1
    MOV         BX,ObjectDescriptionLookupTable; Point to Object Description Table
    ADD         BX,CX
    MOV         DL,byte ptr [BX]
    INC         BX
    MOV         DH,byte ptr [BX]
    XCHG        BX,DX
    CALL        FillPrintBuffer
    RET


DescribeWho:
    MOV         AL,[CharHideFlag]
    CMP         AL,CharacterIsHidden           ; Is the character Hidden?
    JZ          LEC9D
    CALL        FirstNameToBuffer              ; Who is it?
    MOV         BX,TokensIsHidden
    CALL        FillPrintBuffer
LEC9D:
    CALL        SetTokenToUpperCase
    MOV         AL,[WhatObject]
    CMP         AL,NoObjectAtAll
    JZ          DescribeOrGuidence
    CMP         AL,Shelter                     ; Less than = Any Nasty!
    JNC         LAB_0000_1921
    JMP         DescribeNasty
LAB_0000_1921:
    CMP         AL,Fawkrin                     ; Any Ice Crown Killers
    JC          DescribeOrGuidence
    JMP         DescribeCharCondition


DescribeOrGuidence:
    MOV         BX,LE548
    CALL        FillPrintBuffer
    MOV         AL,[WhatObject]
    MOV         [ObjectToDescribe],AL
    CALL        DescribeAnObject
    MOV         AL,[WhatObject]
    CMP         AL,Guidance                    ; Is it Guidance?
    JZ          GiveSomeGuidance               ; Yes
    CALL        StopToBuffer
    JMP         DescribeCharCondition
GiveSomeGuidance:
    CALL        PercentToBuffer
    MOV         AL,[WhatObjectFlag]
    CMP         AL,0x4
    JNC         GiveMoreGuidance
    ADD         AL,0x10                        ; Add on 16
    MOV         [ObjectToDescribe],AL          ; Fawkrin,Farlame,Lake Mirrow,Lorgrim.
    CALL        DescribeAnObject
    CALL        Bytes_Print_Buffer
    db 0EDh,0EBh,000h,0FCh,09Bh                ; 'Can Destroy The Ice'
    db 0FCh,0EAh,0FFh                          ; 'Crown'
LECE9:
    CALL        StopToBuffer
    CALL        AndSignTobuffer
    CALL        SetTokenToLowerCase
    JMP         DescribeCharCondition
GiveMoreGuidance:
    MOV         [TempCharacterNo],AL
    CALL        CopyCharDetails
    MOV         BX,word ptr [CharLocation]
    MOV         word ptr [WorkingLocation],BX
    CALL        CalcMapLocation
    CALL        Bytes_Print_Buffer
    db 0FCh,05Bh,0B6h,0FFh                      ; 'Looking For'
    CALL        FullCharTitle                  ; Who are we looking for?
    CALL        CommaToBuffer
    MOV         BX,TokensYouMustSeek           ; This prints 'You Must Seek'
    CALL        FillPrintBuffer
    CALL        DescribeLocation               ; Where must we seek?
    JMP         LECE9


DescribeCharCondition:
    CALL        SetTokenToUpperCase
    CALL        PrintTimeStatus
    MOV         AL,0x87                        ; 'And'
    CALL        A_IntoPrintBuffer
    MOV         AL,[SaveCurChar]
    MOV         [TempCharacterNo],AL
    CALL        CopyCharDetails
    CALL        FirstNameToBuffer              ; Who is He.
    MOV         AL,0x70                        ; 'Is'
    CALL        A_IntoPrintBuffer
    MOV         AL,[CharEnergyStatus]
    CALL        ReportCharStatus               ; How is he?
    MOV         BX,TokensHowIsHe
    CALL        FillPrintBuffer
    CALL        DescribeIceFear                ; How's the Ice Fear?
    CALL        StopToBuffer
    CALL        FirstNameToBuffer              ; Who are we dealing with.
    MOV         AL,0x70                        ; 'Is'
    CALL        A_IntoPrintBuffer
    CALL        DisplayCharCourage             ; Are We Scared?
    CALL        StopToBuffer
    MOV         AL,[CharObjectCarrying]
    CMP         AL,0x0                         ; Are we carrying anything?
    JNZ         LAB_0000_19d7                  ; Return if not.
    RET
; Describe what we are carrying.
LAB_0000_19d7:
    MOV         [ObjectToDescribe],AL
    MOV         BX,TokensHeHasWithHim
    CALL        FillPrintBuffer
    CALL        DescribeAnObject
    JMP         StopToBuffer


DescribeIceFear:
    MOV         AL,0x40
    MOV         BX,word ptr [IceFear]
    CALL        HowManyUnitsOf_A
    MOV         AL,0x7
    SUB         AL,BL
    MOV         CH,0xf5                        ; 'Mild'
    MOV         CL,0xf4                        ; 'Cold'
    JMP         DisplayCharCourage::LED84


DisplayCharCourage:
    MOV         AL,[CharCourageStatus]
    MOV         CH,0xf3                        ; 'Bold'
    MOV         CL,0xf2                        ; 'Afraid'
LED84:
    JMP         HowMuch_What


DescribeNasty:
    MOV         [ObjectToDescribe],AL
    CMP         AL,WildHorses                  ; Is it wild Horses?
    JZ          LEDA4                          ; yes.
    MOV         AL,[WhatObjectFlag]
    CMP         AL,0x0
    JNZ         HeKilledWhatHow
    CALL        DescribeAnObject
    MOV         BX,TokensFightOrHide
    CALL        FillPrintBuffer
LED9E:
    CALL        StopToBuffer                   ; How does the character Fair?
    JMP         DescribeCharCondition
LEDA4:
    MOV         AL,[WhatObjectFlag]
    CMP         AL,0x0                         ; Has the object been Described?
    JZ          LAB_0000_1a2a                  ; Yes. Then no need to describe again.
    JMP         DescribeOrGuidence
LAB_0000_1a2a:
    CALL        DescribeAnObject
    CALL        Bytes_Print_Buffer
    db 0AEh,0ADh,0FFh                           ; 'Are Abroad'
    JMP         DescribeNasty::LED9E
HeKilledWhatHow:
    MOV         BX,KilledWhatHowDescription
    CALL        FillPrintBuffer
    CALL        DescribeAnObject               ; What did we kill
    MOV         AL,[CharObjectCarrying]
    CMP         AL,IceCrown
    JNC         LEDD6
    CMP         AL,WolfSlayer
    JC          LEDD6
    MOV         [ObjectToDescribe],AL
    MOV         AL,0xe3                        ; 'With'
    CALL        A_IntoPrintBuffer
    CALL        DescribeAnObject
LEDD6:
    JMP         LED9E


DisplayCharThink:
    MOV         AL,[KeyReturnStatus]
    CMP         AL,0x2                         ; Have we been here before?
    JZ          LEE68                          ; Yes. Skip intialise
LEE59:
    XOR         AL,AL
    MOV         [HowManyCharsInFrontDescribed],AL ; Initialise the Variables
    MOV         [Think_TempOne],AL
    MOV         [Think_TempThree],AL
    MOV         AL,0x2                         ; We've been here before
    MOV         [KeyReturnStatus],AL
LEE68:
    CALL        GetLatestCharInfo
    MOV         AL,[CharLifeStatus]
    CMP         AL,CharacterIsAlive            ; Still Alive?
    JNZ         DescribeInDetailHowHeDied      ; No. Describe in details how he died!
    JMP         WhoKilledHim
DescribeInDetailHowHeDied:
    MOV         AL,[Think_TempOne]
    CMP         AL,0x0
    JNZ         LEE81
    INC         AL
    MOV         [Think_TempOne],AL
    JMP         DescribeWho
LEE81:
    CMP         AL,0x1
    JNZ         LEE93
    INC         AL
    MOV         [Think_TempOne],AL
    MOV         AL,[CharBattleStatus]
    CMP         AL,0xff
    JZ          LEE68
    JMP         DescribeBattle
LEE93:
    CMP         AL,0x2
    JNZ         LEEC2
    MOV         AL,[Think_TempThree]
    INC         AL
    MOV         [Think_TempThree],AL
    CMP         AL,0x1
    JZ          LEEAA
    CALL        CheckLocationInfront
    MOV         AL,0x3
    MOV         [Think_TempOne],AL
LEEAA:
    MOV         AL,[LocationFeature]
    CMP         AL,Citadel                     ; Are we at a Citadel?
    JZ          LEEBC
    CMP         AL,Keep                        ; Are We at a Keep?
    JZ          LEEBC
    MOV         AL,[DoomDarksArmyPosInTable]
    CMP         AL,0x0                         ; Are there any armies here?
    JZ          LEE68                          ; if none of the above then skip.
LEEBC:
    CALL        WeAreLooking                   ; Describe where we are looking
    JMP         DisplayArmiesHere              ; ...and who is here!
LEEC2:
    MOV         AL,[Think_TempThree]
    CMP         AL,0x1
    JZ          LAB_0000_1ad6
    CALL        CheckLocationInfront
LAB_0000_1ad6:
    MOV         AL,[NoInCharHereTable]         ; How many Characters are infront?
    MOV         CH,AL
    MOV         AL,[HowManyCharsInFrontDescribed] ; How many have we described?
    CMP         AL,CH
    JNC         LEEE1
    MOV         [CharInHereTable],AL
    INC         AL
    MOV         [HowManyCharsInFrontDescribed],AL
    CALL        GetFromCharHereTable
    JMP         DescribeWhatCharSees
LEEE1:
    MOV         AL,[Think_TempThree]
    CMP         AL,0x1
    JNZ         LAB_0000_1af9
    JMP         LEE59
LAB_0000_1af9:
    DEC         AL
    MOV         [Think_TempThree],AL
    XOR         AL,AL
    MOV         [HowManyCharsInFrontDescribed],AL
    JMP         LEE68


CheckLocationInfront:
    MOV         BX,word ptr [DesirableLocation]
    MOV         word ptr [CurrentLocation],BX
    JMP         WorkOutLocationDetails


WeAreLooking:
    MOV         AL,[Think_TempThree]
    CMP         AL,0x1
    JNZ         LAB_0000_1b1b
    JMP         SetTokenToUpperCase
LAB_0000_1b1b:
    CALL        Bytes_Print_Buffer
    db 0FCh,05Ch,000h,0FFh                      ; 'To The'
    CALL        LookingWhere                   ; Where are we looking towards?
    JMP         CommaToBuffer


DescribeWhatCharSees:
    CALL        WeAreLooking
    JMP         DisplayArmyStatus


WhoKilledHim:
    CALL        SetTokenToUpperCase
    MOV         AL,[CharDeathStatus]
    CMP         AL,0x0                         ; Was it anything that killed him
    JNZ         LEF30                          ; Yes.
    CALL        Bytes_Print_Buffer             ; No. Must have died in battle.
    db 055h,090h,0F1h,054h                      ; 'He Was Killed In'
    db 0C3h,0FEh,02Eh,0FFh                      ; 'Battle.'
    JMP         DescribeBattle                 ; Which Battle?
LEF30:
    MOV         [ObjectToDescribe],AL          ; Describe what actually Killed him!
    CALL        DescribeAnObject
    CALL        Bytes_Print_Buffer
    db 0C7h,0F9h,0FEh,02Eh,0FFh                 ; 'Slew Him.'
    RET


DisplayArmiesHere:
    MOV         AL,[DoomDarksArmyPosInTable]
    CMP         AL,0x0                         ; Has doomdark go any armies here?
    JZ          LEF71                          ; If not don't print the message!
    CALL        Bytes_Print_Buffer
    db 0FCh,00Ch,0FDh,0A0h,08Ah                 ; 'DoomDark Has'
    db 095h,04Fh,040h,0FFh                      ; 'An Army Of'
    MOV         BX,word ptr [DoomDarks_Warriors] ; How many Warriors?
    CALL        HowManyWarriors_1
    CALL        AndToBuffer
    MOV         BX,word ptr [DoomDarks_Riders] ; How Many Riders?
    CALL        HowManyRiders_1
    CALL        StopToBuffer
    MOV         AL,[LocationFeature]
    CMP         AL,Citadel                     ; Are we at a keep or citadel?
    JZ          LEF6E                          ; Yes. At Citadel
    CMP         AL,Keep
    JZ          LEF6E                          ; No.
    RET
LEF6E:
    CALL        SetTokenToUpperCase
LEF71:
    MOV         AL,[WhoGuardsThePlace]
    CMP         AL,0x0
    JNZ         LEF80                          ; Riders Here!
    MOV         AL,[HowManyGuardsThePlace]
    CALL        HowManyWarriors                ; Display Warriors
    JMP         LEF86
LEF80:
    MOV         AL,[HowManyGuardsThePlace]     ; Display Riders
    CALL        HowManyRiders
LEF86:
    CALL        Bytes_Print_Buffer
    db 040h,000h,0FCh,0FFh                      ; 'Of The'
    MOV         AL,[WhoseRaceIsArmy]           ; Belonging to whom
    CMP         AL,DoomDark                    ; is it the DoomGuard?
    JNZ         LEF9D                          ; anything other than zero isn't
    CALL        Bytes_Print_Buffer
    db 00Ch,0FDh,09Eh,0FFh                      ; 'DoomGuard'
    JMP         LEFB2
LEF9D:
    CMP         AL,Free                        ; Are They Belonging to the Free?
    JNZ         LEFA5
    MOV         AL,0x9f                        ; 'Free'
    JMP         LEFAF
LEFA5:
    CMP         AL,Fey                         ; Belonging to the Fey
    JNZ         LEFAD
    MOV         AL,0x7a                        ; 'Fey'
    JMP         LEFAF
LEFAD:
    MOV         AL,0x39                        ; Must be 'Targ'
LEFAF:
    CALL        A_IntoPrintBuffer
LEFB2:
    CALL        Bytes_Print_Buffer
    db 09Eh,000h,0FFh                           ; 'Guard The'
    MOV         AL,[LocationFeature]           ; Where are we?
    ADD         AL,0x41                        ; get token
    CALL        A_IntoPrintBuffer
    JMP         LEFF6


GetLatestCharInfo:
    CALL        UpdateCharsVars
    CALL        FindLookingTowards
    CALL        WorkOutLocationDetails


UpdateCharsVars:
    MOV         AL,[SaveCurChar]
    MOV         [TempCharacterNo],AL
    CALL        CopyCharDetails
    MOV         BX,word ptr [CharLocation]
    MOV         word ptr [CurrentLocation],BX
    MOV         AL,[CharLookDirection]
    MOV         [CurrentlyLooking],AL
    RET


AddToBufferAndKeyTable:
    MOV         CH,AL
    CALL        SetTokenToLowerCase
    CALL        HashToBuffer
    MOV         AL,CH
    SUB         AL,0x31
    MOV         CL,AL
    MOV         AL,CH
    MOV         CH,0x0
    MOV         BX,ChooseKeyTable
    ADD         BX,CX
    MOV         byte ptr [BX],AL
    CALL        AddLiteralToBuffer
    JMP         SetTokenToUpperCase


LEFF6:
    JMP         StopToBuffer


AndToBuffer:
    MOV         AL,0x87
    JMP         A_IntoPrintBuffer

; Terrain drawing routines
CalcPlotMask:
    MOV         CL,AL
    MOV         CH,0x0
    MOV         BX,word ptr [Image_XPixel]
    ADD         BX,CX
    DEC         BH
    JZ          LAB_0000_1c33
    RET
LAB_0000_1c33:
    MOV         CL,BL
    MOV         BX,PixelGenTable
    MOV         AL,CL
    AND         AL,0x7
    ADD         AL,BL
    MOV         BL,AL
    MOV         AL,byte ptr [BX]
    SHR         CL,0x1
    SHR         CL,0x1
    SHR         CL,0x1
    MOV         BH,0x0
    MOV         BL,CL
    ADD         BX,DX
    RET


DrawInScrBoundary:
    CMP         BX,Screen                      ; Bug Fix
    JL          LAB_0000_1c5d
    CMP         BX,Screen[6911]
    JG          LAB_0000_1c5d
    MOV         byte ptr [BX],AL
LAB_0000_1c5d:
    RET


PSET:
    CALL        CalcPlotMask
LF161:
    OR          AL,byte ptr [BX]
    JMP         DrawInScrBoundary


PRESET:
    CALL        CalcPlotMask
    MOV         CH,AL
    MOV         AL,[Image_PlotOnOff]
    CMP         AL,0x0
    MOV         AL,CH
    JNZ         PSET::LF161
    XOR         AL,0xff
    AND         AL,byte ptr [BX]
    JMP         DrawInScrBoundary

; ; CH = Start
; ; CL = End
DrawLine:
    PUSH        CX
    MOV         AL,[Image_PlotOnOff]
    CMP         AL,0x0
    PUSH        AX
    PUSHF
    PUSH        word ptr [AFEXTRA2]
    POPF
    MOV         AX,[AFEXTRA1]
    POP         word ptr [AFEXTRA2]
    POP         word ptr [AFEXTRA1]
    MOV         CH,0x0
    MOV         BX,word ptr [Image_XPixel]
    ADD         BX,CX
    DEC         BH
    POP         CX
    JNS         LAB_0000_1c9f
    RET
LAB_0000_1c9f:
    JZ          LF189
    MOV         BL,0xff
LF189:
    MOV         AL,BL
    MOV         [LFF04],AL
    MOV         CL,CH
    MOV         CH,0x0
    MOV         BX,word ptr [Image_XPixel]
    ADD         BX,CX
    DEC         BH
    JZ          LF19A
    JS          LAB_0000_1cb9
    RET
LAB_0000_1cb9:
    MOV         BL,0x0
LF19A:
    MOV         AL,BL
    MOV         [LFF03],AL
    SHR         AL,0x1
    SHR         AL,0x1
    SHR         AL,0x1
    MOV         [LFF05],AL
    MOV         AL,[LFF03]
    AND         AL,0x7
    MOV         [LFF07],AL
    MOV         AL,[LFF04]
    SHR         AL,0x1
    SHR         AL,0x1
    SHR         AL,0x1
    MOV         [LFF06],AL
    MOV         AL,[LFF04]
    AND         AL,0x7
    MOV         [LFF08],AL
    MOV         AL,[LFF05]
    MOV         BH,0x0
    MOV         BL,AL
    ADD         BX,DX
    PUSH        BX
    MOV         CH,AL
    MOV         AL,[LFF06]
    CMP         AL,CH
    JNZ         LF1F6
    MOV         AL,[LFF07]
    SHL         AL,0x1
    SHL         AL,0x1
    SHL         AL,0x1
    MOV         CL,AL
    MOV         AL,[LFF08]
    OR          AL,CL
    MOV         CL,AL
    MOV         CH,0x0
    MOV         BX,LF010
    ADD         BX,CX
    MOV         AL,byte ptr [BX]
    POP         BX
    PUSH        AX
    PUSHF
    PUSH        word ptr [AFEXTRA2]
    POPF
    MOV         AX,[AFEXTRA1]
    POP         word ptr [AFEXTRA2]
    POP         word ptr [AFEXTRA1]
    JZ          LF1F0
    PUSH        AX
    PUSHF
    PUSH        word ptr [AFEXTRA2]
    POPF
    MOV         AX,[AFEXTRA1]
    POP         word ptr [AFEXTRA2]
    POP         word ptr [AFEXTRA1]
    OR          AL,byte ptr [BX]
    JMP         DrawInScrBoundary
LF1F0:
    PUSH        AX
    PUSHF
    PUSH        word ptr [AFEXTRA2]
    POPF
    MOV         AX,[AFEXTRA1]
    POP         word ptr [AFEXTRA2]
    POP         word ptr [AFEXTRA1]
    XOR         AL,0xff
    AND         AL,byte ptr [BX]
    JMP         DrawInScrBoundary
LF1F6:
    MOV         AL,[LFF07]
    MOV         CL,AL
    MOV         CH,0x0
    MOV         BX,LF008
    ADD         BX,CX
    MOV         AL,byte ptr [BX]
    POP         BX
    PUSH        AX
    PUSHF
    PUSH        word ptr [AFEXTRA2]
    POPF
    MOV         AX,[AFEXTRA1]
    POP         word ptr [AFEXTRA2]
    POP         word ptr [AFEXTRA1]
    JZ          LF209
    PUSH        AX
    PUSHF
    PUSH        word ptr [AFEXTRA2]
    POPF
    MOV         AX,[AFEXTRA1]
    POP         word ptr [AFEXTRA2]
    POP         word ptr [AFEXTRA1]
    OR          AL,byte ptr [BX]
    JMP         LF20D
LF209:
    PUSH        AX
    PUSHF
    PUSH        word ptr [AFEXTRA2]
    POPF
    MOV         AX,[AFEXTRA1]
    POP         word ptr [AFEXTRA2]
    POP         word ptr [AFEXTRA1]
    XOR         AL,0xff
    AND         AL,byte ptr [BX]
LF20D:
    CALL        DrawInScrBoundary
    MOV         AL,[LFF05]
    MOV         CH,AL
    MOV         AL,[LFF06]
    MOV         CL,AL
LF216:
    INC         BX
    INC         CH
    MOV         AL,CH
    CMP         AL,CL
    JZ          LF222
    MOV         AL,[Image_PlotOnOff]
    CALL        DrawInScrBoundary
    JMP         LF216
LF222:
    PUSH        BX
    MOV         AL,[LFF08]
    MOV         CL,AL
    MOV         CH,0x0
    MOV         BX,LF010
    ADD         BX,CX
    MOV         AL,byte ptr [BX]
    POP         BX
    PUSH        AX
    PUSHF
    PUSH        word ptr [AFEXTRA2]
    POPF
    MOV         AX,[AFEXTRA1]
    POP         word ptr [AFEXTRA2]
    POP         word ptr [AFEXTRA1]
    JZ          LF236
    PUSH        AX
    PUSHF
    PUSH        word ptr [AFEXTRA2]
    POPF
    MOV         AX,[AFEXTRA1]
    POP         word ptr [AFEXTRA2]
    POP         word ptr [AFEXTRA1]
    OR          AL,byte ptr [BX]
    JMP         DrawInScrBoundary
LF236:
    PUSH        AX
    PUSHF
    PUSH        word ptr [AFEXTRA2]
    POPF
    MOV         AX,[AFEXTRA1]
    POP         word ptr [AFEXTRA2]
    POP         word ptr [AFEXTRA1]
    XOR         AL,0xff
    AND         AL,byte ptr [BX]
    JMP         DrawInScrBoundary


DrawFeature:
    MOV         AL,[Feature_Draw]
    CMP         AL,Plains                      ; Can't Draw Plains
    JS          LAB_0000_1e21
    RET
LAB_0000_1e21:
    SHL         AL,0x1                         ; 8
    SHL         AL,0x1
    SHL         AL,0x1
    MOV         CL,AL
    MOV         AL,[Feature_Size]              ; Add on Size
    ADD         AL,CL
    SHL         AL,0x1                         ; 2
    MOV         CL,AL
    MOV         CH,0x0
    MOV         BX,TerrainAddressTable         ; = 7CFFh
    ADD         BX,CX
    MOV         AL,byte ptr [BX]
    MOV         [FeatureAddress],AL
    INC         BX
    MOV         AL,byte ptr [BX]
    MOV         [FeatureAddress+1],AL
    MOV         AL,0x0
    MOV         [Image_YOffset],AL
    CALL        CalcLineOnScreen               ; Calc Screen Position
    MOV         DI,word ptr [FeatureAddress]
    MOV         AL,byte ptr [DI]
    MOV         [Image_Height],AL              ; 1st byte is the height
LF271:
    INC         DI
    MOV         AL,0x0
    MOV         [Image_AnotherBit],AL
    MOV         AL,0xff
    MOV         [Image_PlotOnOff],AL           ; Set to draw
    MOV         CH,byte ptr [DI]               ; bit 7 = Another Item
    TEST        CH,0x80                        ; bit 6 = draw / erase
    JZ          LF289                          ; bits 5 - 0 = No of Draw Instructions
    MOV         AL,0x1
    MOV         [Image_AnotherBit],AL          ; More than one item on this line
LF289:
    TEST        CH,0x40
    JZ          LF292
    MOV         AL,0x0
    MOV         [Image_PlotOnOff],AL           ; Set erase
LF292:
    MOV         AL,CH
    AND         AL,0x3f
    MOV         [Image_DrawInstrucs],AL        ; How many draw items
    INC         DI
    MOV         CH,byte ptr [DI]               ; Start of Line
    INC         DI
    MOV         CL,byte ptr [DI]               ; End of Line
    CALL        DrawLine                       ; Draw Line / Actually this is an erase
    DEC         DI                             ; For the same two points
    MOV         AL,byte ptr [DI]               ; used for the erased line we
    CALL        PSET                           ; must plot the first
    INC         DI                             ; and last point on the
    MOV         AL,byte ptr [DI]               ; line
    CALL        PSET
    MOV         AL,[Image_PlotOnOff]
    XOR         AL,0xff
    MOV         [Image_PlotOnOff],AL           ; Drawing ON
    MOV         AL,[Image_DrawInstrucs]
    CMP         AL,0x0
    JZ          LF2E8                          ; Skip if no draw instrucs left
LF2C4:
    INC         DI
    MOV         AL,byte ptr [DI]
    TEST        AL,128                         ; Bit 7 = DrawLine
    JNZ         LF2D4                          ; else just do a point
    AND         AL,0x7f                        ; What pixel
    CALL        PRESET                         ; Set it
    JMP         LF2DF
LF2D4:
    AND         AL,0x7f
    MOV         CH,AL                          ; CH = startofline
    INC         DI
    MOV         CL,byte ptr [DI]               ; CL = End
    CALL        DrawLine                       ; Draw the line
LF2DF:
    MOV         AL,[Image_DrawInstrucs]
    DEC         AL
    MOV         [Image_DrawInstrucs],AL
    JNZ         LF2C4                          ; Repeat if are more draw instrucs
LF2E8:
    MOV         AL,[Image_AnotherBit]
    CMP         AL,0x0
    JNZ         LF271                          ; repeat if more bits
    MOV         AL,[Image_YOffset]
    INC         AL
    MOV         [Image_YOffset],AL             ; next Line up
    CALL        CalcLineOnScreen               ; recalc screen position
    MOV         AL,[Image_Height]
    DEC         AL
    MOV         [Image_Height],AL
    JZ          LAB_0000_1ee2
    JMP         LF271                          ; repeat if more lines to process
LAB_0000_1ee2:
    RET


CalcLineOnScreen:
    MOV         AL,[Image_YOffset]
    MOV         CH,AL
    MOV         AL,[Image_YPixel]
    ADD         AL,CH
    MOV         CH,AL
    MOV         AL,0xaf
    SUB         AL,CH
    MOV         CH,AL
    AND         AL,0x7
    OR          AL,0x40
    MOV         DH,AL
    MOV         AL,CH
    SHR         AL,0x1
    SHR         AL,0x1
    SHR         AL,0x1
    AND         AL,0x18
    OR          AL,DH
    MOV         DH,AL
    MOV         AL,CH
    SHL         AL,0x1
    SHL         AL,0x1
    AND         AL,0xe0
    MOV         DL,AL
    SUB         DX,Screen[4515]
    ADD         DX,Screen
    RET


CalcMapLocation:
    MOV         CX,word ptr [WorkingLocation]
    XOR         AL,AL
    CMP         AL,CH
    JZ          OffTheMap                      ; Not On Map
    MOV         AL,0x3d
    CMP         AL,CH
    JC          OffTheMap                      ; Not On Map
    MOV         AL,0x3f
    CMP         AL,CL
    JC          OffTheMap                      ; Not On Map
    CALL        CalcMapHL                      ; Reference FeatureMap
    MOV         AL,byte ptr [BX]               ; Get from map
    MOV         DH,AL
    AND         AL,0xf                         ; first 4 bits
    MOV         [LocationFeature],AL           ; are the feature
    MOV         AL,DH
    SHR         AL,0x1                         ; Rotate is right
    SHR         AL,0x1                         ; 4 times to get the
    SHR         AL,0x1                         ; second 4 bits
    SHR         AL,0x1
    MOV         [LocationObject],AL            ; they are the object
    MOV         CX,0xf40
    ADD         BX,CX                          ; Reference Description Map
    MOV         AL,byte ptr [BX]
    MOV         DH,AL
    AND         AL,0x3f                        ; First six bits are the area
    MOV         [LocationArea],AL
    MOV         AL,DH
    AND         AL,0x40                        ; Bit seven is the Domain flag (Are we in one!)
    MOV         [LocDomainFlag],AL
    MOV         AL,DH
    AND         AL,0x80                        ; Bit
    JMP         LF432
OffTheMap:
    MOV         AL,FrozenWaste
    MOV         [LocationFeature],AL
    MOV         AL,NoObjectAtAll
    MOV         [LocationObject],AL
    MOV         [LocationArea],AL
    MOV         [LocDomainFlag],AL
LF432:
    MOV         [LocSpecialFlag],AL
    RET


CalcMapHL:
    PUSH        CX
    MOV         CL,0x0
    SHR         CX,0x2
    MOV         BX,MainMapCalcHLTable
    ADD         BX,CX
    POP         CX
    MOV         CH,0x0
    ADD         BX,CX
    RET


DrawGraphicView:
    MOV         AL,[LandscapePosition]
    SHL         AL,0x1
    MOV         CH,AL
    SHL         AL,0x1                         ; 6
    ADD         AL,CH
    MOV         CL,AL
    MOV         CH,0x0
    MOV         BX,LandscapeLocCalcTable
    ADD         BX,CX
    MOV         AL,byte ptr [BX]
    MOV         [Landscape_YAdjustDoWhat],AL
    INC         BX
    MOV         AL,byte ptr [BX]
    MOV         [Landscape_XAdjustDoWhat],AL
    INC         BX
    MOV         AL,byte ptr [BX]
    MOV         [Landscape_ScrAdjust],AL
    INC         BX
    MOV         AL,byte ptr [BX]
    MOV         [Landscape_ScrAdjust+1],AL
    INC         BX
    MOV         AL,byte ptr [BX]
    MOV         [Image_YPixel],AL
    INC         BX
    MOV         AL,byte ptr [BX]
    MOV         [Feature_Size],AL
    MOV         AL,[CurrentLocation]
    MOV         CH,AL
    MOV         AL,[Landscape_XAdjustDoWhat]
    CALL        LF4D8
    MOV         [WorkingLocation],AL
    MOV         AL,[CurrentLocation+1]
    MOV         CH,AL
    MOV         AL,[Landscape_YAdjustDoWhat]
    CALL        LF4D8
    MOV         [WorkingLocation+1],AL
    CALL        CalcMapLocation
    MOV         BX,0x140
    MOV         CX,word ptr [Landscape_ScrAdjust]
    MOV         AL,[Landscape_ScrAdjustDoWhat]
    CMP         AL,0x0
    JNZ         LF4A8
    ADD         BX,CX
    MOV         word ptr [Image_XPixel],BX
    JMP         LF4CE
LF4A8:
    CMP         AL,0x1
    JNZ         LF4B4
    AND         AL,AL                          ; Clear carry
    SBB         BX,CX
    MOV         word ptr [Image_XPixel],BX
    JMP         LF4CE
LF4B4:
    CMP         AL,0x2
    JNZ         LF4C4
    ADD         BX,CX
    MOV         CX,0x64
    AND         AL,AL
    SBB         BX,CX
    MOV         word ptr [Image_XPixel],BX
    JMP         LF4CE
LF4C4:
    AND         AL,AL
    SBB         BX,CX
    MOV         CX,0x64
    ADD         BX,CX
    MOV         word ptr [Image_XPixel],BX
LF4CE:
    MOV         AL,[LocationFeature]
    MOV         [Feature_Draw],AL
    CALL        DrawFeature
    RET


LF4D8:
    CMP         AL,0x0
    JNZ         LF4E1
    MOV         AL,[Landscape_YAdjustDoWhat]
    ADD         AL,CH
    RET
LF4E1:
    CMP         AL,0x1
    JNZ         LF4EC
    MOV         AL,[Landscape_YAdjustDoWhat]
    MOV         CL,AL
    MOV         AL,CH
    SUB         AL,CL
    RET
LF4EC:
    CMP         AL,0x2
    JNZ         LF4F5
    MOV         AL,[Landscape_XAdjustDoWhat]
    ADD         AL,CH
    RET
LF4F5:
    MOV         AL,[Landscape_XAdjustDoWhat]
    MOV         CL,AL
    MOV         AL,CH
    SUB         AL,CL
    RET


DrawGraphicVision:
    MOV         AL,0x1
    MOV         [Landscape_LeftScrDoWhat],AL
    MOV         AL,0x0
    MOV         [Landscape_RightScrDoWhat],AL
    MOV         AL,[CurrentlyLooking]          ; Where are we looking?
    AND         AL,0x1                         ; If bit 1 is set then
    CMP         AL,0x0                         ; we are looking NE,SE,SW,NW
    JZ          LF519                          ; otherwisw its N,E,S,W
    MOV         AL,0x2
    MOV         [Landscape_LeftScrDoWhat],AL
    MOV         AL,0x3
    MOV         [Landscape_RightScrDoWhat],AL
LF519:
    MOV         AL,[CurrentlyLooking]
    MOV         CL,AL
    MOV         CH,0x0
    MOV         BX,LandscapeDirAdjustTableX
    ADD         BX,CX
    MOV         AL,byte ptr [BX]
    MOV         [Landscape_LeftXAdjustDoWhat],AL
    INC         BX
    MOV         AL,byte ptr [BX]
    MOV         [Landscape_RightXAdjustDoWhat],AL
    MOV         BX,LandscapeDirAdjustTableY
    ADD         BX,CX
    MOV         AL,byte ptr [BX]
    MOV         [Landscape_LeftYAdjustDoWhat],AL
    INC         BX
    MOV         AL,byte ptr [BX]
    MOV         [Landscape_RightYAdjustDoWhat],AL
    MOV         AL,0x0
    MOV         [LandscapePosition],AL
LF53E:
    MOV         AL,[Landscape_LeftScrDoWhat]
    MOV         [Landscape_ScrAdjustDoWhat],AL
    MOV         AL,[Landscape_LeftXAdjustDoWhat]
    MOV         [Landscape_XAdjustDoWhat],AL
    MOV         AL,[Landscape_LeftYAdjustDoWhat]
    MOV         [Landscape_YAdjustDoWhat],AL
    CALL        DrawGraphicView
    MOV         AL,[Landscape_RightScrDoWhat]
    MOV         [Landscape_ScrAdjustDoWhat],AL
    MOV         AL,[Landscape_RightXAdjustDoWhat]
    MOV         [Landscape_XAdjustDoWhat],AL
    MOV         AL,[Landscape_RightYAdjustDoWhat]
    MOV         [Landscape_YAdjustDoWhat],AL
    CALL        DrawGraphicView
    MOV         AL,[LandscapePosition]
    INC         AL
    MOV         [LandscapePosition],AL
    CMP         AL,0x1f
    JNZ         LF53E
    RET


LocateOnScreen:
    MOV         AL,[Print_Row]
    MOV         BH,AL                          ; HL = Attributes
    AND         AL,0x18                        ; DE = ScreenAddress
    OR          AL,0x40
    MOV         DH,AL
    MOV         BL,0x0
    SHR         BX,0x3
    MOV         AL,BH
    OR          AL,0x58
    MOV         BH,AL
    MOV         AL,[Print_Col]
    OR          AL,BL
    MOV         BL,AL
    MOV         DL,AL
    SUB         BX,Screen[4515]
    ADD         BX,Screen
    SUB         DX,Screen[4515]
    ADD         DX,Screen
    RET


PrintAsciiChar:
    CALL        LocateOnScreen
    MOV         AL,[Print_Attr]
    MOV         byte ptr [BX],AL
    MOV         BH,0x0
    MOV         AL,[Print_Char]
    MOV         BL,AL
    ADD         BX,BX
    ADD         BX,BX
    ADD         BX,BX
    MOV         CX,word ptr [CHARS]
    ADD         BX,CX
    MOV         CH,0x8
    MOV         AL,[Print_Mask]
    MOV         CL,AL
LF5C3:
    MOV         AL,byte ptr [BX]
    XOR         AL,CL
    MOV         BP,DX
    MOV         byte ptr DS:[BP + 0x0],AL
    INC         BX
    INC         DH
    DEC         CH
    JNZ         LF5C3
    RET


DisplayCharacter:
    MOV         BX,word ptr [CHARS]
    PUSH        BX
    MOV         BX,CharacterGraphics
    MOV         word ptr [CHARS],BX=>CharacterGraphics
    XOR         AL,AL
    MOV         [Print_Mask],AL
    MOV         BX,CharDataTable               ; CharacterDataTable
    MOV         AL,[CharacterToPrint]
    ADD         AL,AL
    MOV         CH,AL                          ; 6
    ADD         AL,AL
    ADD         AL,CH
    MOV         CL,AL
    MOV         CH,0x0
    ADD         BX,CX
    MOV         AL,byte ptr [BX]
    MOV         [Window_Depth],AL              ; Depth of Character
    MOV         CH,AL
    INC         BX
    MOV         AL,byte ptr [BX]
    MOV         [Window_Width],AL              ; Width of Character
    MOV         AL,[Row]
    SUB         AL,CH
    INC         AL
    MOV         [Print_Row],AL
    INC         BX
    MOV         CL,byte ptr [BX]               ; BC=Address Character Data
    INC         BX
    MOV         CH,byte ptr [BX]
    INC         BX
    MOV         DL,byte ptr [BX]               ; DE=Attributes Character
    INC         BX
    MOV         DH,byte ptr [BX]
    XOR         AL,AL
    MOV         BH,AL
LF603:
    XOR         AL,AL
    MOV         BL,AL
    MOV         AL,[Column]
    MOV         [Print_Col],AL
LF60B:
    MOV         BP,CX
    MOV         AL,byte ptr DS:[BP + 0x0]
    MOV         [Print_Char],AL
    CMP         AL,0x0
    JZ          LF62A
    MOV         BP,DX
    MOV         AL,byte ptr DS:[BP + 0x0]
    PUSH        BX
    MOV         BH,AL
    MOV         AL,[Window_Attr]
    AND         AL,BH
    MOV         BH,AL
    MOV         AL,[Print_Ink]
    OR          AL,BH
    MOV         [Print_Attr],AL
    PUSH        CX
    PUSH        DX
    CALL        PrintAsciiChar
    POP         DX
    POP         CX
    POP         BX
LF62A:
    INC         DX
    INC         CX
    MOV         AL,[Print_Col]
    INC         AL
    MOV         [Print_Col],AL
    INC         BL
    MOV         AL,[Window_Width]
    CMP         AL,BL
    JNZ         LF60B
    INC         BH
    MOV         AL,[Print_Row]                 ; New Row
    INC         AL
    MOV         [Print_Row],AL
    MOV         AL,[Window_Depth]
    CMP         AL,BH                          ; Have We Finised
    JNZ         LF603
    POP         BX
    MOV         word ptr [CHARS],BX
    RET


CopyScreen:
    CMP         byte ptr [PrinterFlag],0x0
    JZ          LAB_0000_21fc
    PUSHA
    PUSH        DS
    PUSH        ES
    CALL        Dumpscreen
    POP         ES
    POP         DS
    POPA
LAB_0000_21fc:
    RET


Bytes_Print_Buffer:
    POP         BX
    PUSH        ES
    PUSH        CS
    POP         ES
    CALL        FillPrintBuffer
    INC         BX
    POP         ES
    PUSH        BX
    RET


DecodeToken:
    MOV         AL,[Print_Temp]                ; AL=Token Required
    MOV         BX,0x0                         ; BX=Required Byte
    MOV         CH,AL
    INC         CH                             ; One more than required token
LF698:
    MOV         CL,CH
    CALL        GetRequiredByte
    MOV         CH,CL                          ; Is this the start of
    DEC         CH                             ; the Token we want?
    JNZ         LF6A1
    JMP         GetTokenChars
LF6A1:
    MOV         DH,0x0                         ; No
    MOV         DL,AL                          ; Add on the length of
    ADD         BX,DX                          ; this token to our required
    JMP         LF698                          ; Byte and loop
GetTokenChars:
    DEC         AL                             ; Length-1
    MOV         CH,AL                          ; Set up loop
    MOV         AL,[TextLength]                ; Increment the text buffer length
    ADD         AL,CH
    MOV         [TextLength],AL
    INC         BX
    MOV         DX,word ptr [TextBuffer]       ; Position in buffer
LF6B5:
    MOV         CL,CH
    CALL        GetASCIIchar                   ; Get the ASCII byte
    DEC         CH
    JNZ         LF6B5                          ; Loop for all Chars.
    MOV         word ptr [TextBuffer],DX
    RET


PrintWordFromBuffer:
    MOV         AL,[ViewPoint_Col]
    MOV         CH,AL                          ; What Column are we on?
    MOV         AL,[TextLength]                ; How Big is this line?
    ADD         AL,CH
    MOV         CL,AL
    MOV         AL,[ViewPoint_Width]           ; What's the width of our viewpoint?
    SUB         AL,CL                          ; Check to see if there's enough space.
    JS          LAB_0000_225b                  ; We're Okay to print.
    JMP         LF6DE
LAB_0000_225b:
    MOV         AL,[ViewPoint_StartCol]
    DEC         AL
    MOV         [ViewPoint_Col],AL             ; Reset the Column.
    MOV         AL,[ViewPoint_Row]
    INC         AL                             ; Next Row.
    MOV         [ViewPoint_Row],AL
LF6DE:
    MOV         AL,[ViewPoint_Col]             ; Next Column.
    INC         AL
    MOV         [Print_Col],AL                 ; Set column to print at!
    MOV         AL,[ViewPoint_Row]
    MOV         [Print_Row],AL                 ; Row That we are on.
    CMP         AL,0x18                        ; Deep shit if we get this far!
    JNZ         LAB_0000_227e
    RET
LAB_0000_227e:
    MOV         BX,WorkSpaceArea               ; Start of buffer to print.
LF6F1:
    MOV         AL,byte ptr [BX]               ; Get Byte to print.
    CALL        DecideCase                     ; Decide wether the letter needs uppercasing
    MOV         [Print_Char],AL                ; Set byte to print.
    INC         BX                             ; Next byte!
    PUSH        BX=>WorkSpaceArea[1]
    CALL        PrintAsciiChar                 ; Print the character.
    MOV         AL,[Print_Col]
    INC         AL                             ; One column on.
    MOV         [Print_Col],AL
    POP         BX
    MOV         AL,[TextLength]                ; How many Charcters?
    DEC         AL                             ; one less!
    MOV         [TextLength],AL                ; Store away.
    CMP         AL,0x0                         ; Have we printed them all?
    JNZ         LF6F1                          ; Loop until we have
    MOV         AL,[Print_Col]
    MOV         [ViewPoint_Col],AL             ; Update the variables.
    RET

; Print the message to the buffer
;
; Messages in the game are stored in a tokenised format.
; As each byte is read and is checked to see if it's a special code, otherwise
; the word is looked up in the token dictionary; this word is used in all 
; lowercase. The next token is read to check if it's either a CONNECT or LITERAL,
; if it is then this new text is added to the current word and the next token is
; checked again, otherwise the word is printed with a space at the end.
PrintOutBuffer:
    MOV         BX,word ptr [PrintBufferStart]
LF71A:
    MOV         DX,WorkSpaceArea               ; Print Output Destination address
    MOV         word ptr [TextBuffer],DX=>WorkSpaceArea
    XOR         AL,AL                          ; Reset these variables.
    MOV         [MakeFirstCharUpper],AL
    MOV         [TextLength],AL
LF728:
    MOV         AL,byte ptr [BX]               ; Get the bytes.
LF729:
    CMP         AL,0xff                        ; was it a terminator?
    JNZ         LAB_0000_22c4                  ; Finished if it was.
    RET
LAB_0000_22c4:
    CMP         AL,0xfe                        ; Are we expecting a Literal?
    JZ          DealWithLiteral
    CMP         AL,0xfc                        ; Upper case Token?
    JZ          UppercaseToken
    CMP         AL,0xfb                        ; Next Line?
    JZ          StartOfNextLine
LF738:
    MOV         [Print_Temp],AL                ; Token to decode.
    PUSH        BX
    CALL        DecodeToken
    POP         BX
LF740:
    INC         BX
    MOV         AL,byte ptr [BX]
    CMP         AL,0xfe                        ; Literal?
    JZ          DealWithLiteral
    CMP         AL,0xfd                        ; Connect Token to last word
    JZ          ConnectTokenToLast
    PUSH        BX                             ; Time to print the last words
    CALL        PrintWordFromBuffer            ; Made up in buffer.
    POP         BX
    JMP         LF71A                          ; Loop all over again.
UppercaseToken:
    MOV         [MakeFirstCharUpper],AL
    INC         BX
    MOV         AL,byte ptr [BX]
    JMP         LF729
StartOfNextLine:
    MOV         AL,[ViewPoint_StartCol]
    MOV         [ViewPoint_Col],AL
    MOV         AL,[ViewPoint_Row]
    INC         AL
    MOV         [ViewPoint_Row],AL
    INC         BX
    JMP         LF728
DealWithLiteral:
    INC         BX
    MOV         AL,byte ptr [BX]
    MOV         DX,word ptr [TextBuffer]
    MOV         BP,DX
    MOV         byte ptr DS:[BP + 0x0],AL
    INC         DX
    MOV         word ptr [TextBuffer],DX
    MOV         AL,[TextLength]
    INC         AL
    MOV         [TextLength],AL
    JMP         LF740
ConnectTokenToLast:
    INC         BX
    MOV         AL,byte ptr [BX]
    JMP         LF738


DecideCase:
    MOV         CH,AL
    MOV         AL,[UpperCaseFlag]             ; If uppercase flag is set
    CMP         AL,0x0                         ; then we'll have to make
    JNZ         LowerToUpperFirstChar          ; All characters uppercase!
    MOV         AL,[MakeFirstCharUpper]        ; Other wise check wether only
    CMP         AL,0x0                         ; the first char needs making
    JNZ         LowerToUpperFirstChar          ; uppercase
    MOV         AL,CH
    RET
LowerToUpperFirstChar:
    XOR         AL,AL
    MOV         [MakeFirstCharUpper],AL
LowerToUpperFirstChar:
    MOV         AL,CH
    CMP         AL,0x61
    JNS         LAB_0000_2343
    RET
LAB_0000_2343:
    CMP         AL,0x7a
    JS          LAB_0000_2348
    RET
LAB_0000_2348:
    AND         AL,0xdf
    RET


FillPrintBuffer:
    PUSH        DX
    MOV         DX,word ptr [PrintBufferPos]   ; DE=Start of Print Buffer
LF7A5:
    MOV         AL,byte ptr ES:[BX]            ; Get the byte
    MOV         BP,DX                          ; Store byte away.
    MOV         byte ptr DS:[BP + 0x0],AL
    CMP         AL,0xff                        ; Was it the last one?
    JZ          LF7AF                          ; Exit out!
    INC         BX                             ; Increase Source
    INC         DX                             ; Increase destination
    JMP         LF7A5                          ; Loop.
LF7AF:
    MOV         word ptr [PrintBufferPos],DX
    POP         DX
    RET


FlushPrintBuffer:
    CALL        TerminatorToBuffer
    MOV         BX,WorkSpaceArea[32]
    MOV         word ptr [PrintBufferPos],BX=>WorkSpaceArea[32]
    MOV         word ptr [PrintBufferStart],BX=>WorkSpaceArea[32]
    JMP         PrintOutBuffer


SetTokenToUpperCase:
    MOV         AL,0xfc                        ; UPPERCASE token


A_IntoPrintBuffer:
    PUSH        BX
    MOV         BX,word ptr [PrintBufferPos]
    MOV         byte ptr [BX],AL
    INC         BX
    MOV         word ptr [PrintBufferPos],BX
    POP         BX
    RET


SetTokenToLowerCase:
    MOV         AL,0xfb
    JMP         A_IntoPrintBuffer


AddTokenWithConnect:
    PUSH        CX
    MOV         CH,AL
    MOV         AL,0xfd                        ; CONNECT
    CALL        A_IntoPrintBuffer
    MOV         AL,CH
    CALL        A_IntoPrintBuffer
    POP         CX
    RET


AddLiteralToBuffer:
    PUSH        CX
    MOV         CH,AL
    MOV         AL,0xfe                        ; LITERAL
    CALL        A_IntoPrintBuffer
    MOV         AL,CH
    CALL        A_IntoPrintBuffer
    POP         CX
    RET


TerminatorToBuffer:
    MOV         AL,0xff                        ; TERMINATOR
    JMP         A_IntoPrintBuffer


SToBuffer:
    MOV         AL,0x73
    JMP         AddLiteralToBuffer


StopToBuffer:
    MOV         AL,0x2e
    JMP         AddLiteralToBuffer


CommaToBuffer:
    MOV         AL,0x2c
    JMP         AddLiteralToBuffer


PercentToBuffer:
    MOV         AL,0x25
    JMP         AddLiteralToBuffer


AndSignTobuffer:
    MOV         AL,0x26
    JMP         AddLiteralToBuffer


PlinkToBuffer:
    MOV         AL,0x21
    JMP         AddLiteralToBuffer


HashToBuffer:
    MOV         AL,0x23
    JMP         AddLiteralToBuffer
SpaceToBuffer:
    MOV         AL,0x20
    JMP         AddLiteralToBuffer


PluralToken:
    CALL        A_IntoPrintBuffer
    MOV         AL,[QuantityFlag]
    CMP         AL,0x0
    JNZ         LAB_0000_23d9
    RET
LAB_0000_23d9:
    JMP         SToBuffer


TestFeatureForPlural:
    MOV         AL,[LocationFeature]
    CMP         AL,Mountain
    JZ          LocationPlural
    CMP         AL,Downs
    JZ          LocationPlural
    CMP         AL,FrozenWaste
    JZ          LocationPlural
    CMP         AL,Army
    JNZ         LF832
    INC         AL
LF832:
    CMP         AL,Plains
    JZ          LocationPlural
    MOV         AL,0x0
    MOV         [QuantityFlag],AL              ; Location Singular
    MOV         AL,[LocationFeature]
    RET
LocationPlural:
    MOV         AL,0xff                        ; TERMINATOR
    MOV         [QuantityFlag],AL
    MOV         AL,[LocationFeature]
    RET


DescribeLocation:
    MOV         AL,[LocDomainFlag]
    CMP         AL,0x0                         ; is it any where special?
    JNZ         DescribeFeature                ; if so describe the feature
    CALL        TestFeatureForPlural
    CMP         AL,Henge
    JZ          ItsAHenge
    CMP         AL,Lake
    JZ          ItsALake
    CMP         AL,FrozenWaste
    JZ          ItsFrozenWaste
    CMP         AL,Army                        ; if it's an army
    JNZ         LF866
    INC         AL                             ; Then pretend its a Plain!
    MOV         [QuantityFlag],AL
LF866:
    ADD         AL,0x41                        ; Feature Token
    MOV         CH,AL
    XOR         AL,AL                          ; 'The'
    CALL        A_IntoPrintBuffer
    CALL        SetTokenToUpperCase
    MOV         AL,CH                          ; what
    CALL        PluralToken
    MOV         AL,0x40                        ; 'Of'
    CALL        A_IntoPrintBuffer


DescribeLocationArea:
    MOV         AL,[LocationArea]
    CMP         AL,0x7                         ; Lost
    JZ          ItNeedsThe
    CMP         AL,0x20                        ; Moon
    JZ          ItNeedsThe
    CMP         AL,0x39                        ; Targ
    JZ          ItNeedsThe


PrintPlaceDescription:
    CALL        SetTokenToUpperCase
LF88B:
    MOV         AL,[LocationArea]
    JMP         A_IntoPrintBuffer
ItNeedsThe:
    XOR         AL,AL
    CALL        A_IntoPrintBuffer
    JMP         PrintPlaceDescription
ItsAHenge:
    CALL        PrintPlaceDescription
    MOV         AL,0x44
    JMP         AddTokenWithConnect
ItsALake:
    CALL        Bytes_Print_Buffer
    db 0FCh,04Ah,0FCh,0FFh                      ; 'Lake'
    JMP         PrintPlaceDescription::LF88B
ItsFrozenWaste:
    CALL        Bytes_Print_Buffer
    db 000h,0FCh,051h,0FCh,04Bh,0FFh            ; 'The Frozen Waste'
    JMP         SToBuffer
DescribeFeature:
    CALL        TestFeatureForPlural
    MOV         AL,[QuantityFlag]
    CMP         AL,0x0                         ; Single or plural
    JNZ         LF8C3                          ; Plural!
    MOV         AL,0x53                        ; 'A'
    CALL        A_IntoPrintBuffer
LF8C3:
    MOV         AL,[LocationFeature]
    CMP         AL,Army                        ; Is there an army?
    JNZ         LF8CB                          ; No.
    INC         AL                             ; Pretend its plains
LF8CB:
    ADD         AL,0x41                        ; Description Token
    CALL        PluralToken
    CALL        Bytes_Print_Buffer
    db 054h,000h,0FCh,052h,040h,0FFh            ; 'In The Domain of'
    JMP         DescribeLocationArea


DescribeWhereHeIs:
    CALL        Bytes_Print_Buffer
    db 0FCh,055h,056h,0FEh,073h,0FFh            ; 'He Stands'
    MOV         BX,word ptr [CurrentLocation]
    MOV         word ptr [WorkingLocation],BX
    CALL        CalcMapLocation
    MOV         AL,[LocationArea]              ; Where Abouts are we?
    MOV         CH,AL
    MOV         AL,[LocDomainFlag]
    MOV         CL,AL
    MOV         AL,[LocationFeature]           ; What is here?
    MOV         DH,AL
    PUSH        CX
    PUSH        DX
    MOV         CH,0x0                         ; Work out the correct
    MOV         CL,AL                          ; terminology for the
    MOV         BX,WhereTable                  ; place we are
    ADD         BX,CX                          ; AT/IN/ON/BESIDE
    MOV         AL,byte ptr [BX]
    CALL        A_IntoPrintBuffer
    CALL        DescribeLocation
    CALL        CommaToBuffer
    MOV         AL,0x5b                        ; 'Looking'
    CALL        A_IntoPrintBuffer
    CALL        LookingWhere
    MOV         BX,word ptr [LocationLookingAt]
    MOV         word ptr [WorkingLocation],BX
    CALL        CalcMapLocation
    POP         DX
    POP         CX
    MOV         AL,[LocationArea]              ; Different Area?
    CMP         AL,CH
    JNZ         LookingSomeWhereElse
    MOV         AL,[LocDomainFlag]             ; Different Domain
    CMP         AL,CL
    JNZ         LookingSomeWhereElse
    MOV         AL,[LocationFeature]           ; Same Feature
    CMP         AL,DH
    JZ          LF93A
LookingSomeWhereElse:
    MOV         AL,0x5c
    CALL        A_IntoPrintBuffer              ; 'To'
    CALL        DescribeLocation
LF93A:
    JMP         StopToBuffer


LookingWhere:
    MOV         AL,[CurrentlyLooking]
    MOV         BX,DirectionTable
    MOV         CH,0x0
    ADD         AL,AL
    MOV         CL,AL
    ADD         BX,CX
    MOV         AL,byte ptr [BX]
    MOV         DH,AL
    INC         BX
    MOV         AL,byte ptr [BX]
    MOV         DL,AL
    CALL        SetTokenToUpperCase
    MOV         AL,DH
    CALL        A_IntoPrintBuffer
    MOV         AL,DL
    CMP         AL,0x0
    JNZ         LAB_0000_2533
    RET
LAB_0000_2533:
    JMP         AddTokenWithConnect


PrintTimeStatus:
    MOV         AL,[TempVar]
    CMP         AL,0x1
    JC          KnightTyme
    MOV         CH,0x0
    SHR         AL,0x1
    RCL         CH,0x1
    CMP         AL,0x8
    JZ          DawnTyme
    MOV         CL,AL
    MOV         AL,CH
    CMP         AL,0x0
    JZ          ActualHoursRemaining
    INC         CL
    CALL        Bytes_Print_Buffer
    db 060h,061h,0FFh                           ; 'Less Than'
ActualHoursRemaining:
    MOV         AL,CL
    DEC         AL
    MOV         [QuantityFlag],AL              ; Token for Number of hours
    MOV         AL,0x62
    ADD         AL,CL
    CALL        A_IntoPrintBuffer
    MOV         AL,0x62                        ; 'Hour'
    CALL        PluralToken
    CALL        Bytes_Print_Buffer
    db 040h,000h,06Eh,0FFh                      ; 'Of The Day'
    MOV         AL,[QuantityFlag]
    CMP         AL,0x0
    JNZ         AFewHourRemain
    INC         AL                             ; One
    JMP         HoursRemaining
AFewHourRemain:
    XOR         AL,AL
HoursRemaining:
    MOV         [QuantityFlag],AL
    MOV         AL,0x6d                        ; 'Remain'
    JMP         PluralToken
KnightTyme:
    CALL        Bytes_Print_Buffer 
    db 06Fh,070h,071h,0FFh                      ; 'It Is Night'
    RET
DawnTyme:
    CALL        Bytes_Print_Buffer 
    db 06Fh,070h,03Dh,0FFh                      ; 'It is Dawn'
    RET


FindLookingTowards:
    MOV         BX,word ptr [CurrentLocation]
    MOV         word ptr [WorkingLocation],BX
    MOV         AL,[CurrentlyLooking]
    MOV         CL,AL
    MOV         CH,0x0
    MOV         BX,DirectionLookTable
    SHL         CL,0x1
    ADD         BX,CX
    MOV         AL,byte ptr [BX]
    MOV         [MapYLookAdjust],AL
    INC         BX
    MOV         AL,byte ptr [BX]
    MOV         [MapXLookAdjust],AL
    XOR         AL,AL
    MOV         [LookForwardCount],AL
LF9F2:
    MOV         AL,[MapYLookAdjust]
    MOV         CH,AL                          ; Looking North/South
    MOV         AL,[WorkingLocation]           ; towards which Location?
    ADD         AL,CH                          ; recalc
    MOV         [WorkingLocation],AL           ; Well This one of course!
    MOV         AL,[MapXLookAdjust]
    MOV         CH,AL
    MOV         AL,[WorkingLocation+1]
    ADD         AL,CH
    MOV         [WorkingLocation+1],AL
    MOV         AL,[LookForwardCount]
    CMP         AL,0x0
    JNZ         LFA15
    MOV         BX,word ptr [WorkingLocation]
    MOV         word ptr [DesirableLocation],BX
LFA15:
    CALL        CalcMapLocation
    MOV         AL,[LocationFeature]           ; What are we looking at?
    CMP         AL,Plains
    JNZ         LFA2A                          ; No - We found Something
    MOV         AL,[LookForwardCount]          ; Yes
    INC         AL                             ; We can therefore look forward
    MOV         [LookForwardCount],AL          ; until we find something or
    CMP         AL,0x3                         ; three locations infront!
    JNZ         LF9F2
LFA2A:
    MOV         BX,word ptr [WorkingLocation]
    MOV         word ptr [LocationLookingAt],BX
    RET


PrintShieldBit:
    MOV         AL,[Print_Temp]
    ADD         AL,AL
    ADD         AL,AL                          ; 4
    MOV         CL,AL
    MOV         CH,0x0
    MOV         BX,ShieldPartsTable            ; = 797Eh
    ADD         BX,CX                          ; From Table at LDE8C
    MOV         DL,byte ptr [BX]
    INC         BX                             ; DE=Address of Data
    MOV         DH,byte ptr [BX]
    INC         BX
    MOV         AL,byte ptr [BX]
    MOV         [Window_Depth],AL
    MOV         CL,AL
    INC         BX
    MOV         AL,byte ptr [BX]               ; Depth of data
    MOV         [Window_Width],AL              ; Width of data
    MOV         CH,AL
    MOV         AL,[Shield_Ink]                ; Ink
    MOV         BH,AL
    MOV         AL,[Shield_Paper]              ; Paper
    OR          AL,0x40
    ADD         AL,BH
    MOV         [Print_Attr],AL
    MOV         BX,word ptr [Column]           ; L=Row
    INC         BH                             ; H=Column
    MOV         AL,BL
    ADD         AL,0x19
    MOV         BL,AL
    MOV         word ptr [Column],BX
    MOV         word ptr [Print_Col],BX
LFA77:
    MOV         BP,DX
    MOV         AL,byte ptr DS:[BP + 0x0]
    CMP         AL,0x0                         ; is it printable?
    JZ          LFA86                          ; No. skip the print.
    MOV         [Print_Char],AL                ; Yes. Char to print
    PUSH        CX
    PUSH        DX
    CALL        PrintAsciiChar                 ; Print it
    POP         DX
    POP         CX
LFA86:
    MOV         AL,[Print_Col]
    INC         AL                             ; Next column position
    MOV         [Print_Col],AL
    INC         DX
    DEC         CH                             ; Loop until finished row!
    JNZ         LFA77
    MOV         AL,[Column]                    ; Reset the print Column
    MOV         [Print_Col],AL
    MOV         AL,[Window_Width]              ; Reset the print width
    MOV         CH,AL
    MOV         AL,[Print_Row]                 ; One row down.
    INC         AL
    MOV         [Print_Row],AL
    DEC         CL                             ; One less of the depth
    MOV         AL,CL
    CMP         AL,0x0                         ; Have we finished?
    JNZ         LFA77                          ; Loop until we have.
    RET


PrintShield:
    MOV         BX,word ptr [CHARS]
    PUSH        BX
    MOV         BX,ShieldInc
    MOV         word ptr [CHARS],BX=>ShieldInc
    MOV         AL,[ShieldNumber]
    ADD         AL,AL
    ADD         AL,AL
    ADD         AL,AL                          ; 8
    MOV         CL,AL
    MOV         CH,0x0
    MOV         BX,ShieldConstructTable        ; Entry in table at LDEA8
    ADD         BX,CX
    MOV         AL,byte ptr [BX]               ; Get the first byte.
    ADD         AL,AL                          ; this is the shields paper.
    ADD         AL,AL
    ADD         AL,AL                          ; 8
    MOV         [Shield_Paper],AL
    MOV         AL,0xff
    MOV         [Print_Mask],AL
    XOR         AL,AL                          ; Part of shield to print!
    MOV         [Print_Temp],AL                ; is going to be the main shield
    MOV         [Column],AL                    ; first at :- Column=0
    MOV         [Row],AL                       ; Row=0
    INC         AL
    MOV         [Shield_Ink],AL                ; Ink of Blue
LFAD9:
    PUSH        BX
    CALL        PrintShieldBit
    POP         BX
    INC         BX
    MOV         AL,byte ptr [BX]               ; Get the next bit!
    CMP         AL,0x0                         ; Have we finished?
    JZ          LFB08                          ; Exit if we have.
    MOV         CH,AL                          ; Preserve value
    AND         AL,0x7                         ; First three bits.
    MOV         [Print_Temp],AL                ; are the bit type 0 to 7
    MOV         AL,CH                          ; Restore Value
    SHR         AL,0x1
    SHR         AL,0x1
    SHR         AL,0x1                         ; Next three bits are
    MOV         [Shield_Ink],AL                ; the parts ink. 0 to 31!
    INC         BX
    MOV         AL,byte ptr [BX]               ; Next byte
    MOV         CH,AL                          ; Preserve value
    AND         AL,0x7                         ; First three bits are
    MOV         [Column],AL                    ; the column. 0 to 7
    MOV         AL,CH                          ; Restore Value
    SHR         AL,0x1
    SHR         AL,0x1
    SHR         AL,0x1                         ; Next threee bits are
    MOV         [Row],AL                       ; the row. 0 to 31!
    JMP         LFAD9                          ; Loop.
LFB08:
    POP         BX
    MOV         word ptr [CHARS],BX
    RET


ClearWindow:
    PUSH        BX
    MOV         BX,Font                        ; C=Row, B=Col
    MOV         word ptr [CHARS],BX            ; D=Width
    POP         BX                             ; H=Column
    MOV         AL,0x20
    MOV         [Print_Char],AL
    MOV         AL,CL
    MOV         [Print_Row],AL
    MOV         BL,AL
LFB1F:
    MOV         AL,CH
    MOV         [Print_Col],AL
    MOV         DL,AL
    PUSH        CX
    PUSH        BX
LFB26:
    PUSH        DX
    CALL        PrintAsciiChar
    POP         DX
    INC         DL
    MOV         AL,DL
    MOV         [Print_Col],AL
    CMP         AL,DH
    JNZ         LFB26
    MOV         [Print_Col],AL
    POP         BX
    POP         CX
    INC         BL
    MOV         AL,BL
    MOV         [Print_Row],AL
    CMP         AL,BH
    JNZ         LFB1F
    RET


DoWindowOne:
    MOV         CX,0x0
    MOV         DH,0x20
    MOV         BH,0x18
    MOV         byte ptr [Print_Mask],0x0
    MOV         byte ptr [Print_Attr],0x38
    MOV         byte ptr [_border],0x7
    JMP         ClearWindow


DoWindowTwo:
    MOV         CX,0x0
    MOV         DH,0x20
    MOV         BH,0x8
    MOV         byte ptr [_border],0x4
    MOV         byte ptr [Print_Mask],0xff
    MOV         byte ptr [Print_Attr],0x79
    CALL        ClearWindow
    JMP         DoWindowFour
DoWindowThree:
    MOV         CX,0x2
    MOV         DH,0x18
    MOV         BH,0x8
    MOV         byte ptr [Print_Mask],0xff
    MOV         byte ptr [Print_Attr],0x79
    JMP         ClearWindow
DoWindowFour:
    MOV         CX,0x8
    MOV         DH,0x20
    MOV         BH,0xe
    MOV         byte ptr [Print_Mask],0xff
    MOV         byte ptr [Print_Attr],0x49
    CALL        ClearWindow
    MOV         AL,[LowerWindowAttr]
    MOV         [Print_Attr],AL
    MOV         byte ptr [Print_Mask],0x0
    MOV         CX,0xe
    MOV         BH,0x18
    JMP         ClearWindow

; LABEL also: ClearScreenBlack
DoWindowFive:
    MOV         CX,0x0
    MOV         DH,0x20
    MOV         BH,0x18
    MOV         byte ptr [Print_Attr],0x3
    MOV         byte ptr [Print_Mask],0x0
    MOV         byte ptr [_border],0x0
    CALL        ClearWindow
    CALL        DefineViewPoint
    db 000h,000h,000h,01Fh,003h,000h
    RET


ClearAttributesDay:
    MOV         AX,L07979h
    JMP         ClearAttributes
    MOV         AX,0x1616
    JMP         ClearAttributes


ClearAttributesNight:
    MOV         AX,Screen_1900h_OFFSET
ClearAttributes:
    MOV         CX,0x100
    MOV         DI,Screen[6400]
    STOSW.REP   ES:DI=>Screen_1900h_OFFSET
    RET


FullCharTitle:
    MOV         AL,[CharTitle]
    CMP         AL,0x0
    JZ          IsMoonprince
    CMP         AL,0x1
    JZ          IsNobody
    CMP         AL,0x2
    JZ          IsFey
    CMP         AL,0x3
    JZ          IsWise
    CMP         AL,0x4
    JZ          IsDragon
    CMP         AL,0x5
    JZ          IsSkulkrin
    CMP         AL,0xa
    JC          TheLordOf
    JZ          The_Name_Of
    CALL        Bytes_Print_Buffer 
    db 0FCh,079h,0FFh                           ; 'Lord'
    JMP         FirstNameToBuffer
IsMoonprince:
    MOV         AL,0x7e
    JMP         FirstName_The_What
IsNobody:
    JMP         FirstNameToBuffer
IsFey:
    MOV         AL,0x7a
    JMP         FirstName_The_What
IsWise:
    MOV         AL,0x7b
    JMP         FirstName_The_What
IsDragon:
    MOV         AL,0x7d
    CALL        FirstName_The_What
    MOV         AL,0x79                        ; -Lord
    JMP         AddTokenWithConnect
IsSkulkrin:
    MOV         AL,0x7c
    JMP         FirstName_The_What
TheLordOf:
    CALL        Bytes_Print_Buffer
    db 000h,0FCh,079h,040h,0FFh                 ; 'The Lord Of'
    JMP         FirstNameToBuffer
The_Name_Of:
    CALL        TheToBuffer
    CALL        FirstNameToBuffer
    MOV         AL,0x40                        ; 'Of'
    CALL        A_IntoPrintBuffer


FirstNameToBuffer:
    CALL        SetTokenToUpperCase
    MOV         AL,[CharFirstName]
    JMP         A_IntoPrintBuffer


TheToBuffer:
    XOR         AL,AL
    JMP         A_IntoPrintBuffer


FirstName_The_What:
    PUSH        AX
    PUSHF
    CALL        FirstNameToBuffer
    CALL        TheToBuffer
    CALL        SetTokenToUpperCase
    POPF
    POP         AX
    JMP         A_IntoPrintBuffer


CalcCharTablePos:
    MOV         AL,[TempCharacterNo]
    MOV         BL,AL
    MOV         BH,0x0
    ADD         BX,BX
    ADD         BX,BX
    ADD         BX,BX                          ; Mult by 32
    ADD         BX,BX
    ADD         BX,BX
    MOV         CX,CharTable
    ADD         BX,CX                          ; Add Offset
    MOV         DX,CharLocation
    RET


SaveCharDetails:
    CALL        CalcCharTablePos
    JMP         DoReverseSwap


CopyCharDetails:
    CALL        CalcCharTablePos
LFC64:
    MOV         CX,0x20
    MOV         SI,BX
    MOV         DI,DX
    MOVSB.REP   ES:DI,SI
    MOV         BX,SI
    MOV         DX,DI
    RET

; Display what we're looking at
DrawMainScreen:
    MOV         CH,0x7f
    MOV         AL,[CharTimeOfDay]             ; depending what time of day
    CMP         AL,0x0                         ; it is decides the top screens
    JNZ         LFC75                          ; attributes.
    MOV         CH,0x40
LFC75:
    MOV         AL,CH
    MOV         [LowerWindowAttr],AL
    CALL        DoWindowTwo                    ; Clear the Top Screen
    MOV         AL,[TempCharacterNo]
    MOV         [ShieldNumber],AL
    CALL        PrintShield                    ; Draw the Characters Shield
    CALL        DefineViewPoint
    db 000h,001h,001h,017h,071h,0FFh
    MOV         AL,0x1
    MOV         [UpperCaseFlag],AL
    CALL        FullCharTitle                  ; Display the Characters name
    CALL        FlushPrintBuffer
    CALL        DefineViewPoint
    db 001h,002h,001h,017h,069h,0FFh
    CALL        DescribeWhereHeIs              ; Display Location Description
    CALL        FlushPrintBuffer
    CALL        DrawGraphicVision              ; Draw the LANDSCAPE
    MOV         AL,[CharTimeOfDay]
    CMP         AL,0x0                         ; How exatcly is the landscape
    JNZ         LAB_0000_28dd                  ; going to be coloured in?
    JMP         ClearAttributesNight
LAB_0000_28dd:
    JMP         ClearAttributesDay


DrawMainFeature:
    CALL        DoWindowOne
    MOV         AL,[LocationFeature]
    MOV         [Feature_Draw],AL
    XOR         AL,AL
    MOV         [Feature_Size],AL
    MOV         BX,K_Direction                 ; = 'l'
    MOV         word ptr [Image_XPixel],BX
    MOV         AL,0x60
    MOV         [Image_YPixel],AL
    CALL        DrawFeature
    CALL        DefineViewPoint
    db 0FFh,000h,000h,01Fh,03Ah,000h
    MOV         [Print_Ink],AL
    CALL        SetTokenToUpperCase
    CALL        FullCharTitle
    CALL        FlushPrintBuffer
    MOV         BX,0x90a
    MOV         word ptr [Column],BX=>CalcNightActivity::L66C1
    MOV         AL,0x3f
    MOV         [Window_Attr],AL
    MOV         AL,[CharGraphicType]
    MOV         [CharacterToPrint],AL
    CALL        DisplayCharacter
    CALL        DefineViewPoint
    db 000h,00Bh,000h,01Fh,03Ah,000h
    RET


GetFromCharHereTable:
    MOV         AL,[CharInHereTable]
    MOV         DL,AL                          ; Character we want
    MOV         DH,0x0
    MOV         BX,CharHereTable               ; Start of table
    ADD         BX,DX                          ; position in table.
    MOV         AL,byte ptr [BX]               ; get the char No.
    MOV         [TempCharacterNo],AL
    JMP         CopyCharDetails                ; get the Character and return.


SelectCharacter:
    CALL        CheckKeyCase
    MOV         CL,AL                          ; What Key?
    MOV         DH,0x0
    MOV         BX,CharKeysTable               ; Reference Table
    MOV         CH,0x20
LFD4D:
    MOV         AL,byte ptr [BX]               ; Check Entry
    CMP         AL,CL                          ; Is it what we pressed?
    JZ          FoundCharKey                   ; Yes
    INC         BX
    INC         DH
    DEC         CH
    JNZ         LFD4D
    JMP         SelectCharacter
FoundCharKey:
    MOV         AL,DH
    MOV         [TempCharacterNo],AL
    CALL        CopyCharDetails
    CMP         byte ptr [RecruitedAll],0x0    ; CHEAT:
    JNZ         LAB_0000_2976
    MOV         AL,[CharAvailable]
    CMP         AL,0x1
    JNZ         SelectCharacter
LAB_0000_2976:
    XOR         AL,AL
    MOV         [LASTK],AL
    RET


DisplayPressAKey:
    CALL        DoWindowOne
    CALL        DefineViewPoint
    db 001h,000h,000h,01Fh,03Ah,000h
    CALL        Bytes_Print_Buffer            
    db 0FCh,07Fh,053h,081h,05Ch                 ; 'Press A Key To'
    db 080h,0FEh,02Eh,0FEh,02Eh,0FEh,02Eh       ; 'Choose....'
    db 0FEh,02Eh,0FBh,0FBh,0FFh
    JMP         FlushPrintBuffer


InitialiseChoices:
    MOV         BX,ChooseKeyTable
    MOV         CH,0x7                         ; Clear out the
LFDAD:
    MOV         byte ptr [BX],AL               ; table of keys
    INC         BX
    DEC         CH
    JNZ         LFDAD
    MOV         AL,[CharHideFlag]              ; CanWeSeek
    CMP         AL,CharacterIsHidden           ; Are We Hidden?
    JNZ         CanWeHide                      ; We Can't Seek Then!
    MOV         AL,'1'
    CALL        AddToBufferAndKeyTable
    CALL        Bytes_Print_Buffer
    db 0F0h,0FFh                                ; 'Seek'
CanWeHide:
    MOV         AL,[CharNoWarriors]
    CMP         AL,0x0
    JNZ         AnyBodyElseHere                ; We can't Hide if we
    MOV         AL,[CharNoRiders]              ; have any Warriors or
    CMP         AL,0x0                         ; Riders!
    JNZ         AnyBodyElseHere
    MOV         AL,[SaveCurChar]               ; Morkin can't hide either
    CMP         AL,SelectedMorkin
    JZ          CanWeFight
    MOV         AL,'2'
    CALL        AddToBufferAndKeyTable
    MOV         AL,[CharHideFlag]              ; If we are already
    CMP         AL,0x0                         ; hidden then we must
    JNZ         DoNotHide                      ; not hide!
    CALL        Bytes_Print_Buffer
    db 0EEh,0FFh                                ; 'Hide'
AnyBodyElseHere:
    MOV         AL,[DoomDarksArmyPosInTable]
    CMP         AL,0x0
    JZ          InitialiseChoices::CanWeFight  ; No.
    RET
DoNotHide:
    CALL        Bytes_Print_Buffer
    db 08Ch,0BCh,0FEh,074h,0EEh,0FFh            ; 'Do Not Hide'
    RET
CanWeFight:
    MOV         AL,[LocationObject]
    CMP         AL,NoObjectAtAll               ; Nothing here at all
    JZ          CanWeRecruit
    CMP         AL,WildHorses                  ; Anything we can fight?
    JNC         CanWeRecruit
    MOV         [ObjectToDescribe],AL          ; Store Whats Nasty
    MOV         AL,'3'
    CALL        AddToBufferAndKeyTable
    CALL        Bytes_Print_Buffer
    db 0F7h,000h,0FFh                           ; 'Fight The'
    CALL        DescribeAnObject
CanWeRecruit:
    CALL        AnyCharsToRecruit
    MOV         AL,[CharInLocation]            ; Who's in this location?
    CMP         AL,0x0                         ; Any one?
    JZ          AreWeAtA_Citadel_Keep
    MOV         [TempCharacterNo],AL
    CALL        CopyCharDetails
    MOV         AL,'4'
    CALL        AddToBufferAndKeyTable
    CALL        Bytes_Print_Buffer 
    db 0F6h,0FFh                                ; 'Recruit'
    CALL        FullCharTitle
    CALL        UpdateCharsVars
AreWeAtA_Citadel_Keep:
    MOV         AL,[LocationFeature]
    CMP         AL,Citadel
    JZ          LFE41
    CMP         AL,Keep
    JNZ         CanWeBattle
LFE41:
    CMP         byte ptr [RecruitSoldiers],0x0 ; ; CHEAT:
    JNZ         LAB_0000_2a4e                  ; if cheat enabled, skip validation
; Check the race of the army against that of the
; character to see if they're friend or foe.
    MOV         AL,[WhoseRaceIsArmy]
    MOV         CH,AL
    MOV         AL,[CharRace]
    CMP         AL,CH
    JNZ         CanWeBattle
LAB_0000_2a4e:
    MOV         AL,[HowManyGuardsThePlace]
    CMP         AL,0x19                        ; Might want to put some men
    JC          CanWeStandMenOnGuard           ; on guard.
    MOV         AL,[WhoGuardsThePlace]
    CMP         AL,0x0                         ; Riders or Warriors?
    JNZ         LFE5E
    MOV         AL,[CharNoWarriors]
    JMP         CanWeRecruitMen
LFE5E:
    MOV         AL,[CharNoRiders]
CanWeRecruitMen:
    CMP         AL,0xeb
    JNC         CanWeStandMenOnGuard           ; Got To Many!
    MOV         AL,'5'
    CALL        AddToBufferAndKeyTable
    CALL        Bytes_Print_Buffer 
    db 0F6h,0CDh,0FFh                           ; 'Recruit Men'
CanWeStandMenOnGuard:
    MOV         AL,[WhoGuardsThePlace]
    CMP         AL,0x0
    JNZ         RidersGuard
    MOV         AL,[CharNoWarriors]            ; WarriorsGuard
    CMP         AL,0x14                        ; Have we enough Warriors
    JC          CanWeBattle
OnGuard:
    MOV         AL,[HowManyGuardsThePlace]
    CMP         AL,0xeb                        ; These three
    JNC         CanWeBattle                    ; lines are a
    MOV         AL,'6'                         ; bug fix!!!!!!!!
    CALL        AddToBufferAndKeyTable
    CALL        Bytes_Print_Buffer
    db 056h,0CDh,05Eh,09Eh,0FFh                 ; 'Stand Men On Guard'
    JMP         CanWeBattle
RidersGuard:
    MOV         AL,[CharNoRiders]
    CMP         AL,0x14                        ; Have we enough Riders
    JNC         OnGuard
CanWeBattle:
    MOV         AL,[CharCourageStatus]
    CMP         AL,0x0                         ; Are we a coward?
    JNZ         LAB_0000_2aa6
    RET
LAB_0000_2aa6:
    MOV         AL,[DoomDarksArmyPosInTable]   ; Anything of Doomdarks army to Battle?
    CMP         AL,0x0
    JZ          LAB_0000_2aae                  ; Return if not!
    RET
LAB_0000_2aae:
    CALL        FlushPrintBuffer
    CALL        CheckLocationInfront
    MOV         AL,[DoomDarksArmyPosInTable]   ; Anything of Doomdarks army to Battle?
    CMP         AL,0x0
    JNZ         LAB_0000_2abc                  ; Return if not!
    RET
LAB_0000_2abc:
    MOV         AL,[FreeArmyPosInTable]
    CMP         AL,0x1d
    JC          LAB_0000_2ac4
    RET
LAB_0000_2ac4:
    MOV         AL,'7'
    CALL        AddToBufferAndKeyTable
    CALL        Bytes_Print_Buffer
    db 05Ch,0C3h,0FEh,021h,0FFh                 ; 'To Battle!'
    RET


AnyCharsToRecruit:
    XOR         AL,AL
    MOV         [CharInLocation],AL            ; Nobody in location-Ish
    MOV         AL,[CharRecruitingKey]         ; Store this of the
    MOV         [TempCharRecruitingKey],AL     ; Character at location.
    MOV         AL,[NoInCharHereTable]         ; How Many People Are here?
    CMP         AL,0x2                         ; Less than 2 is no good.
    JNC         LAB_0000_2ae5                  ; which by the way is Zero & one.
    RET
LAB_0000_2ae5:
    XOR         AL,AL                          ; Start at begining
LFED1:
    MOV         [CharInHereTable],AL           ; Where we up to?
    CALL        GetFromCharHereTable           ; get his details
    CMP         byte ptr [RecruitedAll],0x0    ; CHEAT:
    JNZ         LFEF0
    MOV         AL,[CharAvailable]             ; has the character already
    CMP         AL,0x1                         ; been recruited?
    JZ          LFEF0                          ; forget him if he has?
    CMP         byte ptr [RecruitAnyone],0x0   ; ; CHEAT:
    JNZ         LAB_0000_2b10
    MOV         AL,[CharRecruitedBy]           ; Can this character
    MOV         CH,AL                          ; be recuited by the character
    MOV         AL,[TempCharRecruitingKey]     ; at the current location?
    AND         AL,CH
    CMP         AL,0x0
    JZ          LFEF0                          ; No he can't be
LAB_0000_2b10:
    MOV         AL,[TempCharacterNo]
    MOV         [CharInLocation],AL            ; If he can. He's Ready.
LFEF0:
    MOV         AL,[NoInCharHereTable]
    MOV         CH,AL                          ; Store how many are here.
    MOV         AL,[CharInHereTable]           ; increment our count!
    INC         AL
    CMP         AL,CH                          ; Are we at the end?
    JNZ         LFED1                          ; Loop until we are
    JMP         UpdateCharsVars

; Lookup a token in the token dictionary
;
; Tokens are stored using 5-bit bytes compressed together;
; the format is [length][length*char]. All tokens have to
; be decoded until the required token is found.
GetRequiredByte:
    PUSH        BX
    MOV         DH,BH                          ; BX=required byte
    MOV         DL,BL
    ADD         BX,BX                          ; Multiply by 5
    ADD         BX,BX
    ADD         BX,DX
    MOV         AL,BL
    AND         AL,0x7                         ; This is the same as
    INC         AL                             ; doing AL=(BX MOD 8)+1
    MOV         CH,AL
    SHR         BX,0x3                         ; BX=BX/8
    MOV         DX,word ptr [StartOfTokenTable]; BX=Actual byte position in
    ADD         BX,DX                          ; the data with CH= to no of
    MOV         DL,byte ptr [BX]               ; rotations to get the required
    INC         BX                             ; five bits.
    MOV         DH,byte ptr [BX]
    JMP         Rotate_B_Times
Rotate_Once:
    SHR         DX,0x1                         ; Rotate one bit
Rotate_B_Times:
    DEC         CH
    JNZ         Rotate_Once                    ; Looop until finished
    MOV         AL,DL                          ; AL=Byte required
    AND         AL,0x1f                        ; only need bottom five bits.
    POP         BX
    RET


GetASCIIchar:
    PUSH        DX
    CALL        GetRequiredByte                ; Get the byte from the data
    POP         DX
    OR          AL,0x60                        ; add on 'a'-1
    MOV         BP,DX
    MOV         byte ptr DS:[BP + 0x0],AL      ; Store in buffer
    INC         BX                             ; Increase required byte
    INC         DX                             ; Increase position in buffer
    MOV         CH,CL
    RET


DefineViewPoint:
    POP         BX
    MOV         DX,ViewPoint_Col
    MOV         CX,0x4
    MOV         SI,BX
    MOV         DI,DX
    PUSH        DS
    PUSH        CS
    POP         DS
    MOVSB.REP   ES:DI,SI
    POP         DS
    MOV         BX,SI
    MOV         DX,DI
    MOV         AL,byte ptr CS:[BX]
    MOV         [Print_Attr],AL
    INC         BX
    MOV         AL,byte ptr CS:[BX]
    MOV         [Print_Mask],AL
    XOR         AL,AL
    MOV         [UpperCaseFlag],AL
    INC         BX
    PUSH        BX
    RET


; include 286.asm
Initialise:
    CALL        InitialiseVideo
    PUSH        CS
    PUSH        CS
    POP         ES
    POP         DS
    CALL        fun_LocationForLoadedData
    CALL        Trans_Screen
    XOR         AX,AX                          ; BIOS.GetKey
    INT         0x16                           ; BIOS Interrupt (keyboard)
    CALL        Initialise2
    MOV         AX,[RandomSeed]
    MOV         [LastRandomNumber],EAX         ; = 14E038Dh
    MOV         BX,WorkSpaceArea[32]
    MOV         word ptr [PrintBufferPos],BX=>WorkSpaceArea[32]
    MOV         BX,TokenDictionary
    MOV         word ptr [StartOfTokenTable],BX=>TokenDictionary
    RET


Initialise2:
    PUSH        CX
    PUSH        DX
    PUSH        BX
    PUSH        DS
    MOV         AX,0x0
    MOV         DS,AX
    MOV         AL,[LAB_0000_0469+3]
    POP         DS
    MOV         BX,word ptr [RandomSeed]
    MOV         DL,AL
    MOV         CL,AL
    MOV         DH,AL
    AND         CL,0x7
    ROR         DH,CL
    ADD         BX,DX
    CMP         BX,-0x1
    JNZ         LAB_0000_2be0
    INC         BX
LAB_0000_2be0:
    ADD         AX,word ptr [BX]
    MOV         word ptr [RandomSeed],BX
    POP         BX
    POP         DX
    POP         CX
    RET
LastRandomNumber:
    ddw 14E038Dh


RandomishNumber:
    MOV         EAX,[LastRandomNumber]         ; = 14E038Dh
    IMUL        EAX,EAX,0x343fd
    ADD         EAX,0x269ec3
    MOV         [LastRandomNumber],EAX         ; = 14E038Dh
    SAR         EAX,0x10
    AND         EAX,0xff
    RET


CheckKeyCase:
    PUSH        AX
    MOV         AH,0x1                         ; BIOS Check Keyboard Buffer
    INT         0x16                           ; BIOS Interrupt (keyboard)
    JZ          LAB_0000_2c1c
    MOV         AH,0x0                         ; BIOS.GetKey
    INT         0x16                           ; BIOS Interrupt (keyboard)
    MOV         [LASTK],AL
LAB_0000_2c1c:
    POP         AX
    MOV         AL,[LASTK]
    CMP         AL,0x41
    JNS         LAB_0000_2c25
    RET
LAB_0000_2c25:
    CMP         AL,0x5a
    JS          LAB_0000_2c2a
    RET
LAB_0000_2c2a:
    OR          AL,0x20
    RET
Quit:
    CALL        DoWindowFive
    CALL        Bytes_Print_Buffer
    db 0FCh,0AEh,08Dh,0FEh,020h,0FEh,073h,0FEh ; 'Are you sure you want to quit?'
    db 075h,0FEh,072h,0FEh,065h,08Dh,08Eh,05Ch ;
    db 0FEh,020h,0FEh,071h,0FEh,075h,0FEh,069h ;
    db 0FEh,074h,0FEh,03Fh,0FFh                ;
    CALL        FlushPrintBuffer
    CALL        Trans_Screen
LAB_0000_2c56:
    CALL        CheckKeyCase
    CMP         AL,byte ptr [K_Yes]            ; = 'g'
    JZ          LAB_0000_2c69
    CMP         AL,byte ptr [K_No]             ; = 'j'
    JZ          MainGameLoop
    JMP         LAB_0000_2c56
LAB_0000_2c69:
    MOV         AX,0x3                         ; BIOS Video: Get Cursor Position And Shape
    INT         0x10                           ; BIOS Interrupt (Vieo Services)
    PUSH        word ptr [TemporaryVideoVariable]
    POP         ES
    MOV         AH,0x49                        ; DOS: Release memory
    INT         0x21                           ; BIOS Interrupt (DOS API)
LAB_0000_2c77:
    MOV         AX,0x4c00                      ; DOS: Terminate with return code
    INT         0x21                           ; BIOS Interrupt (DOS API)


SelectLoadGame:
    CALL        fun_LoadWithTemplateFilename
    CMP         byte ptr [SingleShotSaveFlag],0x0
    JZ          fun_LoadWithTemplateFilename::JustRET                       ; If true, RET
    CALL        DisplayPressAKey
    MOV         BX,SaveLoadGameBuffer[51]
    XOR         AX,AX
LAB_0000_2c90:
    PUSH        BX=>SaveLoadGameBuffer[51]
    PUSH        AX
    MOV         AH,byte ptr [BX]
    OR          AH,AH
    MOV         BL,0x6e
    JNZ         LAB_0000_2ca3
    MOV         BL,0x9f
    CMP         byte ptr [LoadSaveFlag],0x1
    JZ          LAB_0000_2cf2
LAB_0000_2ca3:
    CALL        HashToBuffer
    POP         AX
    PUSH        AX
    MOV         AH,AL
    ADD         AL,0x41
    CALL        AddLiteralToBuffer
    CALL        SetTokenToUpperCase
    MOV         AL,BL
    CALL        A_IntoPrintBuffer
    CMP         BL,0x9f
    JZ          LAB_0000_2cdc
    MOV         AL,0x20
    CALL        AddLiteralToBuffer
    CALL        AddLiteralToBuffer
    MOV         AL,AH
    XOR         AH,AH
    MOV         BX,SaveLoadGameBuffer[77]
    ADD         BX,AX
    ADD         AX,AX
    ADD         BX,AX
    MOV         CX,0x3
LAB_0000_2cd4:
    MOV         AL,byte ptr [BX]
    CALL        AddLiteralToBuffer
    INC         BX
    LOOP        LAB_0000_2cd4
LAB_0000_2cdc:
    CALL        SetTokenToLowerCase
    CALL        FlushPrintBuffer
    MOV         AL,[ViewPoint_Row]
    CMP         AL,0x12
    JNZ         LAB_0000_2cf2
    CALL        DefineViewPoint
    db 010h,002h,010h,01Fh,03Ah,000h
LAB_0000_2cf2:
    POP         AX
    POP         BX
    INC         BX
    INC         AL
    CMP         AL,0x1a
    JNZ         LAB_0000_2c90
    CALL        Trans_Screen
    CALL        ResetLASTK
LAB_0000_2d01:
    CALL        CheckKeyCase
    MOV         CL,0xff
    CMP         AL,byte ptr [K_Escape]         ; = 01Bh
    JZ          LAB_0000_2d2c
    CMP         AL,0x61
    JL          LAB_0000_2d01
    CMP         AL,0x7a
    JG          LAB_0000_2d01
    SUB         AL,0x61
    MOV         CL,AL
    CMP         byte ptr [LoadSaveFlag],0x0
    JZ          LAB_0000_2d2c
    MOV         BX,SaveLoadGameBuffer[51]
    XOR         AH,AH
    ADD         BX,AX
    MOV         AL,byte ptr [BX]
    OR          AL,AL
    JZ          LAB_0000_2d01
LAB_0000_2d2c:
    MOV         byte ptr [LoadSaveFlag],CL
    RET


fun_LoadWithTemplateFilename:
    MOV         byte ptr [SingleShotSaveFlag],0x0
    MOV         AH,0x4e                        ; DOS: Find first file
    XOR         CX,CX
    MOV         DX,FileMatchPattern            ; = "LOM-????.GAM"
    INT         0x21                           ; BIOS Interrupt (DOS API)
    JC          JustRET
    CALL        fun_LoadSingleShot
LAB_0000_2d44:
    MOV         AH,0x4f                        ; DOS: Find next file
    INT         0x21                           ; BIOS Interrupt (DOS API)
    JC          JustRET
    CALL        fun_LoadSingleShot
    JMP         LAB_0000_2d44
JustRET:
    RET


fun_LoadSingleShot:
    ADD         byte ptr [SingleShotSaveFlag],0x1
    MOV         AL,[SaveLoadGameBuffer[34]]
    SUB         AL,0x41
    MOV         BX,SaveLoadGameBuffer[51]
    XOR         AH,AH
    ADD         BX,AX
    PUSH        AX
    MOV         AL,0x1
    MOV         byte ptr [BX],AL
    POP         AX
    MOV         BX,SaveLoadGameBuffer[77]
    ADD         BX,AX
    ADD         AX,AX
    ADD         BX,AX
    MOV         DI,SaveLoadGameBuffer[35]
    MOV         AX,word ptr [DI]
    MOV         word ptr [BX],AX
    MOV         AL,byte ptr [DI + 0x2]
    MOV         byte ptr [BX + 0x2],AL
    RET


fun_LocationForLoadedData:
    MOV         AH,0x1a                        ; DOS: Set disk transfer address
    MOV         DX,SaveLoadGameBuffer
    INT         0x21                           ; BIOS Interrupt (DOS API)
    RET


SA_BYTES:
    CALL        fun_LdSaBytes
    MOV         DX,FileSingleSlot              ; = "LOM-A000.GAM"
    MOV         AH,0x41                        ; DOS: Delete file
    INT         0x21                           ; BIOS Interrupt (DOS API)
    MOV         AL,[LoadSaveFlag]
    ADD         AL,0x41
    MOV         BX,FileSingleSlot              ; = "LOM-A000.GAM"
    MOV         byte ptr [BX + 0x4],AL
    MOV         DI,FileSingleSlot              ; = "LOM-A000.GAM"
    MOV         AX,[GameDays]
    MOV         BX,0x64
    XOR         DX,DX
    DIV         BX
    ADD         AL,0x30
    MOV         byte ptr [DI + 0x5],AL
    MOV         BX,0xa
    MOV         AX,DX
    XOR         DX,DX
    DIV         BX
    ADD         AL,0x30
    MOV         byte ptr [DI + 0x6],AL
    ADD         DL,0x30
    MOV         byte ptr [DI + 0x7],DL


SAVE_SLOT_ONE:
    MOV         DX,FileSingleSlot              ; = "LOM-A000.GAM"
    MOV         AH,0x3c                        ; DOS: Create or truncate file
    XOR         CX,CX
    INT         0x21                           ; BIOS Interrupt (DOS API)
    JC          LAB_0000_2de9
    PUSH        AX
    MOV         BX,AX
    MOV         AX,0x4200                      ; DOS: Move file pointer
    XOR         CX,CX
    XOR         DX,DX
    INT         0x21                           ; BIOS Interrupt (DOS API)
    POP         BX
    PUSH        BX
    MOV         DX,SaveGameArea                ; = "Lords of Midnight.  Save Game.\r\n"
    MOV         CX,LAB_0000_1853
    MOV         AH,0x40                        ; DOS: Write file or device
    INT         0x21                           ; BIOS Interrupt (DOS API)
    POP         BX
    MOV         AH,0x3e                        ; DOS: Close file
    INT         0x21                           ; BIOS Interrupt (DOS API)
LAB_0000_2de9:
    RET


fun_LdSaBytes:
    MOV         AL,[LoadSaveFlag]
    ADD         AL,0x41
    MOV         BX,FileSingleSlot              ; = "LOM-A000.GAM"
    MOV         byte ptr [BX + 0x4],AL
    MOV         AL,[LoadSaveFlag]
    XOR         AH,AH
    MOV         DI,SaveLoadGameBuffer[77]
    ADD         DI,AX
    ADD         AX,AX
    ADD         DI,AX
    MOV         AX,word ptr [DI]
    MOV         word ptr [BX + 0x5],AX
    MOV         AL,byte ptr [DI + 0x2]
    MOV         byte ptr [BX + 0x7],AL
    RET


LD_BYTES:
    CALL        fun_LdSaBytes


LOAD_SLOT_ONE:
    MOV         DX,FileSingleSlot              ; = "LOM-A000.GAM"
    MOV         AX,0x3d02                      ; DOS: open existing file?
    INT         0x21                           ; BIOS Interrupt (DOS API)
    JC          LAB_0000_2e39
    PUSH        AX
    MOV         BX,AX
    MOV         AX,0x4200                      ; DOS: Move file pointer
    XOR         CX,CX
    XOR         DX,DX
    INT         0x21                           ; BIOS Interrupt (DOS API)
    POP         BX
    PUSH        BX
    MOV         DX,SaveGameArea                ; = "Lords of Midnight.  Save Game.\r\n"
    MOV         CX,LAB_0000_1853
    MOV         AH,0x3f                        ; DOS: Read file or device
    INT         0x21                           ; BIOS Interrupt (DOS API)
    POP         BX
    MOV         AH,0x3e                        ; DOS: Close file
    INT         0x21                           ; BIOS Interrupt (DOS API)
LAB_0000_2e39:
    RET


SwapKeys:
    CMP         byte ptr [DirectionKeyStyle],0x0
    JNZ         LAB_0000_2e49
    CMP         AL,0x8
    JNZ         LAB_0000_2e5c
    MOV         AL,[CurrentlyLooking]
    RET
LAB_0000_2e49:
    CMP         AL,0x4
    JNZ         LAB_0000_2e51
    MOV         AL,[CurrentlyLooking]
    RET
LAB_0000_2e51:
    PUSH        BX
    XOR         AH,AH
    MOV         BX,SwapkeysData
    ADD         BX,AX
    MOV         AL,byte ptr [BX]
    POP         BX
LAB_0000_2e5c:
    RET

; MIDNIGHT.SCR
Screen:
    ; db[6912]
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,09Ch,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0E7h,0FFh,0FFh,0FFh,0FFh,0F3h,09Fh,0FFh
    db 0FFh,0FFh,0FFh,0F9h,0FFh,0FFh,0FFh,0FFh,0FFh,0E7h,0C7h,0FFh,0FFh,0C9h,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,080h,09Ch,080h,0FFh,08Fh,0E3h,091h,093h,0C1h,0FFh,0E3h,080h,0FFh,09Ch,0C0h
    db 093h,09Ch,0C0h,0E1h,09Ch,080h,0FFh,0FFh,0FFh,000h,000h,000h,0F0h,000h,000h,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,000h,001h,000h,003h,0FCh,000h,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,09Fh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,000h,003h,080h,003h,0F8h,000h,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,000h,000h,000h,000h,000h,000h,0FFh,0FFh,0E0h,000h,000h,000h,000h,007h,0FFh
    db 0FFh,0FFh,09Ch,0F9h,09Fh,0FFh,0FFh,0C1h,0F9h,0FFh,0FFh,0E7h,0FFh,0F3h,0FFh,0FFh
    db 0FFh,000h,0F0h,000h,000h,000h,000h,0FFh,0FFh,0FFh,000h,000h,000h,000h,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,08Ch,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0E7h,0FFh,0FFh,0FFh,0FFh,0E7h,09Fh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0E7h,0F3h,0FFh,0FFh,0C4h,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0A6h,09Ch,0CEh,0FFh,09Fh,0C9h,08Ch,089h,09Ch,0FFh,0C9h,0CEh,0FFh,088h,0F3h
    db 089h,08Ch,0F3h,0CCh,09Ch,0A6h,0FFh,0FFh,0FFh,000h,000h,000h,03Eh,000h,000h,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,000h,000h,000h,001h,0FCh,000h,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,09Fh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,000h,000h,000h,003h,0F8h,000h,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,000h,000h,000h,000h,000h,000h,0FFh,0FFh,0E0h,000h,000h,000h,000h,007h,0FFh
    db 0FFh,0FFh,088h,0FFh,09Fh,0FFh,0FFh,09Ch,0FFh,0FFh,0FFh,0E7h,0FFh,0E7h,0FFh,0FFh
    db 0FFh,000h,03Eh,000h,000h,000h,000h,0FFh,0FFh,0FFh,080h,000h,000h,001h,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,084h,0C1h,089h,0FFh,0C1h,088h,091h,0E7h,0C1h,091h,0C1h,0FFh,081h,091h,0C1h
    db 0FFh,0C1h,091h,0E3h,0C1h,0FFh,089h,0C1h,091h,0E7h,0C1h,0FFh,0C1h,0CFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,000h,000h,000h,000h,000h,000h,0FFh
    db 0FFh,0E7h,09Ch,0CFh,0FFh,09Fh,09Ch,09Ch,09Ch,09Fh,0FFh,09Ch,0CFh,0FFh,080h,0F3h
    db 09Ch,084h,0F3h,09Fh,09Ch,0E7h,0FFh,0FFh,0FFh,000h,000h,000h,01Fh,080h,000h,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,000h,021h,008h,001h,0FCh,000h,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,091h,089h,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,080h,009h,020h,007h,0F0h,001h,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,000h,000h,000h,000h,000h,000h,0FFh,0FFh,0F0h,000h,000h,000h,000h,00Fh,0FFh
    db 0FFh,0FFh,080h,0E3h,099h,0C1h,0FFh,09Fh,0E3h,091h,0C1h,0E7h,0C1h,081h,0C1h,091h
    db 0FFh,000h,01Fh,080h,000h,000h,000h,0FFh,0FFh,0FFh,0C0h,000h,000h,003h,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,090h,09Ch,09Ch,0FFh,09Ch,0C9h,08Ch,0E7h,09Ch,08Ch,09Ch,0FFh,0CFh,08Ch,09Ch
    db 0FFh,09Ch,08Ch,0F3h,09Ch,0FFh,09Ch,09Ch,08Ch,0E7h,098h,0FFh,09Ch,0CFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,000h,000h,000h,000h,000h,000h,0FFh
    db 0FFh,0E7h,080h,0C1h,0FFh,09Fh,09Ch,09Ch,09Ch,0C1h,0FFh,09Ch,0C1h,0FFh,094h,0F3h
    db 09Ch,090h,0F3h,090h,080h,0E7h,0FFh,0FFh,0FFh,000h,000h,000h,00Fh,0C0h,000h,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,000h,001h,000h,001h,0FCh,000h,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,08Ch,0CCh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,080h,001h,000h,007h,0E0h,001h,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,000h,000h,000h,000h,000h,000h,0FFh,0FFh,0F0h,000h,000h,000h,000h,00Fh,0FFh
    db 0FFh,0FFh,094h,0F3h,093h,09Ch,0FFh,0C1h,0F3h,08Ch,09Ch,0E7h,09Ch,0CFh,09Ch,08Ch
    db 0FFh,000h,00Fh,0C0h,000h,000h,000h,0FFh,0FFh,0FFh,0E0h,000h,000h,007h,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,098h,09Ch,094h,0FFh,080h,0E3h,09Ch,0E7h,09Ch,09Ch,080h,0FFh,0CFh,09Ch,080h
    db 0FFh,080h,09Ch,0F3h,09Fh,0FFh,094h,09Ch,09Ch,0E7h,09Ch,0FFh,09Ch,083h,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,000h,000h,000h,000h,000h,000h,0FFh
    db 0FFh,0E7h,09Ch,0CFh,0FFh,09Fh,09Ch,081h,09Ch,0FCh,0FFh,09Ch,0CFh,0FFh,09Ch,0F3h
    db 09Ch,098h,0F3h,09Ch,09Ch,0E7h,0FFh,0FFh,0FFh,000h,000h,000h,007h,0E0h,000h,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,000h,009h,020h,001h,0FCh,000h,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,09Ch,0E4h,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,080h,021h,008h,00Fh,0C0h,001h,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,000h,000h,000h,000h,000h,000h,0FFh,0FFh,0F8h,000h,000h,000h,000h,01Fh,0FFh
    db 0FFh,0FFh,09Ch,0F3h,087h,080h,0FFh,0FCh,0F3h,09Ch,09Fh,0E7h,080h,0CFh,09Ch,09Ch
    db 0FFh,000h,007h,0E0h,000h,000h,000h,0FFh,0FFh,0FFh,0F0h,000h,000h,00Fh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,09Ch,09Ch,0C1h,0FFh,09Fh,0C9h,08Ch,0E5h,09Ch,081h,09Fh,0FFh,0CDh,099h,09Fh
    db 0FFh,09Fh,08Ch,0F3h,09Ch,0FFh,0C1h,09Ch,081h,0E5h,09Ch,0FFh,09Ch,0CFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,000h,000h,000h,000h,000h,000h,0FFh
    db 0FFh,0E7h,09Ch,0CEh,0FFh,09Eh,0C9h,099h,089h,09Ch,0FFh,0C9h,0CFh,0FFh,09Ch,0F3h
    db 089h,09Ch,0F3h,0CCh,09Ch,0E7h,0FFh,0FFh,0FFh,000h,000h,000h,007h,0F0h,000h,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,000h,000h,000h,001h,0FCh,000h,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,08Ch,0F1h,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0C0h,000h,000h,01Fh,080h,003h,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,000h,000h,000h,000h,000h,000h,0FFh,0FFh,0F8h,000h,000h,000h,000h,01Fh,0FFh
    db 0FFh,0FFh,09Ch,0F3h,093h,09Fh,0FFh,09Ch,0F3h,099h,098h,0E5h,09Fh,0CDh,09Ch,099h
    db 0FFh,000h,007h,0F0h,000h,000h,000h,0FFh,0FFh,0FFh,0F8h,000h,000h,01Fh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,09Ch,0C1h,0EBh,0FFh,0C0h,088h,091h,0E1h,0C1h,09Ch,0C0h,0FFh,0E3h,090h,0C0h
    db 0FFh,0C0h,091h,0E3h,0C1h,0FFh,0EBh,0C1h,09Ch,0E1h,0C1h,0FFh,0C1h,0CFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,000h,000h,000h,000h,000h,000h,0FFh
    db 0FFh,0E7h,09Ch,080h,0FFh,080h,0E3h,09Ch,093h,0C1h,0FFh,0E3h,08Fh,0FFh,09Ch,0C0h
    db 093h,09Ch,0C0h,0E1h,09Ch,0E7h,0FFh,0FFh,0FFh,000h,000h,000h,003h,0F8h,000h,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,000h,003h,080h,001h,0FCh,000h,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,091h,0B3h,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0C0h,001h,000h,03Eh,000h,003h,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,000h,000h,000h,000h,000h,000h,0FFh,0FFh,0FCh,000h,000h,000h,000h,03Fh,0FFh
    db 0FFh,0FFh,09Ch,0E3h,098h,0C0h,0FFh,0C1h,0E3h,090h,0C1h,0E1h,0C0h,0E3h,0C1h,090h
    db 0FFh,000h,003h,0F8h,000h,000h,000h,0FFh,0FFh,0FFh,0FCh,000h,000h,03Fh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,09Fh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,09Fh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,09Fh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,000h,000h,000h,000h,000h,000h,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,000h,000h,000h,003h,0F8h,000h,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,000h,0BBh,0BAh,003h,0FCh,000h,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0C7h,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0C0h,000h,000h,0F0h,000h,003h,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,000h,000h,000h,000h,000h,000h,0FFh,0FFh,0FEh,000h,000h,000h,000h,07Fh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0F9h,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,000h,003h,0F8h,000h,000h,000h,0FFh,0FFh,0FFh,0FEh,000h,000h,07Fh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,000h,003h,0FCh,000h,008h,000h,0FFh,0FFh,0FFh,0FFh,000h,000h,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,000h,003h,0F8h,000h,07Dh,000h,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0C0h,000h,000h,000h,01Fh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0E0h,000h,000h,008h,000h,007h,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0F0h,0E0h,070h,038h,07Fh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,000h,000h,07Dh,000h,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0F0h,000h,000h,000h,07Fh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,000h,000h,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0F8h,0FFh,0FFh,0FFh
    db 040h,090h,024h,009h,002h,040h,090h,024h,009h,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 09Fh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0A4h,07Ch,0FFh,0FFh,0FFh,008h,005h,0FFh,0FFh
    db 002h,000h,000h,000h,000h,000h,000h,000h,000h,083h,0FFh,0FCh,043h,0C0h,089h,080h
    db 008h,0FCh,013h,008h,0F8h,011h,0A0h,000h,087h,047h,0F9h,000h,000h,010h,07Fh,0FFh
    db 000h,000h,000h,000h,000h,000h,000h,000h,008h,07Fh,0F7h,07Eh,01Fh,080h,003h,0F8h
    db 000h,000h,01Fh,080h,011h,010h,068h,014h,0A0h,000h,000h,0FAh,000h,007h,0FFh,010h
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,000h,001h,0FCh,000h,008h,000h,0FFh,0FFh,0FFh,0FFh,080h,001h,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,000h,003h,0F8h,000h,079h,000h,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0C0h,000h,000h,000h,01Fh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0E0h,000h,000h,008h,000h,007h,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0F0h,000h,000h,000h,07Fh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,080h,000h,079h,001h,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FDh,0EFh,07Bh,0DEh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,080h,001h,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0F0h,07Fh,0FFh,0FFh
    db 000h,000h,000h,000h,000h,000h,000h,000h,001h,0F7h,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 01Fh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0C4h,0B8h,0FFh,0FFh,0F0h,010h,002h,0FFh,0FFh
    db 002h,000h,000h,000h,000h,000h,000h,004h,000h,0FDh,0FFh,0F8h,073h,0F8h,046h,000h
    db 008h,078h,020h,008h,0F0h,009h,040h,000h,040h,0C3h,0C2h,000h,000h,010h,007h,0FFh
    db 000h,000h,000h,020h,000h,000h,000h,000h,008h,07Fh,0F7h,07Eh,01Fh,080h,004h,098h
    db 000h,000h,000h,080h,011h,010h,068h,014h,0A0h,000h,001h,086h,000h,000h,003h,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,000h,001h,0FCh,000h,008h,000h,0FFh,0FFh,0FFh,0FFh,0C0h,003h,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,080h,007h,0F0h,000h,032h,001h,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0F0h,000h,000h,008h,000h,00Fh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0C0h,000h,032h,003h,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 09Ch,0E7h,039h,0CEh,073h,09Ch,0E7h,039h,0CEh,07Fh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0C0h,003h,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0E8h,03Fh,0FFh,0FFh
    db 000h,000h,000h,000h,000h,000h,000h,000h,001h,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FEh
    db 027h,0FFh,0FFh,0CFh,0FFh,0FFh,0FEh,008h,051h,03Fh,0FFh,0C0h,020h,001h,0FFh,0FFh
    db 000h,000h,000h,000h,000h,080h,000h,004h,000h,0F0h,03Fh,0F0h,08Dh,084h,03Eh,000h
    db 007h,0F0h,0C0h,004h,060h,006h,080h,000h,07Fh,0FFh,084h,000h,000h,008h,00Bh,0FFh
    db 000h,000h,000h,020h,000h,000h,000h,000h,008h,07Fh,0EFh,07Eh,01Fh,080h,00Fh,0FFh
    db 0C3h,0FFh,0FFh,080h,010h,000h,048h,011h,020h,000h,003h,002h,000h,000h,000h,001h
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,000h,001h,0FCh,000h,01Ch,000h,0FFh,0FFh,0FFh,0FFh,0E0h,007h,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,080h,007h,0E0h,000h,01Ch,001h,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0F0h,000h,000h,000h,07Fh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0F0h,000h,000h,01Ch,000h,00Fh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0E0h,000h,000h,000h,03Fh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0E0h,000h,01Ch,007h,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 000h,000h,000h,000h,000h,000h,000h,000h,000h,07Fh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0E0h,007h,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0D0h,0CFh,0FFh,0FFh
    db 000h,000h,000h,000h,000h,000h,000h,000h,001h,0E3h,0FFh,0FFh,0FFh,0FCh,07Fh,0FCh
    db 043h,0FFh,0C7h,08Fh,0FFh,08Fh,0FEh,010h,032h,01Fh,0FFh,0C0h,020h,020h,07Fh,0FFh
    db 000h,000h,000h,000h,000h,080h,000h,004h,000h,0EFh,0C1h,0FFh,073h,07Bh,0F4h,000h
    db 008h,0D1h,000h,004h,020h,00Ah,080h,000h,0A2h,0A6h,088h,000h,000h,00Eh,004h,07Fh
    db 000h,000h,000h,020h,000h,000h,000h,000h,000h,02Fh,0DEh,0FEh,01Eh,080h,004h,000h
    db 07Eh,0A4h,080h,000h,018h,001h,048h,018h,020h,000h,005h,002h,000h,000h,000h,000h
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,000h,001h,0FCh,000h,01Ch,000h,0FFh,0FFh,0FFh,0FFh,0F0h,00Fh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,080h,00Fh,0C0h,000h,000h,001h,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0F0h,000h,000h,000h,07Fh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0F8h,000h,000h,01Ch,000h,01Fh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0F7h,077h,077h,077h,07Fh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0F0h,000h,000h,00Fh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 000h,000h,000h,000h,000h,000h,000h,000h,000h,07Fh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0F0h,00Fh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0A1h,007h,0FFh,0FFh
    db 000h,002h,000h,000h,000h,000h,000h,000h,001h,0FFh,0FFh,0FFh,0FFh,0F9h,0CFh,0F8h
    db 083h,0FFh,09Fh,013h,0FFh,03Fh,0FCh,021h,00Ch,01Fh,0FFh,080h,0C0h,024h,03Fh,0FFh
    db 000h,000h,000h,000h,000h,080h,000h,004h,000h,05Fh,0DEh,0E3h,0FCh,0FFh,0FFh,0D8h
    db 008h,0D3h,000h,003h,0FFh,0FFh,0E0h,001h,042h,0A6h,090h,000h,000h,013h,0FBh,0FFh
    db 000h,000h,000h,020h,000h,000h,000h,000h,000h,023h,00Ch,00Ah,018h,080h,002h,000h
    db 064h,0FFh,080h,000h,018h,001h,048h,014h,020h,000h,00Eh,002h,000h,000h,000h,001h
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,000h,001h,0FCh,000h,03Ah,000h,0FFh,0FFh,0FFh,0FFh,0F8h,01Fh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0C0h,01Fh,080h,000h,000h,003h,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0F0h,0E0h,070h,038h,07Fh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0F8h,000h,000h,03Ah,000h,01Fh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0F7h,077h,077h,077h,07Fh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0F8h,000h,000h,01Fh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0F8h,01Fh,0FFh,0FFh,0FBh,0FFh,0FFh,0FFh,0FFh,021h,003h,0FFh,0FFh
    db 000h,002h,000h,000h,000h,000h,000h,000h,000h,0F7h,0FFh,0FFh,09Fh,0F2h,033h,0F1h
    db 003h,0FFh,022h,021h,0FEh,047h,0F8h,0C1h,048h,01Fh,0FFh,003h,000h,022h,03Fh,0FFh
    db 000h,000h,000h,000h,000h,080h,000h,000h,000h,05Fh,0EFh,05Eh,01Eh,080h,000h,064h
    db 008h,04Eh,0FFh,0FDh,000h,000h,02Fh,0F1h,07Fh,0FFh,0FFh,0E0h,000h,016h,009h,03Fh
    db 000h,000h,000h,000h,000h,000h,000h,000h,000h,023h,000h,002h,010h,080h,001h,000h
    db 064h,080h,080h,000h,011h,0F4h,048h,012h,020h,000h,01Fh,0FFh,0FCh,000h,003h,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,000h,001h,0FCh,000h,03Ah,000h,0FFh,0FFh,0FFh,0FFh,0FCh,03Fh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0C0h,03Eh,000h,000h,000h,003h,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0F0h,0E0h,070h,038h,07Fh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FCh,000h,000h,03Ah,000h,03Fh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0F5h,055h,055h,055h,07Fh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FCh,000h,000h,03Fh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 061h,098h,066h,019h,086h,061h,098h,066h,019h,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FCh,03Fh,0FFh,0FFh,0E1h,0FFh,0FFh,0FFh,0FEh,042h,009h,0FFh,0FFh
    db 002h,002h,000h,000h,000h,000h,000h,000h,000h,0F7h,0FFh,0FFh,027h,0E4h,013h,0E6h
    db 011h,0FEh,044h,041h,0FCh,083h,0F0h,001h,024h,08Fh,0FFh,000h,000h,021h,03Fh,0FFh
    db 000h,000h,000h,000h,000h,000h,000h,000h,000h,07Fh,0F7h,07Eh,01Fh,080h,000h,0FFh
    db 0FFh,0FAh,080h,007h,0FFh,0FFh,0F8h,011h,060h,000h,000h,020h,000h,014h,009h,01Fh
    db 000h,000h,000h,000h,000h,000h,000h,000h,000h,03Fh,0FFh,0FEh,010h,080h,000h,080h
    db 064h,080h,080h,000h,011h,0D4h,048h,010h,020h,000h,008h,000h,004h,007h,0FEh,010h
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,000h,003h,0FCh,000h,07Dh,000h,0FFh,0FFh,0FFh,0FFh,0FEh,07Fh,0FFh,0FFh,0FFh
    db 0FFh,0CEh,073h,09Ch,0E7h,01Fh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0C0h,0F0h,000h,000h,000h,003h,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0F0h,0E0h,070h,038h,07Fh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FEh,000h,000h,07Dh,000h,07Fh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0F0h,000h,000h,000h,07Fh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FEh,000h,000h,07Fh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FDh,0FFh,0FFh,0FFh
    db 040h,090h,024h,009h,002h,040h,090h,024h,009h,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FEh,07Fh,0FFh,0FFh,0D3h,0FFh,0FFh,0FFh,0FCh,084h,005h,0FFh,0FFh
    db 002h,002h,000h,000h,000h,000h,000h,000h,000h,0FFh,0FFh,0FEh,027h,0C8h,091h,0C0h
    db 011h,0FCh,088h,081h,0F9h,013h,0E0h,000h,09Ah,08Fh,0FFh,000h,000h,010h,09Fh,0FFh
    db 000h,000h,000h,000h,000h,000h,000h,000h,008h,07Fh,0F7h,07Eh,01Fh,080h,001h,048h
    db 000h,00Fh,0F0h,000h,010h,000h,058h,012h,0A0h,000h,000h,043h,0FFh,0FCh,005h,010h
    db 000h,000h,000h,000h,000h,000h,008h,000h,000h,03Fh,0FFh,0FEh,01Fh,0FFh,0FFh,0C0h
    db 040h,080h,0FFh,0FCh,011h,0D0h,048h,010h,020h,000h,004h,000h,007h,0FCh,002h,010h
    db 000h,000h,000h,000h,000h,000h,000h,000h,000h,03Fh,0FFh,0FEh,01Fh,0F8h,080h,000h
    db 040h,080h,082h,007h,0F1h,0D0h,048h,010h,020h,000h,002h,000h,004h,021h,0FFh,0F0h
    db 000h,001h,009h,045h,021h,000h,000h,0FFh,000h,015h,021h,007h,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0F8h,000h,008h,010h,020h,004h,000h,03Fh,0C4h,001h,000h,010h
    db 000h,081h,029h,0FFh,029h,01Fh,0FBh,00Eh,0DEh,008h,029h,000h,000h,000h,000h,000h
    db 000h,000h,000h,000h,000h,000h,008h,05Bh,06Dh,0B6h,0FFh,0FFh,0FFh,0DBh,06Dh,0B6h
    db 000h,000h,000h,000h,000h,01Fh,07Fh,0FFh,0ECh,000h,000h,000h,000h,000h,000h,020h
    db 0C1h,000h,000h,001h,0FDh,0FFh,000h,000h,000h,000h,027h,0DFh,0FFh,0C0h,000h,000h
    db 000h,000h,000h,000h,000h,001h,0DFh,0F8h,0FCh,000h,000h,000h,000h,000h,000h,025h
    db 0CFh,0DDh,000h,0E7h,0E0h,0FCh,000h,000h,000h,003h,0FFh,0DFh,0BFh,0C1h,080h,000h
    db 000h,000h,000h,000h,000h,000h,0E7h,09Eh,078h,000h,000h,000h,000h,000h,000h,020h
    db 0FFh,000h,000h,0FDh,0FFh,0FFh,0F8h,000h,001h,0CFh,0E1h,0FFh,0F7h,0EFh,0FCh,000h
    db 000h,000h,000h,000h,000h,000h,0C3h,018h,060h,000h,000h,000h,000h,000h,000h,022h
    db 042h,040h,000h,02Fh,0FFh,0FFh,0E4h,000h,007h,08Fh,0C0h,000h,000h,01Fh,0BEh,000h
    db 000h,03Ch,000h,07Eh,000h,000h,000h,000h,038h,000h,03Eh,000h,036h,00Ch,000h,000h
    db 000h,000h,000h,07Dh,0FEh,0FBh,0F0h,000h,03Ch,07Fh,000h,000h,00Fh,0EEh,0FEh,000h
    db 000h,000h,000h,000h,000h,000h,003h,03Ch,0C0h,03Fh,0FFh,0FEh,01Fh,0F0h,080h,000h
    db 040h,080h,082h,003h,001h,0D0h,0F8h,010h,020h,000h,001h,000h,006h,041h,000h,010h
    db 000h,001h,04Fh,0FFh,0E5h,000h,000h,0E7h,000h,01Fh,0E5h,007h,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0F8h,000h,008h,010h,020h,004h,000h,0FFh,0E4h,001h,0FFh,0FFh
    db 000h,081h,02Bh,0ABh,0A9h,01Fh,0FDh,00Eh,0DEh,00Ch,029h,000h,000h,000h,000h,004h
    db 000h,020h,000h,000h,000h,000h,03Fh,0FFh,0FFh,0FFh,0FEh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 000h,000h,000h,000h,000h,01Fh,07Fh,0E1h,0FEh,000h,000h,000h,000h,000h,000h,020h
    db 0B6h,000h,000h,003h,0FFh,0FFh,000h,000h,000h,000h,027h,0DEh,0FFh,0C0h,000h,000h
    db 000h,000h,000h,000h,000h,001h,0DFh,0F8h,0FCh,000h,000h,000h,000h,000h,000h,025h
    db 0CFh,0DBh,000h,0E7h,0E1h,0FFh,000h,000h,000h,006h,007h,0EFh,0DFh,0E1h,0F0h,000h
    db 000h,000h,000h,000h,000h,000h,0E7h,09Ch,070h,000h,000h,000h,000h,000h,000h,021h
    db 07Eh,080h,000h,0FBh,0FFh,0F0h,0FCh,000h,001h,0C7h,0F0h,007h,0FBh,007h,0FEh,000h
    db 000h,000h,000h,000h,000h,000h,0C3h,018h,060h,000h,000h,000h,000h,000h,000h,024h
    db 042h,020h,000h,02Fh,0FFh,0BFh,0F0h,000h,007h,00Fh,080h,000h,000h,07Fh,0BEh,000h
    db 000h,042h,000h,063h,000h,000h,000h,000h,00Ch,000h,063h,000h,03Bh,018h,000h,000h
    db 000h,000h,000h,07Bh,0FEh,0FBh,0E0h,000h,04Ch,0FBh,000h,000h,01Fh,0EEh,0FEh,000h
    db 000h,000h,000h,000h,000h,000h,006h,07Eh,060h,03Fh,0FFh,0FEh,01Fh,080h,080h,000h
    db 040h,0FFh,0FEh,004h,081h,0D0h,008h,010h,020h,000h,000h,080h,005h,041h,000h,010h
    db 020h,001h,048h,000h,025h,004h,040h,0C3h,000h,008h,025h,005h,055h,04Ah,0AAh,0AAh
    db 055h,055h,052h,0AAh,0A8h,000h,008h,010h,020h,004h,003h,0FFh,0F4h,001h,000h,010h
    db 000h,001h,02Bh,0FFh,0A9h,01Eh,0FDh,00Eh,0DEh,004h,029h,000h,000h,000h,000h,004h
    db 018h,020h,000h,000h,048h,000h,02Dh,0B6h,0DBh,06Dh,0FFh,07Fh,0FFh,0B6h,0DBh,06Dh
    db 000h,000h,000h,000h,000h,01Fh,07Fh,0F0h,0FEh,000h,000h,000h,000h,000h,000h,020h
    db 0D5h,03Ch,000h,003h,0FFh,00Ah,03Ch,000h,000h,000h,027h,0DEh,0FFh,0C0h,000h,000h
    db 000h,000h,000h,000h,000h,001h,0EFh,0F8h,0FAh,000h,000h,000h,000h,000h,000h,025h
    db 0CFh,0DFh,000h,0F3h,0F3h,0FFh,0C0h,000h,000h,03Fh,017h,0EFh,0DFh,0F8h,0F0h,000h
    db 000h,000h,000h,000h,000h,000h,0E7h,09Ch,070h,000h,000h,000h,000h,000h,000h,021h
    db 03Ch,080h,000h,0FBh,0FFh,0E0h,03Ch,000h,001h,0FFh,0F0h,003h,0FCh,007h,0FEh,000h
    db 000h,000h,000h,000h,000h,000h,0C3h,01Ch,070h,000h,000h,000h,000h,000h,000h,027h
    db 081h,0E0h,000h,02Fh,0FFh,0DFh,0F8h,000h,007h,01Fh,080h,000h,000h,07Dh,0BEh,000h
    db 000h,099h,000h,063h,03Eh,076h,03Eh,06Eh,03Eh,000h,060h,03Eh,030h,07Eh,076h,03Dh
    db 06Eh,03Eh,000h,07Bh,087h,07Bh,0C0h,000h,063h,0FBh,000h,000h,03Fh,0EDh,0FEh,000h
    db 000h,007h,0FEh,000h,0FFh,0C0h,00Ch,0FFh,030h,010h,0FFh,0C2h,010h,080h,080h,000h
    db 040h,080h,080h,000h,000h,000h,008h,010h,020h,000h,000h,040h,005h,001h,000h,010h
    db 020h,001h,04Fh,0FFh,0E5h,004h,063h,0FFh,0FEh,00Fh,0E5h,007h,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0F8h,000h,00Fh,0F0h,020h,007h,0FFh,0FFh,0FCh,001h,000h,010h
    db 000h,001h,00Ah,0AAh,0A1h,00Ch,0FEh,00Eh,05Ch,004h,021h,000h,000h,000h,000h,026h
    db 02Ch,060h,000h,000h,06Ch,000h,03Fh,0FFh,0FFh,0FFh,0AFh,07Fh,0FFh,0FFh,0FFh,0FFh
    db 000h,000h,000h,000h,000h,01Eh,0FFh,0F0h,0FEh,000h,000h,000h,000h,000h,000h,020h
    db 0C1h,06Eh,000h,007h,0FFh,0C0h,00Eh,000h,000h,000h,027h,0DEh,0FFh,0C0h,000h,000h
    db 000h,000h,000h,000h,000h,001h,0EFh,0FFh,0F6h,000h,000h,000h,000h,000h,000h,02Dh
    db 0CFh,06Eh,000h,0F3h,0F7h,000h,0E0h,000h,000h,079h,017h,0EFh,0DFh,0FCh,0F8h,000h
    db 000h,000h,000h,000h,000h,000h,0E7h,09Ch,070h,000h,000h,000h,000h,000h,000h,021h
    db 03Ch,080h,000h,077h,0FFh,0F0h,01Ch,000h,001h,0FFh,0F0h,001h,0FCh,00Fh,0DFh,000h
    db 000h,000h,000h,000h,000h,000h,0C3h,03Ch,0F0h,000h,000h,000h,000h,000h,000h,025h
    db 081h,060h,000h,01Fh,0FFh,0EFh,0F8h,000h,00Fh,03Fh,080h,000h,000h,07Bh,0BEh,000h
    db 000h,0A1h,000h,07Eh,063h,033h,063h,073h,067h,000h,03Eh,063h,030h,030h,063h,067h
    db 073h,063h,000h,07Bh,000h,07Bh,0A0h,000h,0D0h,0FBh,000h,000h,03Fh,0DBh,0FEh,000h
    db 000h,004h,002h,000h,080h,040h,00Fh,0FFh,0F0h,010h,080h,043h,0F0h,080h,0FFh,0FFh
    db 0C0h,080h,080h,000h,000h,000h,008h,010h,020h,000h,000h,020h,004h,0C1h,000h,010h
    db 020h,001h,008h,000h,021h,00Fh,0E7h,0FFh,0DEh,008h,021h,007h,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FFh,0F8h,000h,008h,000h,020h,004h,00Fh,0FFh,0FCh,001h,000h,010h
    db 000h,001h,00Bh,0FFh,0A1h,00Dh,0FFh,00Eh,07Ch,004h,021h,000h,000h,000h,000h,027h
    db 05Eh,0E0h,000h,000h,07Ch,000h,024h,092h,049h,024h,0E7h,0BFh,0FFh,092h,049h,024h
    db 000h,000h,000h,000h,000h,00Eh,0FFh,0FFh,0FEh,000h,000h,000h,000h,000h,000h,023h
    db 05Dh,06Eh,000h,007h,0F7h,0F0h,0E0h,000h,000h,000h,027h,0DEh,0FFh,0C0h,000h,000h
    db 000h,000h,000h,000h,000h,001h,0EFh,0F8h,0F7h,000h,000h,000h,000h,000h,000h,07Fh
    db 0CFh,06Eh,000h,0FBh,0FEh,0FFh,070h,000h,000h,0FCh,0C7h,0EFh,0EFh,0FCh,0F8h,000h
    db 000h,000h,000h,000h,000h,000h,0E3h,098h,060h,000h,000h,000h,000h,000h,000h,021h
    db 024h,080h,000h,077h,0FFh,0FCh,01Ch,000h,001h,0CFh,0F8h,000h,000h,00Fh,0DEh,000h
    db 000h,000h,000h,000h,000h,000h,0E3h,0B8h,0E0h,000h,000h,000h,000h,000h,000h,025h
    db 000h,0A0h,000h,03Fh,0FFh,0EFh,0F8h,000h,00Eh,03Fh,080h,000h,000h,0FBh,07Eh,000h
    db 000h,0A1h,000h,063h,07Fh,01Bh,063h,063h,063h,000h,003h,063h,07Ch,030h,06Bh,063h
    db 063h,07Fh,000h,0FBh,003h,07Dh,060h,001h,0ECh,0FBh,000h,000h,0FFh,0DBh,0FEh,000h
    db 000h,007h,0FEh,000h,0FFh,0C0h,007h,0FFh,0E0h,010h,0FFh,0C2h,000h,080h,080h,008h
    db 000h,080h,080h,000h,000h,000h,008h,010h,03Fh,0FFh,0FFh,0E0h,004h,001h,000h,01Fh
    db 020h,001h,008h,000h,021h,00Fh,0F7h,0FFh,0DEh,008h,021h,000h,000h,000h,000h,000h
    db 000h,000h,000h,000h,000h,000h,008h,000h,020h,004h,01Fh,0FFh,0FEh,001h,000h,010h
    db 000h,001h,00Ah,0AAh,0A1h,00Dh,0FFh,08Eh,0B8h,004h,021h,000h,000h,000h,000h,023h
    db 0DFh,0C0h,000h,000h,07Eh,000h,024h,092h,049h,024h,0B7h,0BFh,0FFh,0D2h,049h,024h
    db 000h,000h,000h,000h,000h,001h,0FFh,0F8h,0FEh,000h,000h,000h,000h,000h,000h,025h
    db 0E3h,0DFh,000h,007h,0C0h,07Ch,07Ch,000h,000h,000h,027h,0DEh,0FFh,0C0h,000h,000h
    db 000h,000h,000h,000h,000h,000h,0F7h,0F0h,0F7h,000h,000h,000h,000h,000h,000h,053h
    db 0FFh,03Ch,000h,0FDh,0FDh,0FFh,0F0h,000h,001h,0E6h,0E7h,0F7h,0F7h,0FCh,0FCh,000h
    db 000h,000h,000h,000h,000h,000h,0E3h,098h,060h,000h,000h,000h,000h,000h,000h,022h
    db 024h,040h,000h,077h,0FFh,0FEh,00Ch,000h,003h,0C7h,0F0h,000h,000h,00Fh,0DEh,000h
    db 000h,000h,000h,000h,000h,001h,0E7h,0B8h,0E0h,000h,000h,000h,000h,000h,000h,02Bh
    db 000h,0B0h,000h,03Fh,0FBh,0F6h,0F8h,000h,00Eh,03Fh,000h,000h,001h,0F7h,07Eh,000h
    db 000h,099h,000h,063h,060h,00Eh,063h,066h,063h,000h,063h,063h,030h,032h,03Eh,067h
    db 07Eh,060h,000h,0FDh,09Eh,0FCh,0F0h,003h,0B7h,0FBh,000h,000h,0FFh,0DBh,0FEh,000h
    db 000h,002h,004h,000h,040h,080h,000h,099h,000h,010h,040h,082h,03Fh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,0FFh,0FEh,000h,000h,008h,010h,020h,004h,000h,000h,004h,001h,000h,010h
    db 000h,081h,008h,000h,021h,00Fh,0FFh,0FFh,0DEh,008h,021h,000h,000h,000h,000h,000h
    db 000h,000h,000h,000h,000h,000h,008h,000h,020h,004h,03Fh,0FFh,0FFh,001h,000h,010h
    db 000h,001h,00Bh,0FFh,0A1h,00Fh,0BFh,0FFh,0B8h,006h,021h,000h,000h,000h,000h,023h
    db 09Fh,0C0h,000h,000h,0FFh,087h,03Fh,0FFh,0FFh,0FFh,0B7h,0BFh,0FFh,0FFh,0FFh,0FFh
    db 000h,000h,000h,000h,000h,001h,0FFh,0FFh,0FEh,000h,000h,000h,000h,000h,000h,02Bh
    db 0BEh,0DBh,000h,007h,0C0h,01Ch,01Fh,000h,000h,000h,017h,0DFh,07Fh,0C0h,000h,000h
    db 000h,000h,000h,000h,000h,000h,0F7h,0FFh,0F1h,000h,000h,000h,000h,000h,000h,05Eh
    db 081h,000h,000h,0FDh,0FFh,0FFh,0F8h,000h,001h,0F3h,0E7h,0F7h,0F7h,0FCh,0FCh,000h
    db 000h,000h,000h,000h,000h,000h,0C3h,018h,060h,000h,000h,000h,000h,000h,000h,022h
    db 024h,040h,000h,037h,0FFh,0FFh,084h,000h,003h,0C7h,0F0h,000h,000h,00Fh,0DEh,000h
    db 000h,000h,000h,000h,000h,001h,0C7h,000h,000h,000h,000h,000h,000h,000h,000h,037h
    db 000h,0B8h,000h,03Eh,0FDh,0F6h,0F8h,000h,01Eh,07Fh,000h,000h,003h,0F7h,07Eh,000h
    db 000h,042h,000h,07Eh,03Fh,04Ch,03Eh,06Fh,03Eh,000h,03Eh,03Eh,030h,01Ch,014h,03Bh
    db 063h,03Fh,000h,0FEh,07Eh,0FEh,0F8h,007h,03Ah,0F3h,000h,007h,0FFh,0B7h,0FEh,000h
    db 000h,003h,0FFh,07Dh,0FFh,080h,000h,0FFh,000h,01Dh,0FFh,082h,03Fh,0EAh,0BFh,0FFh
    db 055h,0FFh,0FAh,0AEh,000h,000h,008h,010h,020h,004h,000h,000h,004h,001h,000h,010h
    db 000h,081h,008h,0FEh,021h,01Fh,0FFh,0FFh,0DEh,008h,021h,000h,000h,000h,000h,000h
    db 000h,000h,000h,000h,000h,000h,008h,07Fh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 000h,001h,00Ah,0AAh,0A1h,00Fh,0BFh,0E1h,0D4h,002h,021h,000h,000h,000h,000h,020h
    db 09Fh,000h,000h,000h,0F5h,0FDh,03Fh,0FFh,0FFh,0FFh,0F7h,0BFh,0FFh,0FFh,0FFh,0FFh
    db 000h,000h,000h,000h,000h,001h,0FFh,0F8h,0FEh,000h,000h,000h,000h,000h,000h,02Fh
    db 0DDh,0DDh,000h,047h,0C0h,060h,000h,000h,000h,000h,00Fh,0DFh,07Fh,0C0h,000h,000h
    db 000h,000h,000h,000h,000h,000h,0F7h,0DEh,0F8h,000h,000h,000h,000h,000h,000h,07Ch
    db 0FFh,000h,000h,0FDh,0FFh,0FFh,0F8h,000h,001h,0DBh,0E3h,0F7h,0F7h,0FCh,0FCh,000h
    db 000h,000h,000h,000h,000h,000h,0C3h,018h,060h,000h,000h,000h,000h,000h,000h,022h
    db 042h,040h,000h,02Fh,0FFh,0FFh,0C4h,000h,003h,08Fh,0E0h,000h,000h,01Fh,0DEh,000h
    db 000h,000h,000h,000h,000h,001h,0C7h,000h,000h,000h,000h,000h,000h,000h,000h,07Fh
    db 000h,0FEh,000h,07Dh,0FEh,0F5h,0F0h,000h,03Ch,07Fh,000h,000h,007h,0EEh,0FEh,000h
    db 000h,03Ch,000h,000h,000h,038h,000h,000h,000h,000h,000h,000h,060h,000h,000h,000h
    db 000h,000h,000h,0AAh,0FEh,0AAh,0A8h,00Eh,011h,0E2h,000h,01Fh,0FFh,077h,0FEh,000h
    db 079h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h
    db 061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h
    db 061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h
    db 061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,079h
    db 079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h
    db 079h,079h,079h,079h,079h,079h,079h,079h,079h,059h,059h,059h,059h,059h,059h,079h
    db 079h,071h,071h,071h,071h,071h,071h,071h,071h,071h,071h,071h,071h,071h,071h,071h
    db 071h,071h,071h,071h,071h,071h,079h,079h,079h,059h,059h,059h,05Dh,05Dh,059h,079h
    db 079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h
    db 079h,079h,079h,079h,079h,079h,079h,079h,079h,059h,05Eh,05Eh,05Dh,05Dh,059h,079h
    db 049h,061h,061h,061h,061h,061h,061h,061h,059h,059h,061h,061h,061h,061h,061h,061h
    db 061h,061h,061h,061h,061h,061h,069h,069h,079h,059h,05Eh,05Eh,05Dh,05Dh,059h,079h
    db 049h,069h,069h,069h,069h,069h,069h,069h,069h,069h,069h,069h,069h,069h,069h,069h
    db 069h,051h,051h,051h,051h,051h,051h,079h,079h,059h,059h,059h,059h,059h,059h,079h
    db 049h,069h,069h,069h,069h,069h,069h,069h,069h,069h,069h,069h,069h,069h,069h,069h
    db 069h,051h,054h,054h,051h,051h,051h,079h,079h,059h,059h,059h,059h,059h,059h,079h
    db 049h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h
    db 079h,051h,054h,054h,051h,056h,051h,079h,079h,059h,059h,059h,059h,059h,059h,079h
    db 079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h
    db 079h,051h,054h,054h,051h,056h,051h,079h,079h,079h,079h,079h,079h,079h,079h,079h
    db 079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h
    db 079h,051h,051h,051h,056h,051h,051h,079h,079h,079h,079h,079h,079h,079h,079h,079h
    db 079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h
    db 079h,051h,051h,051h,056h,051h,051h,079h,079h,079h,079h,079h,079h,079h,079h,079h
    db 079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h
    db 079h,051h,051h,051h,051h,051h,051h,079h,079h,079h,079h,079h,079h,079h,079h,079h
    db 079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h
    db 079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h
    db 079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h
    db 079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h
    db 079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h
    db 079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h
    db 079h,079h,079h,079h,079h,079h,078h,078h,078h,079h,079h,079h,079h,079h,079h,079h
    db 079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,079h
    db 079h,079h,079h,079h,079h,078h,078h,030h,07Ah,079h,079h,079h,079h,079h,079h,079h
    db 079h,079h,079h,079h,079h,079h,079h,079h,079h,079h,07Ah,07Ah,07Ah,079h,079h,079h
    db 079h,079h,079h,079h,079h,078h,078h,060h,07Ah,079h,079h,079h,079h,079h,079h,078h
    db 07Ah,078h,079h,079h,07Ah,07Ah,079h,079h,079h,079h,06Ah,06Ah,07Ah,079h,079h,079h
    db 079h,079h,079h,079h,079h,078h,078h,058h,078h,079h,079h,079h,079h,079h,079h,079h
    db 079h,07Bh,079h,07Ah,07Ah,07Ah,07Eh,079h,079h,079h,07Ah,06Ah,06Ah,07Ah,079h,079h
    db 079h,079h,079h,079h,079h,078h,078h,068h,078h,079h,079h,079h,079h,079h,079h,079h
    db 072h,07Bh,079h,07Ah,07Ah,07Ah,07Ah,079h,079h,079h,06Ah,06Ah,06Ah,05Ah,07Bh,079h
    db 079h,079h,079h,079h,079h,079h,078h,078h,078h,079h,079h,079h,079h,079h,079h,078h
    db 07Ch,078h,079h,07Ah,07Ah,07Ah,07Ah,079h,079h,069h,069h,06Ah,06Ah,06Bh,06Bh,079h
    db 079h,079h,079h,079h,079h,078h,078h,078h,078h,079h,079h,079h,079h,079h,079h,07Ah
    db 078h,07Ah,079h,07Ah,07Ah,07Ah,07Ah,079h,079h,069h,069h,06Ah,06Bh,06Bh,06Bh,079h
    db 079h,07Ah,07Ah,07Ah,07Ah,07Ah,07Ah,07Ah,07Ah,07Ah,07Ah,07Ah,07Ah,07Ah,07Ah,07Ah
    db 07Ah,07Ah,079h,07Ah,07Ah,07Ah,07Ah,079h,069h,069h,069h,06Bh,06Bh,06Bh,06Bh,079h

WorkSpaceArea:
    ; db[432]
    db 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
    db 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
    db 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
    db 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
    db 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
    db 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
    db 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
    db 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
    db 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
    db 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
    db 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
    db 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
    db 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
    db 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
    db 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
    db 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
    db 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
    db 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
    db 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
    db 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
    db 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
    db 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
    db 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
    db 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
    db 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
    db 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
    db 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h

; Word Token Dictionary
;
; Tokens are stored using 5-bit bytes compressed together.
TokenDictionary:
    ; db[965]
    db 084h,0A2h,092h,0D8h,0A3h,0E8h,0C9h,0C4h,0CCh,061h,0EFh,0B5h,0D2h,0DEh,073h,0A7h
    db 025h,029h,0DFh,03Dh,087h,03Dh,099h,01Ah,05Ah,04Fh,0AEh,044h,051h,061h,06Fh,0D2h
    db 042h,04Ah,020h,0E6h,096h,024h,089h,0A9h,047h,086h,065h,048h,009h,014h,015h,0F2h
    db 05Eh,043h,0A4h,04Ch,018h,092h,044h,0F6h,0C9h,013h,028h,04Ah,075h,0A2h,013h,064h
    db 058h,0A7h,01Eh,0F9h,0A4h,023h,0EBh,0C9h,043h,0DFh,06Bh,0EFh,098h,077h,064h,06Ah
    db 087h,03Ch,022h,0C3h,04Ah,0E7h,0C9h,023h,003h,045h,0C9h,006h,056h,028h,07Ah,0F2h
    db 08Ch,027h,01Fh,045h,028h,04Ch,094h,05Ah,090h,027h,051h,024h,013h,043h,013h,005h
    db 0F2h,0EEh,034h,082h,0BDh,047h,00Eh,045h,032h,030h,086h,0E8h,093h,04Bh,016h,057h
    db 04Eh,090h,004h,0B5h,044h,051h,090h,0A7h,0B4h,0F7h,01Ch,04Ah,0B3h,0C8h,040h,051h
    db 09Ah,028h,0B5h,022h,013h,03Bh,08Fh,0C8h,020h,057h,04Ah,013h,0B5h,0C0h,042h,036h
    db 042h,026h,08Ah,0D0h,04Ch,0ACh,0B8h,051h,04Eh,061h,0C5h,025h,076h,0E4h,093h,081h
    db 022h,0D4h,09Eh,074h,0C9h,09Dh,044h,051h,06Ah,032h,050h,084h,0C6h,093h,085h,085h
    db 09Ch,064h,0A0h,048h,03Eh,0E9h,010h,07Bh,0F2h,0C8h,0D4h,008h,07Bh,012h,099h,040h
    db 064h,0A0h,0C8h,010h,0F9h,09Eh,033h,047h,006h,079h,00Eh,091h,025h,0B4h,089h,012h
    db 045h,0F2h,049h,097h,02Eh,04Ah,013h,016h,039h,015h,00Eh,0EAh,0C9h,095h,028h,03Ah
    db 0A8h,0C8h,040h,091h,059h,0B5h,005h,099h,05Ah,090h,061h,025h,08Ah,00Ah,00Dh,0F2h
    db 098h,04Ah,083h,03Ch,028h,050h,0F4h,064h,062h,088h,0C8h,072h,064h,06Ah,085h,084h
    db 0EBh,00Ch,095h,04Fh,0BAh,032h,0DEh,06Bh,0E3h,099h,0D4h,05Eh,075h,034h,024h,087h
    db 046h,0A2h,081h,014h,076h,0CCh,093h,065h,052h,083h,08Ah,03Bh,0C5h,0D0h,077h,08Bh
    db 044h,036h,031h,016h,04Eh,029h,0E4h,05Dh,057h,056h,029h,030h,04Dh,0F7h,02Eh,00Ah
    db 08Ch,015h,016h,056h,031h,037h,04Ch,05Ah,08Ah,0ACh,0C9h,015h,096h,028h,03Ah,023h
    db 0D8h,022h,05Dh,009h,0B2h,065h,003h,059h,048h,0EEh,018h,0F9h,074h,071h,087h,0BCh
    db 016h,092h,013h,061h,024h,037h,050h,031h,093h,006h,047h,08Ch,07Bh,092h,022h,033h
    db 05Fh,0A5h,0A8h,094h,030h,069h,0B9h,065h,052h,0C4h,0DEh,05Bh,0C9h,09Dh,041h,0DFh
    db 008h,074h,03Ch,077h,044h,099h,089h,094h,0C2h,0CAh,09Ch,085h,0A2h,0E0h,00Ah,07Ah
    db 055h,092h,0E7h,00Ah,0A1h,0F7h,019h,08Ah,064h,029h,0C5h,0BCh,02Ah,08Bh,049h,0B6h
    db 090h,099h,0B0h,099h,0C5h,016h,067h,04Ah,03Ah,088h,016h,097h,05Ch,021h,0B4h,0B8h
    db 023h,04Bh,00Bh,0C9h,011h,012h,0F2h,048h,074h,0A4h,069h,05Ch,03Ah,088h,01Ah,056h
    db 0F1h,093h,0A7h,03Dh,0B9h,092h,043h,0E3h,049h,056h,028h,04Ah,0F2h,049h,08Ah,0E4h
    db 073h,0C8h,084h,0BBh,064h,072h,0C9h,004h,069h,058h,068h,005h,0ADh,027h,093h,02Bh
    db 0ACh,0B0h,027h,009h,031h,025h,097h,09Bh,066h,049h,073h,055h,0B6h,064h,072h,087h
    db 0C8h,070h,09Eh,05Bh,0EDh,03Dh,007h,065h,072h,0A3h,018h,028h,0CBh,09Ch,067h,0A0h
    db 0F7h,066h,021h,0ABh,0E4h,032h,083h,02Dh,0E7h,051h,054h,0E4h,02Ch,027h,0B4h,062h
    db 026h,00Dh,092h,016h,01Ah,060h,021h,0C1h,011h,053h,01Ch,02Dh,0D2h,088h,092h,0DCh
    db 021h,028h,0CCh,022h,04Ah,071h,083h,03Ch,092h,05Fh,02Dh,037h,038h,07Ah,06Ch,091h
    db 0C9h,064h,072h,0C3h,05Ch,0B3h,08Eh,051h,0E6h,034h,095h,0A5h,0F1h,01Ch,04Dh,0AEh
    db 096h,063h,042h,062h,085h,098h,070h,042h,072h,023h,038h,0F2h,018h,021h,054h,066h
    db 092h,0DCh,031h,0E8h,0C9h,059h,0CAh,07Dh,0CCh,090h,034h,08Ah,0A1h,0F2h,031h,056h
    db 06Eh,062h,0C4h,09Ch,01Ah,024h,029h,046h,096h,052h,048h,090h,02Bh,0B5h,044h,05Ch
    db 03Ah,088h,0A2h,05Bh,0D8h,078h,0ADh,014h,016h,01Ch,029h,0ADh,04Eh,06Ah,04Ch,092h
    db 093h,022h,051h,0E8h,02Dh,0C5h,011h,057h,0EEh,078h,0B2h,098h,012h,064h,061h,02Fh
    db 090h,063h,002h,063h,0C5h,015h,0F3h,02Ah,03Bh,041h,0C8h,017h,008h,009h,0B2h,018h
    db 0F3h,0AAh,023h,0C8h,03Dh,08Ah,092h,03Bh,067h,096h,020h,007h,02Ah,02Dh,0B8h,07Ch
    db 00Ah,02Bh,0B6h,0B8h,043h,06Fh,061h,0B6h,014h,08Ah,092h,024h,0E6h,049h,062h,092h
    db 029h,0B4h,014h,077h,0E8h,02Dh,08Eh,066h,084h,0AAh,023h,0B2h,090h,044h,0D1h,0ABh
    db 033h,038h,032h,0DCh,02Bh,028h,0D8h,052h,060h,098h,093h,0DCh,020h,0D3h,07Ch,06Ch
    db 0D2h,034h,08Ah,011h,0E5h,004h,067h,066h,072h,0A3h,01Ch,011h,028h,065h,0C5h,0C8h
    db 044h,08Ah,044h,037h,048h,099h,09Eh,034h,081h,03Dh,057h,0CAh,064h,0E5h,09Ah,0E2h
    db 04Ah,0CBh,087h,0A2h,0E4h,0D6h,044h,036h,00Dh,0FAh,064h,02Eh,0B7h,038h,05Ah,0DCh
    db 073h,085h,0B4h,0E2h,088h,0A8h,094h,0A0h,034h,049h,060h,00Ch,055h,04Ah,08Bh,064h
    db 0B9h,0D8h,022h,073h,09Ah,02Ch,01Dh,044h,059h,036h,0B1h,026h,05Ah,00Ch,04Dh,0B2h
    db 010h,096h,09Ch,04Dh,0E7h,0C9h,040h,00Bh,041h,0E3h,0B5h,016h,01Ch,039h,023h,038h
    db 0F7h,068h,03Ah,035h,091h,0E0h,046h,031h,0F6h,0A5h,051h,0CCh,008h,08Ch,04Dh,034h
    db 051h,061h,0B4h,048h,025h,08Bh,091h,065h,0A2h,042h,0CCh,045h,069h,020h,043h,064h
    db 048h,0AEh,098h,0C4h,0D8h,0B1h,0E9h,0BCh,02Ah,00Bh,04Bh,0A6h,094h,09Bh,028h,02Ah
    db 028h,038h,072h,084h,04Ch,0EEh,04Ch,033h,0EFh,093h,0E4h,04Ch,016h,072h,091h,0E7h
    db 006h,05Ah,0E4h,024h,0A3h,042h,033h,0E4h,0BBh,00Eh,091h,032h,0A9h,07Ch,0D9h,0B0h
    db 012h,0C8h,024h,023h,0B8h,082h,012h,029h,007h,025h,042h,08Ah,02Bh,0B3h,094h,075h
    db 056h,062h,0ACh,090h,013h,08Ch,00Ch,089h,014h,0F1h,018h,029h,0E3h,031h,052h,05Ah
    db 062h,004h,0C9h,032h,064h,04Dh,0D4h,098h,074h,010h,03Dh,0F7h,031h,05Bh,026h,041h
    db 0A9h,015h,099h,0DCh,001h
SaveGameArea:
    ds "Lords of Midnight.  Save Game.\r\n"
    ds "(c) Copyright  Mike Singleton.\r\n"
    ds "PC Conversion      Chris Wild.\r\n"
    ds "                              \r\n"
    db 01Ah

; Save Game Area
;
; +-------+--------+-----------------------------------------------------+
; | Type  | Offset | Description                                         |
; +-------+--------+-----------------------------------------------------+
; | WORD  | 00     | days - days since the start of the game             |
; | BYTE  | 02     | char - current selected character                   |
; | BYTE  | 03     | unused                                              |
; | BYTE  | 04     | unused                                              |
; | BYTE  | 05     | unused                                              |
; | TABLE | 00     | garrisons                                           |
; | TABLE | 00     | special places                                      |
; | TABLE | 00     | regiments                                           |
; | TABLE | 00     | characters                                          |
; | TABLE | 00     | terrain map                                         |
; | TABLE | 00     | area map (only partially included in the save game) |
; +-------+--------+-----------------------------------------------------+
GameDays:
    dw 000h
; current selected character
SaveCurChar:
    db 000h
L6771:
    db 000h
L6772:
    db 000h
L6773:
    db 001h

; Garrisons: 102 entries corresponding to the keeps and citadels.
;
; Ushgarak is element 0x06; Xajorkith is element 0x60.
; +------+--------+---------------------------------------+
; | Type | Offset | Description                           |
; +------+--------+---------------------------------------+
; | BYTE | 00     | bits 0-1: Race                        |
; |      |        | bit  2:   Type (0=warriors, 1=riders) |
; |      |        | bits 3-7: Unused                      |
; | BYTE | 01     | total - size of this unit / 5         |
; +------+--------+---------------------------------------+
ArmyTable1:
    ; db[204]
    db 001h,078h,005h,028h,000h,050h,000h,0C8h,004h,03Ch,000h,064h,004h,0F0h,000h,0DCh
    db 004h,050h,001h,03Ch,000h,064h,002h,028h,000h,03Ch,000h,032h,004h,0C8h,004h,03Ch
    db 005h,028h,001h,01Eh,000h,028h,001h,03Ch,001h,08Ch,000h,032h,000h,064h,000h,028h
    db 002h,06Eh,005h,01Eh,000h,032h,000h,01Eh,001h,032h,000h,014h,001h,03Ch,002h,01Eh
    db 000h,0B4h,000h,014h,000h,046h,005h,050h,000h,032h,001h,028h,000h,028h,001h,03Ch
    db 005h,01Eh,004h,028h,000h,032h,001h,032h,000h,0C8h,000h,01Eh,005h,01Eh,005h,078h
    db 007h,028h,000h,03Ch,000h,03Ch,001h,08Ch,001h,032h,001h,01Eh,005h,014h,007h,046h
    db 001h,050h,001h,01Eh,001h,028h,001h,028h,001h,028h,001h,014h,005h,01Eh,006h,014h
    db 005h,032h,001h,096h,005h,014h,002h,064h,001h,06Eh,001h,01Eh,005h,014h,001h,01Eh
    db 001h,032h,001h,028h,005h,01Eh,005h,032h,001h,01Eh,001h,028h,001h,01Eh,001h,01Eh
    db 001h,028h,001h,032h,001h,032h,001h,028h,001h,01Eh,005h,014h,005h,078h,001h,032h
    db 001h,01Eh,001h,01Eh,001h,01Eh,001h,028h,001h,028h,001h,032h,005h,01Eh,001h,03Ch
    db 005h,096h,005h,00Ah,006h,03Ch,005h,032h,001h,032h,001h,028h

; Special Places: 112 entries
;
; The first 102 are keeps/citadels and have a corresponding entry in the
; garrisons table. The remaining are just in for extra routing. The left and
; right routing branch is used to randomly pick another location to head to.
; When an army of type 3 gets to a location in this table, they randomly pick
; the left or right branch and then goto the location specified in the table
; for that number.
; +------+--------+----------------------------+
; | Type | Offset | Description                |
; +------+--------+----------------------------+
; | WORD | 00     | map location               |
; | BYTE | 02     | left branch special place  |
; | BYTE | 03     | right branch special place |
; +------+--------+----------------------------+
ArmyTable2:
    ; db[448]
    db 008h,001h,000h,000h,02Eh,004h,001h,010h,01Ch,005h,002h,006h,016h,006h,003h,068h
    db 020h,007h,004h,006h,017h,008h,005h,003h,01Dh,008h,006h,00Eh,025h,008h,008h,00Ah
    db 028h,009h,001h,067h,039h,009h,009h,009h,027h,00Ah,00Ah,067h,00Bh,00Bh,00Bh,00Bh
    db 015h,00Ch,00Dh,016h,019h,00Ch,01Ah,016h,01Dh,00Dh,016h,017h,024h,00Dh,016h,017h
    db 033h,00Dh,013h,019h,03Eh,00Dh,014h,014h,010h,00Eh,015h,015h,037h,00Eh,011h,014h
    db 039h,010h,01Fh,06Eh,00Eh,011h,069h,01Dh,01Bh,011h,01Bh,022h,022h,011h,022h,029h
    db 02Ah,011h,018h,018h,034h,011h,014h,014h,013h,012h,020h,020h,016h,013h,01Ah,020h
    db 036h,013h,014h,01Fh,00Eh,015h,020h,020h,031h,015h,019h,01Ch,039h,015h,025h,025h
    db 012h,016h,02Ah,02Ah,02Ah,016h,021h,023h,01Fh,017h,026h,024h,02Eh,017h,023h,01Eh
    db 027h,018h,021h,027h,038h,019h,02Fh,037h,020h,01Ah,029h,029h,02Dh,01Bh,028h,02Eh
    db 036h,01Bh,025h,02Fh,022h,01Ch,02Dh,02Dh,011h,01Dh,02Ch,032h,02Ah,01Dh,02Eh,027h
    db 018h,01Eh,031h,032h,01Eh,01Eh,02Ch,032h,033h,01Eh,02Fh,030h,039h,01Eh,030h,037h
    db 037h,020h,037h,039h,015h,021h,034h,038h,017h,021h,038h,036h,02Bh,021h,03Dh,03Eh
    db 00Dh,022h,06Ah,040h,022h,022h,02Bh,033h,01Eh,023h,035h,03Ah,03Bh,023h,039h,03Fh
    db 015h,025h,03Bh,03Ch,036h,027h,03Dh,03Fh,01Bh,028h,041h,042h,016h,029h,040h,041h
    db 019h,029h,041h,045h,030h,029h,049h,04Ch,02Ah,02Ah,042h,044h,037h,02Ah,044h,04Ch
    db 011h,02Bh,048h,04Ah,01Ch,02Bh,06Fh,042h,025h,02Ch,046h,066h,03Bh,02Ch,043h,043h
    db 02Ch,02Eh,046h,049h,01Dh,02Fh,046h,04Ah,02Ah,02Fh,04Eh,04Bh,007h,030h,056h,055h
    db 00Ah,030h,051h,051h,030h,031h,04Bh,04Fh,015h,032h,052h,058h,02Dh,032h,050h,053h
    db 036h,033h,054h,05Eh,027h,034h,052h,059h,02Ah,034h,04Dh,053h,032h,034h,04Ch,05Eh
    db 02Eh,035h,053h,060h,00Ch,037h,056h,05Bh,019h,037h,066h,066h,02Ch,037h,060h,060h
    db 037h,037h,05Dh,060h,007h,038h,05Ah,05Ah,00Ah,038h,055h,05Bh,011h,039h,058h,06Dh
    db 015h,039h,06Dh,052h,025h,039h,05Ch,05Ch,008h,03Ah,05Bh,065h,00Ch,03Ah,065h,057h
    db 027h,03Bh,05Fh,05Fh,038h,03Bh,060h,060h,03Fh,03Bh,05Dh,064h,02Ah,03Ch,060h,060h
    db 02Dh,03Ch,060h,060h,004h,03Dh,05Bh,065h,021h,03Dh,05Ch,05Fh,017h,03Dh,052h,066h
    db 03Bh,03Dh,060h,060h,00Eh,03Dh,063h,063h,01Bh,03Ah,062h,062h,02Ah,00Ch,00Fh,00Fh
    db 012h,004h,00Ch,012h,007h,016h,034h,06Ah,006h,026h,06Bh,048h,002h,028h,06Ch,06Ch
    db 000h,030h,047h,061h,014h,03Dh,063h,063h,03Eh,019h,02Fh,037h,01Dh,02Dh,044h,045h

; Regiments - 128 entries for the free wandering armies of DoomDark.
;
; +------+--------+----------------------------------------+
; | Type | Offset | Description                            |
; +------+--------+----------------------------------------+
; | BYTE | 00     | Bits 0-5: X coord, Bits 6-7: Order     |
; | BYTE | 01     | Bits 0-5: Y coord                      |
; |      |        | Bits 6:   Unused                       |
; |      |        | Bit  7:   Type (0=warriors, 1=riders)  |
; | BYTE | 02     | total - size of this unit / 5          |
; | BYTE | 03     | id - either special place or character |
; +------+--------+----------------------------------------+
;
; Description of the "order" bits:
;
; +--------+---------------------------------------------------------------+
; | Binary | Description                                                   |
; +--------+---------------------------------------------------------------+
; | 00     | go to special location [ID] and stay there                    |
; | 01     | wander around                                                 |
; | 10     | follow character [ID] and kill him. then pick Luxor or Morkin |
; | 11     | go to special location [ID] then pick new location            |
; +--------+---------------------------------------------------------------+
ArmyTable3:
    ; db[512]
    db 09Dh,088h,0C8h,000h,09Dh,088h,0C8h,000h,09Dh,088h,0C8h,000h,09Dh,088h,0C8h,000h
    db 09Dh,088h,0C8h,000h,09Dh,088h,0C8h,000h,09Dh,088h,0C8h,000h,09Dh,088h,0C8h,000h
    db 09Dh,088h,0C8h,000h,09Dh,088h,0C8h,000h,09Dh,088h,0C8h,001h,09Dh,088h,0C8h,002h
    db 09Dh,088h,0C8h,003h,09Dh,088h,0C8h,004h,09Dh,088h,0C8h,005h,09Dh,088h,0C8h,006h
    db 09Dh,088h,0C8h,008h,09Dh,088h,0C8h,009h,09Dh,088h,0C8h,00Ah,09Dh,088h,0C8h,00Bh
    db 09Dh,088h,0C8h,00Dh,09Dh,088h,0C8h,00Eh,09Dh,088h,0C8h,010h,09Dh,088h,0C8h,013h
    db 09Dh,088h,0C8h,014h,09Dh,088h,0C8h,015h,09Dh,088h,0C8h,016h,09Dh,088h,0C8h,017h
    db 09Dh,088h,0C8h,018h,09Dh,088h,0C8h,019h,09Dh,088h,0C8h,01Ah,09Dh,088h,0C8h,01Bh
    db 0DDh,088h,0F0h,006h,0DDh,088h,0F0h,006h,0DDh,088h,0F0h,006h,0DDh,088h,0F0h,006h
    db 0DDh,088h,0F0h,006h,0DDh,088h,0F0h,006h,0DDh,088h,0F0h,006h,0DDh,088h,0F0h,006h
    db 0D6h,006h,0F0h,003h,0D6h,006h,0F0h,003h,0D6h,006h,0F0h,003h,0D6h,006h,0F0h,003h
    db 0E5h,008h,0F0h,007h,0E5h,008h,0F0h,007h,0E5h,008h,0F0h,007h,0E5h,008h,0F0h,007h
    db 09Dh,088h,0C8h,001h,09Dh,088h,0C8h,001h,0DDh,00Dh,0F0h,00Eh,0DDh,00Dh,0F0h,00Eh
    db 0DDh,00Dh,0F0h,00Eh,0DDh,00Dh,0F0h,00Eh,0DDh,00Dh,0F0h,00Eh,0DDh,00Dh,0F0h,00Eh
    db 0DDh,00Dh,0F0h,00Eh,0DDh,00Dh,0F0h,00Eh,0DDh,00Dh,0F0h,00Eh,0DDh,00Dh,0F0h,00Eh
    db 0DDh,00Dh,0F0h,00Eh,0DDh,00Dh,0F0h,00Eh,0DDh,00Dh,0F0h,00Eh,0DDh,00Dh,0F0h,00Eh
    db 0DDh,08Dh,0F0h,00Eh,0DDh,08Dh,0F0h,00Eh,0DDh,08Dh,0F0h,00Eh,0DDh,08Dh,0F0h,00Eh
    db 0DDh,08Dh,0F0h,00Eh,0DDh,08Dh,0F0h,00Eh,0DDh,08Dh,0F0h,00Eh,0DDh,08Dh,0F0h,00Eh
    db 0D2h,016h,0F0h,020h,0D2h,016h,0F0h,020h,0D2h,016h,0F0h,020h,0D2h,016h,0F0h,020h
    db 0D2h,016h,0F0h,020h,0D2h,016h,0F0h,020h,0D2h,016h,0F0h,020h,0D2h,016h,0F0h,020h
    db 0D2h,016h,0F0h,020h,0D2h,016h,0F0h,020h,0D2h,016h,0F0h,020h,0D2h,016h,0F0h,020h
    db 0D2h,016h,0F0h,020h,0D2h,016h,0F0h,020h,0D2h,016h,0F0h,020h,0D2h,016h,0F0h,020h
    db 0D2h,096h,0F0h,020h,0D2h,096h,0F0h,020h,0D2h,096h,0F0h,020h,0D2h,096h,0F0h,020h
    db 0D8h,01Eh,0F0h,02Ch,0D8h,01Eh,0F0h,02Ch,0D8h,01Eh,0F0h,02Ch,0D8h,01Eh,0F0h,02Ch
    db 047h,096h,0C8h,006h,05Bh,091h,0C8h,006h,068h,089h,0C8h,006h,067h,098h,0C8h,006h
    db 055h,0A1h,0C8h,006h,057h,0A1h,0C8h,006h,051h,01Dh,0C8h,006h,052h,004h,0C8h,006h
    db 05Eh,01Eh,0C8h,006h,050h,00Eh,0C8h,006h,05Fh,017h,0C8h,006h,046h,026h,0C8h,006h
    db 01Dh,008h,0F0h,006h,01Dh,008h,0F0h,006h,01Dh,008h,0F0h,006h,01Dh,008h,0F0h,006h
    db 01Dh,00Dh,0F0h,006h,016h,006h,0F0h,006h,025h,008h,0F0h,006h,017h,008h,0F0h,006h
    db 01Ch,005h,0F0h,006h,019h,00Ch,0F0h,00Eh,024h,00Dh,0F0h,007h,028h,009h,0F0h,007h
    db 027h,00Ah,0F0h,007h,020h,007h,0F0h,006h,015h,00Ch,0F0h,003h,01Dh,08Ah,0C8h,006h
    db 021h,088h,0C8h,006h,01Eh,087h,0C8h,006h,01Bh,087h,0C8h,006h,01Ah,088h,0C8h,006h

; Lords
;
; +------+--------+---------------------------------------------------------+
; | Type | Offset | Description                                             |
; +------+--------+---------------------------------------------------------+
; | WORD | 00     | location - current location                             |
; | BYTE | 02     | direction - currently looking                           |
; | BYTE | 03     | time - time of day                                      |
; | BYTE | 04     | first name - first name token                           |
; | BYTE | 05     | title - see title types                                 |
; | BYTE | 06     | Bit 1: [r]ecruited (0=no), Bit 2: [m]oonring (0=worn)   |
; | BYTE | 07     | graphic - see graphic types                             |
; | BYTE | 08     | riders - total riders / 5                               |
; | BYTE | 09     | riders_energy - riders energy                           |
; | BYTE | 10     | warriors - total warriors / 5                           |
; | BYTE | 11     | warriors_energy - warriors energy                       |
; | BYTE | 12     | battle_area - area currently in battle in               |
; | BYTE | 13     | riders_lost - number of riders lost in battle           |
; | BYTE | 14     | warriors_lost - number of warriors lost in battle       |
; | BYTE | 15     | killed                                                  |
; |      |        | number of the enemy killed by the character in battle   |
; | BYTE | 16     | riders_killed - enemy killed by riders                  |
; | BYTE | 17     | warriors_killed - enemy killed by warriors              |
; | BYTE | 18     | battle_status                                           |
; |      |        | 0xFF: no batle, 0x00: battle continues, 0xXX: who won   |
; | BYTE | 19     | alive - 0 or 1                                          |
; | BYTE | 20     | energy - current energy                                 |
; | BYTE | 21     | strength - current strength                             |
; | BYTE | 22     | cowardess                                               |
; | BYTE | 23     | recruiting_key                                          |
; | BYTE | 24     | recruited_by: the character who is doing the recruiting |
; |      |        | recruiting_key is ANDed with the recruited_by from the  |
; |      |        | character he wished to recruit and if it is not zero,   |
; |      |        | then recruiting can take place                          |
; | BYTE | 25     | courage                                                 |
; | BYTE | 26     | unused                                                  |
; | BYTE | 27     | hidden - 0 or 1                                         |
; | BYTE | 28     | race - see race table                                   |
; | BYTE | 29     | horse - 0 or 1                                          |
; | BYTE | 30     | object - object carrying - see object table             |
; | BYTE | 31     | death by                                                |
; |      |        | 0x00 - in battle                                        |
; |      |        | 0xXX - else the value is the object that killed him     |
; +------+--------+---------------------------------------------------------+
;
; Table of the midnight races:
;
; +-----+----------+
; | $00 | Doomdark |
; | $01 | Free     |
; | $02 | Fay      |
; | $03 | Targ     |
; | $04 | Wise     |
; | $05 | Morkin   |
; | $06 | Skulkrin |
; | $07 | Dragon   |
; +-----+----------+
;  Table of the character titles (firstname):
; +-------+----------------------------+
; | $00   | FirstName "the Moonprince" |
; | $01   | FirstName                  |
; | $02   | FirstName "the Fey"        |
; | $03   | FirstName "the Wise"       |
; | $04   | FirstName "the Dragonlord" |
; | $05   | FirstName "the Skulkrin"   |
; | < $0A | "The Lord of" FirstName    |
; | else  | "Lord" FirstName           |
; +-------+----------------------------+
CharTable:
    ; db[960]
    db 00Ch,029h,003h,010h,072h,000h,001h,001h,000h,058h,000h,058h,000h,000h,000h,000h
    db 000h,000h,0FFh,0B4h,07Fh,019h,050h,017h,000h,000h,000h,000h,001h,001h,00Fh,000h
    db 00Ch,029h,000h,010h,073h,001h,001h,004h,000h,058h,000h,058h,000h,000h,000h,000h
    db 000h,000h,0FFh,0C8h,07Fh,005h,07Fh,07Eh,000h,000h,000h,000h,005h,001h,000h,000h
    db 00Ch,029h,002h,010h,074h,002h,001h,00Fh,000h,058h,000h,058h,000h,000h,000h,000h
    db 000h,000h,0FFh,0B4h,07Fh,014h,060h,06Bh,000h,000h,000h,000h,002h,001h,000h,000h
    db 00Ch,029h,001h,010h,075h,003h,001h,003h,000h,058h,000h,058h,000h,000h,000h,000h
    db 000h,000h,0FFh,0DCh,07Fh,028h,050h,07Fh,000h,000h,000h,000h,004h,001h,000h,000h
    db 00Ah,038h,002h,010h,01Eh,007h,000h,001h,064h,058h,0C8h,058h,000h,000h,000h,000h
    db 000h,000h,0FFh,096h,040h,00Ah,040h,001h,001h,000h,000h,000h,001h,001h,000h,000h
    db 02Bh,021h,006h,010h,038h,007h,000h,001h,064h,058h,0C8h,058h,000h,000h,000h,000h
    db 000h,000h,0FFh,096h,040h,00Ah,040h,001h,001h,000h,000h,000h,001h,001h,000h,000h
    db 02Dh,03Ch,000h,010h,035h,007h,000h,001h,0A0h,058h,0F0h,058h,000h,000h,000h,000h
    db 000h,000h,0FFh,096h,040h,00Fh,040h,001h,001h,000h,000h,000h,001h,001h,000h,000h
    db 008h,001h,002h,010h,002h,007h,000h,001h,064h,058h,0C8h,058h,000h,000h,000h,000h
    db 000h,000h,0FFh,096h,040h,00Fh,038h,001h,001h,000h,000h,000h,001h,001h,000h,000h
    db 01Ch,02Bh,007h,010h,022h,007h,000h,001h,0A0h,058h,0C8h,058h,000h,000h,000h,000h
    db 000h,000h,0FFh,096h,040h,00Fh,040h,001h,001h,000h,000h,000h,001h,001h,000h,000h
    db 039h,01Eh,004h,010h,037h,007h,000h,001h,08Ch,058h,0C8h,058h,000h,000h,000h,000h
    db 000h,000h,0FFh,096h,040h,00Ah,040h,001h,001h,000h,000h,000h,001h,001h,000h,000h
    db 039h,010h,007h,010h,033h,007h,000h,001h,0C8h,058h,0F0h,058h,000h,000h,000h,000h
    db 000h,000h,0FFh,096h,040h,00Fh,040h,009h,001h,000h,000h,000h,001h,001h,000h,000h
    db 02Ch,02Eh,000h,010h,03Dh,007h,000h,001h,064h,058h,0A0h,058h,000h,000h,000h,000h
    db 000h,000h,0FFh,078h,040h,008h,030h,001h,001h,000h,000h,000h,001h,001h,000h,000h
    db 02Ah,011h,000h,010h,032h,006h,000h,00Fh,0A0h,058h,0F0h,058h,000h,000h,000h,000h
    db 000h,000h,0FFh,0B4h,040h,014h,05Ah,01Fh,008h,000h,000h,000h,002h,001h,000h,000h
    db 03Bh,02Ch,000h,010h,03Ch,006h,000h,00Fh,050h,058h,0C8h,058h,000h,000h,000h,000h
    db 000h,000h,0FFh,096h,040h,00Fh,050h,01Fh,008h,000h,000h,000h,002h,001h,000h,000h
    db 021h,03Dh,006h,010h,02Ah,002h,000h,00Fh,078h,058h,050h,058h,000h,000h,000h,000h
    db 000h,000h,0FFh,082h,040h,00Ch,05Ah,01Ah,002h,000h,000h,000h,002h,001h,000h,000h
    db 039h,015h,007h,010h,034h,008h,000h,00Fh,03Ch,058h,078h,058h,000h,000h,000h,000h
    db 000h,000h,0FFh,096h,040h,00Ch,050h,01Ah,002h,000h,000h,000h,002h,001h,000h,000h
    db 00Bh,026h,000h,010h,01Ah,008h,000h,010h,000h,058h,0C8h,058h,000h,000h,000h,000h
    db 000h,000h,0FFh,082h,040h,00Ch,046h,01Ah,002h,000h,000h,000h,002h,000h,000h,000h
    db 00Bh,00Bh,002h,010h,001h,008h,000h,00Fh,028h,058h,064h,058h,000h,000h,000h,000h
    db 000h,000h,0FFh,064h,040h,008h,03Ch,01Ah,002h,000h,000h,000h,002h,001h,000h,000h
    db 017h,016h,000h,010h,078h,002h,000h,010h,000h,058h,0C8h,058h,000h,000h,000h,000h
    db 000h,000h,0FFh,078h,040h,00Ch,03Ch,01Ah,002h,000h,000h,000h,002h,000h,000h,000h
    db 021h,027h,007h,010h,01Ch,008h,000h,00Fh,03Ch,058h,078h,058h,000h,000h,000h,000h
    db 000h,000h,0FFh,096h,040h,00Ah,046h,01Ah,002h,000h,000h,000h,002h,001h,000h,000h
    db 015h,032h,001h,010h,025h,00Bh,000h,001h,064h,058h,03Ch,058h,000h,000h,000h,000h
    db 000h,000h,0FFh,064h,040h,008h,028h,001h,001h,000h,000h,000h,001h,001h,000h,000h
    db 017h,03Dh,000h,010h,028h,00Bh,000h,001h,0A0h,058h,050h,058h,000h,000h,000h,000h
    db 000h,000h,0FFh,064h,040h,008h,032h,001h,001h,000h,000h,000h,001h,001h,000h,000h
    db 036h,033h,007h,010h,03Eh,00Bh,000h,001h,050h,058h,0A0h,058h,000h,000h,000h,000h
    db 000h,000h,0FFh,064h,040h,008h,023h,001h,001h,000h,000h,000h,001h,001h,000h,000h
    db 027h,034h,000h,010h,029h,009h,000h,001h,03Ch,058h,0A0h,058h,000h,000h,000h,000h
    db 000h,000h,0FFh,078h,040h,008h,028h,001h,001h,000h,000h,000h,001h,001h,000h,000h
    db 036h,027h,000h,010h,03Bh,00Bh,000h,001h,0A0h,058h,03Ch,058h,000h,000h,000h,000h
    db 000h,000h,0FFh,078h,040h,008h,032h,001h,001h,000h,000h,000h,001h,001h,000h,000h
    db 015h,025h,000h,010h,01Bh,00Bh,000h,001h,0F0h,058h,000h,058h,000h,000h,000h,000h
    db 000h,000h,0FFh,096h,040h,00Fh,050h,001h,001h,000h,000h,000h,001h,001h,000h,000h
    db 02Dh,01Bh,001h,010h,036h,00Bh,000h,001h,064h,058h,078h,058h,000h,000h,000h,000h
    db 000h,000h,0FFh,082h,040h,008h,028h,001h,001h,000h,000h,000h,001h,001h,000h,000h
    db 01Dh,02Fh,000h,010h,01Fh,00Bh,000h,001h,064h,058h,078h,058h,000h,000h,000h,000h
    db 000h,000h,0FFh,082h,040h,008h,032h,001h,001h,000h,000h,000h,001h,001h,000h,000h
    db 03Bh,023h,006h,010h,03Ah,00Ah,000h,000h,0C8h,058h,000h,058h,000h,000h,000h,000h
    db 000h,000h,0FFh,0B4h,040h,014h,050h,000h,004h,000h,000h,000h,003h,001h,000h,000h
    db 001h,00Bh,002h,010h,076h,005h,000h,00Ch,000h,058h,000h,058h,000h,000h,000h,000h
    db 000h,000h,0FFh,0C8h,040h,001h,01Eh,000h,020h,000h,000h,000h,006h,000h,000h,000h

MainMapCalcHLTable:
    ; db[64]
    db 03Eh,001h,004h,010h,02Dh,003h,000h,003h,000h,058h,000h,058h,000h,000h,000h,000h
    db 000h,000h,0FFh,0C8h,040h,014h,046h,07Fh,010h,000h,000h,000h,004h,000h,000h,000h
    db 00Ch,018h,003h,010h,077h,004h,000h,006h,000h,058h,000h,058h,000h,000h,000h,000h
    db 000h,000h,0FFh,0C8h,040h,064h,07Fh,000h,040h,000h,000h,000h,007h,001h,000h,000h

; Terrain map - 64x61 byte map running x - y
;
; Each entry is a single BYTE:
; +------+------------------+
; | Bits | Description      |
; +------+------------------+
; | 0-3  | Terrain table ID |
; | 4-7  | Object table ID  |
; +------+------------------+
MainMap:
    ; db[7805]
    db 00Ah,00Ah,06Bh,00Fh,0C8h,00Fh,000h,000h,061h,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh
    db 00Fh,00Fh,00Fh,00Fh,068h,00Fh,00Fh,00Fh,00Ah,00Ah,00Ch,05Fh,00Fh,00Fh,073h,00Fh
    db 00Fh,00Fh,00Fh,00Fh,05Fh,01Fh,00Ah,00Ah,0BCh,00Fh,00Fh,00Bh,00Fh,068h,00Fh,00Fh
    db 00Fh,00Ah,00Fh,068h,00Fh,00Fh,00Fh,068h,00Fh,00Fh,00Ah,00Ah,00Ah,00Fh,074h,00Fh
    db 00Ah,00Fh,00Fh,00Fh,046h,030h,000h,000h,000h,000h,00Fh,00Fh,00Fh,0A8h,00Fh,002h
    db 002h,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Ah,00Ah,00Ah,00Ah,006h,056h,00Fh,00Fh,00Fh
    db 00Fh,00Fh,0A8h,00Fh,00Fh,00Fh,05Fh,068h,00Fh,00Fh,00Fh,006h,006h,006h,099h,006h
    db 026h,00Fh,05Fh,00Fh,093h,00Fh,00Fh,00Fh,00Fh,00Fh,03Dh,00Ah,00Ah,099h,00Fh,0A8h
    db 00Fh,00Fh,00Fh,006h,000h,030h,000h,000h,000h,000h,040h,00Fh,00Fh,01Fh,002h,002h
    db 002h,012h,00Fh,00Fh,0BCh,05Fh,00Ah,00Ah,000h,000h,000h,020h,020h,006h,006h,006h
    db 00Fh,00Fh,05Fh,01Fh,00Fh,00Fh,00Fh,00Fh,00Fh,006h,046h,006h,056h,036h,036h,016h
    db 006h,026h,006h,03Dh,00Fh,05Fh,00Ch,00Fh,006h,026h,00Fh,00Ah,00Ah,068h,00Fh,00Ah
    db 00Fh,002h,016h,006h,02Dh,040h,000h,000h,000h,000h,002h,002h,002h,00Fh,002h,002h
    db 002h,002h,0B3h,00Fh,00Fh,0DDh,000h,000h,000h,020h,000h,000h,000h,0CBh,020h,000h
    db 00Fh,00Fh,00Fh,099h,00Fh,068h,00Fh,00Fh,006h,006h,006h,056h,006h,006h,067h,006h
    db 006h,016h,006h,006h,036h,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Ah,00Fh,00Ah,00Ah
    db 00Fh,002h,002h,099h,00Fh,00Fh,000h,000h,000h,040h,002h,012h,002h,00Fh,00Fh,002h
    db 002h,00Fh,00Fh,006h,006h,000h,030h,030h,06Dh,042h,0E4h,002h,067h,000h,000h,000h
    db 000h,0CBh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,006h,068h,006h,006h,006h,006h
    db 006h,06Dh,036h,006h,006h,00Fh,00Fh,006h,05Fh,0B8h,00Fh,00Fh,00Ch,00Ah,00Ah,00Ah
    db 00Fh,00Fh,012h,002h,002h,01Fh,00Fh,020h,042h,002h,002h,002h,002h,00Fh,00Fh,00Fh
    db 07Ch,00Fh,00Fh,020h,000h,00Fh,061h,002h,042h,002h,002h,012h,05Fh,00Fh,065h,000h
    db 000h,000h,040h,000h,020h,030h,00Fh,00Fh,00Fh,0CCh,00Fh,006h,046h,006h,056h,006h
    db 056h,006h,006h,006h,026h,006h,01Fh,00Fh,01Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Ah,00Ah
    db 00Fh,00Fh,002h,002h,002h,002h,00Fh,00Fh,002h,002h,002h,002h,012h,002h,00Fh,00Fh
    db 00Fh,00Fh,00Fh,0CBh,000h,030h,006h,006h,06Bh,00Fh,00Fh,00Fh,01Fh,00Fh,00Fh,05Fh
    db 067h,000h,000h,000h,000h,020h,000h,000h,00Fh,00Fh,00Fh,00Fh,02Dh,006h,006h,016h
    db 006h,006h,026h,0DBh,00Fh,00Fh,00Fh,0DCh,00Fh,00Fh,00Fh,006h,00Fh,00Fh,00Fh,00Ah
    db 00Fh,0B8h,00Fh,012h,002h,012h,00Fh,00Fh,002h,002h,002h,002h,002h,012h,002h,002h
    db 00Fh,00Fh,00Fh,00Fh,0CCh,000h,000h,067h,006h,006h,00Fh,065h,00Fh,061h,00Fh,00Fh
    db 00Fh,00Fh,00Fh,00Fh,00Fh,0D1h,00Fh,000h,020h,0CBh,002h,05Fh,00Fh,00Fh,00Fh,01Fh
    db 006h,006h,00Fh,00Fh,00Fh,00Fh,00Fh,030h,020h,000h,00Fh,0CDh,00Fh,074h,099h,00Fh
    db 00Fh,00Fh,00Fh,00Fh,0B8h,00Fh,00Fh,002h,002h,002h,002h,0B3h,040h,002h,042h,002h
    db 012h,00Fh,00Fh,00Fh,01Fh,099h,000h,000h,000h,020h,002h,0BCh,01Fh,05Fh,000h,000h
    db 000h,040h,020h,020h,040h,000h,006h,006h,067h,00Fh,01Fh,00Fh,068h,002h,099h,00Fh
    db 099h,00Fh,073h,00Fh,00Fh,03Dh,000h,000h,020h,067h,040h,000h,000h,030h,00Fh,00Fh
    db 05Fh,00Fh,00Ch,09Ch,0BCh,0CCh,07Ch,002h,002h,002h,06Dh,065h,074h,00Fh,065h,012h
    db 012h,00Fh,00Fh,00Fh,00Fh,00Fh,000h,000h,000h,000h,000h,000h,006h,00Fh,000h,000h
    db 040h,040h,000h,040h,074h,000h,000h,067h,01Fh,07Ch,00Fh,00Fh,042h,002h,002h,00Fh
    db 00Fh,00Fh,00Fh,00Fh,0A8h,00Fh,00Fh,040h,000h,000h,000h,099h,000h,000h,099h,01Fh
    db 00Fh,083h,00Fh,01Fh,00Fh,00Fh,00Fh,0ADh,002h,002h,006h,067h,099h,0DCh,08Bh,002h
    db 002h,00Fh,0CBh,00Fh,00Fh,00Fh,00Fh,002h,000h,000h,000h,000h,040h,00Fh,000h,000h
    db 000h,000h,099h,000h,000h,000h,000h,000h,06Bh,01Fh,00Fh,002h,042h,012h,002h,002h
    db 00Fh,00Ch,00Fh,07Ch,01Fh,00Fh,002h,0ADh,000h,000h,099h,000h,000h,099h,00Fh,00Fh
    db 00Fh,00Fh,00Ch,00Ch,0BCh,0BCh,0DCh,00Fh,002h,012h,012h,056h,006h,05Fh,002h,002h
    db 002h,05Fh,00Fh,00Fh,00Fh,067h,00Fh,00Fh,00Fh,067h,030h,020h,030h,00Fh,040h,000h
    db 000h,006h,036h,046h,046h,006h,030h,040h,006h,046h,06Dh,042h,002h,074h,002h,012h
    db 042h,002h,05Fh,00Fh,002h,00Fh,068h,00Fh,000h,000h,000h,000h,00Fh,068h,00Fh,00Fh
    db 01Fh,00Fh,00Fh,00Fh,016h,036h,00Fh,002h,042h,002h,002h,002h,002h,002h,012h,042h
    db 00Fh,00Fh,00Fh,00Fh,00Fh,000h,020h,00Fh,00Fh,006h,006h,040h,040h,061h,000h,020h
    db 05Fh,00Fh,00Fh,006h,067h,026h,006h,026h,006h,042h,002h,042h,002h,002h,002h,002h
    db 002h,002h,012h,067h,01Fh,00Fh,01Fh,006h,000h,040h,000h,00Fh,00Fh,00Fh,067h,00Fh
    db 00Fh,00Fh,00Fh,006h,006h,056h,006h,006h,002h,002h,002h,002h,002h,002h,00Fh,00Fh
    db 067h,00Fh,00Fh,000h,000h,000h,056h,006h,036h,00Fh,006h,006h,00Fh,00Fh,00Fh,01Fh
    db 00Fh,00Fh,0DCh,00Fh,00Fh,00Fh,0DCh,00Fh,002h,002h,002h,099h,012h,002h,042h,002h
    db 012h,002h,012h,00Fh,00Fh,00Fh,006h,067h,099h,00Fh,00Fh,016h,05Fh,00Fh,00Fh,00Fh
    db 00Fh,00Fh,00Fh,006h,046h,006h,07Ch,026h,016h,0ABh,00Fh,00Fh,00Fh,00Fh,068h,00Fh
    db 00Fh,00Fh,000h,000h,000h,006h,036h,0CBh,01Fh,00Fh,00Fh,00Fh,01Fh,01Fh,01Fh,00Fh
    db 00Fh,00Fh,002h,012h,002h,042h,002h,042h,002h,002h,002h,002h,012h,002h,002h,00Fh
    db 065h,002h,042h,00Fh,00Fh,026h,006h,01Fh,00Fh,00Fh,006h,00Fh,065h,065h,00Fh,00Fh
    db 00Fh,00Fh,016h,0DBh,006h,006h,006h,006h,026h,00Fh,02Dh,00Fh,09Ch,00Fh,00Fh,00Fh
    db 00Fh,020h,000h,000h,002h,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,05Fh,05Fh
    db 00Fh,00Fh,002h,002h,042h,0DBh,002h,002h,012h,002h,002h,002h,00Ch,002h,002h,06Bh
    db 00Fh,00Fh,00Fh,00Fh,012h,00Fh,05Fh,07Ch,00Fh,0C1h,00Fh,00Fh,00Fh,00Fh,00Fh,06Dh
    db 01Fh,00Fh,006h,006h,006h,06Dh,006h,006h,006h,006h,00Fh,00Fh,00Fh,01Fh,067h,00Fh
    db 000h,065h,000h,00Fh,00Fh,09Ch,00Fh,00Fh,00Fh,099h,00Fh,067h,00Fh,00Fh,00Fh,00Fh
    db 00Fh,00Fh,067h,002h,012h,002h,002h,065h,002h,002h,061h,012h,002h,002h,002h,002h
    db 05Fh,06Bh,00Fh,00Fh,067h,065h,00Fh,00Fh,00Fh,00Fh,065h,0DBh,042h,002h,068h,00Fh
    db 0C8h,00Fh,056h,016h,006h,006h,006h,065h,006h,099h,05Fh,05Fh,00Fh,00Fh,00Fh,000h
    db 000h,020h,000h,067h,01Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh
    db 00Fh,00Fh,00Fh,012h,012h,002h,002h,012h,002h,002h,002h,002h,042h,02Dh,002h,002h
    db 065h,00Fh,00Fh,00Fh,00Fh,065h,065h,00Fh,099h,00Fh,00Fh,012h,002h,002h,002h,00Fh
    db 00Fh,00Fh,006h,006h,006h,056h,026h,006h,006h,006h,006h,00Fh,00Fh,00Fh,00Fh,00Fh
    db 030h,030h,000h,006h,01Fh,00Fh,067h,00Fh,00Fh,012h,042h,05Fh,05Fh,00Fh,00Fh,00Fh
    db 00Fh,0DCh,00Fh,002h,042h,002h,002h,002h,000h,000h,002h,002h,012h,002h,012h,042h
    db 002h,00Fh,099h,0DCh,07Ch,01Fh,067h,0DBh,002h,012h,042h,0BCh,002h,002h,002h,002h
    db 00Fh,000h,000h,006h,056h,00Fh,0CBh,006h,006h,00Fh,00Fh,00Fh,002h,002h,00Fh,00Fh
    db 099h,000h,000h,006h,00Fh,00Fh,002h,042h,042h,002h,012h,012h,00Fh,00Ch,00Fh,00Fh
    db 0BCh,01Fh,00Ch,00Fh,00Fh,00Fh,042h,002h,002h,012h,002h,012h,065h,099h,042h,002h
    db 002h,00Fh,00Fh,00Fh,00Fh,000h,000h,000h,000h,012h,012h,002h,00Fh,002h,002h,002h
    db 00Fh,000h,000h,000h,016h,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,000h,000h,067h,00Fh
    db 00Fh,00Fh,00Fh,006h,006h,002h,042h,042h,012h,099h,012h,002h,002h,00Fh,00Fh,00Fh
    db 00Fh,09Ch,01Fh,0BCh,006h,06Bh,002h,002h,002h,012h,002h,00Fh,00Fh,099h,00Fh,00Fh
    db 01Fh,067h,00Fh,000h,000h,030h,000h,000h,002h,0C7h,002h,002h,065h,042h,012h,002h
    db 01Fh,0DBh,000h,020h,000h,00Fh,00Fh,0CCh,00Fh,00Fh,000h,030h,020h,030h,030h,000h
    db 00Fh,00Fh,061h,00Fh,006h,012h,012h,065h,012h,002h,002h,002h,002h,00Fh,00Fh,00Fh
    db 00Fh,00Fh,0DCh,00Fh,07Ch,006h,05Fh,002h,002h,002h,067h,00Fh,073h,05Fh,00Fh,0CBh
    db 05Fh,040h,020h,000h,020h,000h,020h,002h,002h,002h,002h,002h,042h,00Fh,002h,002h
    db 00Fh,00Fh,000h,030h,030h,00Fh,05Fh,00Fh,00Fh,000h,040h,000h,000h,020h,020h,000h
    db 030h,00Fh,00Fh,00Fh,042h,002h,002h,002h,002h,002h,012h,002h,00Fh,00Fh,00Fh,067h
    db 065h,00Fh,026h,0BCh,00Fh,056h,00Fh,00Fh,016h,006h,006h,046h,026h,006h,067h,000h
    db 000h,000h,020h,000h,020h,00Fh,073h,002h,002h,002h,074h,002h,002h,0CCh,002h,002h
    db 00Fh,00Fh,0A3h,000h,000h,01Fh,00Fh,00Fh,00Fh,040h,000h,000h,0DBh,065h,000h,020h
    db 000h,020h,00Fh,099h,00Fh,002h,002h,042h,002h,012h,002h,00Fh,00Fh,00Fh,01Fh,00Fh
    db 01Fh,00Fh,026h,00Fh,0BCh,00Fh,00Fh,067h,00Fh,00Fh,00Fh,065h,000h,000h,000h,000h
    db 020h,040h,020h,00Fh,099h,01Fh,00Fh,00Fh,002h,042h,002h,002h,002h,002h,01Fh,065h
    db 00Fh,00Fh,000h,000h,002h,01Fh,00Fh,099h,00Fh,040h,000h,000h,074h,099h,030h,000h
    db 020h,00Fh,00Fh,00Fh,00Fh,000h,000h,000h,000h,000h,000h,000h,01Fh,00Fh,00Fh,00Fh
    db 00Fh,006h,0CDh,00Fh,0CCh,00Fh,00Fh,00Fh,01Fh,0CCh,000h,000h,000h,000h,000h,000h
    db 00Fh,06Bh,002h,00Fh,00Fh,00Fh,065h,00Fh,067h,002h,002h,012h,065h,00Fh,08Bh,01Fh
    db 00Fh,002h,000h,030h,099h,00Fh,00Fh,000h,00Fh,00Fh,000h,000h,000h,000h,020h,000h
    db 00Fh,00Fh,05Fh,065h,020h,040h,030h,000h,040h,000h,040h,000h,030h,000h,00Fh,00Fh
    db 067h,000h,030h,00Fh,0DBh,0CBh,00Fh,00Fh,099h,030h,000h,000h,000h,020h,00Fh,00Fh
    db 00Fh,00Fh,00Fh,065h,00Fh,0BCh,01Fh,065h,00Fh,00Fh,00Fh,00Fh,00Fh,0ADh,00Fh,01Fh
    db 00Fh,020h,000h,030h,05Fh,00Fh,002h,000h,030h,00Fh,00Fh,000h,000h,000h,030h,002h
    db 07Ch,006h,000h,040h,000h,000h,040h,040h,000h,000h,020h,000h,040h,040h,000h,000h
    db 000h,030h,030h,00Fh,00Fh,00Fh,00Fh,000h,000h,000h,040h,020h,00Fh,067h,000h,000h
    db 000h,030h,000h,040h,00Fh,05Fh,067h,00Fh,0DBh,01Fh,00Fh,00Ch,00Fh,00Fh,0CBh,002h
    db 00Fh,000h,000h,030h,00Fh,00Fh,020h,074h,000h,040h,00Fh,042h,000h,030h,000h,020h
    db 006h,00Fh,040h,020h,000h,000h,002h,06Bh,065h,006h,020h,000h,000h,000h,030h,020h
    db 000h,000h,067h,00Fh,00Fh,074h,030h,000h,020h,000h,000h,00Fh,065h,00Fh,099h,000h
    db 030h,030h,030h,000h,000h,000h,000h,020h,000h,020h,065h,01Fh,006h,006h,002h,002h
    db 00Fh,00Fh,020h,030h,00Fh,05Fh,000h,030h,000h,030h,00Fh,002h,000h,040h,000h,06Bh
    db 00Fh,067h,00Fh,00Fh,00Fh,00Ch,006h,006h,00Fh,00Fh,099h,006h,000h,000h,000h,00Fh
    db 00Fh,00Fh,00Fh,00Fh,000h,000h,000h,040h,000h,000h,067h,00Fh,074h,00Fh,00Fh,00Fh
    db 00Fh,065h,040h,000h,000h,030h,040h,000h,000h,000h,065h,00Fh,06Bh,006h,046h,042h
    db 00Fh,0A8h,002h,002h,00Fh,00Fh,020h,000h,000h,000h,01Fh,002h,000h,000h,000h,01Fh
    db 00Fh,00Fh,000h,040h,00Fh,006h,00Fh,00Fh,061h,00Fh,00Fh,00Fh,00Fh,00Fh,067h,00Fh
    db 00Fh,00Fh,000h,020h,000h,030h,000h,000h,0DBh,00Fh,00Fh,006h,030h,000h,002h,012h
    db 046h,00Fh,00Fh,067h,00Fh,00Fh,00Fh,00Fh,00Fh,061h,01Fh,00Fh,00Fh,00Fh,05Fh,0DCh
    db 00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,020h,02Dh,020h,000h,00Fh,00Fh,030h,000h,020h,099h
    db 0BCh,000h,020h,040h,040h,020h,0DBh,00Fh,00Fh,08Bh,000h,000h,030h,040h,030h,000h
    db 000h,000h,040h,020h,000h,000h,000h,00Fh,00Fh,065h,00Fh,000h,000h,000h,000h,040h
    db 000h,000h,000h,000h,000h,000h,000h,000h,00Fh,00Fh,00Fh,00Fh,074h,074h,01Fh,01Fh
    db 00Fh,00Fh,00Fh,000h,01Fh,00Fh,000h,020h,000h,030h,05Fh,01Fh,000h,000h,000h,000h
    db 020h,000h,074h,020h,000h,040h,00Fh,00Fh,00Fh,030h,000h,040h,000h,000h,000h,030h
    db 000h,000h,040h,000h,020h,000h,03Dh,00Fh,099h,046h,046h,0CBh,000h,040h,000h,030h
    db 000h,000h,000h,020h,000h,000h,000h,067h,00Fh,00Fh,0ABh,00Fh,01Fh,00Fh,00Ch,099h
    db 00Fh,00Fh,00Fh,000h,040h,00Fh,000h,000h,000h,000h,00Fh,00Fh,00Fh,000h,000h,000h
    db 000h,000h,000h,000h,040h,067h,05Fh,067h,000h,000h,020h,000h,040h,040h,000h,000h
    db 000h,000h,030h,000h,06Bh,00Fh,00Fh,05Fh,00Fh,00Fh,006h,0C1h,00Fh,01Fh,00Fh,00Fh
    db 00Fh,00Fh,065h,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,002h,065h,00Fh,099h,00Fh
    db 00Fh,00Fh,068h,000h,000h,00Fh,000h,000h,040h,000h,000h,01Fh,01Fh,067h,020h,000h
    db 020h,040h,030h,00Fh,00Fh,05Fh,00Fh,00Fh,000h,000h,00Fh,00Fh,00Fh,00Fh,05Fh,00Fh
    db 00Fh,00Fh,067h,00Fh,00Fh,00Fh,00Fh,002h,00Fh,00Fh,00Fh,0CCh,00Fh,00Fh,01Fh,065h
    db 00Fh,07Ch,00Fh,00Fh,0ADh,00Fh,00Fh,065h,00Fh,07Ch,00Fh,00Fh,00Fh,00Fh,002h,00Fh
    db 05Fh,00Fh,020h,000h,000h,00Fh,00Fh,020h,030h,00Fh,0DBh,00Fh,05Fh,00Fh,00Fh,0ABh
    db 00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,05Fh,00Fh,00Fh,00Fh,00Fh,093h,00Fh,00Fh,067h,00Fh
    db 00Fh,00Fh,01Fh,09Ch,00Bh,00Fh,00Fh,00Fh,00Fh,0BCh,01Fh,00Fh,016h,006h,00Fh,0B3h
    db 00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,05Fh,0D7h,00Fh,00Fh,01Fh,00Fh
    db 00Fh,01Fh,030h,000h,020h,000h,00Fh,000h,00Fh,00Fh,00Fh,00Fh,05Fh,05Fh,00Fh,00Fh
    db 01Fh,09Ch,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,01Fh,00Fh,00Fh,00Fh,00Fh,00Fh
    db 00Fh,002h,002h,002h,00Fh,00Fh,00Fh,065h,00Fh,099h,00Fh,00Fh,065h,006h,006h,006h
    db 006h,006h,00Fh,065h,00Fh,00Fh,099h,00Fh,05Fh,00Fh,00Fh,00Fh,00Fh,00Fh,065h,00Fh
    db 00Fh,00Fh,000h,040h,040h,000h,00Fh,00Fh,05Fh,00Fh,002h,002h,002h,042h,00Fh,030h
    db 000h,00Fh,00Fh,00Fh,00Fh,067h,00Fh,00Fh,00Fh,00Fh,00Fh,01Fh,00Fh,00Fh,00Fh,002h
    db 002h,002h,002h,042h,042h,002h,002h,002h,002h,00Fh,0CBh,00Fh,056h,006h,046h,006h
    db 006h,006h,0BCh,036h,006h,00Bh,00Fh,00Fh,05Fh,065h,00Fh,00Fh,00Fh,00Fh,00Fh,01Fh
    db 00Fh,00Fh,00Fh,000h,000h,00Fh,0DCh,05Fh,00Fh,002h,002h,002h,002h,012h,002h,002h
    db 00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,099h,00Fh,00Fh,00Fh,042h,002h
    db 002h,002h,002h,012h,002h,002h,012h,002h,002h,00Fh,00Fh,00Fh,036h,006h,0CDh,006h
    db 065h,006h,006h,006h,006h,006h,006h,006h,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,01Fh,00Fh
    db 00Ah,00Fh,00Fh,026h,006h,05Fh,00Fh,01Fh,042h,002h,002h,042h,012h,012h,002h,002h
    db 002h,00Fh,05Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,065h,002h,012h
    db 002h,065h,099h,012h,012h,012h,012h,01Fh,00Fh,00Fh,00Fh,00Fh,026h,056h,026h,006h
    db 006h,002h,006h,099h,006h,046h,067h,006h,046h,006h,00Fh,00Fh,00Fh,0ABh,002h,002h
    db 00Ah,00Fh,099h,00Fh,006h,046h,00Fh,002h,002h,012h,002h,002h,006h,002h,012h,012h
    db 002h,00Fh,00Fh,0CBh,00Fh,00Fh,00Fh,00Fh,01Fh,00Fh,00Fh,067h,00Fh,002h,042h,002h
    db 002h,026h,002h,03Dh,012h,002h,00Fh,00Fh,042h,00Fh,012h,00Fh,00Fh,00Fh,026h,00Ch
    db 006h,046h,006h,006h,006h,065h,026h,006h,006h,00Fh,09Ch,002h,012h,002h,002h,002h
    db 00Ah,00Fh,00Fh,00Fh,006h,006h,006h,0DBh,002h,002h,002h,006h,074h,00Fh,00Fh,002h
    db 00Fh,05Fh,00Fh,00Fh,00Fh,00Fh,067h,00Fh,00Fh,067h,00Fh,00Fh,00Fh,002h,012h,002h
    db 002h,042h,042h,002h,002h,00Bh,00Fh,065h,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh
    db 067h,026h,036h,006h,026h,006h,006h,006h,00Fh,00Fh,012h,042h,002h,002h,002h,002h
    db 00Fh,00Fh,00Fh,020h,020h,00Fh,026h,01Fh,012h,002h,012h,00Fh,026h,006h,002h,002h
    db 012h,00Fh,0CCh,00Fh,065h,006h,006h,056h,00Fh,00Fh,01Fh,00Fh,00Fh,0CBh,012h,002h
    db 042h,002h,012h,065h,042h,00Fh,00Fh,01Fh,0B3h,00Fh,0D7h,01Fh,02Dh,065h,05Fh,00Fh
    db 00Fh,00Fh,00Fh,006h,08Bh,006h,006h,0C7h,002h,002h,002h,042h,002h,002h,042h,002h
    db 00Fh,00Fh,000h,000h,000h,0ADh,00Fh,00Fh,05Fh,012h,002h,002h,042h,002h,002h,002h
    db 01Fh,067h,00Fh,006h,046h,036h,006h,006h,006h,016h,08Bh,00Fh,0C1h,00Fh,00Fh,00Fh
    db 002h,002h,002h,002h,00Fh,00Fh,00Fh,00Fh,00Fh,0CCh,00Fh,00Fh,00Fh,006h,00Fh,006h
    db 00Fh,065h,00Fh,00Fh,006h,006h,00Fh,002h,002h,002h,002h,002h,002h,002h,002h,002h
    db 01Fh,00Fh,000h,000h,020h,030h,00Fh,00Fh,00Fh,00Fh,002h,002h,002h,002h,002h,03Dh
    db 05Fh,006h,016h,002h,006h,056h,099h,046h,065h,046h,026h,006h,042h,00Fh,065h,00Fh
    db 01Fh,0BCh,00Fh,05Fh,00Fh,067h,00Fh,00Fh,099h,05Fh,046h,00Fh,006h,00Fh,0DCh,00Fh
    db 06Bh,00Fh,01Fh,00Fh,00Fh,00Fh,00Fh,012h,012h,002h,002h,0C1h,002h,0ADh,002h,042h
    db 05Fh,00Fh,020h,020h,030h,000h,020h,00Fh,006h,00Fh,00Fh,042h,002h,042h,00Fh,00Fh
    db 006h,006h,026h,006h,006h,006h,006h,006h,006h,056h,006h,006h,006h,0CCh,00Fh,00Fh
    db 00Fh,00Fh,00Fh,00Fh,00Fh,05Fh,006h,00Fh,00Fh,065h,05Fh,00Fh,00Fh,00Fh,00Fh,00Fh
    db 00Fh,00Fh,065h,006h,00Fh,042h,002h,002h,012h,002h,012h,002h,006h,002h,002h,002h
    db 00Fh,06Bh,00Fh,000h,000h,000h,000h,020h,00Fh,006h,006h,01Fh,00Fh,00Fh,00Fh,00Fh
    db 00Fh,00Fh,00Fh,006h,026h,016h,016h,006h,006h,026h,065h,026h,046h,00Fh,099h,065h
    db 00Fh,00Fh,065h,00Fh,00Fh,00Fh,00Fh,08Bh,00Fh,00Fh,00Fh,000h,061h,000h,099h,00Fh
    db 006h,00Fh,00Fh,00Fh,00Fh,002h,002h,012h,012h,002h,002h,002h,07Ch,002h,002h,002h
    db 00Fh,00Fh,0A8h,00Fh,030h,040h,000h,000h,000h,000h,00Fh,00Fh,0ABh,00Fh,0BCh,00Fh
    db 00Fh,040h,000h,00Ch,05Fh,00Fh,065h,046h,006h,006h,006h,006h,01Fh,067h,040h,000h
    db 05Fh,00Fh,05Fh,00Fh,0DCh,00Fh,00Fh,00Fh,020h,00Fh,067h,00Fh,000h,000h,040h,000h
    db 000h,006h,00Fh,00Fh,0BCh,00Fh,065h,042h,002h,002h,042h,002h,099h,002h,012h,002h
    db 00Fh,00Fh,00Fh,00Fh,00Fh,030h,040h,067h,040h,020h,067h,00Fh,00Fh,00Fh,00Fh,00Fh
    db 0B3h,000h,020h,00Fh,05Fh,00Fh,00Fh,00Fh,006h,046h,006h,00Fh,00Fh,000h,000h,000h
    db 00Fh,0CBh,00Fh,00Fh,00Fh,065h,099h,000h,040h,00Fh,000h,00Fh,08Bh,030h,00Fh,000h
    db 099h,00Fh,00Fh,00Fh,00Fh,00Fh,002h,002h,012h,002h,002h,002h,002h,074h,002h,002h
    db 00Fh,00Fh,00Fh,00Fh,099h,030h,040h,000h,000h,000h,000h,05Fh,00Fh,00Fh,07Ch,00Fh
    db 00Fh,000h,000h,002h,05Fh,00Fh,00Fh,00Fh,00Fh,0CCh,05Fh,01Fh,000h,040h,000h,042h
    db 046h,046h,00Fh,065h,099h,020h,000h,000h,000h,00Fh,000h,000h,00Fh,040h,0CBh,00Fh
    db 067h,00Fh,05Fh,099h,00Fh,042h,002h,042h,012h,042h,002h,002h,042h,065h,042h,002h
    db 00Fh,01Fh,00Fh,0CBh,040h,000h,000h,000h,040h,000h,000h,000h,00Fh,00Fh,00Fh,00Fh
    db 0CBh,000h,030h,002h,002h,067h,00Fh,065h,006h,00Fh,002h,000h,000h,040h,002h,00Fh
    db 00Fh,00Fh,06Dh,040h,000h,000h,074h,030h,030h,00Fh,040h,000h,00Fh,067h,00Fh,000h
    db 000h,0CCh,05Fh,036h,065h,002h,002h,002h,00Fh,00Fh,002h,002h,012h,002h,00Fh,042h
    db 00Fh,06Dh,00Fh,030h,040h,040h,040h,000h,000h,020h,020h,000h,099h,00Fh,0BCh,00Fh
    db 020h,000h,000h,03Dh,036h,026h,056h,006h,00Fh,002h,000h,000h,000h,006h,00Fh,05Fh
    db 00Fh,020h,020h,040h,040h,000h,000h,000h,0DBh,00Fh,000h,000h,000h,00Fh,030h,099h
    db 000h,000h,00Fh,05Fh,0DBh,00Fh,067h,01Fh,00Fh,065h,00Fh,002h,012h,002h,00Fh,002h
    db 00Fh,00Fh,000h,000h,020h,000h,012h,002h,002h,000h,040h,000h,040h,00Fh,00Fh,00Fh
    db 000h,000h,020h,006h,006h,065h,00Fh,00Fh,00Fh,002h,000h,040h,006h,00Fh,065h,00Fh
    db 000h,020h,040h,000h,040h,002h,012h,067h,006h,00Fh,067h,000h,000h,00Fh,020h,030h
    db 000h,040h,067h,065h,0DCh,056h,006h,05Fh,00Ch,00Fh,012h,012h,012h,083h,002h,012h
    db 00Fh,05Fh,000h,000h,000h,00Fh,00Fh,065h,00Fh,099h,000h,000h,040h,00Fh,0BCh,00Fh
    db 030h,000h,065h,006h,01Fh,00Fh,00Fh,00Fh,065h,000h,000h,000h,056h,00Fh,00Fh,000h
    db 000h,020h,000h,099h,00Fh,0DBh,099h,065h,00Fh,000h,020h,000h,000h,00Fh,067h,000h
    db 020h,000h,030h,040h,020h,074h,00Fh,05Fh,006h,006h,002h,012h,00Fh,002h,012h,012h
    db 00Fh,05Fh,040h,000h,000h,065h,00Fh,099h,00Fh,05Fh,040h,020h,000h,00Fh,00Fh,00Fh
    db 000h,000h,006h,056h,00Fh,00Fh,00Fh,00Fh,040h,000h,000h,006h,00Fh,01Fh,00Fh,00Fh
    db 01Fh,01Fh,00Fh,0DCh,006h,00Fh,000h,000h,030h,000h,000h,000h,000h,00Fh,000h,000h
    db 065h,020h,000h,000h,000h,000h,030h,000h,030h,05Fh,00Fh,0BCh,00Fh,00Fh,002h,002h
    db 026h,00Fh,030h,000h,000h,00Fh,074h,016h,00Fh,065h,000h,000h,067h,00Fh,07Ch,00Fh
    db 030h,000h,006h,00Fh,00Fh,00Fh,002h,020h,000h,067h,006h,00Fh,065h,00Fh,00Fh,00Fh
    db 00Fh,05Fh,000h,000h,000h,020h,000h,040h,000h,000h,000h,030h,067h,00Fh,040h,000h
    db 000h,099h,000h,000h,030h,000h,000h,0D7h,000h,030h,000h,020h,00Fh,065h,0ADh,00Fh
    db 026h,00Fh,020h,030h,020h,065h,00Fh,067h,00Fh,00Fh,0C1h,00Fh,00Fh,00Fh,00Fh,00Fh
    db 000h,030h,00Fh,00Fh,00Fh,00Fh,000h,000h,030h,006h,00Fh,00Fh,00Fh,00Fh,002h,002h
    db 000h,040h,040h,020h,000h,000h,040h,000h,000h,000h,020h,000h,000h,05Fh,000h,0DBh
    db 000h,000h,020h,000h,000h,000h,020h,000h,000h,040h,030h,020h,00Fh,00Fh,0CBh,01Fh
    db 026h,00Fh,000h,020h,040h,002h,00Fh,065h,00Fh,030h,000h,000h,00Fh,00Fh,00Fh,040h
    db 000h,067h,00Fh,00Fh,00Fh,067h,000h,000h,000h,036h,099h,00Fh,00Fh,002h,042h,030h
    db 020h,020h,000h,000h,000h,067h,065h,00Fh,002h,00Fh,000h,000h,000h,00Fh,000h,040h
    db 020h,006h,006h,099h,00Fh,000h,030h,040h,000h,0B3h,030h,040h,000h,00Ch,00Fh,00Fh
    db 006h,00Fh,099h,000h,040h,040h,099h,002h,067h,000h,000h,020h,067h,00Fh,00Fh,000h
    db 000h,00Fh,00Fh,05Fh,002h,000h,030h,000h,00Ch,00Fh,00Fh,0DBh,012h,002h,012h,000h
    db 000h,000h,0ADh,006h,006h,006h,00Fh,0CCh,065h,00Fh,002h,000h,000h,00Fh,040h,000h
    db 00Fh,06Bh,00Fh,01Fh,002h,065h,099h,05Fh,000h,020h,000h,000h,000h,00Fh,00Fh,002h
    db 01Fh,0BCh,01Fh,040h,000h,000h,000h,000h,000h,000h,000h,00Fh,00Fh,00Fh,01Fh,000h
    db 00Fh,065h,01Fh,00Fh,002h,000h,020h,030h,00Fh,00Fh,05Fh,00Fh,00Fh,002h,002h,000h
    db 000h,002h,065h,00Fh,065h,006h,056h,067h,00Fh,00Fh,006h,016h,00Fh,00Fh,00Fh,099h
    db 065h,01Fh,00Fh,00Ch,006h,00Fh,065h,0CCh,067h,000h,000h,020h,006h,00Fh,012h,067h
    db 05Fh,00Fh,00Fh,00Fh,000h,000h,030h,000h,000h,000h,000h,00Fh,00Fh,00Fh,000h,000h
    db 00Fh,00Fh,00Fh,00Fh,040h,020h,000h,099h,00Fh,00Fh,002h,002h,002h,00Fh,002h,000h
    db 000h,00Fh,006h,0A3h,00Fh,065h,00Fh,0CBh,036h,006h,067h,00Fh,00Fh,061h,01Fh,00Fh
    db 006h,01Fh,006h,002h,00Fh,00Bh,00Fh,00Fh,099h,00Fh,006h,05Fh,0BCh,01Fh,00Fh,00Fh
    db 00Ah,099h,00Fh,00Fh,067h,05Fh,00Fh,00Fh,01Fh,0CBh,00Fh,00Fh,00Fh,00Fh,067h,06Bh
    db 00Fh,00Fh,01Fh,0ABh,06Bh,000h,000h,067h,00Fh,012h,012h,042h,012h,002h,00Fh,01Fh
    db 00Fh,067h,00Fh,01Fh,074h,05Fh,099h,00Fh,00Fh,0DCh,046h,00Fh,065h,00Fh,00Fh,002h
    db 00Fh,00Fh,00Fh,00Fh,065h,00Fh,006h,00Fh,006h,00Fh,00Fh,067h,040h,01Fh,065h,00Fh

; Area map - 64x61 byte map
; +------+-------------+--------------------------------------------------+
; | Bits | Description | Description                                      |
; +------+-------------+--------------------------------------------------+
; | 0-5  | Area        | Relates to text tokens 0 - 63, see area table    |
; | 6    | Domain      | How a location is described                      |
; |      |             | (0=keep in domain of the moon, 1=Moon Keep)      |
; | 7    | Special     | Only used during the game for processing.        |
; |      |             | Set bit if an army of character is at a location |
; |      |             | This does not require pre-setting.               |
; +------+-------------+--------------------------------------------------+
AreaMap:
    db 000h,000h,042h,002h,042h,002h,002h,002h,002h,007h,007h,007h,007h,007h,007h,007h
    db 007h,007h,007h,007h,047h,007h,007h,007h,000h,000h,047h,007h,007h,007h,008h,007h
    db 02Ch,02Ch,02Ch,02Ch,02Ch,02Ch,000h,000h,02Ch,02Ch,02Ch,02Ch,02Ch,06Ch,02Ch,02Ch
    db 02Ch,000h,02Dh,06Dh,02Dh,02Dh,02Dh,06Dh,02Dh,02Dh,000h,000h,000h,02Dh,02Dh,02Dh
    db 000h,002h,002h,002h,002h,002h,002h,002h,002h,002h,007h,007h,007h,047h,007h,001h
    db 001h,007h,007h,007h,007h,007h,007h,000h,000h,000h,000h,00Bh,00Bh,007h,007h,007h
    db 02Ch,02Ch,06Ch,02Ch,02Ch,02Ch,02Ch,02Ch,02Ch,02Ch,02Ch,02Dh,02Dh,02Dh,02Eh,02Dh
    db 02Dh,02Dh,02Dh,02Dh,02Eh,02Dh,02Dh,02Dh,02Dh,02Dh,02Dh,000h,000h,02Dh,02Dh,06Dh
    db 002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,007h,007h,007h,001h,001h
    db 001h,001h,007h,007h,047h,007h,000h,000h,00Bh,00Bh,00Bh,00Bh,00Bh,00Bh,00Bh,00Bh
    db 02Ch,02Ch,02Ch,02Ch,02Ch,02Ch,02Ch,02Ch,02Ch,02Dh,02Dh,02Dh,02Dh,02Dh,02Dh,02Dh
    db 02Dh,02Dh,02Dh,06Dh,02Dh,02Dh,02Eh,02Dh,02Dh,02Dh,02Dh,000h,000h,06Dh,02Dh,000h
    db 001h,001h,002h,002h,002h,002h,002h,002h,002h,002h,001h,001h,001h,007h,001h,001h
    db 001h,001h,009h,007h,007h,00Bh,00Bh,00Bh,00Bh,00Bh,00Bh,00Bh,00Bh,04Bh,00Bh,00Bh
    db 02Ch,02Ch,02Ch,02Ch,02Ch,06Ch,02Ch,02Ch,02Dh,02Dh,02Dh,02Dh,02Dh,02Dh,02Dh,02Dh
    db 02Dh,02Dh,02Dh,02Dh,02Dh,02Dh,02Dh,02Dh,02Dh,02Dh,02Dh,02Dh,000h,02Dh,000h,000h
    db 001h,001h,001h,002h,001h,001h,002h,002h,002h,002h,001h,001h,001h,007h,007h,001h
    db 001h,007h,007h,00Dh,00Dh,00Bh,00Bh,00Bh,00Dh,00Ch,00Ch,00Ch,04Dh,00Bh,00Bh,00Bh
    db 00Bh,06Ch,02Ch,02Ch,02Ch,02Ch,02Ch,02Ch,02Ch,02Ch,02Dh,06Dh,02Dh,02Dh,02Dh,02Dh
    db 02Dh,02Eh,02Dh,02Dh,02Dh,02Dh,02Dh,02Dh,02Dh,02Dh,02Dh,02Dh,02Fh,000h,000h,000h
    db 001h,001h,001h,001h,001h,001h,001h,002h,001h,001h,001h,001h,001h,007h,007h,007h
    db 047h,007h,007h,00Ah,00Ah,00Dh,00Eh,00Ch,00Ch,00Ch,00Ch,00Ch,00Dh,00Dh,04Dh,00Bh
    db 00Bh,00Bh,00Bh,00Bh,00Bh,00Bh,02Ch,02Ch,02Ch,06Ch,02Ch,02Dh,02Dh,02Dh,02Dh,02Dh
    db 02Dh,02Dh,02Dh,02Dh,02Dh,02Dh,02Dh,02Dh,02Dh,02Dh,02Dh,02Dh,02Dh,02Dh,000h,000h
    db 001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,007h,007h
    db 007h,007h,007h,00Ah,00Ah,00Ah,04Dh,04Dh,04Dh,00Dh,00Dh,00Dh,00Dh,00Dh,00Dh,00Dh
    db 00Bh,00Bh,00Bh,00Bh,00Bh,00Bh,00Bh,00Bh,02Ch,02Ch,02Ch,02Ch,02Ch,02Dh,02Dh,02Dh
    db 02Dh,02Dh,02Dh,030h,02Dh,02Dh,02Dh,030h,02Dh,02Dh,02Dh,02Dh,02Dh,02Dh,02Dh,000h
    db 003h,043h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h
    db 007h,007h,007h,007h,04Ah,00Ah,00Ah,04Dh,04Dh,04Dh,00Dh,04Dh,04Dh,00Fh,00Dh,00Dh
    db 00Dh,00Dh,00Dh,00Dh,00Dh,031h,031h,00Bh,00Bh,071h,031h,02Ch,02Ch,02Ch,02Ch,02Ch
    db 02Dh,02Dh,02Dh,02Dh,02Dh,02Dh,02Dh,030h,030h,030h,02Dh,030h,02Dh,02Fh,02Fh,02Dh
    db 003h,003h,001h,001h,041h,001h,001h,001h,001h,001h,001h,041h,041h,001h,001h,001h
    db 001h,007h,007h,007h,007h,00Ah,00Ah,00Ah,00Ah,00Ah,04Dh,04Dh,00Dh,00Dh,010h,010h
    db 010h,010h,010h,010h,010h,010h,031h,031h,071h,031h,031h,031h,031h,032h,059h,019h
    db 059h,019h,030h,019h,019h,059h,030h,030h,030h,02Fh,030h,030h,030h,030h,02Dh,02Dh
    db 003h,003h,043h,043h,043h,043h,043h,001h,001h,001h,041h,041h,001h,001h,041h,001h
    db 001h,007h,007h,007h,007h,007h,00Ah,00Ah,00Ah,00Ah,00Ah,00Ah,04Dh,00Dh,010h,010h
    db 010h,010h,010h,010h,010h,010h,010h,071h,031h,031h,031h,031h,032h,032h,032h,019h
    db 019h,019h,019h,019h,059h,019h,019h,030h,030h,030h,030h,070h,030h,030h,06Dh,02Dh
    db 003h,003h,003h,003h,003h,003h,003h,003h,001h,001h,001h,001h,001h,041h,041h,001h
    db 001h,005h,047h,007h,007h,007h,011h,04Ah,00Ah,00Ah,00Ah,00Ah,00Ah,00Dh,010h,010h
    db 010h,010h,010h,010h,010h,010h,010h,010h,071h,031h,031h,032h,032h,032h,032h,032h
    db 019h,059h,019h,059h,019h,019h,032h,019h,030h,030h,030h,030h,030h,059h,019h,019h
    db 003h,003h,043h,043h,043h,043h,043h,003h,001h,001h,001h,001h,001h,041h,001h,001h
    db 001h,005h,005h,005h,007h,047h,011h,011h,011h,04Ah,00Ah,00Ah,00Ah,00Dh,010h,010h
    db 010h,010h,010h,010h,010h,010h,010h,010h,010h,010h,031h,032h,032h,032h,032h,032h
    db 032h,032h,019h,019h,032h,019h,059h,019h,030h,030h,030h,030h,019h,059h,019h,019h
    db 003h,003h,003h,003h,004h,004h,003h,001h,001h,001h,001h,001h,001h,001h,001h,001h
    db 005h,005h,005h,005h,005h,006h,006h,011h,011h,00Ah,00Ah,00Ah,00Ah,011h,010h,010h
    db 011h,011h,011h,010h,051h,010h,010h,010h,010h,032h,032h,032h,032h,032h,032h,032h
    db 032h,032h,032h,019h,019h,019h,019h,019h,030h,030h,030h,019h,019h,019h,030h,019h
    db 003h,003h,003h,004h,004h,004h,004h,004h,001h,001h,001h,001h,001h,001h,005h,005h
    db 045h,005h,005h,006h,006h,006h,006h,006h,006h,011h,00Ah,00Ah,011h,011h,011h,011h
    db 011h,011h,051h,011h,011h,011h,051h,011h,032h,032h,032h,019h,032h,032h,032h,032h
    db 032h,032h,032h,019h,019h,019h,019h,059h,059h,019h,019h,019h,019h,019h,019h,019h
    db 003h,003h,003h,004h,004h,004h,044h,004h,004h,005h,005h,005h,005h,005h,045h,005h
    db 005h,005h,006h,006h,006h,006h,006h,046h,011h,011h,011h,011h,011h,011h,011h,011h
    db 011h,011h,032h,032h,032h,032h,032h,032h,032h,032h,032h,032h,032h,032h,032h,019h
    db 059h,032h,032h,019h,019h,019h,019h,019h,019h,019h,019h,019h,059h,059h,019h,019h
    db 013h,013h,004h,044h,004h,004h,004h,004h,004h,005h,045h,005h,045h,005h,005h,005h
    db 005h,006h,006h,006h,046h,011h,011h,011h,011h,011h,011h,011h,011h,011h,011h,011h
    db 011h,011h,032h,032h,032h,072h,032h,032h,032h,032h,032h,032h,072h,032h,032h,059h
    db 019h,019h,019h,019h,032h,019h,019h,034h,019h,033h,019h,019h,019h,019h,019h,033h
    db 013h,013h,004h,004h,004h,012h,004h,044h,004h,004h,005h,005h,005h,005h,045h,005h
    db 006h,006h,006h,011h,011h,051h,011h,011h,011h,003h,011h,051h,011h,011h,011h,011h
    db 011h,011h,051h,032h,032h,032h,032h,032h,032h,032h,032h,032h,032h,032h,032h,032h
    db 019h,059h,019h,019h,059h,059h,019h,019h,019h,019h,059h,059h,034h,034h,034h,019h
    db 012h,013h,004h,004h,004h,004h,004h,004h,004h,004h,005h,005h,005h,005h,005h,006h
    db 006h,006h,006h,051h,011h,011h,011h,011h,011h,011h,011h,011h,011h,011h,011h,011h
    db 011h,011h,011h,032h,032h,032h,032h,032h,032h,032h,032h,032h,032h,032h,032h,032h
    db 059h,019h,019h,019h,019h,059h,059h,019h,033h,019h,019h,034h,034h,034h,034h,019h
    db 013h,013h,004h,004h,004h,004h,004h,004h,004h,004h,004h,005h,005h,005h,005h,005h
    db 006h,006h,006h,011h,011h,011h,051h,011h,011h,011h,011h,011h,011h,011h,011h,011h
    db 011h,051h,011h,032h,032h,032h,032h,032h,032h,032h,032h,032h,032h,032h,032h,032h
    db 032h,019h,059h,059h,059h,019h,059h,059h,034h,034h,034h,033h,034h,034h,034h,034h
    db 013h,012h,012h,004h,004h,013h,013h,004h,004h,005h,005h,005h,005h,005h,005h,006h
    db 006h,006h,006h,011h,011h,011h,011h,011h,011h,011h,011h,011h,011h,010h,011h,011h
    db 051h,011h,051h,011h,011h,011h,032h,032h,032h,032h,032h,032h,059h,059h,032h,032h
    db 032h,019h,019h,019h,019h,019h,019h,019h,019h,034h,034h,034h,034h,034h,034h,034h
    db 013h,012h,012h,012h,004h,013h,013h,013h,013h,013h,005h,005h,014h,014h,046h,006h
    db 006h,006h,006h,011h,011h,011h,011h,011h,011h,011h,011h,011h,011h,011h,011h,011h
    db 011h,051h,011h,051h,011h,051h,032h,032h,032h,032h,032h,011h,011h,059h,019h,019h
    db 019h,059h,019h,019h,019h,019h,019h,019h,034h,034h,034h,034h,034h,034h,034h,034h
    db 013h,053h,012h,012h,012h,013h,013h,053h,013h,013h,014h,014h,014h,014h,014h,014h
    db 006h,006h,006h,006h,011h,011h,011h,011h,011h,011h,011h,011h,011h,011h,011h,011h
    db 011h,011h,051h,011h,051h,011h,011h,032h,032h,032h,051h,011h,011h,011h,011h,059h
    db 019h,019h,019h,019h,019h,019h,019h,034h,034h,034h,034h,034h,034h,034h,034h,034h
    db 013h,013h,012h,012h,012h,013h,013h,013h,013h,014h,014h,014h,014h,014h,014h,014h
    db 014h,006h,006h,006h,011h,011h,011h,011h,011h,011h,011h,011h,011h,011h,011h,011h
    db 051h,011h,011h,051h,011h,011h,011h,011h,011h,011h,011h,011h,011h,011h,059h,019h
    db 019h,019h,019h,019h,019h,036h,03Fh,034h,034h,034h,034h,034h,034h,019h,034h,034h
    db 013h,013h,004h,012h,012h,013h,013h,013h,013h,014h,014h,014h,017h,014h,014h,014h
    db 014h,014h,006h,015h,006h,011h,011h,011h,011h,011h,011h,011h,011h,011h,011h,011h
    db 011h,011h,011h,011h,051h,011h,011h,051h,011h,011h,011h,051h,019h,019h,019h,019h
    db 019h,019h,019h,036h,036h,036h,036h,036h,034h,034h,034h,034h,034h,034h,037h,077h
    db 013h,013h,012h,012h,053h,013h,013h,013h,013h,014h,014h,014h,017h,014h,014h,014h
    db 014h,006h,006h,006h,006h,015h,015h,015h,015h,015h,015h,015h,011h,011h,011h,011h
    db 011h,011h,051h,011h,051h,011h,011h,011h,011h,051h,019h,019h,019h,019h,019h,019h
    db 036h,036h,036h,036h,036h,036h,03Fh,036h,076h,034h,034h,034h,077h,037h,077h,037h
    db 013h,053h,012h,012h,012h,013h,013h,018h,013h,013h,014h,014h,014h,014h,014h,014h
    db 006h,006h,006h,046h,015h,015h,015h,015h,015h,015h,015h,015h,015h,015h,011h,011h
    db 051h,015h,015h,011h,051h,051h,011h,011h,051h,019h,019h,019h,019h,019h,036h,036h
    db 036h,036h,036h,076h,036h,036h,036h,076h,036h,036h,037h,037h,037h,037h,037h,037h
    db 013h,012h,012h,012h,013h,013h,053h,018h,018h,013h,013h,014h,014h,014h,014h,046h
    db 017h,015h,015h,015h,015h,015h,015h,015h,015h,015h,015h,015h,015h,015h,015h,015h
    db 015h,015h,015h,011h,011h,011h,011h,019h,019h,019h,019h,019h,038h,036h,037h,037h
    db 037h,037h,037h,037h,036h,036h,076h,036h,076h,036h,037h,037h,037h,037h,077h,034h
    db 013h,012h,012h,012h,013h,013h,018h,018h,018h,018h,013h,014h,014h,014h,014h,014h
    db 015h,016h,015h,015h,015h,015h,056h,016h,015h,016h,015h,015h,015h,015h,015h,015h
    db 015h,015h,056h,016h,016h,011h,019h,019h,019h,019h,019h,038h,078h,037h,037h,037h
    db 037h,037h,037h,037h,037h,037h,037h,037h,037h,037h,077h,037h,037h,037h,034h,034h
    db 013h,013h,012h,012h,013h,013h,018h,018h,018h,018h,013h,014h,014h,014h,014h,056h
    db 016h,016h,016h,016h,016h,056h,016h,016h,016h,016h,016h,016h,015h,015h,015h,016h
    db 016h,016h,016h,016h,019h,019h,019h,019h,019h,019h,078h,038h,038h,037h,037h,037h
    db 037h,077h,037h,037h,037h,037h,037h,037h,037h,037h,077h,037h,077h,037h,037h,034h
    db 013h,053h,053h,053h,013h,013h,018h,018h,018h,018h,013h,014h,014h,014h,014h,016h
    db 016h,016h,014h,014h,016h,016h,016h,016h,015h,016h,016h,016h,016h,016h,056h,016h
    db 016h,016h,019h,019h,019h,019h,019h,019h,078h,038h,038h,038h,037h,037h,037h,037h
    db 037h,037h,037h,037h,037h,037h,037h,037h,037h,037h,037h,037h,037h,037h,037h,039h
    db 013h,013h,013h,013h,013h,013h,018h,013h,018h,018h,013h,013h,014h,014h,014h,056h
    db 016h,014h,014h,014h,014h,014h,056h,016h,016h,056h,019h,019h,019h,019h,019h,019h
    db 019h,019h,019h,019h,019h,019h,019h,038h,038h,078h,038h,037h,037h,037h,037h,037h
    db 037h,037h,037h,037h,037h,037h,037h,037h,037h,037h,037h,037h,037h,03Bh,037h,037h
    db 013h,013h,013h,018h,013h,013h,018h,018h,018h,018h,013h,013h,014h,014h,014h,014h
    db 014h,014h,014h,014h,014h,014h,016h,016h,016h,019h,019h,019h,019h,019h,019h,019h
    db 019h,019h,019h,019h,019h,019h,078h,038h,038h,038h,038h,078h,037h,037h,037h,037h
    db 037h,037h,037h,037h,037h,037h,037h,079h,039h,039h,079h,039h,039h,039h,03Ah,079h
    db 013h,013h,013h,018h,018h,013h,018h,018h,018h,018h,013h,013h,013h,014h,014h,014h
    db 014h,014h,014h,014h,014h,056h,016h,056h,019h,019h,019h,019h,019h,019h,019h,019h
    db 019h,019h,019h,019h,078h,038h,038h,038h,038h,038h,038h,038h,038h,038h,038h,038h
    db 038h,038h,078h,039h,039h,039h,039h,039h,039h,039h,039h,079h,079h,039h,079h,039h
    db 013h,013h,053h,018h,018h,013h,018h,018h,018h,018h,018h,013h,013h,014h,014h,014h
    db 014h,014h,014h,01Bh,01Bh,01Bh,01Bh,01Bh,019h,019h,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh
    db 01Bh,01Bh,038h,038h,038h,038h,038h,01Ch,038h,038h,038h,078h,038h,038h,038h,078h
    db 038h,03Bh,039h,039h,079h,039h,039h,079h,039h,079h,039h,039h,039h,039h,079h,039h
    db 018h,018h,018h,018h,018h,013h,013h,018h,018h,018h,018h,018h,018h,018h,018h,014h
    db 01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,05Bh,01Bh
    db 01Bh,01Bh,038h,078h,078h,038h,038h,038h,038h,038h,038h,038h,03Bh,03Bh,038h,01Ch
    db 038h,038h,039h,039h,039h,039h,039h,039h,039h,039h,039h,03Ah,039h,039h,039h,039h
    db 018h,018h,018h,018h,018h,018h,013h,018h,018h,018h,018h,018h,018h,018h,01Bh,01Bh
    db 01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh
    db 01Bh,01Ch,01Ch,01Ch,038h,038h,038h,078h,038h,078h,038h,038h,07Bh,03Bh,03Bh,03Bh
    db 03Bh,03Bh,039h,079h,039h,039h,03Ah,039h,039h,039h,039h,039h,039h,039h,079h,039h
    db 018h,018h,018h,018h,018h,018h,018h,018h,018h,018h,01Ah,01Ah,01Ah,01Ah,01Bh,01Ah
    db 01Ah,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Ch
    db 01Ch,01Ch,01Ch,01Ch,01Ch,01Ch,01Ch,01Ch,01Ch,038h,078h,038h,03Bh,03Bh,03Bh,03Bh
    db 03Bh,03Bh,07Bh,03Bh,03Bh,079h,039h,039h,039h,039h,039h,039h,039h,039h,039h,039h
    db 018h,018h,018h,018h,018h,018h,018h,018h,018h,01Ah,01Ah,01Ah,01Ah,01Ah,01Ah,01Ah
    db 01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Ch,01Ch
    db 01Ch,01Ch,01Ch,01Ch,01Ch,01Ch,01Ch,01Ch,01Ch,038h,038h,038h,03Bh,03Bh,03Bh,03Bh
    db 03Bh,03Bh,03Bh,03Bh,03Bh,03Bh,03Bh,03Bh,039h,039h,039h,039h,039h,039h,039h,039h
    db 000h,018h,018h,018h,018h,018h,018h,018h,01Ah,01Ah,01Ah,01Ah,01Ah,01Ah,01Ah,01Ah
    db 01Ah,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,05Ch,01Ch,01Ch
    db 01Ch,01Ch,01Ch,01Ch,01Ch,01Ch,01Ch,03Dh,03Dh,03Dh,03Dh,03Dh,03Bh,03Bh,03Bh,03Bh
    db 03Bh,07Bh,03Bh,03Bh,03Bh,03Bh,03Bh,03Bh,03Bh,03Bh,039h,039h,039h,079h,03Ch,03Ch
    db 000h,018h,018h,018h,018h,018h,018h,01Ah,01Ah,01Ah,01Ah,01Ah,01Ah,01Ah,01Ah,01Ah
    db 01Ah,01Bh,01Bh,05Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,05Bh,01Bh,01Ch,01Ch,01Ch
    db 01Ch,01Ch,01Ch,01Ch,01Ch,01Ch,03Dh,03Dh,01Ch,03Dh,01Ch,03Dh,03Dh,03Dh,03Bh,07Bh
    db 03Bh,03Bh,03Bh,03Bh,03Bh,07Bh,07Bh,07Bh,07Bh,03Bh,07Bh,03Ch,03Ch,03Ch,03Ch,03Ch
    db 000h,018h,018h,018h,018h,018h,018h,058h,01Ah,01Ah,01Ah,01Ah,020h,020h,020h,01Ah
    db 01Bh,01Bh,01Bh,01Bh,01Bh,01Bh,05Bh,01Bh,01Bh,05Bh,021h,021h,021h,01Ch,01Ch,01Ch
    db 01Ch,01Ch,01Ch,01Ch,01Ch,07Dh,03Dh,07Dh,03Dh,03Dh,03Dh,03Dh,03Dh,03Dh,03Dh,03Dh
    db 07Dh,03Bh,03Bh,03Bh,03Bh,03Bh,03Bh,03Bh,03Bh,03Bh,03Ch,03Ch,03Ch,03Ch,03Ch,03Ch
    db 018h,018h,018h,01Dh,01Dh,018h,018h,018h,01Ah,01Ah,01Ah,020h,01Ah,01Ah,01Ah,01Ah
    db 01Ah,01Bh,020h,01Bh,05Fh,01Fh,01Fh,01Fh,021h,021h,021h,021h,021h,01Ch,01Ch,01Ch
    db 01Ch,01Ch,01Ch,05Ch,01Ch,03Dh,03Dh,03Dh,03Dh,03Dh,07Dh,03Dh,07Dh,07Dh,03Dh,03Dh
    db 03Dh,03Dh,03Dh,03Bh,07Bh,03Bh,03Bh,03Ch,03Ch,03Ch,03Ch,03Ch,03Ch,03Ch,03Ch,03Ch
    db 018h,018h,01Dh,01Dh,01Dh,01Dh,018h,018h,018h,01Ah,01Ah,01Ah,01Ah,01Ah,01Ah,01Ah
    db 01Bh,020h,01Bh,01Fh,01Fh,01Fh,01Fh,01Fh,01Fh,01Fh,01Fh,021h,022h,021h,021h,021h
    db 01Ch,01Ch,01Ch,01Ch,03Dh,03Dh,03Dh,03Dh,03Dh,03Dh,03Dh,03Dh,03Dh,03Dh,03Dh,03Dh
    db 03Dh,07Dh,03Dh,03Dh,03Bh,03Bh,03Eh,03Ch,03Ch,03Ch,03Ch,03Ch,03Ch,03Ch,03Ch,03Ch
    db 01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,018h,018h,018h,018h,01Ah,01Ah,01Ah,01Ah,01Ah,01Ah
    db 01Bh,01Fh,01Fh,05Fh,01Fh,01Fh,01Fh,01Fh,01Fh,01Fh,01Fh,01Fh,061h,021h,061h,021h
    db 021h,061h,03Dh,03Dh,03Dh,03Dh,03Dh,03Dh,03Dh,03Dh,03Dh,03Dh,03Dh,03Dh,07Dh,03Dh
    db 07Dh,03Dh,03Dh,03Dh,03Eh,03Eh,03Eh,03Ch,03Ch,03Ch,03Ch,03Ch,03Ch,03Ch,03Ch,03Ch
    db 01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,018h,018h,018h,018h,01Ah,01Ah,01Ah,01Eh,01Eh
    db 01Fh,01Fh,01Fh,01Fh,01Fh,01Fh,01Fh,01Fh,01Fh,01Fh,01Fh,01Fh,01Fh,022h,021h,021h
    db 021h,021h,03Dh,03Dh,03Dh,03Dh,03Dh,03Dh,03Dh,07Dh,03Dh,03Dh,03Dh,03Dh,03Dh,03Dh
    db 03Dh,03Dh,07Dh,03Eh,03Eh,03Ch,03Ch,03Ch,03Ch,03Ch,03Ch,03Ch,03Ch,03Ch,03Ch,03Ch
    db 01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,018h,018h,018h,01Eh,01Eh,01Eh,01Eh,01Eh
    db 01Eh,01Eh,01Eh,01Fh,01Fh,01Fh,01Fh,01Fh,01Fh,01Fh,05Fh,01Fh,01Fh,021h,022h,061h
    db 021h,021h,07Dh,03Dh,03Dh,03Dh,03Dh,07Dh,03Dh,03Dh,03Dh,03Dh,03Dh,03Dh,07Dh,03Dh
    db 03Eh,03Eh,03Eh,03Eh,03Eh,03Ch,03Ch,03Ch,03Ch,03Ch,03Ch,03Ch,03Ch,03Ch,03Ch,03Ch
    db 01Dh,01Dh,05Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Eh,01Eh,05Eh,01Eh,01Fh,01Eh
    db 01Eh,024h,024h,023h,025h,025h,05Fh,01Fh,01Fh,01Fh,01Fh,01Fh,021h,01Fh,023h,023h
    db 021h,021h,021h,03Dh,07Dh,03Dh,03Dh,03Dh,029h,03Dh,07Dh,03Dh,03Dh,03Dh,03Dh,03Dh
    db 03Dh,03Eh,03Eh,03Eh,07Eh,03Eh,07Eh,03Ch,03Ch,03Ch,03Ch,03Ch,03Ch,03Ch,03Ch,03Ch
    db 01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Eh,01Eh,01Eh,01Eh,01Eh,01Eh
    db 01Eh,024h,024h,025h,025h,025h,025h,025h,01Fh,01Fh,01Fh,025h,025h,023h,023h,023h
    db 028h,068h,028h,028h,028h,068h,068h,029h,029h,029h,02Bh,02Bh,06Bh,03Dh,02Bh,03Dh
    db 07Eh,03Eh,03Eh,03Eh,03Eh,03Eh,03Ch,03Ch,03Ch,03Ch,03Ch,03Ch,03Ch,03Fh,03Ch,03Ch
    db 01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Eh,01Eh,01Eh,05Eh,01Eh
    db 01Eh,024h,024h,024h,025h,025h,025h,025h,025h,024h,025h,025h,023h,023h,023h,023h
    db 028h,028h,028h,068h,068h,029h,029h,029h,029h,029h,02Bh,02Bh,02Bh,03Dh,06Bh,02Bh
    db 07Eh,03Eh,03Eh,03Eh,03Eh,03Ch,03Ch,03Ch,03Ch,03Ch,03Ch,03Ch,03Ch,03Ch,03Ch,03Ch
    db 01Dh,01Dh,01Dh,05Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Eh,01Eh,01Eh,01Eh
    db 05Eh,024h,024h,024h,024h,025h,025h,025h,025h,025h,025h,023h,023h,023h,023h,028h
    db 028h,028h,068h,029h,029h,029h,029h,029h,029h,029h,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh
    db 02Bh,07Eh,03Eh,03Eh,07Eh,03Ch,03Ch,03Ch,03Eh,03Eh,03Ch,03Ch,03Ch,03Ch,03Ch,03Ch
    db 01Dh,05Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Eh,01Eh,05Eh,01Eh
    db 024h,024h,024h,025h,025h,025h,025h,025h,025h,025h,023h,023h,023h,028h,028h,028h
    db 028h,029h,029h,029h,029h,029h,029h,029h,069h,029h,02Bh,02Bh,02Bh,02Bh,02Bh,06Bh
    db 02Bh,02Bh,03Eh,03Eh,07Eh,03Eh,03Eh,03Eh,03Eh,03Eh,03Eh,03Ch,03Ch,03Ch,03Ch,03Ch
    db 01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Eh,01Eh,01Eh
    db 024h,024h,024h,025h,025h,065h,025h,025h,025h,025h,023h,023h,028h,028h,023h,028h
    db 029h,029h,029h,029h,029h,029h,029h,029h,029h,029h,069h,02Bh,02Bh,02Bh,02Bh,02Bh
    db 02Bh,02Bh,07Eh,07Eh,07Eh,03Eh,03Eh,03Eh,07Eh,03Eh,03Ch,03Ch,03Ch,03Eh,03Ch,03Ch
    db 01Dh,01Dh,01Dh,01Dh,01Dh,026h,026h,066h,026h,026h,01Dh,01Dh,01Dh,01Eh,01Eh,01Eh
    db 024h,024h,024h,025h,025h,025h,025h,025h,065h,023h,023h,023h,028h,028h,028h,029h
    db 029h,029h,029h,069h,029h,069h,069h,069h,029h,02Bh,02Bh,02Bh,02Bh,02Bh,06Bh,02Bh
    db 02Bh,02Bh,02Bh,02Bh,02Bh,03Eh,03Eh,03Eh,03Eh,03Eh,03Ch,03Ch,03Eh,03Ch,03Ch,03Ch
    db 01Dh,01Dh,01Dh,01Dh,01Dh,066h,026h,027h,026h,026h,01Dh,01Dh,01Dh,01Eh,01Eh,01Eh
    db 024h,024h,025h,025h,025h,025h,025h,025h,023h,023h,023h,028h,028h,028h,028h,028h
    db 028h,028h,029h,069h,029h,029h,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh
    db 06Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,03Eh,03Eh,07Eh,03Eh,03Eh,03Ch,03Ch
    db 01Dh,01Dh,01Dh,01Dh,01Dh,026h,027h,026h,026h,066h,01Dh,01Dh,05Eh,01Eh,05Eh,01Eh
    db 024h,024h,025h,025h,025h,025h,025h,023h,023h,023h,028h,028h,028h,028h,028h,028h
    db 028h,028h,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,06Bh,02Bh,02Bh,02Bh
    db 02Bh,06Bh,02Bh,02Bh,02Bh,02Bh,02Bh,06Bh,02Bh,02Bh,02Bh,02Bh,03Eh,07Eh,03Eh,03Eh
    db 01Dh,01Dh,01Dh,01Dh,01Dh,066h,026h,026h,026h,026h,01Eh,01Eh,01Eh,01Eh,01Eh,01Eh
    db 024h,024h,025h,025h,025h,025h,023h,023h,023h,028h,028h,028h,028h,028h,02Ah,02Ah
    db 02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,06Bh
    db 02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,03Eh,03Eh,07Eh,03Eh
    db 01Dh,01Dh,01Dh,01Dh,01Dh,026h,026h,066h,026h,01Dh,01Dh,01Dh,01Eh,01Eh,01Eh,024h
    db 024h,024h,025h,025h,025h,065h,023h,023h,023h,028h,023h,028h,028h,02Ah,02Ah,02Bh
    db 02Bh,02Bh,02Bh,02Bh,02Bh,06Bh,06Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh
    db 02Bh,02Bh,02Bh,06Bh,02Bh,02Bh,02Bh,02Bh,02Bh,06Bh,02Bh,02Bh,02Bh,07Eh,03Eh,03Eh
    db 01Dh,01Dh,05Dh,01Dh,01Dh,01Dh,066h,026h,066h,01Dh,01Dh,01Dh,05Eh,01Eh,01Eh,024h
    db 024h,025h,025h,025h,025h,023h,023h,023h,02Ah,028h,028h,028h,02Ah,02Ah,02Ah,02Bh
    db 02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,06Bh,06Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh
    db 02Bh,06Bh,02Bh,02Bh,02Bh,06Bh,06Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh
    db 01Dh,05Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Eh,01Eh,01Eh,01Eh,024h
    db 025h,065h,025h,025h,025h,023h,023h,023h,028h,028h,028h,028h,028h,02Ah,02Ah,02Bh
    db 02Bh,02Bh,06Bh,02Bh,06Bh,02Bh,02Bh,06Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,06Bh
    db 06Bh,02Bh,02Bh,06Bh,02Bh,02Bh,06Bh,06Bh,06Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,06Bh
    db 01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Dh,01Eh,01Eh,01Eh,024h,024h
    db 025h,025h,025h,025h,023h,023h,023h,028h,028h,028h,02Ah,02Ah,02Ah,028h,02Ah,02Bh
    db 02Bh,02Bh,02Bh,06Bh,02Bh,06Bh,02Bh,06Bh,02Bh,02Bh,06Bh,02Bh,02Bh,035h,02Bh,02Bh
    db 02Bh,02Bh,02Bh,02Bh,02Bh,06Bh,02Bh,02Bh,06Bh,02Bh,02Bh,02Bh,06Bh,02Bh,02Bh,02Bh
    db 000h,05Dh,01Dh,01Dh,05Dh,01Eh,01Eh,01Eh,01Eh,05Eh,01Eh,01Eh,01Eh,01Eh,065h,024h
    db 025h,025h,025h,025h,023h,023h,023h,028h,028h,02Ah,02Ah,02Ah,02Ah,02Ah,02Bh,02Bh
    db 02Bh,02Ah,02Bh,02Bh,02Bh,02Bh,06Bh,02Bh,02Bh,06Bh,02Bh,02Bh,06Bh,02Bh,02Bh,02Bh
    db 02Bh,02Bh,02Bh,02Bh,06Bh,02Bh,02Bh,02Bh,02Bh,02Bh,02Bh,06Bh,02Bh,02Bh,06Bh,02Bh

; Character lookup table, each entry consisting of 6-bytes.
CharDataTable:
    dw 0407h,CharConstructTable,CharConstructAttrs
    dw 0407h,LD16C,LD2B0
    dw 0407h,LD188,LD2CC
    dw 0407h,LD1A4,LD2E8
    dw 0407h,LD1C0,LD304
    dw 0403h,LD1DC,LD320
    dw 0406h,LD1E8,LD32C
    dw 0407h,LD200,LD344
    dw 0305h,LD21C,LD360
    dw 0305h,LD22B,LD36F
    dw 0305h,LD23A,LD37E
    dw 0406h,LD249,LD38D
    dw 0304h,LD261,LD3A5
    dw 0406h,LD26D,LD3B1
    dw 0305h,LD285,LD3C9
    dw 0407h,LD16C,LD3D8
    dw 0305h,LD21C,LD3F4

; Character Construction (LD150)
CharConstructTable:
    ; db[28]
    db 000h,001h,002h,000h,003h,004h,005h,006h,007h,008h,009h,00Ah,00Bh,00Ch
    db 00Dh,00Eh,00Fh,010h,011h,012h,000h,013h,014h,015h,016h,017h,018h,019h
LD16C:
    ; db[28]
    db 000h,01Ah,01Bh,01Ch,003h,01Dh,01Eh,006h,007h,008h,009h,00Ah,00Bh,00Ch
    db 00Dh,00Eh,00Fh,010h,011h,012h,000h,013h,014h,015h,016h,017h,018h,019h
LD188:
    ; db[28]
    db 000h,01Fh,020h,021h,003h,01Dh,022h,006h,007h,008h,009h,00Ah,00Bh,00Ch
    db 00Dh,00Eh,00Fh,010h,011h,012h,000h,013h,014h,015h,016h,017h,018h,019h
LD1A4:
    ; db[28]
    db 000h,023h,024h,025h,003h,004h,026h,027h,007h,008h,028h,029h,00Bh,00Ch
    db 02Ah,02Bh,00Fh,010h,011h,012h,000h,013h,014h,015h,016h,017h,018h,019h
LD1C0:
    ; db[28]
    db 000h,000h,02Ch,02Dh,003h,02Eh,02Fh,030h,007h,031h,032h,033h,00Bh,00Ch
    db 034h,035h,00Fh,010h,036h,012h,000h,013h,014h,015h,016h,017h,018h,019h
LD1DC:
    ; db[12]
    db 037h,038h,000h,000h,039h,03Ah,03Bh,03Ch,03Dh,03Eh,03Fh,000h
LD1E8:
    ; db[24]
    db 000h,040h,041h,000h,042h,043h,044h,045h,046h,047h,048h,049h
    db 04Ah,03Ah,04Bh,04Ch,04Dh,04Eh,04Fh,050h,051h,052h,053h,054h
LD200:
    ; db[28]
    db 000h,055h,056h,000h,057h,058h,059h,05Ah,05Bh,05Ch,05Dh,05Eh,05Fh,060h
    db 061h,062h,063h,064h,065h,066h,000h,067h,068h,000h,000h,069h,06Ah,000h
LD21C:
    ; db[15]
    db 06Bh,06Ch,06Dh,06Eh,06Fh,070h,071h,072h,073h,074h,075h,076h,000h,077h,078h
LD22B:
    ; db[15]
    db 079h,07Ah,07Bh,07Ch,07Dh,07Eh,07Fh,080h,081h,082h,083h,084h,085h,086h,087h
LD23A:
    ; db[15]
    db 088h,089h,08Ah,08Bh,08Ch,08Dh,08Eh,08Fh,090h,091h,092h,093h,094h,095h,096h
LD249:
    ; db[24]
    db 097h,000h,000h,000h,098h,02Ch,02Dh,000h,099h,09Ah,09Bh,000h
    db 09Ch,09Dh,09Eh,000h,09Fh,0A0h,0A1h,0A2h,0A3h,0A4h,0A5h,0A6h
LD261:
    ; db[12]
    db 000h,0A7h,000h,0A8h,0A9h,0AAh,0ABh,0ACh,0ADh,0AEh,0AFh,0B0h
LD26D:
    ; db[24]
    db 003h,02Eh,000h,000h,007h,0B1h,0B2h,0B3h,00Bh,00Ch,03Ah,035h
    db 00Fh,010h,03Ah,012h,000h,013h,014h,015h,016h,017h,018h,019h
LD285:
    ; db[15]
    db 0B4h,0B5h,0B6h,0B7h,0B8h,0B9h,0BAh,0BBh,0BCh,0BDh,0BEh,0BFh,0C0h,0C1h,0C2h

; Character construction Attributes (LD294)
CharConstructAttrs:
    ; db[28]
    db 078h,078h,07Ah,078h,078h,078h,03Ah,07Bh,078h,078h,069h,07Bh,078h,078h
    db 060h,078h,078h,078h,070h,078h,078h,078h,078h,078h,078h,078h,078h,078h
LD2B0:
    ; db[28]
    db 078h,07Eh,07Ah,07Eh,078h,078h,079h,07Dh,078h,078h,072h,07Dh,078h,078h
    db 058h,078h,078h,078h,068h,078h,078h,078h,078h,078h,078h,078h,078h,078h
LD2CC:
    ; db[28]
    db 078h,078h,078h,078h,078h,078h,030h,07Ah,078h,078h,060h,07Ah,078h,078h
    db 058h,078h,078h,078h,068h,078h,078h,078h,078h,078h,078h,078h,078h,078h
LD2E8:
    ; db[28]
    db 078h,078h,07Bh,07Bh,07Ah,07Ah,07Bh,07Bh,07Ah,07Ah,07Bh,07Bh,07Ah,07Ah
    db 072h,07Ah,07Ah,07Ah,042h,07Ah,078h,07Ah,07Ah,07Ah,07Ah,07Ah,07Ah,07Ah
LD304:
    ; db[28]
    db 078h,078h,07Eh,07Eh,07Ah,07Ah,07Ah,07Eh,07Ah,07Ah,069h,078h,07Ah,07Ah
    db 062h,07Ah,07Ah,07Ah,072h,07Ah,078h,07Ah,07Ah,07Ah,07Ah,07Ah,07Ah,07Ah
LD320:
    ; db[12]
    db 078h,07Dh,078h,078h,078h,078h,078h,078h,078h,078h,078h,078h
LD32C:
    ; db[24]
    db 078h,07Ah,07Ah,078h,07Ah,07Ah,07Ah,07Eh,07Ah,07Ah,07Ah,07Ah
    db 07Ah,07Ah,07Ah,07Ah,07Ah,07Ah,07Ah,07Ah,07Ah,07Ah,07Ah,07Ah
LD344:
    ; db[28]
    db 078h,07Bh,07Bh,078h,079h,06Bh,06Bh,079h,079h,073h,073h,079h,079h,071h
    db 071h,079h,078h,071h,071h,078h,078h,07Ch,07Ch,078h,078h,078h,078h,078h
LD360:
    ; db[15]
    db 07Eh,07Ah,07Eh,07Dh,072h,079h,07Dh,072h,079h,07Dh,072h,079h,078h,079h,079h
LD36F:
    ; db[15]
    db 078h,078h,078h,079h,061h,072h,079h,061h,072h,079h,079h,07Ah,07Bh,07Bh,07Bh
LD37E:
    ; db[15]
    db 07Bh,07Bh,07Bh,07Bh,07Bh,07Bh,07Bh,07Bh,07Bh,07Bh,073h,07Bh,07Bh,073h,07Bh
LD38D:
    ; db[24]
    db 078h,078h,078h,078h,078h,07Eh,07Eh,078h,079h,07Ah,07Eh,078h
    db 079h,069h,079h,078h,079h,079h,079h,079h,07Bh,07Bh,07Bh,07Bh
LD3A5:
    ; db[12]
    db 078h,07Ah,078h,07Ah,072h,07Ah,07Ah,04Ah,07Ah,07Bh,07Bh,07Bh
LD3B1:
    ; db[24]
    db 078h,078h,078h,078h,078h,078h,078h,078h,078h,078h,078h,078h
    db 078h,078h,078h,078h,078h,078h,078h,078h,078h,078h,078h,078h
LD3C9:
    ; db[15]
    db 078h,07Ah,078h,079h,079h,07Bh,079h,072h,07Bh,078h,07Ch,078h,07Ah,078h,07Ah
LD3D8:
    ; db[28]
    db 078h,07Dh,079h,07Dh,078h,078h,079h,07Ch,078h,078h,069h,07Ch,078h,078h
    db 058h,078h,078h,078h,060h,078h,078h,078h,078h,078h,078h,078h,078h,078h
LD3F4:
    ; db[10]
    db 07Dh,07Ah,07Dh,07Bh,069h,079h,073h,069h,079h,07Bh
L07979h:
    ; db[5]
    db 069h,079h,078h,07Ah,079h

; Shield Parts Construction (LDE43)
ShieldPartsConstructTable:
    ; db[42]
    db 001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h
    db 001h,001h,002h,001h,001h,001h,001h,005h,003h,001h,001h,001h,001h,006h,000h,004h
    db 001h,001h,007h,000h,000h,000h,004h,007h,000h,000h
LDE6D:
    ; db[6]
    db 008h,009h,00Ah,00Bh,00Ch,00Dh
LDE73:
    ; db[4]
    db 00Eh,010h,00Fh,011h
LDE77:
    ; db[2]
    db 012h,013h
LDE79:
    ; db[3]
    db 014h,015h,016h
LDE7C:
    ; db[8]
    db 017h,018h,019h,01Ah,000h,01Bh,01Ch,000h
LDE84:
    ; db[8]
    db 01Dh,01Eh,01Fh,020h,021h,022h,023h,024h

; Shield parts table (LDE8C)
;
; Referencing addresses in Shield Parts Construction data.
ShieldPartsTable:
    dw ShieldPartsConstructTable,0607h
    dw LDE6D,0203h
    dw LDE73,0202h
    dw LDE77,0102h
    dw LDE79,0301h
    dw LDE7C,0402h
    dw LDE84,0402h

; Shield Construction Table (LDEA8)
ShieldConstructTable:
    ; db[256]
    db 003h,029h,00Bh,032h,011h,000h,000h,000h,002h,021h,009h,033h,014h,033h,023h,000h
    db 002h,035h,009h,000h,000h,000h,000h,000h,005h,00Ch,009h,03Dh,019h,000h,000h,000h
    db 003h,03Eh,009h,032h,022h,000h,000h,000h,002h,036h,009h,03Ah,022h,000h,000h,000h
    db 003h,036h,009h,02Ah,022h,000h,000h,000h,000h,016h,011h,000h,000h,000h,000h,000h
    db 005h,03Eh,011h,000h,000h,000h,000h,000h,004h,03Eh,011h,000h,000h,000h,000h,000h
    db 002h,03Eh,011h,000h,000h,000h,000h,000h,006h,016h,011h,000h,000h,000h,000h,000h
    db 002h,036h,009h,02Dh,021h,000h,000h,000h,003h,036h,009h,03Dh,021h,000h,000h,000h
    db 004h,03Dh,009h,000h,000h,000h,000h,000h,005h,015h,009h,000h,000h,000h,000h,000h
    db 000h,01Dh,009h,000h,000h,000h,000h,000h,003h,035h,009h,000h,000h,000h,000h,000h
    db 007h,015h,009h,000h,000h,000h,000h,000h,007h,025h,009h,000h,000h,000h,000h,000h
    db 002h,031h,00Ah,000h,000h,000h,000h,000h,005h,039h,00Ah,000h,000h,000h,000h,000h
    db 007h,019h,00Ah,000h,000h,000h,000h,000h,002h,032h,00Ah,000h,000h,000h,000h,000h
    db 000h,022h,00Ah,000h,000h,000h,000h,000h,000h,011h,00Ah,000h,000h,000h,000h,000h
    db 004h,039h,00Ah,000h,000h,000h,000h,000h,003h,03Ah,00Ah,000h,000h,000h,000h,000h
    db 000h,01Eh,009h,024h,022h,000h,000h,000h,000h,032h,009h,01Bh,01Bh,000h,000h,000h
    db 006h,014h,009h,00Bh,01Bh,000h,000h,000h,002h,033h,009h,033h,014h,033h,022h,000h

; Race Image table (GFX)
;
; byte #1 = standing, byte #2 = on horse
;
; (except for Skulkrin and Dragon)
;
RaceImageTable:                
    db 008h,001h                                ; Free
    db 010h,00Fh                                ; Fey
    db 00Eh,000h                                ; Targ
    db 00Ah,003h                                ; Wise
    db 00Bh,004h                                ; Morkin
    db 00Ch,00Ch                                ; Skulkrin
    db 006h,006h                                ; Dragon
    db 0E6h,058h

; Pixel Generation tables (LF000)
PixelGenTable:
    ; db[8]
    db 080h,040h,020h,010h,008h,004h,002h,001h
LF008:
    ; db[8]
    db 0FFh,07Fh,03Fh,01Fh,00Fh,007h,003h,001h
LF010:
    ; db[64]
    db 080h,0C0h,0E0h,0F0h,0F8h,0FCh,0FEh,0FFh
    db 000h,040h,060h,070h,078h,07Ch,07Eh,07Fh
    db 000h,000h,020h,030h,038h,03Ch,03Eh,03Fh
    db 000h,000h,000h,010h,018h,01Ch,01Eh,01Fh
    db 000h,000h,000h,000h,008h,00Ch,00Eh,00Fh
    db 000h,000h,000h,000h,000h,004h,006h,007h
    db 000h,000h,000h,000h,000h,000h,002h,003h
    db 000h,000h,000h,000h,000h,000h,000h,001h

; Landscape Location Calculation Table
;
; +-------+----------+---------------------+
; | Type  | Variable | Description         |
; +-------+----------+---------------------+
; | int8  | dy       | location y adjuster |
; | int8  | dx       | location x adjuster |
; | int16 | xadj     | screen x adjuster   |
; | uint8 | y        | screen y position   |
; | uint8 | size     | scale               |
; +-------+----------+---------------------+
LandscapeLocCalcTable:
    ; db[186]
    db 005h,004h,056h,000h,040h,007h
    db 004h,005h,072h,000h,040h,007h
    db 006h,002h,029h,000h,040h,007h
    db 006h,001h,015h,000h,040h,007h
    db 006h,0FFh,0EBh,0FFh,040h,007h
    db 006h,000h,000h,000h,040h,007h
    db 005h,003h,045h,000h,03Fh,007h
    db 003h,005h,083h,000h,03Fh,007h
    db 004h,004h,064h,000h,03Fh,007h
    db 005h,002h,030h,000h,03Fh,006h
    db 005h,001h,019h,000h,03Fh,006h
    db 005h,0FFh,0E7h,0FFh,03Fh,006h
    db 005h,000h,000h,000h,03Eh,006h
    db 004h,003h,052h,000h,03Eh,006h
    db 003h,004h,076h,000h,03Eh,006h
    db 004h,002h,03Bh,000h,03Eh,006h
    db 003h,003h,064h,000h,03Dh,005h
    db 004h,001h,01Fh,000h,03Dh,005h
    db 004h,0FFh,0E1h,0FFh,03Dh,005h
    db 004h,000h,000h,000h,03Ch,005h
    db 003h,002h,04Bh,000h,03Bh,005h
    db 002h,003h,07Dh,000h,03Bh,005h
    db 003h,001h,029h,000h,03Ah,004h
    db 003h,0FFh,0D7h,0FFh,03Ah,004h
    db 003h,000h,000h,000h,039h,004h
    db 002h,002h,064h,000h,039h,004h
    db 002h,001h,03Bh,000h,035h,003h
    db 001h,002h,08Dh,000h,035h,003h
    db 002h,000h,000h,000h,033h,002h
    db 001h,001h,064h,000h,02Bh,001h
    db 001h,000h,000h,000h,020h,000h

; Landscape Direction Adjustment tables (LF574)
LandscapeDirAdjustTableX:
    db 003h,002h,000h,000h,002h,003h,001h,001h,003h
LandscapeDirAdjustTableY:
    db 001h,001h,003h,002h,000h,000h,002h,003h,001h


; Terrain Image Table
TerrainAddressTable:
    dw TerrainMountain                ; Mountain
    dw L923B
    dw L93C5
    dw L94DD
    dw L95CA
    dw L9674
    dw L96DE
    dw L972F
    dw TerrainCitadel                 ; Citadel
    dw L9A82
    dw L9C76
    dw L9D93
    dw L9E6E
    dw L9F00
    dw L9F5D
    dw L9FAB
    dw TerrainForest                  ; Forest
    dw LA20F
    dw LA384
    dw LA476
    dw LA53F
    dw LA5D1
    dw LA632
    dw LA677
    dw TerrainHenge                   ; Henge
    dw LA819
    dw LA8F7
    dw LA994
    dw LAA1C
    dw LAA6E
    dw LAAA4
    dw LAAC9
    dw TerrainTower                   ; Tower
    dw LAC42
    dw LAD2D
    dw LADCC
    dw LAE4E
    dw LAEB1
    dw LAEF8
    dw LAF2F
    dw TerrainVillage                 ; Village
    dw LB04B
    dw LB0E0
    dw LB13E
    dw LB191
    dw LB1C1
    dw LB1E6
    dw LB1FC
    dw TerrainDowns                   ; Downs
    dw LB2D1
    dw LB35C
    dw LB3BF
    dw LB419
    dw LB45D
    dw LB48D
    dw LB4B2
    dw TerrainKeep                    ; Keep
    dw LB5CE
    dw LB692
    dw LB6F5
    dw LB744
    dw LB773
    dw LB797
    dw LB7AE
    dw TerrainSnowHall                ; SnowHall
    dw LB835
    dw LB884
    dw LB8B7
    dw LB8DD
    dw LB8F5
    dw LB90A
    dw LB91B
    dw TerrainLake                    ; Lake
    dw LB95A
    dw LB981
    dw LB99E
    dw LB9AE
    dw LB9BB
    dw LB9C5
    dw LB9CC
    dw TerrainFrozenWastes            ; Frozen Wastes
    dw LBBEB
    dw LBD50
    dw LBE46
    dw LBF14
    dw LBFA8
    dw LC001
    dw LC03F
    dw TerrainRuin                    ; Ruin
    dw LC17F
    dw LC231
    dw LC2A5
    dw LC30D
    dw LC359
    dw LC38D
    dw LC3B0
    dw TerrainLith                    ; Lith
    dw LC567
    dw LC688
    dw LC753
    dw LC807
    dw LC88B
    dw LC8EC
    dw LC930
    dw TerrainCavern                  ; Cavern
    dw LC9E0
    dw LCA3E
    dw LCA83
    dw LCABF
    dw LCAE8
    dw LCB09
    dw LCB24
    dw TerrainArmy                    ; Army
    dw LCD22
    dw LCE4A
    dw LCF11
    dw LCFB8
    dw LD03E
    dw LD08C
    dw LD0C2

; Terrain data
TerrainMountain:
    ; db[571]
    db 04Eh,041h,000h,07Fh,0C9h,04Bh,043h,001h,07Eh,002h,00Fh,048h,044h,003h,07Dh,004h
    db 010h,047h,07Ch,042h,005h,07Bh,011h,046h,043h,006h,07Ah,011h,046h,04Ah,044h,007h
    db 079h,012h,01Eh,046h,04Ah,045h,008h,079h,013h,01Fh,046h,04Bh,0F4h,075h,045h,009h
    db 078h,013h,0A0h,021h,0C4h,045h,04Bh,0F2h,073h,045h,00Ah,078h,014h,022h,0C2h,043h
    db 04Bh,071h,045h,00Bh,077h,014h,022h,041h,0CCh,04Dh,071h,047h,00Ch,077h,015h,022h
    db 040h,04Eh,065h,070h,0F5h,076h,047h,00Dh,074h,096h,01Ah,023h,040h,0C3h,044h,04Eh
    db 065h,070h,047h,00Eh,073h,01Bh,023h,03Fh,0C5h,046h,04Eh,065h,070h,047h,00Fh,073h
    db 09Ch,01Dh,024h,03Eh,047h,04Eh,065h,070h,047h,00Fh,072h,09Eh,01Fh,025h,03Dh,047h
    db 04Eh,065h,070h,047h,010h,072h,0A0h,022h,025h,03Ch,048h,04Eh,065h,070h,046h,010h
    db 072h,0A3h,025h,03Ch,049h,04Fh,065h,06Fh,047h,011h,072h,092h,013h,025h,0BAh,03Bh
    db 04Ah,04Fh,065h,06Fh,048h,012h,072h,014h,026h,039h,04Bh,04Fh,063h,065h,0EFh,071h
    db 047h,012h,06Fh,015h,026h,0B6h,038h,04Ch,04Fh,063h,065h,047h,013h,06Fh,096h,017h
    db 026h,035h,04Ch,050h,063h,065h,047h,013h,06Fh,018h,027h,035h,04Ch,051h,063h,065h
    db 047h,014h,06Fh,019h,027h,034h,04Ch,051h,062h,065h,047h,014h,06Fh,019h,028h,033h
    db 04Ch,051h,062h,065h,047h,015h,06Eh,01Ah,0A9h,02Dh,032h,04Dh,051h,062h,066h,047h
    db 015h,06Eh,09Bh,01Ch,0AEh,02Fh,031h,04Dh,051h,062h,066h,046h,016h,06Eh,01Dh,030h
    db 04Dh,051h,062h,066h,045h,016h,06Eh,01Dh,04Eh,052h,062h,066h,045h,016h,06Eh,01Dh
    db 04Eh,052h,061h,067h,045h,017h,06Eh,01Dh,04Eh,053h,061h,067h,045h,017h,06Dh,01Eh
    db 04Eh,053h,060h,067h,045h,018h,06Dh,01Eh,04Eh,054h,060h,067h,045h,018h,06Dh,01Fh
    db 04Fh,055h,060h,067h,044h,018h,06Dh,01Fh,050h,0D5h,05Fh,0E4h,06Ch,043h,018h,06Bh
    db 020h,0D1h,054h,063h,043h,019h,06Ah,020h,051h,0E0h,062h,044h,019h,069h,021h,050h
    db 0DEh,05Fh,0E6h,068h,043h,01Ah,065h,0A2h,023h,04Fh,0E3h,064h,043h,01Bh,062h,024h
    db 04Fh,0E0h,061h,043h,01Ch,061h,025h,04Fh,0DEh,05Fh,044h,01Dh,061h,01Eh,025h,04Fh
    db 0DCh,05Dh,045h,01Fh,060h,0A0h,022h,026h,04Eh,0DAh,05Bh,05Fh,043h,023h,05Eh,0A4h
    db 026h,04Eh,059h,042h,026h,05Eh,04Dh,058h,042h,026h,05Dh,04Dh,057h,042h,027h,05Dh
    db 04Dh,056h,042h,027h,05Ch,04Dh,055h,043h,027h,05Ch,0B5h,037h,04Ch,054h,043h,028h
    db 05Ch,038h,04Ch,053h,043h,028h,05Bh,029h,0B9h,03Bh,04Ch,042h,02Ah,05Ah,03Ch,04Ch
    db 042h,02Bh,05Ah,03Dh,059h,042h,02Bh,05Ah,03Dh,0D7h,058h,043h,02Bh,059h,02Ch,03Eh
    db 0D5h,056h,042h,02Dh,059h,03Fh,054h,043h,02Eh,058h,0AFh,033h,040h,054h,043h,031h
    db 057h,034h,041h,053h,043h,032h,057h,0B5h,036h,041h,053h,043h,032h,057h,0B7h,03Ah
    db 042h,052h,044h,033h,057h,034h,03Bh,043h,051h,043h,034h,056h,03Bh,044h,051h,044h
    db 035h,056h,036h,03Ch,045h,050h,042h,036h,056h,03Ch,046h,042h,037h,055h,03Ch,047h
    db 042h,037h,054h,03Dh,047h,042h,038h,053h,03Eh,047h,042h,038h,052h,03Fh,048h,043h
    db 039h,051h,03Ah,040h,0C9h,04Bh,042h,03Bh,050h,040h,0CCh,04Fh,041h,03Ch,04Eh,03Dh
    db 040h,03Eh,04Dh,041h,03Fh,04Ch,0CAh,04Bh,040h,040h,049h,040h,040h,049h,041h,041h
    db 048h,042h,040h,043h,047h,040h,044h,046h,040h,045h,045h
L923B:
    ; db[394]
    db 037h,041h,013h,06Ch,0C6h,048h,044h,014h,06Bh,095h,016h,01Eh,045h,06Ah,042h,017h
    db 069h,01Fh,044h,043h,017h,068h,01Fh,044h,047h,045h,018h,068h,020h,0A8h,029h,044h
    db 047h,0E4h,065h,045h,019h,067h,020h,02Ah,043h,048h,063h,045h,01Ah,066h,021h,02Bh
    db 0C1h,042h,049h,062h,046h,01Bh,065h,022h,02Bh,040h,04Ah,05Ah,061h,048h,01Ch,064h
    db 01Dh,0A3h,026h,02Ch,03Fh,0C2h,044h,04Ah,05Ah,061h,047h,01Eh,064h,027h,02Ch,03Eh
    db 045h,04Ah,05Ah,061h,047h,01Eh,063h,028h,02Dh,03Eh,045h,04Ah,05Ah,061h,046h,01Eh
    db 063h,0A9h,02Dh,03Dh,046h,04Ah,05Ah,061h,046h,01Fh,063h,02Dh,03Ch,047h,04Ah,05Ah
    db 061h,048h,020h,063h,021h,02Eh,0B9h,03Bh,048h,04Ah,058h,05Ah,0E1h,062h,047h,020h
    db 061h,0A2h,023h,02Eh,038h,048h,04Bh,058h,05Ah,047h,020h,061h,024h,02Eh,038h,048h
    db 04Ch,058h,05Ah,047h,021h,061h,025h,02Fh,037h,048h,04Ch,058h,05Ah,047h,022h,060h
    db 025h,0B0h,032h,036h,049h,04Ch,058h,05Ah,046h,022h,060h,026h,0B3h,035h,049h,04Ch
    db 058h,05Ah,045h,022h,060h,027h,04Ah,04Ch,058h,05Ah,045h,022h,060h,027h,04Ah,04Ch
    db 057h,05Bh,045h,023h,05Fh,028h,04Ah,04Dh,056h,05Bh,045h,024h,05Fh,028h,04Ah,04Eh
    db 056h,05Bh,044h,024h,05Eh,029h,04Bh,0CFh,055h,0D9h,05Dh,043h,024h,05Eh,029h,0CCh
    db 04Eh,058h,044h,025h,05Dh,02Ah,04Bh,0D5h,057h,0DBh,05Ch,043h,025h,05Ah,02Bh,04Ah
    db 059h,043h,026h,058h,02Ch,04Ah,0D5h,057h,044h,027h,057h,028h,02Dh,04Ah,0D3h,054h
    db 043h,029h,056h,0AAh,02Dh,04Ah,052h,042h,02Eh,055h,049h,051h,042h,02Eh,054h,049h
    db 050h,042h,02Eh,054h,049h,04Fh,043h,02Eh,053h,0B8h,03Ah,048h,04Eh,043h,02Fh,053h
    db 0BBh,03Ch,048h,04Dh,042h,030h,052h,03Dh,048h,042h,031h,051h,03Eh,050h,042h,032h
    db 051h,03Eh,04Fh,042h,033h,051h,03Fh,04Eh,043h,034h,051h,0B5h,037h,0C0h,041h,04Dh
    db 043h,036h,050h,0B8h,039h,041h,04Dh,043h,036h,050h,0BAh,03Bh,042h,04Ch,043h,037h
    db 04Fh,03Ch,043h,04Ch,044h,038h,04Fh,039h,03Dh,044h,04Bh,042h,03Ah,04Fh,03Dh,045h
    db 042h,03Ah,04Eh,03Eh,045h,042h,03Ah,04Dh,03Fh,045h,042h,03Bh,04Ch,040h,0C6h,047h
    db 044h,03Ch,04Bh,03Dh,040h,048h,04Ah,040h,03Eh,049h,041h,03Fh,048h,047h,040h,040h
    db 046h,040h,041h,045h,040h,042h,044h,040h,043h,043h
L93C5:
    ; db[280]
    db 027h,043h,020h,05Fh,021h,027h,0C4h,045h,043h,022h,05Eh,028h,043h,05Dh,044h,023h
    db 05Ch,028h,02Fh,043h,045h,045h,024h,05Ch,029h,030h,042h,045h,0D9h,05Ah,045h,025h
    db 05Bh,02Ah,031h,041h,046h,058h,046h,026h,05Ah,0ABh,02Dh,031h,040h,047h,052h,058h
    db 047h,027h,05Ah,02Eh,032h,03Fh,042h,047h,052h,058h,047h,028h,05Ah,0AFh,030h,032h
    db 03Eh,043h,047h,052h,058h,046h,029h,059h,0B1h,032h,03Dh,044h,047h,052h,057h,047h
    db 029h,059h,02Ah,033h,0BBh,03Ch,045h,047h,0D1h,052h,0D7h,058h,046h,029h,057h,02Bh
    db 033h,03Ah,046h,048h,0D1h,052h,046h,02Ah,057h,02Ch,034h,039h,046h,048h,0D1h,052h
    db 046h,02Ah,057h,02Dh,0B5h,038h,046h,048h,051h,053h,045h,02Bh,057h,02Eh,046h,049h
    db 051h,053h,045h,02Bh,057h,02Eh,047h,049h,050h,053h,045h,02Bh,056h,02Fh,047h,0C9h
    db 04Ah,050h,053h,044h,02Ch,056h,02Fh,047h,0CAh,050h,0D2h,055h,043h,02Ch,055h,030h
    db 0C8h,04Ah,051h,044h,02Ch,054h,031h,048h,050h,0D2h,053h,042h,02Dh,051h,032h,047h
    db 044h,02Eh,050h,0AFh,030h,033h,047h,0CDh,04Fh,043h,031h,04Fh,0B2h,033h,047h,04Ch
    db 042h,033h,04Eh,046h,04Bh,043h,033h,04Eh,0BAh,03Bh,046h,04Ah,043h,034h,04Eh,0BCh
    db 03Dh,046h,049h,042h,035h,04Dh,03Eh,046h,042h,035h,04Dh,03Eh,0CBh,04Ch,043h,036h
    db 04Ch,037h,03Fh,04Ah,043h,038h,04Bh,0B9h,03Bh,040h,049h,043h,039h,04Bh,03Ch,041h
    db 049h,043h,03Ah,04Bh,03Dh,042h,048h,042h,03Bh,04Ah,03Eh,043h,042h,03Ch,049h,03Eh
    db 043h,042h,03Dh,048h,03Fh,0C4h,045h,042h,03Eh,047h,040h,046h,040h,03Fh,045h,040h
    db 040h,044h,040h,041h,043h,040h,042h,042h
L94DD:
    ; db[237]
    db 023h,042h,024h,05Bh,02Bh,0C4h,045h,043h,025h,05Ah,026h,02Bh,043h,044h,027h,059h
    db 02Ch,031h,043h,045h,045h,028h,059h,02Ch,032h,042h,045h,056h,046h,029h,058h,02Dh
    db 033h,041h,046h,050h,055h,047h,02Ah,057h,0AEh,030h,033h,040h,042h,046h,050h,055h
    db 047h,02Bh,056h,0B1h,032h,034h,03Fh,043h,046h,050h,055h,045h,02Ch,055h,0B3h,034h
    db 03Eh,044h,047h,050h,046h,02Ch,055h,02Dh,035h,0BCh,03Dh,045h,047h,050h,046h,02Ch
    db 055h,02Eh,035h,03Bh,045h,048h,050h,046h,02Dh,055h,02Fh,036h,03Ah,045h,048h,0CFh
    db 050h,046h,02Dh,054h,030h,0B7h,039h,046h,048h,04Fh,051h,045h,02Eh,054h,030h,046h
    db 048h,04Fh,051h,045h,02Eh,054h,031h,046h,049h,0CEh,04Fh,051h,045h,02Fh,054h,031h
    db 047h,049h,04Eh,051h,042h,02Fh,054h,032h,0C8h,053h,042h,02Fh,050h,033h,047h,042h
    db 030h,04Fh,034h,047h,043h,031h,04Eh,0B2h,035h,047h,0CCh,04Dh,042h,035h,04Dh,046h
    db 04Bh,042h,035h,04Dh,046h,04Ah,043h,035h,04Ch,0BBh,03Ch,045h,049h,042h,036h,04Ch
    db 0BDh,03Eh,045h,042h,037h,04Ch,03Fh,0CAh,04Bh,043h,038h,04Bh,039h,040h,049h,043h
    db 03Ah,04Ah,0BBh,03Ch,041h,048h,043h,03Ah,04Ah,03Dh,042h,048h,043h,03Bh,04Ah,03Eh
    db 043h,047h,042h,03Ch,049h,03Fh,043h,042h,03Dh,048h,040h,044h,041h,03Eh,047h,045h
    db 041h,03Fh,046h,045h,040h,040h,044h,040h,041h,043h,040h,042h,042h
L95CA:
    ; db[170]
    db 01Ah,042h,02Bh,055h,030h,043h,043h,02Ch,054h,030h,042h,053h,044h,02Dh,052h,031h
    db 035h,041h,051h,045h,02Eh,050h,032h,036h,040h,044h,04Ch,046h,02Fh,050h,0B3h,034h
    db 037h,03Fh,042h,045h,04Ch,045h,030h,050h,0B5h,037h,03Fh,042h,045h,04Ch,045h,031h
    db 050h,038h,0BDh,03Eh,043h,045h,04Ch,045h,032h,050h,038h,03Ch,044h,046h,04Ch,045h
    db 032h,04Fh,0B3h,034h,0B9h,03Bh,044h,046h,0CBh,04Ch,045h,033h,04Fh,035h,044h,046h
    db 04Bh,04Dh,045h,033h,04Fh,035h,045h,047h,04Bh,04Dh,042h,033h,04Fh,035h,0C6h,04Eh
    db 042h,034h,04Dh,036h,046h,043h,035h,04Ch,037h,045h,0CAh,04Bh,043h,036h,04Bh,037h
    db 045h,0C8h,049h,042h,038h,04Ah,044h,047h,043h,039h,049h,0BDh,03Eh,044h,046h,042h
    db 03Ah,049h,03Fh,044h,042h,03Bh,048h,040h,047h,042h,03Bh,048h,041h,046h,043h,03Ch
    db 047h,0BDh,03Eh,042h,045h,042h,03Dh,046h,03Fh,042h,002h,03Eh,045h,03Fh,0C1h,042h
    db 040h,03Fh,044h,001h,040h,043h,042h,040h,042h,042h
L9674:
    ; db[106]
    db 014h,041h,030h,050h,042h,043h,031h,04Fh,034h,037h,041h,046h,032h,04Eh,035h,038h
    db 040h,043h,049h,04Dh,044h,033h,04Ch,0B6h,038h,03Fh,043h,049h,044h,034h,04Ch,039h
    db 03Eh,043h,049h,044h,034h,04Ch,03Ah,03Dh,044h,049h,043h,035h,04Bh,0BBh,03Ch,044h
    db 0C8h,049h,042h,035h,04Bh,044h,0C8h,049h,041h,036h,04Bh,0C5h,04Ah,041h,036h,049h
    db 044h,042h,037h,048h,038h,044h,041h,039h,047h,043h,042h,03Ah,047h,0BDh,03Eh,043h
    db 041h,03Bh,046h,03Fh,041h,03Ch,046h,040h,041h,03Dh,046h,041h,041h,03Eh,045h,042h
    db 041h,03Fh,044h,043h,040h,040h,043h,000h,041h,042h
L96DE:
    ; db[81]
    db 010h,040h,033h,04Ch,043h,034h,04Ch,037h,041h,043h,044h,035h,04Bh,038h,040h,043h
    db 047h,044h,036h,04Ah,0B9h,03Ah,03Fh,043h,047h,044h,037h,04Ah,03Bh,03Eh,043h,047h
    db 043h,037h,049h,0BCh,03Dh,043h,047h,042h,038h,049h,043h,047h,041h,039h,049h,0C4h
    db 048h,041h,03Ah,047h,043h,041h,03Bh,046h,042h,042h,03Bh,045h,03Eh,042h,041h,03Ch
    db 045h,03Fh,041h,03Dh,044h,040h,001h,03Eh,043h,0BFh,040h,040h,03Fh,043h,000h,040h
    db 042h
L972F:
    ; db[63]
    db 00Dh,040h,036h,04Ah,043h,037h,04Ah,03Bh,041h,043h,044h,038h,049h,03Ch,040h,043h
    db 046h,044h,039h,048h,03Ch,03Fh,043h,046h,043h,039h,048h,0BDh,03Eh,043h,046h,041h
    db 03Ah,048h,0C3h,047h,041h,03Ah,046h,043h,041h,03Bh,045h,042h,041h,03Ch,045h,040h
    db 041h,03Dh,044h,041h,041h,03Eh,044h,041h,041h,03Fh,043h,042h,000h,040h,041h
TerrainCitadel:
    ; db[788]
    db 04Ah,04Eh,003h,07Bh,008h,00Ch,033h,038h,03Ah,03Ch,03Eh,040h,042h,044h,046h,04Bh
    db 072h,076h,049h,003h,07Bh,008h,08Ch,00Dh,033h,038h,0BAh,044h,046h,04Bh,0F1h,072h
    db 076h,04Eh,003h,07Bh,008h,00Dh,033h,038h,03Ah,03Ch,03Eh,040h,042h,044h,046h,04Bh
    db 071h,076h,049h,003h,07Bh,008h,00Dh,033h,038h,0BAh,044h,046h,04Bh,071h,076h,04Fh
    db 003h,07Bh,006h,008h,00Dh,033h,038h,03Ah,03Ch,03Eh,040h,042h,044h,046h,04Bh,071h
    db 076h,04Eh,003h,07Bh,006h,008h,00Dh,033h,036h,038h,0BAh,044h,046h,048h,04Bh,06Ah
    db 071h,076h,078h,052h,003h,07Bh,006h,008h,00Dh,02Ch,033h,036h,038h,0BAh,03Ch,03Eh
    db 040h,0C2h,044h,046h,048h,04Bh,06Ah,0F0h,071h,076h,078h,04Fh,003h,07Bh,008h,08Dh
    db 00Eh,02Ch,033h,036h,038h,0BBh,043h,046h,048h,04Bh,051h,06Ah,070h,076h,078h,04Ch
    db 003h,07Bh,008h,00Eh,02Ch,033h,038h,0BCh,042h,046h,04Bh,051h,06Ah,070h,076h,04Ah
    db 003h,07Bh,008h,00Eh,02Ch,033h,038h,046h,04Bh,051h,070h,076h,04Bh,003h,07Bh,008h
    db 00Eh,015h,026h,033h,038h,046h,04Bh,051h,070h,076h,04Ah,003h,07Bh,008h,00Eh,015h
    db 026h,033h,038h,046h,04Bh,070h,076h,04Bh,003h,07Bh,005h,088h,00Eh,015h,026h,033h
    db 035h,0B8h,046h,049h,04Bh,0F0h,076h,079h,04Eh,003h,07Bh,005h,008h,00Eh,015h,026h
    db 033h,035h,038h,046h,049h,04Bh,070h,076h,079h,049h,003h,07Bh,005h,088h,00Fh,033h
    db 035h,0B8h,046h,049h,04Bh,0EFh,076h,079h,0C1h,003h,00Bh,008h,0CCh,00Dh,071h,00Fh
    db 033h,038h,03Bh,03Dh,041h,043h,046h,04Bh,060h,066h,06Fh,041h,073h,07Bh,076h,080h
    db 002h,00Bh,0C7h,00Dh,071h,08Eh,00Fh,0B2h,03Bh,0BDh,041h,0C3h,04Ch,060h,066h,0EFh
    db 070h,000h,073h,07Ch,0C0h,002h,009h,0C6h,00Fh,06Fh,032h,039h,045h,04Ch,060h,066h
    db 040h,075h,07Ch,080h,001h,00Ah,0C4h,00Fh,06Fh,0B1h,03Ah,0C4h,04Dh,060h,066h,000h
    db 074h,07Dh,0C0h,001h,00Ah,0C4h,00Fh,06Fh,031h,03Ah,044h,04Dh,040h,074h,07Dh,080h
    db 001h,00Ah,0C2h,00Fh,06Fh,0B1h,03Ah,0C4h,04Dh,000h,074h,07Dh,044h,00Fh,06Fh,010h
    db 022h,058h,06Eh,042h,010h,06Eh,022h,058h,043h,010h,06Eh,014h,022h,058h,043h,010h
    db 06Eh,014h,022h,058h,041h,010h,06Eh,014h,041h,010h,06Eh,014h,041h,010h,06Eh,03Eh
    db 042h,010h,06Eh,011h,03Eh,043h,011h,06Eh,03Eh,068h,06Dh,042h,011h,06Dh,03Eh,068h
    db 041h,011h,06Dh,068h,041h,011h,06Dh,068h,041h,011h,06Dh,01Bh,042h,011h,06Dh,01Bh
    db 04Ch,044h,011h,06Dh,012h,01Bh,04Ch,061h,044h,012h,06Dh,01Bh,04Ch,061h,06Ch,042h
    db 012h,06Ch,04Ch,061h,042h,012h,06Ch,02Ah,061h,041h,012h,06Ch,02Ah,042h,012h,06Ch
    db 02Ah,032h,042h,012h,06Ch,02Ah,032h,041h,012h,06Ch,032h,043h,012h,06Ch,013h,032h
    db 06Bh,040h,013h,06Bh,040h,013h,06Bh,040h,013h,06Bh,051h,013h,06Bh,018h,01Bh,022h
    db 025h,02Ch,02Fh,036h,039h,040h,043h,04Ah,04Dh,054h,057h,05Eh,061h,068h,051h,013h
    db 06Bh,018h,01Bh,022h,025h,02Ch,02Fh,036h,039h,040h,043h,04Ah,04Dh,054h,057h,05Eh
    db 061h,068h,051h,013h,06Bh,097h,018h,09Bh,01Ch,0A1h,022h,0A5h,026h,0ABh,02Ch,0AFh
    db 030h,0B5h,036h,0B9h,03Ah,0BFh,040h,0C3h,044h,0C9h,04Ah,0CDh,04Eh,0D3h,054h,0D7h
    db 058h,0DDh,05Eh,0E1h,062h,0E7h,068h,000h,011h,06Dh,040h,011h,06Dh,040h,011h,06Dh
    db 013h,011h,06Dh,012h,096h,017h,09Bh,01Ch,0A0h,021h,0A5h,026h,0AAh,02Bh,0AFh,030h
    db 0B4h,035h,0B9h,03Ah,0BEh,03Fh,0C3h,044h,0C8h,049h,0CDh,04Eh,0D2h,053h,0D7h,058h
    db 0DCh,05Dh,0E1h,062h,0E6h,067h,0EBh,06Ch,080h,011h,013h,080h,015h,018h,080h,01Ah
    db 01Dh,080h,01Fh,022h,080h,024h,027h,080h,029h,02Ch,086h,02Eh,04Fh,032h,037h,03Ch
    db 041h,046h,04Bh,080h,051h,054h,080h,056h,059h,080h,05Bh,05Eh,080h,060h,063h,080h
    db 065h,068h,000h,06Ah,06Dh,040h,02Fh,04Dh,040h,02Fh,04Dh,04Eh,02Fh,04Dh,031h,033h
    db 035h,037h,039h,03Bh,03Dh,03Fh,041h,043h,045h,047h,049h,04Bh,008h,02Fh,04Dh,030h
    db 034h,038h,03Ch,040h,044h,048h,04Ch,008h,02Eh,04Eh,030h,034h,038h,03Ch,040h,044h
    db 048h,04Ch,040h,02Eh,04Eh,000h,02Eh,04Eh,040h,02Fh,04Dh,043h,02Fh,04Dh,0B4h,036h
    db 0BDh,03Fh,0C6h,048h,043h,02Fh,04Dh,0B4h,036h,0BDh,03Fh,0C6h,048h,043h,02Fh,04Dh
    db 0B4h,036h,0BDh,03Fh,0C6h,048h,043h,02Fh,04Dh,0B4h,036h,0BDh,03Fh,0C6h,048h,040h
    db 02Fh,04Dh,040h,02Fh,04Dh,000h,02Dh,04Fh,040h,02Dh,04Fh,040h,02Dh,04Fh,007h,02Dh
    db 04Fh,0AEh,02Fh,0B3h,034h,0B8h,039h,0BDh,03Eh,0C2h,043h,0C7h,048h,0CCh,04Eh,080h
    db 02Dh,030h,080h,032h,035h,080h,037h,03Ah,080h,03Ch,03Fh,080h,041h,044h,080h,046h
    db 049h,000h,04Bh,04Fh
L9A82:
    ; db[500]
    db 034h,049h,015h,069h,018h,01Bh,037h,03Ah,0BCh,042h,044h,047h,063h,066h,049h,015h
    db 069h,018h,09Bh,01Ch,037h,03Ah,0BCh,042h,044h,047h,0E2h,063h,066h,049h,015h,069h
    db 018h,01Ch,037h,03Ah,0BCh,042h,044h,047h,062h,066h,049h,015h,069h,018h,01Ch,037h
    db 03Ah,0BCh,042h,044h,047h,062h,066h,04Bh,015h,069h,018h,01Ch,032h,037h,03Ah,0BCh
    db 042h,044h,047h,05Dh,0E1h,062h,066h,04Ch,015h,069h,018h,09Ch,01Dh,032h,037h,03Ah
    db 0BCh,042h,044h,047h,04Ch,05Dh,061h,066h,04Ch,015h,069h,018h,01Dh,032h,037h,03Ah
    db 0BDh,041h,044h,047h,04Ch,05Dh,061h,066h,04Bh,015h,069h,018h,01Dh,022h,02Eh,037h
    db 03Ah,044h,047h,04Ch,061h,066h,047h,015h,069h,098h,01Dh,022h,02Eh,037h,0BAh,044h
    db 047h,0E1h,066h,04Ah,015h,069h,018h,01Dh,022h,02Eh,037h,03Ah,044h,047h,061h,066h
    db 04Ch,015h,069h,018h,09Ah,01Bh,09Dh,01Eh,037h,03Ah,0BCh,03Eh,0C0h,042h,044h,047h
    db 061h,0E3h,064h,066h,080h,014h,01Ah,0C7h,01Ch,062h,09Dh,01Eh,0B6h,03Ch,0BEh,040h
    db 0C2h,048h,056h,05Ah,061h,000h,064h,06Ah,0C0h,014h,019h,0C6h,01Eh,061h,036h,03Bh
    db 044h,048h,056h,05Ah,040h,065h,06Ah,0C0h,013h,01Ah,0C6h,01Eh,061h,035h,03Ch,043h
    db 049h,056h,05Ah,040h,064h,06Bh,080h,013h,01Ah,0C2h,01Eh,061h,0B5h,03Ch,0C3h,049h
    db 000h,064h,06Bh,043h,01Eh,061h,02Bh,051h,060h,043h,01Eh,060h,021h,02Bh,051h,043h
    db 01Eh,060h,021h,02Bh,051h,041h,01Eh,060h,021h,041h,01Eh,060h,03Eh,044h,01Eh,060h
    db 01Fh,03Eh,05Ch,05Fh,042h,01Fh,05Fh,03Eh,05Ch,041h,01Fh,05Fh,05Ch,041h,01Fh,05Fh
    db 026h,042h,01Fh,05Fh,026h,048h,044h,01Fh,05Fh,020h,026h,048h,057h,042h,020h,05Fh
    db 048h,057h,042h,020h,05Fh,030h,057h,042h,020h,05Fh,030h,036h,042h,020h,05Fh,030h
    db 036h,042h,020h,05Fh,036h,05Eh,040h,020h,05Eh,040h,020h,05Eh,051h,020h,05Eh,024h
    db 026h,02Bh,02Dh,032h,034h,039h,03Bh,040h,042h,047h,049h,04Eh,050h,055h,057h,05Ch
    db 012h,020h,05Eh,0A1h,022h,025h,0A8h,029h,02Ch,0AFh,030h,033h,0B6h,037h,03Ah,0BDh
    db 03Eh,041h,0C4h,045h,048h,0CBh,04Ch,04Fh,0D2h,053h,056h,0D9h,05Ah,05Dh,000h,01Fh
    db 05Fh,040h,01Fh,05Fh,012h,01Fh,05Fh,023h,026h,02Ah,02Dh,031h,034h,038h,03Bh,03Fh
    db 042h,046h,049h,04Dh,050h,054h,057h,05Bh,05Eh,080h,01Fh,020h,080h,022h,027h,080h
    db 029h,02Eh,083h,030h,04Ah,036h,03Dh,044h,080h,04Ch,051h,080h,053h,058h,000h,05Ah
    db 05Fh,040h,034h,049h,007h,034h,049h,035h,038h,03Bh,03Eh,041h,044h,0C7h,048h,007h
    db 033h,04Ah,035h,038h,03Bh,03Eh,041h,044h,0C7h,048h,040h,033h,04Ah,000h,033h,04Ah
    db 040h,034h,049h,043h,034h,049h,0B8h,039h,0BEh,03Fh,0C4h,045h,043h,034h,049h,0B8h
    db 039h,0BEh,03Fh,0C4h,045h,040h,034h,049h,000h,033h,04Ah,040h,033h,04Ah,007h,033h
    db 04Ah,034h,037h,03Bh,03Eh,042h,045h,049h,080h,033h,038h,080h,03Ah,03Fh,080h,041h
    db 046h,000h,048h,04Ah
L9C76:
    ; db[285]
    db 026h,049h,021h,05Dh,023h,025h,039h,03Bh,0BDh,041h,043h,045h,059h,05Bh,049h,021h
    db 05Dh,023h,025h,039h,03Bh,0BDh,041h,043h,045h,059h,05Bh,049h,021h,05Dh,023h,026h
    db 039h,03Bh,0BDh,041h,043h,045h,058h,05Bh,04Bh,021h,05Dh,023h,026h,036h,039h,03Bh
    db 0BDh,041h,043h,045h,054h,058h,05Bh,04Ch,021h,05Dh,023h,026h,036h,039h,03Bh,0BDh
    db 041h,043h,045h,048h,054h,058h,05Bh,04Bh,021h,05Dh,023h,027h,02Ah,033h,039h,03Bh
    db 043h,045h,048h,057h,05Bh,047h,021h,05Dh,0A3h,027h,02Ah,033h,039h,0BBh,043h,045h
    db 0D7h,05Bh,048h,021h,05Dh,023h,027h,039h,03Bh,043h,045h,057h,05Bh,045h,021h,05Dh
    db 0A2h,027h,0B9h,045h,04Fh,052h,0D7h,05Ch,0C0h,020h,024h,0C6h,027h,057h,038h,03Ch
    db 042h,046h,04Fh,052h,040h,05Ah,05Eh,080h,020h,024h,0C2h,027h,057h,0B8h,03Ch,0C2h
    db 046h,000h,05Ah,05Eh,043h,027h,057h,02Ah,031h,04Ch,043h,027h,057h,02Ah,031h,04Ch
    db 040h,027h,057h,042h,027h,057h,03Eh,054h,042h,028h,056h,03Eh,054h,041h,028h,056h
    db 02Dh,042h,028h,056h,02Dh,045h,042h,028h,056h,045h,050h,042h,028h,056h,034h,050h
    db 042h,028h,056h,034h,039h,041h,028h,056h,039h,040h,029h,055h,040h,029h,055h,051h
    db 029h,055h,02Bh,02Dh,030h,032h,035h,037h,03Ah,03Ch,03Fh,041h,044h,046h,049h,04Bh
    db 04Eh,050h,053h,000h,028h,056h,040h,028h,056h,000h,028h,056h,040h,037h,046h,007h
    db 036h,047h,038h,03Ah,03Ch,03Eh,040h,042h,044h,040h,036h,047h,000h,036h,047h,043h
    db 037h,046h,0BAh,03Bh,0BEh,03Fh,0C2h,043h,043h,037h,046h,0BAh,03Bh,0BEh,03Fh,0C2h
    db 043h,040h,037h,046h,000h,036h,047h,040h,036h,047h,000h,036h,047h
L9D93:
    ; db[219]
    db 021h,049h,024h,059h,026h,028h,039h,03Bh,0BDh,040h,042h,044h,055h,057h,049h,024h
    db 059h,026h,028h,039h,03Bh,0BDh,040h,042h,044h,055h,057h,049h,024h,059h,026h,028h
    db 039h,03Bh,0BDh,040h,042h,044h,055h,057h,04Bh,024h,059h,026h,028h,037h,039h,03Bh
    db 0BDh,040h,042h,044h,051h,055h,057h,04Bh,024h,059h,026h,028h,02Ch,034h,039h,03Bh
    db 042h,044h,046h,055h,057h,045h,024h,059h,0A6h,028h,039h,0BBh,042h,044h,0D5h,057h
    db 048h,024h,059h,026h,029h,039h,03Bh,042h,044h,054h,057h,045h,024h,059h,0A5h,029h
    db 0B9h,044h,04Dh,04Fh,0D4h,058h,0C0h,023h,027h,0C4h,029h,054h,038h,03Ch,041h,045h
    db 040h,056h,05Ah,080h,023h,027h,0C2h,029h,054h,0B8h,03Ch,0C1h,045h,000h,056h,05Ah
    db 043h,029h,054h,02Ch,032h,04Ah,040h,029h,054h,042h,029h,054h,03Eh,051h,040h,02Ah
    db 053h,041h,02Ah,053h,02Fh,041h,02Ah,053h,044h,041h,02Ah,053h,04Dh,041h,02Ah,053h
    db 035h,041h,02Ah,053h,039h,040h,02Bh,052h,040h,02Bh,052h,040h,02Bh,052h,000h,02Ah
    db 053h,040h,02Ah,053h,000h,02Ah,053h,040h,038h,045h,040h,038h,045h,004h,038h,045h
    db 039h,0BCh,03Dh,0C0h,041h,044h,004h,038h,045h,039h,0BCh,03Dh,0C0h,041h,044h,040h
    db 038h,045h,000h,038h,045h,040h,038h,045h,000h,038h,045h
L9E6E:
    ; db[146]
    db 018h,047h,02Bh,053h,02Dh,02Fh,03Bh,0BDh,041h,043h,04Fh,051h,047h,02Bh,053h,02Dh
    db 02Fh,03Bh,0BDh,041h,043h,04Fh,051h,047h,02Bh,053h,02Dh,02Fh,03Bh,0BDh,041h,043h
    db 04Fh,051h,048h,02Bh,053h,02Dh,02Fh,03Bh,03Dh,041h,043h,04Fh,051h,045h,02Bh,053h
    db 0ADh,02Fh,03Bh,0BDh,041h,043h,0CFh,051h,080h,02Bh,02Dh,0C2h,02Fh,04Fh,0BBh,03Ch
    db 0C2h,043h,000h,051h,053h,0C0h,02Ah,02Dh,0C4h,02Fh,04Fh,03Ah,03Dh,041h,044h,040h
    db 051h,054h,080h,02Ah,02Dh,0C2h,02Fh,04Fh,0BAh,03Dh,0C1h,044h,000h,051h,054h,040h
    db 02Fh,04Fh,040h,02Fh,04Fh,040h,030h,04Eh,040h,030h,04Eh,040h,030h,04Eh,040h,030h
    db 04Eh,040h,030h,04Eh,000h,030h,04Eh,040h,030h,04Eh,000h,030h,04Eh,040h,03Ah,044h
    db 043h,03Ah,044h,03Ch,03Fh,042h,040h,03Ah,044h,000h,03Ah,044h,040h,03Ah,044h,000h
    db 03Ah,044h
L9F00:
    ; db[93]
    db 012h,045h,030h,04Eh,032h,03Ch,0BEh,040h,042h,04Ch,045h,030h,04Eh,032h,03Ch,0BEh
    db 040h,042h,04Ch,045h,030h,04Eh,032h,03Ch,0BEh,040h,042h,04Ch,045h,030h,04Eh,032h
    db 03Ch,0BEh,040h,042h,04Ch,046h,030h,04Eh,032h,03Ch,03Eh,040h,042h,04Ch,044h,030h
    db 04Eh,0B1h,033h,0BCh,03Eh,0C0h,042h,0CBh,04Dh,040h,033h,04Bh,040h,033h,04Bh,040h
    db 033h,04Bh,040h,033h,04Bh,040h,033h,04Bh,000h,033h,04Bh,040h,033h,04Bh,000h,033h
    db 04Bh,040h,03Bh,043h,040h,03Bh,043h,040h,03Bh,043h,000h,03Bh,043h
L9F5D:
    ; db[78]
    db 00Fh,045h,034h,04Bh,036h,03Dh,0BFh,040h,042h,049h,045h,034h,04Bh,036h,03Dh,0BFh
    db 040h,042h,049h,045h,034h,04Bh,036h,03Dh,0BFh,040h,042h,049h,045h,034h,04Bh,036h
    db 03Dh,0BFh,040h,042h,049h,044h,034h,04Bh,0B5h,036h,0BDh,03Eh,0C1h,042h,0C9h,04Ah
    db 040h,036h,049h,040h,036h,049h,040h,036h,049h,040h,036h,049h,040h,036h,049h,000h
    db 036h,049h,040h,03Ch,043h,040h,03Ch,043h,040h,03Ch,043h,000h,03Ch,043h
L9FAB:
    ; db[45]
    db 00Ch,041h,037h,048h,0BFh,040h,041h,037h,048h,0BFh,040h,041h,037h,048h,0BFh,040h
    db 042h,037h,048h,038h,047h,040h,038h,047h,040h,038h,047h,040h,038h,047h,040h,038h
    db 047h,000h,038h,047h,040h,03Dh,043h,040h,03Dh,043h,000h,03Dh,043h
TerrainForest:
    ; db[567]
    db 029h,045h,009h,076h,08Ah,014h,096h,01Ah,0B8h,03Dh,0DDh,060h,0ECh,075h,00Ah,009h
    db 076h,00Ah,011h,016h,09Ah,02Ch,0B1h,038h,03Dh,0D6h,05Dh,0E0h,066h,070h,075h,00Ch
    db 00Ah,075h,00Bh,010h,017h,019h,02Ch,031h,0B7h,039h,03Ch,05Dh,060h,071h,074h,00Eh
    db 00Bh,075h,00Ch,00Fh,017h,019h,02Dh,030h,039h,03Ch,04Eh,053h,05Dh,060h,071h,074h
    db 00Dh,009h,07Ah,00Ch,00Fh,017h,019h,02Dh,030h,039h,03Ch,04Fh,052h,0DCh,064h,071h
    db 074h,04Ah,005h,07Dh,086h,008h,093h,016h,018h,09Ah,02Bh,0C8h,04Eh,0D0h,051h,0D3h
    db 054h,0DCh,063h,0E5h,069h,0FBh,07Ch,008h,003h,07Eh,085h,008h,093h,01Bh,02Bh,048h
    db 0CEh,052h,054h,0E5h,06Ah,0FBh,07Dh,008h,002h,07Fh,083h,004h,08Dh,014h,09Ch,024h
    db 0A8h,02Ah,0C9h,04Dh,053h,06Bh,07Eh,009h,002h,07Fh,003h,00Ch,025h,027h,02Ah,049h
    db 052h,06Ch,07Eh,008h,001h,07Fh,002h,00Ch,026h,02Ah,049h,052h,06Dh,07Eh,008h,000h
    db 07Fh,001h,00Bh,026h,02Ah,049h,051h,06Dh,07Eh,008h,000h,07Fh,001h,00Ah,026h,02Ah
    db 049h,051h,06Dh,07Eh,008h,000h,07Fh,001h,00Ah,026h,02Ah,049h,051h,06Dh,07Eh,008h
    db 000h,07Fh,001h,00Ah,026h,02Ah,049h,050h,06Eh,07Eh,009h,000h,07Fh,001h,00Ah,026h
    db 02Ah,048h,050h,0E9h,06Bh,06Eh,07Eh,008h,000h,07Fh,001h,00Ah,026h,02Ah,048h,050h
    db 0ECh,06Dh,07Eh,008h,000h,07Fh,001h,00Ah,025h,02Ah,047h,050h,06Eh,07Eh,008h,000h
    db 07Fh,001h,00Ah,025h,02Bh,047h,050h,06Eh,07Eh,008h,000h,07Fh,001h,00Bh,025h,02Bh
    db 047h,050h,06Fh,07Eh,008h,000h,07Fh,001h,00Bh,025h,02Ch,047h,050h,070h,07Dh,008h
    db 000h,07Eh,001h,00Bh,025h,02Ch,047h,050h,070h,07Dh,008h,000h,07Eh,001h,00Bh,025h
    db 02Ch,047h,050h,070h,07Dh,008h,001h,07Eh,002h,00Ch,025h,02Ch,046h,051h,0EEh,06Fh
    db 07Dh,008h,001h,07Eh,002h,00Dh,024h,02Ch,046h,051h,06Dh,07Dh,008h,002h,07Dh,003h
    db 00Eh,024h,02Ch,046h,051h,06Ch,07Ch,008h,002h,07Dh,003h,00Eh,024h,02Dh,046h,051h
    db 06Ch,07Ch,008h,002h,07Dh,003h,00Fh,023h,02Eh,046h,051h,06Bh,07Ch,008h,003h,07Ch
    db 084h,006h,00Fh,023h,02Fh,046h,052h,06Ah,07Bh,008h,004h,07Bh,007h,00Fh,022h,02Fh
    db 045h,052h,069h,07Ah,008h,007h,07Ah,008h,010h,022h,030h,044h,0D3h,054h,0E9h,06Ah
    db 079h,008h,008h,07Ah,009h,011h,0A1h,023h,031h,0D5h,056h,068h,0EBh,06Ch,079h,00Ah
    db 008h,079h,009h,091h,014h,09Fh,020h,024h,032h,043h,057h,067h,06Dh,078h,00Bh,009h
    db 078h,08Ah,00Bh,08Eh,010h,095h,016h,01Eh,025h,033h,043h,057h,066h,0EEh,06Fh,0F6h
    db 077h,081h,00Ah,010h,08Ch,00Dh,008h,015h,077h,097h,018h,09Ch,01Dh,025h,0B4h,037h
    db 0C1h,043h,0D8h,05Dh,0E2h,065h,0F0h,075h,080h,00Ch,00Dh,006h,017h,075h,099h,01Bh
    db 026h,0B8h,040h,0C4h,046h,0DEh,061h,073h,084h,019h,040h,01Ah,0A4h,025h,0A7h,028h
    db 03Bh,003h,044h,074h,0C7h,049h,060h,0F1h,073h,084h,019h,03Bh,01Ah,0A2h,023h,0A9h
    db 02Ah,0B9h,03Ah,003h,047h,073h,04Ah,0DEh,05Fh,0EFh,071h,082h,01Ah,023h,09Bh,01Ch
    db 021h,082h,029h,03Ah,02Bh,0B7h,038h,004h,04Ah,071h,04Bh,0D9h,05Dh,060h,0EDh,06Eh
    db 0C1h,01Bh,021h,01Ch,082h,02Bh,038h,02Ch,0B4h,036h,082h,04Bh,05Dh,04Ch,058h,041h
    db 060h,06Eh,06Dh,080h,01Dh,020h,0C1h,02Ch,036h,0B4h,035h,0C0h,04Ch,058h,000h,061h
    db 06Bh,080h,02Dh,033h,000h,04Dh,057h
LA20F:
    ; db[373]
    db 01Dh,043h,021h,056h,0A3h,025h,0BBh,03Dh,0D4h,055h,049h,019h,066h,09Bh,01Eh,0A0h
    db 021h,024h,034h,03Ch,0BEh,04Eh,055h,0DBh,060h,0E2h,064h,00Eh,01Ah,065h,01Bh,01Eh
    db 023h,025h,033h,035h,03Bh,03Dh,049h,04Dh,054h,056h,062h,064h,00Dh,017h,069h,01Bh
    db 01Eh,023h,025h,033h,035h,03Bh,03Dh,04Ah,04Ch,0D3h,058h,062h,064h,045h,015h,06Ah
    db 016h,0A7h,030h,0C6h,049h,04Dh,0D4h,058h,008h,014h,06Bh,095h,016h,01Ch,0A7h,02Ch
    db 0AFh,030h,0C6h,049h,04Dh,05Eh,06Ah,008h,013h,06Bh,094h,015h,01Bh,0ADh,02Eh,030h
    db 046h,04Ch,05Fh,06Ah,008h,013h,06Ch,014h,01Bh,02Eh,030h,046h,04Ch,05Fh,06Bh,008h
    db 013h,06Ch,014h,01Ah,02Eh,030h,046h,04Ch,05Fh,06Bh,008h,013h,06Ch,014h,01Ah,02Eh
    db 030h,046h,04Bh,060h,06Bh,009h,013h,06Ch,014h,01Ah,02Eh,030h,045h,04Bh,0DDh,05Eh
    db 060h,06Bh,008h,013h,06Ch,014h,01Ah,02Dh,030h,045h,04Bh,0DFh,060h,06Bh,008h,013h
    db 06Ch,014h,01Ah,02Dh,031h,045h,04Bh,060h,06Bh,008h,013h,06Ch,014h,01Bh,02Dh,031h
    db 045h,04Bh,061h,06Bh,008h,013h,06Ch,014h,01Bh,02Dh,032h,045h,04Bh,061h,06Bh,008h
    db 013h,06Ch,014h,01Bh,02Dh,032h,044h,04Bh,060h,06Bh,008h,013h,06Ch,014h,01Ch,02Ch
    db 032h,044h,04Ch,05Fh,06Bh,008h,014h,06Bh,015h,01Dh,02Ch,032h,044h,04Ch,05Fh,06Ah
    db 008h,014h,06Bh,015h,01Dh,02Ch,033h,044h,04Ch,05Eh,06Ah,008h,015h,06Ah,096h,017h
    db 01Eh,02Ch,034h,044h,04Ch,05Dh,069h,008h,016h,069h,018h,01Eh,02Bh,034h,043h,0CDh
    db 04Eh,05Dh,068h,008h,018h,068h,019h,01Fh,0AAh,02Bh,035h,042h,04Fh,05Ch,05Eh,00Ah
    db 019h,068h,01Ah,09Dh,022h,0A8h,029h,02Ch,036h,042h,050h,05Bh,0DFh,060h,0E6h,067h
    db 009h,01Ah,067h,09Bh,01Ch,0A3h,024h,027h,02Dh,0B7h,039h,0C1h,042h,0D1h,054h,0D8h
    db 05Ah,0E1h,065h,080h,01Bh,01Ch,006h,023h,065h,0A5h,026h,02Eh,0BAh,040h,0C3h,044h
    db 0D5h,057h,064h,083h,025h,040h,026h,0ABh,030h,0BBh,03Ch,003h,043h,064h,0C5h,047h
    db 056h,0E1h,063h,083h,026h,03Ch,0A7h,02Ah,031h,03Ah,003h,045h,063h,048h,0D1h,056h
    db 060h,080h,027h,02Ah,0C0h,031h,03Ah,041h,048h,060h,0D1h,056h,080h,032h,039h,080h
    db 049h,050h,000h,057h,05Fh
LA384:
    ; db[242]
    db 015h,041h,02Ch,050h,03Dh,049h,024h,05Bh,026h,0A8h,02Ah,02Ch,037h,03Dh,0BFh,044h
    db 050h,0D2h,057h,059h,00Dh,022h,05Ch,025h,027h,02Bh,02Dh,036h,038h,03Ch,03Eh,047h
    db 049h,0CEh,051h,058h,05Ah,044h,021h,05Dh,0AEh,034h,0C4h,046h,048h,0CEh,051h,006h
    db 020h,05Eh,021h,026h,0AEh,034h,0C4h,049h,055h,05Dh,007h,01Fh,05Fh,020h,025h,034h
    db 044h,048h,056h,05Eh,007h,01Fh,05Fh,020h,025h,034h,044h,048h,057h,05Eh,007h,01Fh
    db 05Fh,020h,025h,034h,043h,048h,057h,05Eh,007h,01Fh,05Fh,020h,025h,034h,043h,048h
    db 057h,05Eh,008h,01Fh,05Fh,020h,025h,033h,035h,043h,048h,057h,05Eh,008h,01Fh,05Fh
    db 020h,025h,032h,036h,043h,048h,057h,05Eh,008h,01Fh,05Fh,020h,026h,032h,036h,043h
    db 048h,057h,05Eh,008h,020h,05Fh,021h,027h,031h,036h,043h,048h,056h,05Eh,008h,020h
    db 05Fh,021h,027h,031h,036h,043h,049h,055h,05Eh,008h,021h,05Eh,0A2h,023h,027h,031h
    db 037h,042h,049h,054h,05Dh,008h,023h,05Dh,024h,028h,0B0h,031h,038h,041h,04Ah,0D4h
    db 055h,05Ch,008h,024h,05Ch,0A5h,02Ch,0AEh,02Fh,032h,0B9h,03Ah,041h,0CBh,04Eh,0D1h
    db 053h,0D6h,05Bh,006h,025h,05Bh,0ACh,02Dh,033h,0BBh,040h,042h,0CFh,050h,058h,083h
    db 02Ch,040h,02Dh,0B2h,034h,0BCh,03Dh,003h,042h,058h,0C3h,044h,04Eh,057h,0C2h,02Dh
    db 03Dh,0B2h,034h,03Ch,042h,043h,057h,044h,04Eh,080h,02Eh,031h,080h,035h,03Bh,000h
    db 045h,056h
LA476:
    ; db[201]
    db 013h,043h,02Dh,04Dh,02Eh,0BCh,03Dh,04Ch,045h,027h,055h,028h,0ADh,02Eh,0BCh,03Dh
    db 0CCh,04Dh,054h,000h,025h,058h,043h,024h,059h,0B0h,035h,043h,047h,007h,023h,05Ah
    db 024h,028h,0B0h,035h,043h,047h,0D2h,053h,059h,007h,022h,05Bh,023h,027h,035h,043h
    db 046h,054h,05Ah,007h,022h,05Bh,023h,027h,035h,042h,046h,054h,05Ah,007h,022h,05Bh
    db 023h,027h,035h,042h,046h,054h,05Ah,008h,022h,05Bh,023h,028h,034h,036h,042h,046h
    db 054h,05Ah,008h,022h,05Bh,023h,028h,033h,037h,042h,046h,054h,05Ah,008h,023h,05Bh
    db 024h,028h,033h,037h,042h,046h,054h,05Ah,008h,023h,05Bh,024h,029h,032h,037h,042h
    db 047h,0D2h,053h,05Ah,008h,024h,05Ah,0A5h,026h,029h,032h,037h,041h,047h,051h,059h
    db 007h,026h,059h,0A7h,02Ah,0B1h,032h,038h,040h,048h,0D1h,052h,058h,007h,027h,058h
    db 0ABh,030h,033h,0B9h,03Ah,040h,0C9h,04Ch,0CEh,050h,0D3h,057h,007h,02Bh,057h,02Eh
    db 034h,03Bh,0BEh,03Fh,041h,04Dh,054h,083h,02Eh,03Fh,02Fh,0B3h,035h,0BCh,03Dh,002h
    db 041h,054h,0C2h,043h,04Ch,0C2h,02Fh,03Dh,0B3h,035h,03Ch,042h,042h,054h,043h,04Ch
    db 080h,030h,032h,080h,036h,03Bh,000h,044h,053h
LA53F:
    ; db[146]
    db 00Fh,042h,032h,04Ah,0BDh,03Eh,049h,045h,02Dh,050h,02Eh,032h,0BDh,03Eh,0C9h,04Ah
    db 04Fh,006h,02Dh,053h,02Fh,039h,041h,046h,04Dh,052h,007h,02Bh,054h,02Ch,02Eh,038h
    db 042h,045h,04Eh,053h,007h,02Ah,054h,02Bh,02Dh,038h,042h,044h,04Fh,053h,007h,02Ah
    db 054h,02Bh,02Dh,038h,042h,044h,04Fh,053h,008h,02Ah,054h,02Bh,02Eh,037h,039h,042h
    db 044h,04Fh,053h,008h,02Ah,054h,02Bh,02Eh,036h,039h,042h,044h,04Fh,053h,008h,02Bh
    db 054h,02Ch,0AEh,02Fh,036h,039h,042h,045h,04Eh,053h,008h,02Ch,053h,02Dh,02Fh,036h
    db 039h,041h,045h,04Dh,052h,006h,02Dh,052h,0AEh,030h,0B5h,036h,03Ah,040h,046h,0CDh
    db 051h,005h,02Eh,051h,0B0h,034h,037h,0BBh,03Ch,0BFh,041h,0C7h,04Ch,004h,030h,04Ch
    db 038h,0BDh,03Eh,042h,049h,0C1h,038h,03Eh,03Dh,040h,042h,049h,080h,039h,03Ch,000h
    db 043h,048h
LA5D1:
    ; db[97]
    db 00Ch,042h,035h,04Ah,03Dh,047h,002h,032h,04Eh,040h,04Dh,006h,031h,04Fh,032h,03Ah
    db 041h,044h,04Ah,04Eh,006h,030h,04Fh,031h,039h,041h,043h,04Bh,04Eh,006h,030h,04Fh
    db 031h,039h,041h,043h,04Bh,04Eh,006h,031h,04Fh,032h,039h,041h,043h,04Bh,04Eh,007h
    db 031h,04Fh,032h,038h,03Ah,041h,043h,04Ah,04Eh,007h,032h,04Eh,033h,038h,03Ah,040h
    db 044h,049h,04Dh,044h,033h,04Dh,038h,03Ah,0BDh,03Eh,0C1h,044h,004h,033h,04Ch,039h
    db 0BDh,03Eh,041h,046h,0C1h,039h,03Eh,03Dh,040h,041h,046h,080h,03Ah,03Ch,000h,042h
    db 045h
LA632:
    ; db[69]
    db 00Ah,041h,037h,047h,03Fh,000h,034h,04Bh,004h,033h,04Bh,034h,03Bh,043h,04Ah,004h
    db 033h,04Bh,034h,03Bh,043h,04Ah,004h,034h,04Ah,035h,03Bh,043h,049h,006h,034h,04Ah
    db 035h,03Ah,03Ch,0C1h,042h,044h,049h,043h,035h,049h,0BAh,03Ch,0BEh,03Fh,0C1h,044h
    db 004h,036h,048h,03Bh,0BEh,03Fh,041h,045h,0C1h,03Bh,03Fh,03Eh,040h,041h,045h,080h
    db 03Ch,03Dh,000h,042h,044h
LA677:
    ; db[51]
    db 008h,041h,039h,046h,040h,000h,037h,048h,004h,036h,049h,037h,03Ch,043h,048h,004h
    db 036h,048h,037h,03Ch,043h,047h,006h,036h,048h,037h,03Bh,03Dh,042h,044h,047h,043h
    db 037h,047h,0BCh,03Dh,0BFh,040h,0C2h,044h,044h,038h,046h,0B9h,03Bh,03Eh,041h,045h
    db 000h,03Ch,044h
TerrainHenge:
    ; db[367]
    db 017h,047h,01Ah,060h,09Eh,01Fh,0A5h,028h,0B0h,033h,0BCh,03Fh,0C7h,04Ah,0D2h,055h
    db 0DBh,05Ch,047h,01Ah,060h,09Eh,020h,0A5h,028h,0B0h,033h,0BCh,03Fh,0C7h,04Ah,0D2h
    db 055h,0DBh,05Ch,047h,01Ah,060h,09Eh,020h,0A5h,028h,0AFh,033h,0BCh,03Fh,0C7h,04Ah
    db 0D2h,055h,0DBh,05Ch,047h,01Ah,060h,09Eh,020h,0A4h,029h,0AFh,033h,0BCh,040h,0C7h
    db 04Ah,0D2h,056h,0DBh,05Dh,047h,01Ah,060h,09Eh,020h,0A5h,029h,0B0h,034h,0BBh,03Fh
    db 0C6h,04Ah,0D2h,055h,0DBh,05Ch,047h,01Ah,060h,09Eh,01Fh,0A5h,029h,0B0h,033h,0BBh
    db 03Fh,0C6h,04Bh,0D1h,055h,0DBh,05Dh,047h,01Ah,060h,09Dh,01Fh,0A5h,028h,0B0h,033h
    db 0BBh,03Fh,0C7h,04Ah,0D1h,055h,0DBh,05Ch,047h,01Ah,060h,09Dh,01Fh,0A5h,028h,0B0h
    db 033h,0BBh,03Fh,0C7h,04Ah,0D1h,055h,0DBh,05Ch,047h,01Ah,060h,09Dh,01Fh,0A5h,028h
    db 0B0h,033h,0BAh,040h,0C7h,04Ah,0D1h,056h,0DBh,05Ch,047h,01Ah,060h,09Dh,01Fh,0A5h
    db 028h,0B0h,033h,0BBh,040h,0C7h,04Ah,0D2h,056h,0DBh,05Ch,047h,01Ah,060h,09Dh,01Fh
    db 0A5h,028h,0B0h,034h,0BBh,040h,0C7h,04Bh,0D2h,056h,0DBh,05Ch,047h,01Ah,060h,09Eh
    db 01Fh,0A5h,028h,0B0h,034h,0BBh,03Fh,0C7h,04Ah,0D2h,056h,0DBh,05Ch,047h,01Ah,060h
    db 09Eh,01Fh,0A4h,028h,0B0h,034h,0BBh,03Fh,0C7h,04Bh,0D2h,056h,0DBh,05Ch,047h,01Ah
    db 060h,09Eh,01Fh,0A5h,028h,0AFh,033h,0BBh,03Fh,0C6h,04Ah,0D2h,055h,0DBh,05Dh,047h
    db 01Ah,060h,09Eh,01Fh,0A5h,028h,0B0h,033h,0BBh,03Fh,0C7h,04Ah,0D2h,055h,0DBh,05Ch
    db 047h,01Ah,060h,09Eh,01Fh,0A5h,028h,0B0h,033h,0BBh,03Fh,0C7h,04Ah,0D2h,055h,0DBh
    db 05Ch,008h,01Ah,060h,09Bh,01Ch,0A1h,023h,0AAh,02Eh,0B5h,039h,0C1h,045h,0CCh,050h
    db 0D7h,059h,0DEh,05Fh,000h,019h,061h,04Ch,019h,061h,09Bh,01Dh,0A1h,023h,0ABh,02Dh
    db 030h,033h,0B6h,038h,03Ch,0C2h,044h,0CDh,04Fh,054h,0D7h,059h,0DDh,05Fh,048h,019h
    db 061h,01Ch,022h,02Ch,037h,043h,04Eh,058h,05Eh,048h,019h,061h,01Ch,022h,02Ch,037h
    db 043h,04Eh,058h,05Eh,04Ch,019h,061h,09Bh,01Dh,0A1h,023h,026h,0ABh,02Dh,0B6h,038h
    db 0BDh,03Eh,0C2h,044h,047h,0CDh,04Fh,052h,0D7h,059h,0DDh,05Fh,000h,019h,061h
LA819:
    ; db[222]
    db 010h,047h,025h,056h,0A8h,029h,0ADh,02Fh,0B5h,037h,0BDh,03Fh,0C5h,047h,0CCh,04Fh
    db 053h,047h,025h,056h,0A8h,029h,0ADh,02Fh,0B5h,037h,0BDh,03Fh,0C5h,047h,0CCh,04Fh
    db 053h,047h,025h,056h,0A8h,029h,0ADh,030h,0B5h,037h,0BDh,03Fh,0C5h,047h,0CCh,04Fh
    db 053h,047h,025h,056h,0A8h,029h,0ADh,030h,0B5h,037h,0BCh,03Fh,0C4h,047h,0CCh,04Fh
    db 053h,047h,025h,056h,0A7h,029h,0ADh,030h,0B5h,037h,0BCh,03Fh,0C4h,047h,0CCh,04Fh
    db 053h,047h,025h,056h,0A7h,029h,0ADh,02Fh,0B5h,037h,0BCh,03Fh,0C5h,047h,0CCh,04Fh
    db 053h,047h,025h,056h,0A7h,029h,0ADh,02Fh,0B5h,037h,0BCh,040h,0C5h,047h,0CCh,04Fh
    db 053h,047h,025h,056h,0A7h,029h,0ADh,02Fh,0B5h,037h,0BCh,040h,0C5h,048h,0CCh,04Fh
    db 053h,047h,025h,056h,0A8h,029h,0ADh,02Fh,0B5h,037h,0BCh,03Fh,0C5h,048h,0CCh,04Fh
    db 053h,047h,025h,056h,0A8h,029h,0ADh,02Fh,0B5h,037h,0BCh,03Fh,0C5h,047h,0CCh,04Fh
    db 053h,047h,025h,056h,0A8h,029h,0ADh,02Fh,0B5h,037h,0BCh,03Fh,0C5h,047h,0CCh,04Fh
    db 053h,008h,025h,056h,026h,0AAh,02Bh,0B1h,033h,0B8h,03Bh,0C1h,043h,0C9h,04Bh,0D0h
    db 052h,055h,000h,025h,057h,048h,025h,057h,027h,02Bh,032h,03Ah,042h,04Ah,051h,055h
    db 048h,025h,057h,027h,02Bh,032h,03Ah,042h,04Ah,051h,055h,000h,025h,057h
LA8F7:
    ; db[157]
    db 00Ch,047h,02Ch,04Fh,02Fh,0B2h,034h,0B8h,039h,0BEh,03Fh,0C3h,045h,0C9h,04Ah,04Dh
    db 047h,02Ch,04Fh,02Fh,0B2h,034h,0B8h,039h,0BEh,03Fh,0C3h,045h,0C9h,04Ah,04Dh,047h
    db 02Ch,04Fh,02Fh,0B2h,034h,0B8h,039h,0BDh,03Fh,0C3h,045h,0C9h,04Ah,04Dh,047h,02Ch
    db 04Fh,0AEh,02Fh,0B2h,034h,0B8h,039h,0BDh,03Fh,0C3h,045h,0C9h,04Ah,04Dh,047h,02Ch
    db 04Fh,0AEh,02Fh,0B2h,034h,0B8h,039h,0BDh,03Fh,0C3h,045h,0C9h,04Ah,04Dh,047h,02Ch
    db 04Fh,0AEh,02Fh,0B2h,034h,0B8h,039h,0BDh,03Fh,0C3h,045h,0C9h,04Ah,04Dh,047h,02Ch
    db 04Fh,02Fh,0B2h,034h,0B8h,039h,0BDh,03Fh,0C3h,045h,0C9h,04Ah,04Dh,047h,02Ch,04Fh
    db 02Fh,0B2h,034h,0B8h,039h,0BDh,03Fh,0C3h,045h,0C9h,04Ah,04Dh,008h,02Ch,04Fh,02Dh
    db 0B0h,031h,0B5h,036h,0BAh,03Ch,0C0h,042h,0C6h,048h,0CBh,04Ch,04Eh,000h,02Ch,04Fh
    db 047h,02Ch,04Fh,02Eh,031h,036h,03Bh,041h,047h,04Ch,000h,02Ch,04Fh
LA994:
    ; db[136]
    db 00Bh,047h,02Eh,04Dh,030h,0B3h,034h,0B8h,039h,0BDh,03Eh,0C2h,043h,0C7h,048h,04Bh
    db 047h,02Eh,04Dh,030h,0B3h,034h,0B8h,039h,0BDh,03Eh,0C2h,043h,0C7h,048h,04Bh,047h
    db 02Eh,04Dh,030h,0B3h,034h,0B8h,039h,0BDh,03Eh,0C2h,043h,0C7h,048h,04Bh,047h,02Eh
    db 04Dh,030h,0B3h,034h,0B8h,039h,0BDh,03Eh,0C2h,043h,0C7h,048h,04Bh,047h,02Eh,04Dh
    db 030h,0B3h,034h,0B8h,039h,0BDh,03Eh,0C2h,043h,0C7h,048h,04Bh,047h,02Eh,04Dh,030h
    db 0B3h,034h,0B8h,039h,0BDh,03Eh,0C2h,043h,0C7h,048h,04Bh,047h,02Eh,04Dh,030h,0B3h
    db 034h,0B8h,039h,0BDh,03Eh,0C2h,043h,0C7h,048h,04Bh,047h,02Eh,04Dh,030h,0B3h,034h
    db 0B8h,039h,0BDh,03Eh,0C2h,043h,0C7h,048h,04Bh,000h,02Eh,04Dh,046h,02Eh,04Dh,032h
    db 037h,03Bh,040h,045h,04Ah,000h,02Eh,04Dh
LAA1C:
    ; db[82]
    db 009h,047h,033h,04Ah,035h,038h,03Bh,0BEh,03Fh,042h,045h,048h,047h,033h,04Ah,035h
    db 038h,03Bh,0BEh,03Fh,042h,045h,048h,047h,033h,04Ah,035h,038h,03Bh,0BEh,03Fh,042h
    db 045h,048h,047h,033h,04Ah,035h,038h,03Bh,0BEh,03Fh,042h,045h,048h,047h,033h,04Ah
    db 035h,038h,03Bh,0BEh,03Fh,042h,045h,048h,047h,033h,04Ah,035h,038h,03Bh,0BEh,03Fh
    db 042h,045h,048h,000h,033h,04Ah,046h,033h,04Ah,036h,039h,03Ch,040h,044h,048h,000h
    db 033h,04Ah
LAA6E:
    ; db[54]
    db 007h,008h,036h,047h,037h,039h,03Bh,03Dh,040h,042h,044h,046h,008h,036h,047h,037h
    db 039h,03Bh,03Dh,040h,042h,044h,046h,008h,036h,047h,037h,039h,03Bh,03Dh,040h,042h
    db 044h,046h,008h,036h,047h,037h,039h,03Bh,03Dh,040h,042h,044h,046h,000h,036h,047h
    db 040h,036h,047h,000h,036h,047h
LAAA4:
    ; db[37]
    db 006h,046h,038h,046h,03Ah,03Ch,03Eh,040h,042h,044h,046h,038h,046h,03Ah,03Ch,03Eh
    db 040h,042h,044h,046h,038h,046h,03Ah,03Ch,03Eh,040h,042h,044h,000h,038h,046h,040h
    db 038h,046h,000h,038h,046h
LAAC9:
    ; db[24]
    db 005h,044h,03Ah,044h,03Ch,03Eh,040h,042h,044h,03Ah,044h,03Ch,03Eh,040h,042h,000h
    db 03Ah,044h,040h,03Ah,044h,000h,03Ah,044h
TerrainTower:
    ; db[353]
    db 04Eh,040h,02Ch,060h,042h,02Dh,05Fh,0C2h,044h,0DDh,05Eh,041h,02Eh,05Ch,048h,043h
    db 02Eh,05Bh,0C0h,042h,049h,0D9h,05Ah,041h,02Fh,058h,0CAh,04Ch,044h,030h,057h,031h
    db 038h,0BEh,040h,0CDh,052h,0C2h,032h,04Fh,033h,037h,000h,053h,056h,042h,034h,04Eh
    db 0B5h,036h,0BCh,03Eh,040h,037h,04Dh,041h,038h,04Dh,0BBh,03Dh,040h,039h,04Ch,043h
    db 03Ah,04Bh,0BCh,03Eh,042h,04Ah,041h,03Bh,049h,0C3h,044h,002h,03Bh,048h,03Ch,0C0h
    db 044h,041h,03Bh,046h,0BDh,03Fh,041h,03Bh,046h,0BDh,03Fh,041h,03Bh,046h,0BDh,03Fh
    db 041h,03Bh,046h,0BDh,03Fh,041h,03Bh,046h,0BDh,03Fh,040h,03Bh,046h,040h,03Bh,046h
    db 040h,03Bh,046h,040h,03Bh,046h,040h,03Bh,046h,040h,03Bh,046h,040h,03Bh,046h,040h
    db 03Bh,046h,040h,03Bh,046h,040h,03Bh,046h,040h,03Bh,046h,040h,03Bh,046h,040h,03Bh
    db 046h,040h,03Bh,046h,040h,03Bh,046h,040h,03Bh,046h,040h,03Bh,046h,040h,03Bh,046h
    db 040h,03Bh,046h,040h,03Bh,046h,040h,03Bh,046h,040h,03Bh,046h,040h,03Bh,046h,040h
    db 03Bh,046h,040h,03Bh,046h,040h,03Bh,046h,040h,03Bh,046h,040h,03Bh,046h,040h,03Bh
    db 046h,040h,03Bh,046h,040h,03Bh,046h,040h,03Bh,046h,044h,03Bh,046h,03Dh,03Fh,042h
    db 044h,002h,03Bh,046h,03Eh,043h,000h,038h,049h,040h,038h,049h,040h,038h,049h,040h
    db 038h,049h,000h,035h,04Ch,040h,035h,04Ch,000h,035h,04Ch,046h,035h,04Ch,037h,03Ch
    db 03Eh,043h,045h,04Ah,046h,035h,04Ch,037h,03Ch,03Eh,043h,045h,04Ah,046h,035h,04Ch
    db 037h,03Ch,03Eh,043h,045h,04Ah,046h,035h,04Ch,037h,03Ch,03Eh,043h,045h,04Ah,046h
    db 035h,04Ch,037h,03Ch,03Eh,043h,045h,04Ah,046h,035h,04Ch,037h,03Ch,03Eh,043h,045h
    db 04Ah,046h,035h,04Ch,037h,03Ch,03Eh,043h,045h,04Ah,046h,035h,04Ch,037h,03Ch,03Eh
    db 043h,045h,04Ah,003h,035h,04Ch,0B9h,03Ah,0C0h,041h,0C7h,048h,004h,035h,04Ch,0B6h
    db 037h,0BCh,03Eh,0C3h,045h,0CAh,04Bh,040h,035h,04Ch,040h,035h,04Ch,000h,035h,04Ch
    db 040h,03Ah,047h,040h,03Bh,046h,040h,03Ch,045h,042h,03Dh,044h,03Eh,043h,000h,03Fh
    db 042h
LAC42:
    ; db[235]
    db 037h,040h,032h,056h,043h,033h,055h,0C1h,043h,045h,0D3h,054h,042h,033h,052h,0C0h
    db 041h,046h,041h,034h,051h,0C7h,048h,044h,035h,050h,036h,03Ah,0BEh,040h,0C9h,04Fh
    db 042h,037h,04Ah,0B8h,039h,0BDh,03Eh,041h,03Ah,049h,0BCh,03Eh,040h,03Bh,048h,002h
    db 03Ch,047h,0BFh,040h,0C3h,045h,002h,03Ch,045h,03Dh,0C0h,042h,041h,03Ch,044h,0BEh
    db 03Fh,041h,03Ch,044h,0BEh,03Fh,041h,03Ch,044h,0BEh,03Fh,041h,03Ch,044h,0BEh,03Fh
    db 040h,03Ch,044h,040h,03Ch,044h,040h,03Ch,044h,040h,03Ch,044h,040h,03Ch,044h,040h
    db 03Ch,044h,040h,03Ch,044h,040h,03Ch,044h,040h,03Ch,044h,040h,03Ch,044h,040h,03Ch
    db 044h,040h,03Ch,044h,040h,03Ch,044h,040h,03Ch,044h,040h,03Ch,044h,040h,03Ch,044h
    db 040h,03Ch,044h,040h,03Ch,044h,040h,03Ch,044h,040h,03Ch,044h,040h,03Ch,044h,040h
    db 03Ch,044h,040h,03Ch,044h,043h,03Ch,044h,03Eh,040h,042h,000h,03Ah,046h,040h,03Ah
    db 046h,040h,03Ah,046h,000h,039h,047h,044h,039h,047h,03Ch,03Eh,042h,044h,044h,039h
    db 047h,03Ch,03Eh,042h,044h,044h,039h,047h,03Ch,03Eh,042h,044h,044h,039h,047h,03Ch
    db 03Eh,042h,044h,044h,039h,047h,03Ch,03Eh,042h,044h,003h,039h,047h,03Ah,040h,046h
    db 002h,039h,047h,0BCh,03Eh,0C2h,044h,040h,039h,047h,000h,039h,047h,040h,03Bh,045h
    db 040h,03Ch,044h,042h,03Dh,043h,03Eh,042h,000h,03Fh,041h
LAD2D:
    ; db[159]
    db 028h,040h,036h,04Fh,043h,036h,04Eh,0C0h,041h,044h,04Dh,041h,037h,04Ch,0C5h,047h
    db 042h,038h,04Bh,0BEh,040h,0C8h,04Ah,043h,039h,047h,0BAh,03Bh,0BDh,03Eh,046h,041h
    db 03Ch,045h,041h,002h,03Dh,044h,03Eh,0C0h,041h,041h,03Dh,043h,03Fh,041h,03Dh,043h
    db 03Fh,041h,03Dh,043h,03Fh,040h,03Dh,043h,040h,03Dh,043h,040h,03Dh,043h,040h,03Dh
    db 043h,040h,03Dh,043h,040h,03Dh,043h,040h,03Dh,043h,040h,03Dh,043h,040h,03Dh,043h
    db 040h,03Dh,043h,040h,03Dh,043h,040h,03Dh,043h,040h,03Dh,043h,040h,03Dh,043h,040h
    db 03Dh,043h,040h,03Dh,043h,040h,03Dh,043h,000h,03Ch,044h,040h,03Ch,044h,000h,03Bh
    db 045h,044h,03Bh,045h,03Dh,03Fh,041h,043h,044h,03Bh,045h,03Dh,03Fh,041h,043h,044h
    db 03Bh,045h,03Dh,03Fh,041h,043h,044h,03Bh,045h,03Dh,03Fh,041h,043h,000h,03Bh,045h
    db 040h,03Bh,045h,000h,03Bh,045h,040h,03Dh,043h,040h,03Eh,042h,000h,03Fh,041h
LADCC:
    ; db[130]
    db 023h,040h,037h,04Dh,043h,038h,04Ch,0BFh,040h,043h,04Bh,041h,039h,04Ah,0C4h,045h
    db 042h,03Ah,049h,0BEh,03Fh,0C6h,048h,043h,03Bh,045h,03Ch,040h,044h,001h,03Dh,043h
    db 0BFh,040h,041h,03Dh,042h,03Eh,041h,03Dh,042h,03Eh,041h,03Dh,042h,03Eh,040h,03Dh
    db 042h,040h,03Dh,042h,040h,03Dh,042h,040h,03Dh,042h,040h,03Dh,042h,040h,03Dh,042h
    db 040h,03Dh,042h,040h,03Dh,042h,040h,03Dh,042h,040h,03Dh,042h,040h,03Dh,042h,040h
    db 03Dh,042h,040h,03Dh,042h,040h,03Dh,042h,040h,03Dh,042h,000h,03Ch,043h,040h,03Ch
    db 043h,000h,03Bh,044h,042h,03Bh,044h,03Eh,041h,042h,03Bh,044h,03Eh,041h,042h,03Bh
    db 044h,03Eh,041h,000h,03Bh,044h,040h,03Bh,044h,000h,03Bh,044h,040h,03Dh,042h,000h
    db 03Eh,041h
LAE4E:
    ; db[99]
    db 01Bh,040h,039h,049h,043h,03Ah,048h,0BFh,040h,042h,047h,041h,03Bh,046h,0C3h,045h
    db 042h,03Ch,044h,03Dh,040h,001h,03Eh,043h,040h,041h,03Eh,042h,03Fh,041h,03Eh,042h
    db 03Fh,040h,03Eh,042h,040h,03Eh,042h,040h,03Eh,042h,040h,03Eh,042h,040h,03Eh,042h
    db 040h,03Eh,042h,040h,03Eh,042h,040h,03Eh,042h,040h,03Eh,042h,040h,03Eh,042h,040h
    db 03Eh,042h,000h,03Eh,042h,040h,03Eh,042h,000h,03Dh,043h,042h,03Dh,043h,03Fh,041h
    db 042h,03Dh,043h,03Fh,041h,042h,03Dh,043h,03Fh,041h,000h,03Dh,043h,040h,03Eh,042h
    db 000h,03Fh,041h
LAEB1:
    ; db[71]
    db 015h,040h,03Ah,046h,041h,03Bh,045h,041h,042h,03Ch,044h,03Dh,0C2h,043h,001h,03Eh
    db 041h,040h,001h,03Eh,041h,040h,001h,03Eh,041h,040h,040h,03Eh,041h,040h,03Eh,041h
    db 040h,03Eh,041h,040h,03Eh,041h,040h,03Eh,041h,040h,03Eh,041h,040h,03Eh,041h,040h
    db 03Eh,041h,040h,03Eh,041h,000h,03Dh,042h,040h,03Dh,042h,040h,03Dh,042h,000h,03Dh
    db 042h,040h,03Eh,041h,000h,03Fh,040h
LAEF8:
    ; db[55]
    db 011h,040h,03Ch,045h,042h,03Dh,044h,040h,043h,041h,03Eh,042h,041h,040h,03Fh,041h
    db 040h,03Fh,041h,040h,03Fh,041h,040h,03Fh,041h,040h,03Fh,041h,040h,03Fh,041h,040h
    db 03Fh,041h,040h,03Fh,041h,040h,03Fh,041h,000h,03Eh,042h,040h,03Eh,042h,000h,03Eh
    db 042h,040h,03Fh,041h,040h,040h,040h
LAF2F:
    ; db[44]
    db 00Eh,040h,03Dh,044h,040h,03Eh,043h,001h,03Fh,042h,040h,040h,03Fh,041h,040h,03Fh
    db 041h,040h,03Fh,041h,040h,03Fh,041h,040h,03Fh,041h,040h,03Fh,041h,000h,03Eh,042h
    db 040h,03Eh,042h,000h,03Eh,042h,040h,03Fh,041h,040h,040h,040h
TerrainVillage:
    ; db[240]
    db 013h,046h,00Fh,04Ch,012h,09Fh,020h,02Fh,039h,0BDh,03Eh,042h,046h,00Fh,04Ch,012h
    db 09Fh,020h,02Fh,039h,0BDh,03Eh,042h,04Bh,00Fh,060h,012h,014h,09Fh,020h,025h,02Ah
    db 02Fh,039h,0BDh,03Eh,042h,049h,0CCh,05Fh,04Bh,00Fh,060h,012h,014h,09Fh,020h,025h
    db 02Ah,02Fh,039h,042h,049h,04Ch,0D0h,052h,046h,00Fh,060h,012h,0AFh,039h,042h,04Ch
    db 0D0h,052h,0D8h,059h,008h,00Fh,060h,010h,0B1h,038h,0BAh,041h,0C3h,045h,0C7h,04Bh
    db 0CDh,04Fh,0D3h,057h,0DAh,05Fh,04Bh,00Fh,060h,011h,030h,0B3h,035h,0B9h,042h,046h
    db 04Ch,04Eh,054h,056h,05Bh,05Dh,00Bh,00Fh,060h,010h,0B1h,032h,0B6h,039h,0BBh,042h
    db 0C4h,04Ah,04Dh,0D0h,052h,055h,0D8h,059h,05Ch,05Fh,045h,00Fh,061h,011h,030h,0BBh
    db 03Eh,044h,0CAh,060h,004h,00Fh,061h,010h,0BDh,042h,0C6h,048h,0CAh,060h,04Ah,00Fh
    db 061h,011h,030h,034h,036h,039h,03Dh,046h,0C8h,04Ch,0D0h,05Ah,0DDh,060h,006h,00Fh
    db 061h,010h,0B1h,033h,035h,0B7h,038h,0BAh,03Ch,0C8h,060h,0C0h,00Fh,012h,048h,01Fh
    db 061h,028h,02Eh,036h,03Dh,043h,0CAh,04Eh,057h,0DAh,060h,080h,00Fh,012h,045h,020h
    db 061h,027h,0ADh,02Eh,036h,043h,0D0h,053h,0C1h,021h,02Ch,026h,003h,02Eh,061h,0AFh
    db 03Ch,0BEh,042h,0D1h,052h,0C2h,022h,02Ch,025h,02Bh,0C0h,02Eh,047h,040h,050h,053h
    db 081h,023h,02Ch,02Bh,080h,02Eh,047h,000h,050h,053h,040h,029h,02Ch,000h,029h,02Ch
LB04B:
    ; db[149]
    db 00Eh,046h,01Eh,048h,020h,029h,034h,03Bh,03Eh,041h,04Bh,01Eh,056h,020h,022h,029h
    db 02Dh,030h,034h,03Bh,03Eh,041h,046h,0C8h,055h,04Bh,01Eh,056h,020h,022h,029h,02Dh
    db 030h,034h,03Bh,041h,046h,048h,0CBh,04Ch,046h,01Eh,056h,020h,0B4h,03Bh,041h,048h
    db 0CBh,04Ch,051h,007h,01Eh,056h,01Fh,0B6h,03Ah,0C2h,043h,0C5h,047h,0C9h,04Ah,0CDh
    db 050h,0D2h,055h,046h,01Eh,056h,020h,035h,038h,03Ch,042h,047h,003h,01Eh,057h,01Fh
    db 0BEh,042h,0C4h,045h,047h,01Eh,057h,020h,035h,037h,039h,03Bh,03Eh,0C4h,045h,009h
    db 01Eh,057h,01Fh,036h,038h,03Ah,0BCh,03Eh,0C5h,046h,0CBh,04Fh,052h,0D4h,056h,080h
    db 01Eh,020h,045h,029h,057h,02Eh,0B3h,034h,039h,042h,0CBh,04Dh,0C1h,02Ah,032h,02Dh
    db 002h,034h,057h,0B5h,042h,04Ch,080h,02Bh,032h,080h,034h,045h,000h,04Bh,04Dh,040h
    db 030h,032h,000h,030h,032h
LB0E0:
    ; db[94]
    db 00Ah,046h,028h,045h,02Ah,02Fh,037h,03Ch,03Eh,040h,00Ah,028h,04Fh,029h,02Bh,0ADh
    db 02Eh,0B0h,031h,033h,0B5h,036h,0B8h,03Bh,03Dh,03Fh,0C1h,044h,045h,028h,04Fh,02Ah
    db 0B7h,03Ch,040h,045h,048h,005h,028h,04Fh,029h,0B9h,03Bh,0C1h,044h,0C6h,04Bh,0CDh
    db 04Eh,045h,028h,050h,02Ah,0B8h,03Bh,03Dh,041h,0C5h,04Fh,045h,028h,050h,02Ah,038h
    db 03Eh,042h,044h,002h,028h,050h,0B9h,03Eh,0C4h,04Fh,044h,030h,050h,032h,037h,0C3h
    db 047h,0CAh,04Fh,081h,031h,043h,0B5h,036h,000h,048h,049h,000h,034h,036h
LB13E:
    ; db[83]
    db 009h,045h,02Ah,044h,02Ch,030h,037h,03Ch,03Fh,009h,02Ah,04Dh,02Bh,02Dh,02Fh,0B1h
    db 032h,034h,036h,0B8h,03Bh,0BDh,03Eh,0C0h,043h,045h,02Ah,04Dh,02Ch,0B7h,03Ch,03Fh
    db 044h,046h,005h,02Ah,04Dh,02Bh,0B8h,03Bh,0C0h,043h,0C5h,049h,0CBh,04Ch,005h,02Ah
    db 04Dh,02Bh,0ADh,037h,03Ch,0BEh,03Fh,0C1h,042h,002h,02Ah,04Dh,0B9h,03Dh,0C3h,04Ch
    db 044h,031h,04Dh,033h,037h,0C2h,045h,0C8h,04Ch,081h,032h,042h,036h,000h,046h,047h
    db 000h,035h,037h
LB191:
    ; db[48]
    db 007h,044h,030h,043h,034h,039h,03Dh,03Fh,044h,030h,04Ah,039h,03Dh,03Fh,0C3h,049h
    db 002h,030h,04Ah,0C0h,042h,0C4h,049h,044h,030h,04Ah,03Ah,03Eh,040h,0C2h,049h,044h
    db 030h,04Ah,0B1h,035h,0B7h,03Ah,03Fh,041h,001h,035h,04Ah,0B8h,039h,000h,038h,039h
LB1C1:
    ; db[37]
    db 006h,044h,033h,042h,036h,03Ah,03Dh,03Fh,003h,033h,047h,0BBh,03Ch,03Eh,0C0h,041h
    db 042h,033h,047h,0BAh,040h,042h,044h,033h,047h,0B4h,036h,03Ah,03Eh,041h,001h,037h
    db 047h,03Ah,000h,039h,03Ah
LB1E6:
    ; db[22]
    db 004h,042h,036h,042h,03Bh,03Eh,002h,036h,046h,0BCh,03Dh,0BFh,041h,043h,036h,046h
    db 03Bh,03Fh,041h,000h,036h,046h
LB1FC:
    ; db[15]
    db 003h,042h,038h,042h,03Ch,03Fh,043h,038h,045h,03Ch,03Fh,042h,000h,038h,045h
TerrainDowns:
    ; db[198]
    db 016h,042h,000h,07Fh,0A0h,023h,0FDh,07Eh,043h,001h,07Ch,0A4h,025h,0E1h,063h,0F8h
    db 07Bh,043h,002h,077h,0A6h,028h,0DFh,060h,0F3h,076h,043h,003h,072h,0A9h,02Bh,0DCh
    db 05Eh,0EFh,071h,043h,004h,06Eh,0ACh,02Eh,0D9h,05Bh,0ECh,06Dh,043h,005h,06Bh,0AFh
    db 030h,0D7h,058h,0E9h,06Ah,043h,006h,068h,0B1h,032h,0D0h,056h,0E5h,067h,044h,007h
    db 064h,0B3h,035h,0CDh,04Fh,054h,0E2h,063h,043h,008h,061h,0B6h,037h,053h,060h,043h
    db 009h,05Fh,00Ah,0B8h,039h,052h,044h,00Bh,05Eh,08Ch,00Dh,03Ah,051h,05Dh,044h,00Ch
    db 05Ch,08Eh,010h,03Bh,0CEh,050h,0DAh,05Bh,044h,00Dh,059h,091h,014h,03Ch,0CCh,04Dh
    db 058h,044h,00Eh,057h,0B9h,03Bh,03Dh,0CAh,04Bh,056h,043h,00Fh,055h,0B6h,038h,0BEh
    db 03Fh,0C8h,049h,043h,010h,054h,011h,0B3h,035h,0C0h,047h,042h,012h,053h,0AFh,032h
    db 0D1h,052h,0C2h,013h,02Eh,014h,02Dh,042h,033h,050h,0B4h,036h,0CEh,04Fh,0C2h,015h
    db 02Ch,096h,017h,02Bh,041h,037h,04Dh,0CBh,04Ch,0C1h,018h,02Ah,029h,042h,038h,04Ah
    db 0B9h,03Ah,0C8h,049h,0C2h,019h,028h,09Ah,01Bh,0A4h,027h,001h,03Bh,047h,0BEh,042h
    db 080h,01Ch,023h,000h,03Eh,042h
LB2D1:
    ; db[139]
    db 010h,042h,013h,06Ch,0A9h,02Ch,06Bh,043h,014h,06Ah,0ADh,02Fh,0D6h,058h,0E4h,069h
    db 043h,015h,063h,0B0h,031h,0D3h,055h,0E1h,062h,043h,016h,060h,0B2h,033h,0D1h,052h
    db 05Fh,043h,017h,05Eh,0B4h,036h,0CBh,050h,0DAh,05Dh,044h,018h,059h,0B7h,038h,0C9h
    db 04Ah,04Eh,058h,044h,019h,057h,01Ah,0B9h,03Bh,04Dh,056h,044h,01Bh,055h,09Ch,01Eh
    db 03Ch,04Ch,054h,044h,01Ch,053h,09Fh,021h,03Dh,0C8h,04Bh,0D1h,052h,043h,01Dh,050h
    db 0BBh,03Ch,03Eh,047h,043h,01Eh,04Fh,0B9h,03Ah,03Fh,0C5h,046h,044h,01Fh,04Eh,020h
    db 0B4h,038h,0C0h,044h,0CCh,04Dh,0C0h,021h,033h,041h,039h,04Bh,04Ah,0C2h,022h,032h
    db 0A3h,024h,0B0h,031h,042h,03Ah,049h,03Bh,0C6h,048h,0C2h,025h,02Fh,026h,0ADh,02Eh
    db 001h,03Ch,045h,0BEh,041h,080h,027h,02Ch,000h,03Eh,041h
LB35C:
    ; db[99]
    db 00Ch,042h,020h,05Fh,0AFh,031h,05Eh,043h,021h,05Dh,0B2h,035h,0CEh,051h,0D7h,05Ch
    db 042h,022h,056h,036h,0CCh,04Dh,043h,022h,055h,0B7h,038h,0C7h,04Bh,0D2h,054h,045h
    db 023h,051h,024h,0B9h,03Ch,046h,049h,0CFh,050h,042h,025h,04Eh,03Dh,048h,044h,026h
    db 04Dh,03Ch,03Eh,0C5h,047h,0CBh,04Ch,043h,027h,04Ah,03Bh,03Fh,0C3h,044h,044h,028h
    db 049h,029h,0B7h,03Ah,0C0h,042h,048h,0C2h,02Ah,036h,02Bh,035h,042h,03Bh,047h,03Ch
    db 0C4h,046h,0C2h,02Ch,034h,02Dh,0B2h,033h,041h,03Dh,043h,0C1h,042h,080h,02Eh,031h
    db 000h,03Eh,040h
LB3BF:
    ; db[90]
    db 00Bh,042h,023h,05Bh,0B0h,032h,05Ah,043h,024h,059h,0B3h,036h,0CCh,04Eh,0D4h,058h
    db 042h,025h,053h,037h,0CAh,04Bh,043h,026h,052h,038h,0C8h,049h,0CFh,051h,043h,027h
    db 04Eh,0B9h,03Bh,0C6h,047h,0CCh,04Dh,043h,028h,04Bh,0BCh,03Dh,0C4h,045h,0C9h,04Ah
    db 043h,029h,048h,03Bh,03Eh,0C2h,043h,044h,02Ah,047h,02Bh,0B7h,03Ah,0BFh,041h,046h
    db 0C1h,02Ch,036h,02Dh,042h,03Bh,045h,03Ch,0C3h,044h,081h,02Eh,035h,0B0h,032h,001h
    db 03Dh,042h,0BEh,03Fh,080h,030h,032h,000h,03Eh,03Fh
LB419:
    ; db[68]
    db 009h,041h,02Ah,054h,0B4h,035h,043h,02Bh,053h,0B6h,038h,0C9h,04Ah,0CFh,052h,043h
    db 02Ch,04Eh,0B9h,03Ah,0C6h,048h,0CCh,04Dh,043h,02Dh,04Bh,0BBh,03Ch,045h,0C9h,04Ah
    db 043h,02Eh,048h,0BDh,03Eh,0C2h,044h,047h,044h,02Fh,046h,030h,0B9h,03Ch,0BFh,041h
    db 045h,0C1h,031h,038h,032h,041h,03Dh,044h,0C2h,043h,0C1h,033h,037h,036h,000h,03Eh
    db 041h,000h,034h,035h
LB45D:
    ; db[48]
    db 007h,041h,02Fh,04Fh,0B6h,037h,043h,030h,04Eh,0B8h,039h,0C2h,044h,0CBh,04Dh,043h
    db 031h,04Ah,0BAh,03Ch,0C0h,041h,0C6h,049h,042h,032h,045h,0BDh,03Fh,0C3h,044h,042h
    db 033h,042h,0BAh,03Ch,041h,081h,034h,039h,0B6h,037h,000h,03Dh,040h,000h,036h,037h
LB48D:
    ; db[37]
    db 006h,041h,033h,04Bh,0B8h,039h,043h,034h,04Ah,0BAh,03Bh,041h,0C8h,049h,043h,035h
    db 047h,03Ch,0BEh,040h,0C3h,046h,042h,036h,042h,0BBh,03Dh,041h,0C0h,037h,03Ah,000h
    db 03Eh,040h,000h,038h,039h
LB4B2:
    ; db[21]
    db 004h,042h,036h,04Ah,03Ah,0C7h,049h,042h,037h,046h,03Bh,0C1h,045h,001h,038h,040h
    db 0B9h,03Bh,000h,039h,03Bh
TerrainKeep:
    ; db[263]
    db 022h,043h,027h,05Bh,02Eh,03Ch,048h,044h,028h,05Bh,02Fh,032h,0BCh,048h,054h,046h
    db 029h,05Ah,0ADh,02Eh,0B0h,031h,03Dh,047h,0D2h,053h,059h,044h,02Ah,058h,0ABh,02Ch
    db 0BDh,047h,051h,0D4h,057h,043h,02Ch,056h,03Dh,0C0h,044h,047h,043h,02Ch,056h,03Dh
    db 0C0h,044h,047h,043h,02Ch,056h,03Dh,0C0h,044h,047h,043h,02Ch,056h,03Dh,0C0h,044h
    db 047h,043h,02Ch,056h,03Dh,0C0h,044h,047h,043h,02Ch,056h,03Dh,0C0h,044h,047h,042h
    db 02Ch,056h,0BCh,048h,04Bh,043h,02Ch,056h,03Ch,048h,04Bh,045h,02Ch,056h,031h,03Ch
    db 048h,04Bh,051h,045h,02Ch,056h,031h,038h,0BCh,048h,04Bh,051h,043h,02Ch,056h,031h
    db 038h,051h,043h,02Ch,056h,031h,038h,051h,041h,02Ch,056h,038h,040h,02Ch,056h,040h
    db 02Ch,056h,042h,02Ch,056h,0BDh,03Eh,0C6h,047h,042h,02Ch,056h,0BDh,03Eh,0C6h,047h
    db 042h,02Ch,056h,0BDh,03Eh,0C6h,047h,042h,02Ch,056h,0BDh,03Eh,0C6h,047h,040h,02Ch
    db 056h,040h,02Ch,056h,04Ah,02Ch,056h,02Fh,031h,036h,038h,040h,043h,04Bh,04Dh,052h
    db 054h,04Ah,02Ch,056h,02Fh,031h,036h,038h,040h,043h,04Bh,04Dh,052h,054h,04Ah,02Ch
    db 056h,0AEh,02Fh,0B1h,032h,0B5h,036h,0B8h,039h,0BFh,040h,0C3h,044h,0CAh,04Bh,0CDh
    db 04Eh,0D1h,052h,0D4h,055h,000h,02Ah,058h,040h,02Ah,058h,040h,02Ah,058h,040h,02Ah
    db 058h,007h,02Ah,058h,0ABh,02Dh,0B2h,034h,0B9h,03Bh,0C0h,042h,0C7h,049h,0CEh,050h
    db 0D5h,057h,080h,02Ah,02Eh,080h,031h,035h,080h,038h,03Ch,080h,03Fh,043h,080h,046h
    db 04Ah,080h,04Dh,051h,000h,054h,058h
LB5CE:
    ; db[196]
    db 018h,043h,02Eh,053h,032h,03Dh,046h,046h,02Fh,053h,030h,0B3h,034h,0BDh,03Eh,0C5h
    db 046h,04Dh,0D1h,052h,044h,030h,051h,0B1h,032h,0BEh,045h,04Ch,0CEh,050h,043h,032h
    db 04Fh,03Eh,0C0h,043h,045h,043h,032h,04Fh,03Eh,0C0h,043h,045h,043h,032h,04Fh,03Eh
    db 0C0h,043h,045h,043h,032h,04Fh,03Eh,0C0h,043h,045h,042h,032h,04Fh,0BDh,046h,048h
    db 044h,032h,04Fh,035h,03Dh,046h,048h,006h,032h,04Fh,0B3h,034h,0B6h,039h,0BBh,03Ch
    db 047h,0C9h,04Bh,0CDh,04Eh,043h,032h,04Fh,035h,03Ah,04Ch,042h,032h,04Fh,03Ah,04Ch
    db 040h,032h,04Fh,042h,032h,04Fh,0BDh,03Eh,0C4h,045h,042h,032h,04Fh,0BDh,03Eh,0C4h
    db 045h,042h,032h,04Fh,0BDh,03Eh,0C4h,045h,040h,032h,04Fh,040h,032h,04Fh,04Ah,032h
    db 04Fh,034h,036h,039h,03Bh,040h,042h,046h,048h,04Bh,04Dh,04Ah,032h,04Fh,034h,036h
    db 039h,03Bh,040h,042h,046h,048h,04Bh,04Dh,000h,030h,051h,040h,030h,051h,007h,030h
    db 051h,0B1h,032h,0B6h,037h,0BBh,03Ch,0C0h,041h,0C5h,046h,0CAh,04Bh,0CFh,050h,080h
    db 030h,033h,080h,035h,038h,080h,03Ah,03Dh,080h,03Fh,042h,080h,044h,047h,080h,049h
    db 04Ch,000h,04Eh,051h
LB692:
    ; db[99]
    db 011h,044h,033h,04Dh,036h,03Eh,0C0h,041h,043h,045h,034h,04Ch,035h,03Eh,0C0h,041h
    db 043h,0C9h,04Bh,043h,036h,04Ah,03Eh,0C0h,041h,043h,043h,036h,04Ah,03Eh,0C0h,041h
    db 043h,041h,036h,04Ah,0BEh,043h,043h,036h,04Ah,03Eh,043h,045h,043h,036h,04Ah,038h
    db 0BEh,043h,045h,043h,036h,04Ah,038h,03Bh,048h,042h,036h,04Ah,03Bh,048h,040h,036h
    db 04Ah,042h,036h,04Ah,03Eh,043h,042h,036h,04Ah,03Eh,043h,040h,036h,04Ah,049h,036h
    db 04Ah,038h,03Ah,03Ch,03Eh,040h,042h,044h,046h,048h,000h,034h,04Ch,040h,034h,04Ch
    db 000h,034h,04Ch
LB6F5:
    ; db[79]
    db 00Fh,043h,034h,04Bh,037h,0BEh,040h,042h,044h,035h,04Ah,036h,0BEh,040h,042h,0C7h
    db 049h,042h,037h,048h,0BEh,040h,042h,042h,037h,048h,0BEh,040h,042h,043h,037h,048h
    db 0BEh,040h,042h,044h,043h,037h,048h,039h,0BEh,042h,044h,043h,037h,048h,039h,03Bh
    db 046h,042h,037h,048h,03Bh,046h,040h,037h,048h,042h,037h,048h,03Eh,042h,042h,037h
    db 048h,03Eh,042h,040h,037h,048h,000h,036h,049h,040h,036h,049h,000h,036h,049h
LB744:
    ; db[47]
    db 00Ch,041h,039h,048h,0BFh,041h,042h,03Ah,047h,0BFh,041h,0C5h,046h,041h,03Ah,046h
    db 0BFh,041h,041h,03Ah,046h,0BFh,041h,040h,03Ah,046h,040h,03Ah,046h,040h,03Ah,046h
    db 040h,03Ah,046h,040h,03Ah,046h,000h,039h,047h,040h,039h,047h,000h,039h,047h
LB773:
    ; db[36]
    db 009h,041h,03Ah,046h,0BFh,040h,042h,03Bh,045h,0BFh,040h,0C3h,044h,041h,03Bh,044h
    db 0BFh,040h,040h,03Bh,044h,040h,03Bh,044h,040h,03Bh,044h,000h,03Bh,044h,040h,03Ah
    db 045h,000h,03Ah,045h
LB797:
    ; db[23]
    db 006h,041h,03Ch,044h,0BFh,040h,041h,03Ch,043h,0BFh,040h,040h,03Ch,043h,040h,03Ch
    db 043h,040h,03Ch,043h,000h,03Ch,043h
LB7AE:
    ; db[20]
    db 005h,002h,03Dh,042h,03Eh,041h,002h,03Dh,042h,03Eh,041h,040h,03Dh,042h,040h,03Dh
    db 042h,000h,03Dh,042h
TerrainSnowHall:
    ; db[115]
    db 012h,045h,02Ch,04Ch,033h,039h,0BBh,03Dh,03Fh,046h,045h,02Dh,04Bh,033h,039h,0BBh
    db 03Dh,03Fh,046h,002h,02Dh,04Bh,03Ah,03Eh,047h,02Dh,04Bh,030h,036h,039h,03Ch,03Fh
    db 043h,049h,046h,02Dh,04Bh,030h,036h,03Ah,03Eh,043h,049h,000h,02Dh,04Bh,044h,02Eh
    db 04Ah,033h,039h,03Fh,046h,044h,02Eh,04Ah,033h,039h,03Fh,046h,000h,02Fh,049h,045h
    db 02Fh,049h,031h,036h,03Ch,042h,047h,045h,02Fh,049h,031h,036h,03Ch,042h,047h,000h
    db 030h,048h,044h,031h,047h,034h,039h,03Fh,044h,044h,032h,046h,035h,039h,03Fh,043h
    db 000h,033h,045h,042h,035h,043h,03Bh,040h,043h,036h,042h,0B7h,038h,03Bh,0C0h,041h
    db 000h,039h,03Fh
LB835:
    ; db[79]
    db 00Dh,045h,033h,047h,037h,03Bh,0BDh,03Eh,040h,044h,002h,033h,047h,03Ch,03Fh,045h
    db 033h,047h,035h,039h,0BBh,03Ch,0BFh,040h,042h,044h,033h,047h,035h,039h,0BCh,03Fh
    db 042h,001h,033h,047h,0BCh,03Eh,044h,033h,047h,037h,03Bh,03Fh,044h,000h,034h,046h
    db 043h,034h,046h,039h,03Dh,041h,000h,035h,045h,042h,036h,044h,03Bh,03Fh,043h,037h
    db 043h,039h,0BBh,03Dh,040h,002h,038h,042h,0BBh,03Ch,0BEh,03Fh,000h,03Bh,03Fh
LB884:
    ; db[51]
    db 00Ah,043h,036h,045h,03Ch,03Eh,040h,043h,036h,045h,03Ch,03Eh,040h,044h,036h,045h
    db 0B7h,038h,03Ch,040h,0C3h,044h,041h,037h,044h,0BDh,03Fh,040h,037h,044h,001h,037h
    db 044h,0BDh,040h,040h,038h,043h,041h,039h,042h,0BDh,03Fh,042h,03Ah,041h,03Bh,040h
    db 000h,03Ch,03Fh
LB8B7:
    ; db[38]
    db 009h,042h,037h,044h,03Ch,03Fh,042h,037h,044h,03Ch,03Fh,042h,037h,044h,03Ch,03Fh
    db 041h,038h,043h,0BDh,03Eh,040h,038h,043h,040h,039h,042h,040h,03Ah,041h,001h,03Bh
    db 040h,0BDh,03Eh,000h,03Dh,03Eh
LB8DD:
    ; db[24]
    db 006h,042h,039h,043h,03Dh,03Fh,042h,039h,043h,03Dh,03Fh,041h,03Ah,042h,03Eh,040h
    db 03Ah,042h,040h,03Bh,041h,000h,03Ch,040h
LB8F5:
    ; db[21]
    db 005h,042h,03Ah,042h,03Dh,03Fh,042h,03Ah,042h,03Dh,03Fh,041h,03Bh,041h,03Eh,040h
    db 03Ch,040h,000h,03Dh,03Fh
LB90A:
    ; db[17]
    db 004h,041h,03Bh,042h,0BEh,03Fh,041h,03Bh,042h,0BEh,03Fh,040h,03Ch,041h,000h,03Dh
    db 040h
LB91B:
    ; db[11]
    db 003h,041h,03Ch,042h,03Fh,040h,03Dh,041h,000h,03Eh,040h
TerrainLake:
    ; db[52]
    db 00Bh,000h,027h,056h,000h,018h,062h,000h,00Eh,06Bh,000h,009h,070h,000h,007h,073h
    db 001h,007h,074h,088h,00Ah,002h,008h,074h,08Bh,010h,0EFh,073h,002h,00Bh,073h,091h
    db 017h,0E9h,06Eh,002h,011h,06Eh,098h,025h,0DEh,068h,042h,018h,068h,099h,025h,0DEh
    db 067h,000h,026h,05Dh
LB95A:
    ; db[39]
    db 008h,000h,02Eh,04Fh,000h,01Dh,05Eh,000h,019h,061h,001h,018h,064h,099h,01Ah,002h
    db 018h,064h,09Bh,01Eh,0E1h,063h,002h,01Bh,064h,09Fh,02Dh,0D6h,060h,042h,01Fh,060h
    db 0A0h,02Dh,0D6h,05Fh,000h,02Eh,055h
LB981:
    ; db[29]
    db 006h,000h,02Ch,053h,000h,024h,057h,001h,023h,059h,0A4h,027h,002h,024h,059h,0A8h
    db 032h,0D0h,058h,042h,028h,058h,0A9h,032h,0D0h,057h,000h,033h,04Fh
LB99E:
    ; db[16]
    db 005h,000h,02Eh,050h,000h,027h,054h,000h,026h,055h,000h,027h,054h,000h,031h,04Bh
LB9AE:
    ; db[13]
    db 004h,000h,033h,04Ch,000h,02Eh,04Fh,000h,02Dh,050h,000h,035h,048h
LB9BB:
    ; db[10]
    db 003h,000h,036h,049h,000h,032h,04Bh,000h,039h,047h
LB9C5:
    ; db[7]
    db 002h,000h,038h,047h,000h,036h,048h
LB9CC:
    ; db[4]
    db 001h,000h,037h,046h
TerrainFrozenWastes:
    ; db[539]
    db 023h,045h,000h,07Fh,005h,00Fh,01Eh,0CBh,04Ch,06Bh,045h,000h,07Fh,005h,00Fh,01Fh
    db 0CDh,04Eh,06Ah,046h,000h,07Fh,006h,010h,01Fh,0CFh,050h,05Ah,069h,046h,000h,07Fh
    db 006h,010h,01Fh,051h,05Ah,069h,047h,001h,07Eh,007h,010h,01Fh,034h,051h,05Bh,069h
    db 048h,001h,07Dh,008h,011h,01Fh,028h,034h,052h,05Bh,069h,049h,001h,07Ch,009h,011h
    db 01Eh,020h,028h,033h,053h,05Bh,069h,049h,001h,07Bh,00Ah,011h,01Dh,020h,028h,033h
    db 053h,05Ch,069h,049h,002h,07Bh,00Bh,011h,01Ch,020h,028h,033h,053h,05Ch,069h,04Ah
    db 002h,07Bh,00Bh,012h,01Bh,020h,027h,032h,043h,0D4h,055h,05Ch,069h,04Ch,003h,07Ah
    db 00Ch,012h,01Bh,020h,027h,02Eh,031h,043h,056h,05Dh,069h,06Fh,04Ch,003h,07Ah,00Ch
    db 012h,01Bh,020h,027h,02Eh,031h,043h,056h,05Eh,069h,070h,04Ch,003h,079h,00Ch,012h
    db 01Bh,021h,027h,02Eh,031h,042h,057h,05Eh,069h,071h,0C0h,003h,00Bh,04Ah,00Dh,079h
    db 012h,01Ah,021h,027h,0AEh,030h,042h,0D7h,058h,05Eh,0E9h,06Ah,071h,0C0h,003h,00Bh
    db 0C7h,00Dh,056h,011h,019h,021h,027h,02Eh,042h,0D4h,055h,0C1h,059h,069h,05Eh,041h
    db 06Bh,078h,072h,0C0h,003h,00Ah,0C7h,00Dh,053h,011h,019h,021h,027h,02Eh,041h,0D1h
    db 052h,0C1h,059h,069h,05Fh,041h,06Bh,077h,072h,0C0h,003h,00Ah,0C7h,00Eh,050h,011h
    db 098h,01Bh,021h,027h,02Eh,041h,0CEh,04Fh,0C1h,05Ah,069h,060h,041h,06Ch,077h,073h
    db 0C0h,004h,00Ah,0C2h,00Eh,017h,010h,016h,0C3h,01Ch,04Dh,0A2h,026h,0AEh,030h,041h
    db 0C2h,05Ah,068h,060h,067h,041h,06Ch,077h,0F3h,076h,0C0h,004h,009h,0C1h,00Eh,015h
    db 010h,0C2h,01Dh,02Eh,022h,027h,0C2h,031h,04Ch,040h,04Bh,0C1h,05Bh,067h,060h,041h
    db 06Ch,076h,072h,0C0h,005h,008h,0C0h,00Fh,015h,0C2h,01Dh,02Eh,023h,028h,0C1h,032h
    db 04Ah,040h,081h,05Bh,067h,0DCh,060h,041h,06Dh,075h,071h,0C0h,005h,008h,0C0h,00Fh
    db 014h,0C1h,01Eh,02Dh,024h,0C1h,033h,049h,040h,0C1h,05Ch,066h,060h,040h,06Dh,074h
    db 0C0h,005h,008h,0C0h,00Fh,013h,0C0h,01Fh,023h,0C0h,025h,02Dh,0C1h,033h,048h,03Fh
    db 0C1h,05Ch,065h,060h,040h,06Dh,074h,0C0h,005h,008h,0C0h,00Fh,012h,0C0h,020h,022h
    db 0C0h,026h,02Ch,0C2h,034h,047h,03Fh,046h,0C1h,05Dh,064h,05Fh,040h,06Eh,073h,0C0h
    db 006h,008h,080h,00Fh,011h,0C0h,021h,021h,0C0h,026h,02Bh,0C1h,034h,045h,03Eh,0C0h
    db 05Dh,063h,040h,06Eh,073h,0C0h,006h,008h,0C0h,026h,02Ah,0C1h,035h,044h,03Eh,0C0h
    db 05Dh,062h,040h,06Eh,072h,0C0h,006h,008h,0C0h,026h,02Ah,0C1h,035h,043h,03Eh,0C1h
    db 05Dh,062h,05Fh,040h,06Fh,072h,0C0h,006h,008h,0C0h,026h,02Ah,0C2h,036h,042h,03Dh
    db 041h,0C1h,05Dh,061h,05Fh,040h,06Fh,072h,0C0h,007h,007h,0C0h,026h,02Ah,0C1h,036h
    db 040h,03Dh,081h,05Eh,061h,060h,040h,070h,072h,0C0h,026h,029h,0C1h,037h,040h,03Dh
    db 0C0h,05Fh,061h,040h,071h,071h,0C0h,026h,029h,0C1h,037h,03Fh,03Ch,040h,05Fh,061h
    db 0C0h,026h,029h,0C1h,037h,03Fh,03Ch,040h,05Fh,061h,0C0h,026h,028h,0C1h,037h,03Eh
    db 03Ch,040h,05Fh,061h,0C0h,026h,028h,0C1h,038h,03Dh,03Bh,040h,060h,060h,0C0h,026h
    db 028h,001h,038h,03Ch,039h,080h,026h,028h,040h,039h,039h
LBBEB:
    ; db[357]
    db 019h,045h,013h,06Ch,017h,01Eh,028h,048h,05Eh,046h,013h,06Ch,017h,01Eh,029h,0C9h
    db 04Bh,052h,05Dh,046h,013h,06Ch,017h,01Eh,029h,04Ch,052h,05Dh,047h,014h,06Bh,018h
    db 01Eh,029h,037h,04Ch,053h,05Dh,048h,014h,06Ah,019h,01Fh,0A8h,029h,02Fh,037h,04Dh
    db 053h,05Dh,049h,014h,069h,01Ah,01Fh,027h,029h,02Fh,037h,04Dh,053h,05Dh,04Ah,014h
    db 069h,01Bh,020h,027h,029h,02Eh,036h,042h,04Eh,053h,05Dh,04Ch,015h,068h,01Bh,020h
    db 026h,029h,02Eh,033h,035h,042h,04Fh,054h,05Dh,061h,04Ch,015h,068h,01Bh,020h,026h
    db 02Ah,02Eh,033h,035h,041h,050h,055h,05Dh,062h,04Bh,015h,068h,01Bh,020h,025h,02Ah
    db 02Eh,0B3h,034h,041h,050h,055h,05Dh,062h,0C8h,015h,04Fh,09Bh,01Ch,01Fh,025h,02Ah
    db 02Eh,033h,041h,04Eh,043h,051h,067h,055h,05Dh,063h,0C0h,015h,01Ah,0C7h,01Dh,04Dh
    db 01Fh,0A4h,026h,02Ah,02Eh,033h,041h,0CAh,04Ch,043h,051h,066h,056h,0DDh,05Eh,063h
    db 0C0h,016h,01Ah,0C0h,01Eh,023h,0C3h,027h,049h,0ABh,02Eh,0B3h,034h,041h,0C2h,052h
    db 05Ch,056h,05Bh,041h,05Fh,066h,064h,0C0h,017h,019h,0C0h,01Eh,022h,0C2h,027h,033h
    db 02Bh,02Fh,0C3h,035h,048h,036h,040h,047h,081h,053h,05Ah,0D4h,056h,041h,05Fh,066h
    db 0E4h,065h,0C0h,017h,019h,0C0h,01Eh,021h,0C1h,028h,033h,02Ch,0C1h,037h,046h,040h
    db 0C1h,053h,05Ah,056h,040h,05Fh,065h,0C0h,017h,019h,0C0h,01Eh,020h,0C1h,029h,032h
    db 0ABh,02Dh,0C2h,037h,045h,03Fh,044h,0C1h,053h,059h,056h,040h,060h,064h,0C0h,017h
    db 019h,0C0h,01Fh,01Fh,0C0h,02Ah,02Ah,0C1h,02Dh,031h,02Eh,0C1h,037h,043h,03Eh,0C0h
    db 054h,058h,040h,060h,064h,0C0h,017h,019h,0C0h,02Eh,030h,0C1h,038h,043h,03Eh,0C0h
    db 054h,058h,040h,060h,063h,0C0h,017h,019h,0C0h,02Eh,030h,0C2h,038h,042h,03Eh,041h
    db 081h,054h,057h,055h,040h,061h,063h,0C0h,018h,018h,0C0h,02Eh,030h,0C1h,039h,040h
    db 03Eh,0C0h,055h,055h,040h,061h,063h,0C0h,02Eh,030h,0C1h,03Ah,03Fh,03Dh,040h,062h
    db 062h,0C0h,02Eh,030h,041h,03Ah,03Fh,03Dh,0C0h,02Fh,02Fh,001h,03Ah,03Eh,03Bh,040h
    db 03Ah,03Ch,040h,03Bh,03Bh
LBD50:
    ; db[246]
    db 012h,045h,020h,05Fh,022h,027h,02Fh,045h,055h,046h,020h,05Fh,022h,027h,02Fh,0C6h
    db 047h,04Dh,054h,047h,020h,05Eh,023h,027h,02Fh,039h,048h,04Dh,054h,048h,020h,05Eh
    db 024h,028h,02Fh,034h,039h,049h,04Dh,054h,049h,020h,05Dh,025h,028h,0AEh,02Fh,033h
    db 039h,041h,049h,04Dh,054h,04Ch,021h,05Ch,025h,029h,02Dh,02Fh,033h,036h,038h,041h
    db 04Ah,04Eh,054h,057h,04Bh,021h,05Ch,025h,029h,02Dh,030h,033h,0B6h,037h,040h,04Bh
    db 04Fh,054h,058h,0C7h,021h,04Ah,0A5h,026h,028h,02Ch,030h,033h,036h,040h,043h,04Ch
    db 05Ch,04Fh,054h,059h,0C0h,021h,025h,0C6h,027h,049h,0ACh,02Dh,030h,033h,036h,040h
    db 0C7h,048h,043h,04Ch,05Bh,04Fh,0D4h,055h,059h,0C0h,022h,024h,0C0h,027h,02Bh,0C4h
    db 02Eh,046h,0B1h,033h,0B6h,038h,040h,045h,081h,04Dh,053h,0CEh,04Fh,040h,056h,05Ah
    db 0C0h,022h,024h,0C0h,027h,02Ah,0C1h,02Fh,036h,031h,0C1h,039h,044h,040h,0C0h,04Dh
    db 052h,040h,056h,05Ah,0C0h,022h,024h,080h,028h,029h,0C1h,030h,036h,0B1h,032h,0C1h
    db 039h,043h,03Fh,0C0h,04Dh,052h,040h,057h,059h,0C0h,022h,024h,0C0h,033h,035h,0C1h
    db 03Ah,042h,03Eh,0C0h,04Eh,051h,040h,057h,059h,0C0h,022h,024h,0C0h,033h,035h,0C2h
    db 03Ah,041h,03Eh,040h,0C0h,04Eh,050h,040h,057h,059h,0C0h,023h,023h,0C0h,033h,035h
    db 0C1h,03Bh,03Fh,03Eh,0C0h,04Fh,04Fh,040h,058h,058h,0C0h,034h,034h,040h,03Bh,03Eh
    db 040h,03Bh,03Dh,040h,03Ch,03Ch
LBE46:
    ; db[206]
    db 010h,045h,023h,05Bh,025h,029h,030h,044h,052h,046h,023h,05Bh,025h,029h,030h,045h
    db 04Bh,051h,047h,023h,05Ah,026h,029h,030h,039h,046h,04Bh,051h,048h,023h,05Ah,027h
    db 02Ah,030h,035h,039h,047h,04Bh,051h,04Ah,023h,059h,028h,02Bh,030h,034h,038h,040h
    db 048h,04Ch,051h,054h,04Bh,024h,058h,028h,02Bh,02Fh,031h,034h,037h,03Fh,049h,04Dh
    db 051h,054h,0C7h,024h,048h,028h,02Ah,02Eh,031h,034h,037h,03Fh,043h,04Ah,058h,04Dh
    db 051h,055h,0C7h,024h,047h,0A8h,029h,0AEh,02Fh,031h,034h,037h,03Fh,0C5h,046h,043h
    db 04Ah,057h,04Dh,0D1h,052h,055h,0C0h,025h,027h,0C0h,029h,02Dh,0C3h,02Fh,044h,0B2h
    db 033h,0B7h,038h,03Fh,081h,04Bh,050h,0CCh,04Dh,040h,053h,056h,0C0h,025h,027h,0C0h
    db 029h,02Ch,0C1h,030h,037h,032h,0C1h,039h,043h,03Fh,0C0h,04Bh,04Fh,040h,053h,056h
    db 0C0h,025h,027h,080h,02Ah,02Bh,0C1h,031h,037h,0B2h,033h,0C1h,039h,042h,03Eh,0C0h
    db 04Bh,04Fh,040h,054h,056h,0C0h,025h,027h,0C0h,034h,036h,081h,03Ah,041h,0BBh,03Dh
    db 0C0h,04Ch,04Eh,040h,055h,055h,0C0h,026h,026h,0C0h,034h,036h,0C0h,03Bh,03Eh,040h
    db 04Dh,04Dh,0C0h,035h,035h,040h,03Bh,03Eh,040h,03Bh,03Dh,040h,03Ch,03Ch
LBF14:
    ; db[148]
    db 00Ch,045h,02Ah,054h,02Ch,02Fh,034h,043h,04Eh,046h,02Ah,054h,02Ch,02Fh,034h,044h
    db 048h,04Dh,048h,02Ah,054h,02Dh,030h,034h,038h,03Bh,045h,048h,04Dh,04Ah,02Bh,053h
    db 02Eh,030h,034h,037h,03Ah,040h,046h,049h,04Dh,04Fh,04Bh,02Bh,052h,02Eh,030h,033h
    db 035h,037h,039h,03Fh,047h,04Ah,04Dh,04Fh,0C8h,02Ch,046h,02Eh,030h,033h,035h,037h
    db 039h,03Fh,0C4h,045h,043h,048h,051h,04Ah,04Dh,050h,0C5h,02Ch,043h,0AEh,02Fh,0B2h
    db 033h,036h,0B9h,03Ah,03Fh,0C1h,048h,04Ch,04Bh,040h,04Eh,051h,0C0h,02Dh,02Dh,0C0h
    db 02Fh,031h,0C1h,034h,039h,036h,0C1h,03Bh,042h,03Fh,0C0h,048h,04Bh,040h,04Fh,051h
    db 0C0h,030h,030h,081h,035h,039h,038h,081h,03Ch,041h,0BDh,03Eh,0C0h,049h,04Bh,040h
    db 050h,050h,0C0h,037h,039h,0C0h,03Ch,03Eh,040h,04Ah,04Ah,0C0h,038h,038h,040h,03Ch
    db 03Eh,040h,03Dh,03Dh
LBFA8:
    ; db[89]
    db 009h,044h,02Fh,04Fh,033h,036h,042h,04Ah,044h,02Fh,04Fh,033h,036h,043h,049h,046h
    db 02Fh,04Eh,033h,036h,03Ch,03Fh,044h,049h,046h,030h,04Dh,033h,035h,03Bh,03Fh,045h
    db 049h,0C5h,030h,044h,0B2h,033h,035h,03Ah,03Fh,043h,002h,046h,04Dh,0C7h,048h,04Ch
    db 0C0h,031h,031h,0C4h,034h,042h,0B5h,036h,0BAh,03Bh,03Fh,041h,0C0h,046h,049h,040h
    db 04Ch,04Ch,081h,037h,03Ah,039h,0C1h,03Ch,040h,03Fh,040h,046h,048h,0C0h,039h,039h
    db 0C0h,03Ch,03Eh,040h,047h,047h,040h,03Dh,03Dh
LC001:
    ; db[62]
    db 007h,043h,033h,04Ch,036h,042h,048h,043h,033h,04Ch,036h,043h,047h,044h,033h,04Bh
    db 036h,03Ch,044h,047h,0C2h,033h,043h,0B5h,037h,03Bh,002h,045h,04Bh,046h,04Ah,0C0h
    db 034h,034h,0C2h,038h,042h,0BBh,03Ch,041h,0C0h,045h,047h,040h,04Ah,04Ah,080h,039h
    db 03Ah,081h,03Dh,040h,03Eh,040h,045h,047h,0C0h,03Eh,03Eh,040h,046h,046h
LC03F:
    ; db[52]
    db 006h,042h,036h,04Ah,042h,047h,043h,036h,04Ah,03Eh,043h,046h,044h,036h,049h,0B8h
    db 039h,03Dh,0C3h,044h,0C6h,047h,0C0h,037h,037h,0C2h,03Ah,042h,0BCh,03Dh,041h,0C0h
    db 044h,046h,040h,048h,048h,0C0h,03Bh,03Bh,0C0h,03Eh,040h,040h,044h,046h,0C0h,03Fh
    db 03Fh,040h,045h,045h
TerrainRuin:
    ; db[268]
    db 022h,047h,018h,06Eh,02Eh,03Ah,03Dh,0C3h,044h,046h,048h,0D1h,053h,049h,018h,06Dh
    db 02Dh,0B9h,03Ah,03Dh,0C3h,044h,046h,048h,0D4h,056h,05Ch,0EAh,06Ch,047h,019h,069h
    db 02Ch,0B5h,039h,03Dh,0C3h,044h,046h,048h,0D7h,05Bh,048h,01Ah,068h,09Bh,01Ch,02Bh
    db 035h,03Dh,0C3h,044h,046h,048h,05Ah,048h,01Dh,067h,09Eh,020h,0A8h,02Ah,0B4h,035h
    db 03Dh,046h,0C8h,04Bh,05Ah,0E2h,066h,047h,01Eh,065h,027h,029h,034h,03Dh,046h,0CBh
    db 04Dh,05Ah,046h,01Eh,065h,029h,034h,03Dh,0C6h,049h,04Dh,05Ah,0C2h,01Eh,046h,029h
    db 0B4h,03Dh,042h,049h,065h,0CAh,04Dh,05Ah,0C1h,01Eh,034h,029h,0C0h,03Dh,046h,042h
    db 04Dh,065h,0CEh,051h,05Ah,0C1h,01Eh,034h,029h,081h,03Dh,046h,0C3h,045h,041h,051h
    db 065h,05Ah,0C1h,01Eh,034h,029h,080h,042h,046h,041h,051h,065h,0D2h,05Ah,0C2h,01Eh
    db 034h,029h,033h,040h,05Ah,065h,0C2h,01Eh,033h,029h,0B0h,032h,041h,05Ah,065h,0DBh
    db 05Ch,0C2h,01Eh,031h,029h,030h,040h,05Dh,065h,0C1h,01Eh,030h,029h,040h,05Dh,065h
    db 0C1h,01Eh,030h,029h,041h,05Eh,065h,064h,0C1h,01Eh,030h,029h,000h,05Eh,063h,042h
    db 01Eh,030h,029h,0ADh,02Fh,043h,01Eh,02Dh,0A1h,022h,029h,02Ch,042h,01Eh,02Ch,0A1h
    db 022h,029h,042h,01Eh,02Ch,0A1h,022h,0A9h,02Bh,041h,01Eh,029h,0A1h,022h,041h,01Eh
    db 029h,0A1h,022h,040h,01Eh,029h,040h,01Eh,029h,041h,01Eh,029h,028h,041h,01Eh,028h
    db 027h,042h,01Eh,027h,021h,023h,003h,01Eh,027h,01Fh,022h,0A5h,026h,000h,01Dh,027h
    db 040h,01Dh,027h,040h,01Dh,026h,040h,01Dh,025h,000h,01Dh,025h
LC17F:
    ; db[178]
    db 018h,047h,024h,060h,033h,03Ch,03Eh,042h,044h,046h,0CCh,04Dh,0C2h,025h,03Bh,032h
    db 0B9h,03Ah,045h,03Eh,05Fh,042h,044h,046h,0CEh,053h,0DDh,05Eh,047h,026h,05Ch,031h
    db 038h,03Eh,042h,044h,046h,052h,048h,027h,05Bh,0A8h,029h,0AFh,030h,038h,03Eh,044h
    db 0C6h,048h,052h,0D8h,05Ah,047h,028h,05Ah,02Eh,030h,037h,03Eh,044h,049h,052h,044h
    db 028h,05Ah,030h,0B7h,03Eh,0C4h,049h,052h,0C1h,028h,037h,030h,081h,03Eh,044h,0C2h
    db 043h,042h,049h,05Ah,0CAh,04Ch,052h,0C1h,028h,037h,030h,080h,041h,044h,041h,04Ch
    db 05Ah,0CDh,052h,0C2h,028h,036h,030h,035h,041h,052h,05Ah,053h,0C1h,028h,035h,030h
    db 040h,054h,05Ah,0C1h,028h,035h,030h,040h,054h,05Ah,0C1h,028h,035h,030h,000h,055h
    db 05Ah,042h,028h,034h,030h,033h,042h,028h,032h,0AAh,02Bh,030h,042h,028h,031h,0AAh
    db 02Bh,030h,041h,028h,030h,0AAh,02Bh,040h,028h,030h,040h,028h,030h,041h,028h,02Fh
    db 02Eh,042h,028h,02Eh,02Ah,02Ch,000h,027h,02Eh,040h,027h,02Eh,040h,027h,02Dh,000h
    db 027h,02Dh
LC231:
    ; db[116]
    db 011h,045h,02Ch,057h,036h,0BDh,03Eh,041h,043h,0C8h,049h,047h,02Dh,056h,035h,0BBh
    db 03Ch,03Eh,041h,043h,0CAh,04Dh,0D4h,055h,046h,02Eh,053h,034h,03Ah,03Eh,0C3h,045h
    db 04Dh,0D1h,052h,046h,02Fh,052h,034h,039h,03Eh,043h,046h,04Dh,044h,02Fh,052h,034h
    db 0B9h,040h,0C3h,048h,04Dh,0C1h,02Fh,039h,034h,080h,040h,043h,001h,048h,052h,0CEh
    db 051h,0C1h,02Fh,039h,034h,040h,04Dh,052h,0C1h,02Fh,038h,034h,040h,04Eh,052h,0C1h
    db 02Fh,038h,034h,000h,04Fh,052h,043h,02Fh,037h,031h,034h,036h,042h,02Fh,035h,031h
    db 034h,041h,02Fh,034h,031h,040h,02Fh,034h,040h,02Fh,033h,000h,02Eh,033h,040h,02Eh
    db 033h,000h,02Eh,032h
LC2A5:
    ; db[104]
    db 00Fh,045h,02Eh,054h,037h,0BDh,03Eh,040h,042h,0C6h,047h,047h,02Fh,053h,036h,0BBh
    db 03Ch,03Eh,040h,042h,0C8h,04Bh,0D1h,052h,046h,02Fh,050h,035h,03Ah,03Eh,0C2h,044h
    db 04Bh,0CEh,04Fh,0C3h,030h,042h,035h,039h,03Eh,041h,045h,04Fh,04Bh,082h,030h,042h
    db 0B1h,034h,0B6h,038h,001h,045h,04Fh,0CCh,04Eh,0C1h,030h,039h,035h,040h,04Bh,04Fh
    db 0C1h,030h,038h,035h,040h,04Ch,04Fh,0C1h,030h,038h,035h,000h,04Dh,04Fh,042h,030h
    db 037h,032h,035h,042h,030h,036h,032h,035h,041h,030h,035h,032h,040h,030h,034h,000h
    db 02Fh,034h,040h,02Fh,034h,000h,02Fh,033h
LC30D:
    ; db[76]
    db 00Ch,044h,033h,04Fh,039h,03Fh,042h,045h,046h,033h,04Eh,039h,03Dh,03Fh,042h,0C6h
    db 048h,04Dh,047h,033h,04Ch,034h,038h,03Ch,03Fh,0C2h,044h,048h,04Bh,082h,034h,042h
    db 0B5h,037h,0B9h,03Bh,001h,044h,04Bh,0C9h,04Ah,0C1h,034h,03Bh,038h,040h,048h,04Bh
    db 0C1h,034h,03Ah,038h,000h,049h,04Bh,002h,034h,039h,035h,037h,041h,034h,038h,036h
    db 040h,034h,038h,000h,033h,037h,040h,033h,037h,000h,033h,036h
LC359:
    ; db[52]
    db 009h,044h,036h,04Bh,03Ah,03Fh,041h,043h,045h,036h,04Ah,03Ah,03Fh,041h,044h,046h
    db 003h,036h,049h,0B7h,038h,0BAh,03Bh,0C7h,048h,0C1h,036h,03Bh,039h,040h,046h,048h
    db 0C1h,036h,03Bh,039h,000h,046h,048h,041h,036h,03Ah,039h,040h,036h,039h,040h,036h
    db 038h,000h,036h,038h
LC38D:
    ; db[35]
    db 007h,043h,038h,049h,03Bh,03Fh,041h,044h,038h,048h,03Bh,03Fh,041h,045h,002h,038h
    db 047h,0B9h,03Ah,046h,0C0h,038h,03Bh,000h,045h,047h,040h,038h,03Bh,040h,038h,03Bh
    db 000h,038h,03Ah
LC3B0:
    ; db[28]
    db 006h,043h,03Ah,047h,03Ch,03Fh,041h,002h,03Ah,047h,03Bh,0C5h,046h,0C0h,03Ah,03Ch
    db 000h,044h,046h,040h,03Ah,03Ch,040h,03Ah,03Ch,000h,03Ah,03Bh
TerrainLith:
    ; db[411]
    db 031h,046h,006h,07Eh,007h,099h,01Eh,0CAh,04Eh,0DAh,05Ch,0F0h,078h,0FCh,07Dh,047h
    db 008h,07Bh,09Fh,020h,0C7h,049h,05Dh,0E4h,066h,0EEh,06Fh,073h,0F9h,07Ah,048h,009h
    db 07Ah,08Ah,00Bh,0A1h,022h,046h,054h,05Eh,0E7h,068h,0ECh,06Dh,073h,047h,00Ch,07Bh
    db 08Dh,00Eh,0A3h,025h,045h,054h,05Eh,0E9h,06Bh,073h,046h,00Fh,07Ch,0A6h,029h,045h
    db 054h,05Fh,06Bh,073h,047h,010h,07Ch,091h,017h,0AAh,02Dh,045h,054h,05Fh,0E7h,06Ah
    db 073h,0C6h,018h,066h,019h,02Eh,044h,054h,05Fh,0E3h,065h,041h,06Ah,07Ch,073h,0C4h
    db 01Ah,062h,0AFh,032h,044h,055h,05Eh,041h,06Ah,07Ch,073h,0C5h,01Bh,061h,0B3h,034h
    db 044h,048h,055h,05Dh,041h,06Ah,07Ch,073h,0C5h,01Ch,060h,01Dh,0B5h,037h,0C5h,047h
    db 055h,0DDh,05Fh,0C0h,06Ah,072h,040h,074h,07Ch,0C3h,01Eh,05Dh,0B8h,03Fh,045h,055h
    db 042h,06Ah,07Ch,071h,075h,0C0h,01Fh,037h,0C2h,040h,05Dh,0C1h,045h,055h,042h,06Ah
    db 07Ch,070h,075h,0C1h,020h,036h,0B3h,035h,0C1h,045h,05Dh,055h,042h,06Bh,07Bh,070h
    db 075h,081h,021h,032h,0A3h,028h,0C0h,035h,035h,0C1h,045h,05Dh,0D4h,055h,042h,06Ch
    db 07Ah,070h,075h,0C2h,023h,035h,0A4h,028h,030h,0C2h,045h,05Ch,053h,056h,002h,06Ch
    db 07Ah,0EDh,06Eh,0F8h,079h,0C1h,024h,035h,030h,0C2h,045h,05Ch,052h,0D7h,058h,042h
    db 06Dh,079h,06Eh,078h,0C1h,024h,035h,030h,0C2h,046h,05Bh,051h,0D9h,05Ah,040h,06Dh
    db 077h,0C1h,024h,035h,030h,0C1h,047h,05Bh,0CFh,050h,001h,06Eh,076h,0F3h,074h,0C1h
    db 024h,035h,030h,0C1h,047h,05Bh,04Eh,000h,073h,074h,0C1h,024h,035h,030h,041h,047h
    db 05Bh,04Dh,0C1h,024h,035h,030h,041h,048h,05Bh,04Ch,0C1h,024h,035h,030h,041h,049h
    db 05Ah,0CAh,04Bh,0C1h,024h,035h,030h,041h,04Ch,059h,058h,0C1h,024h,034h,030h,041h
    db 04Dh,057h,04Eh,0C1h,024h,034h,030h,000h,04Fh,056h,041h,024h,034h,030h,041h,025h
    db 034h,030h,041h,025h,034h,030h,041h,025h,034h,030h,041h,025h,034h,030h,041h,025h
    db 034h,030h,041h,025h,034h,030h,041h,025h,034h,030h,041h,025h,034h,030h,041h,025h
    db 034h,030h,041h,025h,034h,02Fh,041h,025h,033h,02Fh,041h,025h,033h,02Fh,041h,025h
    db 033h,02Fh,041h,025h,033h,02Fh,041h,025h,033h,02Fh,041h,025h,033h,02Fh,041h,025h
    db 033h,02Fh,041h,025h,033h,02Fh,041h,025h,033h,02Eh,041h,025h,032h,02Eh,042h,025h
    db 032h,0A6h,027h,02Eh,041h,027h,032h,02Eh,000h,027h,032h
LC567:
    ; db[289]
    db 023h,046h,017h,06Bh,018h,0A5h,028h,0C7h,04Ah,0D2h,053h,0E1h,067h,06Ah,049h,019h
    db 069h,01Ah,0A9h,02Bh,0C4h,046h,04Eh,054h,0D9h,05Ch,0DFh,060h,064h,068h,047h,01Bh
    db 069h,09Ch,01Dh,0ACh,02Dh,043h,04Eh,055h,0DDh,05Eh,064h,046h,01Eh,06Ah,0AEh,02Fh
    db 043h,04Eh,056h,05Eh,064h,047h,01Fh,06Ah,0A0h,024h,0B0h,033h,043h,04Eh,056h,0D9h
    db 05Dh,064h,0C4h,025h,058h,0B4h,036h,043h,04Fh,055h,041h,05Dh,06Ah,064h,0C5h,026h
    db 057h,027h,0B7h,039h,044h,04Fh,0D5h,056h,041h,05Dh,06Ah,0E3h,064h,0C3h,028h,054h
    db 0BAh,03Fh,043h,04Fh,042h,05Dh,06Ah,062h,065h,0C1h,029h,039h,0B7h,038h,0C2h,040h
    db 054h,0C1h,043h,04Fh,042h,05Eh,069h,061h,065h,082h,02Ah,038h,0ACh,02Fh,037h,0C1h
    db 043h,054h,0CEh,04Fh,042h,05Fh,068h,061h,065h,0C2h,02Ch,038h,0ADh,02Fh,035h,0C2h
    db 043h,053h,04Dh,04Fh,002h,05Fh,068h,060h,0E6h,067h,0C1h,02Ch,038h,035h,0C3h,043h
    db 053h,044h,04Ch,0D0h,052h,041h,060h,067h,066h,0C1h,02Ch,038h,035h,0C1h,045h,053h
    db 04Bh,000h,061h,065h,0C1h,02Ch,038h,035h,041h,045h,053h,0C9h,04Ah,0C1h,02Ch,038h
    db 035h,041h,045h,052h,048h,0C1h,02Ch,038h,035h,041h,046h,051h,0C7h,048h,0C1h,02Ch
    db 037h,035h,041h,049h,050h,04Ah,0C1h,02Ch,037h,035h,000h,04Bh,04Fh,041h,02Ch,037h
    db 035h,041h,02Dh,037h,035h,041h,02Dh,037h,035h,041h,02Dh,037h,035h,041h,02Dh,037h
    db 035h,041h,02Dh,037h,035h,041h,02Dh,037h,035h,041h,02Dh,036h,034h,041h,02Dh,036h
    db 034h,041h,02Dh,036h,034h,041h,02Dh,036h,034h,041h,02Dh,036h,034h,041h,02Dh,036h
    db 034h,041h,02Dh,035h,033h,042h,02Dh,035h,02Eh,033h,041h,02Eh,035h,033h,000h,02Eh
    db 035h
LC688:
    ; db[203]
    db 019h,045h,022h,05Eh,023h,0ACh,02Eh,0C5h,047h,04Dh,0D7h,05Ch,047h,024h,05Dh,0A5h
    db 026h,0AFh,032h,0C2h,044h,04Ah,04Eh,056h,059h,046h,027h,05Eh,033h,042h,04Ah,04Fh
    db 055h,059h,047h,028h,05Eh,0A9h,02Bh,0B4h,036h,042h,04Ah,04Fh,0D2h,054h,059h,0C5h
    db 02Ch,051h,0ADh,02Eh,0B7h,03Ah,042h,04Ah,0CFh,050h,041h,054h,05Eh,059h,0C3h,02Fh
    db 04Eh,0BBh,03Fh,042h,04Ah,042h,054h,05Eh,058h,05Ah,081h,030h,03Bh,0B1h,034h,0C2h
    db 040h,04Eh,0C1h,042h,04Ah,042h,055h,05Dh,057h,05Ah,082h,031h,03Ah,0B5h,037h,039h
    db 0C1h,042h,04Dh,0C9h,04Ah,001h,056h,05Ch,05Bh,0C1h,031h,03Ah,038h,0C3h,042h,04Dh
    db 043h,048h,0CBh,04Ch,040h,057h,05Bh,0C1h,031h,03Ah,038h,0C1h,043h,04Dh,0C6h,047h
    db 000h,058h,05Ah,0C1h,031h,03Ah,038h,041h,043h,04Dh,045h,0C1h,031h,03Ah,038h,001h
    db 044h,04Ch,0C8h,04Ah,0C1h,031h,03Ah,038h,000h,048h,04Ah,041h,031h,03Ah,038h,041h
    db 032h,03Ah,038h,041h,032h,03Ah,038h,041h,032h,03Ah,038h,041h,032h,03Ah,038h,041h
    db 032h,039h,037h,041h,032h,039h,037h,041h,032h,039h,037h,041h,032h,039h,037h,041h
    db 032h,038h,036h,042h,032h,038h,033h,036h,000h,033h,038h
LC753:
    ; db[180]
    db 016h,045h,025h,05Ah,026h,0AEh,02Fh,0C4h,045h,04Bh,0D4h,058h,047h,027h,059h,028h
    db 0B0h,033h,0C1h,043h,048h,04Ch,053h,055h,046h,029h,05Ah,034h,041h,048h,04Dh,052h
    db 055h,047h,02Ah,05Ah,0ABh,02Dh,0B5h,036h,041h,048h,04Dh,0CFh,051h,055h,0C6h,02Eh
    db 04Eh,0AFh,030h,037h,0BCh,03Eh,041h,048h,04Dh,041h,051h,05Ah,055h,081h,031h,03Bh
    db 0B2h,035h,0C2h,03Fh,04Ch,0C0h,041h,048h,042h,052h,059h,054h,056h,082h,032h,03Ah
    db 0B6h,037h,039h,0C1h,041h,04Bh,0C7h,048h,001h,053h,058h,057h,0C1h,032h,03Ah,038h
    db 0C2h,041h,04Bh,046h,0C9h,04Ah,040h,053h,057h,0C1h,032h,03Ah,038h,0C1h,042h,04Bh
    db 045h,000h,054h,056h,0C1h,032h,03Ah,038h,041h,042h,04Bh,044h,0C1h,032h,03Ah,038h
    db 001h,043h,04Ah,0C6h,048h,0C1h,032h,03Ah,038h,000h,046h,048h,041h,033h,03Ah,038h
    db 041h,033h,03Ah,038h,041h,033h,03Ah,038h,041h,033h,03Ah,038h,041h,033h,039h,037h
    db 041h,033h,039h,037h,041h,033h,039h,037h,041h,033h,039h,037h,042h,033h,039h,034h
    db 037h,000h,034h,039h
LC807:
    ; db[132]
    db 011h,044h,02Ch,054h,033h,0C2h,044h,048h,0CEh,052h,047h,02Dh,053h,02Eh,0B4h,036h
    db 041h,046h,049h,04Dh,050h,046h,02Fh,054h,0B0h,032h,0B7h,038h,041h,046h,0CAh,04Dh
    db 050h,0C5h,033h,04Ah,034h,039h,0BDh,03Eh,041h,046h,041h,04Dh,054h,050h,081h,035h
    db 03Ch,0B6h,038h,0C2h,03Fh,049h,0C0h,041h,046h,002h,04Eh,053h,050h,052h,082h,036h
    db 03Ch,039h,03Bh,081h,041h,048h,0C2h,044h,040h,04Eh,052h,0C1h,036h,03Ch,03Ah,0C1h
    db 042h,048h,044h,000h,04Fh,051h,0C1h,036h,03Ch,03Ah,040h,043h,047h,0C1h,036h,03Ch
    db 03Ah,000h,044h,046h,041h,036h,03Ch,03Ah,041h,036h,03Ch,03Ah,041h,036h,03Ch,03Ah
    db 041h,036h,03Bh,039h,041h,036h,03Bh,039h,041h,036h,03Bh,039h,002h,036h,03Bh,038h
    db 03Ah,000h,037h,03Bh
LC88B:
    ; db[97]
    db 00Dh,044h,030h,04Dh,036h,041h,046h,0CAh,04Ch,047h,031h,04Eh,032h,0B7h,038h,040h
    db 044h,046h,049h,04Ch,046h,033h,04Eh,0B4h,036h,039h,040h,044h,0C7h,049h,04Ch,083h
    db 037h,046h,0B8h,039h,0C1h,043h,045h,001h,049h,04Eh,04Dh,082h,038h,03Dh,03Ah,03Ch
    db 081h,040h,045h,0C1h,042h,040h,04Ah,04Dh,0C1h,038h,03Dh,03Bh,0C1h,041h,045h,042h
    db 000h,04Bh,04Ch,0C1h,038h,03Dh,03Bh,000h,043h,044h,041h,038h,03Dh,03Bh,041h,038h
    db 03Dh,03Bh,041h,038h,03Ch,03Ah,041h,038h,03Ch,03Ah,041h,038h,03Ch,03Ah,000h,039h
    db 03Ch
LC8EC:
    ; db[68]
    db 00Bh,044h,033h,04Ah,0B8h,039h,041h,045h,049h,046h,034h,04Bh,035h,03Ah,040h,043h
    db 045h,048h,004h,036h,04Bh,03Ah,0C1h,042h,044h,0C9h,04Ah,0C0h,03Ah,03Eh,0C1h,040h
    db 044h,043h,040h,048h,04Bh,0C0h,03Ah,03Eh,081h,041h,044h,043h,000h,049h,04Ah,0C0h
    db 03Ah,03Eh,040h,043h,043h,040h,03Ah,03Eh,040h,03Ah,03Dh,040h,03Ah,03Dh,040h,03Ah
    db 03Dh,000h,03Bh,03Dh
LC930:
    ; db[44]
    db 009h,043h,036h,048h,041h,044h,047h,044h,037h,049h,03Ah,040h,044h,047h,002h,038h
    db 049h,0C1h,043h,048h,0C0h,03Bh,03Eh,080h,041h,043h,040h,048h,048h,040h,03Bh,03Eh
    db 040h,03Bh,03Eh,040h,03Bh,03Eh,040h,03Bh,03Eh,000h,03Ch,03Dh
TerrainCavern:
    ; db[132]
    db 014h,044h,013h,06Eh,094h,017h,02Fh,0B3h,038h,0CBh,04Fh,045h,018h,06Dh,099h,01Ch
    db 02Fh,0B3h,038h,0C8h,04Ah,0EBh,06Ch,044h,01Dh,06Ah,09Eh,022h,02Fh,0B3h,038h,0C5h
    db 047h,044h,023h,069h,0A4h,026h,02Fh,0B3h,037h,0C3h,044h,044h,027h,068h,030h,0B3h
    db 037h,0C1h,042h,0E5h,067h,043h,028h,064h,030h,0B4h,037h,040h,044h,029h,063h,031h
    db 0B5h,036h,03Fh,0E1h,062h,041h,02Ah,060h,0B2h,035h,040h,02Bh,060h,041h,02Ch,05Fh
    db 0DCh,05Eh,041h,02Dh,05Bh,0C6h,04Ah,042h,02Dh,05Ah,0C4h,045h,059h,041h,02Eh,058h
    db 043h,041h,02Fh,057h,0BFh,042h,043h,030h,056h,0B1h,032h,0BCh,03Eh,055h,041h,033h
    db 054h,0B4h,03Bh,040h,03Ch,053h,041h,03Dh,052h,0CDh,051h,042h,03Eh,04Ch,03Fh,0C7h
    db 04Bh,000h,040h,046h
LC9E0:
    ; db[94]
    db 00Eh,044h,020h,060h,0A1h,023h,034h,0B7h,03Ah,0C8h,04Ah,045h,024h,05Fh,0A5h,02Bh
    db 034h,0B7h,03Ah,0C4h,047h,05Eh,044h,02Ch,05Dh,02Dh,034h,0B7h,03Ah,0C2h,043h,044h
    db 02Eh,05Ch,035h,0B7h,03Ah,041h,0DAh,05Bh,044h,02Fh,059h,035h,0B8h,03Ah,0BFh,040h
    db 0D7h,058h,041h,030h,056h,0B6h,039h,041h,031h,055h,054h,041h,032h,053h,0C4h,047h
    db 042h,033h,052h,0C2h,043h,051h,041h,034h,050h,0BFh,041h,042h,035h,04Fh,036h,03Eh
    db 042h,037h,04Eh,0B8h,03Dh,04Dh,041h,03Eh,04Ch,0C9h,04Bh,000h,03Fh,048h
LCA3E:
    ; db[69]
    db 00Ah,044h,02Bh,057h,0ACh,02Eh,037h,0B9h,03Bh,0C5h,047h,045h,02Fh,056h,0B0h,032h
    db 037h,0B9h,03Bh,0C1h,044h,055h,044h,033h,054h,038h,0BAh,03Bh,040h,053h,044h,034h
    db 052h,038h,0BAh,03Bh,03Fh,0D0h,051h,042h,035h,04Fh,0B9h,03Ah,04Eh,041h,036h,04Dh
    db 0C3h,045h,043h,037h,04Ch,038h,0C0h,042h,04Bh,041h,039h,04Ah,03Fh,001h,03Ah,049h
    db 0BFh,044h,000h,03Fh,044h
LCA83:
    ; db[60]
    db 009h,043h,02Dh,054h,0AEh,030h,0B8h,03Bh,0C4h,045h,044h,031h,053h,0B2h,033h,0B8h
    db 03Bh,0C0h,043h,052h,043h,034h,051h,0B8h,03Bh,03Fh,050h,043h,035h,04Fh,0B9h,03Ah
    db 03Eh,0CDh,04Eh,042h,036h,04Ch,0C2h,044h,04Bh,043h,037h,04Ah,038h,0C0h,041h,049h
    db 041h,039h,048h,03Fh,001h,03Ah,047h,0BFh,043h,000h,03Fh,043h
LCABF:
    ; db[41]
    db 007h,043h,032h,04Fh,0B3h,034h,0BAh,03Ch,04Eh,043h,035h,04Dh,036h,0BAh,03Ch,04Ch
    db 043h,037h,04Bh,038h,03Bh,04Ah,042h,039h,049h,0C2h,043h,048h,041h,03Ah,047h,0C0h
    db 041h,001h,03Bh,046h,0C0h,042h,000h,040h,042h
LCAE8:
    ; db[33]
    db 006h,043h,036h,04Bh,037h,0BBh,03Ch,04Ah,041h,038h,049h,0BBh,03Ch,043h,039h,048h
    db 03Ah,0C1h,042h,0C6h,047h,041h,03Bh,045h,040h,001h,03Ch,044h,0C0h,041h,000h,040h
    db 041h
LCB09:
    ; db[27]
    db 005h,043h,038h,049h,039h,0BCh,03Dh,048h,041h,03Ah,047h,0BCh,03Dh,042h,03Bh,046h
    db 040h,0C4h,045h,001h,03Ch,043h,0C0h,041h,000h,040h,041h
LCB24:
    ; db[17]
    db 003h,041h,03Ah,047h,03Ch,042h,03Bh,046h,03Fh,0C4h,045h,080h,03Ch,03Eh,000h,040h
    db 043h
TerrainArmy:
    ; db[493]
    db 023h,000h,00Eh,074h,000h,00Eh,074h,061h,00Eh,074h,011h,014h,017h,01Ah,01Dh,020h
    db 023h,026h,029h,02Ch,02Fh,032h,035h,038h,03Bh,03Eh,041h,044h,047h,04Ah,04Dh,050h
    db 053h,056h,059h,05Ch,05Fh,062h,065h,068h,06Bh,06Eh,071h,061h,00Eh,074h,011h,014h
    db 017h,01Ah,01Dh,020h,023h,026h,029h,02Ch,02Fh,032h,035h,038h,03Bh,03Eh,041h,044h
    db 047h,04Ah,04Dh,050h,053h,056h,059h,05Ch,05Fh,062h,065h,068h,06Bh,06Eh,071h,000h
    db 00Eh,074h,022h,00Eh,073h,00Fh,012h,015h,018h,01Bh,01Eh,021h,024h,027h,02Ah,02Dh
    db 030h,033h,036h,039h,03Ch,03Fh,042h,045h,048h,04Bh,04Eh,051h,054h,057h,05Ah,05Dh
    db 060h,063h,066h,069h,06Ch,06Fh,072h,000h,00Eh,073h,0C0h,010h,010h,01Dh,015h,06Bh
    db 016h,019h,01Ch,01Fh,022h,025h,028h,02Bh,02Eh,031h,034h,037h,03Ah,03Dh,040h,043h
    db 046h,049h,04Ch,04Fh,052h,055h,058h,05Bh,05Eh,061h,064h,067h,06Ah,0C0h,010h,010h
    db 000h,015h,06Bh,0C0h,010h,010h,0C0h,01Eh,01Eh,0C0h,029h,029h,0C0h,03Ah,03Ah,0C0h
    db 04Bh,04Bh,040h,057h,057h,0C0h,010h,010h,0C0h,01Eh,01Eh,0C0h,029h,029h,0C0h,03Ah
    db 03Ah,0C0h,04Bh,04Bh,040h,057h,057h,0C0h,010h,010h,0C0h,01Eh,01Eh,0C0h,029h,029h
    db 0C0h,03Ah,03Ah,0C0h,04Bh,04Bh,040h,057h,057h,080h,010h,017h,0C0h,01Eh,01Eh,080h
    db 029h,041h,0C0h,04Bh,04Bh,040h,057h,057h,0C0h,010h,017h,0C0h,01Eh,01Eh,0C0h,029h
    db 041h,0C0h,04Bh,04Bh,040h,057h,057h,0C0h,010h,017h,0C0h,01Eh,01Eh,0C0h,029h,041h
    db 000h,04Bh,05Fh,0C0h,010h,017h,0C0h,01Eh,01Eh,0C0h,029h,041h,041h,04Bh,05Fh,057h
    db 0C0h,010h,017h,0C0h,01Eh,01Eh,0C0h,029h,041h,041h,04Bh,05Fh,057h,0C0h,010h,017h
    db 0C0h,01Eh,01Eh,0C0h,029h,041h,0C1h,04Bh,05Fh,057h,000h,06Ah,072h,0C0h,010h,017h
    db 081h,01Eh,041h,0B7h,040h,002h,04Bh,072h,0CCh,056h,0EBh,071h,0C0h,010h,017h,0C1h
    db 01Eh,041h,036h,041h,04Bh,072h,057h,0C0h,010h,017h,0C1h,01Eh,041h,035h,041h,04Bh
    db 072h,057h,0C0h,010h,017h,0C1h,01Eh,041h,034h,041h,04Bh,072h,057h,0C0h,010h,017h
    db 0C1h,01Eh,041h,033h,041h,04Bh,072h,057h,0C0h,010h,017h,0C1h,01Eh,041h,032h,041h
    db 04Bh,072h,0CCh,057h,0C0h,010h,017h,0C2h,01Eh,049h,031h,0C1h,048h,040h,057h,072h
    db 0C0h,010h,017h,0C3h,01Eh,052h,030h,041h,0C9h,051h,040h,057h,072h,0C0h,010h,017h
    db 042h,01Eh,072h,0AFh,041h,0D2h,05Bh,0C0h,010h,017h,0C0h,01Eh,030h,041h,03Ah,072h
    db 0DBh,063h,0C0h,010h,017h,0C0h,01Eh,031h,041h,03Ah,072h,063h,0C0h,010h,017h,0C0h
    db 01Eh,032h,041h,03Ah,072h,0DBh,063h,0C0h,010h,017h,0C0h,01Eh,033h,041h,03Ah,072h
    db 0D2h,05Bh,0C0h,010h,017h,0C0h,01Eh,034h,0C1h,03Ah,052h,0C9h,051h,040h,057h,072h
    db 0C0h,010h,017h,0C0h,01Eh,035h,080h,03Ah,049h,041h,057h,072h,0EAh,071h,0C0h,010h
    db 017h,0C0h,01Eh,036h,000h,057h,06Ah,080h,010h,017h,000h,01Eh,036h
LCD22:
    ; db[296]
    db 019h,000h,01Dh,064h,000h,01Dh,064h,061h,01Dh,064h,01Fh,021h,023h,025h,027h,029h
    db 02Ch,02Eh,030h,032h,034h,036h,038h,03Ah,03Ch,03Eh,041h,043h,045h,047h,049h,04Bh
    db 04Dh,04Fh,051h,053h,056h,058h,05Ah,05Ch,05Eh,060h,062h,000h,01Dh,064h,000h,01Dh
    db 064h,0C0h,01Eh,01Eh,00Ch,022h,05Eh,02Bh,02Dh,02Fh,031h,040h,042h,044h,046h,055h
    db 057h,059h,05Bh,0C0h,01Eh,01Eh,000h,022h,05Eh,0C0h,01Eh,01Eh,0C0h,028h,028h,0C0h
    db 030h,030h,0C0h,03Ch,03Ch,0C0h,048h,048h,040h,050h,050h,080h,01Eh,023h,0C0h,028h
    db 028h,080h,030h,041h,0C0h,048h,048h,040h,050h,050h,0C0h,01Eh,023h,0C0h,028h,028h
    db 0C0h,030h,041h,0C0h,048h,048h,040h,050h,050h,0C0h,01Eh,023h,0C0h,028h,028h,0C0h
    db 030h,041h,000h,048h,056h,0C0h,01Eh,023h,0C0h,028h,028h,0C0h,030h,041h,041h,048h
    db 056h,050h,0C0h,01Eh,023h,0C0h,028h,028h,0C0h,030h,041h,0C1h,048h,056h,050h,000h
    db 05Dh,063h,0C0h,01Eh,023h,081h,028h,041h,0BAh,040h,002h,048h,063h,0C9h,04Fh,0DEh
    db 062h,0C0h,01Eh,023h,0C1h,028h,041h,038h,041h,048h,063h,050h,0C0h,01Eh,023h,0C1h
    db 028h,041h,037h,041h,048h,063h,050h,0C0h,01Eh,023h,0C1h,028h,041h,036h,041h,048h
    db 063h,0C9h,050h,0C0h,01Eh,023h,0C2h,028h,046h,035h,0C1h,045h,040h,050h,063h,0C0h
    db 01Eh,023h,003h,028h,063h,0A9h,033h,0C2h,045h,0D9h,062h,0C0h,01Eh,023h,0C0h,028h
    db 035h,041h,03Ch,063h,058h,0C0h,01Eh,023h,0C0h,028h,036h,041h,03Ch,063h,0D3h,058h
    db 0C0h,01Eh,023h,0C0h,028h,037h,041h,03Ch,063h,0CCh,053h,0C0h,01Eh,023h,0C0h,028h
    db 038h,080h,03Ch,04Ch,041h,050h,063h,0DDh,062h,0C0h,01Eh,023h,0C0h,028h,039h,000h
    db 050h,05Dh,080h,01Eh,023h,000h,028h,039h
LCE4A:
    ; db[199]
    db 012h,000h,027h,059h,000h,027h,059h,058h,027h,059h,029h,02Bh,02Dh,02Fh,031h,033h
    db 035h,037h,039h,03Bh,03Dh,03Fh,041h,043h,045h,047h,049h,04Bh,04Dh,04Fh,051h,053h
    db 055h,057h,000h,027h,059h,0C0h,027h,027h,000h,02Ah,055h,0C0h,027h,027h,0C0h,02Fh
    db 02Fh,0C0h,034h,034h,0C0h,03Dh,03Dh,0C0h,045h,045h,040h,04Bh,04Bh,080h,027h,02Bh
    db 0C0h,02Fh,02Fh,080h,034h,040h,0C0h,045h,045h,040h,04Bh,04Bh,0C0h,027h,02Bh,0C0h
    db 02Fh,02Fh,0C0h,034h,040h,000h,045h,04Fh,0C0h,027h,02Bh,0C0h,02Fh,02Fh,0C0h,034h
    db 040h,041h,045h,04Fh,04Bh,0C0h,027h,02Bh,081h,02Fh,040h,0BCh,03Fh,001h,045h,059h
    db 0C6h,04Ah,0C0h,027h,02Bh,0C1h,02Fh,040h,03Ah,041h,045h,059h,04Bh,0C0h,027h,02Bh
    db 0C1h,02Fh,040h,039h,041h,045h,059h,0C6h,04Bh,0C0h,027h,02Bh,0C2h,02Fh,044h,038h
    db 0C0h,043h,040h,04Bh,059h,0C0h,027h,02Bh,042h,02Fh,059h,0B7h,040h,0C4h,04Ch,0C0h
    db 027h,02Bh,0C0h,02Fh,038h,041h,03Dh,059h,0CCh,050h,0C0h,027h,02Bh,0C0h,02Fh,039h
    db 041h,03Dh,059h,0C8h,04Bh,0C0h,027h,02Bh,0C0h,02Fh,03Ah,080h,03Dh,048h,000h,04Bh
    db 059h,080h,027h,02Bh,000h,02Fh,03Bh
LCF11:
    ; db[167]
    db 010h,000h,029h,055h,000h,029h,055h,055h,029h,055h,02Bh,02Dh,02Fh,031h,033h,035h
    db 037h,039h,03Bh,03Dh,03Fh,041h,043h,045h,047h,049h,04Bh,04Dh,04Fh,051h,053h,000h
    db 029h,055h,0C0h,029h,029h,080h,02Fh,035h,000h,040h,052h,080h,029h,02Dh,0C0h,030h
    db 030h,080h,035h,03Fh,0C0h,044h,044h,040h,049h,049h,0C0h,029h,02Dh,0C0h,030h,030h
    db 0C0h,035h,03Fh,000h,044h,04Dh,0C0h,029h,02Dh,0C0h,030h,030h,0C0h,035h,03Fh,041h
    db 044h,04Dh,049h,0C0h,029h,02Dh,081h,030h,03Fh,0BCh,03Eh,001h,044h,055h,0C5h,048h
    db 0C0h,029h,02Dh,0C1h,030h,03Fh,03Ah,041h,044h,055h,049h,0C0h,029h,02Dh,0C1h,030h
    db 03Fh,039h,041h,044h,055h,049h,0C0h,029h,02Dh,002h,030h,055h,0B1h,037h,0CBh,054h
    db 0C0h,029h,02Dh,0C0h,030h,038h,041h,03Dh,055h,04Ah,0C0h,029h,02Dh,0C0h,030h,039h
    db 041h,03Dh,055h,0C6h,049h,0C0h,029h,02Dh,0C0h,030h,03Ah,080h,03Dh,046h,000h,049h
    db 055h,080h,029h,02Dh,000h,030h,03Bh
LCFB8:
    ; db[134]
    db 00Ch,000h,02Fh,050h,04Fh,02Fh,050h,032h,034h,036h,038h,03Ah,03Ch,03Eh,040h,042h
    db 044h,046h,048h,04Ah,04Ch,04Eh,000h,02Fh,050h,0C0h,02Fh,02Fh,0C0h,034h,034h,0C0h
    db 038h,038h,0C0h,043h,043h,040h,047h,047h,080h,02Fh,032h,0C0h,034h,034h,080h,038h
    db 03Fh,0C0h,043h,043h,040h,047h,047h,0C0h,02Fh,032h,0C0h,034h,034h,0C0h,038h,03Fh
    db 000h,043h,047h,0C0h,02Fh,032h,081h,034h,03Fh,0BDh,03Eh,001h,043h,050h,0C4h,046h
    db 0C0h,02Fh,032h,0C1h,034h,03Fh,03Ch,041h,043h,050h,047h,0C0h,02Fh,032h,002h,034h
    db 050h,0B5h,03Ah,0C9h,04Fh,0C0h,02Fh,032h,0C0h,034h,03Ah,041h,03Eh,050h,048h,0C0h
    db 02Fh,032h,0C0h,034h,03Bh,041h,03Eh,050h,0C5h,047h,080h,02Fh,032h,080h,034h,03Ch
    db 080h,03Eh,045h,000h,047h,050h
LD03E:
    ; db[78]
    db 009h,000h,033h,04Ch,00Ch,033h,04Ch,034h,037h,039h,03Bh,03Dh,03Fh,041h,043h,045h
    db 047h,049h,04Bh,000h,033h,04Ch,0C0h,033h,036h,0C0h,039h,03Fh,0C0h,042h,042h,040h
    db 045h,045h,0C0h,033h,036h,0C0h,039h,03Fh,000h,042h,045h,082h,033h,03Fh,0B4h,035h
    db 0BDh,03Eh,001h,042h,04Ch,0C3h,044h,003h,033h,04Ch,0B4h,035h,0B7h,03Bh,0C7h,04Bh
    db 0C1h,033h,03Ch,036h,041h,03Eh,04Ch,046h,080h,033h,03Ch,000h,03Eh,04Ch
LD08C:
    ; db[54]
    db 007h,000h,036h,04Ah,049h,036h,04Ah,038h,03Ah,03Ch,03Eh,040h,042h,044h,046h,048h
    db 000h,036h,04Ah,0C0h,036h,038h,0C0h,03Bh,03Fh,040h,042h,044h,082h,036h,03Fh,037h
    db 03Eh,001h,042h,04Ah,043h,0C2h,036h,03Fh,038h,0BDh,03Eh,041h,042h,04Ah,0C3h,044h
    db 080h,036h,03Dh,000h,044h,04Ah
LD0C2:
    ; db[40]
    db 006h,000h,038h,048h,047h,038h,048h,03Ah,03Ch,03Eh,040h,042h,044h,046h,000h,038h
    db 048h,0C1h,038h,03Eh,03Ah,001h,041h,048h,042h,0C1h,038h,03Eh,03Ah,041h,041h,048h
    db 0C2h,043h,080h,038h,03Eh,000h,043h,048h

; Graphics for each character
CharacterGraphics:
    ; db[1304]
    db 000h,000h,000h,000h,000h,000h,000h,000h,008h,008h,008h,008h,008h,008h,008h,008h
    db 000h,018h,034h,07Ah,07Ah,0FBh,0FBh,0FFh,000h,000h,004h,004h,00Fh,00Fh,00Fh,01Fh
    db 008h,008h,048h,068h,0E8h,0F9h,0FBh,0FFh,0B3h,0B3h,083h,0C7h,0FFh,083h,001h,0FFh
    db 000h,000h,000h,0FEh,0DEh,0DEh,0DEh,0DEh,01Fh,01Fh,01Eh,00Ch,00Dh,00Dh,00Fh,00Fh
    db 0FBh,0FDh,0FDh,0FEh,0FFh,0FFh,0BFh,0BFh,00Eh,00Eh,00Eh,00Eh,00Eh,08Eh,0FFh,0E1h
    db 0DEh,0DEh,0DEh,05Ch,07Ch,0B8h,0B8h,0D4h,01Fh,01Fh,01Fh,01Eh,00Eh,001h,001h,001h
    db 07Fh,07Fh,07Fh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0E1h,0F0h,0F0h,0FFh,0F8h,0FFh,0F8h
    db 0ECh,0FEh,0FEh,0FEh,0FEh,0FEh,0FEh,0FEh,001h,001h,001h,001h,001h,000h,000h,000h
    db 0DFh,0DFh,0EFh,0EFh,0EFh,0F7h,0F7h,0F7h,0F8h,0F8h,0F8h,0FFh,0F8h,0F0h,0FFh,0DEh
    db 0FCh,0FCh,0FAh,0F6h,0F7h,0F7h,0F1h,0F8h,0E7h,0E7h,0E7h,0E7h,0E3h,0E3h,0C3h,0C3h
    db 09Eh,09Ch,09Ch,09Ch,098h,098h,018h,018h,078h,070h,070h,070h,060h,060h,060h,060h
    db 000h,000h,000h,000h,000h,001h,001h,001h,0C3h,0C3h,0C3h,0C3h,0E3h,0E7h,0C7h,0C7h
    db 018h,018h,01Ch,03Ch,0B8h,0B8h,000h,000h,060h,060h,070h,0F0h,0E0h,0E0h,000h,000h
    db 0FFh,01Fh,007h,003h,001h,001h,001h,000h,081h,099h,03Ch,07Eh,0FFh,0FFh,0FFh,0A7h
    db 0FFh,0F8h,0E0h,0C0h,080h,080h,080h,000h,000h,000h,040h,063h,0E7h,0F7h,0FFh,0FFh
    db 0A7h,0A7h,083h,0CFh,0FFh,0FFh,0FFh,0FFh,000h,003h,006h,00Ch,00Fh,007h,000h,000h
    db 000h,03Ch,07Eh,0FFh,0FFh,0FFh,099h,0FFh,000h,0C0h,060h,030h,0F0h,0E0h,000h,000h
    db 0FFh,0E7h,0C3h,0FFh,0FFh,0FFh,0FFh,0FFh,014h,01Ch,01Ch,008h,008h,008h,008h,008h
    db 000h,000h,000h,03Eh,07Fh,0FFh,0FFh,0FFh,000h,000h,000h,000h,080h,0C0h,0E0h,0A0h
    db 083h,0DBh,0A3h,0A7h,08Fh,077h,003h,007h,080h,080h,080h,0C0h,0C0h,0E0h,0E0h,0E0h
    db 007h,005h,00Eh,00Fh,00Fh,09Fh,0FFh,0FFh,0E0h,0F0h,0F0h,070h,078h,0B8h,0B8h,0D4h
    db 0E1h,0E0h,0F0h,0F0h,0F8h,0F8h,0FFh,0F8h,0D4h,0CEh,0DEh,0FEh,0FEh,0FEh,0FEh,0FEh
    db 000h,000h,000h,000h,00Fh,01Fh,03Fh,03Fh,000h,000h,000h,000h,080h,0C0h,0C0h,0E0h
    db 000h,000h,040h,060h,0E0h,0F0h,0F8h,0F8h,020h,036h,020h,028h,020h,013h,00Fh,009h
    db 0E0h,0E0h,0E0h,0E0h,0E0h,0C0h,080h,000h,0FCh,0FFh,0FFh,0FFh,0FFh,0FCh,0BCh,0BFh
    db 0FFh,0C0h,081h,003h,087h,0FFh,0FFh,0FFh,0C0h,0E0h,0E0h,0E0h,0C0h,080h,080h,0F0h
    db 0F0h,0F0h,0E0h,0E1h,0C3h,0C7h,0FFh,0E3h,0FCh,0FEh,0FEh,0FEh,0FEh,0FEh,0FEh,0FEh
    db 0E3h,0F1h,0F2h,0FFh,0F8h,0F0h,0FFh,0DEh,000h,000h,024h,064h,06Eh,0FEh,0FFh,0D7h
    db 000h,000h,000h,000h,000h,000h,000h,0E0h,0FFh,0D7h,06Fh,07Fh,07Fh,03Fh,01Fh,01Fh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0F8h,0FCh,0FEh,0FEh,0FFh,0FFh,0FDh,0FCh
    db 000h,000h,000h,000h,000h,0C0h,0F0h,038h,00Bh,00Dh,005h,005h,005h,005h,00Dh,003h
    db 0E2h,0C1h,0C1h,081h,081h,081h,083h,000h,0FCh,078h,070h,060h,060h,060h,060h,0C0h
    db 000h,000h,048h,06Ch,07Ch,07Eh,0FFh,0F5h,000h,000h,000h,000h,000h,000h,087h,0FDh
    db 001h,003h,003h,007h,007h,007h,007h,047h,0FDh,0FFh,0FFh,0FFh,0F7h,0C0h,0C0h,0C0h
    db 0FFh,0FFh,00Ah,0C0h,0F0h,07Ch,01Ch,060h,000h,000h,03Ch,00Eh,0E0h,07Ch,01Fh,000h
    db 0E7h,0E7h,0F3h,0F3h,0FBh,0FDh,0FDh,0FDh,0E0h,0E1h,0F3h,0F7h,0FEh,0FDh,0FFh,0FFh
    db 0FCh,0FFh,0FFh,000h,0FFh,0FFh,0FFh,0FFh,000h,000h,0C0h,0E0h,070h,0F0h,0F8h,0F8h
    db 0FDh,0FBh,0FBh,077h,077h,077h,037h,02Fh,0FFh,0F0h,0E0h,0F0h,0FCh,0FEh,0FFh,0FFh
    db 0F8h,0FCh,03Ch,01Ch,01Ch,00Ch,084h,0C4h,02Fh,02Fh,02Fh,01Fh,03Fh,03Fh,03Eh,07Dh
    db 0FFh,0FFh,0FFh,0FFh,0FFh,0FBh,0FDh,0FEh,0FFh,0BFh,0DFh,0EFh,0EFh,0F6h,0F6h,0F5h
    db 0E4h,0F0h,0F8h,0F8h,0F8h,0F8h,0F8h,0F0h,07Dh,07Bh,07Bh,07Bh,0FBh,0FDh,0FEh,0AAh
    db 0FEh,0FEh,087h,000h,003h,09Eh,07Eh,0FEh,0FBh,0FBh,07Bh,07Bh,07Dh,0FCh,0FEh,0AAh
    db 0F0h,0E0h,0C0h,0A0h,060h,0F0h,0F8h,0A8h,007h,01Fh,03Fh,03Fh,07Fh,07Fh,0FFh,0FFh
    db 0E0h,0F8h,0FCh,0FCh,0FEh,0FEh,0FEh,0FFh,001h,000h,003h,00Fh,01Fh,01Fh,03Fh,03Fh
    db 0DFh,0CFh,0CBh,0C9h,0FFh,0FFh,0F9h,0DFh,0FBh,0F3h,0D3h,093h,0FFh,0FFh,09Fh,0F7h
    db 000h,000h,0C0h,0F0h,0F8h,0F8h,0FCh,0FCh,03Fh,03Fh,03Fh,03Fh,03Fh,03Fh,03Fh,03Fh
    db 040h,073h,033h,017h,01Fh,00Fh,003h,000h,006h,0CEh,0CCh,0ECh,0F8h,0F0h,0C0h,000h
    db 0FCh,0FCh,0FCh,0FCh,0FCh,0FCh,0FCh,0FCh,03Fh,03Fh,03Fh,03Fh,01Fh,01Fh,00Fh,007h
    db 080h,080h,0C0h,0F8h,0FFh,0FFh,0FFh,0FFh,000h,000h,000h,078h,084h,01Fh,003h,01Fh
    db 0FCh,0FCh,0FCh,0E4h,092h,081h,0F1h,081h,003h,001h,001h,001h,001h,001h,001h,001h
    db 0FFh,0FFh,01Fh,000h,000h,000h,000h,0FFh,002h,00Ch,0F0h,000h,000h,000h,000h,0FFh
    db 0F2h,084h,0F8h,080h,080h,080h,080h,080h,07Fh,07Eh,0FEh,0FEh,0FEh,0FEh,0FEh,07Eh
    db 0FEh,07Eh,07Fh,07Fh,07Fh,07Fh,07Fh,07Eh,0FEh,082h,0FEh,08Eh,076h,0FEh,0FEh,0FEh
    db 07Fh,041h,07Fh,071h,06Eh,07Fh,07Fh,07Fh,0FFh,03Fh,00Fh,007h,003h,000h,000h,001h
    db 099h,0BDh,07Eh,0FFh,0FFh,0E5h,0E5h,0E1h,0FEh,0F8h,0E0h,0C0h,080h,000h,000h,000h
    db 01Bh,03Dh,07Eh,07Eh,07Eh,0FFh,0FFh,0FFh,0F3h,0FFh,0A0h,0A0h,0A0h,0A0h,0A0h,0A0h
    db 080h,0C0h,0C0h,0C0h,0C0h,0E0h,0F6h,0FEh,0E7h,0C3h,0DBh,0DBh,0DBh,0DBh,0C3h,0E7h
    db 0A0h,0A0h,0A0h,0A0h,0FFh,0FFh,0A0h,0A0h,0FFh,0BFh,087h,086h,08Fh,08Fh,086h,086h
    db 0FFh,0FFh,0FFh,07Eh,07Eh,07Eh,03Ch,018h,0A0h,0A0h,0A0h,0A0h,0A0h,0A0h,0A0h,0A0h
    db 086h,086h,086h,086h,086h,086h,086h,086h,0FFh,077h,077h,077h,077h,07Fh,07Fh,07Fh
    db 086h,006h,006h,006h,006h,006h,086h,0C2h,002h,006h,00Ch,00Fh,007h,000h,000h,001h
    db 03Ch,07Eh,0FFh,0FFh,099h,0FFh,0FFh,0E7h,040h,060h,030h,0F0h,0E0h,000h,000h,080h
    db 007h,00Fh,01Fh,01Fh,01Fh,01Fh,01Fh,01Fh,0C3h,03Ch,000h,000h,080h,080h,080h,0C0h
    db 0FFh,0FBh,0FBh,0FBh,0FBh,0FBh,0FBh,0FBh,01Fh,00Fh,00Fh,00Fh,007h,007h,007h,003h
    db 0C0h,0E0h,0F6h,0FEh,0FFh,0FFh,0FFh,0FEh,0FBh,0FBh,0FBh,0FBh,0FBh,0FBh,0FBh,0FBh
    db 003h,003h,003h,003h,007h,00Dh,019h,031h,0FEh,0FEh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,07Eh,07Eh,07Eh,0BCh,0BCh,0D8h,060h,0C0h,080h,000h,000h,000h,001h,003h
    db 0B2h,0B2h,0B2h,0B2h,0B2h,0B2h,072h,0F3h,0C0h,0C0h,0C0h,0C0h,0C0h,0C0h,0E0h,0F0h
    db 000h,001h,003h,007h,007h,005h,000h,000h,07Ch,0FEh,0FFh,0E1h,0DBh,0C5h,0E5h,0F3h
    db 000h,005h,007h,007h,002h,002h,002h,082h,003h,007h,00Fh,00Fh,01Fh,01Dh,01Dh,01Dh
    db 0CDh,081h,080h,0C0h,0C1h,0C1h,0E1h,0E1h,0C2h,0C2h,0C2h,0C2h,0E2h,0F2h,0FAh,0FFh
    db 01Dh,01Dh,01Dh,01Eh,01Fh,00Fh,00Fh,00Fh,0E1h,0F3h,0F3h,0F3h,0F3h,0FBh,0FFh,0FFh
    db 0FFh,0FFh,0FEh,0FEh,0FEh,0FEh,0FAh,07Ah,007h,007h,00Bh,00Bh,00Dh,00Dh,01Dh,01Dh
    db 0F7h,0F7h,0F7h,0E7h,0E7h,0E3h,0E3h,0E3h,07Ah,0BAh,0BAh,0BAh,0BAh,0B2h,0B2h,0B2h
    db 01Eh,01Eh,03Eh,03Fh,03Fh,07Fh,0FFh,0FFh,0E3h,0E3h,0E3h,0C1h,0C1h,0C1h,0C1h,0C1h
    db 092h,092h,0C2h,0C2h,0C2h,0E2h,0E2h,0F2h,020h,020h,020h,020h,020h,020h,020h,020h
    db 020h,020h,020h,020h,020h,0F8h,070h,0F0h,0F0h,0F8h,07Ch,01Eh,00Fh,007h,007h,003h
    db 020h,036h,020h,028h,021h,093h,0DFh,0F1h,0E0h,0E0h,0E0h,0E0h,0E0h,0C0h,080h,0C0h
    db 003h,003h,003h,003h,007h,007h,00Fh,00Fh,0FFh,0E0h,0E0h,0E0h,0E0h,0E0h,0FFh,0E0h
    db 0F0h,0F8h,0FCh,0FCh,0DEh,0DEh,0EFh,0EFh,00Fh,00Fh,01Eh,01Dh,01Bh,017h,017h,007h
    db 0FFh,07Fh,0FFh,0FFh,0FFh,0FFh,0E3h,0C0h,0F7h,0F7h,0FFh,0CFh,08Fh,0DFh,0FFh,0FFh
    db 000h,080h,080h,0C0h,0E0h,0F0h,0F8h,0FEh

Font:
    ; db[256]
    db 003h,003h,001h,001h,000h,000h,001h,003h,0C0h,0C0h,0E0h,0E0h,0F0h,0F0h,0F8h,0F8h
    db 07Eh,01Fh,00Fh,007h,003h,001h,000h,000h,000h,000h,080h,0C0h,0E0h,0F0h,0FCh,0FEh
    db 000h,000h,000h,000h,000h,000h,03Ch,0FFh,001h,003h,007h,003h,007h,00Fh,003h,005h
    db 0FFh,0FFh,088h,0AAh,0FFh,0FFh,0E3h,0DDh,080h,0C0h,0E0h,080h,0C0h,0C0h,0C0h,080h
    db 00Eh,01Fh,01Fh,01Dh,03Dh,07Fh,07Bh,071h,0FFh,0BDh,081h,081h,081h,081h,0FFh,081h
    db 0E0h,0F0h,0F0h,0B8h,0B8h,0FCh,0DCh,08Ch,019h,01Fh,033h,063h,0C3h,087h,00Ah,00Fh
    db 0FFh,0FFh,0FFh,0EFh,0C7h,083h,082h,083h,0C8h,070h,080h,080h,080h,0C0h,0A0h,0E0h
    db 0FCh,0FCh,0FEh,0FEh,0FFh,0FFh,0BFh,0BFh,000h,000h,000h,000h,000h,080h,0E3h,0FFh
    db 000h,000h,000h,000h,000h,000h,0F0h,0FCh,000h,004h,004h,026h,027h,023h,023h,020h
    db 000h,000h,018h,02Ch,05Eh,0DFh,09Fh,09Fh,000h,020h,020h,060h,0E0h,0C0h,0C0h,000h
    db 020h,020h,020h,020h,023h,025h,02Bh,02Fh,0C1h,0B6h,0D5h,0C1h,05Dh,0E3h,0BEh,0DDh
    db 000h,000h,03Ch,06Eh,06Eh,0DFh,0DBh,0DDh,025h,025h,025h,02Dh,07Fh,053h,05Eh,07Ch
    db 0CFh,0CFh,0CFh,0CFh,0CFh,0FFh,081h,0FFh,0DDh,0DBh,0DFh,06Eh,06Eh,03Ch,000h,000h
    db 020h,021h,021h,021h,021h,022h,022h,022h,0FFh,07Eh,03Ch,03Ch,024h,024h,024h,042h
    db 000h,080h,080h,080h,080h,040h,040h,040h,022h,024h,027h,025h,025h,02Bh,037h,07Fh
    db 042h,042h,081h,081h,000h,000h,000h,000h,040h,020h,0E0h,060h,0A0h,0B0h,0B8h,0FEh

LDA1B:
    ; db[768]
    db 000h,000h,000h,000h,000h,000h,000h,000h,00Ch,00Ch,00Ch,00Ch,00Ch,000h,00Ch,000h
    db 066h,066h,000h,000h,000h,000h,000h,000h,07Fh,041h,041h,041h,041h,041h,07Fh,000h
    db 000h,008h,03Eh,028h,03Eh,00Ah,03Eh,008h,066h,066h,033h,000h,000h,000h,000h,000h
    db 033h,033h,066h,000h,000h,000h,000h,000h,00Ch,00Ch,018h,000h,000h,000h,000h,000h
    db 00Ch,018h,018h,018h,018h,018h,00Ch,000h,018h,00Ch,00Ch,00Ch,00Ch,00Ch,018h,000h
    db 000h,000h,014h,008h,03Eh,008h,014h,000h,000h,000h,008h,008h,03Eh,008h,008h,000h
    db 000h,000h,000h,000h,000h,00Ch,00Ch,018h,000h,000h,000h,000h,03Eh,000h,000h,000h
    db 000h,000h,000h,000h,000h,018h,018h,000h,000h,000h,002h,004h,008h,010h,020h,000h
    db 01Ch,036h,063h,063h,063h,036h,01Ch,000h,00Ch,01Ch,03Ch,00Ch,00Ch,00Ch,03Fh,000h
    db 03Eh,063h,073h,006h,00Ch,031h,07Fh,000h,07Fh,046h,00Ch,01Eh,003h,063h,03Eh,000h
    db 006h,00Eh,01Eh,036h,07Fh,006h,00Fh,000h,07Fh,060h,07Eh,063h,003h,063h,03Eh,000h
    db 00Eh,018h,030h,07Eh,063h,063h,03Eh,000h,07Fh,046h,00Ch,018h,018h,018h,018h,000h
    db 03Eh,063h,063h,03Eh,063h,063h,03Eh,000h,03Eh,063h,063h,03Fh,006h,00Ch,038h,000h
    db 000h,000h,00Ch,00Ch,000h,00Ch,00Ch,000h,000h,000h,00Ch,00Ch,000h,00Ch,00Ch,018h
    db 000h,000h,004h,008h,010h,008h,004h,000h,000h,000h,000h,03Eh,000h,03Eh,000h,000h
    db 000h,000h,010h,008h,004h,008h,010h,000h,03Eh,063h,073h,006h,00Ch,000h,00Ch,000h
    db 000h,03Ch,04Ah,056h,05Eh,040h,03Ch,000h,01Ch,037h,063h,063h,07Fh,033h,07Bh,000h
    db 07Eh,063h,063h,07Eh,063h,063h,07Eh,000h,01Eh,033h,060h,060h,060h,033h,01Eh,000h
    db 06Ch,076h,063h,063h,063h,076h,06Ch,000h,07Fh,031h,030h,03Eh,030h,031h,07Fh,000h
    db 07Fh,031h,030h,03Eh,030h,030h,070h,000h,01Eh,033h,060h,06Fh,063h,033h,01Eh,000h
    db 063h,063h,063h,07Fh,063h,063h,063h,000h,03Fh,00Ch,00Ch,00Ch,00Ch,00Ch,03Fh,000h
    db 07Fh,046h,006h,006h,006h,066h,03Ch,000h,063h,066h,06Ch,078h,06Ch,066h,063h,000h
    db 070h,060h,060h,060h,060h,061h,07Fh,000h,063h,077h,07Fh,06Bh,063h,063h,063h,000h
    db 063h,073h,07Bh,06Fh,067h,063h,063h,000h,01Ch,036h,063h,063h,063h,036h,01Ch,000h
    db 06Eh,073h,063h,063h,07Eh,060h,060h,000h,01Ch,036h,063h,063h,06Bh,036h,01Dh,000h
    db 06Eh,073h,063h,063h,07Eh,066h,063h,000h,03Eh,063h,060h,03Eh,003h,063h,03Eh,000h
    db 07Fh,059h,018h,018h,018h,018h,018h,000h,073h,033h,063h,063h,063h,063h,03Eh,000h
    db 073h,033h,063h,063h,066h,03Ch,018h,000h,076h,033h,063h,063h,06Bh,06Bh,036h,000h
    db 077h,063h,036h,01Ch,036h,063h,077h,000h,077h,063h,036h,01Ch,018h,018h,018h,000h
    db 07Fh,043h,006h,00Ch,018h,031h,07Fh,000h,000h,00Eh,008h,008h,008h,008h,00Eh,000h
    db 000h,000h,040h,020h,010h,008h,004h,000h,000h,070h,010h,010h,010h,010h,070h,000h
    db 000h,010h,038h,054h,010h,010h,010h,000h,000h,000h,000h,000h,000h,000h,000h,0FFh
    db 000h,01Ch,022h,078h,020h,020h,07Eh,000h,000h,000h,03Dh,067h,063h,067h,03Bh,000h
    db 060h,060h,06Eh,073h,063h,073h,06Eh,000h,000h,000h,03Eh,063h,060h,063h,03Eh,000h
    db 038h,00Ch,03Eh,067h,063h,063h,03Eh,000h,000h,000h,03Eh,063h,07Fh,060h,03Fh,000h
    db 036h,03Bh,030h,030h,07Ch,030h,030h,060h,000h,000h,03Eh,063h,060h,067h,03Eh,006h
    db 060h,060h,06Eh,073h,063h,066h,06Fh,000h,006h,000h,01Ch,00Ch,00Ch,00Ch,01Ch,000h
    db 006h,000h,01Ch,00Ch,00Ch,00Ch,04Ch,038h,060h,060h,066h,06Ch,078h,06Ch,067h,000h
    db 018h,018h,018h,018h,018h,01Ah,01Eh,000h,000h,000h,056h,07Fh,06Bh,063h,066h,000h
    db 000h,000h,06Eh,073h,063h,066h,06Fh,000h,000h,000h,03Eh,063h,063h,063h,03Eh,000h
    db 000h,000h,06Eh,073h,063h,073h,06Eh,060h,000h,000h,03Bh,067h,063h,067h,03Bh,003h
    db 000h,000h,06Eh,073h,063h,07Eh,063h,000h,000h,000h,01Eh,030h,01Eh,047h,03Eh,000h
    db 00Ch,018h,07Eh,030h,030h,032h,01Ch,000h,000h,000h,07Bh,033h,063h,067h,03Bh,000h
    db 000h,000h,076h,033h,063h,066h,03Ch,000h,000h,000h,076h,063h,06Bh,03Eh,014h,000h
    db 000h,000h,077h,036h,01Ch,036h,077h,000h,000h,000h,076h,033h,01Bh,00Eh,04Ch,038h
    db 000h,000h,07Fh,046h,00Ch,039h,07Fh,000h,07Fh,041h,041h,041h,041h,041h,07Fh,000h
    db 07Fh,07Fh,07Fh,07Fh,07Fh,07Fh,07Fh,000h,07Fh,063h,055h,049h,055h,063h,07Fh,000h
    db 07Fh,041h,041h,041h,041h,041h,07Fh,000h,07Fh,055h,06Bh,055h,06Bh,055h,07Fh,000h

ShieldInc:
    ; db[296]
    db 000h,000h,000h,000h,000h,000h,000h,000h,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FFh,07Fh,07Fh,07Fh,03Fh,03Fh,03Fh,01Fh,01Fh,00Fh,00Fh,007h,007h,003h,001h
    db 0FFh,07Fh,03Fh,01Fh,00Fh,007h,003h,001h,0FFh,0FFh,0FEh,0FEh,0FEh,0FCh,0FCh,0FCh
    db 0F8h,0F8h,0F0h,0F0h,0E0h,0E0h,0C0h,080h,0FFh,0FEh,0FCh,0F8h,0F0h,0E0h,0C0h,080h
    db 00Fh,0C1h,0E0h,0F0h,0F8h,0F8h,0FCh,0FCh,0FFh,0FFh,07Fh,03Fh,01Fh,00Fh,007h,007h
    db 0FCh,0FEh,0FEh,0FEh,0FEh,0FEh,0FEh,0FCh,003h,003h,003h,003h,003h,003h,003h,003h
    db 0FCh,0FCh,0F8h,0F8h,0F0h,0E0h,0C1h,00Fh,007h,007h,00Fh,01Fh,03Fh,07Fh,0FFh,0FFh
    db 0FEh,0FFh,0DEh,0FEh,0F6h,0FFh,0FCh,044h,0FCh,0FFh,0F6h,0FEh,0DEh,0FFh,0FEh,0FFh
    db 0FFh,0FFh,0F7h,0FFh,0DFh,0FFh,07Fh,045h,07Fh,0FFh,0DFh,0FFh,0F7h,0FFh,0FFh,0FFh
    db 0F7h,0F7h,0F7h,0E3h,0E3h,0E3h,0C5h,082h,082h,086h,0CDh,0E3h,0FFh,0FFh,0FFh,0FFh
    db 0FFh,0FCh,0F8h,0C6h,01Eh,0E3h,0FCh,0FFh,000h,018h,03Ch,03Ch,018h,000h,000h,081h
    db 0FFh,03Fh,01Fh,063h,078h,0C7h,03Fh,0FFh,000h,000h,0FFh,0F0h,0F0h,0FFh,0FCh,0FCh
    db 00Eh,00Ch,00Dh,006h,000h,0C0h,000h,000h,010h,010h,030h,060h,000h,003h,000h,000h
    db 000h,000h,0FFh,00Fh,00Fh,0FFh,03Fh,03Fh,0F8h,0F8h,0F9h,0F3h,0E3h,0D5h,0D5h,0FFh
    db 01Fh,01Fh,09Fh,0CFh,0C7h,0ABh,0ABh,0FFh,077h,022h,000h,080h,0B6h,094h,080h,0DCh
    db 07Fh,060h,04Fh,0E0h,0FFh,000h,000h,000h,0FFh,000h,0FFh,000h,0FFh,000h,000h,000h
    db 0F1h,003h,0FFh,003h,0F9h,003h,00Fh,00Fh,0E1h,0FEh,0C0h,080h,09Fh,01Fh,01Fh,0FFh
    db 000h,000h,01Fh,03Fh,0CFh,0C7h,0E3h,0C3h,001h,03Eh,0C0h,080h,09Fh,01Fh,01Fh,0FFh
    db 00Fh,01Fh,027h,0E3h,0E3h,0F1h,0F1h,0E1h

; Save/Load variables
SingleShotSaveFlag: db 00h
LoadSaveFlag:       db 00h
FileMatchPattern:   ds "LOM-????.GAM"
FileSingleSlot:     ds "LOM-A000.GAM"          ; Filename for the single shot save functionality

SaveLoadGameBuffer:
    db 155 dup (?)

SwapkeysData:
    db 005h,004h,003h,006h,000h,002h,007h,000h,001h

; VIDEO.ASM
InitialiseVideo:
    MOV         AX,0x13                        ; BIOS Video: Write String
    INT         0x10                           ; BIOS Interrupt (Vieo Services)
    MOV         AH,0x4a                        ; DOS: Reallocate memory
    MOV         BX,0x1000
    PUSH        DS
    POP         ES
    INT         0x21                           ; BIOS Interrupt (DOS API)
    JC          LAB_0000_2c77
    MOV         AH,0x48                        ; DOS: Allocate memory
    MOV         BX,0xfa0
    INT         0x21                           ; BIOS Interrupt (DOS API)
    JC          LAB_0000_2c77
    MOV         [TemporaryVideoVariable],AX
    MOV         ES,AX
    XOR         DI,DI
    MOV         CX,0x7d00
    XOR         AX,AX
    STOSW.REP   ES:DI
    CALL        SetVideoPaletteRegisters
    RET


Trans_Screen:
    PUSHA
    PUSH        ES
    MOV         AX,[TemporaryVideoVariable]
    MOV         ES,AX
    MOV         DI,0x0
    MOV         SI,Screen
    MOV         BX,SI
    ADD         BX,0x1800
    MOV         CX,0x3
LAB_0000_c92e:
    PUSH        CX
    MOV         CX,0x8
LAB_0000_c932:
    PUSH        CX
    MOV         CX,0x8
LAB_0000_c936:
    PUSH        CX
    MOV         CX,0x20
LAB_0000_c93a:
    LODSB       SI
    CALL        FUN_0000_c9ff
    MOV         AL,DL
    TEST        AH,0x80
    JZ          LAB_0000_c947
    MOV         AL,DH
LAB_0000_c947:
    STOSB       ES:DI
    MOV         AL,DL
    TEST        AH,0x40
    JZ          LAB_0000_c951
    MOV         AL,DH
LAB_0000_c951:
    STOSB       ES:DI
    MOV         AL,DL
    TEST        AH,0x20
    JZ          LAB_0000_c95b
    MOV         AL,DH
LAB_0000_c95b:
    STOSB       ES:DI
    MOV         AL,DL
    TEST        AH,0x10
    JZ          LAB_0000_c965
    MOV         AL,DH
LAB_0000_c965:
    STOSB       ES:DI
    MOV         AL,DL
    TEST        AH,0x8
    JZ          LAB_0000_c96f
    MOV         AL,DH
LAB_0000_c96f:
    STOSB       ES:DI
    MOV         AL,DL
    TEST        AH,0x4
    JZ          LAB_0000_c979
    MOV         AL,DH
LAB_0000_c979:
    STOSB       ES:DI
    MOV         AL,DL
    TEST        AH,0x2
    JZ          LAB_0000_c983
    MOV         AL,DH
LAB_0000_c983:
    STOSB       ES:DI
    MOV         AL,DL
    TEST        AH,0x1
    JZ          LAB_0000_c98d
    MOV         AL,DH
LAB_0000_c98d:
    STOSB       ES:DI
    LOOP        LAB_0000_c93a
    POP         CX
    ADD         DI,0x700
    LOOP        LAB_0000_c936
    POP         CX
    SUB         DI,Screen[4259]
    SUB         BX,0x100
    LOOP        LAB_0000_c932
    ADD         DI,Screen[2467]
    ADD         BX,0x100
    POP         CX
    LOOP        LAB_0000_c92e
    CALL        FUN_0000_c9b3
    POP         ES
    POPA
    RET


FUN_0000_c9b3:
    PUSH        DS
    MOV         DX,0x3da
LAB_0000_c9b7:
    IN          AL,DX
    TEST        AL,0x8
    JNZ         LAB_0000_c9b7
LAB_0000_c9bc:
    IN          AL,DX
    TEST        AL,0x8
    JZ          LAB_0000_c9bc
    MOV         AX,0xa000
    MOV         ES,AX
    MOV         AL,[_border]
    PUSH        word ptr [TemporaryVideoVariable]
    POP         DS
    XOR         DI,DI
    MOV         CX,0x520
    STOSB.REP   ES:DI
    XOR         SI,SI
    MOV         CX,0xc0
LAB_0000_c9da:
    PUSH        CX
    MOV         CX,0x80
    MOVSW.REP   ES:DI,SI
    MOV         CX,0x40
    STOSB.REP   ES:DI
    POP         CX
    LOOP        LAB_0000_c9da
    MOV         CX,0x4e0
    STOSB.REP   ES:DI
    POP         DS
    RET


SetVideoPaletteRegisters:
    MOV         AX,0x1012
    XOR         BX,BX
    MOV         CX,0x10
    PUSH        CS
    POP         ES
    MOV         DX,VideoPaletteData            ; BIOS Video: Set Palette Registers
    INT         0x10                           ; BIOS Interrupt (Vieo Services)
    RET


FUN_0000_c9ff:
    MOV         AH,byte ptr [BX]
    INC         BX
    MOV         DL,AH
    MOV         DH,AH
    AND         AH,0x40
    AND         DH,0x7
    AND         DL,0x38
    SHR         DL,0x3
    SHR         AH,0x3
    OR          DL,AH
    OR          DH,AH
    MOV         AH,AL
    RET

TemporaryVideoVariable:
    dw 0000h
VideoPaletteData:
    db 000h,000h,000h,000h,000h,028h,037h,000h
    db 000h,039h,000h,02Dh,000h,035h,000h,000h
    db 035h,035h,034h,034h,000h,032h,032h,032h
    db 000h,000h,000h,000h,000h,02Bh,03Ch,000h
    db 000h,03Fh,000h,037h,000h,03Ch,000h,000h
    db 03Fh,03Fh,03Fh,03Fh,000h,03Fh,03Fh,03Fh
_border:
    db 00h

; PRINTER.ASM
Dumpscreen:
    MOV         word ptr [PrinterVar2],0x0
    MOV         DI,PrinterDataArea[320]
    MOV         SI,Screen[6144]
    MOV         CX,0x300
    MOVSB.REP   ES:DI,SI
    MOV         DI,Screen[6144]
    MOV         CX,0x300
    MOV         AL,0x7
    STOSB.REP   ES:DI
    CALL        Trans_Screen
    PUSH        ES
    CALL        FUN_0000_cb32
    CALL        DumpscreenESinit
    MOV         CX,0x28
    MOV         word ptr [PrinterVar1],0x27
LAB_0000_ca7d:
    PUSH        CX
    CALL        FUN_0000_caa9
    SUB         word ptr [PrinterVar1],0x1
    POP         CX
    LOOP        LAB_0000_ca7d
    MOV         AL,0x1b
    CALL        Dumpscreen_SetDiskType
    MOV         AL,0x32
    CALL        Dumpscreen_SetDiskType
    POP         ES
    MOV         SI,PrinterDataArea[320]
    MOV         DI,Screen[6144]
    MOV         CX,0x300
    MOVSB.REP   ES:DI,SI
    CALL        Trans_Screen
    RET


DumpscreenESinit:
    MOV         AX,0xa000
    MOV         ES,AX
    RET


FUN_0000_caa9:
    MOV         CX,0xc8
    MOV         DI,PrinterDataArea
    MOV         BX,word ptr [PrinterVar1]
LAB_0000_cab3:
    PUSH        CX
    MOV         DH,0x80
    MOV         DL,0x1
    MOV         CX,0x8
LAB_0000_cabb:
    MOV         AL,byte ptr ES:[BX]
    TEST        DH,AL
    JNZ         LAB_0000_cac4
    OR          byte ptr [DI],DL
LAB_0000_cac4:
    ROR         DH,0x1
    ROL         DL,0x1
    LOOP        LAB_0000_cabb
    ADD         BX,0x28
    INC         DI
    POP         CX
    LOOP        LAB_0000_cab3
    CALL        FUN_0000_cad5
    RET


FUN_0000_cad5:
    INC         word ptr [PrinterVar2]
    CMP         word ptr [PrinterVar2],0x8
    JL          LAB_0000_cb16
    CMP         word ptr [PrinterVar2],0x28
    JZ          LAB_0000_cb16
    MOV         AL,0x1b
    CALL        Dumpscreen_SetDiskType
    MOV         AL,0x4b
    CALL        Dumpscreen_SetDiskType
    MOV         AL,0xc0
    CALL        Dumpscreen_SetDiskType
    MOV         AL,0x0
    CALL        Dumpscreen_SetDiskType
    PUSH        CX
    MOV         DI,PrinterDataArea
    MOV         CX,0xc0
LAB_0000_cb02:
    MOV         BL,byte ptr [DI]
    MOV         AL,BL
    CALL        Dumpscreen_SetDiskType
    INC         DI
    LOOP        LAB_0000_cb02
    MOV         AL,0xd
    CALL        Dumpscreen_SetDiskType
    MOV         AL,0xa
    CALL        Dumpscreen_SetDiskType
LAB_0000_cb16:
    PUSH        ES
    PUSH        DI=>PrinterDataArea[1]
    PUSH        AX
    PUSH        DS
    POP         ES
    CLD
    MOV         CX,0x140
    MOV         DI,PrinterDataArea
    MOV         AL,0x0
    STOSB.REP   ES:DI
    POP         AX
    POP         DI
    POP         ES
    POP         CX
    RET


Dumpscreen_SetDiskType:
    XOR         AH,AH
    XOR         DX,DX
    INT         0x17                           ; BIOS Interrupt (Printer Character to Printer)
    RET


FUN_0000_cb32:
    MOV         AL,0x1b
    CALL        Dumpscreen_SetDiskType
    MOV         AL,0x40
    CALL        Dumpscreen_SetDiskType
    MOV         AL,0x1b
    CALL        Dumpscreen_SetDiskType
    MOV         AL,0x33
    CALL        Dumpscreen_SetDiskType
    MOV         AL,0x18
    CALL        Dumpscreen_SetDiskType
    RET

PrinterVar1:     dw 0000h
PrinterDataArea: db 1088 dup (?)
PrinterVar2:     dw 0000h

; END OF PRINTER.ASM

; Position Table (L65CF)
PositionTable:
    db 0Ch,14h,10h,04h,08h,18h,00h,1Ch         ; Column positions

; Meanies data table (L65D7)
MeaniesDataTable:
    db 05h,06h,07h,0Ch,0Dh                     ; MeaniesTable

L676B: db 65h

LASTK: db 00h

; Jump table for various functions
SelectRoutineJumpTable:
    dw CharacterSeek
    dw HideCharacter
    dw StartFight
    dw RecruitCharacter
    dw RecruitMen
    dw Guardmen
    dw Battle
; END OF MIDNIGHT.ASM code

;
; VARIABLES
;
LuxorMorkinFlag:              db   00h
IceCrownFlag:                 db   00h
CharInHereTable:              db   00h
KeyReturnStatus:              db   00h
ArmyToMoveLocation:           dw   00h
Route_One:                    db   00h
Route_Two:                    db   00h
Route_Three:                  db   00h
Route_Four:                   db   00h
WhichMenDidCharLose:          db   00h
StartofFreeTable:             dw   00h
StartOfDoomDarksTable:        dw   00h
LastFreeArmyInTable:          db   00h
LastDoomDarksArmyInTable:     db   00h
HowManyFreeArmy:              db   00h
FreeArmySuccessChance:        db   00h
NoOfDoomDarksDead:            db   00h
WhichFreeArmy:                db   00h
HowManyDoomDarksArmy:         db   00h
DoomDarksArmySuccessChance:   db   00h
NoOfFreeDead:                 db   00h
WhichDoomDarksArmy:           db   00h
FreeArmyPosInTable:           db   00h
DoomDarksArmyPosInTable:      db   00h
NoInCharHereTable:            db   00h
DoomDarksElite_Location:      dw   00h
DoomDarksElite_Total:         db   00h
DoomDarksElite_ID:            db   00h
DoomDarksElite_Orders:        db   00h
DoomDarksElite_Type:          db   00h
Headquarters_Location:        dw   00h
Headquarters_ArmyOne:         db   00h
Headquarters_ArmyTwo:         db   00h
WhoseRaceIsArmy:              db   00h
HowManyGuardsThePlace:        db   00h
WhoGuardsThePlace:            db   00h
Army_DoomDarksElite:          db   00h
Army_Headquarters:            db   00h
Army_Details:                 db   00h
ArmyLocation:                 dw   00h
IncRidersEnergyBy:            db   00h
FreeArmyHere:                 db   00h
DoomDarksArmyHere:            db   00h
CharHereTable:
    db 00h,00h,00h,00h,00h,00h,00h,00h
    db 00h,00h,00h,00h,00h,00h,00h,00h
    db 00h,00h,00h,00h,00h,00h,00h,00h
    db 00h,00h,00h,00h,00h,00h,00h,00h
PosInCharHereTable:           dw   00h
IceFear:                      dw   00h
DoomDarksCitadels:            db   00h
PositionOfTowerOfDespair:     dw 051Ah         ; Hard-wired to location 0x051A
FreeArmyStillLeft:            db   00h
DoomDarksArmyStillLeft:       db   00h
BattleVictory:                db   00h
ArmyLoopCurrent:              db   00h
NoOfFreeArmiesAndChars:       db   00h
TotalNoOfArmiesHere:          db   00h
EnemyMoveCount:               db   00h
TempTotalOfArmies:            db   00h
WhatObjectFlag:               db   00h
WhatObject:                   db   00h
ObjectToDescribe:             db   00h
DoomDarks_Warriors:           dw   00h
DoomDarks_Riders:             dw   00h
NoOfDeathsDescribed:          db   00h
Think_TempOne:                db   00h
HowManyCharsInFrontDescribed: db   00h
Think_TempThree:              db   00h
ChooseKeyTable:
    db 00h,00h,00h,00h,00h,00h,00h
CharInLocation:               db   00h
TempCharRecruitingKey:        db   00h
CanCharMoveForward:           db   00h
LocationToMoveTo:             dw   00h
PrintCharacterCount:          db   00h
LFEFE:                        db   00h
LFEFF:                        db   00h
Image_XPixel:                 dw   00h
Image_YPixel:                 db   00h
LFF03:                        db   00h
LFF04:                        db   00h
LFF05:                        db   00h
LFF06:                        db   00h
LFF07:                        db   00h
LFF08:                        db   00h
Image_PlotOnOff:              db   00h
Image_YOffset:                db   00h
Image_Height:                 db   00h
Image_AnotherBit:             db   00h
Image_DrawInstrucs:           db   00h
FeatureAddress:               dw   00h
Feature_Draw:                 db   00h
Feature_Size:                 db   00h
Print_Ink:                    db   00h
WorkingLocation:              dw   00h
LocationFeature:              db   00h
LocationObject:               db   00h
LocationArea:                 db   00h
LocDomainFlag:                db   00h
LocSpecialFlag:               db   00h
Landscape_ScrAdjustDoWhat:    db   00h
Landscape_LeftScrDoWhat:      db   00h
Landscape_RightScrDoWhat:     db   00h
Landscape_XAdjustDoWhat:      db   00h
Landscape_LeftXAdjustDoWhat:  db   00h
Landscape_RightXAdjustDoWhat: db   00h
Landscape_YAdjustDoWhat:      db   00h
Landscape_LeftYAdjustDoWhat:  db   00h
Landscape_RightYAdjustDoWhat: db   00h
Landscape_YAdjustDoWhat:      db   00h
Landscape_XAdjustDoWhat:      db   00h
Landscape_ScrAdjust:          dw   00h
CurrentLocation:              dw   00h
CurrentlyLooking:             db   00h
LandscapePosition:            db   00h
Print_Col:                    db   00h
Print_Row:                    db   00h
Print_Attr:                   db   00h
Print_Char:                   db   00h
Print_Mask:                   db   00h
CharacterToPrint:             db   00h
Window_Attr:                  db   00h
Window_Width:                 db   00h
Window_Depth:                 db   00h
Column:                       db   00h
Row:                          db   00h
Print_Temp:                   db   00h
LFF37:                        db   00h
TextBuffer:                   dw   00h
ViewPoint_Col:                db   00h
ViewPoint_Row:                db   00h
ViewPoint_StartCol:           db   00h
ViewPoint_Width:              db   00h
PrintBufferStart:             dw   00h
TextLength:                   db   00h
MakeFirstCharUpper:           db   00h
UpperCaseFlag:                db   00h
PrintBufferPos:               dw   00h
QuantityFlag:                 db   00h
TempVar:                      db   00h
LFF47:                        db   00h
LFF48:                        db   00h
LFF49:                        db   00h
LocationLookingAt:            dw   00h
DesirableLocation:            dw   00h
MapYLookAdjust:               db   00h
MapXLookAdjust:               db   00h
StartOfTokenTable:            dw   00h
LookForwardCount:             db   00h
Shield_Paper:                 db   00h
Shield_Ink:                   db   00h
ShieldNumber:                 db   00h
LowerWindowAttr:              db   00h
TempCharacterNo:              db   00h
NoOfUnits:                    db   00h
NoOfTens:                     db   00h
NoOfHundreds:                 db   00h
NoOfThousands:                db   00h
NoOfMillions:                 db   00h
RandomSeed:                   dw   00h
LFF5F:                        db   00h
CharLocation:                 dw   00h
CharLookDirection:            db   00h
CharTimeOfDay:                db   00h
CharFirstName:                db   00h
CharTitle:                    db   00h
CharAvailable:                db   00h
CharGraphicType:              db   00h
CharNoRiders:                 db   00h
CharRidersEnergyStatus:       db   00h
CharNoWarriors:               db   00h
CharWarriorsEnergyStatus:     db   00h
CharBattleArea:               db   00h
CharRidersLost:               db   00h
CharWarriorsLost:             db   00h
CharSlew:                     db   00h
CharRidersSlew:               db   00h
CharWarriorsSlew:             db   00h
CharBattleStatus:             db   00h
CharLifeStatus:               db   00h
CharEnergyStatus:             db   00h
CharFightStrength:            db   00h
CharCowardess:                db   00h
CharRecruitingKey:            db   00h
CharRecruitedBy:              db   00h
CharCourageStatus:            db   00h
LFF7A:                        db   00h
CharHideFlag:                 db   00h
CharRace:                     db   00h
CharHasAHorse:                db   00h
CharObjectCarrying:           db   00h
CharDeathStatus:              db   00h
FRAMES:                       dw   00h
CHARS:                        dw   00h
AFEXTRA1:                     dw   00h
AFEXTRA2:                     dw   00h
R:                            db   00h

; Number Tables (LE20E)
NumberTable1:
    db 06Ch,0B3h,0B4h,0B5h,066h,0B7h,068h,069h
    db 06Ah,06Bh
NumberTable2:
    db 0B5h,0B6h,0B7h,068h,069h,06Ah,06Bh

WhereTable:
    db 054h,05Dh,054h,05Dh,05Dh,054h,05Eh,05Dh
    db 05Dh,05Fh,054h,054h,05Dh,05Dh,054h,05Eh
DirectionTable:
    db 057h,000h,057h,059h,059h,000h,058h,059h
    db 058h,000h,058h,05Ah,05Ah,000h,057h,05Ah
DirectionLookTable:
    db 000h,0FFh,001h,0FFh,001h,000h,001h,001h
    db 000h,001h,0FFh,001h,0FFh,000h,0FFh,0FFh

; Objects Description Table (LEE2A)
ObjectDescriptionLookupTable:
    dw LE4D8,LE4DA,LE4DC,LE4E0
    dw LE4E5,LE4E7,LE4EC,LE4F1
    dw LE4FB,LE4CC,LE507,LE515
    dw LE520,LE527,LE534,LE52E
    dw LE53A,LE540,LE489,LE48E

; Token data table for game messages (L6272)
TokensEndOfDayMsg:
    db 0BEh,0FEh,065h,0FEh,064h,0C2h,000h      ; 'Passed Since The'
    db 0FCh,0BFh,040h,000h                     ; 'War Of The'
    db 0FCh,0C0h,0C1h,0FEh,02Eh,0FFh           ; 'Solstice Began.'
    db 0FCh,05Ch,082h,084h,085h,086h,087h,07Fh ; 'To Save Game Start Tape And Press Enter.'
    db 088h,0FEh,02Eh,0FFh
    db 0FCh,08Fh,0FDh,098h,084h,0FEh,02Eh,0FFh ; 'Verifying Game.'
    db 0FCh,08Fh,0FDh,098h,093h,0FEh,021h,0FCh ; 'Verifying Failed!'
    db 08Ch,08Dh,08Eh,05Ch,08Fh,094h,0FEh,03Fh ; 'Do You Want To Verify Again?'
    db 0FFh
    db 0FCh,08Ch,08Dh,08Eh,05Ch,0AAh,095h,096h ; 'Do You Want To Load An Old'
    db 084h,0FEh,03Fh,0FFh                     ; 'Game?'
    db 0FCh,0AAh,0FDh,098h,093h,0FEh,021h      ; 'Loading Failed!'
    db 0FCh,07Fh,096h,084h,05Ch,097h,094h,0FEh ; 'Press Old Game To Try Again.'
    db 02Eh,0FFh

; Various messages token data table (LE485)
KilledWhatHowDescription:
    db 055h,0C7h,000h,0FFh                     ; 'He Slew The'
LE489:
    db 0FCh,04Ah,0FCh,004h,0FFh                ; 'Lake Mirrow'
    db 0EAh,0FFh                               ; 'Crown'
LE48E:
    db 0FCh,02Dh,000h,0FCh,07Bh,0FFh           ; 'Lorgrim The Wise'
TokensYouMustSeek:
    db 08Dh,0A4h,0F0h,0FFh                     ; 'You Must Seek'
TokensHeHasWithHim:
    db 0FCh,055h,08Ah,0E3h,0F9h,0FFh           ; 'He Has With Him'
TokensHowIsHe:
    db 0FEh,02Eh,0FCh,000h,0FCh,09Bh,0FCh,0A9h ; '. The Ice Fear Is'
    db 070h,0FFh
TokensIsHidden:
    db 070h,0EFh,0FEh,02Eh,0FFh                ; 'Is Hidden.'
TokensFightOrHide:
    db 0AEh,0ADh,087h,055h,0A4h,0F7h,0A8h,0EEh ; 'Are Abroad And He Must Fight Or Hide'
    db 0FFh

; Object descriptions token data table
LE4CC:
    db 000h,0FCh,0E8h,040h,0FCh,0E2h,0DEh      ; 'The Waters Of Life Which'
    db 0E0h,0F9h,0E3h,0E1h,0FFh                ; 'Fill Him With Vigour'
LE4D8:
    db 0B0h,0FFh                               ; 'Nothing'
LE4DA:
    db 0F8h,0FFh                               ; 'Wolves'
LE4DC:
    db 07Dh,0FEh,073h,0FFh                     ; 'Dragons'
LE4E0:
    db 09Bh,09Ch,0FEh,073h,0FFh                ; 'Ice Trolls'
LE4E5:
    db 07Ch,0FFh                               ; 'Skulkrin'
LE4E7:
    db 09Dh,099h,0FEh,073h,0FFh                ; 'Wild Horses'
LE4EC:
    db 0DCh,087h,070h,0DDh,0FFh                ; 'Shelter And Is Refreshed'
LE4F1:
    db 0D9h,0FEh,02Eh,0FCh,053h,0DAh,0DBh,0FEh ; 'Guidance. A Voice Calls,'
    db 02Ch,0FFh
LE4FB:
    db 000h,0FCh,01Ah,040h,0FCh,00Bh,0DEh,0DFh ; 'The Shadows Of Death Which Drain Him Of'
    db 0F9h,040h
    db 0E1h,0FFh                               ; 'Vigour'
LE507:
    db 000h,0FCh,0E4h,040h,000h,0FCh,0A0h,0DEh ; 'The Hand Of The Dark Which Brings Death To'
    db 0E5h,00Bh,05Ch
    db 000h,06Eh,0FFh                          ; 'The Day'
LE515:
    db 000h,0FCh,0E9h,040h,0FCh,032h,0DEh,0E5h ; 'The Cup Of Dreams Which Brings New Welcome'
    db 0A7h,0A2h,0FFh
LE520:
    db 000h,0E6h,0FCh,09Ah,0FDh,0E7h,0FFh      ; 'The Sword Wolfslayer'
LE527:
    db 000h,0E6h,0FCh,07Dh,0FDh,0E7h,0FFh      ; 'The Sword Dragonslayer'
LE52E:
    db 000h,0FCh,003h,0FCh,0FAh,0FFh           ; 'The Moon Ring'
LE534:
    db 000h,0FCh,09Bh,0FCh,0EAh,0FFh           ; 'The Ice Crown'
LE53A:
    db 0FCh,076h,000h,0FCh,07Ch,0FFh           ; 'Fawkrin The Skulkrin'
LE540:
    db 0FCh,077h,000h,0FCh,07Dh,0FDh,079h,0FFh ; 'Farflame The Dragonlord'
LE548:
    db 0FCh,055h,08Ah,0AFh,0FFh                ; 'He Has Found'


; A message on death (LEE1A)
TokensDeath:
    db 0FBh,0FCh,000h,01Bh                     ; 'The Bloody'
    db 0FEh,079h,0E6h,040h                     ; 'Sword Of'
    db 0C3h,0E5h,00Bh,054h                     ; 'Battle Brings Death In'
    db 000h,0FCh,052h,0FFh                     ; 'The Domain'
