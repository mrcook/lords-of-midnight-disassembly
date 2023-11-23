> $4000 ; The Lords of Midnight (LOM) - ZX Spectrum Disassembly
> $4000 ; (https://github.com/mrcook/lords-of-midnight-z80-disassembly)
> $4000 ;
> $4000 ; Disassembled by Michael R. Cook, 2023
> $4000 ;
> $4000 ; Copyright (c) 1984 Beyond Software
> $4000 ; LOM was designed and developed by Mike Singleton
> $4000 ;
> $4000 ; Many of the labels and comments are taken directly from the 1991
> $4000 ; DOS source code (v1.05) by Chris Wild (https://www.icemark.com)
> $4000 @start=$5B04 ; BASIC called 0x5B15, but this will init the SP from the old loader routine
@ $4000 org
b $4000 Loading Screen
B $4000,6912,16
b $5B00
@ $5B00 label=WorkSpaceArea
S $5B00,4,$04
c $5B04
@ $5B04 label=Loader
C $5B04,3 Top of STACK
N $5B08 tape loader removed - this loaded Block #6 from the tape to 5CB0
@ $5B08 defs=$5B08:13,0 ; zero out original tape loader bytes
C $5B08,4 ROM LD-BYTES; Start of the block (5CB0)
C $5B0C,3 ROM LD-BYTES; Length of the block (A34F)
C $5B0F,2 ROM LD-BYTES; Block type Flag (data block)
C $5B11,1 ROM LD-BYTES; Set carry flag for LOAD
C $5B12,3 ROM LD-BYTES; call tape loading routine
c $5B15 Start the game!
> $5B18 @defs=$5B18:352 ; zero out all byte before start of game code at 5C78
s $5B18
S $5B18,8,$08
s $5B20
@ $5B20 label=PrintBuffer
S $5B20,96,$60
s $5B80
@ $5B80 label=FreeTable
S $5B80,128,$80
s $5C00
S $5C00,2,$02
s $5C02
S $5C02,6,$06
b $5C08
@ $5C08 label=LASTK
B $5C08,1,1
s $5C09
S $5C09,44,$2C
s $5C35
@ $5C35 label=StackPointer
S $5C35,1,$01
w $5C36 Address to the character graphics
@ $5C36 label=CHARS
W $5C36,2,2
s $5C38
S $5C38,64,$40
w $5C78 Related to the random numberish routine
@ $5C78 label=L5C78
W $5C78,2,2
s $5C7A
B $5C7A,54,8*6,6
b $5CB0 Word Token Dictionary
D $5CB0 Tokens are stored using 5-bit bytes compressed together. For a full list of all tokens see: https://www.icemark.com/dataformats/midnight/index.html
@ $5CB0 label=TokenDictionary
B $5CB0,965,16*60,5
c $6075
@ $6075 label=StartGame
c $607B
@ $607B label=ForceLoad
c $607E
@ $607E label=Select
C $6081,4 Push FD21 to stack, which is just before the CharKeysTable: FD22 - 1 byte.
C $608C,3 Pop what should still be FD21, then INC, and push FD22 (CharKeysTable) to stack.
C $6092,2 Can We Select?
C $6094,2 No
C $609E,2 Make Uppercase
B $60B6,6,6
c $60D1
@ $60D1 label=LocationForLoadedData
C $60D1,2 ROM LD-BYTES; Block type Flag (data block)
C $60D3,4 ROM LD-BYTES; Start of the block
C $60D7,3 ROM LD-BYTES; Length of the block
c $60DB
@ $60DB label=ResetLASTK
c $60E0
@ $60E0 label=ClrScrDoMessage
c $60EB
@ $60EB label=ReduceHealthAfterMovement
C $60EF,1 If less than Zero...Make Zero
c $60F2 Save a game to tape.
@ $60F2 label=SaveGame
C $60F2,3 Start tape and press enter
@ $6108 ssub=LD HL,$6174+12
C $6108,3 Verifying saved game
C $610F,1 ROM LD-BYTES; Unset carry flag for VERIFY
@ $6116 ssub=LD HL,$6174+20
C $6116,3 Verification failed
C $611F,3 Check to see they want to try again(?)
C $6122,2 'g' (K_Yes)
C $6126,2 'j' (K_No)
C $6130,3 ROM LD-BYTES; call tape loading routine
c $6134 Ask player is they want to load an old game.
@ $6134 label=LoadOldGameQuery
@ $6134 ssub=LD HL,$6174+37
C $6134,3 Do you want to load an old game?
C $6140,2 'g' (K_Yes)
C $6144,2 'j' (K_No)
c $614B Load a game from tape
@ $614B label=LoadGame
C $614E,1 ROM LD-BYTES; Set carry flag for LOAD
@ $6155 ssub=LD HL,$6174+49
C $6155,3 Loading failed!
C $6161,2 'd' (K_Load)
c $6167
@ $6167 label=ClearAllScreen
B $616D,6,6
b $6174 Messages for loading and saving games.
@ $6174 label=LoadSaveMessages
B $6174,8,8 'To Save Game Start Tape And Press'
B $617C,4,4 'Enter.'
B $6180,8,8 'Verifying Game.'
B $6188,8,8 'Verifying Failed!'
B $6190,8,8 'Do You Want To Verify Again?'
B $6198,1,1
B $6199,8,8 'Do You Want To Load An Old Game?'
B $61A1,4,4
B $61A5,7,7 'Loading Failed!'
B $61AC,8,8 'Press Old Game To Try Again.'
B $61B4,2,2
c $61B6
@ $61B6 label=CheckGameKeys
C $61B9,2 'q'
C $61BE,2 'e'
C $61C3,2 'r'
C $61C8,2 't'
C $61CD,2 'u'
C $61D1,2 's'
C $61D6,2 'd'
C $61DB,2 'z'
C $61E7,2 'm'
C $61EC,2 'c'
C $61F0,2 'v'
C $61F4,2 'b'
C $61F8,2 'n'
@ $620C label=ChooseLuxor
@ $620F label=ChooseMorkin
@ $6213 label=ChooseCorleth
@ $6217 label=ChooseRorthron
@ $6219 label=SaveChoice
c $621F End of day, the player turn is over.
@ $621F label=Night
B $6225,6,6 'Night Has Fallen And The'
B $622B,4,4 'Foul Are Abroad'
B $622F,4,4 '.'
C $623D,2 'Day'
B $625C,6,6 'Do You Want Dawn'
B $6262,3,3 '?'
C $626B,2 'g' (K_Yes)
b $6272 Message for days passed since war began
@ $6272 label=GameMessagesSinceWarBegan
B $6272,7,7 'Passed Since The'
B $6279,4,4 'War Of The'
B $627D,6,6 'Solstice Began.'
c $6283 Main Game Loop
@ $6283 label=MainGameLoop
C $6289,2 Is the character still alive?
C $628B,3 Can't carry on if not!
@ $629F label=PollDirectionKeys
C $62A2,2 '1'
C $62A7,2 '9'
C $62AC,2 Make keypress into direction
C $62B2,1 Are we already looking that way?
C $62B3,3 Yes
@ $62B7 label=SaveDir
C $62B7,3 Change View
c $62C0
@ $62C0 label=MoveForward
C $62CE,2 Are there any reasons that shouldn't move?
C $62D6,2 Any Energy left?
C $62DE,2 Is it Night?
C $62E3,2 Is It Dawn
C $62EA,2 Any of DoomDarks Army Here?
C $62F2,2 Are we Hidden?
C $62FA,2 Anything in this location?
C $62FC,2 Horses are exceptable
C $6300,3 Between 1-5, we must fight so we can't Move
c $6303
@ $6303 label=WalkForward
C $6309,3 Re-Write info
C $631B,2 Process Char energy drains!
C $631D,3 Are we looking in a
C $6320,2 Diagonaly direction?
C $6322,1 Makes a difference if we are!
C $6327,2 Have We got a horse?
C $6329,2 Yes
C $632B,2 No. Makes a difference!
C $6330,2 Are we currently on downs?
C $6334,1 Yes. Makes a difference
C $6335,2 Are we on Mountain?
C $6339,1 OOOOOH!!!
C $633A,1 Really makes a difference!
C $633D,2 Are we in a forest
C $633F,2 No
C $6344,2 Are we a Fey?
C $6346,2 Yes
C $6348,1 Makes a difference if we are
C $6349,1 not a fey but in a forest
C $634E,2 Are we Farflame?
C $6350,2 No
C $6352,2 Yes. Then forget all the above!!!
c $6372
@ $6372 label=SetResetCharsArmy
C $6375,3 How many armies are still here
C $6378,3 or already here?
c $637B
@ $637B label=Think
@ $6381 label=DisplayThinkInfo
C $6387,3 Print the feature
C $638A,3 Display the text
c $6396
@ $6396 label=Choose
C $639F,2 Is the character alive?
C $63A1,3 Can't choose if the character is stone DEAD!
@ $63BD label=PollTableOfKeys
@ $63D0 label=SelectRoutine
c $63DF
@ $63DF label=CharacterSeek
C $63EB,3 If there's Nasties Here
C $63EE,3 Current Object
C $63F1,2 Is there any Horses?
C $63F3,3 Is there any Horses?
C $63F6,2 Skulkrins & dragons
C $63F8,3 Can't Have Horses!?
@ $6408 label=CheckGuidance
C $640A,2 Not guidance
C $640C,3 Pick a Number
C $640F,2 between 0 - 31
C $6411,3 Store it away
@ $6416 label=CheckShelter
@ $641F label=CheckHandOfDark
@ $6429 label=CheckCupOfDreams
@ $6434 label=CheckWaterOfLife
@ $643A label=SetCharacterStatus
@ $6445 label=CheckShadowsOfDeath
@ $644C label=DropTheObject
@ $6458 label=ClearObjectsLocation
@ $645C label=FinishLocationAlter
@ $645F label=FinishCharacterAlter
@ $6465 label=CheckIceCrownBusters
C $6468,2 Fawkrin,Farflame,Logrim,Lake Mirrow
C $646F,2 What are we carrying other than IceCrown
C $6476,2 Is It Morkin?
C $6478,2 Yes
@ $6484 label=HideCharacter
@ $648F label=SaveDetails
c $6492
@ $6492 label=StartFight
C $6497,2 There's armies here
@ $64CB label=RecruitCharacter
C $64D6,3 Make character now Available
c $64DF
@ $64DF label=RecruitOrGuardMen
C $64E2,1 Increase/Decrease
C $64E9,2 Riders?
C $64EB,2 Yes deal with them.
C $64ED,3 No
C $64F0,1 Change the amount of the characters
C $64F1,3 Warriors accordingly.
C $64F9,1 Alter the amount of the
C $64FA,3 characters riders.
C $64FD,3 Store Away the Change.
c $6503
@ $6503 label=RecruitMen
c $6509
@ $6509 label=Guardmen
c $650D
@ $650D label=Battle
c $6510 Display Whom we're looking at.
@ $6510 label=PrintWhoEversInFront
C $6512,3 Starting Row
C $6515,2 Assume day time
C $6524,3 What Time?
C $6527,2 Is it night
C $652B,2 This is Night
C $6534,3 Where are we?
C $653D,2 Reset Count
C $653F,3 What's in front?
C $6544,2 No Skip next instruction
C $6546,1 Increment Count
C $6547,3 How Many Armies of the free are here?
C $654A,2 Less than 29?
C $654C,2 Skip next instruction if so.
C $654E,1 Increment Count.
C $6552,1 Combine the no of DoomDarks armies with the count
C $6553,3 Well if B<>0 then Sorry! No.
C $6559,2 How Many Characters are in front of us?
C $655B,2 None. Well Check Armies!
C $655D,1 Start of with none in front.
C $6561,3 Who Is here?
C $6567,3 Print him!
C $656A,3 Check the size of table
C $6571,1 Increment our count.
C $6572,1 Are we at the end?
C $6573,2 Loop if not.
@ $6575 label=AnyDoomDarksRidersInFront
C $6578,1 Any Riders?
C $657C,2 Set A to Display Riders
C $657E,2 What A Label!
C $6580,2 Do Display
@ $6582 label=AnyDoomDarksWarriorsInFront
C $6585,1 Any Warriors?
C $6589,2 No. Check Nasties.
C $658B,2 Set A to Display Warriors
C $658D,2 Do Display
@ $658F label=DisplayMeaniesEtc
C $6592,2 Not Set
C $6595,2 Greater than 6
C $6598,1 Minus one
C $6599,3 Point to Table
C $659D,2 Get info from table
c $65A7 Do Display
@ $65A7 label=PVIII
c $65AA
@ $65AA label=PIV
c $65AD
@ $65AD label=PII
c $65B0 Print a character to the screen
@ $65B0 label=PI
C $65B4,3 How Many So Far?
C $65B8,1 Printing one more
C $65B9,2 Loop Eight Times MAX.
C $65C2,3 Reference Position Table
C $65C7,3 Get the Column Position
b $65CF Position Table
@ $65CF label=PositionTable
B $65CF,8,8
b $65D7 MeaniesDataTable
@ $65D7 label=MeaniesDataTable
B $65D7,5,5
c $65DC
@ $65DC label=CalcCharsCourage
C $65F3,2 Can't be more than eight
C $65F5,2 must be seven if it is.
c $6614
@ $6614 label=CalcDoomDarksCitadels
C $6621,2 Army is DoomGuard?
C $6623,2 No
C $6625,3 Yes
C $6640,3 Get next army
C $6644,2 Is it the last?
C $6646,2 No. Loop
c $6649
@ $6649 label=SetLocSpecial
C $664F,2 Set The Bit
C $6654,3 Write it
c $6657
@ $6657 label=ResetLocSpecial
C $6663,1 Store it away for a mo
C $6664,1 Reset The Bit
C $6668,3 Write the Change
C $666C,2 Was it actually Set?
C $666E,1 No
C $6675,2 Are there any of doomdarks here?
C $6677,1 If Not then return
C $6678,3 Yes - we must Battle
c $667B
@ $667B label=CalcNightActivity
C $667C,3 Character to deal with
C $667F,3 Update all his status's
C $6685,1 Next Character
C $6686,2 Is it the last?
C $6688,2 No. Loop until
C $668A,1 Start with Luxor Again
C $668E,3 Mark all characters onto the map
C $6694,2 Is character alive?
C $6696,2 If not can't deal with
C $669B,2 Is character hidden?
C $669D,2 If so can't deal with
C $669F,3 Location at
C $66A2,3 Set the special flag
C $66A8,1 Next Character
C $66A9,2 Are we on the last
C $66AB,2 Loop if not
C $66AD,1 Start with army 0
C $66B1,3 Mark all the free armies on the map
C $66B7,2 Does this army belonging to DoomDark
C $66B9,2 If so can't deal with it yet.
C $66BB,3 Where is the army
C $66BE,3 Set special flag
C $66C4,1 Next army
C $66C5,2 Last One
C $66C7,2 Loop if not
C $66CC,1 Start with Luxor again
C $66D0,1 Remove All Characters
C $66D1,3 from the map????
C $66D4,3 Reset the Special Location flag
C $66D7,3 at the location that
C $66DA,3 the character is at!
C $66E3,1 Start with Army 0
C $66E4,1 Remove all armies from
C $66E5,3 the map.
C $66E8,3 Reset the Special Location
C $66EB,3 flag at the location that
C $66EE,3 the army is at!
c $66FD
@ $66FD label=AlterCharDetails
C $6700,3 What time of day is it
C $6703,2 Multiply by 2
C $6706,3 Increment all status's
C $6709,2 Make Dawn
C $6711,2 Is the character alive?
C $6713,2 Can't process if Not
c $672D
@ $672D label=AddOn_B
c $6734
@ $6734 label=IncrementStatusBy_10
c $6736
@ $6736 label=IncrementStatusBy_B
w $6758
@ $6758 label=SelectRoutineJumpTable
W $6758,2,2 CharacterSeek
W $675A,2,2 HideCharacter
W $675C,2,2 StartFight
W $675E,2,2 RecruitCharacter
W $6760,2,2 RecruitMen
W $6762,2,2 Guardmen
W $6764,2,2 Battle
c $6766
@ $6766 label=DoReverseSwap
b $676D
B $676D,1,1
w $676E Main game data area, which is also used in the saved games
D $676E #TABLE(default,centre,:w) { =h Type | =h Offset | =h Description } { WORD  | 00 | days - days since the start of the game             } { BYTE  | 02 | char - current selected character                   } { BYTE  | 03 | unused                                              } { BYTE  | 04 | unused                                              } { BYTE  | 05 | unused                                              } { TABLE | 00 | garrisons                                           } { TABLE | 00 | special places                                      } { TABLE | 00 | regiments                                           } { TABLE | 00 | characters                                          } { TABLE | 00 | terrain map                                         } { TABLE | 00 | area map (only partially included in the save game) } TABLE#
@ $676E label=GameDays
W $676E,2,2
b $6770 current selected character
@ $6770 label=SaveCurChar
B $6770,1,1
u $6771
B $6771,1,1
u $6772
B $6772,1,1
u $6773
B $6773,1,1
b $6774 Garrisons: 102 entries corresponding to the keeps and citadels.
D $6774 Ushgarak is element 0x06; Xajorkith is element 0x60. #TABLE(default,centre,:w) { =h Type | =h Offset | =h Description } { BYTE | 00 | bits 0-1: Race                        } {      |    | bit  2:   Type (0=warriors, 1=riders) } {      |    | bits 3-7: Unused                      } { BYTE | 01 | total - size of this unit / 5         } TABLE#
@ $6774 label=Garrisons
B $6774,204,16*12,12
b $6840 Special Places: 112 entries
D $6840 The first 102 are keeps/citadels and have a corresponding entry in the garrisons table. The remaining are just in for extra routing. The left and right routing branch is used to randomly pick another location to head to. When an army of type 3 gets to a location in this table, they randomly pick the left or right branch and then goto the location specified in the table for that number. #TABLE(default,centre,:w) { =h Type | =h Offset | =h Description } { WORD | 00 | map location               } { BYTE | 02 | left branch special place  } { BYTE | 03 | right branch special place } TABLE#
@ $6840 label=SpecialPlaces
B $6840,448,16
b $6A00 Regiments - 128 entries for the free wandering armies of DoomDark.
D $6A00 #TABLE(default,centre,:w) { =h Type | =h Offset | =h Description } { BYTE | 00 | Bits 0-5: X coord, Bits 6-7: Order     } { BYTE | 01 | Bits 0-5: Y coord                      } {      |    | Bits 6:   Unused                       } {      |    | Bit  7:   Type (0=warriors, 1=riders)  } { BYTE | 02 | total - size of this unit / 5          } { BYTE | 03 | id - either special place or character } TABLE#
R $6A00 Description of the "order" bits:
N $6A00 #TABLE(default,centre,:w) { =h Binary | =h Description } { 00 | go to special location [ID] and stay there                    } { 01 | wander around                                                 } { 10 | follow character [ID] and kill him. then pick Luxor or Morkin } { 11 | go to special location [ID] then pick new location            } TABLE#
@ $6A00 label=Regiments
B $6A00,512,16
b $6C00 Lords
D $6C00 #TABLE(default,centre,:w) { =h Type | =h Offset | =h Description } { WORD | 00 | location - current location                             } { BYTE | 02 | direction - currently looking                           } { BYTE | 03 | time - time of day                                      } { BYTE | 04 | first name - first name token                           } { BYTE | 05 | title - see title types                                 } { BYTE | 06 | Bit 1: [r]ecruited (0=no), Bit 2: [m]oonring (0=worn)   } { BYTE | 07 | graphic - see graphic types                             } { BYTE | 08 | riders - total riders / 5                               } { BYTE | 09 | riders_energy - riders energy                           } { BYTE | 10 | warriors - total warriors / 5                           } { BYTE | 11 | warriors_energy - warriors energy                       } { BYTE | 12 | battle_area - area currently in battle in               } { BYTE | 13 | riders_lost - number of riders lost in battle           } { BYTE | 14 | warriors_lost - number of warriors lost in battle       } { BYTE | 15 | killed                                                  } {      |    | number of the enemy killed by the character in battle   } { BYTE | 16 | riders_killed - enemy killed by riders                  } { BYTE | 17 | warriors_killed - enemy killed by warriors              } { BYTE | 18 | battle_status                                           } {      |    | 0xFF: no batle, 0x00: battle continues, 0xXX: who won   } { BYTE | 19 | alive - 0 or 1                                          } { BYTE | 20 | energy - current energy                                 } { BYTE | 21 | strength - current strength                             } { BYTE | 22 | cowardess                                               } { BYTE | 23 | recruiting_key                                          } { BYTE | 24 | recruited_by: the character who is doing the recruiting } {      |    | recruiting_key is ANDed with the recruited_by from the  } {      |    | character he wished to recruit and if it is not zero,   } {      |    | then recruiting can take place                          } { BYTE | 25 | courage                                                 } { BYTE | 26 | unused                                                  } { BYTE | 27 | hidden - 0 or 1                                         } { BYTE | 28 | race - see race table                                   } { BYTE | 29 | horse - 0 or 1                                          } { BYTE | 30 | object - object carrying - see object table             } { BYTE | 31 | death by                                                } {      |    | 0x00 - in battle                                        } {      |    | 0xXX - else the value is the object that killed him     } TABLE#
R $6C00 Table of the midnight races:
N $6C00 #TABLE(default,centre,:w) { $00 | Doomdark } { $01 | Free     } { $02 | Fay      } { $03 | Targ     } { $04 | Wise     } { $05 | Morkin   } { $06 | Skulkrin } { $07 | Dragon   } TABLE# Table of the character titles (firstname): #TABLE(default,centre,:w) { $00 | FirstName "the Moonprince" } { $01 | FirstName                  } { $02 | FirstName "the Fey"        } { $03 | FirstName "the Wise"       } { $04 | FirstName "the Dragonlord" } { $05 | FirstName "the Skulkrin"   } { < $0A | "The Lord of" FirstName  } { else | "Lord" FirstName          } TABLE#
@ $6C00 label=CharactersTable
B $6C00,960,16
b $6FC0
@ $6FC0 label=MainMapCalcHLTable
B $6FC0,64,16
b $7000 Terrain map - 64x61 byte map running x - y
D $7000 Each entry is a single BYTE: #TABLE(default,centre,:w) { =h Bits | =h Description } { 0-3 | Terrain table ID   } { 4-7 | Object table ID    } TABLE#
R $7000 Terrain types table
N $7000 #TABLE(default,centre,:w) { $00 | Mountain     } { $01 | Citadel      } { $02 | Forest       } { $03 | Henge        } { $04 | Tower        } { $05 | Village      } { $06 | Downs        } { $07 | Keep         } { $08 | Snow Hall    } { $09 | Lake         } { $0A | Frozen Waste } { $0B | Ruin         } { $0C | Lith         } { $0D | Cavern       } { $0E | Army         } { $0F | Plains       } TABLE# Objects types table #TABLE(default,centre,:w) { $00 | None                   } { $01 | Wolves                 } { $02 | Dragons                } { $03 | Ice Trolls             } { $04 | Skulkrin               } { $05 | Wild Horses            } { $06 | Shelter                } { $07 | Guidance               } { $08 | Shadows Of Death       } { $09 | Waters Of Life         } { $0A | Hand Of Dark           } { $0B | Cup Of Dreams          } { $0C | Sword of Wolf Slayer   } { $0D | Sword of Dragon Slayer } { $0E | Ice Crown              } { $0F | Moon Ring              } TABLE#
@ $7000 label=TerrainMap
B $7000,3904,16
b $7F40 Area map - 64x61 byte map #TABLE(default,centre,:w) { =h Bits | =h Description | =h Description } { 0-5 | Area    | Relates to text tokens 0 - 63, see area table    } {   6 | Domain  | How a location is described                      } {     |         | (0=keep in domain of the moon, 1=Moon Keep)      } {   7 | Special | Only used during the game for processing.        } {     |         | Set bit if an army of character is at a location } {     |         | This does not require pre-setting.               } TABLE#
@ $7F40 label=AreaMap
B $7F40,3904,16
c $8E80
@ $8E80 label=CheckLocBreakCrown
c $8E8C
@ $8E8C label=FindSpecificChars
c $8EAF
@ $8EAF label=CheckSpecialConditions
C $8EB9,3 Check Luxor
C $8EC2,2 Is He Dead?
C $8EC4,2 Yes
C $8EC7,3 Set Flag to say Luxor is dead.
C $8ECD,2 Was luxor carrying the Moon Ring?
C $8ECF,2 No
C $8ED2,3 Drop Moon Ring.
C $8EE3,3 Put Moon Ring in current Location
C $8EE9,2 Toggle all commanded Lords
C $8EEB,3 as we can't use them
C $8EF0,3 Check Morkin
C $8EF9,2 Is he Dead?
C $8EFB,2 Yes
C $8EFD,3 Set Flag to Say so
C $8F0A,2 Is Morkin carrying the Moon Ring?
C $8F0E,2 Toggle All Commanded Lords
C $8F10,3 so we can use them
C $8F15,2 Has Morkin got the Ice Crown
C $8F17,2 Yes
C $8F19,7 Is he at Lake Mirrow? Location is hard-wired to $1209
C $8F23,2 Check Fawkrin,Lorgrim,Farlame
C $8F30,2 Character still alive?
C $8F32,2 If not then next character
C $8F34,3 Check if character is at
C $8F37,3 the same location as the Crown!
C $8F3E,2 Last Character?
C $8F40,2 Loop if not
@ $8F42 label=CheckGameOver
C $8F45,2 Luxor & Morkin Dead
C $8F49,2 Morkin Dead
C $8F4D,2 Army at Xajorkith
C $8F52,3 Get the army
C $8F58,2 Is the army DoomGuard?
C $8F5A,2 If so then Xajorkith has fallen
C $8F5C,2 Army at Ushgarak
C $8F61,3 Get the army
C $8F67,2 Is the army DoomGuard
C $8F69,2 If not then Ushgarak has fallen
C $8F6E,2 Check if the Ice Crown is still in the game!
@ $8F73 label=LuxorIsDead
B $8F76,5,5 'Luxor Is Dead'
@ $8F7D label=XajorkithFallen
B $8F80,5,5 'Xajorkith Has Fallen'
@ $8F85 label=MorkinIsDead
B $8F88,7,7 'And Morkin Is Dead.'
B $8F8F,7,7 'Victory To DoomDark.'
B $8F96,3,3
@ $8F9C label=UshgarakFallen
B $8F9F,5,5 'Ushgarak Has Fallen'
@ $8FA6 label=IceCrownDestroyed
B $8FA9,4,4 'The Ice'
B $8FAD,4,4 'Crown Has Been'
B $8FB1,6,6 'Destroyed'
@ $8FB7 label=DoVictoryMessage
B $8FBA,6,6 '.Victory To The'
B $8FC0,5,5 'Free!'
@ $8FC5 label=EndOfGame
C $8FCE,2 'd' (K_Load)
C $8FD2,5 Change current RET address on stack with the "force load" address
c $8FD8 ClearScreenBlack
@ $8FD8 label=DoWindowFive
B $8FF0,6,6
b $8FF7
@ $8FF7 label=LuxorMorkinFlag
B $8FF7,1,1
b $8FF8
@ $8FF8 label=IceCrownFlag
B $8FF8,1,1
u $8FF9
B $8FF9,7,7
> $9000 ;
> $9000 ; Start of Terrain Graphics
> $9000 ;
b $9000 Terrain data
@ $9000 label=TerrainMountain1
@ $923B label=TerrainMountain2
@ $93C5 label=TerrainMountain3
@ $94DD label=TerrainMountain4
@ $95CA label=TerrainMountain5
@ $9674 label=TerrainMountain6
@ $96DE label=TerrainMountain7
@ $972F label=TerrainMountain8
@ $976E label=TerrainCitadel1
@ $9A82 label=TerrainCitadel2
@ $9C76 label=TerrainCitadel3
@ $9D93 label=TerrainCitadel4
@ $9E6E label=TerrainCitadel5
@ $9F00 label=TerrainCitadel6
@ $9F5D label=TerrainCitadel7
@ $9FAB label=TerrainCitadel8
@ $9FD8 label=TerrainForest1
@ $A20F label=TerrainForest2
@ $A384 label=TerrainForest3
@ $A476 label=TerrainForest4
@ $A53F label=TerrainForest5
@ $A5D1 label=TerrainForest6
@ $A632 label=TerrainForest7
@ $A677 label=TerrainForest8
@ $A6AA label=TerrainHenge1
@ $A819 label=TerrainHenge2
@ $A8F7 label=TerrainHenge3
@ $A994 label=TerrainHenge4
@ $AA1C label=TerrainHenge5
@ $AA6E label=TerrainHenge6
@ $AAA4 label=TerrainHenge7
@ $AAC9 label=TerrainHenge8
@ $AAE1 label=TerrainTower1
@ $AC42 label=TerrainTower2
@ $AD2D label=TerrainTower3
@ $ADCC label=TerrainTower4
@ $AE4E label=TerrainTower5
@ $AEB1 label=TerrainTower6
@ $AEF8 label=TerrainTower7
@ $AF2F label=TerrainTower8
@ $AF5B label=TerrainVillage1
@ $B04B label=TerrainVillage2
@ $B0E0 label=TerrainVillage3
@ $B13E label=TerrainVillage4
@ $B191 label=TerrainVillage5
@ $B1C1 label=TerrainVillage6
@ $B1E6 label=TerrainVillage7
@ $B1FC label=TerrainVillage8
@ $B20B label=TerrainDowns1
@ $B2D1 label=TerrainDowns2
@ $B35C label=TerrainDowns3
@ $B3BF label=TerrainDowns4
@ $B419 label=TerrainDowns5
@ $B45D label=TerrainDowns6
@ $B48D label=TerrainDowns7
@ $B4B2 label=TerrainDowns8
@ $B4C7 label=TerrainKeep1
@ $B5CE label=TerrainKeep2
@ $B692 label=TerrainKeep3
@ $B6F5 label=TerrainKeep4
@ $B744 label=TerrainKeep5
@ $B773 label=TerrainKeep6
@ $B797 label=TerrainKeep7
@ $B7AE label=TerrainKeep8
@ $B7C2 label=TerrainSnowHall1
@ $B835 label=TerrainSnowHall2
@ $B884 label=TerrainSnowHall3
@ $B8B7 label=TerrainSnowHall4
@ $B8DD label=TerrainSnowHall5
@ $B8F5 label=TerrainSnowHall6
@ $B90A label=TerrainSnowHall7
@ $B91B label=TerrainSnowHall8
@ $B926 label=TerrainLake1
@ $B95A label=TerrainLake2
@ $B981 label=TerrainLake3
@ $B99E label=TerrainLake4
@ $B9AE label=TerrainLake5
@ $B9BB label=TerrainLake6
@ $B9C5 label=TerrainLake7
@ $B9CC label=TerrainLake8
@ $B9D0 label=TerrainFrozenWastes1
@ $BBEB label=TerrainFrozenWastes2
@ $BD50 label=TerrainFrozenWastes3
@ $BE46 label=TerrainFrozenWastes4
@ $BF14 label=TerrainFrozenWastes5
@ $BFA8 label=TerrainFrozenWastes6
@ $C001 label=TerrainFrozenWastes7
@ $C03F label=TerrainFrozenWastes8
@ $C073 label=TerrainRuin1
@ $C17F label=TerrainRuin2
@ $C231 label=TerrainRuin3
@ $C2A5 label=TerrainRuin4
@ $C30D label=TerrainRuin5
@ $C359 label=TerrainRuin6
@ $C38D label=TerrainRuin7
@ $C3B0 label=TerrainRuin8
@ $C3CC label=TerrainLith1
@ $C567 label=TerrainLith2
@ $C688 label=TerrainLith3
@ $C753 label=TerrainLith4
@ $C807 label=TerrainLith5
@ $C88B label=TerrainLith6
@ $C8EC label=TerrainLith7
@ $C930 label=TerrainLith8
@ $C95C label=TerrainCavern1
@ $C9E0 label=TerrainCavern2
@ $CA3E label=TerrainCavern3
@ $CA83 label=TerrainCavern4
@ $CABF label=TerrainCavern5
@ $CAE8 label=TerrainCavern6
@ $CB09 label=TerrainCavern7
@ $CB24 label=TerrainCavern8
@ $CB35 label=TerrainArmy1
@ $CD22 label=TerrainArmy2
@ $CE4A label=TerrainArmy3
@ $CF11 label=TerrainArmy4
@ $CFB8 label=TerrainArmy5
@ $D03E label=TerrainArmy6
@ $D08C label=TerrainArmy7
@ $D0C2 label=TerrainArmy8
B $9000,16618,16*35,11,16*24,10,16*17,8,16*14,13,16*10,10,16*6,10,16*5,1,16*3,15,16*49,4,16*31,4,16*17,13,16*13,11,16*9,2,16*5,13,16*4,14,16*2,13,16*35,7,16*23,5,16*15,2,16*12,9,16*9,2,16*6,1,16*4,5,16*3,3,16*22,15,16*13,14,16*9,13,16*8,8,16*5,2,16*3,6,16*2,5,16,8,16*22,1,16*14,11,16*9,15,16*8,2,16*6,3,16*4,7,16*3,7,16*2,12,16*24,5,16*5,14,16*5,3,16*5,5,16,6,15,16*12,6,16*8,11,16*6,3,16*5,10,16*4,4,16*5,5,16,5,16*16,7,16*12,4,16*6,3,16*4,15,16*2,15,16*2,4,16,7,16,4,16*7,3,16*4,15,16*3,3,16*2,6,16,8,16,5,16,1,11,16*3,4,16*2,7,16,13,16,13,10,7,4,16*33,11,16*22,5,16*15,6,16*12,14,16*9,4,16*5,9,16*3,14,16*3,4,16*16,12,16*11,2,16*7,4,16*6,8,16*4,12,16*3,4,16*2,3,16,12,16*25,11,16*18,1,16*12,11,16*11,4,16*8,4,16*6,1,16*4,4,16*2,12,16*8,4,16*5,14,16*4,5,16*3,12,16*2,9,16*2,1,16,11,16,1,16*30,13,16*18,8,16*12,7,16*10,7,16*8,6,16*4,14,16*3,6,16*2,8
b $D0EA Character lookup table, each entry consisting of 6-bytes.
D $D0EA NOTE: bytes 3-4 and 5-6 of each line look like Big Endian addresses
@ $D0EA label=CharacterLookupTable
B $D0EA,102,6
b $D150 Character Construction
@ $D150 label=CharConstructTable
B $D150,324,14*10,12*3,14*2,15*3,12*6,3
b $D294 Character construction Attributes
@ $D294 label=CharConstructAttrs
B $D294,367,14*10,12*3,14*2,15*3,12*5,15,14*2,15
b $D403 Graphics for each character
@ $D403 label=CharacterGraphics
B $D403,1304,16*81,8
b $D91B
@ $D91B label=Font
B $D91B,464,16
b $DAEB
@ $DAEB label=CharHereTable
B $DAEB,32,8
u $DB0B
B $DB0B,232,16*14,8
b $DBF3
@ $DBF3 label=CharInHereTable
B $DBF3,1,1
b $DBF4
@ $DBF4 label=KeyReturnStatus
B $DBF4,1,1
b $DBF5
@ $DBF5 label=ArmyToMoveLocation
B $DBF5,2,2
b $DBF7
@ $DBF7 label=Route_One
B $DBF7,1,1
b $DBF8
@ $DBF8 label=Route_Two
B $DBF8,1,1
b $DBF9
@ $DBF9 label=Route_Three
B $DBF9,1,1
b $DBFA
@ $DBFA label=Route_Four
B $DBFA,1,1
b $DBFB
@ $DBFB label=WhichMenDidCharLose
B $DBFB,1,1
w $DBFC
@ $DBFC label=StartofFreeTable
W $DBFC,2,2
w $DBFE
@ $DBFE label=StartOfDoomDarksTable
W $DBFE,2,2
b $DC00
@ $DC00 label=LastFreeArmyInTable
B $DC00,1,1
b $DC01
@ $DC01 label=LastDoomDarksArmyInTable
B $DC01,1,1
b $DC02
@ $DC02 label=HowManyFreeArmy
B $DC02,1,1
b $DC03
@ $DC03 label=FreeArmySuccessChance
B $DC03,1,1
b $DC04
@ $DC04 label=NoOfDoomDarksDead
B $DC04,1,1
b $DC05
@ $DC05 label=WhichFreeArmy
B $DC05,1,1
b $DC06
@ $DC06 label=HowManyDoomDarksArmy
B $DC06,1,1
b $DC07
@ $DC07 label=DoomDarksArmySuccessChance
B $DC07,1,1
b $DC08
@ $DC08 label=NoOfFreeDead
B $DC08,1,1
b $DC09
@ $DC09 label=WhichDoomDarksArmy
B $DC09,1,1
b $DC0A
@ $DC0A label=FreeArmyPosInTable
B $DC0A,1,1
b $DC0B
@ $DC0B label=DoomDarksArmyPosInTable
B $DC0B,1,1
b $DC0C
@ $DC0C label=NoInCharHereTable
B $DC0C,1,1
b $DC0D
@ $DC0D label=DoomDarksElite_Location
B $DC0D,2,2
b $DC0F
@ $DC0F label=DoomDarksElite_Total
B $DC0F,1,1
b $DC10
@ $DC10 label=DoomDarksElite_ID
B $DC10,1,1
b $DC11
@ $DC11 label=DoomDarksElite_Orders
B $DC11,1,1
b $DC12
@ $DC12 label=DoomDarksElite_Type
B $DC12,1,1
w $DC13
@ $DC13 label=Headquarters_Location
W $DC13,2,2
b $DC15
@ $DC15 label=Headquarters_ArmyOne
B $DC15,1,1
b $DC16
@ $DC16 label=Headquarters_ArmyTwo
B $DC16,1,1
b $DC17
@ $DC17 label=WhoseRaceIsArmy
B $DC17,1,1
b $DC18
@ $DC18 label=HowManyGuardsThePlace
B $DC18,1,1
b $DC19
@ $DC19 label=WhoGuardsThePlace
B $DC19,1,1
b $DC1A
@ $DC1A label=Army_DoomDarksElite
B $DC1A,1,1
b $DC1B
@ $DC1B label=Army_Headquarters
B $DC1B,1,1
b $DC1C
@ $DC1C label=Army_Details
B $DC1C,1,1
b $DC1D
@ $DC1D label=ArmyLocation
B $DC1D,2,2
b $DC1F
@ $DC1F label=IncRidersEnergyBy
B $DC1F,1,1
b $DC20
@ $DC20 label=FreeArmyHere
B $DC20,1,1
b $DC21
@ $DC21 label=DoomDarksArmyHere
B $DC21,1,1
u $DC22
B $DC22,186,8*23,2
w $DCDC KeyTableAddress ?? (initial value points to middle of terrain map)
@ $DCDC label=KeyTableAddress
W $DCDC,2,2
b $DCDE
B $DCDE,21,8*2,5
b $DCF3
@ $DCF3 label=PosInCharHereTable
B $DCF3,2,2
w $DCF5
@ $DCF5 label=IceFear
W $DCF5,2,2
b $DCF7
@ $DCF7 label=DoomDarksCitadels
B $DCF7,1,1
w $DCF8
@ $DCF8 label=PositionOfTowerOfDespair
W $DCF8,2,2 Hard-wired to location 0x051A
b $DCFA
@ $DCFA label=FreeArmyStillLeft
B $DCFA,1,1
b $DCFB
@ $DCFB label=DoomDarksArmyStillLeft
B $DCFB,1,1
b $DCFC
@ $DCFC label=BattleVictory
B $DCFC,1,1
b $DCFD
@ $DCFD label=ArmyLoopCurrent
B $DCFD,1,1
b $DCFE
@ $DCFE label=NoOfFreeArmiesAndChars
B $DCFE,1,1
b $DCFF
@ $DCFF label=TotalNoOfArmiesHere
B $DCFF,1,1
b $DD00
@ $DD00 label=EnemyMoveCount
B $DD00,1,1
b $DD01
@ $DD01 label=TempTotalOfArmies
B $DD01,1,1
b $DD02
@ $DD02 label=WhatObjectFlag
B $DD02,1,1
b $DD03
@ $DD03 label=WhatObject
B $DD03,1,1
b $DD04
@ $DD04 label=ObjectToDescribe
B $DD04,1,1
w $DD05
@ $DD05 label=DoomDarks_Warriors
W $DD05,2,2
w $DD07
@ $DD07 label=DoomDarks_Riders
W $DD07,2,2
b $DD09
@ $DD09 label=NoOfDeathsDescribed
B $DD09,1,1
b $DD0A
@ $DD0A label=Think_TempOne
B $DD0A,1,1
b $DD0B
@ $DD0B label=HowManyCharsInFrontDescribed
B $DD0B,1,1
b $DD0C
@ $DD0C label=Think_TempThree
B $DD0C,1,1
b $DD0D
@ $DD0D label=ChooseKeyTable
B $DD0D,7,7
b $DD14
B $DD14,1,1
b $DD15
@ $DD15 label=CharInLocation
B $DD15,1,1
b $DD16
@ $DD16 label=TempCharRecruitingKey
B $DD16,1,1
b $DD17
@ $DD17 label=CanCharMoveForward
B $DD17,1,1
b $DD18
@ $DD18 label=LocationToMoveTo
B $DD18,2,2
b $DD1A
@ $DD1A label=PrintCharacterCount
B $DD1A,1,1
b $DD1B
@ $DD1B label=ShieldInc
B $DD1B,296,16*18,8
b $DE43 Shield Parts Construction
@ $DE43 label=ShieldPartsConstructTable1
@ $DE6D label=ShieldPartsConstructTable2
@ $DE73 label=ShieldPartsConstructTable3
@ $DE77 label=ShieldPartsConstructTable4
@ $DE79 label=ShieldPartsConstructTable5
@ $DE7C label=ShieldPartsConstructTable6
@ $DE84 label=ShieldPartsConstructTable7
B $DE43,73,16*2,10,6,4,2,3,8
w $DE8C Shield parts table
D $DE8C First byte of each line is an address into the table
@ $DE8C label=ShieldPartsTable
W $DE8C,28,4
b $DEA8 Shield Construction Table
@ $DEA8 label=ShieldConstructTable
B $DEA8,256,16
c $DFA8
@ $DFA8 label=DescribeBattle
B $DFAB,7,7 'In The Battle Of'
B $DFB2,2,2
C $DFBA,3 Where?
C $DFEC,2 'Lost'
C $E005,2 'And'
B $E019,3,3 'Alone Slew'
B $E025,7,7 'Of The Enemy.'
B $E03A,7,7 'His Riders Slew'
B $E054,7,7 'His Warriors Slew'
B $E06E,7,7 'Victory Went To The'
@ $E07E label=BattleStillOn
B $E081,8,8 'The Battle Continues!'
B $E089,1,1
c $E08B
@ $E08B label=HowManyWarriors
c $E08E
@ $E08E label=HowManyWarriors_1
C $E091,2 'Warrior'
c $E099
@ $E099 label=HowManyRiders
c $E09C
@ $E09C label=HowManyRiders_1
C $E09F,2 'Rider'
c $E0A3
@ $E0A3 label=Mult_HL_5
c $E0A9
@ $E0A9 label=DisplayHowManyOf
C $E0B0,2 'None'
c $E0B5
@ $E0B5 label=NumberOf
c $E0BB
@ $E0BB label=HowMuch_What
@ $E0DC label=QuiteAffected
@ $E0DD label=SlightlyAffected
@ $E0DE label=VeryAffected
@ $E0DF label=UtterlyAffected
c $E0E7
@ $E0E7 label=ReportCharStatus
C $E0F0,2 'Invigorated'
C $E0F2,2 'Tired'
B $E0FE,4,4 'And Cannot Continue'
c $E103
@ $E103 label=DisplayArmyStatus
C $E106,2 'Command'
C $E110,2 'And'
C $E117,2 No Riders
C $E11F,2 No Warriors
C $E124,2 None of Anything
C $E12A,2 Riders & Warriors
C $E12C,2 'But'
C $E146,2 None
C $E149,2 Riders or Warriors?
B $E150,7,7 'His Warriors Are'
@ $E160 label=DisplayRidersStatus
@ $E164 label=DisplayWarriorsStatus
B $E167,7,7 'His Riders Are'
c $E177
@ $E177 label=HowManyUnitsOf
c $E179
@ $E179 label=HowManyUnitsOf_A
C $E17F,2 A*2
C $E182,2 A<C?
c $E18B
@ $E18B label=BreakNumberInParts
c $E1AA
@ $E1AA label=CalcBaseNumber
C $E1B7,2 Thirty Over
C $E1C5,2 Special Eighty
C $E1C9,2 AddThe
@ $E1CE label=AddTheY
@ $E1D0 label=LastPartOfNumber
C $E1D6,1 Any more?
B $E1DA,4,4 '-'
@ $E1DE label=LessThanTen
c $E1DF
@ $E1DF label=BaseNumber
@ $E1E4 label=LessThanThirty
C $E1E4,2 'Twenty'
@ $E1EB label=LessThanTwenty
C $E1EC,2 DE=Number
C $E1EE,3 HL=Table
C $E1F1,1 Position in table
C $E1F2,1 A=Token
C $E1F9,1 Ends Less Than Three
C $E1FA,2 But No Eight
C $E1FE,2 'Teen' - add to the End
C $E203,3 Special case for EightEEN
B $E206,7,7 'een'
b $E20E Number Tables
@ $E20E label=NumberTable1
B $E20E,10,8,2
b $E218
@ $E218 label=NumberTable2
B $E218,7,7
c $E21F
@ $E21F label=NumberToString
C $E232,1 Add up all parts
C $E233,1 to see if there
C $E234,1 is a number at all.
C $E237,1 H=ThousandsMillions
C $E238,1 L=TensUnits
C $E239,2 Any amount?
@ $E23D label=TensHundredsThousands
C $E23D,2 No
@ $E24E label=GreaterThanHundred
C $E24F,2 Is it greater than 100?
C $E251,2 No
C $E255,1 How Many Thousands
C $E257,2 Any At all?
C $E259,2 No
C $E260,2 'Thousand'
@ $E265 label=AnyHundreds
C $E26F,2 'Hundred'
@ $E274 label=AnyExtras
@ $E27A label=AddAnAnd
@ $E27F label=CalcTensUnits
c $E286
@ $E286 label=HaveOrHas
C $E28D,2 ItsHave
@ $E292 label=ItsHas
c $E297
@ $E297 label=MoveTowardsSomeOne
C $E29A,3 Compare Row of SomeOne
C $E29D,1 against Row of Army
C $E2A2,2 If it's the same then no need to alter
C $E2A4,3 If their's is less then do decrement
C $E2A7,1 Increment Army's Row count
C $E2A8,2 Skip Next instruction
C $E2AA,1 Decrement Army's Row count
@ $E2AB ssub=LD A,($FF27+1)
C $E2AB,3 Compare Column of SomeOne
C $E2AE,1 against column of army.
@ $E2AF ssub=LD A,($DBF5+1)
C $E2B3,2 If it's the same then no need to alter
C $E2B5,2 If their's is less then Do Decrement
C $E2B7,1 Increment army's column count
C $E2B8,2 Skip Next instruction
C $E2BA,1 Decrement army's column count
C $E2BB,3 Start Looking North
C $E2C3,1 Reference the DirectionLookTable
C $E2C5,1 Is this the Row move we want?
C $E2C6,2 No. Think about another direction.
C $E2C9,1 Is this the Column move we want?
C $E2CA,2 Yes. Process it
C $E2CC,1 Think about next Direction
C $E2D1,2 Have we tried all Directions?
C $E2D3,2 No. Loop until we have.
C $E2D5,3 This is the Direction we want!
C $E2D8,3 This is the Exact Way!
C $E2DB,3 So this
C $E2DF,2 This isn't Quite so exact
C $E2E8,3 Neither is this
C $E2EB,2 We'll Try this 8 times
C $E2ED,3 Random Number
C $E2F0,2 Between 0-3
C $E2F5,3 Reference the moves picked
C $E2F8,1 Which one are we going to use?
C $E2F9,1 This one of course!
C $E2FA,3 Done.
C $E2FE,3 Move to something we're looking at.
C $E301,3 Yes we are!!!!
C $E307,3 Were in the data though?
C $E30B,3 What's here?
C $E310,2 Can't walk through mountains!
C $E314,2 Don't like Forests!
C $E316,2 Bit impassible!
C $E318,1 That'll do.
C $E31B,2 We didn't get a desired Direction.
C $E31D,1 Anything other than frozen waste will do!
C $E31E,2 Or Nowhere
c $E324
@ $E324 label=FullScaleBattle
C $E327,2 How many Free Armies still Here?
C $E329,1 Return if none at all
C $E32D,2 How Many of doomdarks armies here?
C $E32F,1 Return if none at all
C $E330,2 Set this for a while
C $E335,1 Start with army Zero
C $E339,3 Get the required army
C $E33F,2 How many here?
C $E341,2 None is not worth bothering about.
c $E348
@ $E348 label=MinorSkirmish
C $E349,3 Pick a number
C $E34C,1 Compare it agains free's success
C $E34D,2 if A>=C then no Fighting!
C $E365,3 What's the chance of success?
C $E369,2 If a>=c then no loss
C $E36B,3 How Many are already Dead?
C $E36E,2 Are they all dead?
C $E370,2 Yes. can't kill anymore then
C $E372,1 Add one more to the count
C $E378,1 Next Soldier!
C $E37B,3 Was this a full battle
C $E37E,2 or a minor skirmish?
C $E380,1 return if a minor skirmish
C $E384,3 How many entry's in the table?
C $E388,3 How many have we done?
C $E38B,1 Next.
C $E38C,1 Are we past the last one?
C $E38D,2 Loop until we are.
C $E393,1 Reduce the amount of the Enemy
C $E397,3 Store away the results
C $E39D,2 Are there any left?
C $E39F,2 loop until there isn't
C $E3A1,3 Well that's one full army down!
C $E3A4,1 Decrease the Last one
C $E3A8,2 Any Armies left at location?
C $E3AA,2 Yes.
C $E3AC,1 No. well that's that then!!
@ $E3AE label=ShuffleArmytable
C $E3AF,3 B=Last Entry in table
C $E3B2,1 a=Where are we in that table?
C $E3B3,2 Loop if they're the same
C $E3B5,3 We want to store away
C $E3B8,1 these for A while.
C $E3C1,3 Get Next army in the table!
C $E3C7,1 And position it one entry back
C $E3CB,3 Store away the details
C $E3CE,3 How many in the table?
C $E3D5,1 Increment which one we're dealing with
C $E3D6,1 Have we done them all?
C $E3D7,2 Loop until we have.
C $E3D9,1 Restore the variables we saved.
C $E3DE,3 Store as the last entry!!!(?)
C $E3E7,2 ...back to battle!
c $E3E9
@ $E3E9 label=LocateDoomDarksArmy
c $E3F5
@ $E3F5 label=LocateFreeArmy
c $E3FF
@ $E3FF label=HL_Equal_AMult4PlusBC
c $E406
@ $E406 label=GetFreeArmy
c $E40B
@ $E40B label=StoreFreeArmy
c $E410
@ $E410 label=GetDoomDarksArmy
c $E415
@ $E415 label=StoreDoomDarksArmy
@ $E418 label=StoreFourBytes
c $E419
@ $E419 label=RetrieveFourBytes
c $E41F
@ $E41F label=CalcCharsKillRate
C $E422,2 Are there any Chars here?
C $E424,1 Return if not
C $E425,1 Start with the first.
C $E42C,2 Any of Doomdarks army here?
C $E42E,1 Return if not.
C $E42F,3 Get the character.
C $E434,3 Haven't killed any yet!
C $E43A,1 Work out our worth in soldiers.
C $E447,3 Character Killed a few
C $E450,1 How Many Characters are here?
C $E451,3 Select the next character
C $E454,1 that's in this location.
C $E455,1 Have we Done them all?
C $E456,2 Loop if Not.
c $E459
@ $E459 label=DisplayThinkAgain
B $E45C,4,4 'He'
C $E468,2 'Thinks'
B $E478,8,8 'Again ....'
B $E480,2,2
b $E485
@ $E485 label=KilledWhatHowDescription
B $E485,4,4 'He Slew The'
b $E489
@ $E489 label=ObjTokensA
B $E489,5,5 'Lake Mirrow'
B $E48E,2,2 'Crown'
b $E490
@ $E490 label=ObjTokensB
B $E490,6,6 'Lorgrim The Wise'
b $E496
@ $E496 label=TokensYouMustSeek
B $E496,4,4 'You Must Seek'
c $E49A
@ $E49A label=DescribeAnObject
C $E4A2,3 Point to Object Description Table
> $E4AE ;
> $E4AE ; Object descriptions token table
> $E4AE ;
b $E4AE
@ $E4AE label=TokensHeHasWithHim
B $E4AE,6,6 'He Has With Him'
b $E4B4
@ $E4B4 label=TokensHowIsHe
B $E4B4,8,8 '. The Ice Fear Is'
B $E4BC,2,2
b $E4BE
@ $E4BE label=TokensIsHidden
B $E4BE,5,5 'Is Hidden.'
b $E4C3
@ $E4C3 label=TokensFightOrHide
B $E4C3,8,8 'Are Abroad And He Must Fight Or Hide'
B $E4CB,1,1
b $E4CC
@ $E4CC label=ObjTokensC
B $E4CC,8,8 'The Waters Of Life Which'
B $E4D4,4,4 'Fill Him With Vigour'
b $E4D8 Object Descriptions Table
@ $E4D8 label=ObjTokensD
B $E4D8,2,2 'Nothing'
b $E4DA
@ $E4DA label=ObjTokensE
B $E4DA,2,2 'Wolves'
b $E4DC
@ $E4DC label=ObjTokensF
B $E4DC,4,4 'Dragons'
b $E4E0
@ $E4E0 label=ObjTokensG
B $E4E0,5,5 'Ice Trolls'
b $E4E5
@ $E4E5 label=ObjTokensH
B $E4E5,2,2 'Skulkrin'
b $E4E7
@ $E4E7 label=ObjTokensI
B $E4E7,5,5 'Wild Horses'
b $E4EC
@ $E4EC label=ObjTokensJ
B $E4EC,5,5 'Shelter And Is Refreshed'
b $E4F1
@ $E4F1 label=ObjTokensK
B $E4F1,8,8 'Guidance. A Voice Calls,'
B $E4F9,2,2
b $E4FB
@ $E4FB label=ObjTokensL
B $E4FB,8,8 'The Shadows Of Death Which Drain Him Of'
B $E503,4,4 'Vigour'
b $E507
@ $E507 label=ObjTokensM
B $E507,8,8 'The Hand Of The Dark Which Brings Death To'
B $E50F,6,6 'The Day'
b $E515
@ $E515 label=ObjTokensN
B $E515,8,8 'The Cup Of Dreams Which Brings New Welcome'
B $E51D,3,3
b $E520
@ $E520 label=ObjTokensO
B $E520,7,7 'The Sword Wolfslayer'
b $E527
@ $E527 label=ObjTokensP
B $E527,7,7 'The Sword Dragonslayer'
b $E52E
@ $E52E label=ObjTokensQ
B $E52E,6,6 'The Moon Ring'
b $E534
@ $E534 label=ObjTokensR
B $E534,6,6 'The Ice Crown'
b $E53A
@ $E53A label=ObjTokensS
B $E53A,6,6 'Fawkrin The Skulkrin'
b $E540
@ $E540 label=ObjTokensT
B $E540,8,8 'Farflame The Dragonlord'
b $E548
@ $E548 label=ObjTokensU
B $E548,5,5 'He Has Found'
c $E54D
@ $E54D label=LocateArmy_DoomDarksElite
c $E559
@ $E559 label=GetArmy_DoomDarksElite
@ $E56E ssub=LD A,($DC0D+1)
@ $E574 ssub=LD ($DC0D+1),A
c $E57E
@ $E57E label=StoreArmy_DoomDarksElite
@ $E589 ssub=LD A,($DC0D+1)
@ $E591 ssub=LD ($DC0D+1),A
c $E59A
@ $E59A label=GetArmy_Table2
c $E5A9
@ $E5A9 label=GetArmyDetails
c $E5CE
@ $E5CE label=LocateArmy_Table1
c $E5DB
@ $E5DB label=StoreArmy_Table1
c $E5ED
@ $E5ED label=WorkOutLocationDetails
C $E63C,3 Set BC to equal
C $E63F,1 current Location.
@ $E640 ssub=LD A,($FF13+1)
C $E640,3 This will be referenced
C $E643,1 loads of times!
C $E64C,2 AnyBody?
C $E64E,2 Skip rest if not!
C $E653,1 Is the army at this location?
@ $E656 ssub=LD A,($DC1D+1)
C $E65A,2 Yes
C $E65C,3 No. Think about the next army
C $E663,2 Is it the last?
C $E665,2 Loop if not
C $E66F,2 Any Actual army?
C $E671,2 If Not Skip this
C $E676,1 Is the army at the current Location?
C $E677,2 Yes. Do this routine!
@ $E679 ssub=LD A,($DC0D+1)
C $E683,1 Next Army
C $E687,2 Was it the last?
C $E689,2 Loop until it was
C $E693,2 Is the character alive?
C $E69A,2 Is character Hidden? 0=No
C $E69C,2 Yes. skip the rest
C $E6A1,1 Is the character at the current Location?
C $E6A2,2 Yes. Do this
@ $E6A4 ssub=LD A,($FF60+1)
C $E6AE,1 Next Character
C $E6B2,2 Is it the last?
C $E6B4,2 Loop until it is
@ $E6D1 label=AddArmyToBattleTable
C $E6D6,2 Is the army at a Citadel?
C $E6D8,2 No.
C $E6DF,2 Is it the DoomGuard?
C $E6E1,2 No.
C $E6E3,1 Yes
C $E6E4,3 Set to 10/20 depending if citadel!
C $E6EC,3 We neet to know which army number
C $E6EF,3 What type guard the place
C $E6F3,3 And how many
C $E707,3 Loop next army
C $E70D,2 Army at Keep or Citadel.
C $E70F,3 We need to know which army number
C $E713,3 Set depending on wether its a citadel
C $E73C,3 Loop next army
c $E73F
@ $E73F label=AddArmyToDoomDarksBattleTable
c $E75C
@ $E75C label=AddCharToBattleTable
C $E75F,1 Which character
C $E763,1 Add character to character here table!
C $E76B,1 Increase how many characters are here
C $E772,2 Has the character got any riders?
C $E776,3 Set how many.
C $E779,3 Get character no
C $E77C,2 And set bit 5 to say Riders
C $E784,1 Riders energy Status
C $E785,3 Riders increment amount
C $E788,1 Total them
C $E78F,2 Any Warriors?
C $E793,3 Set how many
C $E799,3 Set who
C $E79C,3 Warriors energy status
c $E7A4
@ $E7A4 label=AddIntoBattleTable
C $E7A5,3 How many Here?
C $E7A8,1 Add in our new figure
C $E7AA,3 Where are we?
C $E7AD,2 In a forest?
C $E7B4,2 Is the character a fey on a horse
C $E7B6,2 No
C $E7BA,1 Add loads on if he is
C $E7BD,2 Multiply by two
C $E7BF,2 Add some more
C $E7C1,3 Success chance!
C $E7C6,3 Reset.
C $E7CF,1 One more to the table
c $E7D4
@ $E7D4 label=AddArmyToDoomDarksTable
c $E7FD
@ $E7FD label=CalculateIceFear
C $E7FF,3 Get Morkins Details
C $E808,2 Is he alive?
C $E80A,2 Yes.
C $E80C,2 NO. Start with 127 life status
C $E813,4 Was there A Difference
C $E817,2 No. Character is either with morkin or is morkin.
C $E81B,3 Calc distance from tower!
C $E81E,1 HL = Difference
C $E821,3 IceFear's Initial setting!
C $E82F,2 Is Luxor still alive?
C $E831,2 Ooops! No he's Not
C $E833,3 Yes he is!
C $E838,2 Recalculate the IceFear
C $E83A,2 Accordingly!
C $E841,2 Some for Good Measure!
C $E847,1 Add on the number of Citadels
C $E848,1 currently held by Doomdark!
C $E84D,3 Start back with Luxor
b $E851
B $E851,1,1
c $E852
@ $E852 label=CalcMorkinsIceFear
C $E855,3 Maximum Ice fear
C $E858,1 A=Distance from Tower*2
C $E859,1 BC=A
C $E85E,2 BC=BC*2
C $E860,1 Reset A and Carry
C $E861,2 HL=HL-BC
c $E865
@ $E865 label=CalcDiffinLocations
c $E86E
@ $E86E label=CalcDiffin_BC_DE
c $E87D
@ $E87D label=ItsKillingTime
c $E89E Do the battle for both sides!
@ $E89E label=DoBothSidesBattling
c $E8A1 Do the battling for a side
@ $E8A1 label=DoBattle
C $E8A4,3 Swap over variables
C $E8A7,1 so that we can do all
C $E8A8,3 the work with one set of
C $E8AB,3 variables.
C $E8AE,1 Keeps life much simpler!!
c $E8C1
@ $E8C1 label=WhoWonThisBattle
C $E8C4,2 Has Doomdark still got any armies?
C $E8C6,2 Yes. he didn't lose then.
C $E8C8,2 'Free'
C $E8CF,2 Has the free got any armies left?
C $E8D1,2 Yes. they didn't lose then
C $E8D3,2 'Enemy'
C $E8D7,1 Still fighting!
C $E8D8,3 Set who won, or didn't
C $E8DB,1 Reset
C $E8DC,3 ...these
C $E8DF,3 ...these
C $E8E5,2 How many Free armies?
C $E8E7,3 No More free left.
C $E8F2,1 Army Total
C $E8F3,3 Who are they
C $E8F7,2 C>=80 if at a citadel or keep
C $E8F9,2 otherwise belongs to a character
@ $E900 label=CalcCharsArmyLoses
C $E903,1 Army number
C $E906,3 Select Character
C $E90A,3 Get his details
C $E90E,3 How Many Armies Here?
C $E912,1 Who Are They.
C $E913,2 Riders?
C $E915,2 Yes. Skip the Rest
C $E917,3 No. Warriors
C $E91A,1 Lost A Lot.
C $E91B,3 Save Away how many lost.
C $E91F,3 Save away how many Left.
C $E922,3 Warriors killed Some?
C $E92B,2 They lose some Energy
C $E92D,2 Have they any Left?
C $E92F,1 No Less than Zero.
C $E930,3 Store Away.
C $E935,3 Deal with Riders.
C $E938,1 Lost a lot Again.
C $E939,3 Store how many lost.
C $E93D,3 Store how many left.
C $E940,3 Riders killed a few.
C $E943,3 How Many?
C $E949,2 Lost Some energy.
C $E94B,2 Have they any left?
C $E94D,1 No Less than zero.
C $E94E,3 Store Away
C $E951,3 Save Characters details.
C $E957,1 Next.
C $E95C,2 Loop Until Finished.
C $E95E,3 How many Doomdarks army are left?
C $E96D,2 Does his army guard the place?
C $E96F,2 No.
C $E976,3 Get the army we want
C $E97F,3 Make alterations to the totals
C $E985,3 Deal with the next army.
C $E992,3 Who won?
C $E995,2 Was it DoomDark?
C $E997,1 Return if it wasn't
C $E99B,3 Rather long jump
c $E99E
@ $E99E label=MakeArmyChangeSides
C $E99E,2 Army that we want.
C $E9A4,3 Get the army.
C $E9AB,2 Check who one
C $E9AD,2 No one
C $E9AF,2 Did Doomdark Win?
C $E9B1,2 Yes.
C $E9B3,3 No. Who do the army belong to?
C $E9B6,2 Doomdark?
C $E9B8,2 Yes
C $E9BA,2 No.
C $E9BC,3 Make the army belong to Free.
C $E9C6,2 Does the army belong to to Doomdark?
C $E9C8,2 Don't do anything if it does.
C $E9CA,1 Make the Army belong to Doomdark!
C $E9D0,1 How many of the army left?
C $E9D3,2 There are some.
C $E9D5,2 If none the start with this
C $E9DA,3 Rewrite the army away
c $E9DE
@ $E9DE label=CharacterLosesWhat
C $E9E1,2 Is the Character Alive?
C $E9E3,1 No. Return
C $E9E8,2 Has the Character got a horse?
C $E9EA,2 No. Forget the next bit!
C $E9EC,3 Between Zero & One
C $E9EF,2 See if he'll lose his horse
C $E9F1,3 50/50 Characters not got a horse
@ $E9F7 label=WillCharacterDie
C $E9F7,3 Pick a number
C $E9FB,3 What's his energy like?
C $E9FE,2 Divide by two
C $EA00,2 Then subtract 64
C $EA02,1 Store this a mo
C $EA03,1 Get back his life status
C $EA04,1 Add it to his energy
C $EA05,1 If A>B then character
C $EA06,1 lives.....
C $EA08,3 DEAD!!
c $EA0C
@ $EA0C label=WhatHappensToFreeLords
C $EA0F,2 Any Character in location
C $EA11,1 Return if none!
C $EA12,1 Start with first.
C $EA13,3 Character we want
C $EA16,3 Get his details
C $EA1C,3 Did he lose his life?
C $EA21,2 Skip next bit
C $EA23,3 Move character somewhere!!!
C $EA26,2 Pick A Direction
C $EA28,3 We'll look there
C $EA2B,3 Anything upto three locations?
C $EA31,3 Move There
C $EA34,3 Store Away
C $EA37,3 Calculate New Position in Map
C $EA3A,3 What's there?
C $EA3D,2 Anywhere but Frozen waste
C $EA3F,2 Yes, do it all again.
C $EA41,3 Save away any changes
C $EA44,3 How many in the table
C $EA4B,1 Which one are we on.
C $EA4C,1 have we processed them all?
C $EA4D,2 Loop until we have.
c $EA50
@ $EA50 label=UpdateCharsBattleStats
C $EA53,2 Any characters here?
C $EA55,1 Return if not.
C $EA56,1 Start with first.
C $EA57,3 The character we want.
C $EA5A,3 Get his deatils
C $EA60,3 Say Who Won the battle
C $EA66,3 Say what are the battle was
C $EA6C,2 Get rid of some energy
C $EA70,1 Can't have less than zero
C $EA74,3 Store away the changes
C $EA7A,1 How many in the table
C $EA7E,1 Which are we upto?
C $EA7F,1 The last one?
C $EA80,2 Loop until it is
c $EA83
@ $EA83 label=CalcCharsGraphicType
w $EA9A Race Image table (GFX)
D $EA9A Except for Skulkrin and Dragon, byte #1 = standing, byte #2 = on horse
@ $EA9A label=RaceImageTable
B $EA9A,2,2 Free
B $EA9C,2,2 Fey
B $EA9E,2,2 Targ
B $EAA0,2,2 Wise
B $EAA2,2,2 Morkin
B $EAA4,2,2 Skulkrin
B $EAA6,2,2 Dragon
c $EAA8
@ $EAA8 label=AlterLocationContents
C $EAAC,3 Calc Offset in map
C $EAAF,3 Get the feature
C $EAB3,3 Get the object
C $EAB6,1 Move object into
C $EAB7,1 high order bits
C $EABA,1 Put feature in low
C $EABB,1 Store it away
C $EABC,3 Reference Description map
C $EAC0,3 Get the area
C $EAC4,3 the domain flag
C $EAC8,3 and special flag
C $EACB,3 Combine them and store away
c $EACF
@ $EACF label=ResetToOriginalArmy
@ $EAE2 label=AttemptFollow
@ $EAE5 ssub=LD A,($DC0D+1)
C $EAE5,3 Do we need to move anywhere to
C $EAE8,1 Get to the desired location?
C $EAE9,2 Yes. Start the process.
C $EAEF,2 We're here then.
C $EAF1,3 Set the location we're at
@ $EAF9 label=AnnounceArmyIsHere
C $EAFC,2 Set location feature to
C $EAFE,3 army if we can
c $EB07
@ $EB07 label=MoveArmySomewhere
C $EB0D,2 Is there actually any soldiers?
C $EB0F,2 Finish if not.
C $EB14,2 Anything special here?
C $EB16,2 Yes. - We'll Stay Here then!
C $EB18,1 Look North.
C $EB1C,3 Have a look forwards a couple
C $EB1F,3 of locations.
C $EB22,3 Move to that location.
C $EB2B,2 Anything Special here?
C $EB2D,2 Yes. Check it out!
C $EB2F,3 Check next direction
C $EB35,2 Loop until looked everywhere
C $EB3A,2 What will this army do?
C $EB3C,3 Guess what!
C $EB41,3 Aimlessly wander around!
C $EB51,2 Are we still looking anywhere
C $EB53,2 No. Doesn't look like it.
C $EB55,3 So just say the army is here.
C $EB61,2 How many armies are here?
C $EB63,2 We'll stay here then!
C $EB65,3 We're not going to stay here!
C $EB6B,1 One Less in this location
C $EB6C,3 Set terrain to Whatever
C $EB6F,3 This is for new location
C $EB72,1 One more here than before
C $EB73,3 Set temp as well.
C $EB7C,3 Store army away.
C $EB82,2 Start with two moves.
C $EB84,3 What's here?
C $EB87,2 Is it a mountain.
C $EB89,2 Yes. Bad Move!
C $EB8B,2 Is it a forest? - Hope Not!
C $EB8D,2 No. Still only two moves then
C $EB8F,2 Bad Move, took us eight!
C $EB94,2 Warriors?
C $EB96,2 Yes.
C $EB98,2 Multiply by two for riders!
C $EB9A,3 Add on our number of moves
C $EBA1,3 State that we're here!
@ $EBA4 label=FollowAnotherArmy
C $EBA4,3 Get the Armypointed to
C $EBAD,3 Record their postion
C $EBB9,2 Anything Special there?
C $EBBB,3 No. We'll stay here then
C $EBBE,3 Yes. lets head towards them.
@ $EBC1 label=MoveArmyToNewLocation
C $EBC4,2 Pick a direction
C $EBC6,3 Look that way
C $EBC9,3 Find something to look towards
C $EBCC,3 Move there
C $EBD5,3 What's there?
C $EBD8,2 If it's frozen waste then
C $EBDA,2 Find another location
@ $EBDF label=FollowACharacter
C $EBE2,3 Pick up on character
C $EBE5,3 Get his info
C $EBEB,2 Is he alive?
C $EBED,2 Yes. Skip next bit
C $EBEF,1 No. Set character to Luxor!
C $EBF0,3 Set ID to New Character
C $EBF6,3 Store Army Details
C $EBF9,3 Get characters info
C $EBFF,2 Is he alive
C $EC01,2 Yes. Skip Next bit
C $EC03,2 Set character to Morkin!
C $EC05,2 And retry.
C $EC07,3 Move ArmyTable2
C $EC0A,3 to New characters Location
@ $EC10 label=FollowArmyThenPickAnother
C $EC20,1 Are they at the same Location?
C $EC21,2 No
@ $EC23 ssub=LD A,($DC0D+1)
C $EC27,2 No
C $EC29,3 Yes they are so pick another army.
C $EC2D,3 Pick a Number, Any Number
C $EC30,2 What was it compared to 128
C $EC39,3 Point ArmyDoomDarksElite at the selection
C $EC3F,3 Store it and get the army
C $EC42,3 Read to deal with.
c $EC48
@ $EC48 label=SetLocationPlainsArmy
C $EC4A,2 If a=0 then Set to Plains
C $EC4C,2 Else set to army
C $EC4E,2 Reset to Plains
C $EC53,2 Can only be Army or Plains.
C $EC56,1 Make New Feature
c $EC5D
@ $EC5D label=ProcessAllArmies
C $EC80,2 Army can have upto six moves
C $EC82,2 loop until they've had them.
C $EC84,3 Process the next army
C $EC88,2 Loop 128 times
C $EC8A,2 Done it!!!!
c $EC8D
@ $EC8D label=DescribeWho
C $EC90,2 Is the character Hidden?
C $EC94,3 Who is it?
C $ECA3,2 No object at all
C $ECA7,2 Less than = Any Nasty!
C $ECAC,2 Any Ice Crown Killers
c $ECB1
@ $ECB1 label=DescribeOrGuidence
C $ECC3,2 Is it Guidance?
C $ECC5,2 Yes
@ $ECCC label=GiveSomeGuidance
C $ECD6,2 Add on 16
C $ECD8,3 Fawkrin,Farlame,Lake Mirrow,Lorgrim.
B $ECE1,8,8 'Can Destroy The Ice Crown'
@ $ECF4 label=GiveMoreGuidance
B $ED06,4,4 'Looking For'
C $ED0A,3 Who are we looking for?
C $ED10,3 This prints 'You Must Seek'
C $ED16,3 Where must we seek?
c $ED1B
@ $ED1B label=DescribeCharCondition
C $ED21,2 'And'
C $ED2F,3 Who is He.
C $ED32,2 'Is'
C $ED3A,3 How is he?
C $ED43,3 How's the Ice Fear?
C $ED49,3 Who are we dealing with.
C $ED4C,2 'Is'
C $ED51,3 Are We Scared?
C $ED5A,2 Are we carrying anything?
C $ED5C,1 Return if not.
C $ED5D,3 Otherwise describe what
C $ED60,3 we are carrying.
c $ED6C
@ $ED6C label=DescribeIceFear
C $ED77,2 'Mild'
C $ED79,2 'Cold'
c $ED7D
@ $ED7D label=DisplayCharCourage
C $ED80,2 'Bold'
C $ED82,2 'Afraid'
c $ED87
@ $ED87 label=DescribeNasty
C $ED8A,2 Is it wild Horses?
C $ED8C,2 Yes.
C $ED9E,3 How does the character Fair?
C $EDA7,2 Has the object been Described?
C $EDA9,3 Yes. Then no need to describe again.
B $EDB2,3,3 'Are Abroad'
@ $EDB7 label=HeKilledWhatHow
C $EDBD,3 What did we kill
C $EDCE,2 'With'
c $EDD9
@ $EDD9 label=IncDoomDarksArmy
C $EDDA,1 E=Number, A=Type
C $EDDB,2 Reset D
C $EDDD,2 Are they Warriors
C $EDDF,2 If not then do riders
C $EDE1,3 else
C $EDE4,1 Increment the number of Warriors
C $EDE9,3 Deal with the Riders.
C $EDEC,1 Increment the number of Riders
c $EDF1
@ $EDF1 label=BeenSomeDeaths
b $EE1A A message on death
@ $EE1A label=TokensDeathMessage
B $EE1A,4,4 'The Bloody'
B $EE1E,4,4 'Sword Of'
B $EE22,4,4 'Battle Brings Death In'
B $EE26,4,4 'The Domain'
w $EE2A Objects Description Table
@ $EE2A label=ObjectDescriptionLookupTable
W $EE2A,40,8
c $EE52
@ $EE52 label=DisplayCharThink
C $EE55,2 Have we been here before?
C $EE57,2 Yes. Skip intialise
C $EE5A,3 Initialise the Variables
C $EE63,2 We've been here before
C $EE6E,2 Still Alive?
C $EE70,3 No. Describe in details how he died!
@ $EE73 label=DescribeInDetailHowHeDied
C $EEAD,2 Are we at a Citadel?
C $EEB1,2 Are We at a Keep?
C $EEB8,2 Are there any armies here?
C $EEBA,2 If none of the above then skip.
C $EEBC,3 Describe where we are looking
C $EEBF,3 ...and who is here!
C $EECA,3 How many Characters are infront?
C $EECE,3 How many have we described?
c $EEF4
@ $EEF4 label=CheckLocationInfront
c $EEFD
@ $EEFD label=WeAreLooking
B $EF08,4,4 'To The'
C $EF0C,3 Where are we looking towards?
c $EF12
@ $EF12 label=DescribeWhatCharSees
c $EF18
@ $EF18 label=WhoKilledHim
C $EF1E,2 Was it anything that killed him
C $EF20,2 Yes.
C $EF22,3 No. Must have died in battle.
B $EF25,8,8 'He Was Killed In Battle.'
C $EF2D,3 Which Battle?
C $EF30,3 Describe what actually Killed him!
B $EF39,5,5 'Slew Him.'
c $EF3F
@ $EF3F label=DisplayArmiesHere
C $EF42,2 Has doomdark go any armies here?
C $EF44,2 If not don't print the message!
B $EF49,8,8 'DoomDark Has An Army Of'
B $EF51,1,1
C $EF52,3 How many Warriors?
C $EF5B,3 How Many Riders?
C $EF67,2 Are we at a keep or citadel?
C $EF69,2 Yes. At Citadel
C $EF6E,3 No.
C $EF76,2 Riders Here!
C $EF7B,3 Display Warriors
C $EF80,3 Display Riders
B $EF89,4,4 'Of The'
C $EF8D,3 Belonging to whom
C $EF90,2 Is it the DoomGuard?
C $EF92,2 Anything other than zero isn't
B $EF97,4,4 'DoomGuard'
C $EF9D,2 Are They Belonging to the Free?
C $EFA1,2 'Free'
C $EFA5,2 Belonging to the Fey
C $EFA9,2 'Fey'
C $EFAD,2 Must be 'Targ'
B $EFB5,3,3 'Guard The'
C $EFB8,3 Where are we?
C $EFBB,2 Get token
c $EFC2
@ $EFC2 label=GetLatestCharInfo
c $EFCB
@ $EFCB label=UpdateCharsVars
c $EFE1
@ $EFE1 label=AddToBufferAndKeyTable
c $EFF6
@ $EFF6 label=LEFF6
c $EFF9
@ $EFF9 label=AndToBuffer
b $EFFE DOS source code has this as the last Race Image table entry
B $EFFE,2,2
b $F000 Pixel Generation tables
@ $F000 label=PixelGenTable
@ $F008 label=PixelGenTable_F008
@ $F010 label=PixelGenTable_F010
B $F000,80,8
w $F050 Terrain Image Table
@ $F050 label=TerrainLookupTable
W $F050,2,2 Mountain
W $F052,14,2
W $F060,2,2 Citadel
W $F062,14,2
W $F070,2,2 Forest
W $F072,14,2
W $F080,2,2 Henge
W $F082,14,2
W $F090,2,2 Tower
W $F092,14,2
W $F0A0,2,2 Village
W $F0A2,14,2
W $F0B0,2,2 Downs
W $F0B2,14,2
W $F0C0,2,2 Keep
W $F0C2,14,2
W $F0D0,2,2 SnowHall
W $F0D2,14,2
W $F0E0,2,2 Lake
W $F0E2,14,2
W $F0F0,2,2 Frozen Wastes
W $F0F2,14,2
W $F100,2,2 Ruin
W $F102,14,2
W $F110,2,2 Lith
W $F112,14,2
W $F120,2,2 Cavern
W $F122,14,2
W $F130,2,2 Army
W $F132,14,2
c $F140 Terrain drawing routines
@ $F140 label=CalcPlotMask
c $F15E
@ $F15E label=PSET
c $F164
@ $F164 label=PRESET
c $F175 Draws a line
D $F175 B = Start, C = End
@ $F175 label=DrawLine
c $F23C
@ $F23C label=DrawFeature
C $F23F,2 Can't Draw Plains
C $F242,2 A*8
C $F249,3 Add on Size
C $F24D,2 A*2
@ $F25C ssub=LD ($FF0E+1),A
C $F264,3 Calc Screen Position
C $F26E,3 1st byte is the height
C $F27A,3 Set to draw
C $F27D,3 Bit 7 = Another Item
C $F280,2 Bit 6 = draw / erase
C $F282,2 Bits 5 - 0 = No of Draw Instructions
C $F286,3 More than one item on this line
C $F28F,3 Set erase
C $F295,3 How many draw items
C $F29A,3 Start of Line
C $F29F,3 End of Line
C $F2A2,3 Draw Line / Actually this is an erase
C $F2A5,2 For the same two points
C $F2A7,3 Used for the erased line we
C $F2AA,3 Must plot the first
C $F2AD,2 and last point on the
C $F2AF,3 line
C $F2BA,3 Drawing ON
C $F2C2,2 Skip if no draw instrucs left
C $F2C9,2 Bit 7 = DrawLine
C $F2CB,2 Else just do a point
C $F2CD,2 What pixel
C $F2CF,3 Set it
C $F2D6,1 B = startofline
C $F2D9,3 C = End
C $F2DC,3 Draw the line
C $F2E6,2 Draw the line
C $F2ED,2 Repeat if more bits
C $F2F3,3 Next Line up
C $F2F6,3 Recalc screen position
C $F300,3 Repeat if more lines to process
c $F304
@ $F304 label=CalcLineOnScreen
b $F32A Landscape Location Calculation Table
D $F32A #TABLE(default,centre,:w) { =h Type | =h Variable | =h Description } { int8  | dy   | location y adjuster } { int8  | dx   | location x adjuster } { int16 | xadj | screen x adjuster   } { uint8 | y    | screen y position   } { uint8 | size | scale               } TABLE#
@ $F32A label=LandscapeLocCalcTable
B $F32A,6,6 5,  4,  86, 64, 7
B $F330,6,6 4,  5, 114, 64, 7
B $F336,6,6 6,  2,  41, 64, 7
B $F33C,6,6 6,  1,  21, 64, 7
B $F342,6,6 6, -1, -21, 64, 7
B $F348,6,6 6,  0,   0, 64, 7
B $F34E,6,6 5,  3,  69, 63, 7
B $F354,6,6 3,  5, 131, 63, 7
B $F35A,6,6 4,  4, 100, 63, 7
B $F360,6,6 5,  2,  48, 63, 6
B $F366,6,6 5,  1,  25, 63, 6
B $F36C,6,6 5, -1, -25, 63, 6
B $F372,6,6 5,  0,   0, 62, 6
B $F378,6,6 4,  3,  82, 62, 6
B $F37E,6,6 3,  4, 118, 62, 6
B $F384,6,6 4,  2,  59, 62, 6
B $F38A,6,6 3,  3, 100, 61, 5
B $F390,6,6 4,  1,  31, 61, 5
B $F396,6,6 4, -1, -31, 61, 5
B $F39C,6,6 4,  0,   0, 60, 5
B $F3A2,6,6 3,  2,  75, 59, 5
B $F3A8,6,6 2,  3, 125, 59, 5
B $F3AE,6,6 3,  1,  41, 58, 4
B $F3B4,6,6 3, -1, -41, 58, 4
B $F3BA,6,6 3,  0,   0, 57, 4
B $F3C0,6,6 2,  2, 100, 57, 4
B $F3C6,6,6 2,  1,  59, 53, 3
B $F3CC,6,6 1,  2, 141, 53, 3
B $F3D2,6,6 2,  0,   0, 51, 2
B $F3D8,6,6 1,  1, 100, 43, 1
B $F3DE,6,6 1,  0,   0, 32, 0
c $F3E4
@ $F3E4 label=CalcMapLocation
C $F3EA,2 Not On Map
C $F3EF,2 Not On Map
C $F3F4,2 Not On Map
C $F3F6,3 Reference FeatureMap
C $F3F9,1 Get from map
C $F3FB,2 First 4 bits are the feature
C $F401,8 Rotate it right 4 times to get the second 4 bits
C $F409,3 They are the object
C $F40F,1 Reference Description Map
C $F412,2 First six bits are the area
C $F418,2 Bit seven is the Domain flag (Are we in one!)
C $F41E,2 Bit
@ $F422 label=OffTheMap
c $F436
@ $F436 label=CalcMapHL
c $F44A
@ $F44A label=DrawGraphicView
C $F450,2 A*6
@ $F46A ssub=LD ($FF25+1),A
@ $F484 ssub=LD A,($FF27+1)
@ $F48E ssub=LD ($FF13+1),A
C $F4AC,1 Clear carry
c $F4FC
@ $F4FC label=DrawGraphicVision
C $F506,3 Where are we looking?
C $F509,2 If bit 1 is set then
C $F50B,2 we are looking NE,SE,SW,NW
C $F50D,2 otherwisw its N,E,S,W
b $F574 Landscape Direction Adjustment tables
@ $F574 label=LandscapeDirAdjustTableX
B $F574,9,9
b $F57D
@ $F57D label=LandscapeDirAdjustTableY
B $F57D,9,9
c $F586
@ $F586 label=LocateOnScreen
C $F589,1 HL = Attributes
C $F58A,2 DE = ScreenAddress
c $F5A8
@ $F5A8 label=PrintAsciiChar
c $F5CB
@ $F5CB label=DisplayCharacter
C $F5D9,3 CharacterDataTable
C $F5E0,1 *6
C $F5E8,3 Depth of Character
C $F5ED,3 Width of Character
C $F5FA,1 BC=Address Character Data
C $F5FE,1 DE=Attributes Character
C $F63B,3 New Row
C $F645,1 Have We Finised
c $F64D
@ $F64D label=CopyScreen
c $F689
@ $F689 label=Bytes_Print_Buffer
c $F690
@ $F690 label=DecodeToken
C $F690,3 A=Token Required
C $F693,3 HL=Required Byte
C $F697,1 One more than required token
C $F69C,1 Is this the start of
C $F69D,2 the Token we want?
C $F6A1,2 No
C $F6A3,1 Add on the length of
C $F6A4,1 this token to our required
C $F6A5,2 Byte and loop
@ $F6A7 label=GetTokenChars
C $F6A7,1 Length-1
C $F6A8,1 Set up loop
C $F6A9,3 Increment the text buffer length
C $F6B1,4 Position in buffer
C $F6B6,3 Get the ASCII byte
C $F6B9,2 Loop for all Chars.
c $F6C0
@ $F6C0 label=PrintWordFromBuffer
C $F6C3,1 What Column are we on?
C $F6C4,3 How Big is this line?
C $F6C9,3 What's the width of our viewpoint?
C $F6CC,1 Check to see if there's enough space.
C $F6CD,3 We're Okay to print.
C $F6D4,3 Reset the Column.
C $F6DA,1 Next Row.
C $F6DE,3 Next Column.
C $F6E2,3 Set column to print at!
C $F6E8,3 Row That we are on.
C $F6EB,2 Deep shit if we get this far!
C $F6EE,3 Start of buffer to print.
C $F6F1,1 Get Byte to print.
C $F6F2,3 Decide wether the letter needs uppercasing
C $F6F5,3 Set byte to print.
C $F6F8,1 Next byte!
C $F6FA,3 Print the character.
C $F700,1 One column on.
C $F705,3 How many Charcters?
C $F708,1 One less!
C $F709,3 Store away.
C $F70C,2 Have we printed them all?
C $F70E,2 Loop until we have
C $F713,3 Update the variables.
c $F717 Print the message to the buffer.
D $F717 Messages in the game are stored in a tokenised format. As each byte is read and is checked to see if it's a special code, otherwise the word is looked up in the token dictionary; this word is used in all lowercase. The next token is read to check if it's either a CONNECT or LITERAL, if it is then this new text is added to the current word and the next token is checked again, otherwise the word is printed with a space at the end.
@ $F717 label=PrintOutBuffer
C $F71A,3 Print Output Destination address
C $F721,1 Reset these variables.
C $F728,1 Get the bytes.
C $F729,2 Was it a TERMINATOR?
C $F72B,1 Finished if it was.
C $F72C,2 Are we expecting a LITERAL?
C $F730,2 UPPERCASE Token?
C $F734,2 NEWLINE
C $F738,3 Token to decode.
C $F742,2 LITERAL?
C $F746,2 CONNECT token to last word
C $F74A,1 Time to print the last words
C $F74B,3 Made up in buffer.
C $F74F,2 Loop all over again.
@ $F751 label=UppercaseToken
@ $F758 label=StartOfNextLine
@ $F768 label=DealWithLiteral
@ $F77D label=ConnectTokenToLast
c $F781
@ $F781 label=DecideCase
C $F782,3 If uppercase flag is set
C $F785,2 then we'll have to make
C $F787,2 All characters uppercase!
C $F789,3 Other wise check wether only
C $F78C,2 the first char needs making
C $F78E,2 uppercase
@ $F792 label=LowerToUpperFirstChar
@ $F796 label=LowerToUpper
c $F7A0
@ $F7A0 label=FillPrintBuffer
C $F7A0,1 DE=Start of Print Buffer
C $F7A5,1 Get the byte
C $F7A6,1 Store byte away.
C $F7A7,2 Was it the last one/TERMINATOR?
C $F7A9,2 Exit out!
C $F7AB,1 Increase Source
C $F7AC,1 Increase destination
C $F7AD,2 Loop.
c $F7B5
@ $F7B5 label=FlushPrintBuffer
c $F7C4
@ $F7C4 label=SetTokenToUpperCase
C $F7C4,2 UPPERCASE token
c $F7C6
@ $F7C6 label=A_IntoPrintBuffer
c $F7D1
@ $F7D1 label=SetTokenToLowerCase
c $F7D5
@ $F7D5 label=AddTokenWithConnect
C $F7D7,2 CONNECT
c $F7E2
@ $F7E2 label=AddLiteralToBuffer
C $F7E4,2 LITERAL
c $F7EF
@ $F7EF label=TerminatorToBuffer
C $F7EF,2 TERMINATOR
c $F7F3
@ $F7F3 label=SToBuffer
c $F7F7
@ $F7F7 label=StopToBuffer
c $F7FB
@ $F7FB label=CommaToBuffer
c $F7FF
@ $F7FF label=PercentToBuffer
c $F803
@ $F803 label=AndSignTobuffer
c $F807
@ $F807 label=PlinkToBuffer
c $F80B
@ $F80B label=HashToBuffer
c $F80F
@ $F80F label=SpaceToBuffer
c $F813
@ $F813 label=PluralToken
c $F81E
@ $F81E label=TestFeatureForPlural
C $F838,3 Location Singular
@ $F83F label=LocationPlural
C $F83F,2 TERMINATOR
c $F848
@ $F848 label=DescribeLocation
C $F84B,2 Is it any where special?
C $F84D,2 If so describe the feature
C $F85E,2 If it's an army
C $F862,1 Then pretend its a Plain!
C $F866,2 Feature Token
C $F869,1 'The'
C $F870,1 what
C $F874,2 'Of'
c $F879
@ $F879 label=DescribeLocationArea
C $F87C,2 Lost
C $F880,2 Moon
C $F884,2 Targ
c $F888
@ $F888 label=PrintPlaceDescription
@ $F891 label=ItNeedsThe
@ $F897 label=ItsAHenge
@ $F89F label=ItsALake
B $F8A2,4,4 'Lake'
@ $F8A8 label=ItsFrozenWaste
B $F8AB,6,6 'The Frozen Waste'
@ $F8B4 label=DescribeFeature
C $F8BA,2 Single or plural
C $F8BC,2 Plural!
C $F8BE,2 'A'
C $F8C6,2 Is there an army?
C $F8C8,2 No.
C $F8CA,1 Pretend its plains
C $F8CB,2 Description Token
B $F8D3,6,6 'In The Domain of'
c $F8DC
@ $F8DC label=DescribeWhereHeIs
B $F8DF,6,6 'He Stands'
C $F8EE,3 Where Abouts are we?
C $F8F6,3 What is here?
C $F8FC,2 Work out the correct
C $F8FE,1 terminology for the
C $F8FF,3 place we are
C $F902,1 AT/IN/ON/BESIDE
C $F90D,2 'Looking'
C $F920,3 Different Area?
C $F926,3 Different Domain
C $F92C,3 Same Feature
@ $F932 label=LookingSomeWhereElse
C $F932,2 'To'
b $F93D
@ $F93D label=WhereTable
B $F93D,16,8
c $F94D
@ $F94D label=LookingWhere
b $F96B
@ $F96B label=DirectionTable
B $F96B,16,8
c $F97B
@ $F97B label=PrintTimeStatus
B $F996,3,3 'Less Than'
@ $F999 label=ActualHoursRemaining
C $F99B,3 Token for Number of hours
C $F9A4,2 'Hour'
B $F9AC,4,4 'Of The Day'
C $F9B7,1 One
@ $F9BA label=AFewHourRemain
@ $F9BB label=HoursRemaining
C $F9BE,2 'Remain'
@ $F9C3 label=KnightTyme
B $F9C6,4,4 'It Is Night'
@ $F9CB label=DawnTyme
B $F9CE,4,4 'It is Dawn'
c $F9D3
@ $F9D3 label=FindLookingTowards
C $F9F5,1 Looking North/South
C $F9F6,3 towards which Location?
C $F9F9,1 Recalc
C $F9FA,3 Well This one of course!
@ $FA01 ssub=LD A,($FF13+1)
@ $FA05 ssub=LD ($FF13+1),A
C $FA18,3 What are we looking at?
C $FA1D,2 No - We found Something
C $FA1F,3 Yes
C $FA22,1 We can therefore look forward
C $FA23,3 until we find something or
C $FA26,2 three locations infront!
b $FA31
@ $FA31 label=DirectionLookTable
B $FA31,16,8
c $FA41
@ $FA41 label=PrintShieldBit
C $FA45,1 A*4
C $FA4C,1 From Table at LDE8C
C $FA4E,1 DE=Address of Data
C $FA57,1 Depth of data
C $FA58,3 Width of data
C $FA5C,3 Ink
C $FA60,3 Paper
C $FA69,3 L=Row
C $FA6C,1 H=Column
C $FA78,2 Is it printable?
C $FA7A,2 No. skip the print.
C $FA7C,3 Yes. Char to print
C $FA81,3 Print it
C $FA89,1 Next column position
C $FA8E,2 Loop until finished row!
C $FA90,3 Reset the print Column
C $FA96,3 Reset the print width
C $FA9A,3 One row down.
C $FAA1,1 One less of the depth
C $FAA3,2 Have we finished?
C $FAA5,2 Loop until we have.
c $FAA8
@ $FAA8 label=PrintShield
C $FAB7,1 A*8
C $FABB,3 Entry in ShieldConstructTable
C $FABF,1 Get the first byte.
C $FAC0,1 This is the shields paper.
C $FAC2,1 A*8
C $FACB,1 Part of shield to print!
C $FACC,3 Is going to be the main shield
C $FACF,3 first at :- Column=0
C $FAD2,3 Row=0
C $FAD6,3 Ink of Blue
C $FADF,1 Get the next bit!
C $FAE0,2 Have we finished?
C $FAE2,2 Exit if we have.
C $FAE4,1 Preserve value
C $FAE5,2 First three bits.
C $FAE7,3 Are the bit type 0 to 7
C $FAEA,1 Restore Value
C $FAEF,2 Next three bits are
C $FAF1,3 the parts ink. 0 to 31!
C $FAF5,1 Next byte
C $FAF6,1 Preserve value
C $FAF7,2 First three bits are
C $FAF9,3 the column. 0 to 7
C $FAFC,1 Restore Value
C $FB01,2 Next threee bits are
C $FB03,3 the row. 0 to 31!
C $FB06,2 Loop.
c $FB0D
@ $FB0D label=ClearWindow
C $FB0E,3 C=Row, B=Col
C $FB11,3 D=Width
C $FB14,1 H=Column
c $FB41
@ $FB41 label=DoWindowOne
c $FB58
@ $FB58 label=DoWindowTwo
c $FB72
@ $FB72 label=DoWindowThree
c $FB86
@ $FB86 label=DoWindowFour
c $FBAC
@ $FBAC label=ClearAttributesNight
c $FBBF
@ $FBBF label=ClearAttributesDay
c $FBD2
@ $FBD2 label=FullCharTitle
B $FBF6,3,3 'Lord'
@ $FBFB label=IsMoonprince
@ $FBFF label=IsNobody
@ $FC02 label=IsFey
@ $FC06 label=IsWise
@ $FC0A label=IsDragon
C $FC0F,2 -Lord
@ $FC14 label=IsSkulkrin
@ $FC18 label=TheLordOf
B $FC1B,5,5 'The Lord Of'
@ $FC22 label=The_Name_Of
C $FC28,2 'Of'
c $FC2D
@ $FC2D label=FirstNameToBuffer
c $FC36
@ $FC36 label=TheToBuffer
c $FC3A
@ $FC3A label=FirstName_The_What
c $FC48
@ $FC48 label=CalcCharTablePos
C $FC50,1 Mult by 32
C $FC56,1 Add Offset
c $FC5B
@ $FC5B label=SaveCharDetails
c $FC61
@ $FC61 label=CopyCharDetails
c $FC6A Display what we're looking at
@ $FC6A label=DrawMainScreen
C $FC6C,3 Depending what time of day
C $FC6F,2 it is decides the top screens
C $FC71,2 attributes.
C $FC79,3 Clear the Top Screen
C $FC82,3 Draw the Characters Shield
B $FC88,6,6
C $FC93,3 Display the Characters name
B $FC9C,6,6
C $FCA2,3 Display the Characters name
C $FCA8,3 Draw the LANDSCAPE
C $FCAE,2 How exatcly is the landscape
C $FCB0,3 going to be coloured in?
c $FCB6
@ $FCB6 label=DrawMainFeature
C $FCC3,3 = 'l'
B $FCD4,6,6
B $FCFD,6,6
c $FD04
@ $FD04 label=GetFromCharHereTable
C $FD07,1 Character we want
C $FD0A,3 Start of table
C $FD0D,1 Position in table.
C $FD0E,1 Get the char No.
C $FD12,3 Get the Character and return.
c $FD15
@ $FD15 label=Initialise
@ $FD21 label=Initialise1
t $FD22 Message at FD22
@ $FD22 label=CharKeysTable
T $FD22,32,32
c $FD42
@ $FD42 label=SelectCharacter
C $FD45,1 What Key?
C $FD48,3 Reference Table
C $FD4D,1 Check Entry
C $FD4E,1 Is it what we pressed?
C $FD4F,2 Yes
@ $FD57 label=FoundCharKey
c $FD6A
@ $FD6A label=CheckKeyCase
c $FD76
@ $FD76 label=DisplayPressAKey
B $FD7C,6,6
B $FD85,8,8 'Press A Key To Choose....'
B $FD8D,9,8,1
c $FD99
@ $FD99 label=RandomishNumber
c $FDA8
@ $FDA8 label=InitialiseChoices
C $FDAB,2 Clear out the
C $FDAD,1 table of keys
C $FDB1,3 CanWeSeek
C $FDB4,2 Are We Hidden?
C $FDB6,2 We Can't Seek Then!
C $FDB8,2 '1'
B $FDC0,2,2 'Seek'
@ $FDC2 label=CanWeHide
C $FDC7,2 We can't Hide if we
C $FDC9,3 have any Warriors or
C $FDCC,2 Riders!
C $FDD0,3 Morkin can't hide either
C $FDD7,2 '2'
C $FDDC,3 If we are already
C $FDDF,2 hidden then we must
C $FDE1,2 not hide!
B $FDE6,2,2 'Hide'
@ $FDE8 label=AnyBodyElseHere
C $FDEE,2 No.
@ $FDF0 label=DoNotHide
B $FDF3,6,6 'Do Not Hide'
@ $FDFA label=CanWeFight
C $FDFD,2 Nothing here at all
C $FE01,2 Anything we can fight?
C $FE05,3 Store Whats Nasty
C $FE08,2 '3'
B $FE10,3,3 'Fight The'
@ $FE16 label=CanWeRecruit
C $FE19,3 Who's in this location?
C $FE1C,2 Any one?
C $FE26,2 '4'
B $FE2E,2,2 'Recruit'
@ $FE36 label=AreWeAtA_Citadel_Keep
C $FE41,10 Check the race of the army against that of the character to see if they're friend or foe.
C $FE4E,2 Might want to put some men
C $FE50,2 on guard.
C $FE55,2 Riders or Warriors?
@ $FE61 label=CanWeRecruitMen
C $FE63,2 Got To Many!
C $FE65,2 '5'
B $FE6D,3,3 'Recruit Men'
@ $FE70 label=CanWeStandMenOnGuard
C $FE77,3 WarriorsGuard
C $FE7A,2 Have we enough Warriors
@ $FE7E label=OnGuard
C $FE7E,2 '6'
B $FE86,5,5 'Stand Men On Guard'
@ $FE8D label=RidersGuard
C $FE90,2 Have we enough Riders
@ $FE94 label=CanWeBattle
C $FE97,2 Are we a coward?
C $FE9A,3 Anything of Doomdarks army to Battle?
C $FE9F,1 Return if not!
C $FEA6,3 Anything of Doomdarks army to Battle?
C $FEAB,1 Return if not!
C $FEB2,2 '7'
B $FEBA,5,5 'To Battle!'
c $FEC0
@ $FEC0 label=AnyCharsToRecruit
C $FEC1,3 Nobody in location-Ish
C $FEC4,3 Store this of the
C $FEC7,3 Character at location.
C $FECA,3 How Many People Are here?
C $FECD,2 Less than 2 is no good.
C $FECF,1 Which by the way is Zero & one.
C $FED0,1 Start at begining
C $FED1,3 Where we up to?
C $FED4,3 Get his details
C $FED7,3 Has the character already
C $FEDA,2 been recruited?
C $FEDC,2 Forget him if he has?
C $FEDE,3 Can this character
C $FEE1,1 be recuited by the character
C $FEE2,3 at the current location?
C $FEE8,2 No he can't be
C $FEED,3 If he can. He's Ready.
C $FEF3,1 Store how many are here.
C $FEF4,3 Increment our count!
C $FEF8,1 Are we at the end?
C $FEF9,2 Loop until we are
u $FEFE
B $FEFE,2,2
w $FF00
@ $FF00 label=Image_XPixel
W $FF00,2,2
b $FF02
@ $FF02 label=Image_YPixel
B $FF02,1,1
b $FF03
@ $FF03 label=LFF03
B $FF03,1,1
b $FF04
@ $FF04 label=LFF04
B $FF04,1,1
b $FF05
@ $FF05 label=LFF05
B $FF05,1,1
b $FF06
@ $FF06 label=LFF06
B $FF06,1,1
b $FF07
@ $FF07 label=LFF07
B $FF07,1,1
b $FF08
@ $FF08 label=LFF08
B $FF08,1,1
b $FF09
@ $FF09 label=Image_PlotOnOff
B $FF09,1,1
b $FF0A
@ $FF0A label=Image_YOffset
B $FF0A,1,1
b $FF0B
@ $FF0B label=Image_Height
B $FF0B,1,1
b $FF0C
@ $FF0C label=Image_AnotherBit
B $FF0C,1,1
b $FF0D
@ $FF0D label=Image_DrawInstrucs
B $FF0D,1,1
b $FF0E
@ $FF0E label=FeatureAddress
B $FF0E,2,2
b $FF10
@ $FF10 label=Feature_Draw
B $FF10,1,1
b $FF11
@ $FF11 label=Feature_Size
B $FF11,1,1
b $FF12
@ $FF12 label=Print_Ink
B $FF12,1,1
b $FF13
@ $FF13 label=WorkingLocation
B $FF13,2,2
b $FF15
@ $FF15 label=LocationFeature
B $FF15,1,1
b $FF16
@ $FF16 label=LocationObject
B $FF16,1,1
b $FF17
@ $FF17 label=LocationArea
B $FF17,1,1
b $FF18
@ $FF18 label=LocDomainFlag
B $FF18,1,1
b $FF19
@ $FF19 label=LocSpecialFlag
B $FF19,1,1
b $FF1A
@ $FF1A label=Landscape_ScrAdjustDoWhat
B $FF1A,1,1
b $FF1B
@ $FF1B label=Landscape_LeftScrDoWhat
B $FF1B,1,1
b $FF1C
@ $FF1C label=Landscape_RightScrDoWhat
B $FF1C,1,1
b $FF1D
@ $FF1D label=Landscape_XAdjustDoWhat
B $FF1D,1,1
b $FF1E
@ $FF1E label=Landscape_LeftXAdjustDoWhat
B $FF1E,1,1
b $FF1F
@ $FF1F label=Landscape_RightXAdjustDoWhat
B $FF1F,1,1
b $FF20
@ $FF20 label=Landscape_YAdjustDoWhat
B $FF20,1,1
b $FF21
@ $FF21 label=Landscape_LeftYAdjustDoWhat
B $FF21,1,1
b $FF22
@ $FF22 label=Landscape_RightYAdjustDoWhat
B $FF22,1,1
b $FF23
@ $FF23 label=Landscape_YAdjust
B $FF23,1,1
b $FF24
@ $FF24 label=Landscape_XAdjust
B $FF24,1,1
b $FF25
@ $FF25 label=Landscape_ScrAdjust
B $FF25,2,2
b $FF27
@ $FF27 label=CurrentLocationY
B $FF27,2,2
b $FF29
@ $FF29 label=CurrentlyLooking
B $FF29,1,1
b $FF2A
@ $FF2A label=LandscapePosition
B $FF2A,1,1
b $FF2B
@ $FF2B label=Print_Col
B $FF2B,1,1
b $FF2C
@ $FF2C label=Print_Row
B $FF2C,1,1
b $FF2D
@ $FF2D label=Print_Attr
B $FF2D,1,1
b $FF2E
@ $FF2E label=Print_Char
B $FF2E,1,1
b $FF2F
@ $FF2F label=Print_Mask
B $FF2F,1,1
b $FF30
@ $FF30 label=CharacterToPrint
B $FF30,1,1
b $FF31
@ $FF31 label=Window_Attr
B $FF31,1,1
b $FF32
@ $FF32 label=Window_Width
B $FF32,1,1
b $FF33
@ $FF33 label=Window_Depth
B $FF33,1,1
b $FF34
@ $FF34 label=Column
B $FF34,1,1
b $FF35
@ $FF35 label=Row
B $FF35,1,1
b $FF36
@ $FF36 label=Print_Temp
B $FF36,1,1
u $FF37
B $FF37,1,1
w $FF38
@ $FF38 label=TextBuffer
W $FF38,2,2
b $FF3A
@ $FF3A label=ViewPoint_Col
B $FF3A,1,1
b $FF3B
@ $FF3B label=ViewPoint_Row
B $FF3B,1,1
b $FF3C
@ $FF3C label=ViewPoint_StartCol
B $FF3C,1,1
b $FF3D
@ $FF3D label=ViewPoint_Width
B $FF3D,1,1
w $FF3E
@ $FF3E label=PrintBufferStart
W $FF3E,2,2
b $FF40
@ $FF40 label=TextLength
B $FF40,1,1
b $FF41
@ $FF41 label=MakeFirstCharUpper
B $FF41,1,1
b $FF42
@ $FF42 label=UpperCaseFlag
B $FF42,1,1
w $FF43
@ $FF43 label=PrintBufferPos
W $FF43,2,2
b $FF45
@ $FF45 label=QuantityFlag
B $FF45,1,1
b $FF46
@ $FF46 label=TempVar
B $FF46,1,1
u $FF47
B $FF47,1,1
u $FF48
B $FF48,1,1
u $FF49
B $FF49,1,1
w $FF4A
@ $FF4A label=LocationLookingAt
W $FF4A,2,2
w $FF4C
@ $FF4C label=DesirableLocation
W $FF4C,2,2
b $FF4E
@ $FF4E label=MapYLookAdjust
B $FF4E,1,1
b $FF4F
@ $FF4F label=MapXLookAdjust
B $FF4F,1,1
w $FF50 Address to start of token table
@ $FF50 label=StartOfTokenTable
W $FF50,2,2 (default value overwritten during initialisation)
b $FF52
@ $FF52 label=LookForwardCount
B $FF52,1,1
b $FF53
@ $FF53 label=Shield_Paper
B $FF53,1,1
b $FF54
@ $FF54 label=Shield_Ink
B $FF54,1,1
b $FF55
@ $FF55 label=ShieldNumber
B $FF55,1,1
b $FF56
@ $FF56 label=LowerWindowAttr
B $FF56,1,1
b $FF57
@ $FF57 label=TempCharacterNo
B $FF57,1,1
b $FF58
@ $FF58 label=NoOfUnits
B $FF58,1,1
b $FF59
@ $FF59 label=NoOfTens
B $FF59,1,1
b $FF5A
@ $FF5A label=NoOfHundreds
B $FF5A,1,1
b $FF5B
@ $FF5B label=NoOfThousands
B $FF5B,1,1
b $FF5C
@ $FF5C label=NoOfMillions
B $FF5C,1,1
w $FF5D
@ $FF5D label=LastRandomNumber
W $FF5D,2,2
u $FF5F
B $FF5F,1,1
b $FF60
@ $FF60 label=CharLocation
B $FF60,2,2
b $FF62
@ $FF62 label=CharLookDirection
B $FF62,1,1
b $FF63
@ $FF63 label=CharTimeOfDay
B $FF63,1,1
b $FF64
@ $FF64 label=CharFirstName
B $FF64,1,1
b $FF65
@ $FF65 label=CharTitle
B $FF65,1,1
b $FF66
@ $FF66 label=CharAvailable
B $FF66,1,1
b $FF67
@ $FF67 label=CharGraphicType
B $FF67,1,1
b $FF68
@ $FF68 label=CharNoRiders
B $FF68,1,1
b $FF69
@ $FF69 label=CharRidersEnergyStatus
B $FF69,1,1
b $FF6A
@ $FF6A label=CharNoWarriors
B $FF6A,1,1
b $FF6B
@ $FF6B label=CharWarriorsEnergyStatus
B $FF6B,1,1
b $FF6C
@ $FF6C label=CharBattleArea
B $FF6C,1,1
b $FF6D
@ $FF6D label=CharRidersLost
B $FF6D,1,1
b $FF6E
@ $FF6E label=CharWarriorsLost
B $FF6E,1,1
b $FF6F
@ $FF6F label=CharSlew
B $FF6F,1,1
b $FF70
@ $FF70 label=CharRidersSlew
B $FF70,1,1
b $FF71
@ $FF71 label=CharWarriorsSlew
B $FF71,1,1
b $FF72
@ $FF72 label=CharBattleStatus
B $FF72,1,1
b $FF73
@ $FF73 label=CharLifeStatus
B $FF73,1,1
b $FF74
@ $FF74 label=CharEnergyStatus
B $FF74,1,1
b $FF75
@ $FF75 label=CharFightStrength
B $FF75,1,1
b $FF76
@ $FF76 label=CharCowardess
B $FF76,1,1
b $FF77
@ $FF77 label=CharRecruitingKey
B $FF77,1,1
b $FF78
@ $FF78 label=CharRecruitedBy
B $FF78,1,1
b $FF79
@ $FF79 label=CharCourageStatus
B $FF79,1,1
u $FF7A
B $FF7A,1,1
b $FF7B
@ $FF7B label=CharHideFlag
B $FF7B,1,1
b $FF7C
@ $FF7C label=CharRace
B $FF7C,1,1
b $FF7D
@ $FF7D label=CharHasAHorse
B $FF7D,1,1
b $FF7E
@ $FF7E label=CharObjectCarrying
B $FF7E,1,1
b $FF7F
@ $FF7F label=CharDeathStatus
B $FF7F,1,1
c $FF80 Lookup a token in the token dictionary
D $FF80 Tokens are stored using 5-bit bytes compressed together; the format is [length][length*char]. All tokens have to be decoded until the required token is found.
@ $FF80 label=GetRequiredByte
C $FF81,1 HL=required byte
C $FF83,1 Multiply by 5
C $FF87,2 This is the same as
C $FF89,1 doing A=(HL MOD 8)+1
C $FF8B,2 HL=HL/8
C $FF8D,2 HL=Actual byte position in
C $FF8F,2 the data with B= to no of
C $FF91,2 rotations to get the required
C $FF93,2 five bits.
@ $FFA1 label=Rotate_Once
C $FFA1,2 Rotate one bit
@ $FFA5 label=Rotate_B_Times
C $FFA5,2 Looop until finished
C $FFA7,1 A=Byte required
C $FFA8,2 Only need bottom five bits.
c $FFAC Reads an ASCII character from the token dictionary
@ $FFAC label=GetASCIIchar
C $FFAD,3 Get the byte from the data
C $FFB1,2 add on 'a'-1
C $FFB3,1 Store in buffer
C $FFB4,1 Increase required byte
C $FFB5,1 Increase position in buffer
c $FFB8
@ $FFB8 label=DefineViewPoint
> $FFB8,1 ; The Pasmo assembler uses this directive when generating a tape image to know
> $FFB8,1 ; where to start running the game from.
> $FFB8,1 ; end $5B04
i $FFD1
