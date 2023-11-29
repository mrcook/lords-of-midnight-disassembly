# The Lords of Midnight - Game Source Code

This project contains the (unofficial) disassembly of both the ZX Spectrum and
the PC DOS version of _The Lords of Midnight_ (LOM), the 1984 video game
designed and developed by Mike Singleton.

## Motivation

My motivation for doing two disassembly at the same time came about after I
found that Chris Wild had released a large chunk of the source code to his PC
version, and that his port was an also almost
[byte-for-byte conversion](https://www.icemark.com/tower/pcconv.htm) of the
ZX Spectrum game (due to the similarities between the Z80 and 8086
microprocessors). This piqued my interest and I wondered exactly how close the
two versions of the game really are.

Although I've disassembled a couple of ZX Spectrum games before I've never
tackled a DOS game, but with Chris' source code in hand I was feeling
confident.

## How?

The Ghidra reverse engineering tool was used to disassemble the PC version.
I then applied all the labels and comments from the DOS source code to the
Ghidra disassembly. Chris' release doesn't contain the whole game so I had
to disassemble the remaining code myself. Further labels and annotations were
added where things seemed obvious or didn't take too long to figure out.

After the DOS version was complete I then booted up Skoolkit and started
disassembling the Spectrum game. Although time consuming, this was relatively
straight forward at this point.

The Icemark website contains a great deal of useful information on the game
data formats along with information on what many of the associated data values
mean, including:

* location coordinates for items and places in the world
* character stats (coords, race, life, energy, strength, etc.)
* citadels/keeps location, unit count and type
* strategic places data
* recruitment information
* doomdark's regiment stats (coords, soldier count, type, and orders)

This information is found under the
[Guidance from the Wise](https://www.icemark.com/tower/guidance.htm) section.

I used various parts of this additional information to flesh out the two
disassembly's with more labels and annotations. The resulting source codes are
still relatively sparse, but you can certainly see how close the two versions
of the game are.


## Skoolkit Notes

Download and extract `.z80` binary with the following command:

    tap2sna.py -f @lom.t2s

The `.skool` can be generated using the provided `.ctl` file:

    sna2skool.py -I LineWidth=96 -c lom.ctl -H lom.z80 > lom.skool

When editing the `.skool` file directly, the `.ctl` file should be re-generated:

    skool2ctl.py -h lom.skool > lom.ctl


## Copyright Information

Disassembly, comments, and notes, 2023, Michael R. Cook.

Designed and developed by Mike Singleton.

Copyright (c) 1984 Beyond Software.

PC Version and DOS source code, Copyright Chris Wild. https://www.icemark.com
