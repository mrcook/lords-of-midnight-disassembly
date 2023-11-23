; The Lords of Midnight (LOM) - ZX Spectrum Disassembly
; (https://github.com/mrcook/lords-of-midnight-z80-disassembly)
;
; Disassembled by Michael R. Cook, 2023
;
; Copyright (c) 1984 Beyond Software
; LOM was designed and developed by Mike Singleton
;
; Many of the labels and comments are taken directly from the 1991
; DOS source code (v1.05) by Chris Wild (https://www.icemark.com)

  ORG $4000

; Loading Screen
L4000:
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$9C,$FF,$FF,$FF,$FF,$FF,$FF,$E7,$FF,$FF,$FF,$FF,$F3,$9F,$FF
  DEFB $FF,$FF,$FF,$F9,$FF,$FF,$FF,$FF,$FF,$E7,$C7,$FF,$FF,$C9,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$80,$9C,$80,$FF,$8F,$E3,$91,$93,$C1,$FF,$E3,$80,$FF,$9C,$C0
  DEFB $93,$9C,$C0,$E1,$9C,$80,$FF,$FF,$FF,$00,$00,$00,$F0,$00,$00,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$01,$00,$03,$FC,$00,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$9F,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$03,$80,$03,$F8,$00,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$00,$00,$00,$00,$00,$00,$FF,$FF,$E0,$00,$00,$00,$00,$07,$FF
  DEFB $FF,$FF,$9C,$F9,$9F,$FF,$FF,$C1,$F9,$FF,$FF,$E7,$FF,$F3,$FF,$FF
  DEFB $FF,$00,$F0,$00,$00,$00,$00,$FF,$FF,$FF,$00,$00,$00,$00,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$8C,$FF,$FF,$FF,$FF,$FF,$FF,$E7,$FF,$FF,$FF,$FF,$E7,$9F,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$E7,$F3,$FF,$FF,$C4,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$A6,$9C,$CE,$FF,$9F,$C9,$8C,$89,$9C,$FF,$C9,$CE,$FF,$88,$F3
  DEFB $89,$8C,$F3,$CC,$9C,$A6,$FF,$FF,$FF,$00,$00,$00,$3E,$00,$00,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$00,$00,$01,$FC,$00,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$9F,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$00,$00,$03,$F8,$00,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$00,$00,$00,$00,$00,$00,$FF,$FF,$E0,$00,$00,$00,$00,$07,$FF
  DEFB $FF,$FF,$88,$FF,$9F,$FF,$FF,$9C,$FF,$FF,$FF,$E7,$FF,$E7,$FF,$FF
  DEFB $FF,$00,$3E,$00,$00,$00,$00,$FF,$FF,$FF,$80,$00,$00,$01,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$84,$C1,$89,$FF,$C1,$88,$91,$E7,$C1,$91,$C1,$FF,$81,$91,$C1
  DEFB $FF,$C1,$91,$E3,$C1,$FF,$89,$C1,$91,$E7,$C1,$FF,$C1,$CF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$00,$00,$00,$00,$00,$FF
  DEFB $FF,$E7,$9C,$CF,$FF,$9F,$9C,$9C,$9C,$9F,$FF,$9C,$CF,$FF,$80,$F3
  DEFB $9C,$84,$F3,$9F,$9C,$E7,$FF,$FF,$FF,$00,$00,$00,$1F,$80,$00,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$21,$08,$01,$FC,$00,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$91,$89,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$80,$09,$20,$07,$F0,$01,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$00,$00,$00,$00,$00,$00,$FF,$FF,$F0,$00,$00,$00,$00,$0F,$FF
  DEFB $FF,$FF,$80,$E3,$99,$C1,$FF,$9F,$E3,$91,$C1,$E7,$C1,$81,$C1,$91
  DEFB $FF,$00,$1F,$80,$00,$00,$00,$FF,$FF,$FF,$C0,$00,$00,$03,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$90,$9C,$9C,$FF,$9C,$C9,$8C,$E7,$9C,$8C,$9C,$FF,$CF,$8C,$9C
  DEFB $FF,$9C,$8C,$F3,$9C,$FF,$9C,$9C,$8C,$E7,$98,$FF,$9C,$CF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$00,$00,$00,$00,$00,$FF
  DEFB $FF,$E7,$80,$C1,$FF,$9F,$9C,$9C,$9C,$C1,$FF,$9C,$C1,$FF,$94,$F3
  DEFB $9C,$90,$F3,$90,$80,$E7,$FF,$FF,$FF,$00,$00,$00,$0F,$C0,$00,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$01,$00,$01,$FC,$00,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$8C,$CC,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$80,$01,$00,$07,$E0,$01,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$00,$00,$00,$00,$00,$00,$FF,$FF,$F0,$00,$00,$00,$00,$0F,$FF
  DEFB $FF,$FF,$94,$F3,$93,$9C,$FF,$C1,$F3,$8C,$9C,$E7,$9C,$CF,$9C,$8C
  DEFB $FF,$00,$0F,$C0,$00,$00,$00,$FF,$FF,$FF,$E0,$00,$00,$07,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$98,$9C,$94,$FF,$80,$E3,$9C,$E7,$9C,$9C,$80,$FF,$CF,$9C,$80
  DEFB $FF,$80,$9C,$F3,$9F,$FF,$94,$9C,$9C,$E7,$9C,$FF,$9C,$83,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$00,$00,$00,$00,$00,$FF
  DEFB $FF,$E7,$9C,$CF,$FF,$9F,$9C,$81,$9C,$FC,$FF,$9C,$CF,$FF,$9C,$F3
  DEFB $9C,$98,$F3,$9C,$9C,$E7,$FF,$FF,$FF,$00,$00,$00,$07,$E0,$00,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$09,$20,$01,$FC,$00,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$9C,$E4,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$80,$21,$08,$0F,$C0,$01,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$00,$00,$00,$00,$00,$00,$FF,$FF,$F8,$00,$00,$00,$00,$1F,$FF
  DEFB $FF,$FF,$9C,$F3,$87,$80,$FF,$FC,$F3,$9C,$9F,$E7,$80,$CF,$9C,$9C
  DEFB $FF,$00,$07,$E0,$00,$00,$00,$FF,$FF,$FF,$F0,$00,$00,$0F,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$9C,$9C,$C1,$FF,$9F,$C9,$8C,$E5,$9C,$81,$9F,$FF,$CD,$99,$9F
  DEFB $FF,$9F,$8C,$F3,$9C,$FF,$C1,$9C,$81,$E5,$9C,$FF,$9C,$CF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$00,$00,$00,$00,$00,$FF
  DEFB $FF,$E7,$9C,$CE,$FF,$9E,$C9,$99,$89,$9C,$FF,$C9,$CF,$FF,$9C,$F3
  DEFB $89,$9C,$F3,$CC,$9C,$E7,$FF,$FF,$FF,$00,$00,$00,$07,$F0,$00,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$00,$00,$01,$FC,$00,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$8C,$F1,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$C0,$00,$00,$1F,$80,$03,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$00,$00,$00,$00,$00,$00,$FF,$FF,$F8,$00,$00,$00,$00,$1F,$FF
  DEFB $FF,$FF,$9C,$F3,$93,$9F,$FF,$9C,$F3,$99,$98,$E5,$9F,$CD,$9C,$99
  DEFB $FF,$00,$07,$F0,$00,$00,$00,$FF,$FF,$FF,$F8,$00,$00,$1F,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$9C,$C1,$EB,$FF,$C0,$88,$91,$E1,$C1,$9C,$C0,$FF,$E3,$90,$C0
  DEFB $FF,$C0,$91,$E3,$C1,$FF,$EB,$C1,$9C,$E1,$C1,$FF,$C1,$CF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$00,$00,$00,$00,$00,$FF
  DEFB $FF,$E7,$9C,$80,$FF,$80,$E3,$9C,$93,$C1,$FF,$E3,$8F,$FF,$9C,$C0
  DEFB $93,$9C,$C0,$E1,$9C,$E7,$FF,$FF,$FF,$00,$00,$00,$03,$F8,$00,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$03,$80,$01,$FC,$00,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$91,$B3,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$C0,$01,$00,$3E,$00,$03,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$00,$00,$00,$00,$00,$00,$FF,$FF,$FC,$00,$00,$00,$00,$3F,$FF
  DEFB $FF,$FF,$9C,$E3,$98,$C0,$FF,$C1,$E3,$90,$C1,$E1,$C0,$E3,$C1,$90
  DEFB $FF,$00,$03,$F8,$00,$00,$00,$FF,$FF,$FF,$FC,$00,$00,$3F,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$9F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$9F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$9F,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$00,$00,$00,$00,$00,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$00,$00,$03,$F8,$00,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$BB,$BA,$03,$FC,$00,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$C7,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$C0,$00,$00,$F0,$00,$03,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$00,$00,$00,$00,$00,$00,$FF,$FF,$FE,$00,$00,$00,$00,$7F,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$F9,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$00,$03,$F8,$00,$00,$00,$FF,$FF,$FF,$FE,$00,$00,$7F,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$00,$03,$FC,$00,$08,$00,$FF,$FF,$FF,$FF,$00,$00,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$00,$03,$F8,$00,$7D,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$C0,$00,$00,$00,$1F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$E0,$00,$00,$08,$00,$07,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$F0,$E0,$70,$38,$7F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$00,$00,$7D,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$F0,$00,$00,$00,$7F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$F8,$FF,$FF,$FF
  DEFB $40,$90,$24,$09,$02,$40,$90,$24,$09,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $9F,$FF,$FF,$FF,$FF,$FF,$FF,$A4,$7C,$FF,$FF,$FF,$08,$05,$FF,$FF
  DEFB $02,$00,$00,$00,$00,$00,$00,$00,$00,$83,$FF,$FC,$43,$C0,$89,$80
  DEFB $08,$FC,$13,$08,$F8,$11,$A0,$00,$87,$47,$F9,$00,$00,$10,$7F,$FF
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$08,$7F,$F7,$7E,$1F,$80,$03,$F8
  DEFB $00,$00,$1F,$80,$11,$10,$68,$14,$A0,$00,$00,$FA,$00,$07,$FF,$10
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$00,$01,$FC,$00,$08,$00,$FF,$FF,$FF,$FF,$80,$01,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$00,$03,$F8,$00,$79,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$C0,$00,$00,$00,$1F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$E0,$00,$00,$08,$00,$07,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$F0,$00,$00,$00,$7F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$80,$00,$79,$01,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FD,$EF,$7B,$DE,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$80,$01,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$F0,$7F,$FF,$FF
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$01,$F7,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $1F,$FF,$FF,$FF,$FF,$FF,$FF,$C4,$B8,$FF,$FF,$F0,$10,$02,$FF,$FF
  DEFB $02,$00,$00,$00,$00,$00,$00,$04,$00,$FD,$FF,$F8,$73,$F8,$46,$00
  DEFB $08,$78,$20,$08,$F0,$09,$40,$00,$40,$C3,$C2,$00,$00,$10,$07,$FF
  DEFB $00,$00,$00,$20,$00,$00,$00,$00,$08,$7F,$F7,$7E,$1F,$80,$04,$98
  DEFB $00,$00,$00,$80,$11,$10,$68,$14,$A0,$00,$01,$86,$00,$00,$03,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$00,$01,$FC,$00,$08,$00,$FF,$FF,$FF,$FF,$C0,$03,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$80,$07,$F0,$00,$32,$01,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$F0,$00,$00,$08,$00,$0F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$C0,$00,$32,$03,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $9C,$E7,$39,$CE,$73,$9C,$E7,$39,$CE,$7F,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$C0,$03,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$E8,$3F,$FF,$FF
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$01,$FF,$FF,$FF,$FF,$FF,$FF,$FE
  DEFB $27,$FF,$FF,$CF,$FF,$FF,$FE,$08,$51,$3F,$FF,$C0,$20,$01,$FF,$FF
  DEFB $00,$00,$00,$00,$00,$80,$00,$04,$00,$F0,$3F,$F0,$8D,$84,$3E,$00
  DEFB $07,$F0,$C0,$04,$60,$06,$80,$00,$7F,$FF,$84,$00,$00,$08,$0B,$FF
  DEFB $00,$00,$00,$20,$00,$00,$00,$00,$08,$7F,$EF,$7E,$1F,$80,$0F,$FF
  DEFB $C3,$FF,$FF,$80,$10,$00,$48,$11,$20,$00,$03,$02,$00,$00,$00,$01
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$00,$01,$FC,$00,$1C,$00,$FF,$FF,$FF,$FF,$E0,$07,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$80,$07,$E0,$00,$1C,$01,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$F0,$00,$00,$00,$7F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$F0,$00,$00,$1C,$00,$0F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$E0,$00,$00,$00,$3F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$E0,$00,$1C,$07,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$7F,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$E0,$07,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$D0,$CF,$FF,$FF
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$01,$E3,$FF,$FF,$FF,$FC,$7F,$FC
  DEFB $43,$FF,$C7,$8F,$FF,$8F,$FE,$10,$32,$1F,$FF,$C0,$20,$20,$7F,$FF
  DEFB $00,$00,$00,$00,$00,$80,$00,$04,$00,$EF,$C1,$FF,$73,$7B,$F4,$00
  DEFB $08,$D1,$00,$04,$20,$0A,$80,$00,$A2,$A6,$88,$00,$00,$0E,$04,$7F
  DEFB $00,$00,$00,$20,$00,$00,$00,$00,$00,$2F,$DE,$FE,$1E,$80,$04,$00
  DEFB $7E,$A4,$80,$00,$18,$01,$48,$18,$20,$00,$05,$02,$00,$00,$00,$00
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$00,$01,$FC,$00,$1C,$00,$FF,$FF,$FF,$FF,$F0,$0F,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$80,$0F,$C0,$00,$00,$01,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$F0,$00,$00,$00,$7F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$F8,$00,$00,$1C,$00,$1F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$F7,$77,$77,$77,$7F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$F0,$00,$00,$0F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$7F,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$F0,$0F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$A1,$07,$FF,$FF
  DEFB $00,$02,$00,$00,$00,$00,$00,$00,$01,$FF,$FF,$FF,$FF,$F9,$CF,$F8
  DEFB $83,$FF,$9F,$13,$FF,$3F,$FC,$21,$0C,$1F,$FF,$80,$C0,$24,$3F,$FF
  DEFB $00,$00,$00,$00,$00,$80,$00,$04,$00,$5F,$DE,$E3,$FC,$FF,$FF,$D8
  DEFB $08,$D3,$00,$03,$FF,$FF,$E0,$01,$42,$A6,$90,$00,$00,$13,$FB,$FF
  DEFB $00,$00,$00,$20,$00,$00,$00,$00,$00,$23,$0C,$0A,$18,$80,$02,$00
  DEFB $64,$FF,$80,$00,$18,$01,$48,$14,$20,$00,$0E,$02,$00,$00,$00,$01
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$00,$01,$FC,$00,$3A,$00,$FF,$FF,$FF,$FF,$F8,$1F,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$C0,$1F,$80,$00,$00,$03,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$F0,$E0,$70,$38,$7F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$F8,$00,$00,$3A,$00,$1F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$F7,$77,$77,$77,$7F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$F8,$00,$00,$1F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$F8,$1F,$FF,$FF,$FB,$FF,$FF,$FF,$FF,$21,$03,$FF,$FF
  DEFB $00,$02,$00,$00,$00,$00,$00,$00,$00,$F7,$FF,$FF,$9F,$F2,$33,$F1
  DEFB $03,$FF,$22,$21,$FE,$47,$F8,$C1,$48,$1F,$FF,$03,$00,$22,$3F,$FF
  DEFB $00,$00,$00,$00,$00,$80,$00,$00,$00,$5F,$EF,$5E,$1E,$80,$00,$64
  DEFB $08,$4E,$FF,$FD,$00,$00,$2F,$F1,$7F,$FF,$FF,$E0,$00,$16,$09,$3F
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$23,$00,$02,$10,$80,$01,$00
  DEFB $64,$80,$80,$00,$11,$F4,$48,$12,$20,$00,$1F,$FF,$FC,$00,$03,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$00,$01,$FC,$00,$3A,$00,$FF,$FF,$FF,$FF,$FC,$3F,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$C0,$3E,$00,$00,$00,$03,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$F0,$E0,$70,$38,$7F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FC,$00,$00,$3A,$00,$3F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$F5,$55,$55,$55,$7F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FC,$00,$00,$3F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $61,$98,$66,$19,$86,$61,$98,$66,$19,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FC,$3F,$FF,$FF,$E1,$FF,$FF,$FF,$FE,$42,$09,$FF,$FF
  DEFB $02,$02,$00,$00,$00,$00,$00,$00,$00,$F7,$FF,$FF,$27,$E4,$13,$E6
  DEFB $11,$FE,$44,$41,$FC,$83,$F0,$01,$24,$8F,$FF,$00,$00,$21,$3F,$FF
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$7F,$F7,$7E,$1F,$80,$00,$FF
  DEFB $FF,$FA,$80,$07,$FF,$FF,$F8,$11,$60,$00,$00,$20,$00,$14,$09,$1F
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$3F,$FF,$FE,$10,$80,$00,$80
  DEFB $64,$80,$80,$00,$11,$D4,$48,$10,$20,$00,$08,$00,$04,$07,$FE,$10
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$00,$03,$FC,$00,$7D,$00,$FF,$FF,$FF,$FF,$FE,$7F,$FF,$FF,$FF
  DEFB $FF,$CE,$73,$9C,$E7,$1F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$C0,$F0,$00,$00,$00,$03,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$F0,$E0,$70,$38,$7F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FE,$00,$00,$7D,$00,$7F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$F0,$00,$00,$00,$7F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FE,$00,$00,$7F,$FF,$FF,$FF,$FF,$FF,$FF,$FD,$FF,$FF,$FF
  DEFB $40,$90,$24,$09,$02,$40,$90,$24,$09,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FE,$7F,$FF,$FF,$D3,$FF,$FF,$FF,$FC,$84,$05,$FF,$FF
  DEFB $02,$02,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FE,$27,$C8,$91,$C0
  DEFB $11,$FC,$88,$81,$F9,$13,$E0,$00,$9A,$8F,$FF,$00,$00,$10,$9F,$FF
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$08,$7F,$F7,$7E,$1F,$80,$01,$48
  DEFB $00,$0F,$F0,$00,$10,$00,$58,$12,$A0,$00,$00,$43,$FF,$FC,$05,$10
  DEFB $00,$00,$00,$00,$00,$00,$08,$00,$00,$3F,$FF,$FE,$1F,$FF,$FF,$C0
  DEFB $40,$80,$FF,$FC,$11,$D0,$48,$10,$20,$00,$04,$00,$07,$FC,$02,$10
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$3F,$FF,$FE,$1F,$F8,$80,$00
  DEFB $40,$80,$82,$07,$F1,$D0,$48,$10,$20,$00,$02,$00,$04,$21,$FF,$F0
  DEFB $00,$01,$09,$45,$21,$00,$00,$FF,$00,$15,$21,$07,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$F8,$00,$08,$10,$20,$04,$00,$3F,$C4,$01,$00,$10
  DEFB $00,$81,$29,$FF,$29,$1F,$FB,$0E,$DE,$08,$29,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$08,$5B,$6D,$B6,$FF,$FF,$FF,$DB,$6D,$B6
  DEFB $00,$00,$00,$00,$00,$1F,$7F,$FF,$EC,$00,$00,$00,$00,$00,$00,$20
  DEFB $C1,$00,$00,$01,$FD,$FF,$00,$00,$00,$00,$27,$DF,$FF,$C0,$00,$00
  DEFB $00,$00,$00,$00,$00,$01,$DF,$F8,$FC,$00,$00,$00,$00,$00,$00,$25
  DEFB $CF,$DD,$00,$E7,$E0,$FC,$00,$00,$00,$03,$FF,$DF,$BF,$C1,$80,$00
  DEFB $00,$00,$00,$00,$00,$00,$E7,$9E,$78,$00,$00,$00,$00,$00,$00,$20
  DEFB $FF,$00,$00,$FD,$FF,$FF,$F8,$00,$01,$CF,$E1,$FF,$F7,$EF,$FC,$00
  DEFB $00,$00,$00,$00,$00,$00,$C3,$18,$60,$00,$00,$00,$00,$00,$00,$22
  DEFB $42,$40,$00,$2F,$FF,$FF,$E4,$00,$07,$8F,$C0,$00,$00,$1F,$BE,$00
  DEFB $00,$3C,$00,$7E,$00,$00,$00,$00,$38,$00,$3E,$00,$36,$0C,$00,$00
  DEFB $00,$00,$00,$7D,$FE,$FB,$F0,$00,$3C,$7F,$00,$00,$0F,$EE,$FE,$00
  DEFB $00,$00,$00,$00,$00,$00,$03,$3C,$C0,$3F,$FF,$FE,$1F,$F0,$80,$00
  DEFB $40,$80,$82,$03,$01,$D0,$F8,$10,$20,$00,$01,$00,$06,$41,$00,$10
  DEFB $00,$01,$4F,$FF,$E5,$00,$00,$E7,$00,$1F,$E5,$07,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$F8,$00,$08,$10,$20,$04,$00,$FF,$E4,$01,$FF,$FF
  DEFB $00,$81,$2B,$AB,$A9,$1F,$FD,$0E,$DE,$0C,$29,$00,$00,$00,$00,$04
  DEFB $00,$20,$00,$00,$00,$00,$3F,$FF,$FF,$FF,$FE,$FF,$FF,$FF,$FF,$FF
  DEFB $00,$00,$00,$00,$00,$1F,$7F,$E1,$FE,$00,$00,$00,$00,$00,$00,$20
  DEFB $B6,$00,$00,$03,$FF,$FF,$00,$00,$00,$00,$27,$DE,$FF,$C0,$00,$00
  DEFB $00,$00,$00,$00,$00,$01,$DF,$F8,$FC,$00,$00,$00,$00,$00,$00,$25
  DEFB $CF,$DB,$00,$E7,$E1,$FF,$00,$00,$00,$06,$07,$EF,$DF,$E1,$F0,$00
  DEFB $00,$00,$00,$00,$00,$00,$E7,$9C,$70,$00,$00,$00,$00,$00,$00,$21
  DEFB $7E,$80,$00,$FB,$FF,$F0,$FC,$00,$01,$C7,$F0,$07,$FB,$07,$FE,$00
  DEFB $00,$00,$00,$00,$00,$00,$C3,$18,$60,$00,$00,$00,$00,$00,$00,$24
  DEFB $42,$20,$00,$2F,$FF,$BF,$F0,$00,$07,$0F,$80,$00,$00,$7F,$BE,$00
  DEFB $00,$42,$00,$63,$00,$00,$00,$00,$0C,$00,$63,$00,$3B,$18,$00,$00
  DEFB $00,$00,$00,$7B,$FE,$FB,$E0,$00,$4C,$FB,$00,$00,$1F,$EE,$FE,$00
  DEFB $00,$00,$00,$00,$00,$00,$06,$7E,$60,$3F,$FF,$FE,$1F,$80,$80,$00
  DEFB $40,$FF,$FE,$04,$81,$D0,$08,$10,$20,$00,$00,$80,$05,$41,$00,$10
  DEFB $20,$01,$48,$00,$25,$04,$40,$C3,$00,$08,$25,$05,$55,$4A,$AA,$AA
  DEFB $55,$55,$52,$AA,$A8,$00,$08,$10,$20,$04,$03,$FF,$F4,$01,$00,$10
  DEFB $00,$01,$2B,$FF,$A9,$1E,$FD,$0E,$DE,$04,$29,$00,$00,$00,$00,$04
  DEFB $18,$20,$00,$00,$48,$00,$2D,$B6,$DB,$6D,$FF,$7F,$FF,$B6,$DB,$6D
  DEFB $00,$00,$00,$00,$00,$1F,$7F,$F0,$FE,$00,$00,$00,$00,$00,$00,$20
  DEFB $D5,$3C,$00,$03,$FF,$0A,$3C,$00,$00,$00,$27,$DE,$FF,$C0,$00,$00
  DEFB $00,$00,$00,$00,$00,$01,$EF,$F8,$FA,$00,$00,$00,$00,$00,$00,$25
  DEFB $CF,$DF,$00,$F3,$F3,$FF,$C0,$00,$00,$3F,$17,$EF,$DF,$F8,$F0,$00
  DEFB $00,$00,$00,$00,$00,$00,$E7,$9C,$70,$00,$00,$00,$00,$00,$00,$21
  DEFB $3C,$80,$00,$FB,$FF,$E0,$3C,$00,$01,$FF,$F0,$03,$FC,$07,$FE,$00
  DEFB $00,$00,$00,$00,$00,$00,$C3,$1C,$70,$00,$00,$00,$00,$00,$00,$27
  DEFB $81,$E0,$00,$2F,$FF,$DF,$F8,$00,$07,$1F,$80,$00,$00,$7D,$BE,$00
  DEFB $00,$99,$00,$63,$3E,$76,$3E,$6E,$3E,$00,$60,$3E,$30,$7E,$76,$3D
  DEFB $6E,$3E,$00,$7B,$87,$7B,$C0,$00,$63,$FB,$00,$00,$3F,$ED,$FE,$00
  DEFB $00,$07,$FE,$00,$FF,$C0,$0C,$FF,$30,$10,$FF,$C2,$10,$80,$80,$00
  DEFB $40,$80,$80,$00,$00,$00,$08,$10,$20,$00,$00,$40,$05,$01,$00,$10
  DEFB $20,$01,$4F,$FF,$E5,$04,$63,$FF,$FE,$0F,$E5,$07,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$F8,$00,$0F,$F0,$20,$07,$FF,$FF,$FC,$01,$00,$10
  DEFB $00,$01,$0A,$AA,$A1,$0C,$FE,$0E,$5C,$04,$21,$00,$00,$00,$00,$26
  DEFB $2C,$60,$00,$00,$6C,$00,$3F,$FF,$FF,$FF,$AF,$7F,$FF,$FF,$FF,$FF
  DEFB $00,$00,$00,$00,$00,$1E,$FF,$F0,$FE,$00,$00,$00,$00,$00,$00,$20
  DEFB $C1,$6E,$00,$07,$FF,$C0,$0E,$00,$00,$00,$27,$DE,$FF,$C0,$00,$00
  DEFB $00,$00,$00,$00,$00,$01,$EF,$FF,$F6,$00,$00,$00,$00,$00,$00,$2D
  DEFB $CF,$6E,$00,$F3,$F7,$00,$E0,$00,$00,$79,$17,$EF,$DF,$FC,$F8,$00
  DEFB $00,$00,$00,$00,$00,$00,$E7,$9C,$70,$00,$00,$00,$00,$00,$00,$21
  DEFB $3C,$80,$00,$77,$FF,$F0,$1C,$00,$01,$FF,$F0,$01,$FC,$0F,$DF,$00
  DEFB $00,$00,$00,$00,$00,$00,$C3,$3C,$F0,$00,$00,$00,$00,$00,$00,$25
  DEFB $81,$60,$00,$1F,$FF,$EF,$F8,$00,$0F,$3F,$80,$00,$00,$7B,$BE,$00
  DEFB $00,$A1,$00,$7E,$63,$33,$63,$73,$67,$00,$3E,$63,$30,$30,$63,$67
  DEFB $73,$63,$00,$7B,$00,$7B,$A0,$00,$D0,$FB,$00,$00,$3F,$DB,$FE,$00
  DEFB $00,$04,$02,$00,$80,$40,$0F,$FF,$F0,$10,$80,$43,$F0,$80,$FF,$FF
  DEFB $C0,$80,$80,$00,$00,$00,$08,$10,$20,$00,$00,$20,$04,$C1,$00,$10
  DEFB $20,$01,$08,$00,$21,$0F,$E7,$FF,$DE,$08,$21,$07,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FF,$F8,$00,$08,$00,$20,$04,$0F,$FF,$FC,$01,$00,$10
  DEFB $00,$01,$0B,$FF,$A1,$0D,$FF,$0E,$7C,$04,$21,$00,$00,$00,$00,$27
  DEFB $5E,$E0,$00,$00,$7C,$00,$24,$92,$49,$24,$E7,$BF,$FF,$92,$49,$24
  DEFB $00,$00,$00,$00,$00,$0E,$FF,$FF,$FE,$00,$00,$00,$00,$00,$00,$23
  DEFB $5D,$6E,$00,$07,$F7,$F0,$E0,$00,$00,$00,$27,$DE,$FF,$C0,$00,$00
  DEFB $00,$00,$00,$00,$00,$01,$EF,$F8,$F7,$00,$00,$00,$00,$00,$00,$7F
  DEFB $CF,$6E,$00,$FB,$FE,$FF,$70,$00,$00,$FC,$C7,$EF,$EF,$FC,$F8,$00
  DEFB $00,$00,$00,$00,$00,$00,$E3,$98,$60,$00,$00,$00,$00,$00,$00,$21
  DEFB $24,$80,$00,$77,$FF,$FC,$1C,$00,$01,$CF,$F8,$00,$00,$0F,$DE,$00
  DEFB $00,$00,$00,$00,$00,$00,$E3,$B8,$E0,$00,$00,$00,$00,$00,$00,$25
  DEFB $00,$A0,$00,$3F,$FF,$EF,$F8,$00,$0E,$3F,$80,$00,$00,$FB,$7E,$00
  DEFB $00,$A1,$00,$63,$7F,$1B,$63,$63,$63,$00,$03,$63,$7C,$30,$6B,$63
  DEFB $63,$7F,$00,$FB,$03,$7D,$60,$01,$EC,$FB,$00,$00,$FF,$DB,$FE,$00
  DEFB $00,$07,$FE,$00,$FF,$C0,$07,$FF,$E0,$10,$FF,$C2,$00,$80,$80,$08
  DEFB $00,$80,$80,$00,$00,$00,$08,$10,$3F,$FF,$FF,$E0,$04,$01,$00,$1F
  DEFB $20,$01,$08,$00,$21,$0F,$F7,$FF,$DE,$08,$21,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$08,$00,$20,$04,$1F,$FF,$FE,$01,$00,$10
  DEFB $00,$01,$0A,$AA,$A1,$0D,$FF,$8E,$B8,$04,$21,$00,$00,$00,$00,$23
  DEFB $DF,$C0,$00,$00,$7E,$00,$24,$92,$49,$24,$B7,$BF,$FF,$D2,$49,$24
  DEFB $00,$00,$00,$00,$00,$01,$FF,$F8,$FE,$00,$00,$00,$00,$00,$00,$25
  DEFB $E3,$DF,$00,$07,$C0,$7C,$7C,$00,$00,$00,$27,$DE,$FF,$C0,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$F7,$F0,$F7,$00,$00,$00,$00,$00,$00,$53
  DEFB $FF,$3C,$00,$FD,$FD,$FF,$F0,$00,$01,$E6,$E7,$F7,$F7,$FC,$FC,$00
  DEFB $00,$00,$00,$00,$00,$00,$E3,$98,$60,$00,$00,$00,$00,$00,$00,$22
  DEFB $24,$40,$00,$77,$FF,$FE,$0C,$00,$03,$C7,$F0,$00,$00,$0F,$DE,$00
  DEFB $00,$00,$00,$00,$00,$01,$E7,$B8,$E0,$00,$00,$00,$00,$00,$00,$2B
  DEFB $00,$B0,$00,$3F,$FB,$F6,$F8,$00,$0E,$3F,$00,$00,$01,$F7,$7E,$00
  DEFB $00,$99,$00,$63,$60,$0E,$63,$66,$63,$00,$63,$63,$30,$32,$3E,$67
  DEFB $7E,$60,$00,$FD,$9E,$FC,$F0,$03,$B7,$FB,$00,$00,$FF,$DB,$FE,$00
  DEFB $00,$02,$04,$00,$40,$80,$00,$99,$00,$10,$40,$82,$3F,$FF,$FF,$FF
  DEFB $FF,$FF,$FF,$FE,$00,$00,$08,$10,$20,$04,$00,$00,$04,$01,$00,$10
  DEFB $00,$81,$08,$00,$21,$0F,$FF,$FF,$DE,$08,$21,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$08,$00,$20,$04,$3F,$FF,$FF,$01,$00,$10
  DEFB $00,$01,$0B,$FF,$A1,$0F,$BF,$FF,$B8,$06,$21,$00,$00,$00,$00,$23
  DEFB $9F,$C0,$00,$00,$FF,$87,$3F,$FF,$FF,$FF,$B7,$BF,$FF,$FF,$FF,$FF
  DEFB $00,$00,$00,$00,$00,$01,$FF,$FF,$FE,$00,$00,$00,$00,$00,$00,$2B
  DEFB $BE,$DB,$00,$07,$C0,$1C,$1F,$00,$00,$00,$17,$DF,$7F,$C0,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$F7,$FF,$F1,$00,$00,$00,$00,$00,$00,$5E
  DEFB $81,$00,$00,$FD,$FF,$FF,$F8,$00,$01,$F3,$E7,$F7,$F7,$FC,$FC,$00
  DEFB $00,$00,$00,$00,$00,$00,$C3,$18,$60,$00,$00,$00,$00,$00,$00,$22
  DEFB $24,$40,$00,$37,$FF,$FF,$84,$00,$03,$C7,$F0,$00,$00,$0F,$DE,$00
  DEFB $00,$00,$00,$00,$00,$01,$C7,$00,$00,$00,$00,$00,$00,$00,$00,$37
  DEFB $00,$B8,$00,$3E,$FD,$F6,$F8,$00,$1E,$7F,$00,$00,$03,$F7,$7E,$00
  DEFB $00,$42,$00,$7E,$3F,$4C,$3E,$6F,$3E,$00,$3E,$3E,$30,$1C,$14,$3B
  DEFB $63,$3F,$00,$FE,$7E,$FE,$F8,$07,$3A,$F3,$00,$07,$FF,$B7,$FE,$00
  DEFB $00,$03,$FF,$7D,$FF,$80,$00,$FF,$00,$1D,$FF,$82,$3F,$EA,$BF,$FF
  DEFB $55,$FF,$FA,$AE,$00,$00,$08,$10,$20,$04,$00,$00,$04,$01,$00,$10
  DEFB $00,$81,$08,$FE,$21,$1F,$FF,$FF,$DE,$08,$21,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$08,$7F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $00,$01,$0A,$AA,$A1,$0F,$BF,$E1,$D4,$02,$21,$00,$00,$00,$00,$20
  DEFB $9F,$00,$00,$00,$F5,$FD,$3F,$FF,$FF,$FF,$F7,$BF,$FF,$FF,$FF,$FF
  DEFB $00,$00,$00,$00,$00,$01,$FF,$F8,$FE,$00,$00,$00,$00,$00,$00,$2F
  DEFB $DD,$DD,$00,$47,$C0,$60,$00,$00,$00,$00,$0F,$DF,$7F,$C0,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$F7,$DE,$F8,$00,$00,$00,$00,$00,$00,$7C
  DEFB $FF,$00,$00,$FD,$FF,$FF,$F8,$00,$01,$DB,$E3,$F7,$F7,$FC,$FC,$00
  DEFB $00,$00,$00,$00,$00,$00,$C3,$18,$60,$00,$00,$00,$00,$00,$00,$22
  DEFB $42,$40,$00,$2F,$FF,$FF,$C4,$00,$03,$8F,$E0,$00,$00,$1F,$DE,$00
  DEFB $00,$00,$00,$00,$00,$01,$C7,$00,$00,$00,$00,$00,$00,$00,$00,$7F
  DEFB $00,$FE,$00,$7D,$FE,$F5,$F0,$00,$3C,$7F,$00,$00,$07,$EE,$FE,$00
  DEFB $00,$3C,$00,$00,$00,$38,$00,$00,$00,$00,$00,$00,$60,$00,$00,$00
  DEFB $00,$00,$00,$AA,$FE,$AA,$A8,$0E,$11,$E2,$00,$1F,$FF,$77,$FE,$00
  DEFB $79,$61,$61,$61,$61,$61,$61,$61,$61,$61,$61,$61,$61,$61,$61,$61
  DEFB $61,$61,$61,$61,$61,$61,$61,$61,$61,$61,$61,$61,$61,$61,$61,$61
  DEFB $61,$61,$61,$61,$61,$61,$61,$61,$61,$61,$61,$61,$61,$61,$61,$61
  DEFB $61,$61,$61,$61,$61,$61,$61,$61,$61,$61,$61,$61,$61,$61,$61,$79
  DEFB $79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79
  DEFB $79,$79,$79,$79,$79,$79,$79,$79,$79,$59,$59,$59,$59,$59,$59,$79
  DEFB $79,$71,$71,$71,$71,$71,$71,$71,$71,$71,$71,$71,$71,$71,$71,$71
  DEFB $71,$71,$71,$71,$71,$71,$79,$79,$79,$59,$59,$59,$5D,$5D,$59,$79
  DEFB $79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79
  DEFB $79,$79,$79,$79,$79,$79,$79,$79,$79,$59,$5E,$5E,$5D,$5D,$59,$79
  DEFB $49,$61,$61,$61,$61,$61,$61,$61,$59,$59,$61,$61,$61,$61,$61,$61
  DEFB $61,$61,$61,$61,$61,$61,$69,$69,$79,$59,$5E,$5E,$5D,$5D,$59,$79
  DEFB $49,$69,$69,$69,$69,$69,$69,$69,$69,$69,$69,$69,$69,$69,$69,$69
  DEFB $69,$51,$51,$51,$51,$51,$51,$79,$79,$59,$59,$59,$59,$59,$59,$79
  DEFB $49,$69,$69,$69,$69,$69,$69,$69,$69,$69,$69,$69,$69,$69,$69,$69
  DEFB $69,$51,$54,$54,$51,$51,$51,$79,$79,$59,$59,$59,$59,$59,$59,$79
  DEFB $49,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79
  DEFB $79,$51,$54,$54,$51,$56,$51,$79,$79,$59,$59,$59,$59,$59,$59,$79
  DEFB $79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79
  DEFB $79,$51,$54,$54,$51,$56,$51,$79,$79,$79,$79,$79,$79,$79,$79,$79
  DEFB $79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79
  DEFB $79,$51,$51,$51,$56,$51,$51,$79,$79,$79,$79,$79,$79,$79,$79,$79
  DEFB $79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79
  DEFB $79,$51,$51,$51,$56,$51,$51,$79,$79,$79,$79,$79,$79,$79,$79,$79
  DEFB $79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79
  DEFB $79,$51,$51,$51,$51,$51,$51,$79,$79,$79,$79,$79,$79,$79,$79,$79
  DEFB $79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79
  DEFB $79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79
  DEFB $79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79
  DEFB $79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79
  DEFB $79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79
  DEFB $79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79
  DEFB $79,$79,$79,$79,$79,$79,$78,$78,$78,$79,$79,$79,$79,$79,$79,$79
  DEFB $79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$79
  DEFB $79,$79,$79,$79,$79,$78,$78,$30,$7A,$79,$79,$79,$79,$79,$79,$79
  DEFB $79,$79,$79,$79,$79,$79,$79,$79,$79,$79,$7A,$7A,$7A,$79,$79,$79
  DEFB $79,$79,$79,$79,$79,$78,$78,$60,$7A,$79,$79,$79,$79,$79,$79,$78
  DEFB $7A,$78,$79,$79,$7A,$7A,$79,$79,$79,$79,$6A,$6A,$7A,$79,$79,$79
  DEFB $79,$79,$79,$79,$79,$78,$78,$58,$78,$79,$79,$79,$79,$79,$79,$79
  DEFB $79,$7B,$79,$7A,$7A,$7A,$7E,$79,$79,$79,$7A,$6A,$6A,$7A,$79,$79
  DEFB $79,$79,$79,$79,$79,$78,$78,$68,$78,$79,$79,$79,$79,$79,$79,$79
  DEFB $72,$7B,$79,$7A,$7A,$7A,$7A,$79,$79,$79,$6A,$6A,$6A,$5A,$7B,$79
  DEFB $79,$79,$79,$79,$79,$79,$78,$78,$78,$79,$79,$79,$79,$79,$79,$78
  DEFB $7C,$78,$79,$7A,$7A,$7A,$7A,$79,$79,$69,$69,$6A,$6A,$6B,$6B,$79
  DEFB $79,$79,$79,$79,$79,$78,$78,$78,$78,$79,$79,$79,$79,$79,$79,$7A
  DEFB $78,$7A,$79,$7A,$7A,$7A,$7A,$79,$79,$69,$69,$6A,$6B,$6B,$6B,$79
  DEFB $79,$7A,$7A,$7A,$7A,$7A,$7A,$7A,$7A,$7A,$7A,$7A,$7A,$7A,$7A,$7A
  DEFB $7A,$7A,$79,$7A,$7A,$7A,$7A,$79,$69,$69,$69,$6B,$6B,$6B,$6B,$79

WorkSpaceArea:
  DEFS $04

Loader:
  LD HL,StackPointer      ; Top of STACK
  LD SP,HL
; tape loader removed - this loaded Block #6 from the tape to 5CB0
  NOP                     ; ROM LD-BYTES; Start of the block (5CB0)
  NOP                     ;
  NOP                     ;
  NOP                     ;
  NOP                     ; ROM LD-BYTES; Length of the block (A34F)
  NOP                     ;
  NOP                     ;
  NOP                     ; ROM LD-BYTES; Block type Flag (data block)
  NOP                     ;
  NOP                     ; ROM LD-BYTES; Set carry flag for LOAD
  NOP                     ; ROM LD-BYTES; call tape loading routine
  NOP                     ;
  NOP                     ;

; Start the game!
L5B15:
  JP StartGame

L5B18:
  DEFS $08

PrintBuffer:
  DEFS $60

FreeTable:
  DEFS $80

L5C00:
  DEFS $02

L5C02:
  DEFS $06

LASTK:
  DEFB $00

L5C09:
  DEFS $2C

StackPointer:
  DEFS $01

; Address to the character graphics
CHARS:
  DEFW $0000

L5C38:
  DEFS $40

; Related to the random numberish routine
L5C78:
  DEFW $0002

L5C7A:
  DEFB $00,$58,$FF,$00,$00,$21,$00,$5B
  DEFB $21,$17,$80,$40,$E0,$50,$21,$14
  DEFB $21,$17,$03,$38,$00,$38,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00

; Word Token Dictionary
;
; Tokens are stored using 5-bit bytes compressed together. For a full list of
; all tokens see: https://www.icemark.com/dataformats/midnight/index.html
TokenDictionary:
  DEFB $84,$A2,$92,$D8,$A3,$E8,$C9,$C4,$CC,$61,$EF,$B5,$D2,$DE,$73,$A7
  DEFB $25,$29,$DF,$3D,$87,$3D,$99,$1A,$5A,$4F,$AE,$44,$51,$61,$6F,$D2
  DEFB $42,$4A,$20,$E6,$96,$24,$89,$A9,$47,$86,$65,$48,$09,$14,$15,$F2
  DEFB $5E,$43,$A4,$4C,$18,$92,$44,$F6,$C9,$13,$28,$4A,$75,$A2,$13,$64
  DEFB $58,$A7,$1E,$F9,$A4,$23,$EB,$C9,$43,$DF,$6B,$EF,$98,$77,$64,$6A
  DEFB $87,$3C,$22,$C3,$4A,$E7,$C9,$23,$03,$45,$C9,$06,$56,$28,$7A,$F2
  DEFB $8C,$27,$1F,$45,$28,$4C,$94,$5A,$90,$27,$51,$24,$13,$43,$13,$05
  DEFB $F2,$EE,$34,$82,$BD,$47,$0E,$45,$32,$30,$86,$E8,$93,$4B,$16,$57
  DEFB $4E,$90,$04,$B5,$44,$51,$90,$A7,$B4,$F7,$1C,$4A,$B3,$C8,$40,$51
  DEFB $9A,$28,$B5,$22,$13,$3B,$8F,$C8,$20,$57,$4A,$13,$B5,$C0,$42,$36
  DEFB $42,$26,$8A,$D0,$4C,$AC,$B8,$51,$4E,$61,$C5,$25,$76,$E4,$93,$81
  DEFB $22,$D4,$9E,$74,$C9,$9D,$44,$51,$6A,$32,$50,$84,$C6,$93,$85,$85
  DEFB $9C,$64,$A0,$48,$3E,$E9,$10,$7B,$F2,$C8,$D4,$08,$7B,$12,$99,$40
  DEFB $64,$A0,$C8,$10,$F9,$9E,$33,$47,$06,$79,$0E,$91,$25,$B4,$89,$12
  DEFB $45,$F2,$49,$97,$2E,$4A,$13,$16,$39,$15,$0E,$EA,$C9,$95,$28,$3A
  DEFB $A8,$C8,$40,$91,$59,$B5,$05,$99,$5A,$90,$61,$25,$8A,$0A,$0D,$F2
  DEFB $98,$4A,$83,$3C,$28,$50,$F4,$64,$62,$88,$C8,$72,$64,$6A,$85,$84
  DEFB $EB,$0C,$95,$4F,$BA,$32,$DE,$6B,$E3,$99,$D4,$5E,$75,$34,$24,$87
  DEFB $46,$A2,$81,$14,$76,$CC,$93,$65,$52,$83,$8A,$3B,$C5,$D0,$77,$8B
  DEFB $44,$36,$31,$16,$4E,$29,$E4,$5D,$57,$56,$29,$30,$4D,$F7,$2E,$0A
  DEFB $8C,$15,$16,$56,$31,$37,$4C,$5A,$8A,$AC,$C9,$15,$96,$28,$3A,$23
  DEFB $D8,$22,$5D,$09,$B2,$65,$03,$59,$48,$EE,$18,$F9,$74,$71,$87,$BC
  DEFB $16,$92,$13,$61,$24,$37,$50,$31,$93,$06,$47,$8C,$7B,$92,$22,$33
  DEFB $5F,$A5,$A8,$94,$30,$69,$B9,$65,$52,$C4,$DE,$5B,$C9,$9D,$41,$DF
  DEFB $08,$74,$3C,$77,$44,$99,$89,$94,$C2,$CA,$9C,$85,$A2,$E0,$0A,$7A
  DEFB $55,$92,$E7,$0A,$A1,$F7,$19,$8A,$64,$29,$C5,$BC,$2A,$8B,$49,$B6
  DEFB $90,$99,$B0,$99,$C5,$16,$67,$4A,$3A,$88,$16,$97,$5C,$21,$B4,$B8
  DEFB $23,$4B,$0B,$C9,$11,$12,$F2,$48,$74,$A4,$69,$5C,$3A,$88,$1A,$56
  DEFB $F1,$93,$A7,$3D,$B9,$92,$43,$E3,$49,$56,$28,$4A,$F2,$49,$8A,$E4
  DEFB $73,$C8,$84,$BB,$64,$72,$C9,$04,$69,$58,$68,$05,$AD,$27,$93,$2B
  DEFB $AC,$B0,$27,$09,$31,$25,$97,$9B,$66,$49,$73,$55,$B6,$64,$72,$87
  DEFB $C8,$70,$9E,$5B,$ED,$3D,$07,$65,$72,$A3,$18,$28,$CB,$9C,$67,$A0
  DEFB $F7,$66,$21,$AB,$E4,$32,$83,$2D,$E7,$51,$54,$E4,$2C,$27,$B4,$62
  DEFB $26,$0D,$92,$16,$1A,$60,$21,$C1,$11,$53,$1C,$2D,$D2,$88,$92,$DC
  DEFB $21,$28,$CC,$22,$4A,$71,$83,$3C,$92,$5F,$2D,$37,$38,$7A,$6C,$91
  DEFB $C9,$64,$72,$C3,$5C,$B3,$8E,$51,$E6,$34,$95,$A5,$F1,$1C,$4D,$AE
  DEFB $96,$63,$42,$62,$85,$98,$70,$42,$72,$23,$38,$F2,$18,$21,$54,$66
  DEFB $92,$DC,$31,$E8,$C9,$59,$CA,$7D,$CC,$90,$34,$8A,$A1,$F2,$31,$56
  DEFB $6E,$62,$C4,$9C,$1A,$24,$29,$46,$96,$52,$48,$90,$2B,$B5,$44,$5C
  DEFB $3A,$88,$A2,$5B,$D8,$78,$AD,$14,$16,$1C,$29,$AD,$4E,$6A,$4C,$92
  DEFB $93,$22,$51,$E8,$2D,$C5,$11,$57,$EE,$78,$B2,$98,$12,$64,$61,$2F
  DEFB $90,$63,$02,$63,$C5,$15,$F3,$2A,$3B,$41,$C8,$17,$08,$09,$B2,$18
  DEFB $F3,$AA,$23,$C8,$3D,$8A,$92,$3B,$67,$96,$20,$07,$2A,$2D,$B8,$7C
  DEFB $0A,$2B,$B6,$B8,$43,$6F,$61,$B6,$14,$8A,$92,$24,$E6,$49,$62,$92
  DEFB $29,$B4,$14,$77,$E8,$2D,$8E,$66,$84,$AA,$23,$B2,$90,$44,$D1,$AB
  DEFB $33,$38,$32,$DC,$2B,$28,$D8,$52,$60,$98,$93,$DC,$20,$D3,$7C,$6C
  DEFB $D2,$34,$8A,$11,$E5,$04,$67,$66,$72,$A3,$1C,$11,$28,$65,$C5,$C8
  DEFB $44,$8A,$44,$37,$48,$99,$9E,$34,$81,$3D,$57,$CA,$64,$E5,$9A,$E2
  DEFB $4A,$CB,$87,$A2,$E4,$D6,$44,$36,$0D,$FA,$64,$2E,$B7,$38,$5A,$DC
  DEFB $73,$85,$B4,$E2,$88,$A8,$94,$A0,$34,$49,$60,$0C,$55,$4A,$8B,$64
  DEFB $B9,$D8,$22,$73,$9A,$2C,$1D,$44,$59,$36,$B1,$26,$5A,$0C,$4D,$B2
  DEFB $10,$96,$9C,$4D,$E7,$C9,$40,$0B,$41,$E3,$B5,$16,$1C,$39,$23,$38
  DEFB $F7,$68,$3A,$35,$91,$E0,$46,$31,$F6,$A5,$51,$CC,$08,$8C,$4D,$34
  DEFB $51,$61,$B4,$48,$25,$8B,$91,$65,$A2,$42,$CC,$45,$69,$20,$43,$64
  DEFB $48,$AE,$98,$C4,$D8,$B1,$E9,$BC,$2A,$0B,$4B,$A6,$94,$9B,$28,$2A
  DEFB $28,$38,$72,$84,$4C,$EE,$4C,$33,$EF,$93,$E4,$4C,$16,$72,$91,$E7
  DEFB $06,$5A,$E4,$24,$A3,$42,$33,$E4,$BB,$0E,$91,$32,$A9,$7C,$D9,$B0
  DEFB $12,$C8,$24,$23,$B8,$82,$12,$29,$07,$25,$42,$8A,$2B,$B3,$94,$75
  DEFB $56,$62,$AC,$90,$13,$8C,$0C,$89,$14,$F1,$18,$29,$E3,$31,$52,$5A
  DEFB $62,$04,$C9,$32,$64,$4D,$D4,$98,$74,$10,$3D,$F7,$31,$5B,$26,$41
  DEFB $A9,$15,$99,$DC,$01

StartGame:
  CALL Initialise
  JP MainGameLoop

ForceLoad:
  JP LoadGame

Select:
  CALL DisplayPressAKey
  LD HL,Initialise1       ; Push FD21 to stack, which is just before the
  PUSH HL                 ; CharKeysTable: FD22 - 1 byte.
  XOR A
Select_0:
  LD (TempCharacterNo),A
  CALL CopyCharDetails
  POP HL                  ; Pop what should still be FD21, then INC, and push
  INC HL                  ; FD22 (CharKeysTable) to stack.
  PUSH HL                 ;
  LD A,(CharAvailable)
  CP $01                  ; Can We Select?
  JR NZ,Select_2          ; No
  CALL HashToBuffer
  LD A,(HL)
  CP $61
  JR C,Select_1
  SUB $20                 ; Make Uppercase
Select_1:
  CALL AddLiteralToBuffer
  CALL FirstNameToBuffer
  CALL SetTokenToLowerCase
  CALL FlushPrintBuffer
  LD A,(ViewPoint_Row)
  CP $12
  JR NZ,Select_2
  CALL DefineViewPoint
  DEFB $10,$02,$10,$1F,$3A,$00
Select_2:
  LD A,(TempCharacterNo)
  INC A
  CP $20
  JR NZ,Select_0
  CALL SelectCharacter
  POP HL
  LD A,(TempCharacterNo)
  LD (SaveCurChar),A
  JP MainGameLoop

LocationForLoadedData:
  LD A,$FF                ; ROM LD-BYTES; Block type Flag (data block)
  LD IX,GameDays          ; ROM LD-BYTES; Start of the block
  LD DE,$1892             ; ROM LD-BYTES; Length of the block
  RET

ResetLASTK:
  XOR A
  LD (LASTK),A
  RET

ClrScrDoMessage:
  PUSH HL
  CALL ClearAllScreen
  POP HL
  CALL FillPrintBuffer
  JP FlushPrintBuffer

ReduceHealthAfterMovement:
  LD A,(HL)
  SUB B
  JR NC,ReduceHealthAfterMovement_0
  XOR A                   ; If less than Zero...Make Zero
ReduceHealthAfterMovement_0:
  LD (HL),A
  RET

; Save a game to tape.
SaveGame:
  LD HL,LoadSaveMessages  ; Start tape and press enter
  CALL ClrScrDoMessage
SaveGame_0:
  CALL CheckKeyCase
  CP $0D
  JR NZ,SaveGame_0
  CALL ClearAllScreen
  CALL LocationForLoadedData
  CALL $04C2
SaveGame_1:
  LD HL,LoadSaveMessages+$000C ; Verifying saved game
  CALL ClrScrDoMessage
  SCF
  CCF                     ; ROM LD-BYTES; Unset carry flag for VERIFY
  CALL SaveGame_3
  JP C,MainGameLoop
  LD HL,LoadSaveMessages+$0014 ; Verification failed
  CALL ClrScrDoMessage
  CALL ResetLASTK
SaveGame_2:
  CALL CheckKeyCase       ; Check to see they want to try again(?)
  CP $67                  ; 'g' (K_Yes)
  JR Z,SaveGame_1
  CP $6A                  ; 'j' (K_No)
  JP Z,MainGameLoop
  JR SaveGame_2
SaveGame_3:
  CALL LocationForLoadedData
  CALL $0556              ; ROM LD-BYTES; call tape loading routine
  RET

; Ask player is they want to load an old game.
LoadOldGameQuery:
  LD HL,LoadSaveMessages+$0025 ; Do you want to load an old game?
  CALL ClrScrDoMessage
  CALL ResetLASTK
LoadOldGameQuery_0:
  CALL CheckKeyCase
  CP $67                  ; 'g' (K_Yes)
  JR Z,LoadGame
  CP $6A                  ; 'j' (K_No)
  JP Z,MainGameLoop
  JR LoadOldGameQuery_0

; Load a game from tape
LoadGame:
  CALL ClearAllScreen
  SCF                     ; ROM LD-BYTES; Set carry flag for LOAD
  CALL SaveGame_3
  JP C,MainGameLoop
  LD HL,LoadSaveMessages+$0031 ; Loading failed!
  CALL ClrScrDoMessage
  CALL ResetLASTK
LoadGame_0:
  CALL CheckKeyCase
  CP $64                  ; 'd' (K_Load)
  JR Z,LoadGame
  JR LoadGame_0

ClearAllScreen:
  CALL DoWindowOne
  CALL DefineViewPoint
  DEFB $00,$05,$00,$1F,$3A,$00
  RET

; Messages for loading and saving games.
LoadSaveMessages:
  DEFB $FC,$5C,$82,$84,$85,$86,$87,$7F ; 'To Save Game Start Tape And Press'
  DEFB $88,$FE,$2E,$FF    ; 'Enter.'
  DEFB $FC,$8F,$FD,$98,$84,$FE,$2E,$FF ; 'Verifying Game.'
  DEFB $FC,$8F,$FD,$98,$93,$FE,$21,$FC ; 'Verifying Failed!'
  DEFB $8C,$8D,$8E,$5C,$8F,$94,$FE,$3F ; 'Do You Want To Verify Again?'
  DEFB $FF
  DEFB $FC,$8C,$8D,$8E,$5C,$AA,$95,$96 ; 'Do You Want To Load An Old Game?'
  DEFB $84,$FE,$3F,$FF
  DEFB $FC,$AA,$FD,$98,$93,$FE,$21 ; 'Loading Failed!'
  DEFB $FC,$7F,$96,$84,$5C,$97,$94,$FE ; 'Press Old Game To Try Again.'
  DEFB $2E,$FF

CheckGameKeys:
  CALL CheckKeyCase
  CP $71                  ; 'q'
  JP Z,MoveForward
  CP $65                  ; 'e'
  JP Z,MainGameLoop
  CP $72                  ; 'r'
  JP Z,Think
  CP $74                  ; 't'
  JP Z,Choose
  CP $75                  ; 'u'
  JR Z,Night
  CP $73                  ; 's'
  JP Z,SaveGame
  CP $64                  ; 'd'
  JP Z,LoadOldGameQuery
  CP $7A                  ; 'z'
  JR NZ,CheckGameKeys_0
  CALL CopyScreen
  CALL ResetLASTK
  JR CheckGameKeys
CheckGameKeys_0:
  CP $6D                  ; 'm'
  JP Z,Select
  CP $63                  ; 'c'
  JR Z,ChooseLuxor
  CP $76                  ; 'v'
  JR Z,ChooseMorkin
  CP $62                  ; 'b'
  JR Z,ChooseCorleth
  CP $6E                  ; 'n'
  JR Z,ChooseRorthron
  LD A,(KeyReturnStatus)
  CP $01
  JP Z,PollDirectionKeys
  CP $03
  JP Z,PollTableOfKeys
  JP CheckGameKeys
ChooseLuxor:
  XOR A
  JR SaveChoice
ChooseMorkin:
  LD A,$01
  JR SaveChoice
ChooseCorleth:
  LD A,$02
  JR SaveChoice
ChooseRorthron:
  LD A,$03
SaveChoice:
  LD (SaveCurChar),A
  JP MainGameLoop

; End of day, the player turn is over.
Night:
  CALL CheckSpecialConditions
  CALL Bytes_Print_Buffer
  DEFB $FC,$71,$8A,$AB,$87,$00 ; 'Night Has Fallen And The'
  DEFB $FC,$AC,$AE,$AD    ; 'Foul Are Abroad'
  DEFB $FE,$21,$FC,$FF    ; '.'
  LD HL,(GameDays)
  INC HL
  LD (GameDays),HL
  CALL NumberToString
  LD A,$6E                ; 'Day'
  CALL PluralToken
  CALL HaveOrHas
  LD HL,GameMessagesSinceWarBegan
  CALL FillPrintBuffer
  CALL FlushPrintBuffer
  CALL CalcDoomDarksCitadels
  CALL CalcNightActivity
  LD A,$04
  LD (Print_Attr),A
  CALL Bytes_Print_Buffer
  DEFB $FB,$FC,$8C,$8D,$8E,$3D ; 'Do You Want Dawn'
  DEFB $FE,$3F,$FF        ; '?'
  CALL FlushPrintBuffer
Night_0:
  CALL CheckKeyCase
  CP $67                  ; 'g' (K_Yes)
  JR NZ,Night_0
  JP MainGameLoop

; Message for days passed since war began
GameMessagesSinceWarBegan:
  DEFB $BE,$FE,$65,$FE,$64,$C2,$00 ; 'Passed Since The'
  DEFB $FC,$BF,$40,$00    ; 'War Of The'
  DEFB $FC,$C0,$C1,$FE,$2E,$FF ; 'Solstice Began.'

; Main Game Loop
MainGameLoop:
  CALL GetLatestCharInfo
  LD A,(CharLifeStatus)
  CP $00                  ; Is the character still alive?
  JP Z,Think              ; Can't carry on if not!
  CALL DrawMainScreen
  CALL PrintWhoEversInFront
  CALL GetLatestCharInfo
  LD A,$01
  LD (KeyReturnStatus),A
  LD (LASTK),A
PollDirectionKeys:
  CALL CheckKeyCase
  CP $31                  ; '1'
  JP M,CheckGameKeys
  CP $39                  ; '9'
  JP P,CheckGameKeys
  SUB $31                 ; Make keypress into direction
  LD B,A
  LD A,(CurrentlyLooking)
  CP B                    ; Are we already looking that way?
  JP Z,PollDirectionKeys  ; Yes
  LD A,B
SaveDir:
  LD (CharLookDirection),A ; Change View
  CALL SaveCharDetails
  JP MainGameLoop

MoveForward:
  CALL GetLatestCharInfo
  LD A,(CharLifeStatus)
  CP $00
  JP Z,Think
  LD A,(CanCharMoveForward)
  CP $00                  ; Are there any reasons that shouldn't move?
  JP NZ,Think
  LD A,(CharEnergyStatus)
  CP $00                  ; Any Energy left?
  JP Z,Think
  LD A,(CharTimeOfDay)
  CP $00                  ; Is it Night?
  JP Z,Think
  CP $10                  ; Is It Dawn
  JR Z,MoveForward_0
  LD A,(DoomDarksArmyPosInTable)
  CP $00                  ; Any of DoomDarks Army Here?
  JP NZ,Think
MoveForward_0:
  LD A,(CharHideFlag)
  CP $00                  ; Are we Hidden?
  JP NZ,Choose
  LD A,(LocationObject)
  CP $00                  ; Anything in this location?
  JR Z,WalkForward        ; Horses are exceptable
  CP $05
  JP C,Choose             ; Between 1-5, we must fight so we can't Move

WalkForward:
  LD HL,(LocationToMoveTo)
  LD (CharLocation),HL
  CALL SaveCharDetails    ; Re-Write info
  CALL SetResetCharsArmy
  LD HL,(LocationToMoveTo)
  LD (CurrentLocationY),HL
  CALL SetResetCharsArmy
  CALL UpdateCharsVars
  LD B,$02                ; Process Char energy drains!
  LD A,(CurrentlyLooking) ; Are we looking in a
  AND $01                 ; Diagonaly direction?
  ADD A,B                 ; Makes a difference if we are!
  LD B,A
  LD A,(CharHasAHorse)
  CP $00                  ; Have We got a horse?
  JR NZ,WalkForward_0     ; Yes
  SLA B                   ; No. Makes a difference!
WalkForward_0:
  LD A,(LocationFeature)
  CP $06                  ; Are we currently on downs?
  JR NZ,WalkForward_1
  INC B                   ; Yes. Makes a difference
WalkForward_1:
  CP $00                  ; Are we on Mountain?
  JR NZ,WalkForward_2
  INC B                   ; OOOOOH!!!
  INC B                   ; Really makes a difference!
  INC B
  INC B
WalkForward_2:
  CP $02                  ; Are we in a forest
  JR NZ,WalkForward_3     ; No
  LD A,(CharRace)
  CP $02                  ; Are we a Fey?
  JR Z,WalkForward_3      ; Yes
  INC B                   ; Makes a difference if we are
  INC B                   ; not a fey but in a forest
  INC B
WalkForward_3:
  LD A,(TempCharacterNo)
  CP $1F                  ; Are we Farflame?
  JR NZ,WalkForward_4     ; No
  LD B,$01                ; Yes. Then forget all the above!!!
WalkForward_4:
  LD HL,CharTimeOfDay
  CALL ReduceHealthAfterMovement
  LD HL,CharEnergyStatus
  CALL ReduceHealthAfterMovement
  LD HL,CharRidersEnergyStatus
  CALL ReduceHealthAfterMovement
  LD HL,CharWarriorsEnergyStatus
  CALL ReduceHealthAfterMovement
  CALL SaveCharDetails
  JP MainGameLoop

SetResetCharsArmy:
  CALL WorkOutLocationDetails
  LD A,(TotalNoOfArmiesHere) ; How many armies are still here
  JP SetLocationPlainsArmy ; or already here?

Think:
  CALL GetLatestCharInfo
  CALL CalcCharsCourage
DisplayThinkInfo:
  LD A,(CharTimeOfDay)
  LD (TempVar),A
  CALL DrawMainFeature    ; Print the feature
  CALL DisplayCharThink   ; Display the text
  CALL DisplayThinkAgain
  CALL ResetLASTK
  JP CheckGameKeys

Choose:
  CALL GetLatestCharInfo
  CALL CalcCharsCourage
  LD A,(CharLifeStatus)
  CP $00                  ; Is the character alive?
  JP Z,Think              ; Can't choose if the character is stone DEAD!
  CALL DisplayPressAKey
  LD A,$FF
  CALL InitialiseChoices
  CALL SetTokenToLowerCase
  CALL FlushPrintBuffer
  CALL GetLatestCharInfo
  LD A,$03
  LD (KeyReturnStatus),A
  CALL ResetLASTK
PollTableOfKeys:
  CALL CheckKeyCase
  LD C,A
  LD B,$07
  LD HL,ChooseKeyTable
Choose_0:
  LD A,(HL)
  CP C
  JR Z,SelectRoutine
  INC HL
  DJNZ Choose_0
  JP CheckGameKeys
SelectRoutine:
  SUB $31
  ADD A,A
  LD C,A
  LD B,$00
  LD HL,SelectRoutineJumpTable
  ADD HL,BC
  LD E,(HL)
  INC HL
  LD D,(HL)
  EX DE,HL
  JP (HL)

CharacterSeek:
  XOR A
  LD (WhatObjectFlag),A
  LD (WhatObject),A
  LD A,(LocationObject)
  CP $05
  JP C,DisplayThinkInfo   ; If there's Nasties Here
  LD (WhatObject),A       ; Current Object
  JR NZ,CheckGuidance     ; Is there any Horses?
  LD A,(CharRace)         ; Is there any Horses?
  CP $06                  ; Skulkrins & dragons
  JP NC,DisplayThinkInfo  ; Can't Have Horses!?
  LD A,$01
  LD (CharHasAHorse),A
  LD (WhatObjectFlag),A
  CALL CalcCharsGraphicType
  JR FinishCharacterAlter
CheckGuidance:
  CP $07
  JR NZ,CheckShelter      ; Not guidance
  CALL RandomishNumber    ; Pick a Number
  AND $1F                 ; between 0 - 31
  LD (WhatObjectFlag),A   ; Store it away
  JR ClearObjectsLocation
CheckShelter:
  CP $06
  JR NZ,CheckHandOfDark
  CALL IncrementStatusBy_10
  JR ClearObjectsLocation
CheckHandOfDark:
  CP $0A
  JR NZ,CheckCupOfDreams
  XOR A
  LD (CharTimeOfDay),A
  JR ClearObjectsLocation
CheckCupOfDreams:
  CP $0B
  JR NZ,CheckWaterOfLife
  LD A,$10
  LD (CharTimeOfDay),A
  JR ClearObjectsLocation
CheckWaterOfLife:
  CP $09
  JR NZ,CheckShadowsOfDeath
  LD A,$78
SetCharacterStatus:
  LD (CharEnergyStatus),A
  LD (CharWarriorsEnergyStatus),A
  LD (CharRidersEnergyStatus),A
  JR ClearObjectsLocation
CheckShadowsOfDeath:
  CP $08
  JR NZ,CheckIceCrownBusters
  XOR A
  JR SetCharacterStatus
DropTheObject:
  LD A,(CharObjectCarrying)
  LD (LocationObject),A
  LD A,B
  LD (CharObjectCarrying),A
  JR FinishLocationAlter
ClearObjectsLocation:
  XOR A
  LD (LocationObject),A
FinishLocationAlter:
  CALL AlterLocationContents
FinishCharacterAlter:
  CALL SaveCharDetails
  JP DisplayThinkInfo
CheckIceCrownBusters:
  LD B,A
  CP $0E
  JR NC,CharacterSeek_0   ; Fawkrin,Farflame,Logrim,Lake Mirrow
  LD A,(CharObjectCarrying)
  CP $0E
  JR C,DropTheObject      ; What are we carrying other than IceCrown
  JR CharacterSeek_1
CharacterSeek_0:
  LD A,(SaveCurChar)
  CP $01                  ; Is It Morkin?
  JR Z,DropTheObject      ; Yes
CharacterSeek_1:
  XOR A
  LD (WhatObject),A
  LD (WhatObjectFlag),A
  JP DisplayThinkInfo
HideCharacter:
  LD A,(CharHideFlag)
  XOR $01
  LD (CharHideFlag),A
CharacterSeek_2:
  CALL SaveCharDetails
SaveDetails:
  JP Think

StartFight:
  LD A,(FreeArmyPosInTable)
  CP $00
  JR NZ,StartFight_0      ; There's armies here
  LD A,(CharObjectCarrying)
  SUB $0B
  LD B,A
  LD A,(LocationObject)
  CP B
  JR Z,StartFight_0
  CALL CharacterLosesWhat
  LD A,(CharLifeStatus)
  CP $00
  JR NZ,StartFight_0
  NOP
  NOP
  NOP
  NOP
  LD A,(LocationObject)
  LD (CharDeathStatus),A
  JR CharacterSeek_2
StartFight_0:
  LD A,(LocationObject)
  LD (WhatObject),A
  LD (WhatObjectFlag),A
  XOR A
  LD (LocationObject),A
  JP FinishLocationAlter
RecruitCharacter:
  LD A,(CharInLocation)
  LD (SaveCurChar),A
  CALL GetLatestCharInfo
  LD A,$01
  LD (CharAvailable),A    ; Make character now Available
  CALL SaveCharDetails
  JP MainGameLoop

RecruitOrGuardMen:
  LD A,(HowManyGuardsThePlace)
  SUB B                   ; Increase/Decrease
  LD (HowManyGuardsThePlace),A
  LD A,(WhoGuardsThePlace)
  CP $00                  ; Riders?
  JR NZ,RecruitOrGuardMen_0 ; Yes deal with them.
  LD A,(CharNoWarriors)   ; No
  ADD A,B                 ; Change the amount of the characters
  LD (CharNoWarriors),A   ; Warriors accordingly.
  JR RecruitOrGuardMen_1
RecruitOrGuardMen_0:
  LD A,(CharNoRiders)
  ADD A,B                 ; Alter the amount of the
  LD (CharNoRiders),A     ; characters riders.
RecruitOrGuardMen_1:
  CALL StoreArmy_Table1   ; Store Away the Change.
  JP CharacterSeek_2

RecruitMen:
  LD B,$14
  ADD A,$14
  JR RecruitOrGuardMen

Guardmen:
  LD B,$EC
  JR RecruitOrGuardMen

Battle:
  JP WalkForward

; Display Whom we're looking at.
PrintWhoEversInFront:
  LD A,$17
  LD (Row),A              ; Starting Row
  LD A,$7F                ; Assume day time
  LD (Window_Attr),A
  XOR A
  LD (Print_Ink),A
  LD (Print_Mask),A
  LD (PrintCharacterCount),A
  LD A,(CharTimeOfDay)    ; What Time?
  CP $00                  ; Is it night
  JR NZ,PrintWhoEversInFront_0
  LD A,$40                ; This is Night
  LD (Window_Attr),A
  INC A
  LD (Print_Ink),A
PrintWhoEversInFront_0:
  LD HL,(DesirableLocation) ; Where are we?
  LD (LocationToMoveTo),HL
  CALL CheckLocationInfront
  LD B,$00                ; Reset Count
  LD A,(LocationFeature)  ; What's in front?
  CP $0A
  JR NZ,PrintWhoEversInFront_1 ; No Skip next instruction
  INC B                   ; Increment Count
PrintWhoEversInFront_1:
  LD A,(FreeArmyPosInTable) ; How Many Armies of the free are here?
  CP $1D                  ; Less than 29?
  JR C,PrintWhoEversInFront_2 ; Skip next instruction if so.
  INC B                   ; Increment Count.
PrintWhoEversInFront_2:
  LD A,(DoomDarksArmyPosInTable)
  OR B                    ; Combine the no of DoomDarks armies with the count
  LD (CanCharMoveForward),A ; Well if B<>0 then Sorry! No.
  LD A,(NoInCharHereTable)
  CP $00                  ; How Many Characters are in front of us?
  JR Z,AnyDoomDarksRidersInFront ; None. Well Check Armies!
  XOR A                   ; Start of with none in front.
PrintWhoEversInFront_3:
  LD (CharInHereTable),A
  CALL GetFromCharHereTable ; Who Is here?
  LD A,(CharGraphicType)
  CALL PI                 ; Print him!
  LD A,(NoInCharHereTable) ; Check the size of table
  LD B,A
  LD A,(CharInHereTable)
  INC A                   ; Increment our count.
  CP B                    ; Are we at the end?
  JR NZ,PrintWhoEversInFront_3 ; Loop if not.
AnyDoomDarksRidersInFront:
  LD HL,(DoomDarks_Riders)
  LD A,H                  ; Any Riders?
  OR L
  CP $00
  LD A,$02                ; Set A to Display Riders
  JR Z,AnyDoomDarksWarriorsInFront ; What A Label!
  JR PVIII                ; Do Display
AnyDoomDarksWarriorsInFront:
  LD HL,(DoomDarks_Warriors)
  LD A,H                  ; Any Warriors?
  OR L
  CP $00
  JR Z,DisplayMeaniesEtc  ; No. Check Nasties.
  LD A,$09                ; Set A to Display Warriors
  JR PVIII                ; Do Display
DisplayMeaniesEtc:
  LD A,(LocationObject)
  CP $00                  ; Not Set
  RET Z
  CP $06                  ; Greater than 6
  RET NC
  DEC A                   ; Minus one
  LD HL,MeaniesDataTable  ; Point to Table
  LD C,A
  LD B,$00                ; Get info from table
  ADD HL,BC
  LD A,(HL)
  CP $06
  JR Z,PII
  JR PIV

; Do Display
PVIII:
  CALL PIV

PIV:
  CALL PII

PII:
  CALL PI

; Print a character to the screen
PI:
  LD (CharacterToPrint),A
  PUSH AF
  LD A,(PrintCharacterCount) ; How Many So Far?
  LD C,A
  INC A                   ; Printing one more
  CP $09                  ; Loop Eight Times MAX.
  JR NC,PI_0
  LD (PrintCharacterCount),A
  LD B,$00
  LD HL,PositionTable     ; Reference Position Table
  ADD HL,BC
  LD A,(HL)
  LD (Column),A           ; Get the Column Position
  CALL DisplayCharacter
PI_0:
  POP AF
  RET

; Position Table
PositionTable:
  DEFB $0C,$14,$10,$04,$08,$18,$00,$1C

; MeaniesDataTable
MeaniesDataTable:
  DEFB $05,$06,$07,$0C,$0D

CalcCharsCourage:
  LD HL,(IceFear)
  LD A,$07
  CALL HowManyUnitsOf_A
  LD A,(CharCowardess)
  SUB L
  JR NC,CalcCharsCourage_0
  XOR A
CalcCharsCourage_0:
  SRL A
  SRL A
  SRL A
  CP $08
  JR C,CalcCharsCourage_1 ; Can't be more than eight
  LD A,$07                ; must be seven if it is.
CalcCharsCourage_1:
  LD (CharCourageStatus),A
  CALL SaveCharDetails
  LD B,$10
  LD A,(LocationObject)
  CP $00
  JR Z,CalcCharsCourage_2
  CP $06
  JR NC,CalcCharsCourage_2
  LD B,A
CalcCharsCourage_2:
  LD A,B
  LD (WhatObject),A
  XOR A
  LD (WhatObjectFlag),A
  RET

CalcDoomDarksCitadels:
  XOR A
  LD (DoomDarksCitadels),A
CalcDoomDarksCitadels_0:
  LD (Army_Details),A
  CALL GetArmyDetails
  LD A,(WhoseRaceIsArmy)
  CP $00                  ; Army is DoomGuard?
  JR NZ,CalcDoomDarksCitadels_2 ; No
  LD HL,(ArmyLocation)    ; Yes
  LD (WorkingLocation),HL
  CALL CalcMapLocation
  LD B,$05
  LD A,(LocationFeature)
  CP $01
  JR Z,CalcDoomDarksCitadels_1
  LD B,$02
CalcDoomDarksCitadels_1:
  LD A,(DoomDarksCitadels)
  ADD A,B
  LD (DoomDarksCitadels),A
CalcDoomDarksCitadels_2:
  LD A,(Army_Details)     ; Get next army
  INC A
  CP $66                  ; Is it the last?
  JR NZ,CalcDoomDarksCitadels_0 ; No. Loop
  RET

SetLocSpecial:
  LD (WorkingLocation),HL
  CALL CalcMapLocation
  LD A,$80                ; Set The Bit
  LD (LocSpecialFlag),A
  JP AlterLocationContents ; Write it

ResetLocSpecial:
  LD (CurrentLocationY),HL
  LD (WorkingLocation),HL
  CALL CalcMapLocation
  LD A,(LocSpecialFlag)
  PUSH AF                 ; Store it away for a mo
  XOR A                   ; Reset The Bit
  LD (LocSpecialFlag),A
  CALL AlterLocationContents ; Write the Change
  POP AF
  CP $00                  ; Was it actually Set?
  RET Z                   ; No
  CALL WorkOutLocationDetails
  LD A,(DoomDarksArmyPosInTable)
  CP $00                  ; Are there any of doomdarks here?
  RET Z                   ; If Not then return
  JP ItsKillingTime       ; Yes - we must Battle

CalcNightActivity:
  XOR A
CalcNightActivity_0:
  LD (TempCharacterNo),A  ; Character to deal with
  CALL AlterCharDetails   ; Update all his status's
  LD A,(TempCharacterNo)
  INC A                   ; Next Character
  CP $20                  ; Is it the last?
  JR NZ,CalcNightActivity_0 ; No. Loop until
  XOR A                   ; Start with Luxor Again
CalcNightActivity_1:
  LD (TempCharacterNo),A
  CALL CopyCharDetails    ; Mark all characters onto the map
  LD A,(CharLifeStatus)
  CP $00                  ; Is character alive?
  JR Z,CalcNightActivity_2 ; If not can't deal with
  LD A,(CharHideFlag)
  CP $00                  ; Is character hidden?
  JR NZ,CalcNightActivity_2 ; If so can't deal with
  LD HL,(CharLocation)    ; Location at
  CALL SetLocSpecial      ; Set the special flag
CalcNightActivity_2:
  LD A,(TempCharacterNo)
  INC A                   ; Next Character
  CP $20                  ; Are we on the last
  JR NZ,CalcNightActivity_1 ; Loop if not
  XOR A                   ; Start with army 0
CalcNightActivity_3:
  LD (Army_Details),A
  CALL GetArmyDetails     ; Mark all the free armies on the map
  LD A,(WhoseRaceIsArmy)
  CP $00                  ; Does this army belonging to DoomDark
  JR Z,CalcNightActivity_4 ; If so can't deal with it yet.
  LD HL,(ArmyLocation)    ; Where is the army
  CALL SetLocSpecial      ; Set special flag
CalcNightActivity_4:
  LD A,(Army_Details)
  INC A                   ; Next army
  CP $66                  ; Last One
  JR NZ,CalcNightActivity_3 ; Loop if not
  CALL ProcessAllArmies
  XOR A                   ; Start with Luxor again
  LD (NoOfDeathsDescribed),A
CalcNightActivity_5:
  PUSH AF                 ; Remove All Characters
  LD (TempCharacterNo),A  ; from the map????
  CALL CopyCharDetails    ; Reset the Special Location flag
  LD HL,(CharLocation)    ; at the location that
  CALL ResetLocSpecial    ; the character is at!
  POP AF
  INC A
  CP $20
  JR NZ,CalcNightActivity_5
  XOR A                   ; Start with Army 0
CalcNightActivity_6:
  PUSH AF                 ; Remove all armies from
  LD (Army_Details),A     ; the map.
  CALL GetArmyDetails     ; Reset the Special Location
  LD HL,(ArmyLocation)    ; flag at the location that
  CALL ResetLocSpecial    ; the army is at!
  POP AF
  INC A
  CP $66
  JR NZ,CalcNightActivity_6
  CALL CopyScreen
  JP UpdateCharsVars

AlterCharDetails:
  CALL CopyCharDetails
  LD A,(CharTimeOfDay)    ; What time of day is it
  SRL A                   ; Multiply by 2
  LD B,A
  CALL IncrementStatusBy_B ; Increment all status's
  LD A,$10                ; Make Dawn
  LD (CharTimeOfDay),A
  LD A,(CharLifeStatus)
  CP $00                  ; Is the character alive?
  JR Z,AlterCharDetails_0 ; Can't process if Not
  LD A,$FF
  LD (CharBattleStatus),A
  INC A
  LD (CharRidersLost),A
  LD (CharWarriorsLost),A
  LD (CharSlew),A
  LD (CharRidersSlew),A
  LD (CharWarriorsSlew),A
AlterCharDetails_0:
  JP SaveCharDetails

AddOn_B:
  ADD A,B
  CP $80
  RET C
  LD A,$7F
  RET

IncrementStatusBy_10:
  LD B,$10

IncrementStatusBy_B:
  LD A,(CharEnergyStatus)
  ADD A,$09
  CALL AddOn_B
  LD (CharEnergyStatus),A
  LD A,(CharRidersEnergyStatus)
  ADD A,$06
  CALL AddOn_B
  LD (CharRidersEnergyStatus),A
  LD A,(CharWarriorsEnergyStatus)
  ADD A,$04
  CALL AddOn_B
  LD (CharWarriorsEnergyStatus),A
  RET

SelectRoutineJumpTable:
  DEFW CharacterSeek      ; CharacterSeek
  DEFW HideCharacter      ; HideCharacter
  DEFW StartFight         ; StartFight
  DEFW RecruitCharacter   ; RecruitCharacter
  DEFW RecruitMen         ; RecruitMen
  DEFW Guardmen           ; Guardmen
  DEFW Battle             ; Battle

DoReverseSwap:
  CP $20
  RET NC
  EX DE,HL
  JP CopyCharDetails_0

L676D:
  DEFB $65

; Main game data area, which is also used in the saved games
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
  DEFW $0000

; current selected character
SaveCurChar:
  DEFB $00

L6771:
  DEFB $00

L6772:
  DEFB $00

L6773:
  DEFB $01

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
Garrisons:
  DEFB $01,$78,$05,$28,$00,$50,$00,$C8,$04,$3C,$00,$64,$04,$F0,$00,$DC
  DEFB $04,$50,$01,$3C,$00,$64,$02,$28,$00,$3C,$00,$32,$04,$C8,$04,$3C
  DEFB $05,$28,$01,$1E,$00,$28,$01,$3C,$01,$8C,$00,$32,$00,$64,$00,$28
  DEFB $02,$6E,$05,$1E,$00,$32,$00,$1E,$01,$32,$00,$14,$01,$3C,$02,$1E
  DEFB $00,$B4,$00,$14,$00,$46,$05,$50,$00,$32,$01,$28,$00,$28,$01,$3C
  DEFB $05,$1E,$04,$28,$00,$32,$01,$32,$00,$C8,$00,$1E,$05,$1E,$05,$78
  DEFB $07,$28,$00,$3C,$00,$3C,$01,$8C,$01,$32,$01,$1E,$05,$14,$07,$46
  DEFB $01,$50,$01,$1E,$01,$28,$01,$28,$01,$28,$01,$14,$05,$1E,$06,$14
  DEFB $05,$32,$01,$96,$05,$14,$02,$64,$01,$6E,$01,$1E,$05,$14,$01,$1E
  DEFB $01,$32,$01,$28,$05,$1E,$05,$32,$01,$1E,$01,$28,$01,$1E,$01,$1E
  DEFB $01,$28,$01,$32,$01,$32,$01,$28,$01,$1E,$05,$14,$05,$78,$01,$32
  DEFB $01,$1E,$01,$1E,$01,$1E,$01,$28,$01,$28,$01,$32,$05,$1E,$01,$3C
  DEFB $05,$96,$05,$0A,$06,$3C,$05,$32,$01,$32,$01,$28

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
SpecialPlaces:
  DEFB $08,$01,$00,$00,$2E,$04,$01,$10,$1C,$05,$02,$06,$16,$06,$03,$68
  DEFB $20,$07,$04,$06,$17,$08,$05,$03,$1D,$08,$06,$0E,$25,$08,$08,$0A
  DEFB $28,$09,$01,$67,$39,$09,$09,$09,$27,$0A,$0A,$67,$0B,$0B,$0B,$0B
  DEFB $15,$0C,$0D,$16,$19,$0C,$1A,$16,$1D,$0D,$16,$17,$24,$0D,$16,$17
  DEFB $33,$0D,$13,$19,$3E,$0D,$14,$14,$10,$0E,$15,$15,$37,$0E,$11,$14
  DEFB $39,$10,$1F,$6E,$0E,$11,$69,$1D,$1B,$11,$1B,$22,$22,$11,$22,$29
  DEFB $2A,$11,$18,$18,$34,$11,$14,$14,$13,$12,$20,$20,$16,$13,$1A,$20
  DEFB $36,$13,$14,$1F,$0E,$15,$20,$20,$31,$15,$19,$1C,$39,$15,$25,$25
  DEFB $12,$16,$2A,$2A,$2A,$16,$21,$23,$1F,$17,$26,$24,$2E,$17,$23,$1E
  DEFB $27,$18,$21,$27,$38,$19,$2F,$37,$20,$1A,$29,$29,$2D,$1B,$28,$2E
  DEFB $36,$1B,$25,$2F,$22,$1C,$2D,$2D,$11,$1D,$2C,$32,$2A,$1D,$2E,$27
  DEFB $18,$1E,$31,$32,$1E,$1E,$2C,$32,$33,$1E,$2F,$30,$39,$1E,$30,$37
  DEFB $37,$20,$37,$39,$15,$21,$34,$38,$17,$21,$38,$36,$2B,$21,$3D,$3E
  DEFB $0D,$22,$6A,$40,$22,$22,$2B,$33,$1E,$23,$35,$3A,$3B,$23,$39,$3F
  DEFB $15,$25,$3B,$3C,$36,$27,$3D,$3F,$1B,$28,$41,$42,$16,$29,$40,$41
  DEFB $19,$29,$41,$45,$30,$29,$49,$4C,$2A,$2A,$42,$44,$37,$2A,$44,$4C
  DEFB $11,$2B,$48,$4A,$1C,$2B,$6F,$42,$25,$2C,$46,$66,$3B,$2C,$43,$43
  DEFB $2C,$2E,$46,$49,$1D,$2F,$46,$4A,$2A,$2F,$4E,$4B,$07,$30,$56,$55
  DEFB $0A,$30,$51,$51,$30,$31,$4B,$4F,$15,$32,$52,$58,$2D,$32,$50,$53
  DEFB $36,$33,$54,$5E,$27,$34,$52,$59,$2A,$34,$4D,$53,$32,$34,$4C,$5E
  DEFB $2E,$35,$53,$60,$0C,$37,$56,$5B,$19,$37,$66,$66,$2C,$37,$60,$60
  DEFB $37,$37,$5D,$60,$07,$38,$5A,$5A,$0A,$38,$55,$5B,$11,$39,$58,$6D
  DEFB $15,$39,$6D,$52,$25,$39,$5C,$5C,$08,$3A,$5B,$65,$0C,$3A,$65,$57
  DEFB $27,$3B,$5F,$5F,$38,$3B,$60,$60,$3F,$3B,$5D,$64,$2A,$3C,$60,$60
  DEFB $2D,$3C,$60,$60,$04,$3D,$5B,$65,$21,$3D,$5C,$5F,$17,$3D,$52,$66
  DEFB $3B,$3D,$60,$60,$0E,$3D,$63,$63,$1B,$3A,$62,$62,$2A,$0C,$0F,$0F
  DEFB $12,$04,$0C,$12,$07,$16,$34,$6A,$06,$26,$6B,$48,$02,$28,$6C,$6C
  DEFB $00,$30,$47,$61,$14,$3D,$63,$63,$3E,$19,$2F,$37,$1D,$2D,$44,$45

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
Regiments:
  DEFB $9D,$88,$C8,$00,$9D,$88,$C8,$00,$9D,$88,$C8,$00,$9D,$88,$C8,$00
  DEFB $9D,$88,$C8,$00,$9D,$88,$C8,$00,$9D,$88,$C8,$00,$9D,$88,$C8,$00
  DEFB $9D,$88,$C8,$00,$9D,$88,$C8,$00,$9D,$88,$C8,$01,$9D,$88,$C8,$02
  DEFB $9D,$88,$C8,$03,$9D,$88,$C8,$04,$9D,$88,$C8,$05,$9D,$88,$C8,$06
  DEFB $9D,$88,$C8,$08,$9D,$88,$C8,$09,$9D,$88,$C8,$0A,$9D,$88,$C8,$0B
  DEFB $9D,$88,$C8,$0D,$9D,$88,$C8,$0E,$9D,$88,$C8,$10,$9D,$88,$C8,$13
  DEFB $9D,$88,$C8,$14,$9D,$88,$C8,$15,$9D,$88,$C8,$16,$9D,$88,$C8,$17
  DEFB $9D,$88,$C8,$18,$9D,$88,$C8,$19,$9D,$88,$C8,$1A,$9D,$88,$C8,$1B
  DEFB $DD,$88,$F0,$06,$DD,$88,$F0,$06,$DD,$88,$F0,$06,$DD,$88,$F0,$06
  DEFB $DD,$88,$F0,$06,$DD,$88,$F0,$06,$DD,$88,$F0,$06,$DD,$88,$F0,$06
  DEFB $D6,$06,$F0,$03,$D6,$06,$F0,$03,$D6,$06,$F0,$03,$D6,$06,$F0,$03
  DEFB $E5,$08,$F0,$07,$E5,$08,$F0,$07,$E5,$08,$F0,$07,$E5,$08,$F0,$07
  DEFB $9D,$88,$C8,$01,$9D,$88,$C8,$01,$DD,$0D,$F0,$0E,$DD,$0D,$F0,$0E
  DEFB $DD,$0D,$F0,$0E,$DD,$0D,$F0,$0E,$DD,$0D,$F0,$0E,$DD,$0D,$F0,$0E
  DEFB $DD,$0D,$F0,$0E,$DD,$0D,$F0,$0E,$DD,$0D,$F0,$0E,$DD,$0D,$F0,$0E
  DEFB $DD,$0D,$F0,$0E,$DD,$0D,$F0,$0E,$DD,$0D,$F0,$0E,$DD,$0D,$F0,$0E
  DEFB $DD,$8D,$F0,$0E,$DD,$8D,$F0,$0E,$DD,$8D,$F0,$0E,$DD,$8D,$F0,$0E
  DEFB $DD,$8D,$F0,$0E,$DD,$8D,$F0,$0E,$DD,$8D,$F0,$0E,$DD,$8D,$F0,$0E
  DEFB $D2,$16,$F0,$20,$D2,$16,$F0,$20,$D2,$16,$F0,$20,$D2,$16,$F0,$20
  DEFB $D2,$16,$F0,$20,$D2,$16,$F0,$20,$D2,$16,$F0,$20,$D2,$16,$F0,$20
  DEFB $D2,$16,$F0,$20,$D2,$16,$F0,$20,$D2,$16,$F0,$20,$D2,$16,$F0,$20
  DEFB $D2,$16,$F0,$20,$D2,$16,$F0,$20,$D2,$16,$F0,$20,$D2,$16,$F0,$20
  DEFB $D2,$96,$F0,$20,$D2,$96,$F0,$20,$D2,$96,$F0,$20,$D2,$96,$F0,$20
  DEFB $D8,$1E,$F0,$2C,$D8,$1E,$F0,$2C,$D8,$1E,$F0,$2C,$D8,$1E,$F0,$2C
  DEFB $47,$96,$C8,$06,$5B,$91,$C8,$06,$68,$89,$C8,$06,$67,$98,$C8,$06
  DEFB $55,$A1,$C8,$06,$57,$A1,$C8,$06,$51,$1D,$C8,$06,$52,$04,$C8,$06
  DEFB $5E,$1E,$C8,$06,$50,$0E,$C8,$06,$5F,$17,$C8,$06,$46,$26,$C8,$06
  DEFB $1D,$08,$F0,$06,$1D,$08,$F0,$06,$1D,$08,$F0,$06,$1D,$08,$F0,$06
  DEFB $1D,$0D,$F0,$06,$16,$06,$F0,$06,$25,$08,$F0,$06,$17,$08,$F0,$06
  DEFB $1C,$05,$F0,$06,$19,$0C,$F0,$0E,$24,$0D,$F0,$07,$28,$09,$F0,$07
  DEFB $27,$0A,$F0,$07,$20,$07,$F0,$06,$15,$0C,$F0,$03,$1D,$8A,$C8,$06
  DEFB $21,$88,$C8,$06,$1E,$87,$C8,$06,$1B,$87,$C8,$06,$1A,$88,$C8,$06

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
CharactersTable:
  DEFB $0C,$29,$03,$10,$72,$00,$01,$01,$00,$58,$00,$58,$00,$00,$00,$00
  DEFB $00,$00,$FF,$B4,$7F,$19,$50,$17,$00,$00,$00,$00,$01,$01,$0F,$00
  DEFB $0C,$29,$00,$10,$73,$01,$01,$04,$00,$58,$00,$58,$00,$00,$00,$00
  DEFB $00,$00,$FF,$C8,$7F,$05,$7F,$7E,$00,$00,$00,$00,$05,$01,$00,$00
  DEFB $0C,$29,$02,$10,$74,$02,$01,$0F,$00,$58,$00,$58,$00,$00,$00,$00
  DEFB $00,$00,$FF,$B4,$7F,$14,$60,$6B,$00,$00,$00,$00,$02,$01,$00,$00
  DEFB $0C,$29,$01,$10,$75,$03,$01,$03,$00,$58,$00,$58,$00,$00,$00,$00
  DEFB $00,$00,$FF,$DC,$7F,$28,$50,$7F,$00,$00,$00,$00,$04,$01,$00,$00
  DEFB $0A,$38,$02,$10,$1E,$07,$00,$01,$64,$58,$C8,$58,$00,$00,$00,$00
  DEFB $00,$00,$FF,$96,$40,$0A,$40,$01,$01,$00,$00,$00,$01,$01,$00,$00
  DEFB $2B,$21,$06,$10,$38,$07,$00,$01,$64,$58,$C8,$58,$00,$00,$00,$00
  DEFB $00,$00,$FF,$96,$40,$0A,$40,$01,$01,$00,$00,$00,$01,$01,$00,$00
  DEFB $2D,$3C,$00,$10,$35,$07,$00,$01,$A0,$58,$F0,$58,$00,$00,$00,$00
  DEFB $00,$00,$FF,$96,$40,$0F,$40,$01,$01,$00,$00,$00,$01,$01,$00,$00
  DEFB $08,$01,$02,$10,$02,$07,$00,$01,$64,$58,$C8,$58,$00,$00,$00,$00
  DEFB $00,$00,$FF,$96,$40,$0F,$38,$01,$01,$00,$00,$00,$01,$01,$00,$00
  DEFB $1C,$2B,$07,$10,$22,$07,$00,$01,$A0,$58,$C8,$58,$00,$00,$00,$00
  DEFB $00,$00,$FF,$96,$40,$0F,$40,$01,$01,$00,$00,$00,$01,$01,$00,$00
  DEFB $39,$1E,$04,$10,$37,$07,$00,$01,$8C,$58,$C8,$58,$00,$00,$00,$00
  DEFB $00,$00,$FF,$96,$40,$0A,$40,$01,$01,$00,$00,$00,$01,$01,$00,$00
  DEFB $39,$10,$07,$10,$33,$07,$00,$01,$C8,$58,$F0,$58,$00,$00,$00,$00
  DEFB $00,$00,$FF,$96,$40,$0F,$40,$09,$01,$00,$00,$00,$01,$01,$00,$00
  DEFB $2C,$2E,$00,$10,$3D,$07,$00,$01,$64,$58,$A0,$58,$00,$00,$00,$00
  DEFB $00,$00,$FF,$78,$40,$08,$30,$01,$01,$00,$00,$00,$01,$01,$00,$00
  DEFB $2A,$11,$00,$10,$32,$06,$00,$0F,$A0,$58,$F0,$58,$00,$00,$00,$00
  DEFB $00,$00,$FF,$B4,$40,$14,$5A,$1F,$08,$00,$00,$00,$02,$01,$00,$00
  DEFB $3B,$2C,$00,$10,$3C,$06,$00,$0F,$50,$58,$C8,$58,$00,$00,$00,$00
  DEFB $00,$00,$FF,$96,$40,$0F,$50,$1F,$08,$00,$00,$00,$02,$01,$00,$00
  DEFB $21,$3D,$06,$10,$2A,$02,$00,$0F,$78,$58,$50,$58,$00,$00,$00,$00
  DEFB $00,$00,$FF,$82,$40,$0C,$5A,$1A,$02,$00,$00,$00,$02,$01,$00,$00
  DEFB $39,$15,$07,$10,$34,$08,$00,$0F,$3C,$58,$78,$58,$00,$00,$00,$00
  DEFB $00,$00,$FF,$96,$40,$0C,$50,$1A,$02,$00,$00,$00,$02,$01,$00,$00
  DEFB $0B,$26,$00,$10,$1A,$08,$00,$10,$00,$58,$C8,$58,$00,$00,$00,$00
  DEFB $00,$00,$FF,$82,$40,$0C,$46,$1A,$02,$00,$00,$00,$02,$00,$00,$00
  DEFB $0B,$0B,$02,$10,$01,$08,$00,$0F,$28,$58,$64,$58,$00,$00,$00,$00
  DEFB $00,$00,$FF,$64,$40,$08,$3C,$1A,$02,$00,$00,$00,$02,$01,$00,$00
  DEFB $17,$16,$00,$10,$78,$02,$00,$10,$00,$58,$C8,$58,$00,$00,$00,$00
  DEFB $00,$00,$FF,$78,$40,$0C,$3C,$1A,$02,$00,$00,$00,$02,$00,$00,$00
  DEFB $21,$27,$07,$10,$1C,$08,$00,$0F,$3C,$58,$78,$58,$00,$00,$00,$00
  DEFB $00,$00,$FF,$96,$40,$0A,$46,$1A,$02,$00,$00,$00,$02,$01,$00,$00
  DEFB $15,$32,$01,$10,$25,$0B,$00,$01,$64,$58,$3C,$58,$00,$00,$00,$00
  DEFB $00,$00,$FF,$64,$40,$08,$28,$01,$01,$00,$00,$00,$01,$01,$00,$00
  DEFB $17,$3D,$00,$10,$28,$0B,$00,$01,$A0,$58,$50,$58,$00,$00,$00,$00
  DEFB $00,$00,$FF,$64,$40,$08,$32,$01,$01,$00,$00,$00,$01,$01,$00,$00
  DEFB $36,$33,$07,$10,$3E,$0B,$00,$01,$50,$58,$A0,$58,$00,$00,$00,$00
  DEFB $00,$00,$FF,$64,$40,$08,$23,$01,$01,$00,$00,$00,$01,$01,$00,$00
  DEFB $27,$34,$00,$10,$29,$09,$00,$01,$3C,$58,$A0,$58,$00,$00,$00,$00
  DEFB $00,$00,$FF,$78,$40,$08,$28,$01,$01,$00,$00,$00,$01,$01,$00,$00
  DEFB $36,$27,$00,$10,$3B,$0B,$00,$01,$A0,$58,$3C,$58,$00,$00,$00,$00
  DEFB $00,$00,$FF,$78,$40,$08,$32,$01,$01,$00,$00,$00,$01,$01,$00,$00
  DEFB $15,$25,$00,$10,$1B,$0B,$00,$01,$F0,$58,$00,$58,$00,$00,$00,$00
  DEFB $00,$00,$FF,$96,$40,$0F,$50,$01,$01,$00,$00,$00,$01,$01,$00,$00
  DEFB $2D,$1B,$01,$10,$36,$0B,$00,$01,$64,$58,$78,$58,$00,$00,$00,$00
  DEFB $00,$00,$FF,$82,$40,$08,$28,$01,$01,$00,$00,$00,$01,$01,$00,$00
  DEFB $1D,$2F,$00,$10,$1F,$0B,$00,$01,$64,$58,$78,$58,$00,$00,$00,$00
  DEFB $00,$00,$FF,$82,$40,$08,$32,$01,$01,$00,$00,$00,$01,$01,$00,$00
  DEFB $3B,$23,$06,$10,$3A,$0A,$00,$00,$C8,$58,$00,$58,$00,$00,$00,$00
  DEFB $00,$00,$FF,$B4,$40,$14,$50,$00,$04,$00,$00,$00,$03,$01,$00,$00
  DEFB $01,$0B,$02,$10,$76,$05,$00,$0C,$00,$58,$00,$58,$00,$00,$00,$00
  DEFB $00,$00,$FF,$C8,$40,$01,$1E,$00,$20,$00,$00,$00,$06,$00,$00,$00

MainMapCalcHLTable:
  DEFB $3E,$01,$04,$10,$2D,$03,$00,$03,$00,$58,$00,$58,$00,$00,$00,$00
  DEFB $00,$00,$FF,$C8,$40,$14,$46,$7F,$10,$00,$00,$00,$04,$00,$00,$00
  DEFB $0C,$18,$03,$10,$77,$04,$00,$06,$00,$58,$00,$58,$00,$00,$00,$00
  DEFB $00,$00,$FF,$C8,$40,$64,$7F,$00,$40,$00,$00,$00,$07,$01,$00,$00

; Terrain map - 64x61 byte map running x - y
;
; Each entry is a single BYTE:
; +------+------------------+
; | Bits | Description      |
; +------+------------------+
; | 0-3  | Terrain table ID |
; | 4-7  | Object table ID  |
; +------+------------------+
;
; Terrain types table
;
; +-----+--------------+
; | $00 | Mountain     |
; | $01 | Citadel      |
; | $02 | Forest       |
; | $03 | Henge        |
; | $04 | Tower        |
; | $05 | Village      |
; | $06 | Downs        |
; | $07 | Keep         |
; | $08 | Snow Hall    |
; | $09 | Lake         |
; | $0A | Frozen Waste |
; | $0B | Ruin         |
; | $0C | Lith         |
; | $0D | Cavern       |
; | $0E | Army         |
; | $0F | Plains       |
; +-----+--------------+
;  Objects types table
; +-----+------------------------+
; | $00 | None                   |
; | $01 | Wolves                 |
; | $02 | Dragons                |
; | $03 | Ice Trolls             |
; | $04 | Skulkrin               |
; | $05 | Wild Horses            |
; | $06 | Shelter                |
; | $07 | Guidance               |
; | $08 | Shadows Of Death       |
; | $09 | Waters Of Life         |
; | $0A | Hand Of Dark           |
; | $0B | Cup Of Dreams          |
; | $0C | Sword of Wolf Slayer   |
; | $0D | Sword of Dragon Slayer |
; | $0E | Ice Crown              |
; | $0F | Moon Ring              |
; +-----+------------------------+
TerrainMap:
  DEFB $0A,$0A,$6B,$0F,$C8,$0F,$00,$00,$61,$0F,$0F,$0F,$0F,$0F,$0F,$0F
  DEFB $0F,$0F,$0F,$0F,$68,$0F,$0F,$0F,$0A,$0A,$0C,$5F,$0F,$0F,$73,$0F
  DEFB $0F,$0F,$0F,$0F,$5F,$1F,$0A,$0A,$BC,$0F,$0F,$0B,$0F,$68,$0F,$0F
  DEFB $0F,$0A,$0F,$68,$0F,$0F,$0F,$68,$0F,$0F,$0A,$0A,$0A,$0F,$74,$0F
  DEFB $0A,$0F,$0F,$0F,$46,$30,$00,$00,$00,$00,$0F,$0F,$0F,$A8,$0F,$02
  DEFB $02,$0F,$0F,$0F,$0F,$0F,$0F,$0A,$0A,$0A,$0A,$06,$56,$0F,$0F,$0F
  DEFB $0F,$0F,$A8,$0F,$0F,$0F,$5F,$68,$0F,$0F,$0F,$06,$06,$06,$99,$06
  DEFB $26,$0F,$5F,$0F,$93,$0F,$0F,$0F,$0F,$0F,$3D,$0A,$0A,$99,$0F,$A8
  DEFB $0F,$0F,$0F,$06,$00,$30,$00,$00,$00,$00,$40,$0F,$0F,$1F,$02,$02
  DEFB $02,$12,$0F,$0F,$BC,$5F,$0A,$0A,$00,$00,$00,$20,$20,$06,$06,$06
  DEFB $0F,$0F,$5F,$1F,$0F,$0F,$0F,$0F,$0F,$06,$46,$06,$56,$36,$36,$16
  DEFB $06,$26,$06,$3D,$0F,$5F,$0C,$0F,$06,$26,$0F,$0A,$0A,$68,$0F,$0A
  DEFB $0F,$02,$16,$06,$2D,$40,$00,$00,$00,$00,$02,$02,$02,$0F,$02,$02
  DEFB $02,$02,$B3,$0F,$0F,$DD,$00,$00,$00,$20,$00,$00,$00,$CB,$20,$00
  DEFB $0F,$0F,$0F,$99,$0F,$68,$0F,$0F,$06,$06,$06,$56,$06,$06,$67,$06
  DEFB $06,$16,$06,$06,$36,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0A,$0F,$0A,$0A
  DEFB $0F,$02,$02,$99,$0F,$0F,$00,$00,$00,$40,$02,$12,$02,$0F,$0F,$02
  DEFB $02,$0F,$0F,$06,$06,$00,$30,$30,$6D,$42,$E4,$02,$67,$00,$00,$00
  DEFB $00,$CB,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$06,$68,$06,$06,$06,$06
  DEFB $06,$6D,$36,$06,$06,$0F,$0F,$06,$5F,$B8,$0F,$0F,$0C,$0A,$0A,$0A
  DEFB $0F,$0F,$12,$02,$02,$1F,$0F,$20,$42,$02,$02,$02,$02,$0F,$0F,$0F
  DEFB $7C,$0F,$0F,$20,$00,$0F,$61,$02,$42,$02,$02,$12,$5F,$0F,$65,$00
  DEFB $00,$00,$40,$00,$20,$30,$0F,$0F,$0F,$CC,$0F,$06,$46,$06,$56,$06
  DEFB $56,$06,$06,$06,$26,$06,$1F,$0F,$1F,$0F,$0F,$0F,$0F,$0F,$0A,$0A
  DEFB $0F,$0F,$02,$02,$02,$02,$0F,$0F,$02,$02,$02,$02,$12,$02,$0F,$0F
  DEFB $0F,$0F,$0F,$CB,$00,$30,$06,$06,$6B,$0F,$0F,$0F,$1F,$0F,$0F,$5F
  DEFB $67,$00,$00,$00,$00,$20,$00,$00,$0F,$0F,$0F,$0F,$2D,$06,$06,$16
  DEFB $06,$06,$26,$DB,$0F,$0F,$0F,$DC,$0F,$0F,$0F,$06,$0F,$0F,$0F,$0A
  DEFB $0F,$B8,$0F,$12,$02,$12,$0F,$0F,$02,$02,$02,$02,$02,$12,$02,$02
  DEFB $0F,$0F,$0F,$0F,$CC,$00,$00,$67,$06,$06,$0F,$65,$0F,$61,$0F,$0F
  DEFB $0F,$0F,$0F,$0F,$0F,$D1,$0F,$00,$20,$CB,$02,$5F,$0F,$0F,$0F,$1F
  DEFB $06,$06,$0F,$0F,$0F,$0F,$0F,$30,$20,$00,$0F,$CD,$0F,$74,$99,$0F
  DEFB $0F,$0F,$0F,$0F,$B8,$0F,$0F,$02,$02,$02,$02,$B3,$40,$02,$42,$02
  DEFB $12,$0F,$0F,$0F,$1F,$99,$00,$00,$00,$20,$02,$BC,$1F,$5F,$00,$00
  DEFB $00,$40,$20,$20,$40,$00,$06,$06,$67,$0F,$1F,$0F,$68,$02,$99,$0F
  DEFB $99,$0F,$73,$0F,$0F,$3D,$00,$00,$20,$67,$40,$00,$00,$30,$0F,$0F
  DEFB $5F,$0F,$0C,$9C,$BC,$CC,$7C,$02,$02,$02,$6D,$65,$74,$0F,$65,$12
  DEFB $12,$0F,$0F,$0F,$0F,$0F,$00,$00,$00,$00,$00,$00,$06,$0F,$00,$00
  DEFB $40,$40,$00,$40,$74,$00,$00,$67,$1F,$7C,$0F,$0F,$42,$02,$02,$0F
  DEFB $0F,$0F,$0F,$0F,$A8,$0F,$0F,$40,$00,$00,$00,$99,$00,$00,$99,$1F
  DEFB $0F,$83,$0F,$1F,$0F,$0F,$0F,$AD,$02,$02,$06,$67,$99,$DC,$8B,$02
  DEFB $02,$0F,$CB,$0F,$0F,$0F,$0F,$02,$00,$00,$00,$00,$40,$0F,$00,$00
  DEFB $00,$00,$99,$00,$00,$00,$00,$00,$6B,$1F,$0F,$02,$42,$12,$02,$02
  DEFB $0F,$0C,$0F,$7C,$1F,$0F,$02,$AD,$00,$00,$99,$00,$00,$99,$0F,$0F
  DEFB $0F,$0F,$0C,$0C,$BC,$BC,$DC,$0F,$02,$12,$12,$56,$06,$5F,$02,$02
  DEFB $02,$5F,$0F,$0F,$0F,$67,$0F,$0F,$0F,$67,$30,$20,$30,$0F,$40,$00
  DEFB $00,$06,$36,$46,$46,$06,$30,$40,$06,$46,$6D,$42,$02,$74,$02,$12
  DEFB $42,$02,$5F,$0F,$02,$0F,$68,$0F,$00,$00,$00,$00,$0F,$68,$0F,$0F
  DEFB $1F,$0F,$0F,$0F,$16,$36,$0F,$02,$42,$02,$02,$02,$02,$02,$12,$42
  DEFB $0F,$0F,$0F,$0F,$0F,$00,$20,$0F,$0F,$06,$06,$40,$40,$61,$00,$20
  DEFB $5F,$0F,$0F,$06,$67,$26,$06,$26,$06,$42,$02,$42,$02,$02,$02,$02
  DEFB $02,$02,$12,$67,$1F,$0F,$1F,$06,$00,$40,$00,$0F,$0F,$0F,$67,$0F
  DEFB $0F,$0F,$0F,$06,$06,$56,$06,$06,$02,$02,$02,$02,$02,$02,$0F,$0F
  DEFB $67,$0F,$0F,$00,$00,$00,$56,$06,$36,$0F,$06,$06,$0F,$0F,$0F,$1F
  DEFB $0F,$0F,$DC,$0F,$0F,$0F,$DC,$0F,$02,$02,$02,$99,$12,$02,$42,$02
  DEFB $12,$02,$12,$0F,$0F,$0F,$06,$67,$99,$0F,$0F,$16,$5F,$0F,$0F,$0F
  DEFB $0F,$0F,$0F,$06,$46,$06,$7C,$26,$16,$AB,$0F,$0F,$0F,$0F,$68,$0F
  DEFB $0F,$0F,$00,$00,$00,$06,$36,$CB,$1F,$0F,$0F,$0F,$1F,$1F,$1F,$0F
  DEFB $0F,$0F,$02,$12,$02,$42,$02,$42,$02,$02,$02,$02,$12,$02,$02,$0F
  DEFB $65,$02,$42,$0F,$0F,$26,$06,$1F,$0F,$0F,$06,$0F,$65,$65,$0F,$0F
  DEFB $0F,$0F,$16,$DB,$06,$06,$06,$06,$26,$0F,$2D,$0F,$9C,$0F,$0F,$0F
  DEFB $0F,$20,$00,$00,$02,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$5F,$5F
  DEFB $0F,$0F,$02,$02,$42,$DB,$02,$02,$12,$02,$02,$02,$0C,$02,$02,$6B
  DEFB $0F,$0F,$0F,$0F,$12,$0F,$5F,$7C,$0F,$C1,$0F,$0F,$0F,$0F,$0F,$6D
  DEFB $1F,$0F,$06,$06,$06,$6D,$06,$06,$06,$06,$0F,$0F,$0F,$1F,$67,$0F
  DEFB $00,$65,$00,$0F,$0F,$9C,$0F,$0F,$0F,$99,$0F,$67,$0F,$0F,$0F,$0F
  DEFB $0F,$0F,$67,$02,$12,$02,$02,$65,$02,$02,$61,$12,$02,$02,$02,$02
  DEFB $5F,$6B,$0F,$0F,$67,$65,$0F,$0F,$0F,$0F,$65,$DB,$42,$02,$68,$0F
  DEFB $C8,$0F,$56,$16,$06,$06,$06,$65,$06,$99,$5F,$5F,$0F,$0F,$0F,$00
  DEFB $00,$20,$00,$67,$1F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
  DEFB $0F,$0F,$0F,$12,$12,$02,$02,$12,$02,$02,$02,$02,$42,$2D,$02,$02
  DEFB $65,$0F,$0F,$0F,$0F,$65,$65,$0F,$99,$0F,$0F,$12,$02,$02,$02,$0F
  DEFB $0F,$0F,$06,$06,$06,$56,$26,$06,$06,$06,$06,$0F,$0F,$0F,$0F,$0F
  DEFB $30,$30,$00,$06,$1F,$0F,$67,$0F,$0F,$12,$42,$5F,$5F,$0F,$0F,$0F
  DEFB $0F,$DC,$0F,$02,$42,$02,$02,$02,$00,$00,$02,$02,$12,$02,$12,$42
  DEFB $02,$0F,$99,$DC,$7C,$1F,$67,$DB,$02,$12,$42,$BC,$02,$02,$02,$02
  DEFB $0F,$00,$00,$06,$56,$0F,$CB,$06,$06,$0F,$0F,$0F,$02,$02,$0F,$0F
  DEFB $99,$00,$00,$06,$0F,$0F,$02,$42,$42,$02,$12,$12,$0F,$0C,$0F,$0F
  DEFB $BC,$1F,$0C,$0F,$0F,$0F,$42,$02,$02,$12,$02,$12,$65,$99,$42,$02
  DEFB $02,$0F,$0F,$0F,$0F,$00,$00,$00,$00,$12,$12,$02,$0F,$02,$02,$02
  DEFB $0F,$00,$00,$00,$16,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$00,$00,$67,$0F
  DEFB $0F,$0F,$0F,$06,$06,$02,$42,$42,$12,$99,$12,$02,$02,$0F,$0F,$0F
  DEFB $0F,$9C,$1F,$BC,$06,$6B,$02,$02,$02,$12,$02,$0F,$0F,$99,$0F,$0F
  DEFB $1F,$67,$0F,$00,$00,$30,$00,$00,$02,$C7,$02,$02,$65,$42,$12,$02
  DEFB $1F,$DB,$00,$20,$00,$0F,$0F,$CC,$0F,$0F,$00,$30,$20,$30,$30,$00
  DEFB $0F,$0F,$61,$0F,$06,$12,$12,$65,$12,$02,$02,$02,$02,$0F,$0F,$0F
  DEFB $0F,$0F,$DC,$0F,$7C,$06,$5F,$02,$02,$02,$67,$0F,$73,$5F,$0F,$CB
  DEFB $5F,$40,$20,$00,$20,$00,$20,$02,$02,$02,$02,$02,$42,$0F,$02,$02
  DEFB $0F,$0F,$00,$30,$30,$0F,$5F,$0F,$0F,$00,$40,$00,$00,$20,$20,$00
  DEFB $30,$0F,$0F,$0F,$42,$02,$02,$02,$02,$02,$12,$02,$0F,$0F,$0F,$67
  DEFB $65,$0F,$26,$BC,$0F,$56,$0F,$0F,$16,$06,$06,$46,$26,$06,$67,$00
  DEFB $00,$00,$20,$00,$20,$0F,$73,$02,$02,$02,$74,$02,$02,$CC,$02,$02
  DEFB $0F,$0F,$A3,$00,$00,$1F,$0F,$0F,$0F,$40,$00,$00,$DB,$65,$00,$20
  DEFB $00,$20,$0F,$99,$0F,$02,$02,$42,$02,$12,$02,$0F,$0F,$0F,$1F,$0F
  DEFB $1F,$0F,$26,$0F,$BC,$0F,$0F,$67,$0F,$0F,$0F,$65,$00,$00,$00,$00
  DEFB $20,$40,$20,$0F,$99,$1F,$0F,$0F,$02,$42,$02,$02,$02,$02,$1F,$65
  DEFB $0F,$0F,$00,$00,$02,$1F,$0F,$99,$0F,$40,$00,$00,$74,$99,$30,$00
  DEFB $20,$0F,$0F,$0F,$0F,$00,$00,$00,$00,$00,$00,$00,$1F,$0F,$0F,$0F
  DEFB $0F,$06,$CD,$0F,$CC,$0F,$0F,$0F,$1F,$CC,$00,$00,$00,$00,$00,$00
  DEFB $0F,$6B,$02,$0F,$0F,$0F,$65,$0F,$67,$02,$02,$12,$65,$0F,$8B,$1F
  DEFB $0F,$02,$00,$30,$99,$0F,$0F,$00,$0F,$0F,$00,$00,$00,$00,$20,$00
  DEFB $0F,$0F,$5F,$65,$20,$40,$30,$00,$40,$00,$40,$00,$30,$00,$0F,$0F
  DEFB $67,$00,$30,$0F,$DB,$CB,$0F,$0F,$99,$30,$00,$00,$00,$20,$0F,$0F
  DEFB $0F,$0F,$0F,$65,$0F,$BC,$1F,$65,$0F,$0F,$0F,$0F,$0F,$AD,$0F,$1F
  DEFB $0F,$20,$00,$30,$5F,$0F,$02,$00,$30,$0F,$0F,$00,$00,$00,$30,$02
  DEFB $7C,$06,$00,$40,$00,$00,$40,$40,$00,$00,$20,$00,$40,$40,$00,$00
  DEFB $00,$30,$30,$0F,$0F,$0F,$0F,$00,$00,$00,$40,$20,$0F,$67,$00,$00
  DEFB $00,$30,$00,$40,$0F,$5F,$67,$0F,$DB,$1F,$0F,$0C,$0F,$0F,$CB,$02
  DEFB $0F,$00,$00,$30,$0F,$0F,$20,$74,$00,$40,$0F,$42,$00,$30,$00,$20
  DEFB $06,$0F,$40,$20,$00,$00,$02,$6B,$65,$06,$20,$00,$00,$00,$30,$20
  DEFB $00,$00,$67,$0F,$0F,$74,$30,$00,$20,$00,$00,$0F,$65,$0F,$99,$00
  DEFB $30,$30,$30,$00,$00,$00,$00,$20,$00,$20,$65,$1F,$06,$06,$02,$02
  DEFB $0F,$0F,$20,$30,$0F,$5F,$00,$30,$00,$30,$0F,$02,$00,$40,$00,$6B
  DEFB $0F,$67,$0F,$0F,$0F,$0C,$06,$06,$0F,$0F,$99,$06,$00,$00,$00,$0F
  DEFB $0F,$0F,$0F,$0F,$00,$00,$00,$40,$00,$00,$67,$0F,$74,$0F,$0F,$0F
  DEFB $0F,$65,$40,$00,$00,$30,$40,$00,$00,$00,$65,$0F,$6B,$06,$46,$42
  DEFB $0F,$A8,$02,$02,$0F,$0F,$20,$00,$00,$00,$1F,$02,$00,$00,$00,$1F
  DEFB $0F,$0F,$00,$40,$0F,$06,$0F,$0F,$61,$0F,$0F,$0F,$0F,$0F,$67,$0F
  DEFB $0F,$0F,$00,$20,$00,$30,$00,$00,$DB,$0F,$0F,$06,$30,$00,$02,$12
  DEFB $46,$0F,$0F,$67,$0F,$0F,$0F,$0F,$0F,$61,$1F,$0F,$0F,$0F,$5F,$DC
  DEFB $0F,$0F,$0F,$0F,$0F,$0F,$20,$2D,$20,$00,$0F,$0F,$30,$00,$20,$99
  DEFB $BC,$00,$20,$40,$40,$20,$DB,$0F,$0F,$8B,$00,$00,$30,$40,$30,$00
  DEFB $00,$00,$40,$20,$00,$00,$00,$0F,$0F,$65,$0F,$00,$00,$00,$00,$40
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$0F,$0F,$0F,$0F,$74,$74,$1F,$1F
  DEFB $0F,$0F,$0F,$00,$1F,$0F,$00,$20,$00,$30,$5F,$1F,$00,$00,$00,$00
  DEFB $20,$00,$74,$20,$00,$40,$0F,$0F,$0F,$30,$00,$40,$00,$00,$00,$30
  DEFB $00,$00,$40,$00,$20,$00,$3D,$0F,$99,$46,$46,$CB,$00,$40,$00,$30
  DEFB $00,$00,$00,$20,$00,$00,$00,$67,$0F,$0F,$AB,$0F,$1F,$0F,$0C,$99
  DEFB $0F,$0F,$0F,$00,$40,$0F,$00,$00,$00,$00,$0F,$0F,$0F,$00,$00,$00
  DEFB $00,$00,$00,$00,$40,$67,$5F,$67,$00,$00,$20,$00,$40,$40,$00,$00
  DEFB $00,$00,$30,$00,$6B,$0F,$0F,$5F,$0F,$0F,$06,$C1,$0F,$1F,$0F,$0F
  DEFB $0F,$0F,$65,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$02,$65,$0F,$99,$0F
  DEFB $0F,$0F,$68,$00,$00,$0F,$00,$00,$40,$00,$00,$1F,$1F,$67,$20,$00
  DEFB $20,$40,$30,$0F,$0F,$5F,$0F,$0F,$00,$00,$0F,$0F,$0F,$0F,$5F,$0F
  DEFB $0F,$0F,$67,$0F,$0F,$0F,$0F,$02,$0F,$0F,$0F,$CC,$0F,$0F,$1F,$65
  DEFB $0F,$7C,$0F,$0F,$AD,$0F,$0F,$65,$0F,$7C,$0F,$0F,$0F,$0F,$02,$0F
  DEFB $5F,$0F,$20,$00,$00,$0F,$0F,$20,$30,$0F,$DB,$0F,$5F,$0F,$0F,$AB
  DEFB $0F,$0F,$0F,$0F,$0F,$0F,$5F,$0F,$0F,$0F,$0F,$93,$0F,$0F,$67,$0F
  DEFB $0F,$0F,$1F,$9C,$0B,$0F,$0F,$0F,$0F,$BC,$1F,$0F,$16,$06,$0F,$B3
  DEFB $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$5F,$D7,$0F,$0F,$1F,$0F
  DEFB $0F,$1F,$30,$00,$20,$00,$0F,$00,$0F,$0F,$0F,$0F,$5F,$5F,$0F,$0F
  DEFB $1F,$9C,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$1F,$0F,$0F,$0F,$0F,$0F
  DEFB $0F,$02,$02,$02,$0F,$0F,$0F,$65,$0F,$99,$0F,$0F,$65,$06,$06,$06
  DEFB $06,$06,$0F,$65,$0F,$0F,$99,$0F,$5F,$0F,$0F,$0F,$0F,$0F,$65,$0F
  DEFB $0F,$0F,$00,$40,$40,$00,$0F,$0F,$5F,$0F,$02,$02,$02,$42,$0F,$30
  DEFB $00,$0F,$0F,$0F,$0F,$67,$0F,$0F,$0F,$0F,$0F,$1F,$0F,$0F,$0F,$02
  DEFB $02,$02,$02,$42,$42,$02,$02,$02,$02,$0F,$CB,$0F,$56,$06,$46,$06
  DEFB $06,$06,$BC,$36,$06,$0B,$0F,$0F,$5F,$65,$0F,$0F,$0F,$0F,$0F,$1F
  DEFB $0F,$0F,$0F,$00,$00,$0F,$DC,$5F,$0F,$02,$02,$02,$02,$12,$02,$02
  DEFB $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$99,$0F,$0F,$0F,$42,$02
  DEFB $02,$02,$02,$12,$02,$02,$12,$02,$02,$0F,$0F,$0F,$36,$06,$CD,$06
  DEFB $65,$06,$06,$06,$06,$06,$06,$06,$0F,$0F,$0F,$0F,$0F,$0F,$1F,$0F
  DEFB $0A,$0F,$0F,$26,$06,$5F,$0F,$1F,$42,$02,$02,$42,$12,$12,$02,$02
  DEFB $02,$0F,$5F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$65,$02,$12
  DEFB $02,$65,$99,$12,$12,$12,$12,$1F,$0F,$0F,$0F,$0F,$26,$56,$26,$06
  DEFB $06,$02,$06,$99,$06,$46,$67,$06,$46,$06,$0F,$0F,$0F,$AB,$02,$02
  DEFB $0A,$0F,$99,$0F,$06,$46,$0F,$02,$02,$12,$02,$02,$06,$02,$12,$12
  DEFB $02,$0F,$0F,$CB,$0F,$0F,$0F,$0F,$1F,$0F,$0F,$67,$0F,$02,$42,$02
  DEFB $02,$26,$02,$3D,$12,$02,$0F,$0F,$42,$0F,$12,$0F,$0F,$0F,$26,$0C
  DEFB $06,$46,$06,$06,$06,$65,$26,$06,$06,$0F,$9C,$02,$12,$02,$02,$02
  DEFB $0A,$0F,$0F,$0F,$06,$06,$06,$DB,$02,$02,$02,$06,$74,$0F,$0F,$02
  DEFB $0F,$5F,$0F,$0F,$0F,$0F,$67,$0F,$0F,$67,$0F,$0F,$0F,$02,$12,$02
  DEFB $02,$42,$42,$02,$02,$0B,$0F,$65,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
  DEFB $67,$26,$36,$06,$26,$06,$06,$06,$0F,$0F,$12,$42,$02,$02,$02,$02
  DEFB $0F,$0F,$0F,$20,$20,$0F,$26,$1F,$12,$02,$12,$0F,$26,$06,$02,$02
  DEFB $12,$0F,$CC,$0F,$65,$06,$06,$56,$0F,$0F,$1F,$0F,$0F,$CB,$12,$02
  DEFB $42,$02,$12,$65,$42,$0F,$0F,$1F,$B3,$0F,$D7,$1F,$2D,$65,$5F,$0F
  DEFB $0F,$0F,$0F,$06,$8B,$06,$06,$C7,$02,$02,$02,$42,$02,$02,$42,$02
  DEFB $0F,$0F,$00,$00,$00,$AD,$0F,$0F,$5F,$12,$02,$02,$42,$02,$02,$02
  DEFB $1F,$67,$0F,$06,$46,$36,$06,$06,$06,$16,$8B,$0F,$C1,$0F,$0F,$0F
  DEFB $02,$02,$02,$02,$0F,$0F,$0F,$0F,$0F,$CC,$0F,$0F,$0F,$06,$0F,$06
  DEFB $0F,$65,$0F,$0F,$06,$06,$0F,$02,$02,$02,$02,$02,$02,$02,$02,$02
  DEFB $1F,$0F,$00,$00,$20,$30,$0F,$0F,$0F,$0F,$02,$02,$02,$02,$02,$3D
  DEFB $5F,$06,$16,$02,$06,$56,$99,$46,$65,$46,$26,$06,$42,$0F,$65,$0F
  DEFB $1F,$BC,$0F,$5F,$0F,$67,$0F,$0F,$99,$5F,$46,$0F,$06,$0F,$DC,$0F
  DEFB $6B,$0F,$1F,$0F,$0F,$0F,$0F,$12,$12,$02,$02,$C1,$02,$AD,$02,$42
  DEFB $5F,$0F,$20,$20,$30,$00,$20,$0F,$06,$0F,$0F,$42,$02,$42,$0F,$0F
  DEFB $06,$06,$26,$06,$06,$06,$06,$06,$06,$56,$06,$06,$06,$CC,$0F,$0F
  DEFB $0F,$0F,$0F,$0F,$0F,$5F,$06,$0F,$0F,$65,$5F,$0F,$0F,$0F,$0F,$0F
  DEFB $0F,$0F,$65,$06,$0F,$42,$02,$02,$12,$02,$12,$02,$06,$02,$02,$02
  DEFB $0F,$6B,$0F,$00,$00,$00,$00,$20,$0F,$06,$06,$1F,$0F,$0F,$0F,$0F
  DEFB $0F,$0F,$0F,$06,$26,$16,$16,$06,$06,$26,$65,$26,$46,$0F,$99,$65
  DEFB $0F,$0F,$65,$0F,$0F,$0F,$0F,$8B,$0F,$0F,$0F,$00,$61,$00,$99,$0F
  DEFB $06,$0F,$0F,$0F,$0F,$02,$02,$12,$12,$02,$02,$02,$7C,$02,$02,$02
  DEFB $0F,$0F,$A8,$0F,$30,$40,$00,$00,$00,$00,$0F,$0F,$AB,$0F,$BC,$0F
  DEFB $0F,$40,$00,$0C,$5F,$0F,$65,$46,$06,$06,$06,$06,$1F,$67,$40,$00
  DEFB $5F,$0F,$5F,$0F,$DC,$0F,$0F,$0F,$20,$0F,$67,$0F,$00,$00,$40,$00
  DEFB $00,$06,$0F,$0F,$BC,$0F,$65,$42,$02,$02,$42,$02,$99,$02,$12,$02
  DEFB $0F,$0F,$0F,$0F,$0F,$30,$40,$67,$40,$20,$67,$0F,$0F,$0F,$0F,$0F
  DEFB $B3,$00,$20,$0F,$5F,$0F,$0F,$0F,$06,$46,$06,$0F,$0F,$00,$00,$00
  DEFB $0F,$CB,$0F,$0F,$0F,$65,$99,$00,$40,$0F,$00,$0F,$8B,$30,$0F,$00
  DEFB $99,$0F,$0F,$0F,$0F,$0F,$02,$02,$12,$02,$02,$02,$02,$74,$02,$02
  DEFB $0F,$0F,$0F,$0F,$99,$30,$40,$00,$00,$00,$00,$5F,$0F,$0F,$7C,$0F
  DEFB $0F,$00,$00,$02,$5F,$0F,$0F,$0F,$0F,$CC,$5F,$1F,$00,$40,$00,$42
  DEFB $46,$46,$0F,$65,$99,$20,$00,$00,$00,$0F,$00,$00,$0F,$40,$CB,$0F
  DEFB $67,$0F,$5F,$99,$0F,$42,$02,$42,$12,$42,$02,$02,$42,$65,$42,$02
  DEFB $0F,$1F,$0F,$CB,$40,$00,$00,$00,$40,$00,$00,$00,$0F,$0F,$0F,$0F
  DEFB $CB,$00,$30,$02,$02,$67,$0F,$65,$06,$0F,$02,$00,$00,$40,$02,$0F
  DEFB $0F,$0F,$6D,$40,$00,$00,$74,$30,$30,$0F,$40,$00,$0F,$67,$0F,$00
  DEFB $00,$CC,$5F,$36,$65,$02,$02,$02,$0F,$0F,$02,$02,$12,$02,$0F,$42
  DEFB $0F,$6D,$0F,$30,$40,$40,$40,$00,$00,$20,$20,$00,$99,$0F,$BC,$0F
  DEFB $20,$00,$00,$3D,$36,$26,$56,$06,$0F,$02,$00,$00,$00,$06,$0F,$5F
  DEFB $0F,$20,$20,$40,$40,$00,$00,$00,$DB,$0F,$00,$00,$00,$0F,$30,$99
  DEFB $00,$00,$0F,$5F,$DB,$0F,$67,$1F,$0F,$65,$0F,$02,$12,$02,$0F,$02
  DEFB $0F,$0F,$00,$00,$20,$00,$12,$02,$02,$00,$40,$00,$40,$0F,$0F,$0F
  DEFB $00,$00,$20,$06,$06,$65,$0F,$0F,$0F,$02,$00,$40,$06,$0F,$65,$0F
  DEFB $00,$20,$40,$00,$40,$02,$12,$67,$06,$0F,$67,$00,$00,$0F,$20,$30
  DEFB $00,$40,$67,$65,$DC,$56,$06,$5F,$0C,$0F,$12,$12,$12,$83,$02,$12
  DEFB $0F,$5F,$00,$00,$00,$0F,$0F,$65,$0F,$99,$00,$00,$40,$0F,$BC,$0F
  DEFB $30,$00,$65,$06,$1F,$0F,$0F,$0F,$65,$00,$00,$00,$56,$0F,$0F,$00
  DEFB $00,$20,$00,$99,$0F,$DB,$99,$65,$0F,$00,$20,$00,$00,$0F,$67,$00
  DEFB $20,$00,$30,$40,$20,$74,$0F,$5F,$06,$06,$02,$12,$0F,$02,$12,$12
  DEFB $0F,$5F,$40,$00,$00,$65,$0F,$99,$0F,$5F,$40,$20,$00,$0F,$0F,$0F
  DEFB $00,$00,$06,$56,$0F,$0F,$0F,$0F,$40,$00,$00,$06,$0F,$1F,$0F,$0F
  DEFB $1F,$1F,$0F,$DC,$06,$0F,$00,$00,$30,$00,$00,$00,$00,$0F,$00,$00
  DEFB $65,$20,$00,$00,$00,$00,$30,$00,$30,$5F,$0F,$BC,$0F,$0F,$02,$02
  DEFB $26,$0F,$30,$00,$00,$0F,$74,$16,$0F,$65,$00,$00,$67,$0F,$7C,$0F
  DEFB $30,$00,$06,$0F,$0F,$0F,$02,$20,$00,$67,$06,$0F,$65,$0F,$0F,$0F
  DEFB $0F,$5F,$00,$00,$00,$20,$00,$40,$00,$00,$00,$30,$67,$0F,$40,$00
  DEFB $00,$99,$00,$00,$30,$00,$00,$D7,$00,$30,$00,$20,$0F,$65,$AD,$0F
  DEFB $26,$0F,$20,$30,$20,$65,$0F,$67,$0F,$0F,$C1,$0F,$0F,$0F,$0F,$0F
  DEFB $00,$30,$0F,$0F,$0F,$0F,$00,$00,$30,$06,$0F,$0F,$0F,$0F,$02,$02
  DEFB $00,$40,$40,$20,$00,$00,$40,$00,$00,$00,$20,$00,$00,$5F,$00,$DB
  DEFB $00,$00,$20,$00,$00,$00,$20,$00,$00,$40,$30,$20,$0F,$0F,$CB,$1F
  DEFB $26,$0F,$00,$20,$40,$02,$0F,$65,$0F,$30,$00,$00,$0F,$0F,$0F,$40
  DEFB $00,$67,$0F,$0F,$0F,$67,$00,$00,$00,$36,$99,$0F,$0F,$02,$42,$30
  DEFB $20,$20,$00,$00,$00,$67,$65,$0F,$02,$0F,$00,$00,$00,$0F,$00,$40
  DEFB $20,$06,$06,$99,$0F,$00,$30,$40,$00,$B3,$30,$40,$00,$0C,$0F,$0F
  DEFB $06,$0F,$99,$00,$40,$40,$99,$02,$67,$00,$00,$20,$67,$0F,$0F,$00
  DEFB $00,$0F,$0F,$5F,$02,$00,$30,$00,$0C,$0F,$0F,$DB,$12,$02,$12,$00
  DEFB $00,$00,$AD,$06,$06,$06,$0F,$CC,$65,$0F,$02,$00,$00,$0F,$40,$00
  DEFB $0F,$6B,$0F,$1F,$02,$65,$99,$5F,$00,$20,$00,$00,$00,$0F,$0F,$02
  DEFB $1F,$BC,$1F,$40,$00,$00,$00,$00,$00,$00,$00,$0F,$0F,$0F,$1F,$00
  DEFB $0F,$65,$1F,$0F,$02,$00,$20,$30,$0F,$0F,$5F,$0F,$0F,$02,$02,$00
  DEFB $00,$02,$65,$0F,$65,$06,$56,$67,$0F,$0F,$06,$16,$0F,$0F,$0F,$99
  DEFB $65,$1F,$0F,$0C,$06,$0F,$65,$CC,$67,$00,$00,$20,$06,$0F,$12,$67
  DEFB $5F,$0F,$0F,$0F,$00,$00,$30,$00,$00,$00,$00,$0F,$0F,$0F,$00,$00
  DEFB $0F,$0F,$0F,$0F,$40,$20,$00,$99,$0F,$0F,$02,$02,$02,$0F,$02,$00
  DEFB $00,$0F,$06,$A3,$0F,$65,$0F,$CB,$36,$06,$67,$0F,$0F,$61,$1F,$0F
  DEFB $06,$1F,$06,$02,$0F,$0B,$0F,$0F,$99,$0F,$06,$5F,$BC,$1F,$0F,$0F
  DEFB $0A,$99,$0F,$0F,$67,$5F,$0F,$0F,$1F,$CB,$0F,$0F,$0F,$0F,$67,$6B
  DEFB $0F,$0F,$1F,$AB,$6B,$00,$00,$67,$0F,$12,$12,$42,$12,$02,$0F,$1F
  DEFB $0F,$67,$0F,$1F,$74,$5F,$99,$0F,$0F,$DC,$46,$0F,$65,$0F,$0F,$02
  DEFB $0F,$0F,$0F,$0F,$65,$0F,$06,$0F,$06,$0F,$0F,$67,$40,$1F,$65,$0F

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
  DEFB $00,$00,$42,$02,$42,$02,$02,$02,$02,$07,$07,$07,$07,$07,$07,$07
  DEFB $07,$07,$07,$07,$47,$07,$07,$07,$00,$00,$47,$07,$07,$07,$08,$07
  DEFB $2C,$2C,$2C,$2C,$2C,$2C,$00,$00,$2C,$2C,$2C,$2C,$2C,$6C,$2C,$2C
  DEFB $2C,$00,$2D,$6D,$2D,$2D,$2D,$6D,$2D,$2D,$00,$00,$00,$2D,$2D,$2D
  DEFB $00,$02,$02,$02,$02,$02,$02,$02,$02,$02,$07,$07,$07,$47,$07,$01
  DEFB $01,$07,$07,$07,$07,$07,$07,$00,$00,$00,$00,$0B,$0B,$07,$07,$07
  DEFB $2C,$2C,$6C,$2C,$2C,$2C,$2C,$2C,$2C,$2C,$2C,$2D,$2D,$2D,$2E,$2D
  DEFB $2D,$2D,$2D,$2D,$2E,$2D,$2D,$2D,$2D,$2D,$2D,$00,$00,$2D,$2D,$6D
  DEFB $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$07,$07,$07,$01,$01
  DEFB $01,$01,$07,$07,$47,$07,$00,$00,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
  DEFB $2C,$2C,$2C,$2C,$2C,$2C,$2C,$2C,$2C,$2D,$2D,$2D,$2D,$2D,$2D,$2D
  DEFB $2D,$2D,$2D,$6D,$2D,$2D,$2E,$2D,$2D,$2D,$2D,$00,$00,$6D,$2D,$00
  DEFB $01,$01,$02,$02,$02,$02,$02,$02,$02,$02,$01,$01,$01,$07,$01,$01
  DEFB $01,$01,$09,$07,$07,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$4B,$0B,$0B
  DEFB $2C,$2C,$2C,$2C,$2C,$6C,$2C,$2C,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
  DEFB $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$00,$2D,$00,$00
  DEFB $01,$01,$01,$02,$01,$01,$02,$02,$02,$02,$01,$01,$01,$07,$07,$01
  DEFB $01,$07,$07,$0D,$0D,$0B,$0B,$0B,$0D,$0C,$0C,$0C,$4D,$0B,$0B,$0B
  DEFB $0B,$6C,$2C,$2C,$2C,$2C,$2C,$2C,$2C,$2C,$2D,$6D,$2D,$2D,$2D,$2D
  DEFB $2D,$2E,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2F,$00,$00,$00
  DEFB $01,$01,$01,$01,$01,$01,$01,$02,$01,$01,$01,$01,$01,$07,$07,$07
  DEFB $47,$07,$07,$0A,$0A,$0D,$0E,$0C,$0C,$0C,$0C,$0C,$0D,$0D,$4D,$0B
  DEFB $0B,$0B,$0B,$0B,$0B,$0B,$2C,$2C,$2C,$6C,$2C,$2D,$2D,$2D,$2D,$2D
  DEFB $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$00,$00
  DEFB $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$07,$07
  DEFB $07,$07,$07,$0A,$0A,$0A,$4D,$4D,$4D,$0D,$0D,$0D,$0D,$0D,$0D,$0D
  DEFB $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$2C,$2C,$2C,$2C,$2C,$2D,$2D,$2D
  DEFB $2D,$2D,$2D,$30,$2D,$2D,$2D,$30,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$00
  DEFB $03,$43,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
  DEFB $07,$07,$07,$07,$4A,$0A,$0A,$4D,$4D,$4D,$0D,$4D,$4D,$0F,$0D,$0D
  DEFB $0D,$0D,$0D,$0D,$0D,$31,$31,$0B,$0B,$71,$31,$2C,$2C,$2C,$2C,$2C
  DEFB $2D,$2D,$2D,$2D,$2D,$2D,$2D,$30,$30,$30,$2D,$30,$2D,$2F,$2F,$2D
  DEFB $03,$03,$01,$01,$41,$01,$01,$01,$01,$01,$01,$41,$41,$01,$01,$01
  DEFB $01,$07,$07,$07,$07,$0A,$0A,$0A,$0A,$0A,$4D,$4D,$0D,$0D,$10,$10
  DEFB $10,$10,$10,$10,$10,$10,$31,$31,$71,$31,$31,$31,$31,$32,$59,$19
  DEFB $59,$19,$30,$19,$19,$59,$30,$30,$30,$2F,$30,$30,$30,$30,$2D,$2D
  DEFB $03,$03,$43,$43,$43,$43,$43,$01,$01,$01,$41,$41,$01,$01,$41,$01
  DEFB $01,$07,$07,$07,$07,$07,$0A,$0A,$0A,$0A,$0A,$0A,$4D,$0D,$10,$10
  DEFB $10,$10,$10,$10,$10,$10,$10,$71,$31,$31,$31,$31,$32,$32,$32,$19
  DEFB $19,$19,$19,$19,$59,$19,$19,$30,$30,$30,$30,$70,$30,$30,$6D,$2D
  DEFB $03,$03,$03,$03,$03,$03,$03,$03,$01,$01,$01,$01,$01,$41,$41,$01
  DEFB $01,$05,$47,$07,$07,$07,$11,$4A,$0A,$0A,$0A,$0A,$0A,$0D,$10,$10
  DEFB $10,$10,$10,$10,$10,$10,$10,$10,$71,$31,$31,$32,$32,$32,$32,$32
  DEFB $19,$59,$19,$59,$19,$19,$32,$19,$30,$30,$30,$30,$30,$59,$19,$19
  DEFB $03,$03,$43,$43,$43,$43,$43,$03,$01,$01,$01,$01,$01,$41,$01,$01
  DEFB $01,$05,$05,$05,$07,$47,$11,$11,$11,$4A,$0A,$0A,$0A,$0D,$10,$10
  DEFB $10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$31,$32,$32,$32,$32,$32
  DEFB $32,$32,$19,$19,$32,$19,$59,$19,$30,$30,$30,$30,$19,$59,$19,$19
  DEFB $03,$03,$03,$03,$04,$04,$03,$01,$01,$01,$01,$01,$01,$01,$01,$01
  DEFB $05,$05,$05,$05,$05,$06,$06,$11,$11,$0A,$0A,$0A,$0A,$11,$10,$10
  DEFB $11,$11,$11,$10,$51,$10,$10,$10,$10,$32,$32,$32,$32,$32,$32,$32
  DEFB $32,$32,$32,$19,$19,$19,$19,$19,$30,$30,$30,$19,$19,$19,$30,$19
  DEFB $03,$03,$03,$04,$04,$04,$04,$04,$01,$01,$01,$01,$01,$01,$05,$05
  DEFB $45,$05,$05,$06,$06,$06,$06,$06,$06,$11,$0A,$0A,$11,$11,$11,$11
  DEFB $11,$11,$51,$11,$11,$11,$51,$11,$32,$32,$32,$19,$32,$32,$32,$32
  DEFB $32,$32,$32,$19,$19,$19,$19,$59,$59,$19,$19,$19,$19,$19,$19,$19
  DEFB $03,$03,$03,$04,$04,$04,$44,$04,$04,$05,$05,$05,$05,$05,$45,$05
  DEFB $05,$05,$06,$06,$06,$06,$06,$46,$11,$11,$11,$11,$11,$11,$11,$11
  DEFB $11,$11,$32,$32,$32,$32,$32,$32,$32,$32,$32,$32,$32,$32,$32,$19
  DEFB $59,$32,$32,$19,$19,$19,$19,$19,$19,$19,$19,$19,$59,$59,$19,$19
  DEFB $13,$13,$04,$44,$04,$04,$04,$04,$04,$05,$45,$05,$45,$05,$05,$05
  DEFB $05,$06,$06,$06,$46,$11,$11,$11,$11,$11,$11,$11,$11,$11,$11,$11
  DEFB $11,$11,$32,$32,$32,$72,$32,$32,$32,$32,$32,$32,$72,$32,$32,$59
  DEFB $19,$19,$19,$19,$32,$19,$19,$34,$19,$33,$19,$19,$19,$19,$19,$33
  DEFB $13,$13,$04,$04,$04,$12,$04,$44,$04,$04,$05,$05,$05,$05,$45,$05
  DEFB $06,$06,$06,$11,$11,$51,$11,$11,$11,$03,$11,$51,$11,$11,$11,$11
  DEFB $11,$11,$51,$32,$32,$32,$32,$32,$32,$32,$32,$32,$32,$32,$32,$32
  DEFB $19,$59,$19,$19,$59,$59,$19,$19,$19,$19,$59,$59,$34,$34,$34,$19
  DEFB $12,$13,$04,$04,$04,$04,$04,$04,$04,$04,$05,$05,$05,$05,$05,$06
  DEFB $06,$06,$06,$51,$11,$11,$11,$11,$11,$11,$11,$11,$11,$11,$11,$11
  DEFB $11,$11,$11,$32,$32,$32,$32,$32,$32,$32,$32,$32,$32,$32,$32,$32
  DEFB $59,$19,$19,$19,$19,$59,$59,$19,$33,$19,$19,$34,$34,$34,$34,$19
  DEFB $13,$13,$04,$04,$04,$04,$04,$04,$04,$04,$04,$05,$05,$05,$05,$05
  DEFB $06,$06,$06,$11,$11,$11,$51,$11,$11,$11,$11,$11,$11,$11,$11,$11
  DEFB $11,$51,$11,$32,$32,$32,$32,$32,$32,$32,$32,$32,$32,$32,$32,$32
  DEFB $32,$19,$59,$59,$59,$19,$59,$59,$34,$34,$34,$33,$34,$34,$34,$34
  DEFB $13,$12,$12,$04,$04,$13,$13,$04,$04,$05,$05,$05,$05,$05,$05,$06
  DEFB $06,$06,$06,$11,$11,$11,$11,$11,$11,$11,$11,$11,$11,$10,$11,$11
  DEFB $51,$11,$51,$11,$11,$11,$32,$32,$32,$32,$32,$32,$59,$59,$32,$32
  DEFB $32,$19,$19,$19,$19,$19,$19,$19,$19,$34,$34,$34,$34,$34,$34,$34
  DEFB $13,$12,$12,$12,$04,$13,$13,$13,$13,$13,$05,$05,$14,$14,$46,$06
  DEFB $06,$06,$06,$11,$11,$11,$11,$11,$11,$11,$11,$11,$11,$11,$11,$11
  DEFB $11,$51,$11,$51,$11,$51,$32,$32,$32,$32,$32,$11,$11,$59,$19,$19
  DEFB $19,$59,$19,$19,$19,$19,$19,$19,$34,$34,$34,$34,$34,$34,$34,$34
  DEFB $13,$53,$12,$12,$12,$13,$13,$53,$13,$13,$14,$14,$14,$14,$14,$14
  DEFB $06,$06,$06,$06,$11,$11,$11,$11,$11,$11,$11,$11,$11,$11,$11,$11
  DEFB $11,$11,$51,$11,$51,$11,$11,$32,$32,$32,$51,$11,$11,$11,$11,$59
  DEFB $19,$19,$19,$19,$19,$19,$19,$34,$34,$34,$34,$34,$34,$34,$34,$34
  DEFB $13,$13,$12,$12,$12,$13,$13,$13,$13,$14,$14,$14,$14,$14,$14,$14
  DEFB $14,$06,$06,$06,$11,$11,$11,$11,$11,$11,$11,$11,$11,$11,$11,$11
  DEFB $51,$11,$11,$51,$11,$11,$11,$11,$11,$11,$11,$11,$11,$11,$59,$19
  DEFB $19,$19,$19,$19,$19,$36,$3F,$34,$34,$34,$34,$34,$34,$19,$34,$34
  DEFB $13,$13,$04,$12,$12,$13,$13,$13,$13,$14,$14,$14,$17,$14,$14,$14
  DEFB $14,$14,$06,$15,$06,$11,$11,$11,$11,$11,$11,$11,$11,$11,$11,$11
  DEFB $11,$11,$11,$11,$51,$11,$11,$51,$11,$11,$11,$51,$19,$19,$19,$19
  DEFB $19,$19,$19,$36,$36,$36,$36,$36,$34,$34,$34,$34,$34,$34,$37,$77
  DEFB $13,$13,$12,$12,$53,$13,$13,$13,$13,$14,$14,$14,$17,$14,$14,$14
  DEFB $14,$06,$06,$06,$06,$15,$15,$15,$15,$15,$15,$15,$11,$11,$11,$11
  DEFB $11,$11,$51,$11,$51,$11,$11,$11,$11,$51,$19,$19,$19,$19,$19,$19
  DEFB $36,$36,$36,$36,$36,$36,$3F,$36,$76,$34,$34,$34,$77,$37,$77,$37
  DEFB $13,$53,$12,$12,$12,$13,$13,$18,$13,$13,$14,$14,$14,$14,$14,$14
  DEFB $06,$06,$06,$46,$15,$15,$15,$15,$15,$15,$15,$15,$15,$15,$11,$11
  DEFB $51,$15,$15,$11,$51,$51,$11,$11,$51,$19,$19,$19,$19,$19,$36,$36
  DEFB $36,$36,$36,$76,$36,$36,$36,$76,$36,$36,$37,$37,$37,$37,$37,$37
  DEFB $13,$12,$12,$12,$13,$13,$53,$18,$18,$13,$13,$14,$14,$14,$14,$46
  DEFB $17,$15,$15,$15,$15,$15,$15,$15,$15,$15,$15,$15,$15,$15,$15,$15
  DEFB $15,$15,$15,$11,$11,$11,$11,$19,$19,$19,$19,$19,$38,$36,$37,$37
  DEFB $37,$37,$37,$37,$36,$36,$76,$36,$76,$36,$37,$37,$37,$37,$77,$34
  DEFB $13,$12,$12,$12,$13,$13,$18,$18,$18,$18,$13,$14,$14,$14,$14,$14
  DEFB $15,$16,$15,$15,$15,$15,$56,$16,$15,$16,$15,$15,$15,$15,$15,$15
  DEFB $15,$15,$56,$16,$16,$11,$19,$19,$19,$19,$19,$38,$78,$37,$37,$37
  DEFB $37,$37,$37,$37,$37,$37,$37,$37,$37,$37,$77,$37,$37,$37,$34,$34
  DEFB $13,$13,$12,$12,$13,$13,$18,$18,$18,$18,$13,$14,$14,$14,$14,$56
  DEFB $16,$16,$16,$16,$16,$56,$16,$16,$16,$16,$16,$16,$15,$15,$15,$16
  DEFB $16,$16,$16,$16,$19,$19,$19,$19,$19,$19,$78,$38,$38,$37,$37,$37
  DEFB $37,$77,$37,$37,$37,$37,$37,$37,$37,$37,$77,$37,$77,$37,$37,$34
  DEFB $13,$53,$53,$53,$13,$13,$18,$18,$18,$18,$13,$14,$14,$14,$14,$16
  DEFB $16,$16,$14,$14,$16,$16,$16,$16,$15,$16,$16,$16,$16,$16,$56,$16
  DEFB $16,$16,$19,$19,$19,$19,$19,$19,$78,$38,$38,$38,$37,$37,$37,$37
  DEFB $37,$37,$37,$37,$37,$37,$37,$37,$37,$37,$37,$37,$37,$37,$37,$39
  DEFB $13,$13,$13,$13,$13,$13,$18,$13,$18,$18,$13,$13,$14,$14,$14,$56
  DEFB $16,$14,$14,$14,$14,$14,$56,$16,$16,$56,$19,$19,$19,$19,$19,$19
  DEFB $19,$19,$19,$19,$19,$19,$19,$38,$38,$78,$38,$37,$37,$37,$37,$37
  DEFB $37,$37,$37,$37,$37,$37,$37,$37,$37,$37,$37,$37,$37,$3B,$37,$37
  DEFB $13,$13,$13,$18,$13,$13,$18,$18,$18,$18,$13,$13,$14,$14,$14,$14
  DEFB $14,$14,$14,$14,$14,$14,$16,$16,$16,$19,$19,$19,$19,$19,$19,$19
  DEFB $19,$19,$19,$19,$19,$19,$78,$38,$38,$38,$38,$78,$37,$37,$37,$37
  DEFB $37,$37,$37,$37,$37,$37,$37,$79,$39,$39,$79,$39,$39,$39,$3A,$79
  DEFB $13,$13,$13,$18,$18,$13,$18,$18,$18,$18,$13,$13,$13,$14,$14,$14
  DEFB $14,$14,$14,$14,$14,$56,$16,$56,$19,$19,$19,$19,$19,$19,$19,$19
  DEFB $19,$19,$19,$19,$78,$38,$38,$38,$38,$38,$38,$38,$38,$38,$38,$38
  DEFB $38,$38,$78,$39,$39,$39,$39,$39,$39,$39,$39,$79,$79,$39,$79,$39
  DEFB $13,$13,$53,$18,$18,$13,$18,$18,$18,$18,$18,$13,$13,$14,$14,$14
  DEFB $14,$14,$14,$1B,$1B,$1B,$1B,$1B,$19,$19,$1B,$1B,$1B,$1B,$1B,$1B
  DEFB $1B,$1B,$38,$38,$38,$38,$38,$1C,$38,$38,$38,$78,$38,$38,$38,$78
  DEFB $38,$3B,$39,$39,$79,$39,$39,$79,$39,$79,$39,$39,$39,$39,$79,$39
  DEFB $18,$18,$18,$18,$18,$13,$13,$18,$18,$18,$18,$18,$18,$18,$18,$14
  DEFB $1B,$1B,$1B,$1B,$1B,$1B,$1B,$1B,$1B,$1B,$1B,$1B,$1B,$1B,$5B,$1B
  DEFB $1B,$1B,$38,$78,$78,$38,$38,$38,$38,$38,$38,$38,$3B,$3B,$38,$1C
  DEFB $38,$38,$39,$39,$39,$39,$39,$39,$39,$39,$39,$3A,$39,$39,$39,$39
  DEFB $18,$18,$18,$18,$18,$18,$13,$18,$18,$18,$18,$18,$18,$18,$1B,$1B
  DEFB $1B,$1B,$1B,$1B,$1B,$1B,$1B,$1B,$1B,$1B,$1B,$1B,$1B,$1B,$1B,$1B
  DEFB $1B,$1C,$1C,$1C,$38,$38,$38,$78,$38,$78,$38,$38,$7B,$3B,$3B,$3B
  DEFB $3B,$3B,$39,$79,$39,$39,$3A,$39,$39,$39,$39,$39,$39,$39,$79,$39
  DEFB $18,$18,$18,$18,$18,$18,$18,$18,$18,$18,$1A,$1A,$1A,$1A,$1B,$1A
  DEFB $1A,$1B,$1B,$1B,$1B,$1B,$1B,$1B,$1B,$1B,$1B,$1B,$1B,$1B,$1B,$1C
  DEFB $1C,$1C,$1C,$1C,$1C,$1C,$1C,$1C,$1C,$38,$78,$38,$3B,$3B,$3B,$3B
  DEFB $3B,$3B,$7B,$3B,$3B,$79,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39
  DEFB $18,$18,$18,$18,$18,$18,$18,$18,$18,$1A,$1A,$1A,$1A,$1A,$1A,$1A
  DEFB $1B,$1B,$1B,$1B,$1B,$1B,$1B,$1B,$1B,$1B,$1B,$1B,$1B,$1B,$1C,$1C
  DEFB $1C,$1C,$1C,$1C,$1C,$1C,$1C,$1C,$1C,$38,$38,$38,$3B,$3B,$3B,$3B
  DEFB $3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$39,$39,$39,$39,$39,$39,$39,$39
  DEFB $00,$18,$18,$18,$18,$18,$18,$18,$1A,$1A,$1A,$1A,$1A,$1A,$1A,$1A
  DEFB $1A,$1B,$1B,$1B,$1B,$1B,$1B,$1B,$1B,$1B,$1B,$1B,$1B,$5C,$1C,$1C
  DEFB $1C,$1C,$1C,$1C,$1C,$1C,$1C,$3D,$3D,$3D,$3D,$3D,$3B,$3B,$3B,$3B
  DEFB $3B,$7B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$39,$39,$39,$79,$3C,$3C
  DEFB $00,$18,$18,$18,$18,$18,$18,$1A,$1A,$1A,$1A,$1A,$1A,$1A,$1A,$1A
  DEFB $1A,$1B,$1B,$5B,$1B,$1B,$1B,$1B,$1B,$1B,$1B,$5B,$1B,$1C,$1C,$1C
  DEFB $1C,$1C,$1C,$1C,$1C,$1C,$3D,$3D,$1C,$3D,$1C,$3D,$3D,$3D,$3B,$7B
  DEFB $3B,$3B,$3B,$3B,$3B,$7B,$7B,$7B,$7B,$3B,$7B,$3C,$3C,$3C,$3C,$3C
  DEFB $00,$18,$18,$18,$18,$18,$18,$58,$1A,$1A,$1A,$1A,$20,$20,$20,$1A
  DEFB $1B,$1B,$1B,$1B,$1B,$1B,$5B,$1B,$1B,$5B,$21,$21,$21,$1C,$1C,$1C
  DEFB $1C,$1C,$1C,$1C,$1C,$7D,$3D,$7D,$3D,$3D,$3D,$3D,$3D,$3D,$3D,$3D
  DEFB $7D,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3B,$3C,$3C,$3C,$3C,$3C,$3C
  DEFB $18,$18,$18,$1D,$1D,$18,$18,$18,$1A,$1A,$1A,$20,$1A,$1A,$1A,$1A
  DEFB $1A,$1B,$20,$1B,$5F,$1F,$1F,$1F,$21,$21,$21,$21,$21,$1C,$1C,$1C
  DEFB $1C,$1C,$1C,$5C,$1C,$3D,$3D,$3D,$3D,$3D,$7D,$3D,$7D,$7D,$3D,$3D
  DEFB $3D,$3D,$3D,$3B,$7B,$3B,$3B,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C
  DEFB $18,$18,$1D,$1D,$1D,$1D,$18,$18,$18,$1A,$1A,$1A,$1A,$1A,$1A,$1A
  DEFB $1B,$20,$1B,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$21,$22,$21,$21,$21
  DEFB $1C,$1C,$1C,$1C,$3D,$3D,$3D,$3D,$3D,$3D,$3D,$3D,$3D,$3D,$3D,$3D
  DEFB $3D,$7D,$3D,$3D,$3B,$3B,$3E,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C
  DEFB $1D,$1D,$1D,$1D,$1D,$1D,$18,$18,$18,$18,$1A,$1A,$1A,$1A,$1A,$1A
  DEFB $1B,$1F,$1F,$5F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$61,$21,$61,$21
  DEFB $21,$61,$3D,$3D,$3D,$3D,$3D,$3D,$3D,$3D,$3D,$3D,$3D,$3D,$7D,$3D
  DEFB $7D,$3D,$3D,$3D,$3E,$3E,$3E,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C
  DEFB $1D,$1D,$1D,$1D,$1D,$1D,$1D,$18,$18,$18,$18,$1A,$1A,$1A,$1E,$1E
  DEFB $1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$22,$21,$21
  DEFB $21,$21,$3D,$3D,$3D,$3D,$3D,$3D,$3D,$7D,$3D,$3D,$3D,$3D,$3D,$3D
  DEFB $3D,$3D,$7D,$3E,$3E,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C
  DEFB $1D,$1D,$1D,$1D,$1D,$1D,$1D,$1D,$18,$18,$18,$1E,$1E,$1E,$1E,$1E
  DEFB $1E,$1E,$1E,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$5F,$1F,$1F,$21,$22,$61
  DEFB $21,$21,$7D,$3D,$3D,$3D,$3D,$7D,$3D,$3D,$3D,$3D,$3D,$3D,$7D,$3D
  DEFB $3E,$3E,$3E,$3E,$3E,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C
  DEFB $1D,$1D,$5D,$1D,$1D,$1D,$1D,$1D,$1D,$1D,$1E,$1E,$5E,$1E,$1F,$1E
  DEFB $1E,$24,$24,$23,$25,$25,$5F,$1F,$1F,$1F,$1F,$1F,$21,$1F,$23,$23
  DEFB $21,$21,$21,$3D,$7D,$3D,$3D,$3D,$29,$3D,$7D,$3D,$3D,$3D,$3D,$3D
  DEFB $3D,$3E,$3E,$3E,$7E,$3E,$7E,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C
  DEFB $1D,$1D,$1D,$1D,$1D,$1D,$1D,$1D,$1D,$1D,$1E,$1E,$1E,$1E,$1E,$1E
  DEFB $1E,$24,$24,$25,$25,$25,$25,$25,$1F,$1F,$1F,$25,$25,$23,$23,$23
  DEFB $28,$68,$28,$28,$28,$68,$68,$29,$29,$29,$2B,$2B,$6B,$3D,$2B,$3D
  DEFB $7E,$3E,$3E,$3E,$3E,$3E,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$3F,$3C,$3C
  DEFB $1D,$1D,$1D,$1D,$1D,$1D,$1D,$1D,$1D,$1D,$1D,$1E,$1E,$1E,$5E,$1E
  DEFB $1E,$24,$24,$24,$25,$25,$25,$25,$25,$24,$25,$25,$23,$23,$23,$23
  DEFB $28,$28,$28,$68,$68,$29,$29,$29,$29,$29,$2B,$2B,$2B,$3D,$6B,$2B
  DEFB $7E,$3E,$3E,$3E,$3E,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C,$3C
  DEFB $1D,$1D,$1D,$5D,$1D,$1D,$1D,$1D,$1D,$1D,$1D,$1D,$1E,$1E,$1E,$1E
  DEFB $5E,$24,$24,$24,$24,$25,$25,$25,$25,$25,$25,$23,$23,$23,$23,$28
  DEFB $28,$28,$68,$29,$29,$29,$29,$29,$29,$29,$2B,$2B,$2B,$2B,$2B,$2B
  DEFB $2B,$7E,$3E,$3E,$7E,$3C,$3C,$3C,$3E,$3E,$3C,$3C,$3C,$3C,$3C,$3C
  DEFB $1D,$5D,$1D,$1D,$1D,$1D,$1D,$1D,$1D,$1D,$1D,$1D,$1E,$1E,$5E,$1E
  DEFB $24,$24,$24,$25,$25,$25,$25,$25,$25,$25,$23,$23,$23,$28,$28,$28
  DEFB $28,$29,$29,$29,$29,$29,$29,$29,$69,$29,$2B,$2B,$2B,$2B,$2B,$6B
  DEFB $2B,$2B,$3E,$3E,$7E,$3E,$3E,$3E,$3E,$3E,$3E,$3C,$3C,$3C,$3C,$3C
  DEFB $1D,$1D,$1D,$1D,$1D,$1D,$1D,$1D,$1D,$1D,$1D,$1D,$1D,$1E,$1E,$1E
  DEFB $24,$24,$24,$25,$25,$65,$25,$25,$25,$25,$23,$23,$28,$28,$23,$28
  DEFB $29,$29,$29,$29,$29,$29,$29,$29,$29,$29,$69,$2B,$2B,$2B,$2B,$2B
  DEFB $2B,$2B,$7E,$7E,$7E,$3E,$3E,$3E,$7E,$3E,$3C,$3C,$3C,$3E,$3C,$3C
  DEFB $1D,$1D,$1D,$1D,$1D,$26,$26,$66,$26,$26,$1D,$1D,$1D,$1E,$1E,$1E
  DEFB $24,$24,$24,$25,$25,$25,$25,$25,$65,$23,$23,$23,$28,$28,$28,$29
  DEFB $29,$29,$29,$69,$29,$69,$69,$69,$29,$2B,$2B,$2B,$2B,$2B,$6B,$2B
  DEFB $2B,$2B,$2B,$2B,$2B,$3E,$3E,$3E,$3E,$3E,$3C,$3C,$3E,$3C,$3C,$3C
  DEFB $1D,$1D,$1D,$1D,$1D,$66,$26,$27,$26,$26,$1D,$1D,$1D,$1E,$1E,$1E
  DEFB $24,$24,$25,$25,$25,$25,$25,$25,$23,$23,$23,$28,$28,$28,$28,$28
  DEFB $28,$28,$29,$69,$29,$29,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B
  DEFB $6B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$3E,$3E,$7E,$3E,$3E,$3C,$3C
  DEFB $1D,$1D,$1D,$1D,$1D,$26,$27,$26,$26,$66,$1D,$1D,$5E,$1E,$5E,$1E
  DEFB $24,$24,$25,$25,$25,$25,$25,$23,$23,$23,$28,$28,$28,$28,$28,$28
  DEFB $28,$28,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$6B,$2B,$2B,$2B
  DEFB $2B,$6B,$2B,$2B,$2B,$2B,$2B,$6B,$2B,$2B,$2B,$2B,$3E,$7E,$3E,$3E
  DEFB $1D,$1D,$1D,$1D,$1D,$66,$26,$26,$26,$26,$1E,$1E,$1E,$1E,$1E,$1E
  DEFB $24,$24,$25,$25,$25,$25,$23,$23,$23,$28,$28,$28,$28,$28,$2A,$2A
  DEFB $2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$6B
  DEFB $2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$3E,$3E,$7E,$3E
  DEFB $1D,$1D,$1D,$1D,$1D,$26,$26,$66,$26,$1D,$1D,$1D,$1E,$1E,$1E,$24
  DEFB $24,$24,$25,$25,$25,$65,$23,$23,$23,$28,$23,$28,$28,$2A,$2A,$2B
  DEFB $2B,$2B,$2B,$2B,$2B,$6B,$6B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B
  DEFB $2B,$2B,$2B,$6B,$2B,$2B,$2B,$2B,$2B,$6B,$2B,$2B,$2B,$7E,$3E,$3E
  DEFB $1D,$1D,$5D,$1D,$1D,$1D,$66,$26,$66,$1D,$1D,$1D,$5E,$1E,$1E,$24
  DEFB $24,$25,$25,$25,$25,$23,$23,$23,$2A,$28,$28,$28,$2A,$2A,$2A,$2B
  DEFB $2B,$2B,$2B,$2B,$2B,$2B,$2B,$6B,$6B,$2B,$2B,$2B,$2B,$2B,$2B,$2B
  DEFB $2B,$6B,$2B,$2B,$2B,$6B,$6B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$2B
  DEFB $1D,$5D,$1D,$1D,$1D,$1D,$1D,$1D,$1D,$1D,$1D,$1E,$1E,$1E,$1E,$24
  DEFB $25,$65,$25,$25,$25,$23,$23,$23,$28,$28,$28,$28,$28,$2A,$2A,$2B
  DEFB $2B,$2B,$6B,$2B,$6B,$2B,$2B,$6B,$2B,$2B,$2B,$2B,$2B,$2B,$2B,$6B
  DEFB $6B,$2B,$2B,$6B,$2B,$2B,$6B,$6B,$6B,$2B,$2B,$2B,$2B,$2B,$2B,$6B
  DEFB $1D,$1D,$1D,$1D,$1D,$1D,$1D,$1D,$1D,$1D,$1D,$1E,$1E,$1E,$24,$24
  DEFB $25,$25,$25,$25,$23,$23,$23,$28,$28,$28,$2A,$2A,$2A,$28,$2A,$2B
  DEFB $2B,$2B,$2B,$6B,$2B,$6B,$2B,$6B,$2B,$2B,$6B,$2B,$2B,$35,$2B,$2B
  DEFB $2B,$2B,$2B,$2B,$2B,$6B,$2B,$2B,$6B,$2B,$2B,$2B,$6B,$2B,$2B,$2B
  DEFB $00,$5D,$1D,$1D,$5D,$1E,$1E,$1E,$1E,$5E,$1E,$1E,$1E,$1E,$65,$24
  DEFB $25,$25,$25,$25,$23,$23,$23,$28,$28,$2A,$2A,$2A,$2A,$2A,$2B,$2B
  DEFB $2B,$2A,$2B,$2B,$2B,$2B,$6B,$2B,$2B,$6B,$2B,$2B,$6B,$2B,$2B,$2B
  DEFB $2B,$2B,$2B,$2B,$6B,$2B,$2B,$2B,$2B,$2B,$2B,$6B,$2B,$2B,$6B,$2B

CheckLocBreakCrown:
  LD A,B
  CP H
  RET NZ
  LD A,C
  CP L
  RET NZ
  LD A,$01
  LD (IceCrownFlag),A
  RET

FindSpecificChars:
  LD A,$02
FindSpecificChars_0:
  LD (TempCharacterNo),A
  PUSH BC
  CALL CopyCharDetails
  POP BC
  LD A,(CharAvailable)
  CP B
  JR NZ,FindSpecificChars_1
  XOR $02
  LD (CharAvailable),A
  PUSH BC
  CALL SaveCharDetails
  POP BC
FindSpecificChars_1:
  LD A,(TempCharacterNo)
  INC A
  CP $20
  JR NZ,FindSpecificChars_0
  RET

CheckSpecialConditions:
  CALL DoWindowFive
  XOR A
  LD (LuxorMorkinFlag),A
  LD (IceCrownFlag),A
  LD (TempCharacterNo),A  ; Check Luxor
  CALL CopyCharDetails
  LD A,(CharLifeStatus)
  CP $00                  ; Is He Dead?
  JR NZ,CheckSpecialConditions_0 ; Yes
  INC A
  LD (LuxorMorkinFlag),A  ; Set Flag to say Luxor is dead.
  LD A,(CharObjectCarrying)
  CP $0F                  ; Was luxor carrying the Moon Ring?
  JR NZ,CheckSpecialConditions_0 ; No
  XOR A
  LD (CharObjectCarrying),A ; Drop Moon Ring.
  CALL SaveCharDetails
  LD HL,(CharLocation)
  LD (WorkingLocation),HL
  CALL CalcMapLocation
  LD A,$0F
  LD (LocationObject),A   ; Put Moon Ring in current Location
  CALL AlterLocationContents
  LD B,$01                ; Toggle all commanded Lords
  CALL FindSpecificChars  ; as we can't use them
CheckSpecialConditions_0:
  LD A,$01
  LD (TempCharacterNo),A  ; Check Morkin
  CALL CopyCharDetails
  LD A,(CharLifeStatus)
  CP $00                  ; Is he Dead?
  JR NZ,CheckSpecialConditions_1 ; Yes
  LD A,(LuxorMorkinFlag)  ; Set Flag to Say so
  XOR $02
  LD (LuxorMorkinFlag),A
  JR CheckGameOver
CheckSpecialConditions_1:
  LD A,(CharObjectCarrying)
  CP $0F                  ; Is Morkin carrying the Moon Ring?
  JR NZ,CheckSpecialConditions_2
  LD B,$03                ; Toggle All Commanded Lords
  CALL FindSpecificChars  ; so we can use them
  JR CheckGameOver
CheckSpecialConditions_2:
  CP $0E                  ; Has Morkin got the Ice Crown
  JR NZ,CheckGameOver     ; Yes
  LD BC,(CharLocation)    ; Is he at Lake Mirrow? Location is hard-wired to
  LD HL,$1209             ; $1209
  CALL CheckLocBreakCrown
  LD A,$1D                ; Check Fawkrin,Lorgrim,Farlame
CheckSpecialConditions_3:
  LD (TempCharacterNo),A
  PUSH BC
  CALL CopyCharDetails
  POP BC
  LD A,(CharLifeStatus)
  CP $00                  ; Character still alive?
  JR Z,CheckSpecialConditions_4 ; If not then next character
  LD HL,(CharLocation)    ; Check if character is at
  CALL CheckLocBreakCrown ; the same location as the Crown!
CheckSpecialConditions_4:
  LD A,(TempCharacterNo)
  INC A
  CP $20                  ; Last Character?
  JR NZ,CheckSpecialConditions_3 ; Loop if not
CheckGameOver:
  LD A,(LuxorMorkinFlag)
  CP $03                  ; Luxor & Morkin Dead
  JR Z,LuxorIsDead
  CP $02                  ; Morkin Dead
  JR NZ,CheckSpecialConditions_5
  LD A,$60                ; Army at Xajorkith
  LD (Army_Details),A
  CALL GetArmyDetails     ; Get the army
  LD A,(WhoseRaceIsArmy)
  CP $00                  ; Is the army DoomGuard?
  JR Z,XajorkithFallen    ; If so then Xajorkith has fallen
CheckSpecialConditions_5:
  LD A,$06                ; Army at Ushgarak
  LD (Army_Details),A
  CALL GetArmyDetails     ; Get the army
  LD A,(WhoseRaceIsArmy)
  CP $00                  ; Is the army DoomGuard
  JR NZ,UshgarakFallen    ; If not then Ushgarak has fallen
  LD A,(IceCrownFlag)
  CP $00                  ; Check if the Ice Crown is still in the game!
  JR NZ,IceCrownDestroyed
  RET
LuxorIsDead:
  CALL Bytes_Print_Buffer
  DEFB $FC,$72,$70,$08,$FF ; 'Luxor Is Dead'
  JR MorkinIsDead
XajorkithFallen:
  CALL Bytes_Print_Buffer
  DEFB $FC,$35,$8A,$AB,$FF ; 'Xajorkith Has Fallen'
MorkinIsDead:
  CALL Bytes_Print_Buffer
  DEFB $87,$FC,$73,$70,$08,$FE,$2E ; 'And Morkin Is Dead.'
  DEFB $FC,$CA,$5C,$FC,$0C,$FD,$A0 ; 'Victory To DoomDark.'
  DEFB $FE,$21,$FF
  JP EndOfGame
UshgarakFallen:
  CALL Bytes_Print_Buffer
  DEFB $FC,$0F,$8A,$AB,$FF ; 'Ushgarak Has Fallen'
  JR DoVictoryMessage
IceCrownDestroyed:
  CALL Bytes_Print_Buffer
  DEFB $FC,$00,$FC,$9B    ; 'The Ice'
  DEFB $FC,$EA,$8A,$8B    ; 'Crown Has Been'
  DEFB $EB,$FE,$65,$FE,$64,$FF ; 'Destroyed'
DoVictoryMessage:
  CALL Bytes_Print_Buffer
  DEFB $FE,$2E,$FC,$CA,$5C,$00 ; '.Victory To The'
  DEFB $FC,$9F,$FE,$21,$FF ; 'Free!'
EndOfGame:
  CALL FlushPrintBuffer
  CALL CopyScreen
CheckSpecialConditions_6:
  CALL CheckKeyCase
  CP $64                  ; 'd' (K_Load)
  JR NZ,CheckSpecialConditions_6
  POP HL                  ; Change current RET address on stack with the "force
  LD HL,ForceLoad         ; load" address
  PUSH HL                 ;
  RET

; ClearScreenBlack
DoWindowFive:
  LD BC,$0000
  LD D,$20
  LD H,$18
  LD A,$03
  LD (Print_Attr),A
  XOR A
  LD (Print_Mask),A
  OUT ($FE),A
  CALL ClearWindow
  CALL DefineViewPoint
  DEFB $00,$00,$00,$1F,$03,$00
  RET

LuxorMorkinFlag:
  DEFB $00

IceCrownFlag:
  DEFB $00

L8FF9:
  DEFB $2B,$2B,$6B,$2B,$2B,$2B,$2B

;
; Start of Terrain Graphics
;

; Terrain data
TerrainMountain1:
  DEFB $4E,$41,$00,$7F,$C9,$4B,$43,$01,$7E,$02,$0F,$48,$44,$03,$7D,$04
  DEFB $10,$47,$7C,$42,$05,$7B,$11,$46,$43,$06,$7A,$11,$46,$4A,$44,$07
  DEFB $79,$12,$1E,$46,$4A,$45,$08,$79,$13,$1F,$46,$4B,$F4,$75,$45,$09
  DEFB $78,$13,$A0,$21,$C4,$45,$4B,$F2,$73,$45,$0A,$78,$14,$22,$C2,$43
  DEFB $4B,$71,$45,$0B,$77,$14,$22,$41,$CC,$4D,$71,$47,$0C,$77,$15,$22
  DEFB $40,$4E,$65,$70,$F5,$76,$47,$0D,$74,$96,$1A,$23,$40,$C3,$44,$4E
  DEFB $65,$70,$47,$0E,$73,$1B,$23,$3F,$C5,$46,$4E,$65,$70,$47,$0F,$73
  DEFB $9C,$1D,$24,$3E,$47,$4E,$65,$70,$47,$0F,$72,$9E,$1F,$25,$3D,$47
  DEFB $4E,$65,$70,$47,$10,$72,$A0,$22,$25,$3C,$48,$4E,$65,$70,$46,$10
  DEFB $72,$A3,$25,$3C,$49,$4F,$65,$6F,$47,$11,$72,$92,$13,$25,$BA,$3B
  DEFB $4A,$4F,$65,$6F,$48,$12,$72,$14,$26,$39,$4B,$4F,$63,$65,$EF,$71
  DEFB $47,$12,$6F,$15,$26,$B6,$38,$4C,$4F,$63,$65,$47,$13,$6F,$96,$17
  DEFB $26,$35,$4C,$50,$63,$65,$47,$13,$6F,$18,$27,$35,$4C,$51,$63,$65
  DEFB $47,$14,$6F,$19,$27,$34,$4C,$51,$62,$65,$47,$14,$6F,$19,$28,$33
  DEFB $4C,$51,$62,$65,$47,$15,$6E,$1A,$A9,$2D,$32,$4D,$51,$62,$66,$47
  DEFB $15,$6E,$9B,$1C,$AE,$2F,$31,$4D,$51,$62,$66,$46,$16,$6E,$1D,$30
  DEFB $4D,$51,$62,$66,$45,$16,$6E,$1D,$4E,$52,$62,$66,$45,$16,$6E,$1D
  DEFB $4E,$52,$61,$67,$45,$17,$6E,$1D,$4E,$53,$61,$67,$45,$17,$6D,$1E
  DEFB $4E,$53,$60,$67,$45,$18,$6D,$1E,$4E,$54,$60,$67,$45,$18,$6D,$1F
  DEFB $4F,$55,$60,$67,$44,$18,$6D,$1F,$50,$D5,$5F,$E4,$6C,$43,$18,$6B
  DEFB $20,$D1,$54,$63,$43,$19,$6A,$20,$51,$E0,$62,$44,$19,$69,$21,$50
  DEFB $DE,$5F,$E6,$68,$43,$1A,$65,$A2,$23,$4F,$E3,$64,$43,$1B,$62,$24
  DEFB $4F,$E0,$61,$43,$1C,$61,$25,$4F,$DE,$5F,$44,$1D,$61,$1E,$25,$4F
  DEFB $DC,$5D,$45,$1F,$60,$A0,$22,$26,$4E,$DA,$5B,$5F,$43,$23,$5E,$A4
  DEFB $26,$4E,$59,$42,$26,$5E,$4D,$58,$42,$26,$5D,$4D,$57,$42,$27,$5D
  DEFB $4D,$56,$42,$27,$5C,$4D,$55,$43,$27,$5C,$B5,$37,$4C,$54,$43,$28
  DEFB $5C,$38,$4C,$53,$43,$28,$5B,$29,$B9,$3B,$4C,$42,$2A,$5A,$3C,$4C
  DEFB $42,$2B,$5A,$3D,$59,$42,$2B,$5A,$3D,$D7,$58,$43,$2B,$59,$2C,$3E
  DEFB $D5,$56,$42,$2D,$59,$3F,$54,$43,$2E,$58,$AF,$33,$40,$54,$43,$31
  DEFB $57,$34,$41,$53,$43,$32,$57,$B5,$36,$41,$53,$43,$32,$57,$B7,$3A
  DEFB $42,$52,$44,$33,$57,$34,$3B,$43,$51,$43,$34,$56,$3B,$44,$51,$44
  DEFB $35,$56,$36,$3C,$45,$50,$42,$36,$56,$3C,$46,$42,$37,$55,$3C,$47
  DEFB $42,$37,$54,$3D,$47,$42,$38,$53,$3E,$47,$42,$38,$52,$3F,$48,$43
  DEFB $39,$51,$3A,$40,$C9,$4B,$42,$3B,$50,$40,$CC,$4F,$41,$3C,$4E,$3D
  DEFB $40,$3E,$4D,$41,$3F,$4C,$CA,$4B,$40,$40,$49,$40,$40,$49,$41,$41
  DEFB $48,$42,$40,$43,$47,$40,$44,$46,$40,$45,$45
TerrainMountain2:
  DEFB $37,$41,$13,$6C,$C6,$48,$44,$14,$6B,$95,$16,$1E,$45,$6A,$42,$17
  DEFB $69,$1F,$44,$43,$17,$68,$1F,$44,$47,$45,$18,$68,$20,$A8,$29,$44
  DEFB $47,$E4,$65,$45,$19,$67,$20,$2A,$43,$48,$63,$45,$1A,$66,$21,$2B
  DEFB $C1,$42,$49,$62,$46,$1B,$65,$22,$2B,$40,$4A,$5A,$61,$48,$1C,$64
  DEFB $1D,$A3,$26,$2C,$3F,$C2,$44,$4A,$5A,$61,$47,$1E,$64,$27,$2C,$3E
  DEFB $45,$4A,$5A,$61,$47,$1E,$63,$28,$2D,$3E,$45,$4A,$5A,$61,$46,$1E
  DEFB $63,$A9,$2D,$3D,$46,$4A,$5A,$61,$46,$1F,$63,$2D,$3C,$47,$4A,$5A
  DEFB $61,$48,$20,$63,$21,$2E,$B9,$3B,$48,$4A,$58,$5A,$E1,$62,$47,$20
  DEFB $61,$A2,$23,$2E,$38,$48,$4B,$58,$5A,$47,$20,$61,$24,$2E,$38,$48
  DEFB $4C,$58,$5A,$47,$21,$61,$25,$2F,$37,$48,$4C,$58,$5A,$47,$22,$60
  DEFB $25,$B0,$32,$36,$49,$4C,$58,$5A,$46,$22,$60,$26,$B3,$35,$49,$4C
  DEFB $58,$5A,$45,$22,$60,$27,$4A,$4C,$58,$5A,$45,$22,$60,$27,$4A,$4C
  DEFB $57,$5B,$45,$23,$5F,$28,$4A,$4D,$56,$5B,$45,$24,$5F,$28,$4A,$4E
  DEFB $56,$5B,$44,$24,$5E,$29,$4B,$CF,$55,$D9,$5D,$43,$24,$5E,$29,$CC
  DEFB $4E,$58,$44,$25,$5D,$2A,$4B,$D5,$57,$DB,$5C,$43,$25,$5A,$2B,$4A
  DEFB $59,$43,$26,$58,$2C,$4A,$D5,$57,$44,$27,$57,$28,$2D,$4A,$D3,$54
  DEFB $43,$29,$56,$AA,$2D,$4A,$52,$42,$2E,$55,$49,$51,$42,$2E,$54,$49
  DEFB $50,$42,$2E,$54,$49,$4F,$43,$2E,$53,$B8,$3A,$48,$4E,$43,$2F,$53
  DEFB $BB,$3C,$48,$4D,$42,$30,$52,$3D,$48,$42,$31,$51,$3E,$50,$42,$32
  DEFB $51,$3E,$4F,$42,$33,$51,$3F,$4E,$43,$34,$51,$B5,$37,$C0,$41,$4D
  DEFB $43,$36,$50,$B8,$39,$41,$4D,$43,$36,$50,$BA,$3B,$42,$4C,$43,$37
  DEFB $4F,$3C,$43,$4C,$44,$38,$4F,$39,$3D,$44,$4B,$42,$3A,$4F,$3D,$45
  DEFB $42,$3A,$4E,$3E,$45,$42,$3A,$4D,$3F,$45,$42,$3B,$4C,$40,$C6,$47
  DEFB $44,$3C,$4B,$3D,$40,$48,$4A,$40,$3E,$49,$41,$3F,$48,$47,$40,$40
  DEFB $46,$40,$41,$45,$40,$42,$44,$40,$43,$43
TerrainMountain3:
  DEFB $27,$43,$20,$5F,$21,$27,$C4,$45,$43,$22,$5E,$28,$43,$5D,$44,$23
  DEFB $5C,$28,$2F,$43,$45,$45,$24,$5C,$29,$30,$42,$45,$D9,$5A,$45,$25
  DEFB $5B,$2A,$31,$41,$46,$58,$46,$26,$5A,$AB,$2D,$31,$40,$47,$52,$58
  DEFB $47,$27,$5A,$2E,$32,$3F,$42,$47,$52,$58,$47,$28,$5A,$AF,$30,$32
  DEFB $3E,$43,$47,$52,$58,$46,$29,$59,$B1,$32,$3D,$44,$47,$52,$57,$47
  DEFB $29,$59,$2A,$33,$BB,$3C,$45,$47,$D1,$52,$D7,$58,$46,$29,$57,$2B
  DEFB $33,$3A,$46,$48,$D1,$52,$46,$2A,$57,$2C,$34,$39,$46,$48,$D1,$52
  DEFB $46,$2A,$57,$2D,$B5,$38,$46,$48,$51,$53,$45,$2B,$57,$2E,$46,$49
  DEFB $51,$53,$45,$2B,$57,$2E,$47,$49,$50,$53,$45,$2B,$56,$2F,$47,$C9
  DEFB $4A,$50,$53,$44,$2C,$56,$2F,$47,$CA,$50,$D2,$55,$43,$2C,$55,$30
  DEFB $C8,$4A,$51,$44,$2C,$54,$31,$48,$50,$D2,$53,$42,$2D,$51,$32,$47
  DEFB $44,$2E,$50,$AF,$30,$33,$47,$CD,$4F,$43,$31,$4F,$B2,$33,$47,$4C
  DEFB $42,$33,$4E,$46,$4B,$43,$33,$4E,$BA,$3B,$46,$4A,$43,$34,$4E,$BC
  DEFB $3D,$46,$49,$42,$35,$4D,$3E,$46,$42,$35,$4D,$3E,$CB,$4C,$43,$36
  DEFB $4C,$37,$3F,$4A,$43,$38,$4B,$B9,$3B,$40,$49,$43,$39,$4B,$3C,$41
  DEFB $49,$43,$3A,$4B,$3D,$42,$48,$42,$3B,$4A,$3E,$43,$42,$3C,$49,$3E
  DEFB $43,$42,$3D,$48,$3F,$C4,$45,$42,$3E,$47,$40,$46,$40,$3F,$45,$40
  DEFB $40,$44,$40,$41,$43,$40,$42,$42
TerrainMountain4:
  DEFB $23,$42,$24,$5B,$2B,$C4,$45,$43,$25,$5A,$26,$2B,$43,$44,$27,$59
  DEFB $2C,$31,$43,$45,$45,$28,$59,$2C,$32,$42,$45,$56,$46,$29,$58,$2D
  DEFB $33,$41,$46,$50,$55,$47,$2A,$57,$AE,$30,$33,$40,$42,$46,$50,$55
  DEFB $47,$2B,$56,$B1,$32,$34,$3F,$43,$46,$50,$55,$45,$2C,$55,$B3,$34
  DEFB $3E,$44,$47,$50,$46,$2C,$55,$2D,$35,$BC,$3D,$45,$47,$50,$46,$2C
  DEFB $55,$2E,$35,$3B,$45,$48,$50,$46,$2D,$55,$2F,$36,$3A,$45,$48,$CF
  DEFB $50,$46,$2D,$54,$30,$B7,$39,$46,$48,$4F,$51,$45,$2E,$54,$30,$46
  DEFB $48,$4F,$51,$45,$2E,$54,$31,$46,$49,$CE,$4F,$51,$45,$2F,$54,$31
  DEFB $47,$49,$4E,$51,$42,$2F,$54,$32,$C8,$53,$42,$2F,$50,$33,$47,$42
  DEFB $30,$4F,$34,$47,$43,$31,$4E,$B2,$35,$47,$CC,$4D,$42,$35,$4D,$46
  DEFB $4B,$42,$35,$4D,$46,$4A,$43,$35,$4C,$BB,$3C,$45,$49,$42,$36,$4C
  DEFB $BD,$3E,$45,$42,$37,$4C,$3F,$CA,$4B,$43,$38,$4B,$39,$40,$49,$43
  DEFB $3A,$4A,$BB,$3C,$41,$48,$43,$3A,$4A,$3D,$42,$48,$43,$3B,$4A,$3E
  DEFB $43,$47,$42,$3C,$49,$3F,$43,$42,$3D,$48,$40,$44,$41,$3E,$47,$45
  DEFB $41,$3F,$46,$45,$40,$40,$44,$40,$41,$43,$40,$42,$42
TerrainMountain5:
  DEFB $1A,$42,$2B,$55,$30,$43,$43,$2C,$54,$30,$42,$53,$44,$2D,$52,$31
  DEFB $35,$41,$51,$45,$2E,$50,$32,$36,$40,$44,$4C,$46,$2F,$50,$B3,$34
  DEFB $37,$3F,$42,$45,$4C,$45,$30,$50,$B5,$37,$3F,$42,$45,$4C,$45,$31
  DEFB $50,$38,$BD,$3E,$43,$45,$4C,$45,$32,$50,$38,$3C,$44,$46,$4C,$45
  DEFB $32,$4F,$B3,$34,$B9,$3B,$44,$46,$CB,$4C,$45,$33,$4F,$35,$44,$46
  DEFB $4B,$4D,$45,$33,$4F,$35,$45,$47,$4B,$4D,$42,$33,$4F,$35,$C6,$4E
  DEFB $42,$34,$4D,$36,$46,$43,$35,$4C,$37,$45,$CA,$4B,$43,$36,$4B,$37
  DEFB $45,$C8,$49,$42,$38,$4A,$44,$47,$43,$39,$49,$BD,$3E,$44,$46,$42
  DEFB $3A,$49,$3F,$44,$42,$3B,$48,$40,$47,$42,$3B,$48,$41,$46,$43,$3C
  DEFB $47,$BD,$3E,$42,$45,$42,$3D,$46,$3F,$42,$02,$3E,$45,$3F,$C1,$42
  DEFB $40,$3F,$44,$01,$40,$43,$42,$40,$42,$42
TerrainMountain6:
  DEFB $14,$41,$30,$50,$42,$43,$31,$4F,$34,$37,$41,$46,$32,$4E,$35,$38
  DEFB $40,$43,$49,$4D,$44,$33,$4C,$B6,$38,$3F,$43,$49,$44,$34,$4C,$39
  DEFB $3E,$43,$49,$44,$34,$4C,$3A,$3D,$44,$49,$43,$35,$4B,$BB,$3C,$44
  DEFB $C8,$49,$42,$35,$4B,$44,$C8,$49,$41,$36,$4B,$C5,$4A,$41,$36,$49
  DEFB $44,$42,$37,$48,$38,$44,$41,$39,$47,$43,$42,$3A,$47,$BD,$3E,$43
  DEFB $41,$3B,$46,$3F,$41,$3C,$46,$40,$41,$3D,$46,$41,$41,$3E,$45,$42
  DEFB $41,$3F,$44,$43,$40,$40,$43,$00,$41,$42
TerrainMountain7:
  DEFB $10,$40,$33,$4C,$43,$34,$4C,$37,$41,$43,$44,$35,$4B,$38,$40,$43
  DEFB $47,$44,$36,$4A,$B9,$3A,$3F,$43,$47,$44,$37,$4A,$3B,$3E,$43,$47
  DEFB $43,$37,$49,$BC,$3D,$43,$47,$42,$38,$49,$43,$47,$41,$39,$49,$C4
  DEFB $48,$41,$3A,$47,$43,$41,$3B,$46,$42,$42,$3B,$45,$3E,$42,$41,$3C
  DEFB $45,$3F,$41,$3D,$44,$40,$01,$3E,$43,$BF,$40,$40,$3F,$43,$00,$40
  DEFB $42
TerrainMountain8:
  DEFB $0D,$40,$36,$4A,$43,$37,$4A,$3B,$41,$43,$44,$38,$49,$3C,$40,$43
  DEFB $46,$44,$39,$48,$3C,$3F,$43,$46,$43,$39,$48,$BD,$3E,$43,$46,$41
  DEFB $3A,$48,$C3,$47,$41,$3A,$46,$43,$41,$3B,$45,$42,$41,$3C,$45,$40
  DEFB $41,$3D,$44,$41,$41,$3E,$44,$41,$41,$3F,$43,$42,$00,$40,$41
TerrainCitadel1:
  DEFB $4A,$4E,$03,$7B,$08,$0C,$33,$38,$3A,$3C,$3E,$40,$42,$44,$46,$4B
  DEFB $72,$76,$49,$03,$7B,$08,$8C,$0D,$33,$38,$BA,$44,$46,$4B,$F1,$72
  DEFB $76,$4E,$03,$7B,$08,$0D,$33,$38,$3A,$3C,$3E,$40,$42,$44,$46,$4B
  DEFB $71,$76,$49,$03,$7B,$08,$0D,$33,$38,$BA,$44,$46,$4B,$71,$76,$4F
  DEFB $03,$7B,$06,$08,$0D,$33,$38,$3A,$3C,$3E,$40,$42,$44,$46,$4B,$71
  DEFB $76,$4E,$03,$7B,$06,$08,$0D,$33,$36,$38,$BA,$44,$46,$48,$4B,$6A
  DEFB $71,$76,$78,$52,$03,$7B,$06,$08,$0D,$2C,$33,$36,$38,$BA,$3C,$3E
  DEFB $40,$C2,$44,$46,$48,$4B,$6A,$F0,$71,$76,$78,$4F,$03,$7B,$08,$8D
  DEFB $0E,$2C,$33,$36,$38,$BB,$43,$46,$48,$4B,$51,$6A,$70,$76,$78,$4C
  DEFB $03,$7B,$08,$0E,$2C,$33,$38,$BC,$42,$46,$4B,$51,$6A,$70,$76,$4A
  DEFB $03,$7B,$08,$0E,$2C,$33,$38,$46,$4B,$51,$70,$76,$4B,$03,$7B,$08
  DEFB $0E,$15,$26,$33,$38,$46,$4B,$51,$70,$76,$4A,$03,$7B,$08,$0E,$15
  DEFB $26,$33,$38,$46,$4B,$70,$76,$4B,$03,$7B,$05,$88,$0E,$15,$26,$33
  DEFB $35,$B8,$46,$49,$4B,$F0,$76,$79,$4E,$03,$7B,$05,$08,$0E,$15,$26
  DEFB $33,$35,$38,$46,$49,$4B,$70,$76,$79,$49,$03,$7B,$05,$88,$0F,$33
  DEFB $35,$B8,$46,$49,$4B,$EF,$76,$79,$C1,$03,$0B,$08,$CC,$0D,$71,$0F
  DEFB $33,$38,$3B,$3D,$41,$43,$46,$4B,$60,$66,$6F,$41,$73,$7B,$76,$80
  DEFB $02,$0B,$C7,$0D,$71,$8E,$0F,$B2,$3B,$BD,$41,$C3,$4C,$60,$66,$EF
  DEFB $70,$00,$73,$7C,$C0,$02,$09,$C6,$0F,$6F,$32,$39,$45,$4C,$60,$66
  DEFB $40,$75,$7C,$80,$01,$0A,$C4,$0F,$6F,$B1,$3A,$C4,$4D,$60,$66,$00
  DEFB $74,$7D,$C0,$01,$0A,$C4,$0F,$6F,$31,$3A,$44,$4D,$40,$74,$7D,$80
  DEFB $01,$0A,$C2,$0F,$6F,$B1,$3A,$C4,$4D,$00,$74,$7D,$44,$0F,$6F,$10
  DEFB $22,$58,$6E,$42,$10,$6E,$22,$58,$43,$10,$6E,$14,$22,$58,$43,$10
  DEFB $6E,$14,$22,$58,$41,$10,$6E,$14,$41,$10,$6E,$14,$41,$10,$6E,$3E
  DEFB $42,$10,$6E,$11,$3E,$43,$11,$6E,$3E,$68,$6D,$42,$11,$6D,$3E,$68
  DEFB $41,$11,$6D,$68,$41,$11,$6D,$68,$41,$11,$6D,$1B,$42,$11,$6D,$1B
  DEFB $4C,$44,$11,$6D,$12,$1B,$4C,$61,$44,$12,$6D,$1B,$4C,$61,$6C,$42
  DEFB $12,$6C,$4C,$61,$42,$12,$6C,$2A,$61,$41,$12,$6C,$2A,$42,$12,$6C
  DEFB $2A,$32,$42,$12,$6C,$2A,$32,$41,$12,$6C,$32,$43,$12,$6C,$13,$32
  DEFB $6B,$40,$13,$6B,$40,$13,$6B,$40,$13,$6B,$51,$13,$6B,$18,$1B,$22
  DEFB $25,$2C,$2F,$36,$39,$40,$43,$4A,$4D,$54,$57,$5E,$61,$68,$51,$13
  DEFB $6B,$18,$1B,$22,$25,$2C,$2F,$36,$39,$40,$43,$4A,$4D,$54,$57,$5E
  DEFB $61,$68,$51,$13,$6B,$97,$18,$9B,$1C,$A1,$22,$A5,$26,$AB,$2C,$AF
  DEFB $30,$B5,$36,$B9,$3A,$BF,$40,$C3,$44,$C9,$4A,$CD,$4E,$D3,$54,$D7
  DEFB $58,$DD,$5E,$E1,$62,$E7,$68,$00,$11,$6D,$40,$11,$6D,$40,$11,$6D
  DEFB $13,$11,$6D,$12,$96,$17,$9B,$1C,$A0,$21,$A5,$26,$AA,$2B,$AF,$30
  DEFB $B4,$35,$B9,$3A,$BE,$3F,$C3,$44,$C8,$49,$CD,$4E,$D2,$53,$D7,$58
  DEFB $DC,$5D,$E1,$62,$E6,$67,$EB,$6C,$80,$11,$13,$80,$15,$18,$80,$1A
  DEFB $1D,$80,$1F,$22,$80,$24,$27,$80,$29,$2C,$86,$2E,$4F,$32,$37,$3C
  DEFB $41,$46,$4B,$80,$51,$54,$80,$56,$59,$80,$5B,$5E,$80,$60,$63,$80
  DEFB $65,$68,$00,$6A,$6D,$40,$2F,$4D,$40,$2F,$4D,$4E,$2F,$4D,$31,$33
  DEFB $35,$37,$39,$3B,$3D,$3F,$41,$43,$45,$47,$49,$4B,$08,$2F,$4D,$30
  DEFB $34,$38,$3C,$40,$44,$48,$4C,$08,$2E,$4E,$30,$34,$38,$3C,$40,$44
  DEFB $48,$4C,$40,$2E,$4E,$00,$2E,$4E,$40,$2F,$4D,$43,$2F,$4D,$B4,$36
  DEFB $BD,$3F,$C6,$48,$43,$2F,$4D,$B4,$36,$BD,$3F,$C6,$48,$43,$2F,$4D
  DEFB $B4,$36,$BD,$3F,$C6,$48,$43,$2F,$4D,$B4,$36,$BD,$3F,$C6,$48,$40
  DEFB $2F,$4D,$40,$2F,$4D,$00,$2D,$4F,$40,$2D,$4F,$40,$2D,$4F,$07,$2D
  DEFB $4F,$AE,$2F,$B3,$34,$B8,$39,$BD,$3E,$C2,$43,$C7,$48,$CC,$4E,$80
  DEFB $2D,$30,$80,$32,$35,$80,$37,$3A,$80,$3C,$3F,$80,$41,$44,$80,$46
  DEFB $49,$00,$4B,$4F
TerrainCitadel2:
  DEFB $34,$49,$15,$69,$18,$1B,$37,$3A,$BC,$42,$44,$47,$63,$66,$49,$15
  DEFB $69,$18,$9B,$1C,$37,$3A,$BC,$42,$44,$47,$E2,$63,$66,$49,$15,$69
  DEFB $18,$1C,$37,$3A,$BC,$42,$44,$47,$62,$66,$49,$15,$69,$18,$1C,$37
  DEFB $3A,$BC,$42,$44,$47,$62,$66,$4B,$15,$69,$18,$1C,$32,$37,$3A,$BC
  DEFB $42,$44,$47,$5D,$E1,$62,$66,$4C,$15,$69,$18,$9C,$1D,$32,$37,$3A
  DEFB $BC,$42,$44,$47,$4C,$5D,$61,$66,$4C,$15,$69,$18,$1D,$32,$37,$3A
  DEFB $BD,$41,$44,$47,$4C,$5D,$61,$66,$4B,$15,$69,$18,$1D,$22,$2E,$37
  DEFB $3A,$44,$47,$4C,$61,$66,$47,$15,$69,$98,$1D,$22,$2E,$37,$BA,$44
  DEFB $47,$E1,$66,$4A,$15,$69,$18,$1D,$22,$2E,$37,$3A,$44,$47,$61,$66
  DEFB $4C,$15,$69,$18,$9A,$1B,$9D,$1E,$37,$3A,$BC,$3E,$C0,$42,$44,$47
  DEFB $61,$E3,$64,$66,$80,$14,$1A,$C7,$1C,$62,$9D,$1E,$B6,$3C,$BE,$40
  DEFB $C2,$48,$56,$5A,$61,$00,$64,$6A,$C0,$14,$19,$C6,$1E,$61,$36,$3B
  DEFB $44,$48,$56,$5A,$40,$65,$6A,$C0,$13,$1A,$C6,$1E,$61,$35,$3C,$43
  DEFB $49,$56,$5A,$40,$64,$6B,$80,$13,$1A,$C2,$1E,$61,$B5,$3C,$C3,$49
  DEFB $00,$64,$6B,$43,$1E,$61,$2B,$51,$60,$43,$1E,$60,$21,$2B,$51,$43
  DEFB $1E,$60,$21,$2B,$51,$41,$1E,$60,$21,$41,$1E,$60,$3E,$44,$1E,$60
  DEFB $1F,$3E,$5C,$5F,$42,$1F,$5F,$3E,$5C,$41,$1F,$5F,$5C,$41,$1F,$5F
  DEFB $26,$42,$1F,$5F,$26,$48,$44,$1F,$5F,$20,$26,$48,$57,$42,$20,$5F
  DEFB $48,$57,$42,$20,$5F,$30,$57,$42,$20,$5F,$30,$36,$42,$20,$5F,$30
  DEFB $36,$42,$20,$5F,$36,$5E,$40,$20,$5E,$40,$20,$5E,$51,$20,$5E,$24
  DEFB $26,$2B,$2D,$32,$34,$39,$3B,$40,$42,$47,$49,$4E,$50,$55,$57,$5C
  DEFB $12,$20,$5E,$A1,$22,$25,$A8,$29,$2C,$AF,$30,$33,$B6,$37,$3A,$BD
  DEFB $3E,$41,$C4,$45,$48,$CB,$4C,$4F,$D2,$53,$56,$D9,$5A,$5D,$00,$1F
  DEFB $5F,$40,$1F,$5F,$12,$1F,$5F,$23,$26,$2A,$2D,$31,$34,$38,$3B,$3F
  DEFB $42,$46,$49,$4D,$50,$54,$57,$5B,$5E,$80,$1F,$20,$80,$22,$27,$80
  DEFB $29,$2E,$83,$30,$4A,$36,$3D,$44,$80,$4C,$51,$80,$53,$58,$00,$5A
  DEFB $5F,$40,$34,$49,$07,$34,$49,$35,$38,$3B,$3E,$41,$44,$C7,$48,$07
  DEFB $33,$4A,$35,$38,$3B,$3E,$41,$44,$C7,$48,$40,$33,$4A,$00,$33,$4A
  DEFB $40,$34,$49,$43,$34,$49,$B8,$39,$BE,$3F,$C4,$45,$43,$34,$49,$B8
  DEFB $39,$BE,$3F,$C4,$45,$40,$34,$49,$00,$33,$4A,$40,$33,$4A,$07,$33
  DEFB $4A,$34,$37,$3B,$3E,$42,$45,$49,$80,$33,$38,$80,$3A,$3F,$80,$41
  DEFB $46,$00,$48,$4A
TerrainCitadel3:
  DEFB $26,$49,$21,$5D,$23,$25,$39,$3B,$BD,$41,$43,$45,$59,$5B,$49,$21
  DEFB $5D,$23,$25,$39,$3B,$BD,$41,$43,$45,$59,$5B,$49,$21,$5D,$23,$26
  DEFB $39,$3B,$BD,$41,$43,$45,$58,$5B,$4B,$21,$5D,$23,$26,$36,$39,$3B
  DEFB $BD,$41,$43,$45,$54,$58,$5B,$4C,$21,$5D,$23,$26,$36,$39,$3B,$BD
  DEFB $41,$43,$45,$48,$54,$58,$5B,$4B,$21,$5D,$23,$27,$2A,$33,$39,$3B
  DEFB $43,$45,$48,$57,$5B,$47,$21,$5D,$A3,$27,$2A,$33,$39,$BB,$43,$45
  DEFB $D7,$5B,$48,$21,$5D,$23,$27,$39,$3B,$43,$45,$57,$5B,$45,$21,$5D
  DEFB $A2,$27,$B9,$45,$4F,$52,$D7,$5C,$C0,$20,$24,$C6,$27,$57,$38,$3C
  DEFB $42,$46,$4F,$52,$40,$5A,$5E,$80,$20,$24,$C2,$27,$57,$B8,$3C,$C2
  DEFB $46,$00,$5A,$5E,$43,$27,$57,$2A,$31,$4C,$43,$27,$57,$2A,$31,$4C
  DEFB $40,$27,$57,$42,$27,$57,$3E,$54,$42,$28,$56,$3E,$54,$41,$28,$56
  DEFB $2D,$42,$28,$56,$2D,$45,$42,$28,$56,$45,$50,$42,$28,$56,$34,$50
  DEFB $42,$28,$56,$34,$39,$41,$28,$56,$39,$40,$29,$55,$40,$29,$55,$51
  DEFB $29,$55,$2B,$2D,$30,$32,$35,$37,$3A,$3C,$3F,$41,$44,$46,$49,$4B
  DEFB $4E,$50,$53,$00,$28,$56,$40,$28,$56,$00,$28,$56,$40,$37,$46,$07
  DEFB $36,$47,$38,$3A,$3C,$3E,$40,$42,$44,$40,$36,$47,$00,$36,$47,$43
  DEFB $37,$46,$BA,$3B,$BE,$3F,$C2,$43,$43,$37,$46,$BA,$3B,$BE,$3F,$C2
  DEFB $43,$40,$37,$46,$00,$36,$47,$40,$36,$47,$00,$36,$47
TerrainCitadel4:
  DEFB $21,$49,$24,$59,$26,$28,$39,$3B,$BD,$40,$42,$44,$55,$57,$49,$24
  DEFB $59,$26,$28,$39,$3B,$BD,$40,$42,$44,$55,$57,$49,$24,$59,$26,$28
  DEFB $39,$3B,$BD,$40,$42,$44,$55,$57,$4B,$24,$59,$26,$28,$37,$39,$3B
  DEFB $BD,$40,$42,$44,$51,$55,$57,$4B,$24,$59,$26,$28,$2C,$34,$39,$3B
  DEFB $42,$44,$46,$55,$57,$45,$24,$59,$A6,$28,$39,$BB,$42,$44,$D5,$57
  DEFB $48,$24,$59,$26,$29,$39,$3B,$42,$44,$54,$57,$45,$24,$59,$A5,$29
  DEFB $B9,$44,$4D,$4F,$D4,$58,$C0,$23,$27,$C4,$29,$54,$38,$3C,$41,$45
  DEFB $40,$56,$5A,$80,$23,$27,$C2,$29,$54,$B8,$3C,$C1,$45,$00,$56,$5A
  DEFB $43,$29,$54,$2C,$32,$4A,$40,$29,$54,$42,$29,$54,$3E,$51,$40,$2A
  DEFB $53,$41,$2A,$53,$2F,$41,$2A,$53,$44,$41,$2A,$53,$4D,$41,$2A,$53
  DEFB $35,$41,$2A,$53,$39,$40,$2B,$52,$40,$2B,$52,$40,$2B,$52,$00,$2A
  DEFB $53,$40,$2A,$53,$00,$2A,$53,$40,$38,$45,$40,$38,$45,$04,$38,$45
  DEFB $39,$BC,$3D,$C0,$41,$44,$04,$38,$45,$39,$BC,$3D,$C0,$41,$44,$40
  DEFB $38,$45,$00,$38,$45,$40,$38,$45,$00,$38,$45
TerrainCitadel5:
  DEFB $18,$47,$2B,$53,$2D,$2F,$3B,$BD,$41,$43,$4F,$51,$47,$2B,$53,$2D
  DEFB $2F,$3B,$BD,$41,$43,$4F,$51,$47,$2B,$53,$2D,$2F,$3B,$BD,$41,$43
  DEFB $4F,$51,$48,$2B,$53,$2D,$2F,$3B,$3D,$41,$43,$4F,$51,$45,$2B,$53
  DEFB $AD,$2F,$3B,$BD,$41,$43,$CF,$51,$80,$2B,$2D,$C2,$2F,$4F,$BB,$3C
  DEFB $C2,$43,$00,$51,$53,$C0,$2A,$2D,$C4,$2F,$4F,$3A,$3D,$41,$44,$40
  DEFB $51,$54,$80,$2A,$2D,$C2,$2F,$4F,$BA,$3D,$C1,$44,$00,$51,$54,$40
  DEFB $2F,$4F,$40,$2F,$4F,$40,$30,$4E,$40,$30,$4E,$40,$30,$4E,$40,$30
  DEFB $4E,$40,$30,$4E,$00,$30,$4E,$40,$30,$4E,$00,$30,$4E,$40,$3A,$44
  DEFB $43,$3A,$44,$3C,$3F,$42,$40,$3A,$44,$00,$3A,$44,$40,$3A,$44,$00
  DEFB $3A,$44
TerrainCitadel6:
  DEFB $12,$45,$30,$4E,$32,$3C,$BE,$40,$42,$4C,$45,$30,$4E,$32,$3C,$BE
  DEFB $40,$42,$4C,$45,$30,$4E,$32,$3C,$BE,$40,$42,$4C,$45,$30,$4E,$32
  DEFB $3C,$BE,$40,$42,$4C,$46,$30,$4E,$32,$3C,$3E,$40,$42,$4C,$44,$30
  DEFB $4E,$B1,$33,$BC,$3E,$C0,$42,$CB,$4D,$40,$33,$4B,$40,$33,$4B,$40
  DEFB $33,$4B,$40,$33,$4B,$40,$33,$4B,$00,$33,$4B,$40,$33,$4B,$00,$33
  DEFB $4B,$40,$3B,$43,$40,$3B,$43,$40,$3B,$43,$00,$3B,$43
TerrainCitadel7:
  DEFB $0F,$45,$34,$4B,$36,$3D,$BF,$40,$42,$49,$45,$34,$4B,$36,$3D,$BF
  DEFB $40,$42,$49,$45,$34,$4B,$36,$3D,$BF,$40,$42,$49,$45,$34,$4B,$36
  DEFB $3D,$BF,$40,$42,$49,$44,$34,$4B,$B5,$36,$BD,$3E,$C1,$42,$C9,$4A
  DEFB $40,$36,$49,$40,$36,$49,$40,$36,$49,$40,$36,$49,$40,$36,$49,$00
  DEFB $36,$49,$40,$3C,$43,$40,$3C,$43,$40,$3C,$43,$00,$3C,$43
TerrainCitadel8:
  DEFB $0C,$41,$37,$48,$BF,$40,$41,$37,$48,$BF,$40,$41,$37,$48,$BF,$40
  DEFB $42,$37,$48,$38,$47,$40,$38,$47,$40,$38,$47,$40,$38,$47,$40,$38
  DEFB $47,$00,$38,$47,$40,$3D,$43,$40,$3D,$43,$00,$3D,$43
TerrainForest1:
  DEFB $29,$45,$09,$76,$8A,$14,$96,$1A,$B8,$3D,$DD,$60,$EC,$75,$0A,$09
  DEFB $76,$0A,$11,$16,$9A,$2C,$B1,$38,$3D,$D6,$5D,$E0,$66,$70,$75,$0C
  DEFB $0A,$75,$0B,$10,$17,$19,$2C,$31,$B7,$39,$3C,$5D,$60,$71,$74,$0E
  DEFB $0B,$75,$0C,$0F,$17,$19,$2D,$30,$39,$3C,$4E,$53,$5D,$60,$71,$74
  DEFB $0D,$09,$7A,$0C,$0F,$17,$19,$2D,$30,$39,$3C,$4F,$52,$DC,$64,$71
  DEFB $74,$4A,$05,$7D,$86,$08,$93,$16,$18,$9A,$2B,$C8,$4E,$D0,$51,$D3
  DEFB $54,$DC,$63,$E5,$69,$FB,$7C,$08,$03,$7E,$85,$08,$93,$1B,$2B,$48
  DEFB $CE,$52,$54,$E5,$6A,$FB,$7D,$08,$02,$7F,$83,$04,$8D,$14,$9C,$24
  DEFB $A8,$2A,$C9,$4D,$53,$6B,$7E,$09,$02,$7F,$03,$0C,$25,$27,$2A,$49
  DEFB $52,$6C,$7E,$08,$01,$7F,$02,$0C,$26,$2A,$49,$52,$6D,$7E,$08,$00
  DEFB $7F,$01,$0B,$26,$2A,$49,$51,$6D,$7E,$08,$00,$7F,$01,$0A,$26,$2A
  DEFB $49,$51,$6D,$7E,$08,$00,$7F,$01,$0A,$26,$2A,$49,$51,$6D,$7E,$08
  DEFB $00,$7F,$01,$0A,$26,$2A,$49,$50,$6E,$7E,$09,$00,$7F,$01,$0A,$26
  DEFB $2A,$48,$50,$E9,$6B,$6E,$7E,$08,$00,$7F,$01,$0A,$26,$2A,$48,$50
  DEFB $EC,$6D,$7E,$08,$00,$7F,$01,$0A,$25,$2A,$47,$50,$6E,$7E,$08,$00
  DEFB $7F,$01,$0A,$25,$2B,$47,$50,$6E,$7E,$08,$00,$7F,$01,$0B,$25,$2B
  DEFB $47,$50,$6F,$7E,$08,$00,$7F,$01,$0B,$25,$2C,$47,$50,$70,$7D,$08
  DEFB $00,$7E,$01,$0B,$25,$2C,$47,$50,$70,$7D,$08,$00,$7E,$01,$0B,$25
  DEFB $2C,$47,$50,$70,$7D,$08,$01,$7E,$02,$0C,$25,$2C,$46,$51,$EE,$6F
  DEFB $7D,$08,$01,$7E,$02,$0D,$24,$2C,$46,$51,$6D,$7D,$08,$02,$7D,$03
  DEFB $0E,$24,$2C,$46,$51,$6C,$7C,$08,$02,$7D,$03,$0E,$24,$2D,$46,$51
  DEFB $6C,$7C,$08,$02,$7D,$03,$0F,$23,$2E,$46,$51,$6B,$7C,$08,$03,$7C
  DEFB $84,$06,$0F,$23,$2F,$46,$52,$6A,$7B,$08,$04,$7B,$07,$0F,$22,$2F
  DEFB $45,$52,$69,$7A,$08,$07,$7A,$08,$10,$22,$30,$44,$D3,$54,$E9,$6A
  DEFB $79,$08,$08,$7A,$09,$11,$A1,$23,$31,$D5,$56,$68,$EB,$6C,$79,$0A
  DEFB $08,$79,$09,$91,$14,$9F,$20,$24,$32,$43,$57,$67,$6D,$78,$0B,$09
  DEFB $78,$8A,$0B,$8E,$10,$95,$16,$1E,$25,$33,$43,$57,$66,$EE,$6F,$F6
  DEFB $77,$81,$0A,$10,$8C,$0D,$08,$15,$77,$97,$18,$9C,$1D,$25,$B4,$37
  DEFB $C1,$43,$D8,$5D,$E2,$65,$F0,$75,$80,$0C,$0D,$06,$17,$75,$99,$1B
  DEFB $26,$B8,$40,$C4,$46,$DE,$61,$73,$84,$19,$40,$1A,$A4,$25,$A7,$28
  DEFB $3B,$03,$44,$74,$C7,$49,$60,$F1,$73,$84,$19,$3B,$1A,$A2,$23,$A9
  DEFB $2A,$B9,$3A,$03,$47,$73,$4A,$DE,$5F,$EF,$71,$82,$1A,$23,$9B,$1C
  DEFB $21,$82,$29,$3A,$2B,$B7,$38,$04,$4A,$71,$4B,$D9,$5D,$60,$ED,$6E
  DEFB $C1,$1B,$21,$1C,$82,$2B,$38,$2C,$B4,$36,$82,$4B,$5D,$4C,$58,$41
  DEFB $60,$6E,$6D,$80,$1D,$20,$C1,$2C,$36,$B4,$35,$C0,$4C,$58,$00,$61
  DEFB $6B,$80,$2D,$33,$00,$4D,$57
TerrainForest2:
  DEFB $1D,$43,$21,$56,$A3,$25,$BB,$3D,$D4,$55,$49,$19,$66,$9B,$1E,$A0
  DEFB $21,$24,$34,$3C,$BE,$4E,$55,$DB,$60,$E2,$64,$0E,$1A,$65,$1B,$1E
  DEFB $23,$25,$33,$35,$3B,$3D,$49,$4D,$54,$56,$62,$64,$0D,$17,$69,$1B
  DEFB $1E,$23,$25,$33,$35,$3B,$3D,$4A,$4C,$D3,$58,$62,$64,$45,$15,$6A
  DEFB $16,$A7,$30,$C6,$49,$4D,$D4,$58,$08,$14,$6B,$95,$16,$1C,$A7,$2C
  DEFB $AF,$30,$C6,$49,$4D,$5E,$6A,$08,$13,$6B,$94,$15,$1B,$AD,$2E,$30
  DEFB $46,$4C,$5F,$6A,$08,$13,$6C,$14,$1B,$2E,$30,$46,$4C,$5F,$6B,$08
  DEFB $13,$6C,$14,$1A,$2E,$30,$46,$4C,$5F,$6B,$08,$13,$6C,$14,$1A,$2E
  DEFB $30,$46,$4B,$60,$6B,$09,$13,$6C,$14,$1A,$2E,$30,$45,$4B,$DD,$5E
  DEFB $60,$6B,$08,$13,$6C,$14,$1A,$2D,$30,$45,$4B,$DF,$60,$6B,$08,$13
  DEFB $6C,$14,$1A,$2D,$31,$45,$4B,$60,$6B,$08,$13,$6C,$14,$1B,$2D,$31
  DEFB $45,$4B,$61,$6B,$08,$13,$6C,$14,$1B,$2D,$32,$45,$4B,$61,$6B,$08
  DEFB $13,$6C,$14,$1B,$2D,$32,$44,$4B,$60,$6B,$08,$13,$6C,$14,$1C,$2C
  DEFB $32,$44,$4C,$5F,$6B,$08,$14,$6B,$15,$1D,$2C,$32,$44,$4C,$5F,$6A
  DEFB $08,$14,$6B,$15,$1D,$2C,$33,$44,$4C,$5E,$6A,$08,$15,$6A,$96,$17
  DEFB $1E,$2C,$34,$44,$4C,$5D,$69,$08,$16,$69,$18,$1E,$2B,$34,$43,$CD
  DEFB $4E,$5D,$68,$08,$18,$68,$19,$1F,$AA,$2B,$35,$42,$4F,$5C,$5E,$0A
  DEFB $19,$68,$1A,$9D,$22,$A8,$29,$2C,$36,$42,$50,$5B,$DF,$60,$E6,$67
  DEFB $09,$1A,$67,$9B,$1C,$A3,$24,$27,$2D,$B7,$39,$C1,$42,$D1,$54,$D8
  DEFB $5A,$E1,$65,$80,$1B,$1C,$06,$23,$65,$A5,$26,$2E,$BA,$40,$C3,$44
  DEFB $D5,$57,$64,$83,$25,$40,$26,$AB,$30,$BB,$3C,$03,$43,$64,$C5,$47
  DEFB $56,$E1,$63,$83,$26,$3C,$A7,$2A,$31,$3A,$03,$45,$63,$48,$D1,$56
  DEFB $60,$80,$27,$2A,$C0,$31,$3A,$41,$48,$60,$D1,$56,$80,$32,$39,$80
  DEFB $49,$50,$00,$57,$5F
TerrainForest3:
  DEFB $15,$41,$2C,$50,$3D,$49,$24,$5B,$26,$A8,$2A,$2C,$37,$3D,$BF,$44
  DEFB $50,$D2,$57,$59,$0D,$22,$5C,$25,$27,$2B,$2D,$36,$38,$3C,$3E,$47
  DEFB $49,$CE,$51,$58,$5A,$44,$21,$5D,$AE,$34,$C4,$46,$48,$CE,$51,$06
  DEFB $20,$5E,$21,$26,$AE,$34,$C4,$49,$55,$5D,$07,$1F,$5F,$20,$25,$34
  DEFB $44,$48,$56,$5E,$07,$1F,$5F,$20,$25,$34,$44,$48,$57,$5E,$07,$1F
  DEFB $5F,$20,$25,$34,$43,$48,$57,$5E,$07,$1F,$5F,$20,$25,$34,$43,$48
  DEFB $57,$5E,$08,$1F,$5F,$20,$25,$33,$35,$43,$48,$57,$5E,$08,$1F,$5F
  DEFB $20,$25,$32,$36,$43,$48,$57,$5E,$08,$1F,$5F,$20,$26,$32,$36,$43
  DEFB $48,$57,$5E,$08,$20,$5F,$21,$27,$31,$36,$43,$48,$56,$5E,$08,$20
  DEFB $5F,$21,$27,$31,$36,$43,$49,$55,$5E,$08,$21,$5E,$A2,$23,$27,$31
  DEFB $37,$42,$49,$54,$5D,$08,$23,$5D,$24,$28,$B0,$31,$38,$41,$4A,$D4
  DEFB $55,$5C,$08,$24,$5C,$A5,$2C,$AE,$2F,$32,$B9,$3A,$41,$CB,$4E,$D1
  DEFB $53,$D6,$5B,$06,$25,$5B,$AC,$2D,$33,$BB,$40,$42,$CF,$50,$58,$83
  DEFB $2C,$40,$2D,$B2,$34,$BC,$3D,$03,$42,$58,$C3,$44,$4E,$57,$C2,$2D
  DEFB $3D,$B2,$34,$3C,$42,$43,$57,$44,$4E,$80,$2E,$31,$80,$35,$3B,$00
  DEFB $45,$56
TerrainForest4:
  DEFB $13,$43,$2D,$4D,$2E,$BC,$3D,$4C,$45,$27,$55,$28,$AD,$2E,$BC,$3D
  DEFB $CC,$4D,$54,$00,$25,$58,$43,$24,$59,$B0,$35,$43,$47,$07,$23,$5A
  DEFB $24,$28,$B0,$35,$43,$47,$D2,$53,$59,$07,$22,$5B,$23,$27,$35,$43
  DEFB $46,$54,$5A,$07,$22,$5B,$23,$27,$35,$42,$46,$54,$5A,$07,$22,$5B
  DEFB $23,$27,$35,$42,$46,$54,$5A,$08,$22,$5B,$23,$28,$34,$36,$42,$46
  DEFB $54,$5A,$08,$22,$5B,$23,$28,$33,$37,$42,$46,$54,$5A,$08,$23,$5B
  DEFB $24,$28,$33,$37,$42,$46,$54,$5A,$08,$23,$5B,$24,$29,$32,$37,$42
  DEFB $47,$D2,$53,$5A,$08,$24,$5A,$A5,$26,$29,$32,$37,$41,$47,$51,$59
  DEFB $07,$26,$59,$A7,$2A,$B1,$32,$38,$40,$48,$D1,$52,$58,$07,$27,$58
  DEFB $AB,$30,$33,$B9,$3A,$40,$C9,$4C,$CE,$50,$D3,$57,$07,$2B,$57,$2E
  DEFB $34,$3B,$BE,$3F,$41,$4D,$54,$83,$2E,$3F,$2F,$B3,$35,$BC,$3D,$02
  DEFB $41,$54,$C2,$43,$4C,$C2,$2F,$3D,$B3,$35,$3C,$42,$42,$54,$43,$4C
  DEFB $80,$30,$32,$80,$36,$3B,$00,$44,$53
TerrainForest5:
  DEFB $0F,$42,$32,$4A,$BD,$3E,$49,$45,$2D,$50,$2E,$32,$BD,$3E,$C9,$4A
  DEFB $4F,$06,$2D,$53,$2F,$39,$41,$46,$4D,$52,$07,$2B,$54,$2C,$2E,$38
  DEFB $42,$45,$4E,$53,$07,$2A,$54,$2B,$2D,$38,$42,$44,$4F,$53,$07,$2A
  DEFB $54,$2B,$2D,$38,$42,$44,$4F,$53,$08,$2A,$54,$2B,$2E,$37,$39,$42
  DEFB $44,$4F,$53,$08,$2A,$54,$2B,$2E,$36,$39,$42,$44,$4F,$53,$08,$2B
  DEFB $54,$2C,$AE,$2F,$36,$39,$42,$45,$4E,$53,$08,$2C,$53,$2D,$2F,$36
  DEFB $39,$41,$45,$4D,$52,$06,$2D,$52,$AE,$30,$B5,$36,$3A,$40,$46,$CD
  DEFB $51,$05,$2E,$51,$B0,$34,$37,$BB,$3C,$BF,$41,$C7,$4C,$04,$30,$4C
  DEFB $38,$BD,$3E,$42,$49,$C1,$38,$3E,$3D,$40,$42,$49,$80,$39,$3C,$00
  DEFB $43,$48
TerrainForest6:
  DEFB $0C,$42,$35,$4A,$3D,$47,$02,$32,$4E,$40,$4D,$06,$31,$4F,$32,$3A
  DEFB $41,$44,$4A,$4E,$06,$30,$4F,$31,$39,$41,$43,$4B,$4E,$06,$30,$4F
  DEFB $31,$39,$41,$43,$4B,$4E,$06,$31,$4F,$32,$39,$41,$43,$4B,$4E,$07
  DEFB $31,$4F,$32,$38,$3A,$41,$43,$4A,$4E,$07,$32,$4E,$33,$38,$3A,$40
  DEFB $44,$49,$4D,$44,$33,$4D,$38,$3A,$BD,$3E,$C1,$44,$04,$33,$4C,$39
  DEFB $BD,$3E,$41,$46,$C1,$39,$3E,$3D,$40,$41,$46,$80,$3A,$3C,$00,$42
  DEFB $45
TerrainForest7:
  DEFB $0A,$41,$37,$47,$3F,$00,$34,$4B,$04,$33,$4B,$34,$3B,$43,$4A,$04
  DEFB $33,$4B,$34,$3B,$43,$4A,$04,$34,$4A,$35,$3B,$43,$49,$06,$34,$4A
  DEFB $35,$3A,$3C,$C1,$42,$44,$49,$43,$35,$49,$BA,$3C,$BE,$3F,$C1,$44
  DEFB $04,$36,$48,$3B,$BE,$3F,$41,$45,$C1,$3B,$3F,$3E,$40,$41,$45,$80
  DEFB $3C,$3D,$00,$42,$44
TerrainForest8:
  DEFB $08,$41,$39,$46,$40,$00,$37,$48,$04,$36,$49,$37,$3C,$43,$48,$04
  DEFB $36,$48,$37,$3C,$43,$47,$06,$36,$48,$37,$3B,$3D,$42,$44,$47,$43
  DEFB $37,$47,$BC,$3D,$BF,$40,$C2,$44,$44,$38,$46,$B9,$3B,$3E,$41,$45
  DEFB $00,$3C,$44
TerrainHenge1:
  DEFB $17,$47,$1A,$60,$9E,$1F,$A5,$28,$B0,$33,$BC,$3F,$C7,$4A,$D2,$55
  DEFB $DB,$5C,$47,$1A,$60,$9E,$20,$A5,$28,$B0,$33,$BC,$3F,$C7,$4A,$D2
  DEFB $55,$DB,$5C,$47,$1A,$60,$9E,$20,$A5,$28,$AF,$33,$BC,$3F,$C7,$4A
  DEFB $D2,$55,$DB,$5C,$47,$1A,$60,$9E,$20,$A4,$29,$AF,$33,$BC,$40,$C7
  DEFB $4A,$D2,$56,$DB,$5D,$47,$1A,$60,$9E,$20,$A5,$29,$B0,$34,$BB,$3F
  DEFB $C6,$4A,$D2,$55,$DB,$5C,$47,$1A,$60,$9E,$1F,$A5,$29,$B0,$33,$BB
  DEFB $3F,$C6,$4B,$D1,$55,$DB,$5D,$47,$1A,$60,$9D,$1F,$A5,$28,$B0,$33
  DEFB $BB,$3F,$C7,$4A,$D1,$55,$DB,$5C,$47,$1A,$60,$9D,$1F,$A5,$28,$B0
  DEFB $33,$BB,$3F,$C7,$4A,$D1,$55,$DB,$5C,$47,$1A,$60,$9D,$1F,$A5,$28
  DEFB $B0,$33,$BA,$40,$C7,$4A,$D1,$56,$DB,$5C,$47,$1A,$60,$9D,$1F,$A5
  DEFB $28,$B0,$33,$BB,$40,$C7,$4A,$D2,$56,$DB,$5C,$47,$1A,$60,$9D,$1F
  DEFB $A5,$28,$B0,$34,$BB,$40,$C7,$4B,$D2,$56,$DB,$5C,$47,$1A,$60,$9E
  DEFB $1F,$A5,$28,$B0,$34,$BB,$3F,$C7,$4A,$D2,$56,$DB,$5C,$47,$1A,$60
  DEFB $9E,$1F,$A4,$28,$B0,$34,$BB,$3F,$C7,$4B,$D2,$56,$DB,$5C,$47,$1A
  DEFB $60,$9E,$1F,$A5,$28,$AF,$33,$BB,$3F,$C6,$4A,$D2,$55,$DB,$5D,$47
  DEFB $1A,$60,$9E,$1F,$A5,$28,$B0,$33,$BB,$3F,$C7,$4A,$D2,$55,$DB,$5C
  DEFB $47,$1A,$60,$9E,$1F,$A5,$28,$B0,$33,$BB,$3F,$C7,$4A,$D2,$55,$DB
  DEFB $5C,$08,$1A,$60,$9B,$1C,$A1,$23,$AA,$2E,$B5,$39,$C1,$45,$CC,$50
  DEFB $D7,$59,$DE,$5F,$00,$19,$61,$4C,$19,$61,$9B,$1D,$A1,$23,$AB,$2D
  DEFB $30,$33,$B6,$38,$3C,$C2,$44,$CD,$4F,$54,$D7,$59,$DD,$5F,$48,$19
  DEFB $61,$1C,$22,$2C,$37,$43,$4E,$58,$5E,$48,$19,$61,$1C,$22,$2C,$37
  DEFB $43,$4E,$58,$5E,$4C,$19,$61,$9B,$1D,$A1,$23,$26,$AB,$2D,$B6,$38
  DEFB $BD,$3E,$C2,$44,$47,$CD,$4F,$52,$D7,$59,$DD,$5F,$00,$19,$61
TerrainHenge2:
  DEFB $10,$47,$25,$56,$A8,$29,$AD,$2F,$B5,$37,$BD,$3F,$C5,$47,$CC,$4F
  DEFB $53,$47,$25,$56,$A8,$29,$AD,$2F,$B5,$37,$BD,$3F,$C5,$47,$CC,$4F
  DEFB $53,$47,$25,$56,$A8,$29,$AD,$30,$B5,$37,$BD,$3F,$C5,$47,$CC,$4F
  DEFB $53,$47,$25,$56,$A8,$29,$AD,$30,$B5,$37,$BC,$3F,$C4,$47,$CC,$4F
  DEFB $53,$47,$25,$56,$A7,$29,$AD,$30,$B5,$37,$BC,$3F,$C4,$47,$CC,$4F
  DEFB $53,$47,$25,$56,$A7,$29,$AD,$2F,$B5,$37,$BC,$3F,$C5,$47,$CC,$4F
  DEFB $53,$47,$25,$56,$A7,$29,$AD,$2F,$B5,$37,$BC,$40,$C5,$47,$CC,$4F
  DEFB $53,$47,$25,$56,$A7,$29,$AD,$2F,$B5,$37,$BC,$40,$C5,$48,$CC,$4F
  DEFB $53,$47,$25,$56,$A8,$29,$AD,$2F,$B5,$37,$BC,$3F,$C5,$48,$CC,$4F
  DEFB $53,$47,$25,$56,$A8,$29,$AD,$2F,$B5,$37,$BC,$3F,$C5,$47,$CC,$4F
  DEFB $53,$47,$25,$56,$A8,$29,$AD,$2F,$B5,$37,$BC,$3F,$C5,$47,$CC,$4F
  DEFB $53,$08,$25,$56,$26,$AA,$2B,$B1,$33,$B8,$3B,$C1,$43,$C9,$4B,$D0
  DEFB $52,$55,$00,$25,$57,$48,$25,$57,$27,$2B,$32,$3A,$42,$4A,$51,$55
  DEFB $48,$25,$57,$27,$2B,$32,$3A,$42,$4A,$51,$55,$00,$25,$57
TerrainHenge3:
  DEFB $0C,$47,$2C,$4F,$2F,$B2,$34,$B8,$39,$BE,$3F,$C3,$45,$C9,$4A,$4D
  DEFB $47,$2C,$4F,$2F,$B2,$34,$B8,$39,$BE,$3F,$C3,$45,$C9,$4A,$4D,$47
  DEFB $2C,$4F,$2F,$B2,$34,$B8,$39,$BD,$3F,$C3,$45,$C9,$4A,$4D,$47,$2C
  DEFB $4F,$AE,$2F,$B2,$34,$B8,$39,$BD,$3F,$C3,$45,$C9,$4A,$4D,$47,$2C
  DEFB $4F,$AE,$2F,$B2,$34,$B8,$39,$BD,$3F,$C3,$45,$C9,$4A,$4D,$47,$2C
  DEFB $4F,$AE,$2F,$B2,$34,$B8,$39,$BD,$3F,$C3,$45,$C9,$4A,$4D,$47,$2C
  DEFB $4F,$2F,$B2,$34,$B8,$39,$BD,$3F,$C3,$45,$C9,$4A,$4D,$47,$2C,$4F
  DEFB $2F,$B2,$34,$B8,$39,$BD,$3F,$C3,$45,$C9,$4A,$4D,$08,$2C,$4F,$2D
  DEFB $B0,$31,$B5,$36,$BA,$3C,$C0,$42,$C6,$48,$CB,$4C,$4E,$00,$2C,$4F
  DEFB $47,$2C,$4F,$2E,$31,$36,$3B,$41,$47,$4C,$00,$2C,$4F
TerrainHenge4:
  DEFB $0B,$47,$2E,$4D,$30,$B3,$34,$B8,$39,$BD,$3E,$C2,$43,$C7,$48,$4B
  DEFB $47,$2E,$4D,$30,$B3,$34,$B8,$39,$BD,$3E,$C2,$43,$C7,$48,$4B,$47
  DEFB $2E,$4D,$30,$B3,$34,$B8,$39,$BD,$3E,$C2,$43,$C7,$48,$4B,$47,$2E
  DEFB $4D,$30,$B3,$34,$B8,$39,$BD,$3E,$C2,$43,$C7,$48,$4B,$47,$2E,$4D
  DEFB $30,$B3,$34,$B8,$39,$BD,$3E,$C2,$43,$C7,$48,$4B,$47,$2E,$4D,$30
  DEFB $B3,$34,$B8,$39,$BD,$3E,$C2,$43,$C7,$48,$4B,$47,$2E,$4D,$30,$B3
  DEFB $34,$B8,$39,$BD,$3E,$C2,$43,$C7,$48,$4B,$47,$2E,$4D,$30,$B3,$34
  DEFB $B8,$39,$BD,$3E,$C2,$43,$C7,$48,$4B,$00,$2E,$4D,$46,$2E,$4D,$32
  DEFB $37,$3B,$40,$45,$4A,$00,$2E,$4D
TerrainHenge5:
  DEFB $09,$47,$33,$4A,$35,$38,$3B,$BE,$3F,$42,$45,$48,$47,$33,$4A,$35
  DEFB $38,$3B,$BE,$3F,$42,$45,$48,$47,$33,$4A,$35,$38,$3B,$BE,$3F,$42
  DEFB $45,$48,$47,$33,$4A,$35,$38,$3B,$BE,$3F,$42,$45,$48,$47,$33,$4A
  DEFB $35,$38,$3B,$BE,$3F,$42,$45,$48,$47,$33,$4A,$35,$38,$3B,$BE,$3F
  DEFB $42,$45,$48,$00,$33,$4A,$46,$33,$4A,$36,$39,$3C,$40,$44,$48,$00
  DEFB $33,$4A
TerrainHenge6:
  DEFB $07,$08,$36,$47,$37,$39,$3B,$3D,$40,$42,$44,$46,$08,$36,$47,$37
  DEFB $39,$3B,$3D,$40,$42,$44,$46,$08,$36,$47,$37,$39,$3B,$3D,$40,$42
  DEFB $44,$46,$08,$36,$47,$37,$39,$3B,$3D,$40,$42,$44,$46,$00,$36,$47
  DEFB $40,$36,$47,$00,$36,$47
TerrainHenge7:
  DEFB $06,$46,$38,$46,$3A,$3C,$3E,$40,$42,$44,$46,$38,$46,$3A,$3C,$3E
  DEFB $40,$42,$44,$46,$38,$46,$3A,$3C,$3E,$40,$42,$44,$00,$38,$46,$40
  DEFB $38,$46,$00,$38,$46
TerrainHenge8:
  DEFB $05,$44,$3A,$44,$3C,$3E,$40,$42,$44,$3A,$44,$3C,$3E,$40,$42,$00
  DEFB $3A,$44,$40,$3A,$44,$00,$3A,$44
TerrainTower1:
  DEFB $4E,$40,$2C,$60,$42,$2D,$5F,$C2,$44,$DD,$5E,$41,$2E,$5C,$48,$43
  DEFB $2E,$5B,$C0,$42,$49,$D9,$5A,$41,$2F,$58,$CA,$4C,$44,$30,$57,$31
  DEFB $38,$BE,$40,$CD,$52,$C2,$32,$4F,$33,$37,$00,$53,$56,$42,$34,$4E
  DEFB $B5,$36,$BC,$3E,$40,$37,$4D,$41,$38,$4D,$BB,$3D,$40,$39,$4C,$43
  DEFB $3A,$4B,$BC,$3E,$42,$4A,$41,$3B,$49,$C3,$44,$02,$3B,$48,$3C,$C0
  DEFB $44,$41,$3B,$46,$BD,$3F,$41,$3B,$46,$BD,$3F,$41,$3B,$46,$BD,$3F
  DEFB $41,$3B,$46,$BD,$3F,$41,$3B,$46,$BD,$3F,$40,$3B,$46,$40,$3B,$46
  DEFB $40,$3B,$46,$40,$3B,$46,$40,$3B,$46,$40,$3B,$46,$40,$3B,$46,$40
  DEFB $3B,$46,$40,$3B,$46,$40,$3B,$46,$40,$3B,$46,$40,$3B,$46,$40,$3B
  DEFB $46,$40,$3B,$46,$40,$3B,$46,$40,$3B,$46,$40,$3B,$46,$40,$3B,$46
  DEFB $40,$3B,$46,$40,$3B,$46,$40,$3B,$46,$40,$3B,$46,$40,$3B,$46,$40
  DEFB $3B,$46,$40,$3B,$46,$40,$3B,$46,$40,$3B,$46,$40,$3B,$46,$40,$3B
  DEFB $46,$40,$3B,$46,$40,$3B,$46,$40,$3B,$46,$44,$3B,$46,$3D,$3F,$42
  DEFB $44,$02,$3B,$46,$3E,$43,$00,$38,$49,$40,$38,$49,$40,$38,$49,$40
  DEFB $38,$49,$00,$35,$4C,$40,$35,$4C,$00,$35,$4C,$46,$35,$4C,$37,$3C
  DEFB $3E,$43,$45,$4A,$46,$35,$4C,$37,$3C,$3E,$43,$45,$4A,$46,$35,$4C
  DEFB $37,$3C,$3E,$43,$45,$4A,$46,$35,$4C,$37,$3C,$3E,$43,$45,$4A,$46
  DEFB $35,$4C,$37,$3C,$3E,$43,$45,$4A,$46,$35,$4C,$37,$3C,$3E,$43,$45
  DEFB $4A,$46,$35,$4C,$37,$3C,$3E,$43,$45,$4A,$46,$35,$4C,$37,$3C,$3E
  DEFB $43,$45,$4A,$03,$35,$4C,$B9,$3A,$C0,$41,$C7,$48,$04,$35,$4C,$B6
  DEFB $37,$BC,$3E,$C3,$45,$CA,$4B,$40,$35,$4C,$40,$35,$4C,$00,$35,$4C
  DEFB $40,$3A,$47,$40,$3B,$46,$40,$3C,$45,$42,$3D,$44,$3E,$43,$00,$3F
  DEFB $42
TerrainTower2:
  DEFB $37,$40,$32,$56,$43,$33,$55,$C1,$43,$45,$D3,$54,$42,$33,$52,$C0
  DEFB $41,$46,$41,$34,$51,$C7,$48,$44,$35,$50,$36,$3A,$BE,$40,$C9,$4F
  DEFB $42,$37,$4A,$B8,$39,$BD,$3E,$41,$3A,$49,$BC,$3E,$40,$3B,$48,$02
  DEFB $3C,$47,$BF,$40,$C3,$45,$02,$3C,$45,$3D,$C0,$42,$41,$3C,$44,$BE
  DEFB $3F,$41,$3C,$44,$BE,$3F,$41,$3C,$44,$BE,$3F,$41,$3C,$44,$BE,$3F
  DEFB $40,$3C,$44,$40,$3C,$44,$40,$3C,$44,$40,$3C,$44,$40,$3C,$44,$40
  DEFB $3C,$44,$40,$3C,$44,$40,$3C,$44,$40,$3C,$44,$40,$3C,$44,$40,$3C
  DEFB $44,$40,$3C,$44,$40,$3C,$44,$40,$3C,$44,$40,$3C,$44,$40,$3C,$44
  DEFB $40,$3C,$44,$40,$3C,$44,$40,$3C,$44,$40,$3C,$44,$40,$3C,$44,$40
  DEFB $3C,$44,$40,$3C,$44,$43,$3C,$44,$3E,$40,$42,$00,$3A,$46,$40,$3A
  DEFB $46,$40,$3A,$46,$00,$39,$47,$44,$39,$47,$3C,$3E,$42,$44,$44,$39
  DEFB $47,$3C,$3E,$42,$44,$44,$39,$47,$3C,$3E,$42,$44,$44,$39,$47,$3C
  DEFB $3E,$42,$44,$44,$39,$47,$3C,$3E,$42,$44,$03,$39,$47,$3A,$40,$46
  DEFB $02,$39,$47,$BC,$3E,$C2,$44,$40,$39,$47,$00,$39,$47,$40,$3B,$45
  DEFB $40,$3C,$44,$42,$3D,$43,$3E,$42,$00,$3F,$41
TerrainTower3:
  DEFB $28,$40,$36,$4F,$43,$36,$4E,$C0,$41,$44,$4D,$41,$37,$4C,$C5,$47
  DEFB $42,$38,$4B,$BE,$40,$C8,$4A,$43,$39,$47,$BA,$3B,$BD,$3E,$46,$41
  DEFB $3C,$45,$41,$02,$3D,$44,$3E,$C0,$41,$41,$3D,$43,$3F,$41,$3D,$43
  DEFB $3F,$41,$3D,$43,$3F,$40,$3D,$43,$40,$3D,$43,$40,$3D,$43,$40,$3D
  DEFB $43,$40,$3D,$43,$40,$3D,$43,$40,$3D,$43,$40,$3D,$43,$40,$3D,$43
  DEFB $40,$3D,$43,$40,$3D,$43,$40,$3D,$43,$40,$3D,$43,$40,$3D,$43,$40
  DEFB $3D,$43,$40,$3D,$43,$40,$3D,$43,$00,$3C,$44,$40,$3C,$44,$00,$3B
  DEFB $45,$44,$3B,$45,$3D,$3F,$41,$43,$44,$3B,$45,$3D,$3F,$41,$43,$44
  DEFB $3B,$45,$3D,$3F,$41,$43,$44,$3B,$45,$3D,$3F,$41,$43,$00,$3B,$45
  DEFB $40,$3B,$45,$00,$3B,$45,$40,$3D,$43,$40,$3E,$42,$00,$3F,$41
TerrainTower4:
  DEFB $23,$40,$37,$4D,$43,$38,$4C,$BF,$40,$43,$4B,$41,$39,$4A,$C4,$45
  DEFB $42,$3A,$49,$BE,$3F,$C6,$48,$43,$3B,$45,$3C,$40,$44,$01,$3D,$43
  DEFB $BF,$40,$41,$3D,$42,$3E,$41,$3D,$42,$3E,$41,$3D,$42,$3E,$40,$3D
  DEFB $42,$40,$3D,$42,$40,$3D,$42,$40,$3D,$42,$40,$3D,$42,$40,$3D,$42
  DEFB $40,$3D,$42,$40,$3D,$42,$40,$3D,$42,$40,$3D,$42,$40,$3D,$42,$40
  DEFB $3D,$42,$40,$3D,$42,$40,$3D,$42,$40,$3D,$42,$00,$3C,$43,$40,$3C
  DEFB $43,$00,$3B,$44,$42,$3B,$44,$3E,$41,$42,$3B,$44,$3E,$41,$42,$3B
  DEFB $44,$3E,$41,$00,$3B,$44,$40,$3B,$44,$00,$3B,$44,$40,$3D,$42,$00
  DEFB $3E,$41
TerrainTower5:
  DEFB $1B,$40,$39,$49,$43,$3A,$48,$BF,$40,$42,$47,$41,$3B,$46,$C3,$45
  DEFB $42,$3C,$44,$3D,$40,$01,$3E,$43,$40,$41,$3E,$42,$3F,$41,$3E,$42
  DEFB $3F,$40,$3E,$42,$40,$3E,$42,$40,$3E,$42,$40,$3E,$42,$40,$3E,$42
  DEFB $40,$3E,$42,$40,$3E,$42,$40,$3E,$42,$40,$3E,$42,$40,$3E,$42,$40
  DEFB $3E,$42,$00,$3E,$42,$40,$3E,$42,$00,$3D,$43,$42,$3D,$43,$3F,$41
  DEFB $42,$3D,$43,$3F,$41,$42,$3D,$43,$3F,$41,$00,$3D,$43,$40,$3E,$42
  DEFB $00,$3F,$41
TerrainTower6:
  DEFB $15,$40,$3A,$46,$41,$3B,$45,$41,$42,$3C,$44,$3D,$C2,$43,$01,$3E
  DEFB $41,$40,$01,$3E,$41,$40,$01,$3E,$41,$40,$40,$3E,$41,$40,$3E,$41
  DEFB $40,$3E,$41,$40,$3E,$41,$40,$3E,$41,$40,$3E,$41,$40,$3E,$41,$40
  DEFB $3E,$41,$40,$3E,$41,$00,$3D,$42,$40,$3D,$42,$40,$3D,$42,$00,$3D
  DEFB $42,$40,$3E,$41,$00,$3F,$40
TerrainTower7:
  DEFB $11,$40,$3C,$45,$42,$3D,$44,$40,$43,$41,$3E,$42,$41,$40,$3F,$41
  DEFB $40,$3F,$41,$40,$3F,$41,$40,$3F,$41,$40,$3F,$41,$40,$3F,$41,$40
  DEFB $3F,$41,$40,$3F,$41,$40,$3F,$41,$00,$3E,$42,$40,$3E,$42,$00,$3E
  DEFB $42,$40,$3F,$41,$40,$40,$40
TerrainTower8:
  DEFB $0E,$40,$3D,$44,$40,$3E,$43,$01,$3F,$42,$40,$40,$3F,$41,$40,$3F
  DEFB $41,$40,$3F,$41,$40,$3F,$41,$40,$3F,$41,$40,$3F,$41,$00,$3E,$42
  DEFB $40,$3E,$42,$00,$3E,$42,$40,$3F,$41,$40,$40,$40
TerrainVillage1:
  DEFB $13,$46,$0F,$4C,$12,$9F,$20,$2F,$39,$BD,$3E,$42,$46,$0F,$4C,$12
  DEFB $9F,$20,$2F,$39,$BD,$3E,$42,$4B,$0F,$60,$12,$14,$9F,$20,$25,$2A
  DEFB $2F,$39,$BD,$3E,$42,$49,$CC,$5F,$4B,$0F,$60,$12,$14,$9F,$20,$25
  DEFB $2A,$2F,$39,$42,$49,$4C,$D0,$52,$46,$0F,$60,$12,$AF,$39,$42,$4C
  DEFB $D0,$52,$D8,$59,$08,$0F,$60,$10,$B1,$38,$BA,$41,$C3,$45,$C7,$4B
  DEFB $CD,$4F,$D3,$57,$DA,$5F,$4B,$0F,$60,$11,$30,$B3,$35,$B9,$42,$46
  DEFB $4C,$4E,$54,$56,$5B,$5D,$0B,$0F,$60,$10,$B1,$32,$B6,$39,$BB,$42
  DEFB $C4,$4A,$4D,$D0,$52,$55,$D8,$59,$5C,$5F,$45,$0F,$61,$11,$30,$BB
  DEFB $3E,$44,$CA,$60,$04,$0F,$61,$10,$BD,$42,$C6,$48,$CA,$60,$4A,$0F
  DEFB $61,$11,$30,$34,$36,$39,$3D,$46,$C8,$4C,$D0,$5A,$DD,$60,$06,$0F
  DEFB $61,$10,$B1,$33,$35,$B7,$38,$BA,$3C,$C8,$60,$C0,$0F,$12,$48,$1F
  DEFB $61,$28,$2E,$36,$3D,$43,$CA,$4E,$57,$DA,$60,$80,$0F,$12,$45,$20
  DEFB $61,$27,$AD,$2E,$36,$43,$D0,$53,$C1,$21,$2C,$26,$03,$2E,$61,$AF
  DEFB $3C,$BE,$42,$D1,$52,$C2,$22,$2C,$25,$2B,$C0,$2E,$47,$40,$50,$53
  DEFB $81,$23,$2C,$2B,$80,$2E,$47,$00,$50,$53,$40,$29,$2C,$00,$29,$2C
TerrainVillage2:
  DEFB $0E,$46,$1E,$48,$20,$29,$34,$3B,$3E,$41,$4B,$1E,$56,$20,$22,$29
  DEFB $2D,$30,$34,$3B,$3E,$41,$46,$C8,$55,$4B,$1E,$56,$20,$22,$29,$2D
  DEFB $30,$34,$3B,$41,$46,$48,$CB,$4C,$46,$1E,$56,$20,$B4,$3B,$41,$48
  DEFB $CB,$4C,$51,$07,$1E,$56,$1F,$B6,$3A,$C2,$43,$C5,$47,$C9,$4A,$CD
  DEFB $50,$D2,$55,$46,$1E,$56,$20,$35,$38,$3C,$42,$47,$03,$1E,$57,$1F
  DEFB $BE,$42,$C4,$45,$47,$1E,$57,$20,$35,$37,$39,$3B,$3E,$C4,$45,$09
  DEFB $1E,$57,$1F,$36,$38,$3A,$BC,$3E,$C5,$46,$CB,$4F,$52,$D4,$56,$80
  DEFB $1E,$20,$45,$29,$57,$2E,$B3,$34,$39,$42,$CB,$4D,$C1,$2A,$32,$2D
  DEFB $02,$34,$57,$B5,$42,$4C,$80,$2B,$32,$80,$34,$45,$00,$4B,$4D,$40
  DEFB $30,$32,$00,$30,$32
TerrainVillage3:
  DEFB $0A,$46,$28,$45,$2A,$2F,$37,$3C,$3E,$40,$0A,$28,$4F,$29,$2B,$AD
  DEFB $2E,$B0,$31,$33,$B5,$36,$B8,$3B,$3D,$3F,$C1,$44,$45,$28,$4F,$2A
  DEFB $B7,$3C,$40,$45,$48,$05,$28,$4F,$29,$B9,$3B,$C1,$44,$C6,$4B,$CD
  DEFB $4E,$45,$28,$50,$2A,$B8,$3B,$3D,$41,$C5,$4F,$45,$28,$50,$2A,$38
  DEFB $3E,$42,$44,$02,$28,$50,$B9,$3E,$C4,$4F,$44,$30,$50,$32,$37,$C3
  DEFB $47,$CA,$4F,$81,$31,$43,$B5,$36,$00,$48,$49,$00,$34,$36
TerrainVillage4:
  DEFB $09,$45,$2A,$44,$2C,$30,$37,$3C,$3F,$09,$2A,$4D,$2B,$2D,$2F,$B1
  DEFB $32,$34,$36,$B8,$3B,$BD,$3E,$C0,$43,$45,$2A,$4D,$2C,$B7,$3C,$3F
  DEFB $44,$46,$05,$2A,$4D,$2B,$B8,$3B,$C0,$43,$C5,$49,$CB,$4C,$05,$2A
  DEFB $4D,$2B,$AD,$37,$3C,$BE,$3F,$C1,$42,$02,$2A,$4D,$B9,$3D,$C3,$4C
  DEFB $44,$31,$4D,$33,$37,$C2,$45,$C8,$4C,$81,$32,$42,$36,$00,$46,$47
  DEFB $00,$35,$37
TerrainVillage5:
  DEFB $07,$44,$30,$43,$34,$39,$3D,$3F,$44,$30,$4A,$39,$3D,$3F,$C3,$49
  DEFB $02,$30,$4A,$C0,$42,$C4,$49,$44,$30,$4A,$3A,$3E,$40,$C2,$49,$44
  DEFB $30,$4A,$B1,$35,$B7,$3A,$3F,$41,$01,$35,$4A,$B8,$39,$00,$38,$39
TerrainVillage6:
  DEFB $06,$44,$33,$42,$36,$3A,$3D,$3F,$03,$33,$47,$BB,$3C,$3E,$C0,$41
  DEFB $42,$33,$47,$BA,$40,$42,$44,$33,$47,$B4,$36,$3A,$3E,$41,$01,$37
  DEFB $47,$3A,$00,$39,$3A
TerrainVillage7:
  DEFB $04,$42,$36,$42,$3B,$3E,$02,$36,$46,$BC,$3D,$BF,$41,$43,$36,$46
  DEFB $3B,$3F,$41,$00,$36,$46
TerrainVillage8:
  DEFB $03,$42,$38,$42,$3C,$3F,$43,$38,$45,$3C,$3F,$42,$00,$38,$45
TerrainDowns1:
  DEFB $16,$42,$00,$7F,$A0,$23,$FD,$7E,$43,$01,$7C,$A4,$25,$E1,$63,$F8
  DEFB $7B,$43,$02,$77,$A6,$28,$DF,$60,$F3,$76,$43,$03,$72,$A9,$2B,$DC
  DEFB $5E,$EF,$71,$43,$04,$6E,$AC,$2E,$D9,$5B,$EC,$6D,$43,$05,$6B,$AF
  DEFB $30,$D7,$58,$E9,$6A,$43,$06,$68,$B1,$32,$D0,$56,$E5,$67,$44,$07
  DEFB $64,$B3,$35,$CD,$4F,$54,$E2,$63,$43,$08,$61,$B6,$37,$53,$60,$43
  DEFB $09,$5F,$0A,$B8,$39,$52,$44,$0B,$5E,$8C,$0D,$3A,$51,$5D,$44,$0C
  DEFB $5C,$8E,$10,$3B,$CE,$50,$DA,$5B,$44,$0D,$59,$91,$14,$3C,$CC,$4D
  DEFB $58,$44,$0E,$57,$B9,$3B,$3D,$CA,$4B,$56,$43,$0F,$55,$B6,$38,$BE
  DEFB $3F,$C8,$49,$43,$10,$54,$11,$B3,$35,$C0,$47,$42,$12,$53,$AF,$32
  DEFB $D1,$52,$C2,$13,$2E,$14,$2D,$42,$33,$50,$B4,$36,$CE,$4F,$C2,$15
  DEFB $2C,$96,$17,$2B,$41,$37,$4D,$CB,$4C,$C1,$18,$2A,$29,$42,$38,$4A
  DEFB $B9,$3A,$C8,$49,$C2,$19,$28,$9A,$1B,$A4,$27,$01,$3B,$47,$BE,$42
  DEFB $80,$1C,$23,$00,$3E,$42
TerrainDowns2:
  DEFB $10,$42,$13,$6C,$A9,$2C,$6B,$43,$14,$6A,$AD,$2F,$D6,$58,$E4,$69
  DEFB $43,$15,$63,$B0,$31,$D3,$55,$E1,$62,$43,$16,$60,$B2,$33,$D1,$52
  DEFB $5F,$43,$17,$5E,$B4,$36,$CB,$50,$DA,$5D,$44,$18,$59,$B7,$38,$C9
  DEFB $4A,$4E,$58,$44,$19,$57,$1A,$B9,$3B,$4D,$56,$44,$1B,$55,$9C,$1E
  DEFB $3C,$4C,$54,$44,$1C,$53,$9F,$21,$3D,$C8,$4B,$D1,$52,$43,$1D,$50
  DEFB $BB,$3C,$3E,$47,$43,$1E,$4F,$B9,$3A,$3F,$C5,$46,$44,$1F,$4E,$20
  DEFB $B4,$38,$C0,$44,$CC,$4D,$C0,$21,$33,$41,$39,$4B,$4A,$C2,$22,$32
  DEFB $A3,$24,$B0,$31,$42,$3A,$49,$3B,$C6,$48,$C2,$25,$2F,$26,$AD,$2E
  DEFB $01,$3C,$45,$BE,$41,$80,$27,$2C,$00,$3E,$41
TerrainDowns3:
  DEFB $0C,$42,$20,$5F,$AF,$31,$5E,$43,$21,$5D,$B2,$35,$CE,$51,$D7,$5C
  DEFB $42,$22,$56,$36,$CC,$4D,$43,$22,$55,$B7,$38,$C7,$4B,$D2,$54,$45
  DEFB $23,$51,$24,$B9,$3C,$46,$49,$CF,$50,$42,$25,$4E,$3D,$48,$44,$26
  DEFB $4D,$3C,$3E,$C5,$47,$CB,$4C,$43,$27,$4A,$3B,$3F,$C3,$44,$44,$28
  DEFB $49,$29,$B7,$3A,$C0,$42,$48,$C2,$2A,$36,$2B,$35,$42,$3B,$47,$3C
  DEFB $C4,$46,$C2,$2C,$34,$2D,$B2,$33,$41,$3D,$43,$C1,$42,$80,$2E,$31
  DEFB $00,$3E,$40
TerrainDowns4:
  DEFB $0B,$42,$23,$5B,$B0,$32,$5A,$43,$24,$59,$B3,$36,$CC,$4E,$D4,$58
  DEFB $42,$25,$53,$37,$CA,$4B,$43,$26,$52,$38,$C8,$49,$CF,$51,$43,$27
  DEFB $4E,$B9,$3B,$C6,$47,$CC,$4D,$43,$28,$4B,$BC,$3D,$C4,$45,$C9,$4A
  DEFB $43,$29,$48,$3B,$3E,$C2,$43,$44,$2A,$47,$2B,$B7,$3A,$BF,$41,$46
  DEFB $C1,$2C,$36,$2D,$42,$3B,$45,$3C,$C3,$44,$81,$2E,$35,$B0,$32,$01
  DEFB $3D,$42,$BE,$3F,$80,$30,$32,$00,$3E,$3F
TerrainDowns5:
  DEFB $09,$41,$2A,$54,$B4,$35,$43,$2B,$53,$B6,$38,$C9,$4A,$CF,$52,$43
  DEFB $2C,$4E,$B9,$3A,$C6,$48,$CC,$4D,$43,$2D,$4B,$BB,$3C,$45,$C9,$4A
  DEFB $43,$2E,$48,$BD,$3E,$C2,$44,$47,$44,$2F,$46,$30,$B9,$3C,$BF,$41
  DEFB $45,$C1,$31,$38,$32,$41,$3D,$44,$C2,$43,$C1,$33,$37,$36,$00,$3E
  DEFB $41,$00,$34,$35
TerrainDowns6:
  DEFB $07,$41,$2F,$4F,$B6,$37,$43,$30,$4E,$B8,$39,$C2,$44,$CB,$4D,$43
  DEFB $31,$4A,$BA,$3C,$C0,$41,$C6,$49,$42,$32,$45,$BD,$3F,$C3,$44,$42
  DEFB $33,$42,$BA,$3C,$41,$81,$34,$39,$B6,$37,$00,$3D,$40,$00,$36,$37
TerrainDowns7:
  DEFB $06,$41,$33,$4B,$B8,$39,$43,$34,$4A,$BA,$3B,$41,$C8,$49,$43,$35
  DEFB $47,$3C,$BE,$40,$C3,$46,$42,$36,$42,$BB,$3D,$41,$C0,$37,$3A,$00
  DEFB $3E,$40,$00,$38,$39
TerrainDowns8:
  DEFB $04,$42,$36,$4A,$3A,$C7,$49,$42,$37,$46,$3B,$C1,$45,$01,$38,$40
  DEFB $B9,$3B,$00,$39,$3B
TerrainKeep1:
  DEFB $22,$43,$27,$5B,$2E,$3C,$48,$44,$28,$5B,$2F,$32,$BC,$48,$54,$46
  DEFB $29,$5A,$AD,$2E,$B0,$31,$3D,$47,$D2,$53,$59,$44,$2A,$58,$AB,$2C
  DEFB $BD,$47,$51,$D4,$57,$43,$2C,$56,$3D,$C0,$44,$47,$43,$2C,$56,$3D
  DEFB $C0,$44,$47,$43,$2C,$56,$3D,$C0,$44,$47,$43,$2C,$56,$3D,$C0,$44
  DEFB $47,$43,$2C,$56,$3D,$C0,$44,$47,$43,$2C,$56,$3D,$C0,$44,$47,$42
  DEFB $2C,$56,$BC,$48,$4B,$43,$2C,$56,$3C,$48,$4B,$45,$2C,$56,$31,$3C
  DEFB $48,$4B,$51,$45,$2C,$56,$31,$38,$BC,$48,$4B,$51,$43,$2C,$56,$31
  DEFB $38,$51,$43,$2C,$56,$31,$38,$51,$41,$2C,$56,$38,$40,$2C,$56,$40
  DEFB $2C,$56,$42,$2C,$56,$BD,$3E,$C6,$47,$42,$2C,$56,$BD,$3E,$C6,$47
  DEFB $42,$2C,$56,$BD,$3E,$C6,$47,$42,$2C,$56,$BD,$3E,$C6,$47,$40,$2C
  DEFB $56,$40,$2C,$56,$4A,$2C,$56,$2F,$31,$36,$38,$40,$43,$4B,$4D,$52
  DEFB $54,$4A,$2C,$56,$2F,$31,$36,$38,$40,$43,$4B,$4D,$52,$54,$4A,$2C
  DEFB $56,$AE,$2F,$B1,$32,$B5,$36,$B8,$39,$BF,$40,$C3,$44,$CA,$4B,$CD
  DEFB $4E,$D1,$52,$D4,$55,$00,$2A,$58,$40,$2A,$58,$40,$2A,$58,$40,$2A
  DEFB $58,$07,$2A,$58,$AB,$2D,$B2,$34,$B9,$3B,$C0,$42,$C7,$49,$CE,$50
  DEFB $D5,$57,$80,$2A,$2E,$80,$31,$35,$80,$38,$3C,$80,$3F,$43,$80,$46
  DEFB $4A,$80,$4D,$51,$00,$54,$58
TerrainKeep2:
  DEFB $18,$43,$2E,$53,$32,$3D,$46,$46,$2F,$53,$30,$B3,$34,$BD,$3E,$C5
  DEFB $46,$4D,$D1,$52,$44,$30,$51,$B1,$32,$BE,$45,$4C,$CE,$50,$43,$32
  DEFB $4F,$3E,$C0,$43,$45,$43,$32,$4F,$3E,$C0,$43,$45,$43,$32,$4F,$3E
  DEFB $C0,$43,$45,$43,$32,$4F,$3E,$C0,$43,$45,$42,$32,$4F,$BD,$46,$48
  DEFB $44,$32,$4F,$35,$3D,$46,$48,$06,$32,$4F,$B3,$34,$B6,$39,$BB,$3C
  DEFB $47,$C9,$4B,$CD,$4E,$43,$32,$4F,$35,$3A,$4C,$42,$32,$4F,$3A,$4C
  DEFB $40,$32,$4F,$42,$32,$4F,$BD,$3E,$C4,$45,$42,$32,$4F,$BD,$3E,$C4
  DEFB $45,$42,$32,$4F,$BD,$3E,$C4,$45,$40,$32,$4F,$40,$32,$4F,$4A,$32
  DEFB $4F,$34,$36,$39,$3B,$40,$42,$46,$48,$4B,$4D,$4A,$32,$4F,$34,$36
  DEFB $39,$3B,$40,$42,$46,$48,$4B,$4D,$00,$30,$51,$40,$30,$51,$07,$30
  DEFB $51,$B1,$32,$B6,$37,$BB,$3C,$C0,$41,$C5,$46,$CA,$4B,$CF,$50,$80
  DEFB $30,$33,$80,$35,$38,$80,$3A,$3D,$80,$3F,$42,$80,$44,$47,$80,$49
  DEFB $4C,$00,$4E,$51
TerrainKeep3:
  DEFB $11,$44,$33,$4D,$36,$3E,$C0,$41,$43,$45,$34,$4C,$35,$3E,$C0,$41
  DEFB $43,$C9,$4B,$43,$36,$4A,$3E,$C0,$41,$43,$43,$36,$4A,$3E,$C0,$41
  DEFB $43,$41,$36,$4A,$BE,$43,$43,$36,$4A,$3E,$43,$45,$43,$36,$4A,$38
  DEFB $BE,$43,$45,$43,$36,$4A,$38,$3B,$48,$42,$36,$4A,$3B,$48,$40,$36
  DEFB $4A,$42,$36,$4A,$3E,$43,$42,$36,$4A,$3E,$43,$40,$36,$4A,$49,$36
  DEFB $4A,$38,$3A,$3C,$3E,$40,$42,$44,$46,$48,$00,$34,$4C,$40,$34,$4C
  DEFB $00,$34,$4C
TerrainKeep4:
  DEFB $0F,$43,$34,$4B,$37,$BE,$40,$42,$44,$35,$4A,$36,$BE,$40,$42,$C7
  DEFB $49,$42,$37,$48,$BE,$40,$42,$42,$37,$48,$BE,$40,$42,$43,$37,$48
  DEFB $BE,$40,$42,$44,$43,$37,$48,$39,$BE,$42,$44,$43,$37,$48,$39,$3B
  DEFB $46,$42,$37,$48,$3B,$46,$40,$37,$48,$42,$37,$48,$3E,$42,$42,$37
  DEFB $48,$3E,$42,$40,$37,$48,$00,$36,$49,$40,$36,$49,$00,$36,$49
TerrainKeep5:
  DEFB $0C,$41,$39,$48,$BF,$41,$42,$3A,$47,$BF,$41,$C5,$46,$41,$3A,$46
  DEFB $BF,$41,$41,$3A,$46,$BF,$41,$40,$3A,$46,$40,$3A,$46,$40,$3A,$46
  DEFB $40,$3A,$46,$40,$3A,$46,$00,$39,$47,$40,$39,$47,$00,$39,$47
TerrainKeep6:
  DEFB $09,$41,$3A,$46,$BF,$40,$42,$3B,$45,$BF,$40,$C3,$44,$41,$3B,$44
  DEFB $BF,$40,$40,$3B,$44,$40,$3B,$44,$40,$3B,$44,$00,$3B,$44,$40,$3A
  DEFB $45,$00,$3A,$45
TerrainKeep7:
  DEFB $06,$41,$3C,$44,$BF,$40,$41,$3C,$43,$BF,$40,$40,$3C,$43,$40,$3C
  DEFB $43,$40,$3C,$43,$00,$3C,$43
TerrainKeep8:
  DEFB $05,$02,$3D,$42,$3E,$41,$02,$3D,$42,$3E,$41,$40,$3D,$42,$40,$3D
  DEFB $42,$00,$3D,$42
TerrainSnowHall1:
  DEFB $12,$45,$2C,$4C,$33,$39,$BB,$3D,$3F,$46,$45,$2D,$4B,$33,$39,$BB
  DEFB $3D,$3F,$46,$02,$2D,$4B,$3A,$3E,$47,$2D,$4B,$30,$36,$39,$3C,$3F
  DEFB $43,$49,$46,$2D,$4B,$30,$36,$3A,$3E,$43,$49,$00,$2D,$4B,$44,$2E
  DEFB $4A,$33,$39,$3F,$46,$44,$2E,$4A,$33,$39,$3F,$46,$00,$2F,$49,$45
  DEFB $2F,$49,$31,$36,$3C,$42,$47,$45,$2F,$49,$31,$36,$3C,$42,$47,$00
  DEFB $30,$48,$44,$31,$47,$34,$39,$3F,$44,$44,$32,$46,$35,$39,$3F,$43
  DEFB $00,$33,$45,$42,$35,$43,$3B,$40,$43,$36,$42,$B7,$38,$3B,$C0,$41
  DEFB $00,$39,$3F
TerrainSnowHall2:
  DEFB $0D,$45,$33,$47,$37,$3B,$BD,$3E,$40,$44,$02,$33,$47,$3C,$3F,$45
  DEFB $33,$47,$35,$39,$BB,$3C,$BF,$40,$42,$44,$33,$47,$35,$39,$BC,$3F
  DEFB $42,$01,$33,$47,$BC,$3E,$44,$33,$47,$37,$3B,$3F,$44,$00,$34,$46
  DEFB $43,$34,$46,$39,$3D,$41,$00,$35,$45,$42,$36,$44,$3B,$3F,$43,$37
  DEFB $43,$39,$BB,$3D,$40,$02,$38,$42,$BB,$3C,$BE,$3F,$00,$3B,$3F
TerrainSnowHall3:
  DEFB $0A,$43,$36,$45,$3C,$3E,$40,$43,$36,$45,$3C,$3E,$40,$44,$36,$45
  DEFB $B7,$38,$3C,$40,$C3,$44,$41,$37,$44,$BD,$3F,$40,$37,$44,$01,$37
  DEFB $44,$BD,$40,$40,$38,$43,$41,$39,$42,$BD,$3F,$42,$3A,$41,$3B,$40
  DEFB $00,$3C,$3F
TerrainSnowHall4:
  DEFB $09,$42,$37,$44,$3C,$3F,$42,$37,$44,$3C,$3F,$42,$37,$44,$3C,$3F
  DEFB $41,$38,$43,$BD,$3E,$40,$38,$43,$40,$39,$42,$40,$3A,$41,$01,$3B
  DEFB $40,$BD,$3E,$00,$3D,$3E
TerrainSnowHall5:
  DEFB $06,$42,$39,$43,$3D,$3F,$42,$39,$43,$3D,$3F,$41,$3A,$42,$3E,$40
  DEFB $3A,$42,$40,$3B,$41,$00,$3C,$40
TerrainSnowHall6:
  DEFB $05,$42,$3A,$42,$3D,$3F,$42,$3A,$42,$3D,$3F,$41,$3B,$41,$3E,$40
  DEFB $3C,$40,$00,$3D,$3F
TerrainSnowHall7:
  DEFB $04,$41,$3B,$42,$BE,$3F,$41,$3B,$42,$BE,$3F,$40,$3C,$41,$00,$3D
  DEFB $40
TerrainSnowHall8:
  DEFB $03,$41,$3C,$42,$3F,$40,$3D,$41,$00,$3E,$40
TerrainLake1:
  DEFB $0B,$00,$27,$56,$00,$18,$62,$00,$0E,$6B,$00,$09,$70,$00,$07,$73
  DEFB $01,$07,$74,$88,$0A,$02,$08,$74,$8B,$10,$EF,$73,$02,$0B,$73,$91
  DEFB $17,$E9,$6E,$02,$11,$6E,$98,$25,$DE,$68,$42,$18,$68,$99,$25,$DE
  DEFB $67,$00,$26,$5D
TerrainLake2:
  DEFB $08,$00,$2E,$4F,$00,$1D,$5E,$00,$19,$61,$01,$18,$64,$99,$1A,$02
  DEFB $18,$64,$9B,$1E,$E1,$63,$02,$1B,$64,$9F,$2D,$D6,$60,$42,$1F,$60
  DEFB $A0,$2D,$D6,$5F,$00,$2E,$55
TerrainLake3:
  DEFB $06,$00,$2C,$53,$00,$24,$57,$01,$23,$59,$A4,$27,$02,$24,$59,$A8
  DEFB $32,$D0,$58,$42,$28,$58,$A9,$32,$D0,$57,$00,$33,$4F
TerrainLake4:
  DEFB $05,$00,$2E,$50,$00,$27,$54,$00,$26,$55,$00,$27,$54,$00,$31,$4B
TerrainLake5:
  DEFB $04,$00,$33,$4C,$00,$2E,$4F,$00,$2D,$50,$00,$35,$48
TerrainLake6:
  DEFB $03,$00,$36,$49,$00,$32,$4B,$00,$39,$47
TerrainLake7:
  DEFB $02,$00,$38,$47,$00,$36,$48
TerrainLake8:
  DEFB $01,$00,$37,$46
TerrainFrozenWastes1:
  DEFB $23,$45,$00,$7F,$05,$0F,$1E,$CB,$4C,$6B,$45,$00,$7F,$05,$0F,$1F
  DEFB $CD,$4E,$6A,$46,$00,$7F,$06,$10,$1F,$CF,$50,$5A,$69,$46,$00,$7F
  DEFB $06,$10,$1F,$51,$5A,$69,$47,$01,$7E,$07,$10,$1F,$34,$51,$5B,$69
  DEFB $48,$01,$7D,$08,$11,$1F,$28,$34,$52,$5B,$69,$49,$01,$7C,$09,$11
  DEFB $1E,$20,$28,$33,$53,$5B,$69,$49,$01,$7B,$0A,$11,$1D,$20,$28,$33
  DEFB $53,$5C,$69,$49,$02,$7B,$0B,$11,$1C,$20,$28,$33,$53,$5C,$69,$4A
  DEFB $02,$7B,$0B,$12,$1B,$20,$27,$32,$43,$D4,$55,$5C,$69,$4C,$03,$7A
  DEFB $0C,$12,$1B,$20,$27,$2E,$31,$43,$56,$5D,$69,$6F,$4C,$03,$7A,$0C
  DEFB $12,$1B,$20,$27,$2E,$31,$43,$56,$5E,$69,$70,$4C,$03,$79,$0C,$12
  DEFB $1B,$21,$27,$2E,$31,$42,$57,$5E,$69,$71,$C0,$03,$0B,$4A,$0D,$79
  DEFB $12,$1A,$21,$27,$AE,$30,$42,$D7,$58,$5E,$E9,$6A,$71,$C0,$03,$0B
  DEFB $C7,$0D,$56,$11,$19,$21,$27,$2E,$42,$D4,$55,$C1,$59,$69,$5E,$41
  DEFB $6B,$78,$72,$C0,$03,$0A,$C7,$0D,$53,$11,$19,$21,$27,$2E,$41,$D1
  DEFB $52,$C1,$59,$69,$5F,$41,$6B,$77,$72,$C0,$03,$0A,$C7,$0E,$50,$11
  DEFB $98,$1B,$21,$27,$2E,$41,$CE,$4F,$C1,$5A,$69,$60,$41,$6C,$77,$73
  DEFB $C0,$04,$0A,$C2,$0E,$17,$10,$16,$C3,$1C,$4D,$A2,$26,$AE,$30,$41
  DEFB $C2,$5A,$68,$60,$67,$41,$6C,$77,$F3,$76,$C0,$04,$09,$C1,$0E,$15
  DEFB $10,$C2,$1D,$2E,$22,$27,$C2,$31,$4C,$40,$4B,$C1,$5B,$67,$60,$41
  DEFB $6C,$76,$72,$C0,$05,$08,$C0,$0F,$15,$C2,$1D,$2E,$23,$28,$C1,$32
  DEFB $4A,$40,$81,$5B,$67,$DC,$60,$41,$6D,$75,$71,$C0,$05,$08,$C0,$0F
  DEFB $14,$C1,$1E,$2D,$24,$C1,$33,$49,$40,$C1,$5C,$66,$60,$40,$6D,$74
  DEFB $C0,$05,$08,$C0,$0F,$13,$C0,$1F,$23,$C0,$25,$2D,$C1,$33,$48,$3F
  DEFB $C1,$5C,$65,$60,$40,$6D,$74,$C0,$05,$08,$C0,$0F,$12,$C0,$20,$22
  DEFB $C0,$26,$2C,$C2,$34,$47,$3F,$46,$C1,$5D,$64,$5F,$40,$6E,$73,$C0
  DEFB $06,$08,$80,$0F,$11,$C0,$21,$21,$C0,$26,$2B,$C1,$34,$45,$3E,$C0
  DEFB $5D,$63,$40,$6E,$73,$C0,$06,$08,$C0,$26,$2A,$C1,$35,$44,$3E,$C0
  DEFB $5D,$62,$40,$6E,$72,$C0,$06,$08,$C0,$26,$2A,$C1,$35,$43,$3E,$C1
  DEFB $5D,$62,$5F,$40,$6F,$72,$C0,$06,$08,$C0,$26,$2A,$C2,$36,$42,$3D
  DEFB $41,$C1,$5D,$61,$5F,$40,$6F,$72,$C0,$07,$07,$C0,$26,$2A,$C1,$36
  DEFB $40,$3D,$81,$5E,$61,$60,$40,$70,$72,$C0,$26,$29,$C1,$37,$40,$3D
  DEFB $C0,$5F,$61,$40,$71,$71,$C0,$26,$29,$C1,$37,$3F,$3C,$40,$5F,$61
  DEFB $C0,$26,$29,$C1,$37,$3F,$3C,$40,$5F,$61,$C0,$26,$28,$C1,$37,$3E
  DEFB $3C,$40,$5F,$61,$C0,$26,$28,$C1,$38,$3D,$3B,$40,$60,$60,$C0,$26
  DEFB $28,$01,$38,$3C,$39,$80,$26,$28,$40,$39,$39
TerrainFrozenWastes2:
  DEFB $19,$45,$13,$6C,$17,$1E,$28,$48,$5E,$46,$13,$6C,$17,$1E,$29,$C9
  DEFB $4B,$52,$5D,$46,$13,$6C,$17,$1E,$29,$4C,$52,$5D,$47,$14,$6B,$18
  DEFB $1E,$29,$37,$4C,$53,$5D,$48,$14,$6A,$19,$1F,$A8,$29,$2F,$37,$4D
  DEFB $53,$5D,$49,$14,$69,$1A,$1F,$27,$29,$2F,$37,$4D,$53,$5D,$4A,$14
  DEFB $69,$1B,$20,$27,$29,$2E,$36,$42,$4E,$53,$5D,$4C,$15,$68,$1B,$20
  DEFB $26,$29,$2E,$33,$35,$42,$4F,$54,$5D,$61,$4C,$15,$68,$1B,$20,$26
  DEFB $2A,$2E,$33,$35,$41,$50,$55,$5D,$62,$4B,$15,$68,$1B,$20,$25,$2A
  DEFB $2E,$B3,$34,$41,$50,$55,$5D,$62,$C8,$15,$4F,$9B,$1C,$1F,$25,$2A
  DEFB $2E,$33,$41,$4E,$43,$51,$67,$55,$5D,$63,$C0,$15,$1A,$C7,$1D,$4D
  DEFB $1F,$A4,$26,$2A,$2E,$33,$41,$CA,$4C,$43,$51,$66,$56,$DD,$5E,$63
  DEFB $C0,$16,$1A,$C0,$1E,$23,$C3,$27,$49,$AB,$2E,$B3,$34,$41,$C2,$52
  DEFB $5C,$56,$5B,$41,$5F,$66,$64,$C0,$17,$19,$C0,$1E,$22,$C2,$27,$33
  DEFB $2B,$2F,$C3,$35,$48,$36,$40,$47,$81,$53,$5A,$D4,$56,$41,$5F,$66
  DEFB $E4,$65,$C0,$17,$19,$C0,$1E,$21,$C1,$28,$33,$2C,$C1,$37,$46,$40
  DEFB $C1,$53,$5A,$56,$40,$5F,$65,$C0,$17,$19,$C0,$1E,$20,$C1,$29,$32
  DEFB $AB,$2D,$C2,$37,$45,$3F,$44,$C1,$53,$59,$56,$40,$60,$64,$C0,$17
  DEFB $19,$C0,$1F,$1F,$C0,$2A,$2A,$C1,$2D,$31,$2E,$C1,$37,$43,$3E,$C0
  DEFB $54,$58,$40,$60,$64,$C0,$17,$19,$C0,$2E,$30,$C1,$38,$43,$3E,$C0
  DEFB $54,$58,$40,$60,$63,$C0,$17,$19,$C0,$2E,$30,$C2,$38,$42,$3E,$41
  DEFB $81,$54,$57,$55,$40,$61,$63,$C0,$18,$18,$C0,$2E,$30,$C1,$39,$40
  DEFB $3E,$C0,$55,$55,$40,$61,$63,$C0,$2E,$30,$C1,$3A,$3F,$3D,$40,$62
  DEFB $62,$C0,$2E,$30,$41,$3A,$3F,$3D,$C0,$2F,$2F,$01,$3A,$3E,$3B,$40
  DEFB $3A,$3C,$40,$3B,$3B
TerrainFrozenWastes3:
  DEFB $12,$45,$20,$5F,$22,$27,$2F,$45,$55,$46,$20,$5F,$22,$27,$2F,$C6
  DEFB $47,$4D,$54,$47,$20,$5E,$23,$27,$2F,$39,$48,$4D,$54,$48,$20,$5E
  DEFB $24,$28,$2F,$34,$39,$49,$4D,$54,$49,$20,$5D,$25,$28,$AE,$2F,$33
  DEFB $39,$41,$49,$4D,$54,$4C,$21,$5C,$25,$29,$2D,$2F,$33,$36,$38,$41
  DEFB $4A,$4E,$54,$57,$4B,$21,$5C,$25,$29,$2D,$30,$33,$B6,$37,$40,$4B
  DEFB $4F,$54,$58,$C7,$21,$4A,$A5,$26,$28,$2C,$30,$33,$36,$40,$43,$4C
  DEFB $5C,$4F,$54,$59,$C0,$21,$25,$C6,$27,$49,$AC,$2D,$30,$33,$36,$40
  DEFB $C7,$48,$43,$4C,$5B,$4F,$D4,$55,$59,$C0,$22,$24,$C0,$27,$2B,$C4
  DEFB $2E,$46,$B1,$33,$B6,$38,$40,$45,$81,$4D,$53,$CE,$4F,$40,$56,$5A
  DEFB $C0,$22,$24,$C0,$27,$2A,$C1,$2F,$36,$31,$C1,$39,$44,$40,$C0,$4D
  DEFB $52,$40,$56,$5A,$C0,$22,$24,$80,$28,$29,$C1,$30,$36,$B1,$32,$C1
  DEFB $39,$43,$3F,$C0,$4D,$52,$40,$57,$59,$C0,$22,$24,$C0,$33,$35,$C1
  DEFB $3A,$42,$3E,$C0,$4E,$51,$40,$57,$59,$C0,$22,$24,$C0,$33,$35,$C2
  DEFB $3A,$41,$3E,$40,$C0,$4E,$50,$40,$57,$59,$C0,$23,$23,$C0,$33,$35
  DEFB $C1,$3B,$3F,$3E,$C0,$4F,$4F,$40,$58,$58,$C0,$34,$34,$40,$3B,$3E
  DEFB $40,$3B,$3D,$40,$3C,$3C
TerrainFrozenWastes4:
  DEFB $10,$45,$23,$5B,$25,$29,$30,$44,$52,$46,$23,$5B,$25,$29,$30,$45
  DEFB $4B,$51,$47,$23,$5A,$26,$29,$30,$39,$46,$4B,$51,$48,$23,$5A,$27
  DEFB $2A,$30,$35,$39,$47,$4B,$51,$4A,$23,$59,$28,$2B,$30,$34,$38,$40
  DEFB $48,$4C,$51,$54,$4B,$24,$58,$28,$2B,$2F,$31,$34,$37,$3F,$49,$4D
  DEFB $51,$54,$C7,$24,$48,$28,$2A,$2E,$31,$34,$37,$3F,$43,$4A,$58,$4D
  DEFB $51,$55,$C7,$24,$47,$A8,$29,$AE,$2F,$31,$34,$37,$3F,$C5,$46,$43
  DEFB $4A,$57,$4D,$D1,$52,$55,$C0,$25,$27,$C0,$29,$2D,$C3,$2F,$44,$B2
  DEFB $33,$B7,$38,$3F,$81,$4B,$50,$CC,$4D,$40,$53,$56,$C0,$25,$27,$C0
  DEFB $29,$2C,$C1,$30,$37,$32,$C1,$39,$43,$3F,$C0,$4B,$4F,$40,$53,$56
  DEFB $C0,$25,$27,$80,$2A,$2B,$C1,$31,$37,$B2,$33,$C1,$39,$42,$3E,$C0
  DEFB $4B,$4F,$40,$54,$56,$C0,$25,$27,$C0,$34,$36,$81,$3A,$41,$BB,$3D
  DEFB $C0,$4C,$4E,$40,$55,$55,$C0,$26,$26,$C0,$34,$36,$C0,$3B,$3E,$40
  DEFB $4D,$4D,$C0,$35,$35,$40,$3B,$3E,$40,$3B,$3D,$40,$3C,$3C
TerrainFrozenWastes5:
  DEFB $0C,$45,$2A,$54,$2C,$2F,$34,$43,$4E,$46,$2A,$54,$2C,$2F,$34,$44
  DEFB $48,$4D,$48,$2A,$54,$2D,$30,$34,$38,$3B,$45,$48,$4D,$4A,$2B,$53
  DEFB $2E,$30,$34,$37,$3A,$40,$46,$49,$4D,$4F,$4B,$2B,$52,$2E,$30,$33
  DEFB $35,$37,$39,$3F,$47,$4A,$4D,$4F,$C8,$2C,$46,$2E,$30,$33,$35,$37
  DEFB $39,$3F,$C4,$45,$43,$48,$51,$4A,$4D,$50,$C5,$2C,$43,$AE,$2F,$B2
  DEFB $33,$36,$B9,$3A,$3F,$C1,$48,$4C,$4B,$40,$4E,$51,$C0,$2D,$2D,$C0
  DEFB $2F,$31,$C1,$34,$39,$36,$C1,$3B,$42,$3F,$C0,$48,$4B,$40,$4F,$51
  DEFB $C0,$30,$30,$81,$35,$39,$38,$81,$3C,$41,$BD,$3E,$C0,$49,$4B,$40
  DEFB $50,$50,$C0,$37,$39,$C0,$3C,$3E,$40,$4A,$4A,$C0,$38,$38,$40,$3C
  DEFB $3E,$40,$3D,$3D
TerrainFrozenWastes6:
  DEFB $09,$44,$2F,$4F,$33,$36,$42,$4A,$44,$2F,$4F,$33,$36,$43,$49,$46
  DEFB $2F,$4E,$33,$36,$3C,$3F,$44,$49,$46,$30,$4D,$33,$35,$3B,$3F,$45
  DEFB $49,$C5,$30,$44,$B2,$33,$35,$3A,$3F,$43,$02,$46,$4D,$C7,$48,$4C
  DEFB $C0,$31,$31,$C4,$34,$42,$B5,$36,$BA,$3B,$3F,$41,$C0,$46,$49,$40
  DEFB $4C,$4C,$81,$37,$3A,$39,$C1,$3C,$40,$3F,$40,$46,$48,$C0,$39,$39
  DEFB $C0,$3C,$3E,$40,$47,$47,$40,$3D,$3D
TerrainFrozenWastes7:
  DEFB $07,$43,$33,$4C,$36,$42,$48,$43,$33,$4C,$36,$43,$47,$44,$33,$4B
  DEFB $36,$3C,$44,$47,$C2,$33,$43,$B5,$37,$3B,$02,$45,$4B,$46,$4A,$C0
  DEFB $34,$34,$C2,$38,$42,$BB,$3C,$41,$C0,$45,$47,$40,$4A,$4A,$80,$39
  DEFB $3A,$81,$3D,$40,$3E,$40,$45,$47,$C0,$3E,$3E,$40,$46,$46
TerrainFrozenWastes8:
  DEFB $06,$42,$36,$4A,$42,$47,$43,$36,$4A,$3E,$43,$46,$44,$36,$49,$B8
  DEFB $39,$3D,$C3,$44,$C6,$47,$C0,$37,$37,$C2,$3A,$42,$BC,$3D,$41,$C0
  DEFB $44,$46,$40,$48,$48,$C0,$3B,$3B,$C0,$3E,$40,$40,$44,$46,$C0,$3F
  DEFB $3F,$40,$45,$45
TerrainRuin1:
  DEFB $22,$47,$18,$6E,$2E,$3A,$3D,$C3,$44,$46,$48,$D1,$53,$49,$18,$6D
  DEFB $2D,$B9,$3A,$3D,$C3,$44,$46,$48,$D4,$56,$5C,$EA,$6C,$47,$19,$69
  DEFB $2C,$B5,$39,$3D,$C3,$44,$46,$48,$D7,$5B,$48,$1A,$68,$9B,$1C,$2B
  DEFB $35,$3D,$C3,$44,$46,$48,$5A,$48,$1D,$67,$9E,$20,$A8,$2A,$B4,$35
  DEFB $3D,$46,$C8,$4B,$5A,$E2,$66,$47,$1E,$65,$27,$29,$34,$3D,$46,$CB
  DEFB $4D,$5A,$46,$1E,$65,$29,$34,$3D,$C6,$49,$4D,$5A,$C2,$1E,$46,$29
  DEFB $B4,$3D,$42,$49,$65,$CA,$4D,$5A,$C1,$1E,$34,$29,$C0,$3D,$46,$42
  DEFB $4D,$65,$CE,$51,$5A,$C1,$1E,$34,$29,$81,$3D,$46,$C3,$45,$41,$51
  DEFB $65,$5A,$C1,$1E,$34,$29,$80,$42,$46,$41,$51,$65,$D2,$5A,$C2,$1E
  DEFB $34,$29,$33,$40,$5A,$65,$C2,$1E,$33,$29,$B0,$32,$41,$5A,$65,$DB
  DEFB $5C,$C2,$1E,$31,$29,$30,$40,$5D,$65,$C1,$1E,$30,$29,$40,$5D,$65
  DEFB $C1,$1E,$30,$29,$41,$5E,$65,$64,$C1,$1E,$30,$29,$00,$5E,$63,$42
  DEFB $1E,$30,$29,$AD,$2F,$43,$1E,$2D,$A1,$22,$29,$2C,$42,$1E,$2C,$A1
  DEFB $22,$29,$42,$1E,$2C,$A1,$22,$A9,$2B,$41,$1E,$29,$A1,$22,$41,$1E
  DEFB $29,$A1,$22,$40,$1E,$29,$40,$1E,$29,$41,$1E,$29,$28,$41,$1E,$28
  DEFB $27,$42,$1E,$27,$21,$23,$03,$1E,$27,$1F,$22,$A5,$26,$00,$1D,$27
  DEFB $40,$1D,$27,$40,$1D,$26,$40,$1D,$25,$00,$1D,$25
TerrainRuin2:
  DEFB $18,$47,$24,$60,$33,$3C,$3E,$42,$44,$46,$CC,$4D,$C2,$25,$3B,$32
  DEFB $B9,$3A,$45,$3E,$5F,$42,$44,$46,$CE,$53,$DD,$5E,$47,$26,$5C,$31
  DEFB $38,$3E,$42,$44,$46,$52,$48,$27,$5B,$A8,$29,$AF,$30,$38,$3E,$44
  DEFB $C6,$48,$52,$D8,$5A,$47,$28,$5A,$2E,$30,$37,$3E,$44,$49,$52,$44
  DEFB $28,$5A,$30,$B7,$3E,$C4,$49,$52,$C1,$28,$37,$30,$81,$3E,$44,$C2
  DEFB $43,$42,$49,$5A,$CA,$4C,$52,$C1,$28,$37,$30,$80,$41,$44,$41,$4C
  DEFB $5A,$CD,$52,$C2,$28,$36,$30,$35,$41,$52,$5A,$53,$C1,$28,$35,$30
  DEFB $40,$54,$5A,$C1,$28,$35,$30,$40,$54,$5A,$C1,$28,$35,$30,$00,$55
  DEFB $5A,$42,$28,$34,$30,$33,$42,$28,$32,$AA,$2B,$30,$42,$28,$31,$AA
  DEFB $2B,$30,$41,$28,$30,$AA,$2B,$40,$28,$30,$40,$28,$30,$41,$28,$2F
  DEFB $2E,$42,$28,$2E,$2A,$2C,$00,$27,$2E,$40,$27,$2E,$40,$27,$2D,$00
  DEFB $27,$2D
TerrainRuin3:
  DEFB $11,$45,$2C,$57,$36,$BD,$3E,$41,$43,$C8,$49,$47,$2D,$56,$35,$BB
  DEFB $3C,$3E,$41,$43,$CA,$4D,$D4,$55,$46,$2E,$53,$34,$3A,$3E,$C3,$45
  DEFB $4D,$D1,$52,$46,$2F,$52,$34,$39,$3E,$43,$46,$4D,$44,$2F,$52,$34
  DEFB $B9,$40,$C3,$48,$4D,$C1,$2F,$39,$34,$80,$40,$43,$01,$48,$52,$CE
  DEFB $51,$C1,$2F,$39,$34,$40,$4D,$52,$C1,$2F,$38,$34,$40,$4E,$52,$C1
  DEFB $2F,$38,$34,$00,$4F,$52,$43,$2F,$37,$31,$34,$36,$42,$2F,$35,$31
  DEFB $34,$41,$2F,$34,$31,$40,$2F,$34,$40,$2F,$33,$00,$2E,$33,$40,$2E
  DEFB $33,$00,$2E,$32
TerrainRuin4:
  DEFB $0F,$45,$2E,$54,$37,$BD,$3E,$40,$42,$C6,$47,$47,$2F,$53,$36,$BB
  DEFB $3C,$3E,$40,$42,$C8,$4B,$D1,$52,$46,$2F,$50,$35,$3A,$3E,$C2,$44
  DEFB $4B,$CE,$4F,$C3,$30,$42,$35,$39,$3E,$41,$45,$4F,$4B,$82,$30,$42
  DEFB $B1,$34,$B6,$38,$01,$45,$4F,$CC,$4E,$C1,$30,$39,$35,$40,$4B,$4F
  DEFB $C1,$30,$38,$35,$40,$4C,$4F,$C1,$30,$38,$35,$00,$4D,$4F,$42,$30
  DEFB $37,$32,$35,$42,$30,$36,$32,$35,$41,$30,$35,$32,$40,$30,$34,$00
  DEFB $2F,$34,$40,$2F,$34,$00,$2F,$33
TerrainRuin5:
  DEFB $0C,$44,$33,$4F,$39,$3F,$42,$45,$46,$33,$4E,$39,$3D,$3F,$42,$C6
  DEFB $48,$4D,$47,$33,$4C,$34,$38,$3C,$3F,$C2,$44,$48,$4B,$82,$34,$42
  DEFB $B5,$37,$B9,$3B,$01,$44,$4B,$C9,$4A,$C1,$34,$3B,$38,$40,$48,$4B
  DEFB $C1,$34,$3A,$38,$00,$49,$4B,$02,$34,$39,$35,$37,$41,$34,$38,$36
  DEFB $40,$34,$38,$00,$33,$37,$40,$33,$37,$00,$33,$36
TerrainRuin6:
  DEFB $09,$44,$36,$4B,$3A,$3F,$41,$43,$45,$36,$4A,$3A,$3F,$41,$44,$46
  DEFB $03,$36,$49,$B7,$38,$BA,$3B,$C7,$48,$C1,$36,$3B,$39,$40,$46,$48
  DEFB $C1,$36,$3B,$39,$00,$46,$48,$41,$36,$3A,$39,$40,$36,$39,$40,$36
  DEFB $38,$00,$36,$38
TerrainRuin7:
  DEFB $07,$43,$38,$49,$3B,$3F,$41,$44,$38,$48,$3B,$3F,$41,$45,$02,$38
  DEFB $47,$B9,$3A,$46,$C0,$38,$3B,$00,$45,$47,$40,$38,$3B,$40,$38,$3B
  DEFB $00,$38,$3A
TerrainRuin8:
  DEFB $06,$43,$3A,$47,$3C,$3F,$41,$02,$3A,$47,$3B,$C5,$46,$C0,$3A,$3C
  DEFB $00,$44,$46,$40,$3A,$3C,$40,$3A,$3C,$00,$3A,$3B
TerrainLith1:
  DEFB $31,$46,$06,$7E,$07,$99,$1E,$CA,$4E,$DA,$5C,$F0,$78,$FC,$7D,$47
  DEFB $08,$7B,$9F,$20,$C7,$49,$5D,$E4,$66,$EE,$6F,$73,$F9,$7A,$48,$09
  DEFB $7A,$8A,$0B,$A1,$22,$46,$54,$5E,$E7,$68,$EC,$6D,$73,$47,$0C,$7B
  DEFB $8D,$0E,$A3,$25,$45,$54,$5E,$E9,$6B,$73,$46,$0F,$7C,$A6,$29,$45
  DEFB $54,$5F,$6B,$73,$47,$10,$7C,$91,$17,$AA,$2D,$45,$54,$5F,$E7,$6A
  DEFB $73,$C6,$18,$66,$19,$2E,$44,$54,$5F,$E3,$65,$41,$6A,$7C,$73,$C4
  DEFB $1A,$62,$AF,$32,$44,$55,$5E,$41,$6A,$7C,$73,$C5,$1B,$61,$B3,$34
  DEFB $44,$48,$55,$5D,$41,$6A,$7C,$73,$C5,$1C,$60,$1D,$B5,$37,$C5,$47
  DEFB $55,$DD,$5F,$C0,$6A,$72,$40,$74,$7C,$C3,$1E,$5D,$B8,$3F,$45,$55
  DEFB $42,$6A,$7C,$71,$75,$C0,$1F,$37,$C2,$40,$5D,$C1,$45,$55,$42,$6A
  DEFB $7C,$70,$75,$C1,$20,$36,$B3,$35,$C1,$45,$5D,$55,$42,$6B,$7B,$70
  DEFB $75,$81,$21,$32,$A3,$28,$C0,$35,$35,$C1,$45,$5D,$D4,$55,$42,$6C
  DEFB $7A,$70,$75,$C2,$23,$35,$A4,$28,$30,$C2,$45,$5C,$53,$56,$02,$6C
  DEFB $7A,$ED,$6E,$F8,$79,$C1,$24,$35,$30,$C2,$45,$5C,$52,$D7,$58,$42
  DEFB $6D,$79,$6E,$78,$C1,$24,$35,$30,$C2,$46,$5B,$51,$D9,$5A,$40,$6D
  DEFB $77,$C1,$24,$35,$30,$C1,$47,$5B,$CF,$50,$01,$6E,$76,$F3,$74,$C1
  DEFB $24,$35,$30,$C1,$47,$5B,$4E,$00,$73,$74,$C1,$24,$35,$30,$41,$47
  DEFB $5B,$4D,$C1,$24,$35,$30,$41,$48,$5B,$4C,$C1,$24,$35,$30,$41,$49
  DEFB $5A,$CA,$4B,$C1,$24,$35,$30,$41,$4C,$59,$58,$C1,$24,$34,$30,$41
  DEFB $4D,$57,$4E,$C1,$24,$34,$30,$00,$4F,$56,$41,$24,$34,$30,$41,$25
  DEFB $34,$30,$41,$25,$34,$30,$41,$25,$34,$30,$41,$25,$34,$30,$41,$25
  DEFB $34,$30,$41,$25,$34,$30,$41,$25,$34,$30,$41,$25,$34,$30,$41,$25
  DEFB $34,$30,$41,$25,$34,$2F,$41,$25,$33,$2F,$41,$25,$33,$2F,$41,$25
  DEFB $33,$2F,$41,$25,$33,$2F,$41,$25,$33,$2F,$41,$25,$33,$2F,$41,$25
  DEFB $33,$2F,$41,$25,$33,$2F,$41,$25,$33,$2E,$41,$25,$32,$2E,$42,$25
  DEFB $32,$A6,$27,$2E,$41,$27,$32,$2E,$00,$27,$32
TerrainLith2:
  DEFB $23,$46,$17,$6B,$18,$A5,$28,$C7,$4A,$D2,$53,$E1,$67,$6A,$49,$19
  DEFB $69,$1A,$A9,$2B,$C4,$46,$4E,$54,$D9,$5C,$DF,$60,$64,$68,$47,$1B
  DEFB $69,$9C,$1D,$AC,$2D,$43,$4E,$55,$DD,$5E,$64,$46,$1E,$6A,$AE,$2F
  DEFB $43,$4E,$56,$5E,$64,$47,$1F,$6A,$A0,$24,$B0,$33,$43,$4E,$56,$D9
  DEFB $5D,$64,$C4,$25,$58,$B4,$36,$43,$4F,$55,$41,$5D,$6A,$64,$C5,$26
  DEFB $57,$27,$B7,$39,$44,$4F,$D5,$56,$41,$5D,$6A,$E3,$64,$C3,$28,$54
  DEFB $BA,$3F,$43,$4F,$42,$5D,$6A,$62,$65,$C1,$29,$39,$B7,$38,$C2,$40
  DEFB $54,$C1,$43,$4F,$42,$5E,$69,$61,$65,$82,$2A,$38,$AC,$2F,$37,$C1
  DEFB $43,$54,$CE,$4F,$42,$5F,$68,$61,$65,$C2,$2C,$38,$AD,$2F,$35,$C2
  DEFB $43,$53,$4D,$4F,$02,$5F,$68,$60,$E6,$67,$C1,$2C,$38,$35,$C3,$43
  DEFB $53,$44,$4C,$D0,$52,$41,$60,$67,$66,$C1,$2C,$38,$35,$C1,$45,$53
  DEFB $4B,$00,$61,$65,$C1,$2C,$38,$35,$41,$45,$53,$C9,$4A,$C1,$2C,$38
  DEFB $35,$41,$45,$52,$48,$C1,$2C,$38,$35,$41,$46,$51,$C7,$48,$C1,$2C
  DEFB $37,$35,$41,$49,$50,$4A,$C1,$2C,$37,$35,$00,$4B,$4F,$41,$2C,$37
  DEFB $35,$41,$2D,$37,$35,$41,$2D,$37,$35,$41,$2D,$37,$35,$41,$2D,$37
  DEFB $35,$41,$2D,$37,$35,$41,$2D,$37,$35,$41,$2D,$36,$34,$41,$2D,$36
  DEFB $34,$41,$2D,$36,$34,$41,$2D,$36,$34,$41,$2D,$36,$34,$41,$2D,$36
  DEFB $34,$41,$2D,$35,$33,$42,$2D,$35,$2E,$33,$41,$2E,$35,$33,$00,$2E
  DEFB $35
TerrainLith3:
  DEFB $19,$45,$22,$5E,$23,$AC,$2E,$C5,$47,$4D,$D7,$5C,$47,$24,$5D,$A5
  DEFB $26,$AF,$32,$C2,$44,$4A,$4E,$56,$59,$46,$27,$5E,$33,$42,$4A,$4F
  DEFB $55,$59,$47,$28,$5E,$A9,$2B,$B4,$36,$42,$4A,$4F,$D2,$54,$59,$C5
  DEFB $2C,$51,$AD,$2E,$B7,$3A,$42,$4A,$CF,$50,$41,$54,$5E,$59,$C3,$2F
  DEFB $4E,$BB,$3F,$42,$4A,$42,$54,$5E,$58,$5A,$81,$30,$3B,$B1,$34,$C2
  DEFB $40,$4E,$C1,$42,$4A,$42,$55,$5D,$57,$5A,$82,$31,$3A,$B5,$37,$39
  DEFB $C1,$42,$4D,$C9,$4A,$01,$56,$5C,$5B,$C1,$31,$3A,$38,$C3,$42,$4D
  DEFB $43,$48,$CB,$4C,$40,$57,$5B,$C1,$31,$3A,$38,$C1,$43,$4D,$C6,$47
  DEFB $00,$58,$5A,$C1,$31,$3A,$38,$41,$43,$4D,$45,$C1,$31,$3A,$38,$01
  DEFB $44,$4C,$C8,$4A,$C1,$31,$3A,$38,$00,$48,$4A,$41,$31,$3A,$38,$41
  DEFB $32,$3A,$38,$41,$32,$3A,$38,$41,$32,$3A,$38,$41,$32,$3A,$38,$41
  DEFB $32,$39,$37,$41,$32,$39,$37,$41,$32,$39,$37,$41,$32,$39,$37,$41
  DEFB $32,$38,$36,$42,$32,$38,$33,$36,$00,$33,$38
TerrainLith4:
  DEFB $16,$45,$25,$5A,$26,$AE,$2F,$C4,$45,$4B,$D4,$58,$47,$27,$59,$28
  DEFB $B0,$33,$C1,$43,$48,$4C,$53,$55,$46,$29,$5A,$34,$41,$48,$4D,$52
  DEFB $55,$47,$2A,$5A,$AB,$2D,$B5,$36,$41,$48,$4D,$CF,$51,$55,$C6,$2E
  DEFB $4E,$AF,$30,$37,$BC,$3E,$41,$48,$4D,$41,$51,$5A,$55,$81,$31,$3B
  DEFB $B2,$35,$C2,$3F,$4C,$C0,$41,$48,$42,$52,$59,$54,$56,$82,$32,$3A
  DEFB $B6,$37,$39,$C1,$41,$4B,$C7,$48,$01,$53,$58,$57,$C1,$32,$3A,$38
  DEFB $C2,$41,$4B,$46,$C9,$4A,$40,$53,$57,$C1,$32,$3A,$38,$C1,$42,$4B
  DEFB $45,$00,$54,$56,$C1,$32,$3A,$38,$41,$42,$4B,$44,$C1,$32,$3A,$38
  DEFB $01,$43,$4A,$C6,$48,$C1,$32,$3A,$38,$00,$46,$48,$41,$33,$3A,$38
  DEFB $41,$33,$3A,$38,$41,$33,$3A,$38,$41,$33,$3A,$38,$41,$33,$39,$37
  DEFB $41,$33,$39,$37,$41,$33,$39,$37,$41,$33,$39,$37,$42,$33,$39,$34
  DEFB $37,$00,$34,$39
TerrainLith5:
  DEFB $11,$44,$2C,$54,$33,$C2,$44,$48,$CE,$52,$47,$2D,$53,$2E,$B4,$36
  DEFB $41,$46,$49,$4D,$50,$46,$2F,$54,$B0,$32,$B7,$38,$41,$46,$CA,$4D
  DEFB $50,$C5,$33,$4A,$34,$39,$BD,$3E,$41,$46,$41,$4D,$54,$50,$81,$35
  DEFB $3C,$B6,$38,$C2,$3F,$49,$C0,$41,$46,$02,$4E,$53,$50,$52,$82,$36
  DEFB $3C,$39,$3B,$81,$41,$48,$C2,$44,$40,$4E,$52,$C1,$36,$3C,$3A,$C1
  DEFB $42,$48,$44,$00,$4F,$51,$C1,$36,$3C,$3A,$40,$43,$47,$C1,$36,$3C
  DEFB $3A,$00,$44,$46,$41,$36,$3C,$3A,$41,$36,$3C,$3A,$41,$36,$3C,$3A
  DEFB $41,$36,$3B,$39,$41,$36,$3B,$39,$41,$36,$3B,$39,$02,$36,$3B,$38
  DEFB $3A,$00,$37,$3B
TerrainLith6:
  DEFB $0D,$44,$30,$4D,$36,$41,$46,$CA,$4C,$47,$31,$4E,$32,$B7,$38,$40
  DEFB $44,$46,$49,$4C,$46,$33,$4E,$B4,$36,$39,$40,$44,$C7,$49,$4C,$83
  DEFB $37,$46,$B8,$39,$C1,$43,$45,$01,$49,$4E,$4D,$82,$38,$3D,$3A,$3C
  DEFB $81,$40,$45,$C1,$42,$40,$4A,$4D,$C1,$38,$3D,$3B,$C1,$41,$45,$42
  DEFB $00,$4B,$4C,$C1,$38,$3D,$3B,$00,$43,$44,$41,$38,$3D,$3B,$41,$38
  DEFB $3D,$3B,$41,$38,$3C,$3A,$41,$38,$3C,$3A,$41,$38,$3C,$3A,$00,$39
  DEFB $3C
TerrainLith7:
  DEFB $0B,$44,$33,$4A,$B8,$39,$41,$45,$49,$46,$34,$4B,$35,$3A,$40,$43
  DEFB $45,$48,$04,$36,$4B,$3A,$C1,$42,$44,$C9,$4A,$C0,$3A,$3E,$C1,$40
  DEFB $44,$43,$40,$48,$4B,$C0,$3A,$3E,$81,$41,$44,$43,$00,$49,$4A,$C0
  DEFB $3A,$3E,$40,$43,$43,$40,$3A,$3E,$40,$3A,$3D,$40,$3A,$3D,$40,$3A
  DEFB $3D,$00,$3B,$3D
TerrainLith8:
  DEFB $09,$43,$36,$48,$41,$44,$47,$44,$37,$49,$3A,$40,$44,$47,$02,$38
  DEFB $49,$C1,$43,$48,$C0,$3B,$3E,$80,$41,$43,$40,$48,$48,$40,$3B,$3E
  DEFB $40,$3B,$3E,$40,$3B,$3E,$40,$3B,$3E,$00,$3C,$3D
TerrainCavern1:
  DEFB $14,$44,$13,$6E,$94,$17,$2F,$B3,$38,$CB,$4F,$45,$18,$6D,$99,$1C
  DEFB $2F,$B3,$38,$C8,$4A,$EB,$6C,$44,$1D,$6A,$9E,$22,$2F,$B3,$38,$C5
  DEFB $47,$44,$23,$69,$A4,$26,$2F,$B3,$37,$C3,$44,$44,$27,$68,$30,$B3
  DEFB $37,$C1,$42,$E5,$67,$43,$28,$64,$30,$B4,$37,$40,$44,$29,$63,$31
  DEFB $B5,$36,$3F,$E1,$62,$41,$2A,$60,$B2,$35,$40,$2B,$60,$41,$2C,$5F
  DEFB $DC,$5E,$41,$2D,$5B,$C6,$4A,$42,$2D,$5A,$C4,$45,$59,$41,$2E,$58
  DEFB $43,$41,$2F,$57,$BF,$42,$43,$30,$56,$B1,$32,$BC,$3E,$55,$41,$33
  DEFB $54,$B4,$3B,$40,$3C,$53,$41,$3D,$52,$CD,$51,$42,$3E,$4C,$3F,$C7
  DEFB $4B,$00,$40,$46
TerrainCavern2:
  DEFB $0E,$44,$20,$60,$A1,$23,$34,$B7,$3A,$C8,$4A,$45,$24,$5F,$A5,$2B
  DEFB $34,$B7,$3A,$C4,$47,$5E,$44,$2C,$5D,$2D,$34,$B7,$3A,$C2,$43,$44
  DEFB $2E,$5C,$35,$B7,$3A,$41,$DA,$5B,$44,$2F,$59,$35,$B8,$3A,$BF,$40
  DEFB $D7,$58,$41,$30,$56,$B6,$39,$41,$31,$55,$54,$41,$32,$53,$C4,$47
  DEFB $42,$33,$52,$C2,$43,$51,$41,$34,$50,$BF,$41,$42,$35,$4F,$36,$3E
  DEFB $42,$37,$4E,$B8,$3D,$4D,$41,$3E,$4C,$C9,$4B,$00,$3F,$48
TerrainCavern3:
  DEFB $0A,$44,$2B,$57,$AC,$2E,$37,$B9,$3B,$C5,$47,$45,$2F,$56,$B0,$32
  DEFB $37,$B9,$3B,$C1,$44,$55,$44,$33,$54,$38,$BA,$3B,$40,$53,$44,$34
  DEFB $52,$38,$BA,$3B,$3F,$D0,$51,$42,$35,$4F,$B9,$3A,$4E,$41,$36,$4D
  DEFB $C3,$45,$43,$37,$4C,$38,$C0,$42,$4B,$41,$39,$4A,$3F,$01,$3A,$49
  DEFB $BF,$44,$00,$3F,$44
TerrainCavern4:
  DEFB $09,$43,$2D,$54,$AE,$30,$B8,$3B,$C4,$45,$44,$31,$53,$B2,$33,$B8
  DEFB $3B,$C0,$43,$52,$43,$34,$51,$B8,$3B,$3F,$50,$43,$35,$4F,$B9,$3A
  DEFB $3E,$CD,$4E,$42,$36,$4C,$C2,$44,$4B,$43,$37,$4A,$38,$C0,$41,$49
  DEFB $41,$39,$48,$3F,$01,$3A,$47,$BF,$43,$00,$3F,$43
TerrainCavern5:
  DEFB $07,$43,$32,$4F,$B3,$34,$BA,$3C,$4E,$43,$35,$4D,$36,$BA,$3C,$4C
  DEFB $43,$37,$4B,$38,$3B,$4A,$42,$39,$49,$C2,$43,$48,$41,$3A,$47,$C0
  DEFB $41,$01,$3B,$46,$C0,$42,$00,$40,$42
TerrainCavern6:
  DEFB $06,$43,$36,$4B,$37,$BB,$3C,$4A,$41,$38,$49,$BB,$3C,$43,$39,$48
  DEFB $3A,$C1,$42,$C6,$47,$41,$3B,$45,$40,$01,$3C,$44,$C0,$41,$00,$40
  DEFB $41
TerrainCavern7:
  DEFB $05,$43,$38,$49,$39,$BC,$3D,$48,$41,$3A,$47,$BC,$3D,$42,$3B,$46
  DEFB $40,$C4,$45,$01,$3C,$43,$C0,$41,$00,$40,$41
TerrainCavern8:
  DEFB $03,$41,$3A,$47,$3C,$42,$3B,$46,$3F,$C4,$45,$80,$3C,$3E,$00,$40
  DEFB $43
TerrainArmy1:
  DEFB $23,$00,$0E,$74,$00,$0E,$74,$61,$0E,$74,$11,$14,$17,$1A,$1D,$20
  DEFB $23,$26,$29,$2C,$2F,$32,$35,$38,$3B,$3E,$41,$44,$47,$4A,$4D,$50
  DEFB $53,$56,$59,$5C,$5F,$62,$65,$68,$6B,$6E,$71,$61,$0E,$74,$11,$14
  DEFB $17,$1A,$1D,$20,$23,$26,$29,$2C,$2F,$32,$35,$38,$3B,$3E,$41,$44
  DEFB $47,$4A,$4D,$50,$53,$56,$59,$5C,$5F,$62,$65,$68,$6B,$6E,$71,$00
  DEFB $0E,$74,$22,$0E,$73,$0F,$12,$15,$18,$1B,$1E,$21,$24,$27,$2A,$2D
  DEFB $30,$33,$36,$39,$3C,$3F,$42,$45,$48,$4B,$4E,$51,$54,$57,$5A,$5D
  DEFB $60,$63,$66,$69,$6C,$6F,$72,$00,$0E,$73,$C0,$10,$10,$1D,$15,$6B
  DEFB $16,$19,$1C,$1F,$22,$25,$28,$2B,$2E,$31,$34,$37,$3A,$3D,$40,$43
  DEFB $46,$49,$4C,$4F,$52,$55,$58,$5B,$5E,$61,$64,$67,$6A,$C0,$10,$10
  DEFB $00,$15,$6B,$C0,$10,$10,$C0,$1E,$1E,$C0,$29,$29,$C0,$3A,$3A,$C0
  DEFB $4B,$4B,$40,$57,$57,$C0,$10,$10,$C0,$1E,$1E,$C0,$29,$29,$C0,$3A
  DEFB $3A,$C0,$4B,$4B,$40,$57,$57,$C0,$10,$10,$C0,$1E,$1E,$C0,$29,$29
  DEFB $C0,$3A,$3A,$C0,$4B,$4B,$40,$57,$57,$80,$10,$17,$C0,$1E,$1E,$80
  DEFB $29,$41,$C0,$4B,$4B,$40,$57,$57,$C0,$10,$17,$C0,$1E,$1E,$C0,$29
  DEFB $41,$C0,$4B,$4B,$40,$57,$57,$C0,$10,$17,$C0,$1E,$1E,$C0,$29,$41
  DEFB $00,$4B,$5F,$C0,$10,$17,$C0,$1E,$1E,$C0,$29,$41,$41,$4B,$5F,$57
  DEFB $C0,$10,$17,$C0,$1E,$1E,$C0,$29,$41,$41,$4B,$5F,$57,$C0,$10,$17
  DEFB $C0,$1E,$1E,$C0,$29,$41,$C1,$4B,$5F,$57,$00,$6A,$72,$C0,$10,$17
  DEFB $81,$1E,$41,$B7,$40,$02,$4B,$72,$CC,$56,$EB,$71,$C0,$10,$17,$C1
  DEFB $1E,$41,$36,$41,$4B,$72,$57,$C0,$10,$17,$C1,$1E,$41,$35,$41,$4B
  DEFB $72,$57,$C0,$10,$17,$C1,$1E,$41,$34,$41,$4B,$72,$57,$C0,$10,$17
  DEFB $C1,$1E,$41,$33,$41,$4B,$72,$57,$C0,$10,$17,$C1,$1E,$41,$32,$41
  DEFB $4B,$72,$CC,$57,$C0,$10,$17,$C2,$1E,$49,$31,$C1,$48,$40,$57,$72
  DEFB $C0,$10,$17,$C3,$1E,$52,$30,$41,$C9,$51,$40,$57,$72,$C0,$10,$17
  DEFB $42,$1E,$72,$AF,$41,$D2,$5B,$C0,$10,$17,$C0,$1E,$30,$41,$3A,$72
  DEFB $DB,$63,$C0,$10,$17,$C0,$1E,$31,$41,$3A,$72,$63,$C0,$10,$17,$C0
  DEFB $1E,$32,$41,$3A,$72,$DB,$63,$C0,$10,$17,$C0,$1E,$33,$41,$3A,$72
  DEFB $D2,$5B,$C0,$10,$17,$C0,$1E,$34,$C1,$3A,$52,$C9,$51,$40,$57,$72
  DEFB $C0,$10,$17,$C0,$1E,$35,$80,$3A,$49,$41,$57,$72,$EA,$71,$C0,$10
  DEFB $17,$C0,$1E,$36,$00,$57,$6A,$80,$10,$17,$00,$1E,$36
TerrainArmy2:
  DEFB $19,$00,$1D,$64,$00,$1D,$64,$61,$1D,$64,$1F,$21,$23,$25,$27,$29
  DEFB $2C,$2E,$30,$32,$34,$36,$38,$3A,$3C,$3E,$41,$43,$45,$47,$49,$4B
  DEFB $4D,$4F,$51,$53,$56,$58,$5A,$5C,$5E,$60,$62,$00,$1D,$64,$00,$1D
  DEFB $64,$C0,$1E,$1E,$0C,$22,$5E,$2B,$2D,$2F,$31,$40,$42,$44,$46,$55
  DEFB $57,$59,$5B,$C0,$1E,$1E,$00,$22,$5E,$C0,$1E,$1E,$C0,$28,$28,$C0
  DEFB $30,$30,$C0,$3C,$3C,$C0,$48,$48,$40,$50,$50,$80,$1E,$23,$C0,$28
  DEFB $28,$80,$30,$41,$C0,$48,$48,$40,$50,$50,$C0,$1E,$23,$C0,$28,$28
  DEFB $C0,$30,$41,$C0,$48,$48,$40,$50,$50,$C0,$1E,$23,$C0,$28,$28,$C0
  DEFB $30,$41,$00,$48,$56,$C0,$1E,$23,$C0,$28,$28,$C0,$30,$41,$41,$48
  DEFB $56,$50,$C0,$1E,$23,$C0,$28,$28,$C0,$30,$41,$C1,$48,$56,$50,$00
  DEFB $5D,$63,$C0,$1E,$23,$81,$28,$41,$BA,$40,$02,$48,$63,$C9,$4F,$DE
  DEFB $62,$C0,$1E,$23,$C1,$28,$41,$38,$41,$48,$63,$50,$C0,$1E,$23,$C1
  DEFB $28,$41,$37,$41,$48,$63,$50,$C0,$1E,$23,$C1,$28,$41,$36,$41,$48
  DEFB $63,$C9,$50,$C0,$1E,$23,$C2,$28,$46,$35,$C1,$45,$40,$50,$63,$C0
  DEFB $1E,$23,$03,$28,$63,$A9,$33,$C2,$45,$D9,$62,$C0,$1E,$23,$C0,$28
  DEFB $35,$41,$3C,$63,$58,$C0,$1E,$23,$C0,$28,$36,$41,$3C,$63,$D3,$58
  DEFB $C0,$1E,$23,$C0,$28,$37,$41,$3C,$63,$CC,$53,$C0,$1E,$23,$C0,$28
  DEFB $38,$80,$3C,$4C,$41,$50,$63,$DD,$62,$C0,$1E,$23,$C0,$28,$39,$00
  DEFB $50,$5D,$80,$1E,$23,$00,$28,$39
TerrainArmy3:
  DEFB $12,$00,$27,$59,$00,$27,$59,$58,$27,$59,$29,$2B,$2D,$2F,$31,$33
  DEFB $35,$37,$39,$3B,$3D,$3F,$41,$43,$45,$47,$49,$4B,$4D,$4F,$51,$53
  DEFB $55,$57,$00,$27,$59,$C0,$27,$27,$00,$2A,$55,$C0,$27,$27,$C0,$2F
  DEFB $2F,$C0,$34,$34,$C0,$3D,$3D,$C0,$45,$45,$40,$4B,$4B,$80,$27,$2B
  DEFB $C0,$2F,$2F,$80,$34,$40,$C0,$45,$45,$40,$4B,$4B,$C0,$27,$2B,$C0
  DEFB $2F,$2F,$C0,$34,$40,$00,$45,$4F,$C0,$27,$2B,$C0,$2F,$2F,$C0,$34
  DEFB $40,$41,$45,$4F,$4B,$C0,$27,$2B,$81,$2F,$40,$BC,$3F,$01,$45,$59
  DEFB $C6,$4A,$C0,$27,$2B,$C1,$2F,$40,$3A,$41,$45,$59,$4B,$C0,$27,$2B
  DEFB $C1,$2F,$40,$39,$41,$45,$59,$C6,$4B,$C0,$27,$2B,$C2,$2F,$44,$38
  DEFB $C0,$43,$40,$4B,$59,$C0,$27,$2B,$42,$2F,$59,$B7,$40,$C4,$4C,$C0
  DEFB $27,$2B,$C0,$2F,$38,$41,$3D,$59,$CC,$50,$C0,$27,$2B,$C0,$2F,$39
  DEFB $41,$3D,$59,$C8,$4B,$C0,$27,$2B,$C0,$2F,$3A,$80,$3D,$48,$00,$4B
  DEFB $59,$80,$27,$2B,$00,$2F,$3B
TerrainArmy4:
  DEFB $10,$00,$29,$55,$00,$29,$55,$55,$29,$55,$2B,$2D,$2F,$31,$33,$35
  DEFB $37,$39,$3B,$3D,$3F,$41,$43,$45,$47,$49,$4B,$4D,$4F,$51,$53,$00
  DEFB $29,$55,$C0,$29,$29,$80,$2F,$35,$00,$40,$52,$80,$29,$2D,$C0,$30
  DEFB $30,$80,$35,$3F,$C0,$44,$44,$40,$49,$49,$C0,$29,$2D,$C0,$30,$30
  DEFB $C0,$35,$3F,$00,$44,$4D,$C0,$29,$2D,$C0,$30,$30,$C0,$35,$3F,$41
  DEFB $44,$4D,$49,$C0,$29,$2D,$81,$30,$3F,$BC,$3E,$01,$44,$55,$C5,$48
  DEFB $C0,$29,$2D,$C1,$30,$3F,$3A,$41,$44,$55,$49,$C0,$29,$2D,$C1,$30
  DEFB $3F,$39,$41,$44,$55,$49,$C0,$29,$2D,$02,$30,$55,$B1,$37,$CB,$54
  DEFB $C0,$29,$2D,$C0,$30,$38,$41,$3D,$55,$4A,$C0,$29,$2D,$C0,$30,$39
  DEFB $41,$3D,$55,$C6,$49,$C0,$29,$2D,$C0,$30,$3A,$80,$3D,$46,$00,$49
  DEFB $55,$80,$29,$2D,$00,$30,$3B
TerrainArmy5:
  DEFB $0C,$00,$2F,$50,$4F,$2F,$50,$32,$34,$36,$38,$3A,$3C,$3E,$40,$42
  DEFB $44,$46,$48,$4A,$4C,$4E,$00,$2F,$50,$C0,$2F,$2F,$C0,$34,$34,$C0
  DEFB $38,$38,$C0,$43,$43,$40,$47,$47,$80,$2F,$32,$C0,$34,$34,$80,$38
  DEFB $3F,$C0,$43,$43,$40,$47,$47,$C0,$2F,$32,$C0,$34,$34,$C0,$38,$3F
  DEFB $00,$43,$47,$C0,$2F,$32,$81,$34,$3F,$BD,$3E,$01,$43,$50,$C4,$46
  DEFB $C0,$2F,$32,$C1,$34,$3F,$3C,$41,$43,$50,$47,$C0,$2F,$32,$02,$34
  DEFB $50,$B5,$3A,$C9,$4F,$C0,$2F,$32,$C0,$34,$3A,$41,$3E,$50,$48,$C0
  DEFB $2F,$32,$C0,$34,$3B,$41,$3E,$50,$C5,$47,$80,$2F,$32,$80,$34,$3C
  DEFB $80,$3E,$45,$00,$47,$50
TerrainArmy6:
  DEFB $09,$00,$33,$4C,$0C,$33,$4C,$34,$37,$39,$3B,$3D,$3F,$41,$43,$45
  DEFB $47,$49,$4B,$00,$33,$4C,$C0,$33,$36,$C0,$39,$3F,$C0,$42,$42,$40
  DEFB $45,$45,$C0,$33,$36,$C0,$39,$3F,$00,$42,$45,$82,$33,$3F,$B4,$35
  DEFB $BD,$3E,$01,$42,$4C,$C3,$44,$03,$33,$4C,$B4,$35,$B7,$3B,$C7,$4B
  DEFB $C1,$33,$3C,$36,$41,$3E,$4C,$46,$80,$33,$3C,$00,$3E,$4C
TerrainArmy7:
  DEFB $07,$00,$36,$4A,$49,$36,$4A,$38,$3A,$3C,$3E,$40,$42,$44,$46,$48
  DEFB $00,$36,$4A,$C0,$36,$38,$C0,$3B,$3F,$40,$42,$44,$82,$36,$3F,$37
  DEFB $3E,$01,$42,$4A,$43,$C2,$36,$3F,$38,$BD,$3E,$41,$42,$4A,$C3,$44
  DEFB $80,$36,$3D,$00,$44,$4A
TerrainArmy8:
  DEFB $06,$00,$38,$48,$47,$38,$48,$3A,$3C,$3E,$40,$42,$44,$46,$00,$38
  DEFB $48,$C1,$38,$3E,$3A,$01,$41,$48,$42,$C1,$38,$3E,$3A,$41,$41,$48
  DEFB $C2,$43,$80,$38,$3E,$00,$43,$48

; Character lookup table, each entry consisting of 6-bytes.
;
; NOTE: bytes 3-4 and 5-6 of each line look like Big Endian addresses
CharacterLookupTable:
  DEFB $04,$07,$D1,$50,$D2,$94
  DEFB $04,$07,$D1,$6C,$D2,$B0
  DEFB $04,$07,$D1,$88,$D2,$CC
  DEFB $04,$07,$D1,$A4,$D2,$E8
  DEFB $04,$07,$D1,$C0,$D3,$04
  DEFB $04,$03,$D1,$DC,$D3,$20
  DEFB $04,$06,$D1,$E8,$D3,$2C
  DEFB $04,$07,$D2,$00,$D3,$44
  DEFB $03,$05,$D2,$1C,$D3,$60
  DEFB $03,$05,$D2,$2B,$D3,$6F
  DEFB $03,$05,$D2,$3A,$D3,$7E
  DEFB $04,$06,$D2,$49,$D3,$8D
  DEFB $03,$04,$D2,$61,$D3,$A5
  DEFB $04,$06,$D2,$6D,$D3,$B1
  DEFB $03,$05,$D2,$85,$D3,$C9
  DEFB $04,$07,$D1,$6C,$D3,$D8
  DEFB $03,$05,$D2,$1C,$D3,$F4

; Character Construction
CharConstructTable:
  DEFB $00,$01,$02,$00,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C
  DEFB $0D,$0E,$0F,$10,$11,$12,$00,$13,$14,$15,$16,$17,$18,$19
  DEFB $00,$1A,$1B,$1C,$03,$1D,$1E,$06,$07,$08,$09,$0A,$0B,$0C
  DEFB $0D,$0E,$0F,$10,$11,$12,$00,$13,$14,$15,$16,$17,$18,$19
  DEFB $00,$1F,$20,$21,$03,$1D,$22,$06,$07,$08,$09,$0A,$0B,$0C
  DEFB $0D,$0E,$0F,$10,$11,$12,$00,$13,$14,$15,$16,$17,$18,$19
  DEFB $00,$23,$24,$25,$03,$04,$26,$27,$07,$08,$28,$29,$0B,$0C
  DEFB $2A,$2B,$0F,$10,$11,$12,$00,$13,$14,$15,$16,$17,$18,$19
  DEFB $00,$00,$2C,$2D,$03,$2E,$2F,$30,$07,$31,$32,$33,$0B,$0C
  DEFB $34,$35,$0F,$10,$36,$12,$00,$13,$14,$15,$16,$17,$18,$19
  DEFB $37,$38,$00,$00,$39,$3A,$3B,$3C,$3D,$3E,$3F,$00
  DEFB $00,$40,$41,$00,$42,$43,$44,$45,$46,$47,$48,$49
  DEFB $4A,$3A,$4B,$4C,$4D,$4E,$4F,$50,$51,$52,$53,$54
  DEFB $00,$55,$56,$00,$57,$58,$59,$5A,$5B,$5C,$5D,$5E,$5F,$60
  DEFB $61,$62,$63,$64,$65,$66,$00,$67,$68,$00,$00,$69,$6A,$00
  DEFB $6B,$6C,$6D,$6E,$6F,$70,$71,$72,$73,$74,$75,$76,$00,$77,$78
  DEFB $79,$7A,$7B,$7C,$7D,$7E,$7F,$80,$81,$82,$83,$84,$85,$86,$87
  DEFB $88,$89,$8A,$8B,$8C,$8D,$8E,$8F,$90,$91,$92,$93,$94,$95,$96
  DEFB $97,$00,$00,$00,$98,$2C,$2D,$00,$99,$9A,$9B,$00
  DEFB $9C,$9D,$9E,$00,$9F,$A0,$A1,$A2,$A3,$A4,$A5,$A6
  DEFB $00,$A7,$00,$A8,$A9,$AA,$AB,$AC,$AD,$AE,$AF,$B0
  DEFB $03,$2E,$00,$00,$07,$B1,$B2,$B3,$0B,$0C,$3A,$35
  DEFB $0F,$10,$3A,$12,$00,$13,$14,$15,$16,$17,$18,$19
  DEFB $B4,$B5,$B6,$B7,$B8,$B9,$BA,$BB,$BC,$BD,$BE,$BF
  DEFB $C0,$C1,$C2

; Character construction Attributes
CharConstructAttrs:
  DEFB $78,$78,$7A,$78,$78,$78,$3A,$7B,$78,$78,$69,$7B,$78,$78
  DEFB $60,$78,$78,$78,$70,$78,$78,$78,$78,$78,$78,$78,$78,$78
  DEFB $78,$7E,$7A,$7E,$78,$78,$79,$7D,$78,$78,$72,$7D,$78,$78
  DEFB $58,$78,$78,$78,$68,$78,$78,$78,$78,$78,$78,$78,$78,$78
  DEFB $78,$78,$78,$78,$78,$78,$30,$7A,$78,$78,$60,$7A,$78,$78
  DEFB $58,$78,$78,$78,$68,$78,$78,$78,$78,$78,$78,$78,$78,$78
  DEFB $78,$78,$7B,$7B,$7A,$7A,$7B,$7B,$7A,$7A,$7B,$7B,$7A,$7A
  DEFB $72,$7A,$7A,$7A,$42,$7A,$78,$7A,$7A,$7A,$7A,$7A,$7A,$7A
  DEFB $78,$78,$7E,$7E,$7A,$7A,$7A,$7E,$7A,$7A,$69,$78,$7A,$7A
  DEFB $62,$7A,$7A,$7A,$72,$7A,$78,$7A,$7A,$7A,$7A,$7A,$7A,$7A
  DEFB $78,$7D,$78,$78,$78,$78,$78,$78,$78,$78,$78,$78
  DEFB $78,$7A,$7A,$78,$7A,$7A,$7A,$7E,$7A,$7A,$7A,$7A
  DEFB $7A,$7A,$7A,$7A,$7A,$7A,$7A,$7A,$7A,$7A,$7A,$7A
  DEFB $78,$7B,$7B,$78,$79,$6B,$6B,$79,$79,$73,$73,$79,$79,$71
  DEFB $71,$79,$78,$71,$71,$78,$78,$7C,$7C,$78,$78,$78,$78,$78
  DEFB $7E,$7A,$7E,$7D,$72,$79,$7D,$72,$79,$7D,$72,$79,$78,$79,$79
  DEFB $78,$78,$78,$79,$61,$72,$79,$61,$72,$79,$79,$7A,$7B,$7B,$7B
  DEFB $7B,$7B,$7B,$7B,$7B,$7B,$7B,$7B,$7B,$7B,$73,$7B,$7B,$73,$7B
  DEFB $78,$78,$78,$78,$78,$7E,$7E,$78,$79,$7A,$7E,$78
  DEFB $79,$69,$79,$78,$79,$79,$79,$79,$7B,$7B,$7B,$7B
  DEFB $78,$7A,$78,$7A,$72,$7A,$7A,$4A,$7A,$7B,$7B,$7B
  DEFB $78,$78,$78,$78,$78,$78,$78,$78,$78,$78,$78,$78
  DEFB $78,$78,$78,$78,$78,$78,$78,$78,$78,$78,$78,$78
  DEFB $78,$7A,$78,$79,$79,$7B,$79,$72,$7B,$78,$7C,$78,$7A,$78,$7A
  DEFB $78,$7D,$79,$7D,$78,$78,$79,$7C,$78,$78,$69,$7C,$78,$78
  DEFB $58,$78,$78,$78,$60,$78,$78,$78,$78,$78,$78,$78,$78,$78
  DEFB $7D,$7A,$7D,$7B,$69,$79,$73,$69,$79,$7B,$69,$79,$78,$7A,$79

; Graphics for each character
CharacterGraphics:
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$08,$08,$08,$08,$08,$08,$08,$08
  DEFB $00,$18,$34,$7A,$7A,$FB,$FB,$FF,$00,$00,$04,$04,$0F,$0F,$0F,$1F
  DEFB $08,$08,$48,$68,$E8,$F9,$FB,$FF,$B3,$B3,$83,$C7,$FF,$83,$01,$FF
  DEFB $00,$00,$00,$FE,$DE,$DE,$DE,$DE,$1F,$1F,$1E,$0C,$0D,$0D,$0F,$0F
  DEFB $FB,$FD,$FD,$FE,$FF,$FF,$BF,$BF,$0E,$0E,$0E,$0E,$0E,$8E,$FF,$E1
  DEFB $DE,$DE,$DE,$5C,$7C,$B8,$B8,$D4,$1F,$1F,$1F,$1E,$0E,$01,$01,$01
  DEFB $7F,$7F,$7F,$FF,$FF,$FF,$FF,$FF,$FF,$E1,$F0,$F0,$FF,$F8,$FF,$F8
  DEFB $EC,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$01,$01,$01,$01,$01,$00,$00,$00
  DEFB $DF,$DF,$EF,$EF,$EF,$F7,$F7,$F7,$F8,$F8,$F8,$FF,$F8,$F0,$FF,$DE
  DEFB $FC,$FC,$FA,$F6,$F7,$F7,$F1,$F8,$E7,$E7,$E7,$E7,$E3,$E3,$C3,$C3
  DEFB $9E,$9C,$9C,$9C,$98,$98,$18,$18,$78,$70,$70,$70,$60,$60,$60,$60
  DEFB $00,$00,$00,$00,$00,$01,$01,$01,$C3,$C3,$C3,$C3,$E3,$E7,$C7,$C7
  DEFB $18,$18,$1C,$3C,$B8,$B8,$00,$00,$60,$60,$70,$F0,$E0,$E0,$00,$00
  DEFB $FF,$1F,$07,$03,$01,$01,$01,$00,$81,$99,$3C,$7E,$FF,$FF,$FF,$A7
  DEFB $FF,$F8,$E0,$C0,$80,$80,$80,$00,$00,$00,$40,$63,$E7,$F7,$FF,$FF
  DEFB $A7,$A7,$83,$CF,$FF,$FF,$FF,$FF,$00,$03,$06,$0C,$0F,$07,$00,$00
  DEFB $00,$3C,$7E,$FF,$FF,$FF,$99,$FF,$00,$C0,$60,$30,$F0,$E0,$00,$00
  DEFB $FF,$E7,$C3,$FF,$FF,$FF,$FF,$FF,$14,$1C,$1C,$08,$08,$08,$08,$08
  DEFB $00,$00,$00,$3E,$7F,$FF,$FF,$FF,$00,$00,$00,$00,$80,$C0,$E0,$A0
  DEFB $83,$DB,$A3,$A7,$8F,$77,$03,$07,$80,$80,$80,$C0,$C0,$E0,$E0,$E0
  DEFB $07,$05,$0E,$0F,$0F,$9F,$FF,$FF,$E0,$F0,$F0,$70,$78,$B8,$B8,$D4
  DEFB $E1,$E0,$F0,$F0,$F8,$F8,$FF,$F8,$D4,$CE,$DE,$FE,$FE,$FE,$FE,$FE
  DEFB $00,$00,$00,$00,$0F,$1F,$3F,$3F,$00,$00,$00,$00,$80,$C0,$C0,$E0
  DEFB $00,$00,$40,$60,$E0,$F0,$F8,$F8,$20,$36,$20,$28,$20,$13,$0F,$09
  DEFB $E0,$E0,$E0,$E0,$E0,$C0,$80,$00,$FC,$FF,$FF,$FF,$FF,$FC,$BC,$BF
  DEFB $FF,$C0,$81,$03,$87,$FF,$FF,$FF,$C0,$E0,$E0,$E0,$C0,$80,$80,$F0
  DEFB $F0,$F0,$E0,$E1,$C3,$C7,$FF,$E3,$FC,$FE,$FE,$FE,$FE,$FE,$FE,$FE
  DEFB $E3,$F1,$F2,$FF,$F8,$F0,$FF,$DE,$00,$00,$24,$64,$6E,$FE,$FF,$D7
  DEFB $00,$00,$00,$00,$00,$00,$00,$E0,$FF,$D7,$6F,$7F,$7F,$3F,$1F,$1F
  DEFB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$F8,$FC,$FE,$FE,$FF,$FF,$FD,$FC
  DEFB $00,$00,$00,$00,$00,$C0,$F0,$38,$0B,$0D,$05,$05,$05,$05,$0D,$03
  DEFB $E2,$C1,$C1,$81,$81,$81,$83,$00,$FC,$78,$70,$60,$60,$60,$60,$C0
  DEFB $00,$00,$48,$6C,$7C,$7E,$FF,$F5,$00,$00,$00,$00,$00,$00,$87,$FD
  DEFB $01,$03,$03,$07,$07,$07,$07,$47,$FD,$FF,$FF,$FF,$F7,$C0,$C0,$C0
  DEFB $FF,$FF,$0A,$C0,$F0,$7C,$1C,$60,$00,$00,$3C,$0E,$E0,$7C,$1F,$00
  DEFB $E7,$E7,$F3,$F3,$FB,$FD,$FD,$FD,$E0,$E1,$F3,$F7,$FE,$FD,$FF,$FF
  DEFB $FC,$FF,$FF,$00,$FF,$FF,$FF,$FF,$00,$00,$C0,$E0,$70,$F0,$F8,$F8
  DEFB $FD,$FB,$FB,$77,$77,$77,$37,$2F,$FF,$F0,$E0,$F0,$FC,$FE,$FF,$FF
  DEFB $F8,$FC,$3C,$1C,$1C,$0C,$84,$C4,$2F,$2F,$2F,$1F,$3F,$3F,$3E,$7D
  DEFB $FF,$FF,$FF,$FF,$FF,$FB,$FD,$FE,$FF,$BF,$DF,$EF,$EF,$F6,$F6,$F5
  DEFB $E4,$F0,$F8,$F8,$F8,$F8,$F8,$F0,$7D,$7B,$7B,$7B,$FB,$FD,$FE,$AA
  DEFB $FE,$FE,$87,$00,$03,$9E,$7E,$FE,$FB,$FB,$7B,$7B,$7D,$FC,$FE,$AA
  DEFB $F0,$E0,$C0,$A0,$60,$F0,$F8,$A8,$07,$1F,$3F,$3F,$7F,$7F,$FF,$FF
  DEFB $E0,$F8,$FC,$FC,$FE,$FE,$FE,$FF,$01,$00,$03,$0F,$1F,$1F,$3F,$3F
  DEFB $DF,$CF,$CB,$C9,$FF,$FF,$F9,$DF,$FB,$F3,$D3,$93,$FF,$FF,$9F,$F7
  DEFB $00,$00,$C0,$F0,$F8,$F8,$FC,$FC,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F
  DEFB $40,$73,$33,$17,$1F,$0F,$03,$00,$06,$CE,$CC,$EC,$F8,$F0,$C0,$00
  DEFB $FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$3F,$3F,$3F,$3F,$1F,$1F,$0F,$07
  DEFB $80,$80,$C0,$F8,$FF,$FF,$FF,$FF,$00,$00,$00,$78,$84,$1F,$03,$1F
  DEFB $FC,$FC,$FC,$E4,$92,$81,$F1,$81,$03,$01,$01,$01,$01,$01,$01,$01
  DEFB $FF,$FF,$1F,$00,$00,$00,$00,$FF,$02,$0C,$F0,$00,$00,$00,$00,$FF
  DEFB $F2,$84,$F8,$80,$80,$80,$80,$80,$7F,$7E,$FE,$FE,$FE,$FE,$FE,$7E
  DEFB $FE,$7E,$7F,$7F,$7F,$7F,$7F,$7E,$FE,$82,$FE,$8E,$76,$FE,$FE,$FE
  DEFB $7F,$41,$7F,$71,$6E,$7F,$7F,$7F,$FF,$3F,$0F,$07,$03,$00,$00,$01
  DEFB $99,$BD,$7E,$FF,$FF,$E5,$E5,$E1,$FE,$F8,$E0,$C0,$80,$00,$00,$00
  DEFB $1B,$3D,$7E,$7E,$7E,$FF,$FF,$FF,$F3,$FF,$A0,$A0,$A0,$A0,$A0,$A0
  DEFB $80,$C0,$C0,$C0,$C0,$E0,$F6,$FE,$E7,$C3,$DB,$DB,$DB,$DB,$C3,$E7
  DEFB $A0,$A0,$A0,$A0,$FF,$FF,$A0,$A0,$FF,$BF,$87,$86,$8F,$8F,$86,$86
  DEFB $FF,$FF,$FF,$7E,$7E,$7E,$3C,$18,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0
  DEFB $86,$86,$86,$86,$86,$86,$86,$86,$FF,$77,$77,$77,$77,$7F,$7F,$7F
  DEFB $86,$06,$06,$06,$06,$06,$86,$C2,$02,$06,$0C,$0F,$07,$00,$00,$01
  DEFB $3C,$7E,$FF,$FF,$99,$FF,$FF,$E7,$40,$60,$30,$F0,$E0,$00,$00,$80
  DEFB $07,$0F,$1F,$1F,$1F,$1F,$1F,$1F,$C3,$3C,$00,$00,$80,$80,$80,$C0
  DEFB $FF,$FB,$FB,$FB,$FB,$FB,$FB,$FB,$1F,$0F,$0F,$0F,$07,$07,$07,$03
  DEFB $C0,$E0,$F6,$FE,$FF,$FF,$FF,$FE,$FB,$FB,$FB,$FB,$FB,$FB,$FB,$FB
  DEFB $03,$03,$03,$03,$07,$0D,$19,$31,$FE,$FE,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$7E,$7E,$7E,$BC,$BC,$D8,$60,$C0,$80,$00,$00,$00,$01,$03
  DEFB $B2,$B2,$B2,$B2,$B2,$B2,$72,$F3,$C0,$C0,$C0,$C0,$C0,$C0,$E0,$F0
  DEFB $00,$01,$03,$07,$07,$05,$00,$00,$7C,$FE,$FF,$E1,$DB,$C5,$E5,$F3
  DEFB $00,$05,$07,$07,$02,$02,$02,$82,$03,$07,$0F,$0F,$1F,$1D,$1D,$1D
  DEFB $CD,$81,$80,$C0,$C1,$C1,$E1,$E1,$C2,$C2,$C2,$C2,$E2,$F2,$FA,$FF
  DEFB $1D,$1D,$1D,$1E,$1F,$0F,$0F,$0F,$E1,$F3,$F3,$F3,$F3,$FB,$FF,$FF
  DEFB $FF,$FF,$FE,$FE,$FE,$FE,$FA,$7A,$07,$07,$0B,$0B,$0D,$0D,$1D,$1D
  DEFB $F7,$F7,$F7,$E7,$E7,$E3,$E3,$E3,$7A,$BA,$BA,$BA,$BA,$B2,$B2,$B2
  DEFB $1E,$1E,$3E,$3F,$3F,$7F,$FF,$FF,$E3,$E3,$E3,$C1,$C1,$C1,$C1,$C1
  DEFB $92,$92,$C2,$C2,$C2,$E2,$E2,$F2,$20,$20,$20,$20,$20,$20,$20,$20
  DEFB $20,$20,$20,$20,$20,$F8,$70,$F0,$F0,$F8,$7C,$1E,$0F,$07,$07,$03
  DEFB $20,$36,$20,$28,$21,$93,$DF,$F1,$E0,$E0,$E0,$E0,$E0,$C0,$80,$C0
  DEFB $03,$03,$03,$03,$07,$07,$0F,$0F,$FF,$E0,$E0,$E0,$E0,$E0,$FF,$E0
  DEFB $F0,$F8,$FC,$FC,$DE,$DE,$EF,$EF,$0F,$0F,$1E,$1D,$1B,$17,$17,$07
  DEFB $FF,$7F,$FF,$FF,$FF,$FF,$E3,$C0,$F7,$F7,$FF,$CF,$8F,$DF,$FF,$FF
  DEFB $00,$80,$80,$C0,$E0,$F0,$F8,$FE

Font:
  DEFB $03,$03,$01,$01,$00,$00,$01,$03,$C0,$C0,$E0,$E0,$F0,$F0,$F8,$F8
  DEFB $7E,$1F,$0F,$07,$03,$01,$00,$00,$00,$00,$80,$C0,$E0,$F0,$FC,$FE
  DEFB $00,$00,$00,$00,$00,$00,$3C,$FF,$01,$03,$07,$03,$07,$0F,$03,$05
  DEFB $FF,$FF,$88,$AA,$FF,$FF,$E3,$DD,$80,$C0,$E0,$80,$C0,$C0,$C0,$80
  DEFB $0E,$1F,$1F,$1D,$3D,$7F,$7B,$71,$FF,$BD,$81,$81,$81,$81,$FF,$81
  DEFB $E0,$F0,$F0,$B8,$B8,$FC,$DC,$8C,$19,$1F,$33,$63,$C3,$87,$0A,$0F
  DEFB $FF,$FF,$FF,$EF,$C7,$83,$82,$83,$C8,$70,$80,$80,$80,$C0,$A0,$E0
  DEFB $FC,$FC,$FE,$FE,$FF,$FF,$BF,$BF,$00,$00,$00,$00,$00,$80,$E3,$FF
  DEFB $00,$00,$00,$00,$00,$00,$F0,$FC,$00,$04,$04,$26,$27,$23,$23,$20
  DEFB $00,$00,$18,$2C,$5E,$DF,$9F,$9F,$00,$20,$20,$60,$E0,$C0,$C0,$00
  DEFB $20,$20,$20,$20,$23,$25,$2B,$2F,$C1,$B6,$D5,$C1,$5D,$E3,$BE,$DD
  DEFB $00,$00,$3C,$6E,$6E,$DF,$DB,$DD,$25,$25,$25,$2D,$7F,$53,$5E,$7C
  DEFB $CF,$CF,$CF,$CF,$CF,$FF,$81,$FF,$DD,$DB,$DF,$6E,$6E,$3C,$00,$00
  DEFB $20,$21,$21,$21,$21,$22,$22,$22,$FF,$7E,$3C,$3C,$24,$24,$24,$42
  DEFB $00,$80,$80,$80,$80,$40,$40,$40,$22,$24,$27,$25,$25,$2B,$37,$7F
  DEFB $42,$42,$81,$81,$00,$00,$00,$00,$40,$20,$E0,$60,$A0,$B0,$B8,$FE
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$0C,$0C,$0C,$0C,$0C,$00,$0C,$00
  DEFB $66,$66,$00,$00,$00,$00,$00,$00,$7F,$41,$41,$41,$41,$41,$7F,$00
  DEFB $00,$08,$3E,$28,$3E,$0A,$3E,$08,$66,$66,$33,$00,$00,$00,$00,$00
  DEFB $33,$33,$66,$00,$00,$00,$00,$00,$0C,$0C,$18,$00,$00,$00,$00,$00
  DEFB $0C,$18,$18,$18,$18,$18,$0C,$00,$18,$0C,$0C,$0C,$0C,$0C,$18,$00
  DEFB $00,$00,$14,$08,$3E,$08,$14,$00,$00,$00,$08,$08,$3E,$08,$08,$00
  DEFB $00,$00,$00,$00,$00,$0C,$0C,$18,$00,$00,$00,$00,$3E,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$18,$18,$00,$00,$00,$02,$04,$08,$10,$20,$00
  DEFB $1C,$36,$63,$63,$63,$36,$1C,$00,$0C,$1C,$3C,$0C,$0C,$0C,$3F,$00
  DEFB $3E,$63,$73,$06,$0C,$31,$7F,$00,$7F,$46,$0C,$1E,$03,$63,$3E,$00
  DEFB $06,$0E,$1E,$36,$7F,$06,$0F,$00,$7F,$60,$7E,$63,$03,$63,$3E,$00
  DEFB $0E,$18,$30,$7E,$63,$63,$3E,$00,$7F,$46,$0C,$18,$18,$18,$18,$00
  DEFB $3E,$63,$63,$3E,$63,$63,$3E,$00,$3E,$63,$63,$3F,$06,$0C,$38,$00

CharHereTable:
  DEFB $00,$00,$0C,$0C,$00,$0C,$0C,$00
  DEFB $00,$00,$0C,$0C,$00,$0C,$0C,$18
  DEFB $00,$00,$04,$08,$10,$08,$04,$00
  DEFB $00,$00,$00,$3E,$00,$3E,$00,$00

LDB0B:
  DEFB $00,$00,$10,$08,$04,$08,$10,$00,$3E,$63,$73,$06,$0C,$00,$0C,$00
  DEFB $00,$3C,$4A,$56,$5E,$40,$3C,$00,$1C,$37,$63,$63,$7F,$33,$7B,$00
  DEFB $7E,$63,$63,$7E,$63,$63,$7E,$00,$1E,$33,$60,$60,$60,$33,$1E,$00
  DEFB $6C,$76,$63,$63,$63,$76,$6C,$00,$7F,$31,$30,$3E,$30,$31,$7F,$00
  DEFB $7F,$31,$30,$3E,$30,$30,$70,$00,$1E,$33,$60,$6F,$63,$33,$1E,$00
  DEFB $63,$63,$63,$7F,$63,$63,$63,$00,$3F,$0C,$0C,$0C,$0C,$0C,$3F,$00
  DEFB $7F,$46,$06,$06,$06,$66,$3C,$00,$63,$66,$6C,$78,$6C,$66,$63,$00
  DEFB $70,$60,$60,$60,$60,$61,$7F,$00,$63,$77,$7F,$6B,$63,$63,$63,$00
  DEFB $63,$73,$7B,$6F,$67,$63,$63,$00,$1C,$36,$63,$63,$63,$36,$1C,$00
  DEFB $6E,$73,$63,$63,$7E,$60,$60,$00,$1C,$36,$63,$63,$6B,$36,$1D,$00
  DEFB $6E,$73,$63,$63,$7E,$66,$63,$00,$3E,$63,$60,$3E,$03,$63,$3E,$00
  DEFB $7F,$59,$18,$18,$18,$18,$18,$00,$73,$33,$63,$63,$63,$63,$3E,$00
  DEFB $73,$33,$63,$63,$66,$3C,$18,$00,$76,$33,$63,$63,$6B,$6B,$36,$00
  DEFB $77,$63,$36,$1C,$36,$63,$77,$00,$77,$63,$36,$1C,$18,$18,$18,$00
  DEFB $7F,$43,$06,$0C,$18,$31,$7F,$00

CharInHereTable:
  DEFB $00

KeyReturnStatus:
  DEFB $0E

ArmyToMoveLocation:
  DEFB $08,$08

Route_One:
  DEFB $08

Route_Two:
  DEFB $08

Route_Three:
  DEFB $0E

Route_Four:
  DEFB $00

WhichMenDidCharLose:
  DEFB $00

StartofFreeTable:
  DEFW L4000

StartOfDoomDarksTable:
  DEFW $1020

LastFreeArmyInTable:
  DEFB $08

LastDoomDarksArmyInTable:
  DEFB $04

HowManyFreeArmy:
  DEFB $00

FreeArmySuccessChance:
  DEFB $00

NoOfDoomDarksDead:
  DEFB $70

WhichFreeArmy:
  DEFB $10

HowManyDoomDarksArmy:
  DEFB $10

DoomDarksArmySuccessChance:
  DEFB $10

NoOfFreeDead:
  DEFB $10

WhichDoomDarksArmy:
  DEFB $70

FreeArmyPosInTable:
  DEFB $00

DoomDarksArmyPosInTable:
  DEFB $00

NoInCharHereTable:
  DEFB $10

DoomDarksElite_Location:
  DEFB $38,$54

DoomDarksElite_Total:
  DEFB $10

DoomDarksElite_ID:
  DEFB $10

DoomDarksElite_Orders:
  DEFB $10

DoomDarksElite_Type:
  DEFB $00

Headquarters_Location:
  DEFW $0000

Headquarters_ArmyOne:
  DEFB $00

Headquarters_ArmyTwo:
  DEFB $00

WhoseRaceIsArmy:
  DEFB $00

HowManyGuardsThePlace:
  DEFB $00

WhoGuardsThePlace:
  DEFB $00

Army_DoomDarksElite:
  DEFB $FF

Army_Headquarters:
  DEFB $00

Army_Details:
  DEFB $1C

ArmyLocation:
  DEFB $22,$78

IncRidersEnergyBy:
  DEFB $20

FreeArmyHere:
  DEFB $20

DoomDarksArmyHere:
  DEFB $7E

LDC22:
  DEFB $00,$00,$00,$3D,$67,$63,$67,$3B
  DEFB $00,$60,$60,$6E,$73,$63,$73,$6E
  DEFB $00,$00,$00,$3E,$63,$60,$63,$3E
  DEFB $00,$38,$0C,$3E,$67,$63,$63,$3E
  DEFB $00,$00,$00,$3E,$63,$7F,$60,$3F
  DEFB $00,$36,$3B,$30,$30,$7C,$30,$30
  DEFB $60,$00,$00,$3E,$63,$60,$67,$3E
  DEFB $06,$60,$60,$6E,$73,$63,$66,$6F
  DEFB $00,$06,$00,$1C,$0C,$0C,$0C,$1C
  DEFB $00,$06,$00,$1C,$0C,$0C,$0C,$4C
  DEFB $38,$60,$60,$66,$6C,$78,$6C,$67
  DEFB $00,$18,$18,$18,$18,$18,$1A,$1E
  DEFB $00,$00,$00,$56,$7F,$6B,$63,$66
  DEFB $00,$00,$00,$6E,$73,$63,$66,$6F
  DEFB $00,$00,$00,$3E,$63,$63,$63,$3E
  DEFB $00,$00,$00,$6E,$73,$63,$73,$6E
  DEFB $60,$00,$00,$3B,$67,$63,$67,$3B
  DEFB $03,$00,$00,$6E,$73,$63,$7E,$63
  DEFB $00,$00,$00,$1E,$30,$1E,$47,$3E
  DEFB $00,$0C,$18,$7E,$30,$30,$32,$1C
  DEFB $00,$00,$00,$7B,$33,$63,$67,$3B
  DEFB $00,$00,$00,$76,$33,$63,$66,$3C
  DEFB $00,$00,$00,$76,$63,$6B,$3E,$14
  DEFB $00,$00

; KeyTableAddress ?? (initial value points to middle of terrain map)
KeyTableAddress:
  DEFW $7700

LDCDE:
  DEFB $36,$1C,$36,$77,$00,$00,$00,$76
  DEFB $33,$1B,$0E,$4C,$38,$00,$00,$7F
  DEFB $46,$0C,$39,$7F,$00

PosInCharHereTable:
  DEFB $00,$0E

IceFear:
  DEFW $3008

DoomDarksCitadels:
  DEFB $08

PositionOfTowerOfDespair:
  DEFW $051A              ; Hard-wired to location 0x051A

FreeArmyStillLeft:
  DEFB $00

DoomDarksArmyStillLeft:
  DEFB $00

BattleVictory:
  DEFB $08

ArmyLoopCurrent:
  DEFB $08

NoOfFreeArmiesAndChars:
  DEFB $08

TotalNoOfArmiesHere:
  DEFB $08

EnemyMoveCount:
  DEFB $08

TempTotalOfArmies:
  DEFB $08

WhatObjectFlag:
  DEFB $00

WhatObject:
  DEFB $00

ObjectToDescribe:
  DEFB $70

DoomDarks_Warriors:
  DEFW $0C10

DoomDarks_Riders:
  DEFW $1010

NoOfDeathsDescribed:
  DEFB $70

Think_TempOne:
  DEFB $00

HowManyCharsInFrontDescribed:
  DEFB $00

Think_TempThree:
  DEFB $14

ChooseKeyTable:
  DEFB $28,$00,$00,$00,$00,$00,$3C

LDD14:
  DEFB $42

CharInLocation:
  DEFB $99

TempCharRecruitingKey:
  DEFB $A1

CanCharMoveForward:
  DEFB $A1

LocationToMoveTo:
  DEFB $99,$42

PrintCharacterCount:
  DEFB $3C

ShieldInc:
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DEFB $FF,$FF,$7F,$7F,$7F,$3F,$3F,$3F,$1F,$1F,$0F,$0F,$07,$07,$03,$01
  DEFB $FF,$7F,$3F,$1F,$0F,$07,$03,$01,$FF,$FF,$FE,$FE,$FE,$FC,$FC,$FC
  DEFB $F8,$F8,$F0,$F0,$E0,$E0,$C0,$80,$FF,$FE,$FC,$F8,$F0,$E0,$C0,$80
  DEFB $0F,$C1,$E0,$F0,$F8,$F8,$FC,$FC,$FF,$FF,$7F,$3F,$1F,$0F,$07,$07
  DEFB $FC,$FE,$FE,$FE,$FE,$FE,$FE,$FC,$03,$03,$03,$03,$03,$03,$03,$03
  DEFB $FC,$FC,$F8,$F8,$F0,$E0,$C1,$0F,$07,$07,$0F,$1F,$3F,$7F,$FF,$FF
  DEFB $FE,$FF,$DE,$FE,$F6,$FF,$FC,$44,$FC,$FF,$F6,$FE,$DE,$FF,$FE,$FF
  DEFB $FF,$FF,$F7,$FF,$DF,$FF,$7F,$45,$7F,$FF,$DF,$FF,$F7,$FF,$FF,$FF
  DEFB $F7,$F7,$F7,$E3,$E3,$E3,$C5,$82,$82,$86,$CD,$E3,$FF,$FF,$FF,$FF
  DEFB $FF,$FC,$F8,$C6,$1E,$E3,$FC,$FF,$00,$18,$3C,$3C,$18,$00,$00,$81
  DEFB $FF,$3F,$1F,$63,$78,$C7,$3F,$FF,$00,$00,$FF,$F0,$F0,$FF,$FC,$FC
  DEFB $0E,$0C,$0D,$06,$00,$C0,$00,$00,$10,$10,$30,$60,$00,$03,$00,$00
  DEFB $00,$00,$FF,$0F,$0F,$FF,$3F,$3F,$F8,$F8,$F9,$F3,$E3,$D5,$D5,$FF
  DEFB $1F,$1F,$9F,$CF,$C7,$AB,$AB,$FF,$77,$22,$00,$80,$B6,$94,$80,$DC
  DEFB $7F,$60,$4F,$E0,$FF,$00,$00,$00,$FF,$00,$FF,$00,$FF,$00,$00,$00
  DEFB $F1,$03,$FF,$03,$F9,$03,$0F,$0F,$E1,$FE,$C0,$80,$9F,$1F,$1F,$FF
  DEFB $00,$00,$1F,$3F,$CF,$C7,$E3,$C3,$01,$3E,$C0,$80,$9F,$1F,$1F,$FF
  DEFB $0F,$1F,$27,$E3,$E3,$F1,$F1,$E1

; Shield Parts Construction
ShieldPartsConstructTable1:
  DEFB $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
  DEFB $01,$01,$02,$01,$01,$01,$01,$05,$03,$01,$01,$01,$01,$06,$00,$04
  DEFB $01,$01,$07,$00,$00,$00,$04,$07,$00,$00
ShieldPartsConstructTable2:
  DEFB $08,$09,$0A,$0B,$0C,$0D
ShieldPartsConstructTable3:
  DEFB $0E,$10,$0F,$11
ShieldPartsConstructTable4:
  DEFB $12,$13
ShieldPartsConstructTable5:
  DEFB $14,$15,$16
ShieldPartsConstructTable6:
  DEFB $17,$18,$19,$1A,$00,$1B,$1C,$00
ShieldPartsConstructTable7:
  DEFB $1D,$1E,$1F,$20,$21,$22,$23,$24

; Shield parts table
;
; First byte of each line is an address into the table
ShieldPartsTable:
  DEFW ShieldPartsConstructTable1,$0706
  DEFW ShieldPartsConstructTable2,$0302
  DEFW ShieldPartsConstructTable3,$0202
  DEFW ShieldPartsConstructTable4,$0201
  DEFW ShieldPartsConstructTable5,$0103
  DEFW ShieldPartsConstructTable6,$0204
  DEFW ShieldPartsConstructTable7,$0204

; Shield Construction Table
ShieldConstructTable:
  DEFB $03,$29,$0B,$32,$11,$00,$00,$00,$02,$21,$09,$33,$14,$33,$23,$00
  DEFB $02,$35,$09,$00,$00,$00,$00,$00,$05,$0C,$09,$3D,$19,$00,$00,$00
  DEFB $03,$3E,$09,$32,$22,$00,$00,$00,$02,$36,$09,$3A,$22,$00,$00,$00
  DEFB $03,$36,$09,$2A,$22,$00,$00,$00,$00,$16,$11,$00,$00,$00,$00,$00
  DEFB $05,$3E,$11,$00,$00,$00,$00,$00,$04,$3E,$11,$00,$00,$00,$00,$00
  DEFB $02,$3E,$11,$00,$00,$00,$00,$00,$06,$16,$11,$00,$00,$00,$00,$00
  DEFB $02,$36,$09,$2D,$21,$00,$00,$00,$03,$36,$09,$3D,$21,$00,$00,$00
  DEFB $04,$3D,$09,$00,$00,$00,$00,$00,$05,$15,$09,$00,$00,$00,$00,$00
  DEFB $00,$1D,$09,$00,$00,$00,$00,$00,$03,$35,$09,$00,$00,$00,$00,$00
  DEFB $07,$15,$09,$00,$00,$00,$00,$00,$07,$25,$09,$00,$00,$00,$00,$00
  DEFB $02,$31,$0A,$00,$00,$00,$00,$00,$05,$39,$0A,$00,$00,$00,$00,$00
  DEFB $07,$19,$0A,$00,$00,$00,$00,$00,$02,$32,$0A,$00,$00,$00,$00,$00
  DEFB $00,$22,$0A,$00,$00,$00,$00,$00,$00,$11,$0A,$00,$00,$00,$00,$00
  DEFB $04,$39,$0A,$00,$00,$00,$00,$00,$03,$3A,$0A,$00,$00,$00,$00,$00
  DEFB $00,$1E,$09,$24,$22,$00,$00,$00,$00,$32,$09,$1B,$1B,$00,$00,$00
  DEFB $06,$14,$09,$0B,$1B,$00,$00,$00,$02,$33,$09,$33,$14,$33,$22,$00

DescribeBattle:
  CALL Bytes_Print_Buffer
  DEFB $FC,$54,$00,$FC,$C3,$40,$FF ; 'In The Battle Of'
  DEFB $00,$00
  LD A,(CharBattleArea)
  LD (LocationArea),A
  CALL DescribeLocationArea ; Where?
  CALL CommaToBuffer
  LD B,$00
  LD A,(CharNoRiders)
  CP $00
  JR NZ,DescribeBattle_0
  LD C,A
  LD A,(CharRidersLost)
  CP C
  JR NZ,DescribeBattle_0
  INC B
DescribeBattle_0:
  LD A,(CharNoWarriors)
  CP $00
  JR NZ,DescribeBattle_1
  LD C,A
  LD A,(CharWarriorsLost)
  CP C
  JR NZ,DescribeBattle_1
  INC B
  INC B
DescribeBattle_1:
  LD A,B
  LD (WhichMenDidCharLose),A
  CP $03
  JR Z,DescribeBattle_4
  CALL FirstNameToBuffer
  LD A,$07                ; 'Lost'
  CALL A_IntoPrintBuffer
  LD A,(WhichMenDidCharLose)
  CP $01
  JR Z,DescribeBattle_2
  LD A,(CharRidersLost)
  CALL HowManyRiders
  LD A,(WhichMenDidCharLose)
  CP $02
  JR Z,DescribeBattle_3
  LD A,$87                ; 'And'
  CALL A_IntoPrintBuffer
DescribeBattle_2:
  LD A,(CharWarriorsLost)
  CALL HowManyWarriors
DescribeBattle_3:
  CALL StopToBuffer
DescribeBattle_4:
  CALL FirstNameToBuffer
  CALL Bytes_Print_Buffer
  DEFB $C6,$C7,$FF        ; 'Alone Slew'
  LD A,(CharSlew)
  CALL DisplayHowManyOf
  CALL Bytes_Print_Buffer
  DEFB $40,$00,$FC,$C8,$FE,$2E,$FF ; 'Of The Enemy.'
  LD A,(WhichMenDidCharLose)
  CP $03
  JR Z,DescribeBattle_6
  CP $01
  JR Z,DescribeBattle_5
  CALL Bytes_Print_Buffer
  DEFB $FC,$CF,$C4,$FE,$73,$C7,$FF ; 'His Riders Slew'
  LD A,(CharRidersSlew)
  CALL DisplayHowManyOf
  CALL StopToBuffer
DescribeBattle_5:
  LD A,(WhichMenDidCharLose)
  CP $02
  JR Z,DescribeBattle_6
  CALL Bytes_Print_Buffer
  DEFB $FC,$CF,$C5,$FE,$73,$C7,$FF ; 'His Warriors Slew'
  LD A,(CharWarriorsSlew)
  CALL DisplayHowManyOf
  CALL StopToBuffer
DescribeBattle_6:
  LD A,(CharBattleStatus)
  CP $00
  JR Z,BattleStillOn
  CALL Bytes_Print_Buffer
  DEFB $FC,$CA,$CB,$5C,$00,$FC,$FF ; 'Victory Went To The'
  LD A,(CharBattleStatus)
  CALL A_IntoPrintBuffer
  JP PlinkToBuffer
BattleStillOn:
  CALL Bytes_Print_Buffer
  DEFB $FC,$00,$C3,$92,$FE,$73,$FE,$21 ; 'The Battle Continues!'
  DEFB $FF
  RET

HowManyWarriors:
  LD L,A
  LD H,$00

HowManyWarriors_1:
  CALL NumberOf
  LD A,$C5                ; 'Warrior'
HowManyWarriors_1_0:
  CALL A_IntoPrintBuffer
  JP SToBuffer

HowManyRiders:
  LD L,A
  LD H,$00

HowManyRiders_1:
  CALL NumberOf
  LD A,$C4                ; 'Rider'
  JR HowManyWarriors_1_0

Mult_HL_5:
  PUSH HL
  ADD HL,HL
  ADD HL,HL
  POP DE
  ADD HL,DE
  RET

DisplayHowManyOf:
  LD L,A
  LD H,$00
  CP $00
  JR NZ,NumberOf
  LD A,$CC                ; 'None'
  JP A_IntoPrintBuffer

NumberOf:
  CALL Mult_HL_5
  JP NumberToString

HowMuch_What:
  CP $05
  JR NC,HowMuch_What_0
  LD B,C
HowMuch_What_0:
  LD C,$D1
  CP $00
  JR Z,UtterlyAffected
  CP $07
  JR Z,UtterlyAffected
  CP $01
  JR Z,VeryAffected
  CP $06
  JR Z,VeryAffected
  CP $03
  JR Z,QuiteAffected
  CP $04
  JR Z,SlightlyAffected
  JR HowMuch_What_1
QuiteAffected:
  INC C
SlightlyAffected:
  INC C
VeryAffected:
  INC C
UtterlyAffected:
  LD A,C
  CALL A_IntoPrintBuffer
HowMuch_What_1:
  LD A,B
  JP A_IntoPrintBuffer

ReportCharStatus:
  PUSH AF
  SRL A
  SRL A
  SRL A
  SRL A
  LD B,$D6                ; 'Invigorated'
  LD C,$D5                ; 'Tired'
  CALL HowMuch_What
  POP AF
  CP $00
  RET NZ
  CALL Bytes_Print_Buffer
  DEFB $87,$D8,$92,$FF    ; 'And Cannot Continue'
  RET

DisplayArmyStatus:
  CALL FullCharTitle
  LD A,$D7                ; 'Command'
  CALL A_IntoPrintBuffer
  CALL SToBuffer
  LD D,$00
  LD E,$87                ; 'And'
  LD A,(CharNoRiders)
  CP $00
  JR Z,DisplayArmyStatus_0 ; No Riders
  INC D
DisplayArmyStatus_0:
  LD A,(CharNoWarriors)
  CP $00
  JR Z,DisplayArmyStatus_1 ; No Warriors
  INC D
  INC D
DisplayArmyStatus_1:
  LD A,D
  CP $00                  ; None of Anything
  JR Z,DisplayArmyStatus_2
  CP $03
  JR Z,DisplayArmyStatus_2 ; Riders & Warriors
  LD E,$CE                ; 'But'
DisplayArmyStatus_2:
  LD A,(CharNoWarriors)
  PUSH DE
  CALL HowManyWarriors
  POP DE
  PUSH DE
  LD A,E
  CALL A_IntoPrintBuffer
  LD A,(CharNoRiders)
  CALL HowManyRiders
  CALL StopToBuffer
  POP DE
  LD A,D
  CP $00                  ; None
  RET Z
  CP $01                  ; Riders or Warriors?
  JR Z,DisplayRidersStatus
  CALL Bytes_Print_Buffer
  DEFB $FC,$CF,$C5,$FE,$73,$AE,$FF ; 'His Warriors Are'
  LD A,(CharWarriorsEnergyStatus)
  CALL ReportCharStatus
  CALL StopToBuffer
DisplayRidersStatus:
  LD A,D
  CP $02
  RET Z
DisplayWarriorsStatus:
  CALL Bytes_Print_Buffer
  DEFB $FC,$CF,$C4,$FE,$73,$AE,$FF ; 'His Riders Are'
  LD A,(CharRidersEnergyStatus)
  CALL ReportCharStatus
  JP StopToBuffer

HowManyUnitsOf:
  LD A,$0A

HowManyUnitsOf_A:
  LD B,$10
  LD C,A
  XOR A
HowManyUnitsOf_A_0:
  ADC HL,HL
  RL A                    ; A*2
  CP C
  JR C,HowManyUnitsOf_A_1 ; A<C?
  SUB C
HowManyUnitsOf_A_1:
  CCF
  DJNZ HowManyUnitsOf_A_0
  ADC HL,HL
  RET

BreakNumberInParts:
  CALL HowManyUnitsOf
  LD (NoOfUnits),A
  CALL HowManyUnitsOf
  LD (NoOfTens),A
  CALL HowManyUnitsOf
  LD (NoOfHundreds),A
  CALL HowManyUnitsOf
  LD (NoOfThousands),A
  CALL HowManyUnitsOf
  LD (NoOfMillions),A
  RET

CalcBaseNumber:
  LD A,B
  CP $00
  JR Z,LessThanTen
  CP $01
  JR Z,LessThanTwenty
  CP $02
  JR Z,LessThanThirty
  SUB $03                 ; Thirty Over
  LD E,A
  LD D,$00
  LD HL,NumberTable2
  ADD HL,DE
  LD A,(HL)
  CALL A_IntoPrintBuffer
  LD A,B
  CP $08                  ; Special Eighty
  JR Z,AddTheY
  LD A,$74                ; AddThe
  CALL AddLiteralToBuffer
AddTheY:
  LD A,$79
LastPartOfNumber:
  CALL AddLiteralToBuffer
CalcBaseNumber_0:
  LD A,C
  CP $00
  RET Z                   ; Any more?
  CALL Bytes_Print_Buffer
  DEFB $FE,$2D,$FD,$FF    ; '-'
LessThanTen:
  LD A,C

BaseNumber:
  ADD A,$62
  JP A_IntoPrintBuffer
LessThanThirty:
  LD A,$B9                ; 'Twenty'
  CALL A_IntoPrintBuffer
  JR CalcBaseNumber_0
LessThanTwenty:
  LD E,C
  LD D,$00                ; DE=Number
  LD HL,NumberTable1      ; HL=Table
  ADD HL,DE               ; Position in table
  LD A,(HL)               ; A=Token
  CALL A_IntoPrintBuffer
  LD A,C
  CP $03
  RET M                   ; Ends Less Than Three
  CP $08                  ; But No Eight
  JR Z,BaseNumber_0
  LD A,$B8                ; 'Teen' - add to the End
  JP AddTokenWithConnect
BaseNumber_0:
  CALL Bytes_Print_Buffer ; Special case for EightEEN
  DEFB $FE,$65,$FE,$65,$FE,$6E,$FF ; 'een'
  RET

; Number Tables
NumberTable1:
  DEFB $6C,$B3,$B4,$B5,$66,$B7,$68,$69
  DEFB $6A,$6B

NumberTable2:
  DEFB $B5,$B6,$B7,$68,$69,$6A,$6B

NumberToString:
  CALL BreakNumberInParts
  LD A,$01
  LD (QuantityFlag),A
  LD BC,(NoOfThousands)
  LD DE,(NoOfUnits)
  LD A,(NoOfHundreds)
  ADD A,B                 ; Add up all parts
  ADD A,C                 ; to see if there
  LD H,A                  ; is a number at all.
  LD A,E
  ADD A,D
  LD L,A                  ; H=ThousandsMillions
  ADD A,H                 ; L=TensUnits
  CP $00                  ; Any amount?
  JR NZ,NumberToString_0
TensHundredsThousands:
  LD A,$BC                ; No
  JP A_IntoPrintBuffer
NumberToString_0:
  CP $01
  JR NZ,GreaterThanHundred
  CP E
  JR NZ,GreaterThanHundred
  LD A,$00
  LD (QuantityFlag),A
GreaterThanHundred:
  LD A,H
  CP $00                  ; Is it greater than 100?
  JR Z,CalcTensUnits      ; No
  LD A,$00
  ADD A,B                 ; How Many Thousands
  ADD A,C
  CP $00                  ; Any At all?
  JR Z,AnyHundreds        ; No
  PUSH HL
  CALL CalcBaseNumber
  POP HL
  LD A,$BB                ; 'Thousand'
  CALL A_IntoPrintBuffer
AnyHundreds:
  LD A,(NoOfHundreds)
  CP $00
  JR Z,AnyExtras
  CALL BaseNumber
  LD A,$BA                ; 'Hundred'
  CALL A_IntoPrintBuffer
AnyExtras:
  LD A,L
  CP $00
  JR NZ,AddAnAnd
  RET
AddAnAnd:
  LD A,$87
  CALL A_IntoPrintBuffer
CalcTensUnits:
  LD BC,(NoOfUnits)
  JP CalcBaseNumber

HaveOrHas:
  LD A,(QuantityFlag)
  CP $00
  JR Z,ItsHas
  LD A,$BD                ; ItsHave
  JP A_IntoPrintBuffer
ItsHas:
  LD A,$8A
  JP A_IntoPrintBuffer

MoveTowardsSomeOne:
  LD B,$00
  LD C,B
  LD A,(CurrentLocationY) ; Compare Row of SomeOne
  LD D,A                  ; against Row of Army
  LD A,(ArmyToMoveLocation)
  CP D
  JR Z,MoveTowardsSomeOne_1 ; If it's the same then no need to alter
  JP C,MoveTowardsSomeOne_0 ; If their's is less then do decrement
  INC B                   ; Increment Army's Row count
  JR MoveTowardsSomeOne_1 ; Skip Next instruction
MoveTowardsSomeOne_0:
  DEC B                   ; Decrement Army's Row count
MoveTowardsSomeOne_1:
  LD A,(CurrentLocationY+$0001) ; Compare Column of SomeOne
  LD D,A                  ; against column of army.
  LD A,(ArmyToMoveLocation+$0001)
  CP D
  JR Z,MoveTowardsSomeOne_3 ; If it's the same then no need to alter
  JR C,MoveTowardsSomeOne_2 ; If their's is less then Do Decrement
  INC C                   ; Increment army's column count
  JR MoveTowardsSomeOne_3 ; Skip Next instruction
MoveTowardsSomeOne_2:
  DEC C                   ; Decrement army's column count
MoveTowardsSomeOne_3:
  LD HL,DirectionLookTable ; Start Looking North
  LD A,$00
MoveTowardsSomeOne_4:
  LD (CurrentlyLooking),A
  LD A,(HL)               ; Reference the DirectionLookTable
  INC HL
  CP B                    ; Is this the Row move we want?
  JR NZ,MoveTowardsSomeOne_5 ; No. Think about another direction.
  LD A,(HL)
  CP C                    ; Is this the Column move we want?
  JR Z,MoveTowardsSomeOne_6 ; Yes. Process it
MoveTowardsSomeOne_5:
  INC HL                  ; Think about next Direction
  LD A,(CurrentlyLooking)
  INC A
  CP $08                  ; Have we tried all Directions?
  JR NZ,MoveTowardsSomeOne_4 ; No. Loop until we have.
MoveTowardsSomeOne_6:
  LD A,(CurrentlyLooking) ; This is the Direction we want!
  LD (Route_One),A        ; This is the Exact Way!
  LD (Route_Two),A        ; So this
  DEC A
  AND $07                 ; This isn't Quite so exact
  LD (Route_Three),A
  INC A
  INC A
  AND $07
  LD (Route_Four),A       ; Neither is this
  LD B,$08                ; We'll Try this 8 times
MoveTowardsSomeOne_7:
  CALL RandomishNumber    ; Random Number
  AND $03                 ; Between 0-3
  LD D,$00
  LD E,A
  LD HL,Route_One         ; Reference the moves picked
  ADD HL,DE               ; Which one are we going to use?
  LD A,(HL)               ; This one of course!
  LD (CurrentlyLooking),A ; Done.
  PUSH BC
  CALL FindLookingTowards ; Move to something we're looking at.
  LD HL,(DesirableLocation) ; Yes we are!!!!
  LD (WorkingLocation),HL
  CALL CalcMapLocation    ; Were in the data though?
  POP BC
  LD A,(LocationFeature)  ; What's here?
  CP $00
  JR Z,MoveTowardsSomeOne_8 ; Can't walk through mountains!
  CP $02
  JR Z,MoveTowardsSomeOne_8 ; Don't like Forests!
  CP $0A                  ; Bit impassible!
  RET NZ                  ; That'll do.
MoveTowardsSomeOne_8:
  DJNZ MoveTowardsSomeOne_7
  CP $0A                  ; We didn't get a desired Direction.
  RET NZ                  ; Anything other than frozen waste will do!
  LD A,$08                ; Or Nowhere
  LD (CurrentlyLooking),A
  RET

FullScaleBattle:
  LD A,(LastFreeArmyInTable)
  CP $00                  ; How many Free Armies still Here?
  RET Z                   ; Return if none at all
  LD A,(LastDoomDarksArmyInTable)
  CP $00                  ; How Many of doomdarks armies here?
  RET Z                   ; Return if none at all
  LD A,$FF                ; Set this for a while
  LD (CharInHereTable),A
  XOR A                   ; Start with army Zero
FullScaleBattle_0:
  LD (FreeArmyPosInTable),A
  CALL GetFreeArmy        ; Get the required army
  LD A,(HowManyFreeArmy)
  CP $00                  ; How many here?
  JR Z,MinorSkirmish_2    ; None is not worth bothering about.
  LD B,A
  LD A,(FreeArmySuccessChance)
  LD C,A

MinorSkirmish:
  PUSH BC
  CALL RandomishNumber    ; Pick a number
  CP C                    ; Compare it agains free's success
  JR NC,MinorSkirmish_1   ; if A>=C then no Fighting!
  CALL RandomishNumber
  LD L,A
  LD H,$00
  LD A,(LastDoomDarksArmyInTable)
  CALL HowManyUnitsOf_A
  LD (DoomDarksArmyPosInTable),A
  CALL GetDoomDarksArmy
  CALL RandomishNumber
  LD C,A
  LD A,(DoomDarksArmySuccessChance) ; What's the chance of success?
  CP C
  JR NC,MinorSkirmish_1   ; If a>=c then no loss
  LD A,(NoOfDoomDarksDead) ; How Many are already Dead?
  CP $FF                  ; Are they all dead?
  JR Z,MinorSkirmish_0    ; Yes. can't kill anymore then
  INC A                   ; Add one more to the count
  LD (NoOfDoomDarksDead),A
MinorSkirmish_0:
  JR MinorSkirmish_3
MinorSkirmish_1:
  POP BC                  ; Next Soldier!
  DJNZ MinorSkirmish
  LD A,(CharInHereTable)  ; Was this a full battle
  CP $FF                  ; or a minor skirmish?
  RET NZ                  ; return if a minor skirmish
  CALL StoreFreeArmy
MinorSkirmish_2:
  LD A,(LastFreeArmyInTable) ; How many entry's in the table?
  LD B,A
  LD A,(FreeArmyPosInTable) ; How many have we done?
  INC A                   ; Next.
  CP B                    ; Are we past the last one?
  JR NZ,FullScaleBattle_0 ; Loop until we are.
  RET
MinorSkirmish_3:
  LD A,(HowManyDoomDarksArmy)
  DEC A                   ; Reduce the amount of the Enemy
  LD (HowManyDoomDarksArmy),A
  CALL StoreDoomDarksArmy ; Store away the results
  LD A,(HowManyDoomDarksArmy)
  CP $00                  ; Are there any left?
  JR NZ,MinorSkirmish_1   ; loop until there isn't
  LD A,(LastDoomDarksArmyInTable) ; Well that's one full army down!
  DEC A                   ; Decrease the Last one
  LD (LastDoomDarksArmyInTable),A
  CP $00                  ; Any Armies left at location?
  JR NZ,ShuffleArmytable  ; Yes.
  POP BC                  ; No. well that's that then!!
  RET
ShuffleArmytable:
  LD B,A
  LD A,(DoomDarksArmyPosInTable) ; B=Last Entry in table
  CP B                    ; a=Where are we in that table?
  JR Z,MinorSkirmish_1    ; Loop if they're the same
  LD HL,(HowManyDoomDarksArmy) ; We want to store away
  PUSH HL                 ; these for A while.
  LD HL,(NoOfFreeDead)
  PUSH HL
MinorSkirmish_4:
  INC A
  LD (DoomDarksArmyPosInTable),A
  CALL GetDoomDarksArmy   ; Get Next army in the table!
  LD A,(DoomDarksArmyPosInTable)
  DEC A                   ; And position it one entry back
  LD (DoomDarksArmyPosInTable),A
  CALL StoreDoomDarksArmy ; Store away the details
  LD A,(LastDoomDarksArmyInTable) ; How many in the table?
  LD B,A
  LD A,(DoomDarksArmyPosInTable)
  INC A                   ; Increment which one we're dealing with
  CP B                    ; Have we done them all?
  JR NZ,MinorSkirmish_4   ; Loop until we have.
  POP HL                  ; Restore the variables we saved.
  LD (NoOfFreeDead),HL
  POP HL
  LD (HowManyDoomDarksArmy),HL ; Store as the last entry!!!(?)
  LD (DoomDarksArmyPosInTable),A
  CALL StoreDoomDarksArmy
  JR MinorSkirmish_1      ; ...back to battle!

LocateDoomDarksArmy:
  LD BC,(StartOfDoomDarksTable)
  LD DE,HowManyDoomDarksArmy
  LD A,(DoomDarksArmyPosInTable)
  JR HL_Equal_AMult4PlusBC

LocateFreeArmy:
  LD BC,(StartofFreeTable)
  LD DE,HowManyFreeArmy
  LD A,(FreeArmyPosInTable)

HL_Equal_AMult4PlusBC:
  LD L,A
  LD H,$00
  ADD HL,HL
  ADD HL,HL
  ADD HL,BC
  RET

GetFreeArmy:
  CALL LocateFreeArmy
  JR RetrieveFourBytes

StoreFreeArmy:
  CALL LocateFreeArmy
  JR StoreFourBytes

GetDoomDarksArmy:
  CALL LocateDoomDarksArmy
  JR RetrieveFourBytes

StoreDoomDarksArmy:
  CALL LocateDoomDarksArmy
StoreFourBytes:
  EX DE,HL

RetrieveFourBytes:
  LD BC,$0004
  LDIR
  RET

CalcCharsKillRate:
  LD A,(NoInCharHereTable)
  CP $00                  ; Are there any Chars here?
  RET Z                   ; Return if not
  XOR A                   ; Start with the first.
CalcCharsKillRate_0:
  LD (CharInHereTable),A
  LD A,(LastDoomDarksArmyInTable)
  CP $00                  ; Any of Doomdarks army here?
  RET Z                   ; Return if not.
  CALL GetFromCharHereTable ; Get the character.
  LD A,$00
  LD (NoOfDoomDarksDead),A ; Haven't killed any yet!
  LD A,(CharFightStrength)
  LD B,A                  ; Work out our worth in soldiers.
  LD A,(CharEnergyStatus)
  ADD A,$80
  LD C,A
  CALL MinorSkirmish
  LD A,(NoOfDoomDarksDead)
  LD (CharSlew),A         ; Character Killed a few
  CALL SaveCharDetails
  LD A,(NoInCharHereTable)
  LD B,A                  ; How Many Characters are here?
  LD A,(CharInHereTable)  ; Select the next character
  INC A                   ; that's in this location.
  CP B                    ; Have we Done them all?
  JR NZ,CalcCharsKillRate_0 ; Loop if Not.
  RET

DisplayThinkAgain:
  CALL Bytes_Print_Buffer
  DEFB $FB,$FC,$55,$FF    ; 'He'
  CALL FlushPrintBuffer
  LD A,$3C
  LD (Print_Attr),A
  LD A,$C9                ; 'Thinks'
  CALL A_IntoPrintBuffer
  CALL FlushPrintBuffer
  LD A,$3A
  LD (Print_Attr),A
  CALL Bytes_Print_Buffer
  DEFB $94,$FE,$2E,$FE,$2E,$FE,$2E,$FE ; 'Again ....'
  DEFB $2E,$FF
  JP FlushPrintBuffer

KilledWhatHowDescription:
  DEFB $55,$C7,$00,$FF    ; 'He Slew The'

ObjTokensA:
  DEFB $FC,$4A,$FC,$04,$FF ; 'Lake Mirrow'
  DEFB $EA,$FF            ; 'Crown'

ObjTokensB:
  DEFB $FC,$2D,$00,$FC,$7B,$FF ; 'Lorgrim The Wise'

TokensYouMustSeek:
  DEFB $8D,$A4,$F0,$FF    ; 'You Must Seek'

DescribeAnObject:
  LD A,(ObjectToDescribe)
  LD C,A
  LD B,$00
  SLA C
  LD HL,ObjectDescriptionLookupTable ; Point to Object Description Table
  ADD HL,BC
  LD E,(HL)
  INC HL
  LD D,(HL)
  EX DE,HL
  CALL FillPrintBuffer
  RET

;
; Object descriptions token table
;

TokensHeHasWithHim:
  DEFB $FC,$55,$8A,$E3,$F9,$FF ; 'He Has With Him'

TokensHowIsHe:
  DEFB $FE,$2E,$FC,$00,$FC,$9B,$FC,$A9 ; '. The Ice Fear Is'
  DEFB $70,$FF

TokensIsHidden:
  DEFB $70,$EF,$FE,$2E,$FF ; 'Is Hidden.'

TokensFightOrHide:
  DEFB $AE,$AD,$87,$55,$A4,$F7,$A8,$EE ; 'Are Abroad And He Must Fight Or Hide'
  DEFB $FF

ObjTokensC:
  DEFB $00,$FC,$E8,$40,$FC,$E2,$DE,$E0 ; 'The Waters Of Life Which'
  DEFB $F9,$E3,$E1,$FF    ; 'Fill Him With Vigour'

; Object Descriptions Table
ObjTokensD:
  DEFB $B0,$FF            ; 'Nothing'

ObjTokensE:
  DEFB $F8,$FF            ; 'Wolves'

ObjTokensF:
  DEFB $7D,$FE,$73,$FF    ; 'Dragons'

ObjTokensG:
  DEFB $9B,$9C,$FE,$73,$FF ; 'Ice Trolls'

ObjTokensH:
  DEFB $7C,$FF            ; 'Skulkrin'

ObjTokensI:
  DEFB $9D,$99,$FE,$73,$FF ; 'Wild Horses'

ObjTokensJ:
  DEFB $DC,$87,$70,$DD,$FF ; 'Shelter And Is Refreshed'

ObjTokensK:
  DEFB $D9,$FE,$2E,$FC,$53,$DA,$DB,$FE ; 'Guidance. A Voice Calls,'
  DEFB $2C,$FF

ObjTokensL:
  DEFB $00,$FC,$1A,$40,$FC,$0B,$DE,$DF ; 'The Shadows Of Death Which Drain Him
                                       ; Of'
  DEFB $F9,$40,$E1,$FF    ; 'Vigour'

ObjTokensM:
  DEFB $00,$FC,$E4,$40,$00,$FC,$A0,$DE ; 'The Hand Of The Dark Which Brings
                                       ; Death To'
  DEFB $E5,$0B,$5C,$00,$6E,$FF ; 'The Day'

ObjTokensN:
  DEFB $00,$FC,$E9,$40,$FC,$32,$DE,$E5 ; 'The Cup Of Dreams Which Brings New
                                       ; Welcome'
  DEFB $A7,$A2,$FF

ObjTokensO:
  DEFB $00,$E6,$FC,$9A,$FD,$E7,$FF ; 'The Sword Wolfslayer'

ObjTokensP:
  DEFB $00,$E6,$FC,$7D,$FD,$E7,$FF ; 'The Sword Dragonslayer'

ObjTokensQ:
  DEFB $00,$FC,$03,$FC,$FA,$FF ; 'The Moon Ring'

ObjTokensR:
  DEFB $00,$FC,$9B,$FC,$EA,$FF ; 'The Ice Crown'

ObjTokensS:
  DEFB $FC,$76,$00,$FC,$7C,$FF ; 'Fawkrin The Skulkrin'

ObjTokensT:
  DEFB $FC,$77,$00,$FC,$7D,$FD,$79,$FF ; 'Farflame The Dragonlord'

ObjTokensU:
  DEFB $FC,$55,$8A,$AF,$FF ; 'He Has Found'

LocateArmy_DoomDarksElite:
  LD BC,Regiments
  LD DE,DoomDarksElite_Location
  LD A,(Army_DoomDarksElite)
  JP HL_Equal_AMult4PlusBC

GetArmy_DoomDarksElite:
  CALL LocateArmy_DoomDarksElite
  CALL RetrieveFourBytes
  LD A,(DoomDarksElite_Location)
  LD B,A
  AND $3F
  LD (DoomDarksElite_Location),A
  LD A,B
  AND $C0
  LD (DoomDarksElite_Orders),A
  LD A,(DoomDarksElite_Location+$0001)
  LD B,A
  AND $3F
  LD (DoomDarksElite_Location+$0001),A
  LD A,B
  AND $80
  LD (DoomDarksElite_Type),A
  RET

StoreArmy_DoomDarksElite:
  LD A,(DoomDarksElite_Location)
  LD B,A
  LD A,(DoomDarksElite_Orders)
  OR B
  LD (DoomDarksElite_Location),A
  LD A,(DoomDarksElite_Location+$0001)
  LD B,A
  LD A,(DoomDarksElite_Type)
  OR B
  LD (DoomDarksElite_Location+$0001),A
  CALL LocateArmy_DoomDarksElite
  JP StoreFourBytes

GetArmy_Table2:
  LD BC,SpecialPlaces
  LD DE,Headquarters_Location
  LD A,(Army_Headquarters)
  CALL HL_Equal_AMult4PlusBC
  JP RetrieveFourBytes

GetArmyDetails:
  LD A,(Army_Details)
  LD (Army_Headquarters),A
  CALL GetArmy_Table2
  LD HL,(Headquarters_Location)
  LD (ArmyLocation),HL
  CALL LocateArmy_Table1
  LD A,(HL)
  LD B,A
  AND $03
  LD (WhoseRaceIsArmy),A
  LD A,B
  AND $04
  LD (WhoGuardsThePlace),A
  INC HL
  LD A,(HL)
  LD (HowManyGuardsThePlace),A
  RET

LocateArmy_Table1:
  LD A,(Army_Details)
  LD C,A
  LD B,$00
  SLA C
  LD HL,Garrisons
  ADD HL,BC
  RET

StoreArmy_Table1:
  CALL LocateArmy_Table1
  LD A,(WhoseRaceIsArmy)
  LD B,A
  LD A,(WhoGuardsThePlace)
  OR B
  LD (HL),A
  INC HL
  LD A,(HowManyGuardsThePlace)
  LD (HL),A
  RET

WorkOutLocationDetails:
  LD HL,(CurrentLocationY)
  LD (WorkingLocation),HL
  CALL CalcMapLocation
  LD B,$40
  LD A,(LocationFeature)
  CP $00
  JR NZ,WorkOutLocationDetails_0
  LD B,$20
WorkOutLocationDetails_0:
  LD A,B
  LD (IncRidersEnergyBy),A
  LD HL,CharHereTable
  LD (PosInCharHereTable),HL
  LD HL,WorkSpaceArea
  LD (StartOfDoomDarksTable),HL
  LD HL,FreeTable
  LD (StartofFreeTable),HL
  LD HL,$0000
  LD (DoomDarks_Warriors),HL
  LD (DoomDarks_Riders),HL
  XOR A
  LD (FreeArmyHere),A
  LD (DoomDarksArmyHere),A
  LD (NoInCharHereTable),A
  LD (TempCharacterNo),A
  LD (FreeArmyPosInTable),A
  LD (DoomDarksArmyPosInTable),A
  LD (Army_Details),A
  LD (Army_DoomDarksElite),A
  CALL CalculateIceFear
  LD A,(WorkingLocation)  ; Set BC to equal
  LD B,A                  ; current Location.
  LD A,(WorkingLocation+$0001) ; This will be referenced
  LD C,A                  ; loads of times!
WorkOutLocationDetails_1:
  PUSH BC
  CALL GetArmyDetails
  POP BC
  LD A,(HowManyGuardsThePlace)
  CP $00                  ; AnyBody?
  JR Z,WorkOutLocationDetails_2 ; Skip rest if not!
  LD A,(ArmyLocation)
  CP B                    ; Is the army at this location?
  JR NZ,WorkOutLocationDetails_2
  LD A,(ArmyLocation+$0001)
  CP C
  JR Z,AddArmyToBattleTable ; Yes
WorkOutLocationDetails_2:
  LD A,(Army_Details)     ; No. Think about the next army
  INC A
  LD (Army_Details),A
  CP $66                  ; Is it the last?
  JR NZ,WorkOutLocationDetails_1 ; Loop if not
WorkOutLocationDetails_3:
  PUSH BC
  CALL GetArmy_DoomDarksElite
  POP BC
  LD A,(DoomDarksElite_Total)
  CP $00                  ; Any Actual army?
  JR Z,WorkOutLocationDetails_4 ; If Not Skip this
  LD A,(DoomDarksElite_Location)
  CP B                    ; Is the army at the current Location?
  JR NZ,WorkOutLocationDetails_4 ; Yes. Do this routine!
  LD A,(DoomDarksElite_Location+$0001)
  CP C
  CALL Z,AddArmyToDoomDarksBattleTable
WorkOutLocationDetails_4:
  LD A,(Army_DoomDarksElite)
  INC A                   ; Next Army
  LD (Army_DoomDarksElite),A
  CP $80                  ; Was it the last?
  JR NZ,WorkOutLocationDetails_3 ; Loop until it was
WorkOutLocationDetails_5:
  PUSH BC
  CALL CopyCharDetails
  POP BC
  LD A,(CharLifeStatus)
  CP $00                  ; Is the character alive?
  JR Z,WorkOutLocationDetails_6
  LD A,(CharHideFlag)
  CP $00                  ; Is character Hidden? 0=No
  JR NZ,WorkOutLocationDetails_6 ; Yes. skip the rest
  LD A,(CharLocation)
  CP B                    ; Is the character at the current Location?
  JR NZ,WorkOutLocationDetails_6 ; Yes. Do this
  LD A,(CharLocation+$0001)
  CP C
  CALL Z,AddCharToBattleTable
WorkOutLocationDetails_6:
  LD A,(TempCharacterNo)
  INC A                   ; Next Character
  LD (TempCharacterNo),A
  CP $20                  ; Is it the last?
  JR NZ,WorkOutLocationDetails_5 ; Loop until it is
  LD A,(DoomDarksArmyPosInTable)
  LD (LastDoomDarksArmyInTable),A
  LD B,A
  LD A,(FreeArmyPosInTable)
  LD (LastFreeArmyInTable),A
  LD C,A
  LD A,(NoInCharHereTable)
  ADD A,C
  LD (NoOfFreeArmiesAndChars),A
  LD A,B
  ADD A,C
  LD (TotalNoOfArmiesHere),A
  RET
AddArmyToBattleTable:
  LD E,$10
  LD A,(LocationFeature)
  CP $01                  ; Is the army at a Citadel?
  JR NZ,WorkOutLocationDetails_7 ; No.
  LD E,$20
WorkOutLocationDetails_7:
  LD A,(WhoseRaceIsArmy)
  CP $00                  ; Is it the DoomGuard?
  JR NZ,WorkOutLocationDetails_8 ; No.
  LD A,E                  ; Yes
  LD (DoomDarksArmyHere),A ; Set to 10/20 depending if citadel!
  LD A,(Army_Details)
  OR $80
  LD (WhichDoomDarksArmy),A ; We neet to know which army number
  LD A,(WhoGuardsThePlace) ; What type guard the place
  LD D,A
  LD A,(HowManyGuardsThePlace) ; And how many
  LD (HowManyDoomDarksArmy),A
  CALL IncDoomDarksArmy
  LD A,$00
  LD (NoOfFreeDead),A
  LD A,(WhoGuardsThePlace)
  CALL AddArmyToDoomDarksTable
  JP WorkOutLocationDetails_3 ; Loop next army
WorkOutLocationDetails_8:
  LD A,(Army_Details)
  OR $80                  ; Army at Keep or Citadel.
  LD (WhichFreeArmy),A    ; We need to know which army number
  LD A,E
  LD (FreeArmyHere),A     ; Set depending on wether its a citadel
  LD A,(HowManyGuardsThePlace)
  LD (HowManyFreeArmy),A
  LD A,$00
  LD (NoOfDoomDarksDead),A
  LD A,(WhoGuardsThePlace)
  LD D,$40
  CP $00
  JR Z,WorkOutLocationDetails_9
  LD D,$60
WorkOutLocationDetails_9:
  LD A,D
  LD (FreeArmySuccessChance),A
  PUSH BC
  CALL StoreFreeArmy
  POP BC
  LD A,(FreeArmyPosInTable)
  INC A
  LD (FreeArmyPosInTable),A
  JP WorkOutLocationDetails_3 ; Loop next army

AddArmyToDoomDarksBattleTable:
  LD A,(Army_DoomDarksElite)
  LD (WhichDoomDarksArmy),A
  LD A,(DoomDarksElite_Type)
  LD D,A
  LD A,(DoomDarksElite_Total)
  LD (HowManyDoomDarksArmy),A
  CALL IncDoomDarksArmy
  XOR A
  LD (NoOfFreeDead),A
  LD A,(DoomDarksElite_Type)
  JP AddArmyToDoomDarksTable

AddCharToBattleTable:
  LD A,(TempCharacterNo)
  PUSH BC                 ; Which character
  LD HL,(PosInCharHereTable)
  LD (HL),A               ; Add character to character here table!
  INC HL
  LD (PosInCharHereTable),HL
  LD A,(NoInCharHereTable)
  INC A                   ; Increase how many characters are here
  LD (NoInCharHereTable),A
  LD A,(CharNoRiders)
  CP $00                  ; Has the character got any riders?
  JR Z,AddCharToBattleTable_0
  LD (HowManyFreeArmy),A  ; Set how many.
  LD A,(TempCharacterNo)  ; Get character no
  OR $40                  ; And set bit 5 to say Riders
  LD (WhichFreeArmy),A
  LD A,(CharRidersEnergyStatus)
  LD D,A                  ; Riders energy Status
  LD A,(IncRidersEnergyBy) ; Riders increment amount
  ADD A,D                 ; Total them
  CALL AddIntoBattleTable
AddCharToBattleTable_0:
  LD A,(CharNoWarriors)
  CP $00                  ; Any Warriors?
  JR Z,AddCharToBattleTable_1
  LD (HowManyFreeArmy),A  ; Set how many
  LD A,(TempCharacterNo)
  LD (WhichFreeArmy),A    ; Set who
  LD A,(CharWarriorsEnergyStatus) ; Warriors energy status
  CALL AddIntoBattleTable
AddCharToBattleTable_1:
  POP BC
  RET

AddIntoBattleTable:
  LD D,A
  LD A,(FreeArmyHere)     ; How many Here?
  ADD A,D                 ; Add in our new figure
  LD D,A
  LD A,(LocationFeature)  ; Where are we?
  CP $02                  ; In a forest?
  JR NZ,AddIntoBattleTable_0
  LD A,(CharGraphicType)
  CP $0F                  ; Is the character a fey on a horse
  JR C,AddIntoBattleTable_0 ; No
  LD A,$40
  ADD A,D                 ; Add loads on if he is
  LD D,A
AddIntoBattleTable_0:
  LD A,D
  SRL A                   ; Multiply by two
  ADD A,$18               ; Add some more
  LD (FreeArmySuccessChance),A ; Success chance!
  LD A,$00
  LD (NoOfDoomDarksDead),A ; Reset.
  CALL StoreFreeArmy
  LD A,(FreeArmyPosInTable)
  INC A                   ; One more to the table
  LD (FreeArmyPosInTable),A
  RET

AddArmyToDoomDarksTable:
  PUSH BC
  CP $00
  LD HL,(IceFear)
  JR NZ,AddArmyToDoomDarksTable_0
  LD A,$05
  CALL HowManyUnitsOf_A
  JR AddArmyToDoomDarksTable_1
AddArmyToDoomDarksTable_0:
  LD A,$04
  CALL HowManyUnitsOf_A
AddArmyToDoomDarksTable_1:
  LD A,(DoomDarksArmyHere)
  ADD A,L
  LD (DoomDarksArmySuccessChance),A
  PUSH BC
  CALL StoreDoomDarksArmy
  POP BC
  LD A,(DoomDarksArmyPosInTable)
  INC A
  LD (DoomDarksArmyPosInTable),A
  POP BC
  RET

CalculateIceFear:
  LD A,$01
  LD (TempCharacterNo),A  ; Get Morkins Details
  CALL CopyCharDetails
  LD A,(CharLifeStatus)
  CP $00                  ; Is he alive?
  JR NZ,CalculateIceFear_0 ; Yes.
  LD A,$7F                ; NO. Start with 127 life status
  JR CalculateIceFear_1
CalculateIceFear_0:
  CALL CalcDiffinLocations
  LD DE,(PositionOfTowerOfDespair) ; Was there A Difference
  CP $00                  ; No. Character is either with morkin or is morkin.
  JR Z,CalcMorkinsIceFear
  CALL CalcDiffin_BC_DE   ; Calc distance from tower!
CalculateIceFear_1:
  LD L,A                  ; HL = Difference
  LD H,$00
  LD (IceFear),HL         ; IceFear's Initial setting!
  LD A,$00
  LD (TempCharacterNo),A
  CALL CopyCharDetails
  LD A,(CharLifeStatus)
  CP $00                  ; Is Luxor still alive?
  JR Z,CalculateIceFear_2 ; Ooops! No he's Not
  CALL CalcDiffinLocations ; Yes he is!
  JR CalculateIceFear_3
CalculateIceFear_2:
  LD A,$7F                ; Recalculate the IceFear
CalculateIceFear_3:
  LD B,$00                ; Accordingly!
  LD C,A
  LD HL,(IceFear)
  ADD HL,BC
  LD C,$30                ; Some for Good Measure!
  ADD HL,BC
  LD A,(DoomDarksCitadels)
  LD C,A                  ; Add on the number of Citadels
  ADD HL,BC               ; currently held by Doomdark!
CalculateIceFear_4:
  LD (IceFear),HL
  XOR A
  LD (TempCharacterNo),A  ; Start back with Luxor
  RET

LE851:
  DEFB $00

CalcMorkinsIceFear:
  CALL CalcDiffin_BC_DE
  LD HL,$01FF             ; Maximum Ice fear
  ADD A,A                 ; A=Distance from Tower*2
  LD C,A                  ; BC=A
  LD B,$00
  SLA C
  RL B                    ; BC=BC*2
  XOR A                   ; Reset A and Carry
  SBC HL,BC               ; HL=HL-BC
  JR CalculateIceFear_4

CalcDiffinLocations:
  LD BC,(CharLocation)
  LD DE,(WorkingLocation)
  NOP

CalcDiffin_BC_DE:
  LD A,B
  SUB D
  JR NC,CalcDiffin_BC_DE_0
  NEG
CalcDiffin_BC_DE_0:
  LD L,A
  LD A,C
  SUB E
  JR NC,CalcDiffin_BC_DE_1
  NEG
CalcDiffin_BC_DE_1:
  ADD A,L
  RET

ItsKillingTime:
  LD A,(LocationArea)
  LD (TempVar),A
  LD A,(LastFreeArmyInTable)
  LD (FreeArmyStillLeft),A
  LD A,(LastDoomDarksArmyInTable)
  LD (DoomDarksArmyStillLeft),A
  CALL CalcCharsKillRate
  CALL DoBothSidesBattling
  CALL DoBothSidesBattling
  CALL WhoWonThisBattle
  JP BeenSomeDeaths

; Do the battle for both sides!
DoBothSidesBattling:
  CALL DoBattle

; Do the battling for a side
DoBattle:
  CALL FullScaleBattle
  LD A,(LastFreeArmyInTable) ; Swap over variables
  LD B,A                  ; so that we can do all
  LD A,(LastDoomDarksArmyInTable) ; the work with one set of
  LD (LastFreeArmyInTable),A ; variables.
  LD A,B                  ; Keeps life much simpler!!
  LD (LastDoomDarksArmyInTable),A
  LD HL,(StartofFreeTable)
  LD DE,(StartOfDoomDarksTable)
  LD (StartofFreeTable),DE
  LD (StartOfDoomDarksTable),HL
  RET

WhoWonThisBattle:
  LD A,(LastDoomDarksArmyInTable)
  CP $00                  ; Has Doomdark still got any armies?
  JR NZ,WhoWonThisBattle_0 ; Yes. he didn't lose then.
  LD A,$9F                ; 'Free'
  JR WhoWonThisBattle_2
WhoWonThisBattle_0:
  LD A,(LastFreeArmyInTable)
  CP $00                  ; Has the free got any armies left?
  JR NZ,WhoWonThisBattle_1 ; Yes. they didn't lose then
  LD A,$C8                ; 'Enemy'
  JR WhoWonThisBattle_2
WhoWonThisBattle_1:
  XOR A                   ; Still fighting!
WhoWonThisBattle_2:
  LD (BattleVictory),A    ; Set who won, or didn't
  XOR A                   ; Reset
  LD (FreeArmyPosInTable),A ; ...these
  LD (DoomDarksArmyPosInTable),A ; ...these
  LD A,(FreeArmyStillLeft)
  CP $00                  ; How many Free armies?
  JP Z,WhoWonThisBattle_8 ; No More free left.
  LD B,A
WhoWonThisBattle_3:
  PUSH BC
  CALL GetFreeArmy
  LD A,(HowManyFreeArmy)
  LD E,A                  ; Army Total
  LD A,(WhichFreeArmy)    ; Who are they
  LD C,A
  CP $80                  ; C>=80 if at a citadel or keep
  JR C,CalcCharsArmyLoses ; otherwise belongs to a character
  CALL MakeArmyChangeSides
  JR WhoWonThisBattle_7
CalcCharsArmyLoses:
  AND $40
  LD D,A
  LD A,C                  ; Army number
  AND $1F
  LD (TempCharacterNo),A  ; Select Character
  PUSH DE
  CALL CopyCharDetails    ; Get his details
  POP DE
  LD A,(HowManyFreeArmy)  ; How Many Armies Here?
  LD B,A
  LD A,D                  ; Who Are They.
  CP $00                  ; Riders?
  JR NZ,WhoWonThisBattle_5 ; Yes. Skip the Rest
  LD A,(CharNoWarriors)   ; No. Warriors
  SUB B                   ; Lost A Lot.
  LD (CharWarriorsLost),A ; Save Away how many lost.
  LD A,B
  LD (CharNoWarriors),A   ; Save away how many Left.
  LD A,(NoOfDoomDarksDead) ; Warriors killed Some?
  LD (CharWarriorsSlew),A
  LD A,(CharWarriorsEnergyStatus)
  SUB $18                 ; They lose some Energy
  JR NC,WhoWonThisBattle_4 ; Have they any Left?
  XOR A                   ; No Less than Zero.
WhoWonThisBattle_4:
  LD (CharWarriorsEnergyStatus),A ; Store Away.
  JR WhoWonThisBattle_7
WhoWonThisBattle_5:
  LD A,(CharNoRiders)     ; Deal with Riders.
  SUB B                   ; Lost a lot Again.
  LD (CharRidersLost),A   ; Store how many lost.
  LD A,B
  LD (CharNoRiders),A     ; Store how many left.
  LD A,(NoOfDoomDarksDead) ; Riders killed a few.
  LD (CharRidersSlew),A   ; How Many?
  LD A,(CharRidersEnergyStatus)
  SUB $18                 ; Lost Some energy.
  JR NC,WhoWonThisBattle_6 ; Have they any left?
  XOR A                   ; No Less than zero.
WhoWonThisBattle_6:
  LD (CharRidersEnergyStatus),A ; Store Away
WhoWonThisBattle_7:
  CALL SaveCharDetails    ; Save Characters details.
  LD A,(FreeArmyPosInTable)
  INC A                   ; Next.
  LD (FreeArmyPosInTable),A
  POP BC
  DJNZ WhoWonThisBattle_12 ; Loop Until Finished.
WhoWonThisBattle_8:
  LD A,(DoomDarksArmyStillLeft) ; How many Doomdarks army are left?
  LD B,A
WhoWonThisBattle_9:
  PUSH BC
  CALL GetDoomDarksArmy
  LD A,(HowManyDoomDarksArmy)
  LD E,A
  LD A,(WhichDoomDarksArmy)
  CP $80                  ; Does his army guard the place?
  JR C,WhoWonThisBattle_10 ; No.
  CALL MakeArmyChangeSides
  JR WhoWonThisBattle_11
WhoWonThisBattle_10:
  LD (Army_DoomDarksElite),A ; Get the army we want
  CALL GetArmy_DoomDarksElite
  LD A,(HowManyDoomDarksArmy)
  LD (DoomDarksElite_Total),A ; Make alterations to the totals
  CALL StoreArmy_DoomDarksElite
WhoWonThisBattle_11:
  LD A,(DoomDarksArmyPosInTable) ; Deal with the next army.
  INC A
  LD (DoomDarksArmyPosInTable),A
  POP BC
  DJNZ WhoWonThisBattle_9
  CALL UpdateCharsBattleStats
  LD A,(BattleVictory)    ; Who won?
  CP $C8                  ; Was it DoomDark?
  RET NZ                  ; Return if it wasn't
  JP WhatHappensToFreeLords
WhoWonThisBattle_12:
  JP WhoWonThisBattle_3   ; Rather long jump

MakeArmyChangeSides:
  AND $7F                 ; Army that we want.
  LD (Army_Details),A
  PUSH DE
  CALL GetArmyDetails     ; Get the army.
  POP DE
  LD A,(BattleVictory)
  CP $00                  ; Check who one
  JR Z,MakeArmyChangeSides_1 ; No one
  CP $C8                  ; Did Doomdark Win?
  JR Z,MakeArmyChangeSides_0 ; Yes.
  LD A,(WhoseRaceIsArmy)  ; No. Who do the army belong to?
  CP $00                  ; Doomdark?
  JR NZ,MakeArmyChangeSides_1 ; Yes
  LD A,$01                ; No.
  LD (WhoseRaceIsArmy),A  ; Make the army belong to Free.
  LD E,$28
  JR MakeArmyChangeSides_1
MakeArmyChangeSides_0:
  LD A,(WhoseRaceIsArmy)
  CP $00                  ; Does the army belong to to Doomdark?
  JR Z,MakeArmyChangeSides_1 ; Don't do anything if it does.
  XOR A                   ; Make the Army belong to Doomdark!
  LD (WhoseRaceIsArmy),A
  LD E,$32
MakeArmyChangeSides_1:
  LD A,E                  ; How many of the army left?
  CP $00
  JR NZ,MakeArmyChangeSides_2 ; There are some.
  LD A,$04                ; If none the start with this
MakeArmyChangeSides_2:
  LD (HowManyGuardsThePlace),A
  CALL StoreArmy_Table1   ; Rewrite the army away
  RET

CharacterLosesWhat:
  LD A,(CharLifeStatus)
  CP $00                  ; Is the Character Alive?
  RET Z                   ; No. Return
  PUSH AF
  LD A,(CharHasAHorse)
  CP $00                  ; Has the Character got a horse?
  JR Z,WillCharacterDie   ; No. Forget the next bit!
  CALL RandomishNumber    ; Between Zero & One
  AND $01                 ; See if he'll lose his horse
  LD (CharHasAHorse),A    ; 50/50 Characters not got a horse
  CALL CalcCharsGraphicType
WillCharacterDie:
  CALL RandomishNumber    ; Pick a number
  LD B,A
  LD A,(CharEnergyStatus) ; What's his energy like?
  SRL A                   ; Divide by two
  SUB $40                 ; Then subtract 64
  LD C,A                  ; Store this a mo
  POP AF                  ; Get back his life status
  ADD A,C                 ; Add it to his energy
  CP B                    ; If A>B then character
  RET NC                  ; lives.....
  XOR A
  LD (CharLifeStatus),A   ; DEAD!!
  RET

WhatHappensToFreeLords:
  LD A,(NoInCharHereTable)
  CP $00                  ; Any Character in location
  RET Z                   ; Return if none!
  XOR A                   ; Start with first.
WhatHappensToFreeLords_0:
  LD (CharInHereTable),A  ; Character we want
  CALL GetFromCharHereTable ; Get his details
  CALL CharacterLosesWhat
  LD A,(CharLifeStatus)   ; Did he lose his life?
  CP $00
  JR Z,WhatHappensToFreeLords_2 ; Skip next bit
WhatHappensToFreeLords_1:
  CALL RandomishNumber    ; Move character somewhere!!!
  AND $07                 ; Pick A Direction
  LD (CurrentlyLooking),A ; We'll look there
  CALL FindLookingTowards ; Anything upto three locations?
  LD HL,(DesirableLocation)
  LD (WorkingLocation),HL ; Move There
  LD (CharLocation),HL    ; Store Away
  CALL CalcMapLocation    ; Calculate New Position in Map
  LD A,(LocationFeature)  ; What's there?
  CP $0A                  ; Anywhere but Frozen waste
  JR Z,WhatHappensToFreeLords_1 ; Yes, do it all again.
WhatHappensToFreeLords_2:
  CALL SaveCharDetails    ; Save away any changes
  LD A,(NoInCharHereTable) ; How many in the table
  LD B,A
  LD A,(CharInHereTable)
  INC A                   ; Which one are we on.
  CP B                    ; have we processed them all?
  JR NZ,WhatHappensToFreeLords_0 ; Loop until we have.
  RET

UpdateCharsBattleStats:
  LD A,(NoInCharHereTable)
  CP $00                  ; Any characters here?
  RET Z                   ; Return if not.
  XOR A                   ; Start with first.
UpdateCharsBattleStats_0:
  LD (CharInHereTable),A  ; The character we want.
  CALL GetFromCharHereTable ; Get his deatils
  LD A,(BattleVictory)
  LD (CharBattleStatus),A ; Say Who Won the battle
  LD A,(TempVar)
  LD (CharBattleArea),A   ; Say what are the battle was
  LD A,(CharEnergyStatus)
  SUB $14                 ; Get rid of some energy
  JR NC,UpdateCharsBattleStats_1
  XOR A                   ; Can't have less than zero
UpdateCharsBattleStats_1:
  LD (CharEnergyStatus),A
  CALL SaveCharDetails    ; Store away the changes
  LD A,(NoInCharHereTable)
  LD B,A                  ; How many in the table
  LD A,(CharInHereTable)
  INC A                   ; Which are we upto?
  CP B                    ; The last one?
  JR NZ,UpdateCharsBattleStats_0 ; Loop until it is
  RET

CalcCharsGraphicType:
  LD A,(CharRace)
  DEC A
  LD C,A
  LD B,$00
  SLA C
  LD A,(CharHasAHorse)
  ADD A,C
  LD C,A
  LD HL,RaceImageTable
  ADD HL,BC
  LD A,(HL)
  LD (CharGraphicType),A
  RET

; Race Image table (GFX)
;
; Except for Skulkrin and Dragon, byte #1 = standing, byte #2 = on horse
RaceImageTable:
  DEFB $08,$01            ; Free
  DEFB $10,$0F            ; Fey
  DEFB $0E,$00            ; Targ
  DEFB $0A,$03            ; Wise
  DEFB $0B,$04            ; Morkin
  DEFB $0C,$0C            ; Skulkrin
  DEFB $06,$06            ; Dragon

AlterLocationContents:
  LD BC,(WorkingLocation)
  CALL CalcMapHL          ; Calc Offset in map
  LD A,(LocationFeature)  ; Get the feature
  LD B,A
  LD A,(LocationObject)   ; Get the object
  ADD A,A                 ; Move object into
  ADD A,A                 ; high order bits
  ADD A,A
  ADD A,A
  ADD A,B                 ; Put feature in low
  LD (HL),A               ; Store it away
  LD BC,$0F40             ; Reference Description map
  ADD HL,BC
  LD A,(LocationArea)     ; Get the area
  LD B,A
  LD A,(LocDomainFlag)    ; the domain flag
  LD C,A
  LD A,(LocSpecialFlag)   ; and special flag
  OR B                    ; Combine them and store away
  OR C                    ;
  LD (HL),A               ;
  RET

ResetToOriginalArmy:
  LD A,(ArmyLoopCurrent)
  LD (Army_DoomDarksElite),A
  CALL GetArmy_DoomDarksElite
  LD HL,(DoomDarksElite_Location)
  LD (WorkingLocation),HL
  CALL CalcMapLocation
  RET
AttemptFollow:
  LD HL,(Headquarters_Location)
  LD A,(DoomDarksElite_Location+$0001) ; Do we need to move anywhere to
  CP H                    ; Get to the desired location?
  JR NZ,ResetToOriginalArmy_0 ; Yes. Start the process.
  LD A,(DoomDarksElite_Location)
  CP L
  JR Z,AnnounceArmyIsHere ; We're here then.
ResetToOriginalArmy_0:
  LD (ArmyToMoveLocation),HL ; Set the location we're at
  CALL MoveTowardsSomeOne
  JR MoveArmySomewhere_1
AnnounceArmyIsHere:
  CALL ResetToOriginalArmy
  LD A,$01                ; Set location feature to
  CALL SetLocationPlainsArmy ; army if we can
ResetToOriginalArmy_1:
  LD A,$08
  LD (EnemyMoveCount),A
  RET

MoveArmySomewhere:
  CALL ResetToOriginalArmy
  LD A,(DoomDarksElite_Total)
  CP $00                  ; Is there actually any soldiers?
  JR Z,ResetToOriginalArmy_1 ; Finish if not.
  LD A,(LocSpecialFlag)
  CP $00                  ; Anything special here?
  JR NZ,AnnounceArmyIsHere ; Yes. - We'll Stay Here then!
  XOR A                   ; Look North.
MoveArmySomewhere_0:
  LD (CurrentlyLooking),A
  CALL FindLookingTowards ; Have a look forwards a couple
  LD HL,(DesirableLocation) ; of locations.
  LD (WorkingLocation),HL ; Move to that location.
  CALL CalcMapLocation
  LD A,(LocSpecialFlag)
  CP $00                  ; Anything Special here?
  JR NZ,MoveArmySomewhere_1 ; Yes. Check it out!
  LD A,(CurrentlyLooking) ; Check next direction
  INC A
  CP $08
  JR NZ,MoveArmySomewhere_0 ; Loop until looked everywhere
  LD A,(DoomDarksElite_Orders)
  CP $00                  ; What will this army do?
  JP Z,FollowAnotherArmy  ; Guess what!
  CP $40
  JP Z,MoveArmyToNewLocation ; Aimlessly wander around!
  CP $80
  JP Z,FollowACharacter
  CP $C0
  JP Z,FollowArmyThenPickAnother
MoveArmySomewhere_1:
  LD A,(CurrentlyLooking)
  CP $08                  ; Are we still looking anywhere
  JR Z,AnnounceArmyIsHere ; No. Doesn't look like it.
  LD HL,(DesirableLocation) ; So just say the army is here.
  LD (CurrentLocationY),HL
  CALL WorkOutLocationDetails
  LD A,(LastDoomDarksArmyInTable)
  CP $1F                  ; How many armies are here?
  JR NC,AnnounceArmyIsHere ; We'll stay here then!
  CALL ResetToOriginalArmy ; We're not going to stay here!
  LD A,(TempTotalOfArmies)
  DEC A                   ; One Less in this location
  CALL SetLocationPlainsArmy ; Set terrain to Whatever
  LD A,(TotalNoOfArmiesHere) ; This is for new location
  INC A                   ; One more here than before
  LD (TempTotalOfArmies),A ; Set temp as well.
  LD HL,(CurrentLocationY)
  LD (DoomDarksElite_Location),HL
  CALL StoreArmy_DoomDarksElite ; Store army away.
  CALL ResetToOriginalArmy
  LD B,$02                ; Start with two moves.
  LD A,(LocationFeature)  ; What's here?
  CP $00                  ; Is it a mountain.
  JR Z,MoveArmySomewhere_2 ; Yes. Bad Move!
  CP $02                  ; Is it a forest? - Hope Not!
  JR NZ,MoveArmySomewhere_3 ; No. Still only two moves then
MoveArmySomewhere_2:
  LD B,$08                ; Bad Move, took us eight!
MoveArmySomewhere_3:
  LD A,(DoomDarksElite_Type)
  CP $00                  ; Warriors?
  JR Z,MoveArmySomewhere_4 ; Yes.
  SRL B                   ; Multiply by two for riders!
MoveArmySomewhere_4:
  LD A,(EnemyMoveCount)   ; Add on our number of moves
  ADD A,B
  LD (EnemyMoveCount),A
  JP SetLocationPlainsArmy ; State that we're here!
FollowAnotherArmy:
  LD A,(DoomDarksElite_ID) ; Get the Armypointed to
  LD (Army_Headquarters),A
  CALL GetArmy_Table2
  LD HL,(Headquarters_Location) ; Record their postion
  LD (WorkingLocation),HL
  CALL CalcMapLocation
  LD A,(LocSpecialFlag)
  CP $00                  ; Anything Special there?
  JP Z,AnnounceArmyIsHere ; No. We'll stay here then
  JP AttemptFollow        ; Yes. lets head towards them.
MoveArmyToNewLocation:
  CALL RandomishNumber
  AND $07                 ; Pick a direction
  LD (CurrentlyLooking),A ; Look that way
  CALL FindLookingTowards ; Find something to look towards
  LD HL,(DesirableLocation) ; Move there
  LD (WorkingLocation),HL
  CALL CalcMapLocation
  LD A,(LocationFeature)  ; What's there?
  CP $0A                  ; If it's frozen waste then
  JR Z,MoveArmyToNewLocation ; Find another location
  JP MoveArmySomewhere_1
FollowACharacter:
  LD A,(DoomDarksElite_ID)
  LD (TempCharacterNo),A  ; Pick up on character
  CALL CopyCharDetails    ; Get his info
  LD A,(CharLifeStatus)
  CP $00                  ; Is he alive?
  JR NZ,MoveArmySomewhere_6 ; Yes. Skip next bit
  XOR A                   ; No. Set character to Luxor!
MoveArmySomewhere_5:
  LD (DoomDarksElite_ID),A ; Set ID to New Character
  LD (TempCharacterNo),A
  CALL StoreArmy_DoomDarksElite ; Store Army Details
  CALL CopyCharDetails    ; Get characters info
  LD A,(CharLifeStatus)
  CP $00                  ; Is he alive
  JR NZ,MoveArmySomewhere_6 ; Yes. Skip Next bit
  LD A,$01                ; Set character to Morkin!
  JR MoveArmySomewhere_5  ; And retry.
MoveArmySomewhere_6:
  LD HL,(CharLocation)    ; Move ArmyTable2
  LD (Headquarters_Location),HL ; to New characters Location
  JP AttemptFollow
FollowArmyThenPickAnother:
  LD A,(DoomDarksElite_ID)
  LD (Army_Headquarters),A
  CALL GetArmy_Table2
  LD BC,(Headquarters_Location)
  LD A,(DoomDarksElite_Location)
  CP C                    ; Are they at the same Location?
  JR NZ,MoveArmySomewhere_8 ; No
  LD A,(DoomDarksElite_Location+$0001)
  CP B
  JR NZ,MoveArmySomewhere_8 ; No
  LD A,(Headquarters_ArmyOne) ; Yes they are so pick another army.
  LD B,A
  CALL RandomishNumber    ; Pick a Number, Any Number
  CP $80                  ; What was it compared to 128
  JR C,MoveArmySomewhere_7
  LD A,(Headquarters_ArmyTwo)
  LD B,A
MoveArmySomewhere_7:
  LD A,B
  LD (DoomDarksElite_ID),A ; Point ArmyDoomDarksElite at the selection
  LD (Army_Headquarters),A
  CALL StoreArmy_DoomDarksElite ; Store it and get the army
  CALL GetArmy_Table2     ; Read to deal with.
MoveArmySomewhere_8:
  JP AttemptFollow

SetLocationPlainsArmy:
  LD B,$0E
  CP $00                  ; If a=0 then Set to Plains
  JR NZ,SetLocationPlainsArmy_0 ; Else set to army
  LD B,$0F                ; Reset to Plains
SetLocationPlainsArmy_0:
  LD A,(LocationFeature)
  CP $0E                  ; Can only be Army or Plains.
  RET C
  LD A,B                  ; Make New Feature
  LD (LocationFeature),A
  JP AlterLocationContents

ProcessAllArmies:
  XOR A
ProcessAllArmies_0:
  LD (ArmyLoopCurrent),A
  LD (Army_DoomDarksElite),A
  CALL GetArmy_DoomDarksElite
  LD HL,(DoomDarksElite_Location)
  LD (CurrentLocationY),HL
  CALL WorkOutLocationDetails
  LD A,(TotalNoOfArmiesHere)
  LD (TempTotalOfArmies),A
  XOR A
  LD (EnemyMoveCount),A
ProcessAllArmies_1:
  CALL MoveArmySomewhere
  LD A,(EnemyMoveCount)
  CP $06                  ; Army can have upto six moves
  JR C,ProcessAllArmies_1 ; loop until they've had them.
  LD A,(ArmyLoopCurrent)  ; Process the next army
  INC A
  CP $80                  ; Loop 128 times
  JR NZ,ProcessAllArmies_0 ; Done it!!!!
  RET

DescribeWho:
  LD A,(CharHideFlag)
  CP $00                  ; Is the character Hidden?
  JR Z,DescribeWho_0
  CALL FirstNameToBuffer  ; Who is it?
  LD HL,TokensIsHidden
  CALL FillPrintBuffer
DescribeWho_0:
  CALL SetTokenToUpperCase
  LD A,(WhatObject)
  CP $00                  ; No object at all
  JR Z,DescribeOrGuidence
  CP $06                  ; Less than = Any Nasty!
  JP C,DescribeNasty
  CP $10                  ; Any Ice Crown Killers
  JP NC,DescribeCharCondition

DescribeOrGuidence:
  LD HL,ObjTokensU
  CALL FillPrintBuffer
  LD A,(WhatObject)
  LD (ObjectToDescribe),A
  CALL DescribeAnObject
  LD A,(WhatObject)
  CP $07                  ; Is it Guidance?
  JR Z,GiveSomeGuidance   ; Yes
  CALL StopToBuffer
  JR DescribeCharCondition
GiveSomeGuidance:
  CALL PercentToBuffer
  LD A,(WhatObjectFlag)
  CP $04
  JR NC,GiveMoreGuidance
  ADD A,$10               ; Add on 16
  LD (ObjectToDescribe),A ; Fawkrin,Farlame,Lake Mirrow,Lorgrim.
  CALL DescribeAnObject
  CALL Bytes_Print_Buffer
  DEFB $ED,$EB,$00,$FC,$9B,$FC,$EA,$FF ; 'Can Destroy The Ice Crown'
DescribeOrGuidence_0:
  CALL StopToBuffer
  CALL AndSignTobuffer
  CALL SetTokenToLowerCase
  JR DescribeCharCondition
GiveMoreGuidance:
  LD (TempCharacterNo),A
  CALL CopyCharDetails
  LD HL,(CharLocation)
  LD (WorkingLocation),HL
  CALL CalcMapLocation
  CALL Bytes_Print_Buffer
  DEFB $FC,$5B,$B6,$FF    ; 'Looking For'
  CALL FullCharTitle      ; Who are we looking for?
  CALL CommaToBuffer
  LD HL,TokensYouMustSeek ; This prints 'You Must Seek'
  CALL FillPrintBuffer
  CALL DescribeLocation   ; Where must we seek?
  JR DescribeOrGuidence_0

DescribeCharCondition:
  CALL SetTokenToUpperCase
  CALL PrintTimeStatus
  LD A,$87                ; 'And'
  CALL A_IntoPrintBuffer
  LD A,(SaveCurChar)
  LD (TempCharacterNo),A
  CALL CopyCharDetails
  CALL FirstNameToBuffer  ; Who is He.
  LD A,$70                ; 'Is'
  CALL A_IntoPrintBuffer
  LD A,(CharEnergyStatus)
  CALL ReportCharStatus   ; How is he?
  LD HL,TokensHowIsHe
  CALL FillPrintBuffer
  CALL DescribeIceFear    ; How's the Ice Fear?
  CALL StopToBuffer
  CALL FirstNameToBuffer  ; Who are we dealing with.
  LD A,$70                ; 'Is'
  CALL A_IntoPrintBuffer
  CALL DisplayCharCourage ; Are We Scared?
  CALL StopToBuffer
  LD A,(CharObjectCarrying)
  CP $00                  ; Are we carrying anything?
  RET Z                   ; Return if not.
  LD (ObjectToDescribe),A ; Otherwise describe what
  LD HL,TokensHeHasWithHim ; we are carrying.
  CALL FillPrintBuffer
  CALL DescribeAnObject
  JP StopToBuffer

DescribeIceFear:
  LD A,$40
  LD HL,(IceFear)
  CALL HowManyUnitsOf_A
  LD A,$07
  SUB L
  LD B,$F5                ; 'Mild'
  LD C,$F4                ; 'Cold'
  JR DisplayCharCourage_0

DisplayCharCourage:
  LD A,(CharCourageStatus)
  LD B,$F3                ; 'Bold'
  LD C,$F2                ; 'Afraid'
DisplayCharCourage_0:
  JP HowMuch_What

DescribeNasty:
  LD (ObjectToDescribe),A
  CP $05                  ; Is it wild Horses?
  JR Z,DescribeNasty_1    ; Yes.
  LD A,(WhatObjectFlag)
  CP $00
  JR NZ,HeKilledWhatHow
  CALL DescribeAnObject
  LD HL,TokensFightOrHide
  CALL FillPrintBuffer
DescribeNasty_0:
  CALL StopToBuffer       ; How does the character Fair?
  JP DescribeCharCondition
DescribeNasty_1:
  LD A,(WhatObjectFlag)
  CP $00                  ; Has the object been Described?
  JP NZ,DescribeOrGuidence ; Yes. Then no need to describe again.
  CALL DescribeAnObject
  CALL Bytes_Print_Buffer
  DEFB $AE,$AD,$FF        ; 'Are Abroad'
  JR DescribeNasty_0
HeKilledWhatHow:
  LD HL,KilledWhatHowDescription
  CALL FillPrintBuffer
  CALL DescribeAnObject   ; What did we kill
  LD A,(CharObjectCarrying)
  CP $0E
  JR NC,DescribeNasty_2
  CP $0C
  JR C,DescribeNasty_2
  LD (ObjectToDescribe),A
  LD A,$E3                ; 'With'
  CALL A_IntoPrintBuffer
  CALL DescribeAnObject
DescribeNasty_2:
  JP DescribeNasty_0

IncDoomDarksArmy:
  LD E,A
  LD A,D                  ; E=Number, A=Type
  LD D,$00                ; Reset D
  CP $00                  ; Are they Warriors
  JR NZ,IncDoomDarksArmy_0 ; If not then do riders
  LD HL,(DoomDarks_Warriors) ; else
  ADD HL,DE               ; Increment the number of Warriors
  LD (DoomDarks_Warriors),HL
  RET
IncDoomDarksArmy_0:
  LD HL,(DoomDarks_Riders) ; Deal with the Riders.
  ADD HL,DE               ; Increment the number of Riders
  LD (DoomDarks_Riders),HL
  RET

BeenSomeDeaths:
  LD A,(NoOfDeathsDescribed)
  INC A
  LD (NoOfDeathsDescribed),A
  CP $01
  JR NZ,BeenSomeDeaths_0
  LD HL,TokensDeathMessage
  CALL FillPrintBuffer
  JR BeenSomeDeaths_1
BeenSomeDeaths_0:
  LD A,$87
  CALL A_IntoPrintBuffer
BeenSomeDeaths_1:
  LD A,$40
  CALL A_IntoPrintBuffer
  LD A,(TempVar)
  LD (LocationArea),A
  CALL DescribeLocationArea
  JP FlushPrintBuffer

; A message on death
TokensDeathMessage:
  DEFB $FB,$FC,$00,$1B    ; 'The Bloody'
  DEFB $FE,$79,$E6,$40    ; 'Sword Of'
  DEFB $C3,$E5,$0B,$54    ; 'Battle Brings Death In'
  DEFB $00,$FC,$52,$FF    ; 'The Domain'

; Objects Description Table
ObjectDescriptionLookupTable:
  DEFW ObjTokensD,ObjTokensE,ObjTokensF,ObjTokensG
  DEFW ObjTokensH,ObjTokensI,ObjTokensJ,ObjTokensK
  DEFW ObjTokensL,ObjTokensC,ObjTokensM,ObjTokensN
  DEFW ObjTokensO,ObjTokensP,ObjTokensR,ObjTokensQ
  DEFW ObjTokensS,ObjTokensT,ObjTokensA,ObjTokensB

DisplayCharThink:
  LD A,(KeyReturnStatus)
  CP $02                  ; Have we been here before?
  JR Z,DisplayCharThink_1 ; Yes. Skip intialise
DisplayCharThink_0:
  XOR A
  LD (HowManyCharsInFrontDescribed),A ; Initialise the Variables
  LD (Think_TempOne),A
  LD (Think_TempThree),A
  LD A,$02                ; We've been here before
  LD (KeyReturnStatus),A
DisplayCharThink_1:
  CALL GetLatestCharInfo
  LD A,(CharLifeStatus)
  CP $00                  ; Still Alive?
  JP Z,WhoKilledHim       ; No. Describe in details how he died!
DescribeInDetailHowHeDied:
  LD A,(Think_TempOne)
  CP $00
  JR NZ,DisplayCharThink_2
  INC A
  LD (Think_TempOne),A
  JP DescribeWho
DisplayCharThink_2:
  CP $01
  JR NZ,DisplayCharThink_3
  INC A
  LD (Think_TempOne),A
  LD A,(CharBattleStatus)
  CP $FF
  JR Z,DisplayCharThink_1
  JP DescribeBattle
DisplayCharThink_3:
  CP $02
  JR NZ,DisplayCharThink_6
  LD A,(Think_TempThree)
  INC A
  LD (Think_TempThree),A
  CP $01
  JR Z,DisplayCharThink_4
  CALL CheckLocationInfront
  LD A,$03
  LD (Think_TempOne),A
DisplayCharThink_4:
  LD A,(LocationFeature)
  CP $01                  ; Are we at a Citadel?
  JR Z,DisplayCharThink_5
  CP $07                  ; Are We at a Keep?
  JR Z,DisplayCharThink_5
  LD A,(DoomDarksArmyPosInTable)
  CP $00                  ; Are there any armies here?
  JR Z,DisplayCharThink_1 ; If none of the above then skip.
DisplayCharThink_5:
  CALL WeAreLooking       ; Describe where we are looking
  JP DisplayArmiesHere    ; ...and who is here!
DisplayCharThink_6:
  LD A,(Think_TempThree)
  CP $01
  CALL NZ,CheckLocationInfront
  LD A,(NoInCharHereTable) ; How many Characters are infront?
  LD B,A
  LD A,(HowManyCharsInFrontDescribed) ; How many have we described?
  CP B
  JR NC,DisplayCharThink_7
  LD (CharInHereTable),A
  INC A
  LD (HowManyCharsInFrontDescribed),A
  CALL GetFromCharHereTable
  JP DescribeWhatCharSees
DisplayCharThink_7:
  LD A,(Think_TempThree)
  CP $01
  JP Z,DisplayCharThink_0
  DEC A
  LD (Think_TempThree),A
  XOR A
  LD (HowManyCharsInFrontDescribed),A
  JP DisplayCharThink_1

CheckLocationInfront:
  LD HL,(DesirableLocation)
  LD (CurrentLocationY),HL
  JP WorkOutLocationDetails

WeAreLooking:
  LD A,(Think_TempThree)
  CP $01
  JP Z,SetTokenToUpperCase
  CALL Bytes_Print_Buffer
  DEFB $FC,$5C,$00,$FF    ; 'To The'
  CALL LookingWhere       ; Where are we looking towards?
  JP CommaToBuffer

DescribeWhatCharSees:
  CALL WeAreLooking
  JP DisplayArmyStatus

WhoKilledHim:
  CALL SetTokenToUpperCase
  LD A,(CharDeathStatus)
  CP $00                  ; Was it anything that killed him
  JR NZ,WhoKilledHim_0    ; Yes.
  CALL Bytes_Print_Buffer ; No. Must have died in battle.
  DEFB $55,$90,$F1,$54,$C3,$FE,$2E,$FF ; 'He Was Killed In Battle.'
  JP DescribeBattle       ; Which Battle?
WhoKilledHim_0:
  LD (ObjectToDescribe),A ; Describe what actually Killed him!
  CALL DescribeAnObject
  CALL Bytes_Print_Buffer
  DEFB $C7,$F9,$FE,$2E,$FF ; 'Slew Him.'
  RET

DisplayArmiesHere:
  LD A,(DoomDarksArmyPosInTable)
  CP $00                  ; Has doomdark go any armies here?
  JR Z,DisplayArmiesHere_1 ; If not don't print the message!
  CALL Bytes_Print_Buffer
  DEFB $FC,$0C,$FD,$A0,$8A,$95,$4F,$40 ; 'DoomDark Has An Army Of'
  DEFB $FF
  LD HL,(DoomDarks_Warriors) ; How many Warriors?
  CALL HowManyWarriors_1
  CALL AndToBuffer
  LD HL,(DoomDarks_Riders) ; How Many Riders?
  CALL HowManyRiders_1
  CALL StopToBuffer
  LD A,(LocationFeature)
  CP $01                  ; Are we at a keep or citadel?
  JR Z,DisplayArmiesHere_0 ; Yes. At Citadel
  CP $07
  RET NZ
DisplayArmiesHere_0:
  CALL SetTokenToUpperCase ; No.
DisplayArmiesHere_1:
  LD A,(WhoGuardsThePlace)
  CP $00
  JR NZ,DisplayArmiesHere_2 ; Riders Here!
  LD A,(HowManyGuardsThePlace)
  CALL HowManyWarriors    ; Display Warriors
  JR DisplayArmiesHere_3
DisplayArmiesHere_2:
  LD A,(HowManyGuardsThePlace) ; Display Riders
  CALL HowManyRiders
DisplayArmiesHere_3:
  CALL Bytes_Print_Buffer
  DEFB $40,$00,$FC,$FF    ; 'Of The'
  LD A,(WhoseRaceIsArmy)  ; Belonging to whom
  CP $00                  ; Is it the DoomGuard?
  JR NZ,DisplayArmiesHere_4 ; Anything other than zero isn't
  CALL Bytes_Print_Buffer
  DEFB $0C,$FD,$9E,$FF    ; 'DoomGuard'
  JR DisplayArmiesHere_8
DisplayArmiesHere_4:
  CP $01                  ; Are They Belonging to the Free?
  JR NZ,DisplayArmiesHere_5
  LD A,$9F                ; 'Free'
  JR DisplayArmiesHere_7
DisplayArmiesHere_5:
  CP $02                  ; Belonging to the Fey
  JR NZ,DisplayArmiesHere_6
  LD A,$7A                ; 'Fey'
  JR DisplayArmiesHere_7
DisplayArmiesHere_6:
  LD A,$39                ; Must be 'Targ'
DisplayArmiesHere_7:
  CALL A_IntoPrintBuffer
DisplayArmiesHere_8:
  CALL Bytes_Print_Buffer
  DEFB $9E,$00,$FF        ; 'Guard The'
  LD A,(LocationFeature)  ; Where are we?
  ADD A,$41               ; Get token
  CALL A_IntoPrintBuffer
  JR LEFF6

GetLatestCharInfo:
  CALL UpdateCharsVars
  CALL FindLookingTowards
  CALL WorkOutLocationDetails

UpdateCharsVars:
  LD A,(SaveCurChar)
  LD (TempCharacterNo),A
  CALL CopyCharDetails
  LD HL,(CharLocation)
  LD (CurrentLocationY),HL
  LD A,(CharLookDirection)
  LD (CurrentlyLooking),A
  RET

AddToBufferAndKeyTable:
  LD C,A
  CALL SetTokenToLowerCase
  CALL HashToBuffer
  LD A,C
  LD B,$00
  LD HL,KeyTableAddress
  ADD HL,BC
  LD (HL),A
  CALL AddLiteralToBuffer
  JP SetTokenToUpperCase

LEFF6:
  JP StopToBuffer

AndToBuffer:
  LD A,$87
  JP A_IntoPrintBuffer

; DOS source code has this as the last Race Image table entry
LEFFE:
  DEFB $E6,$58

; Pixel Generation tables
PixelGenTable:
  DEFB $80,$40,$20,$10,$08,$04,$02,$01
PixelGenTable_F008:
  DEFB $FF,$7F,$3F,$1F,$0F,$07,$03,$01
PixelGenTable_F010:
  DEFB $80,$C0,$E0,$F0,$F8,$FC,$FE,$FF
  DEFB $00,$40,$60,$70,$78,$7C,$7E,$7F
  DEFB $00,$00,$20,$30,$38,$3C,$3E,$3F
  DEFB $00,$00,$00,$10,$18,$1C,$1E,$1F
  DEFB $00,$00,$00,$00,$08,$0C,$0E,$0F
  DEFB $00,$00,$00,$00,$00,$04,$06,$07
  DEFB $00,$00,$00,$00,$00,$00,$02,$03
  DEFB $00,$00,$00,$00,$00,$00,$00,$01

; Terrain Image Table
TerrainLookupTable:
  DEFW TerrainMountain1   ; Mountain
  DEFW TerrainMountain2
  DEFW TerrainMountain3
  DEFW TerrainMountain4
  DEFW TerrainMountain5
  DEFW TerrainMountain6
  DEFW TerrainMountain7
  DEFW TerrainMountain8
  DEFW TerrainCitadel1    ; Citadel
  DEFW TerrainCitadel2
  DEFW TerrainCitadel3
  DEFW TerrainCitadel4
  DEFW TerrainCitadel5
  DEFW TerrainCitadel6
  DEFW TerrainCitadel7
  DEFW TerrainCitadel8
  DEFW TerrainForest1     ; Forest
  DEFW TerrainForest2
  DEFW TerrainForest3
  DEFW TerrainForest4
  DEFW TerrainForest5
  DEFW TerrainForest6
  DEFW TerrainForest7
  DEFW TerrainForest8
  DEFW TerrainHenge1      ; Henge
  DEFW TerrainHenge2
  DEFW TerrainHenge3
  DEFW TerrainHenge4
  DEFW TerrainHenge5
  DEFW TerrainHenge6
  DEFW TerrainHenge7
  DEFW TerrainHenge8
  DEFW TerrainTower1      ; Tower
  DEFW TerrainTower2
  DEFW TerrainTower3
  DEFW TerrainTower4
  DEFW TerrainTower5
  DEFW TerrainTower6
  DEFW TerrainTower7
  DEFW TerrainTower8
  DEFW TerrainVillage1    ; Village
  DEFW TerrainVillage2
  DEFW TerrainVillage3
  DEFW TerrainVillage4
  DEFW TerrainVillage5
  DEFW TerrainVillage6
  DEFW TerrainVillage7
  DEFW TerrainVillage8
  DEFW TerrainDowns1      ; Downs
  DEFW TerrainDowns2
  DEFW TerrainDowns3
  DEFW TerrainDowns4
  DEFW TerrainDowns5
  DEFW TerrainDowns6
  DEFW TerrainDowns7
  DEFW TerrainDowns8
  DEFW TerrainKeep1       ; Keep
  DEFW TerrainKeep2
  DEFW TerrainKeep3
  DEFW TerrainKeep4
  DEFW TerrainKeep5
  DEFW TerrainKeep6
  DEFW TerrainKeep7
  DEFW TerrainKeep8
  DEFW TerrainSnowHall1   ; SnowHall
  DEFW TerrainSnowHall2
  DEFW TerrainSnowHall3
  DEFW TerrainSnowHall4
  DEFW TerrainSnowHall5
  DEFW TerrainSnowHall6
  DEFW TerrainSnowHall7
  DEFW TerrainSnowHall8
  DEFW TerrainLake1       ; Lake
  DEFW TerrainLake2
  DEFW TerrainLake3
  DEFW TerrainLake4
  DEFW TerrainLake5
  DEFW TerrainLake6
  DEFW TerrainLake7
  DEFW TerrainLake8
  DEFW TerrainFrozenWastes1 ; Frozen Wastes
  DEFW TerrainFrozenWastes2
  DEFW TerrainFrozenWastes3
  DEFW TerrainFrozenWastes4
  DEFW TerrainFrozenWastes5
  DEFW TerrainFrozenWastes6
  DEFW TerrainFrozenWastes7
  DEFW TerrainFrozenWastes8
  DEFW TerrainRuin1       ; Ruin
  DEFW TerrainRuin2
  DEFW TerrainRuin3
  DEFW TerrainRuin4
  DEFW TerrainRuin5
  DEFW TerrainRuin6
  DEFW TerrainRuin7
  DEFW TerrainRuin8
  DEFW TerrainLith1       ; Lith
  DEFW TerrainLith2
  DEFW TerrainLith3
  DEFW TerrainLith4
  DEFW TerrainLith5
  DEFW TerrainLith6
  DEFW TerrainLith7
  DEFW TerrainLith8
  DEFW TerrainCavern1     ; Cavern
  DEFW TerrainCavern2
  DEFW TerrainCavern3
  DEFW TerrainCavern4
  DEFW TerrainCavern5
  DEFW TerrainCavern6
  DEFW TerrainCavern7
  DEFW TerrainCavern8
  DEFW TerrainArmy1       ; Army
  DEFW TerrainArmy2
  DEFW TerrainArmy3
  DEFW TerrainArmy4
  DEFW TerrainArmy5
  DEFW TerrainArmy6
  DEFW TerrainArmy7
  DEFW TerrainArmy8

; Terrain drawing routines
CalcPlotMask:
  LD C,A
  LD B,$00
  LD HL,(Image_XPixel)
  ADD HL,BC
  DEC H
  RET NZ
  LD C,L
  LD HL,PixelGenTable
  LD A,C
  AND $07
  ADD A,L
  LD L,A
  LD A,(HL)
  SRL C
  SRL C
  SRL C
  LD H,$00
  LD L,C
  ADD HL,DE
  RET

PSET:
  CALL CalcPlotMask
PSET_0:
  OR (HL)
  LD (HL),A
  RET

PRESET:
  CALL CalcPlotMask
  LD B,A
  LD A,(Image_PlotOnOff)
  CP $00
  LD A,B
  JR NZ,PSET_0
  XOR $FF
  AND (HL)
  LD (HL),A
  RET

; Draws a line
;
; B = Start, C = End
DrawLine:
  PUSH BC
  LD A,(Image_PlotOnOff)
  CP $00
  EX AF,AF'
  LD B,$00
  LD HL,(Image_XPixel)
  ADD HL,BC
  DEC H
  POP BC
  RET M
  JR Z,DrawLine_0
  LD L,$FF
DrawLine_0:
  LD A,L
  LD (LFF04),A
  LD C,B
  LD B,$00
  LD HL,(Image_XPixel)
  ADD HL,BC
  DEC H
  JR Z,DrawLine_1
  RET P
  LD L,$00
DrawLine_1:
  LD A,L
  LD (LFF03),A
  SRL A
  SRL A
  SRL A
  LD (LFF05),A
  LD A,(LFF03)
  AND $07
  LD (LFF07),A
  LD A,(LFF04)
  SRL A
  SRL A
  SRL A
  LD (LFF06),A
  LD A,(LFF04)
  AND $07
  LD (LFF08),A
  LD A,(LFF05)
  LD H,$00
  LD L,A
  ADD HL,DE
  PUSH HL
  LD B,A
  LD A,(LFF06)
  CP B
  JR NZ,DrawLine_3
  LD A,(LFF07)
  SLA A
  SLA A
  SLA A
  LD C,A
  LD A,(LFF08)
  OR C
  LD C,A
  LD B,$00
  LD HL,PixelGenTable_F010
  ADD HL,BC
  LD A,(HL)
  POP HL
  EX AF,AF'
  JR Z,DrawLine_2
  EX AF,AF'
  OR (HL)
  LD (HL),A
  RET
DrawLine_2:
  EX AF,AF'
  XOR $FF
  AND (HL)
  LD (HL),A
  RET
DrawLine_3:
  LD A,(LFF07)
  LD C,A
  LD B,$00
  LD HL,PixelGenTable_F008
  ADD HL,BC
  LD A,(HL)
  POP HL
  EX AF,AF'
  JR Z,DrawLine_4
  EX AF,AF'
  OR (HL)
  JR DrawLine_5
DrawLine_4:
  EX AF,AF'
  XOR $FF
  AND (HL)
DrawLine_5:
  LD (HL),A
  LD A,(LFF05)
  LD B,A
  LD A,(LFF06)
  LD C,A
DrawLine_6:
  INC HL
  INC B
  LD A,B
  CP C
  JR Z,DrawLine_7
  LD A,(Image_PlotOnOff)
  LD (HL),A
  JR DrawLine_6
DrawLine_7:
  PUSH HL
  LD A,(LFF08)
  LD C,A
  LD B,$00
  LD HL,PixelGenTable_F010
  ADD HL,BC
  LD A,(HL)
  POP HL
  EX AF,AF'
  JR Z,DrawLine_8
  EX AF,AF'
  OR (HL)
  LD (HL),A
  RET
DrawLine_8:
  EX AF,AF'
  XOR $FF
  AND (HL)
  LD (HL),A
  RET

DrawFeature:
  LD A,(Feature_Draw)
  CP $0F                  ; Can't Draw Plains
  RET P
  SLA A                   ; A*8
  SLA A
  SLA A
  LD C,A
  LD A,(Feature_Size)     ; Add on Size
  ADD A,C
  SLA A                   ; A*2
  LD C,A
  LD B,$00
  LD HL,TerrainLookupTable
  ADD HL,BC
  LD A,(HL)
  LD (FeatureAddress),A
  INC HL
  LD A,(HL)
  LD (FeatureAddress+$0001),A
  LD A,$00
  LD (Image_YOffset),A
  CALL CalcLineOnScreen   ; Calc Screen Position
  LD IX,(FeatureAddress)
  LD A,(IX+$00)
  LD (Image_Height),A     ; 1st byte is the height
DrawFeature_0:
  INC IX
  LD A,$00
  LD (Image_AnotherBit),A
  LD A,$FF
  LD (Image_PlotOnOff),A  ; Set to draw
  LD B,(IX+$00)           ; Bit 7 = Another Item
  BIT 7,B                 ; Bit 6 = draw / erase
  JR Z,DrawFeature_1      ; Bits 5 - 0 = No of Draw Instructions
  LD A,$01
  LD (Image_AnotherBit),A ; More than one item on this line
DrawFeature_1:
  BIT 6,B
  JR Z,DrawFeature_2
  LD A,$00
  LD (Image_PlotOnOff),A  ; Set erase
DrawFeature_2:
  LD A,B
  AND $3F
  LD (Image_DrawInstrucs),A ; How many draw items
  INC IX
  LD B,(IX+$00)           ; Start of Line
  INC IX
  LD C,(IX+$00)           ; End of Line
  CALL DrawLine           ; Draw Line / Actually this is an erase
  DEC IX                  ; For the same two points
  LD A,(IX+$00)           ; Used for the erased line we
  CALL PSET               ; Must plot the first
  INC IX                  ; and last point on the
  LD A,(IX+$00)           ; line
  CALL PSET
  LD A,(Image_PlotOnOff)
  XOR $FF
  LD (Image_PlotOnOff),A  ; Drawing ON
  LD A,(Image_DrawInstrucs)
  CP $00
  JR Z,DrawFeature_6      ; Skip if no draw instrucs left
DrawFeature_3:
  INC IX
  LD A,(IX+$00)
  BIT 7,A                 ; Bit 7 = DrawLine
  JR NZ,DrawFeature_4     ; Else just do a point
  AND $7F                 ; What pixel
  CALL PRESET             ; Set it
  JR DrawFeature_5
DrawFeature_4:
  AND $7F
  LD B,A                  ; B = startofline
  INC IX
  LD C,(IX+$00)           ; C = End
  CALL DrawLine           ; Draw the line
DrawFeature_5:
  LD A,(Image_DrawInstrucs)
  DEC A
  LD (Image_DrawInstrucs),A
  JR NZ,DrawFeature_3     ; Draw the line
DrawFeature_6:
  LD A,(Image_AnotherBit)
  CP $00
  JR NZ,DrawFeature_0     ; Repeat if more bits
  LD A,(Image_YOffset)
  INC A
  LD (Image_YOffset),A    ; Next Line up
  CALL CalcLineOnScreen   ; Recalc screen position
  LD A,(Image_Height)
  DEC A
  LD (Image_Height),A
  JP NZ,DrawFeature_0     ; Repeat if more lines to process
  RET

CalcLineOnScreen:
  LD A,(Image_YOffset)
  LD B,A
  LD A,(Image_YPixel)
  ADD A,B
  LD B,A
  LD A,$AF
  SUB B
  LD B,A
  AND $07
  OR $40
  LD D,A
  LD A,B
  SRL A
  SRL A
  SRL A
  AND $18
  OR D
  LD D,A
  LD A,B
  SLA A
  SLA A
  AND $E0
  LD E,A
  RET

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
  DEFB $05,$04,$56,$00,$40,$07 ; 5,  4,  86, 64, 7
  DEFB $04,$05,$72,$00,$40,$07 ; 4,  5, 114, 64, 7
  DEFB $06,$02,$29,$00,$40,$07 ; 6,  2,  41, 64, 7
  DEFB $06,$01,$15,$00,$40,$07 ; 6,  1,  21, 64, 7
  DEFB $06,$FF,$EB,$FF,$40,$07 ; 6, -1, -21, 64, 7
  DEFB $06,$00,$00,$00,$40,$07 ; 6,  0,   0, 64, 7
  DEFB $05,$03,$45,$00,$3F,$07 ; 5,  3,  69, 63, 7
  DEFB $03,$05,$83,$00,$3F,$07 ; 3,  5, 131, 63, 7
  DEFB $04,$04,$64,$00,$3F,$07 ; 4,  4, 100, 63, 7
  DEFB $05,$02,$30,$00,$3F,$06 ; 5,  2,  48, 63, 6
  DEFB $05,$01,$19,$00,$3F,$06 ; 5,  1,  25, 63, 6
  DEFB $05,$FF,$E7,$FF,$3F,$06 ; 5, -1, -25, 63, 6
  DEFB $05,$00,$00,$00,$3E,$06 ; 5,  0,   0, 62, 6
  DEFB $04,$03,$52,$00,$3E,$06 ; 4,  3,  82, 62, 6
  DEFB $03,$04,$76,$00,$3E,$06 ; 3,  4, 118, 62, 6
  DEFB $04,$02,$3B,$00,$3E,$06 ; 4,  2,  59, 62, 6
  DEFB $03,$03,$64,$00,$3D,$05 ; 3,  3, 100, 61, 5
  DEFB $04,$01,$1F,$00,$3D,$05 ; 4,  1,  31, 61, 5
  DEFB $04,$FF,$E1,$FF,$3D,$05 ; 4, -1, -31, 61, 5
  DEFB $04,$00,$00,$00,$3C,$05 ; 4,  0,   0, 60, 5
  DEFB $03,$02,$4B,$00,$3B,$05 ; 3,  2,  75, 59, 5
  DEFB $02,$03,$7D,$00,$3B,$05 ; 2,  3, 125, 59, 5
  DEFB $03,$01,$29,$00,$3A,$04 ; 3,  1,  41, 58, 4
  DEFB $03,$FF,$D7,$FF,$3A,$04 ; 3, -1, -41, 58, 4
  DEFB $03,$00,$00,$00,$39,$04 ; 3,  0,   0, 57, 4
  DEFB $02,$02,$64,$00,$39,$04 ; 2,  2, 100, 57, 4
  DEFB $02,$01,$3B,$00,$35,$03 ; 2,  1,  59, 53, 3
  DEFB $01,$02,$8D,$00,$35,$03 ; 1,  2, 141, 53, 3
  DEFB $02,$00,$00,$00,$33,$02 ; 2,  0,   0, 51, 2
  DEFB $01,$01,$64,$00,$2B,$01 ; 1,  1, 100, 43, 1
  DEFB $01,$00,$00,$00,$20,$00 ; 1,  0,   0, 32, 0

CalcMapLocation:
  LD BC,(WorkingLocation)
  XOR A
  CP B
  JR Z,OffTheMap          ; Not On Map
  LD A,$3D
  CP B
  JR C,OffTheMap          ; Not On Map
  LD A,$3F
  CP C
  JR C,OffTheMap          ; Not On Map
  CALL CalcMapHL          ; Reference FeatureMap
  LD A,(HL)               ; Get from map
  LD D,A
  AND $0F                 ; First 4 bits are the feature
  LD (LocationFeature),A
  LD A,D
  SRL A                   ; Rotate it right 4 times to get the second 4 bits
  SRL A                   ;
  SRL A                   ;
  SRL A                   ;
  LD (LocationObject),A   ; They are the object
  LD BC,$0F40
  ADD HL,BC               ; Reference Description Map
  LD A,(HL)
  LD D,A
  AND $3F                 ; First six bits are the area
  LD (LocationArea),A
  LD A,D
  AND $40                 ; Bit seven is the Domain flag (Are we in one!)
  LD (LocDomainFlag),A
  LD A,D
  AND $80                 ; Bit
  JR CalcMapLocation_0
OffTheMap:
  LD A,$0A
  LD (LocationFeature),A
  LD A,$00
  LD (LocationObject),A
  LD (LocationArea),A
  LD (LocDomainFlag),A
CalcMapLocation_0:
  LD (LocSpecialFlag),A
  RET

CalcMapHL:
  PUSH BC
  LD C,$00
  SRL B
  RR C
  SRL B
  RR C
  LD HL,MainMapCalcHLTable
  ADD HL,BC
  POP BC
  LD B,$00
  ADD HL,BC
  RET

DrawGraphicView:
  LD A,(LandscapePosition)
  SLA A
  LD B,A
  SLA A                   ; A*6
  ADD A,B
  LD C,A
  LD B,$00
  LD HL,LandscapeLocCalcTable
  ADD HL,BC
  LD A,(HL)
  LD (Landscape_YAdjust),A
  INC HL
  LD A,(HL)
  LD (Landscape_XAdjust),A
  INC HL
  LD A,(HL)
  LD (Landscape_ScrAdjust),A
  INC HL
  LD A,(HL)
  LD (Landscape_ScrAdjust+$0001),A
  INC HL
  LD A,(HL)
  LD (Image_YPixel),A
  INC HL
  LD A,(HL)
  LD (Feature_Size),A
  LD A,(CurrentLocationY)
  LD B,A
  LD A,(Landscape_XAdjustDoWhat)
  CALL DrawGraphicView_4
  LD (WorkingLocation),A
  LD A,(CurrentLocationY+$0001)
  LD B,A
  LD A,(Landscape_YAdjustDoWhat)
  CALL DrawGraphicView_4
  LD (WorkingLocation+$0001),A
  CALL CalcMapLocation
  LD HL,$0140
  LD BC,(Landscape_ScrAdjust)
  LD A,(Landscape_ScrAdjustDoWhat)
  CP $00
  JR NZ,DrawGraphicView_0
  ADD HL,BC
  LD (Image_XPixel),HL
  JR DrawGraphicView_3
DrawGraphicView_0:
  CP $01
  JR NZ,DrawGraphicView_1
  AND A                   ; Clear carry
  SBC HL,BC
  LD (Image_XPixel),HL
  JR DrawGraphicView_3
DrawGraphicView_1:
  CP $02
  JR NZ,DrawGraphicView_2
  ADD HL,BC
  LD BC,$0064
  AND A
  SBC HL,BC
  LD (Image_XPixel),HL
  JR DrawGraphicView_3
DrawGraphicView_2:
  AND A
  SBC HL,BC
  LD BC,$0064
  ADD HL,BC
  LD (Image_XPixel),HL
DrawGraphicView_3:
  LD A,(LocationFeature)
  LD (Feature_Draw),A
  CALL DrawFeature
  RET
DrawGraphicView_4:
  CP $00
  JR NZ,DrawGraphicView_5
  LD A,(Landscape_YAdjust)
  ADD A,B
  RET
DrawGraphicView_5:
  CP $01
  JR NZ,DrawGraphicView_6
  LD A,(Landscape_YAdjust)
  LD C,A
  LD A,B
  SUB C
  RET
DrawGraphicView_6:
  CP $02
  JR NZ,DrawGraphicView_7
  LD A,(Landscape_XAdjust)
  ADD A,B
  RET
DrawGraphicView_7:
  LD A,(Landscape_XAdjust)
  LD C,A
  LD A,B
  SUB C
  RET

DrawGraphicVision:
  LD A,$01
  LD (Landscape_LeftScrDoWhat),A
  LD A,$00
  LD (Landscape_RightScrDoWhat),A
  LD A,(CurrentlyLooking) ; Where are we looking?
  AND $01                 ; If bit 1 is set then
  CP $00                  ; we are looking NE,SE,SW,NW
  JR Z,DrawGraphicVision_0 ; otherwisw its N,E,S,W
  LD A,$02
  LD (Landscape_LeftScrDoWhat),A
  LD A,$03
  LD (Landscape_RightScrDoWhat),A
DrawGraphicVision_0:
  LD A,(CurrentlyLooking)
  LD C,A
  LD B,$00
  LD HL,LandscapeDirAdjustTableX
  ADD HL,BC
  LD A,(HL)
  LD (Landscape_LeftXAdjustDoWhat),A
  INC HL
  LD A,(HL)
  LD (Landscape_RightXAdjustDoWhat),A
  LD HL,LandscapeDirAdjustTableY
  ADD HL,BC
  LD A,(HL)
  LD (Landscape_LeftYAdjustDoWhat),A
  INC HL
  LD A,(HL)
  LD (Landscape_RightYAdjustDoWhat),A
  LD A,$00
  LD (LandscapePosition),A
DrawGraphicVision_1:
  LD A,(Landscape_LeftScrDoWhat)
  LD (Landscape_ScrAdjustDoWhat),A
  LD A,(Landscape_LeftXAdjustDoWhat)
  LD (Landscape_XAdjustDoWhat),A
  LD A,(Landscape_LeftYAdjustDoWhat)
  LD (Landscape_YAdjustDoWhat),A
  CALL DrawGraphicView
  LD A,(Landscape_RightScrDoWhat)
  LD (Landscape_ScrAdjustDoWhat),A
  LD A,(Landscape_RightXAdjustDoWhat)
  LD (Landscape_XAdjustDoWhat),A
  LD A,(Landscape_RightYAdjustDoWhat)
  LD (Landscape_YAdjustDoWhat),A
  CALL DrawGraphicView
  LD A,(LandscapePosition)
  INC A
  LD (LandscapePosition),A
  CP $1F
  JR NZ,DrawGraphicVision_1
  RET

; Landscape Direction Adjustment tables
LandscapeDirAdjustTableX:
  DEFB $03,$02,$00,$00,$02,$03,$01,$01,$03

LandscapeDirAdjustTableY:
  DEFB $01,$01,$03,$02,$00,$00,$02,$03,$01

LocateOnScreen:
  LD A,(Print_Row)
  LD H,A                  ; HL = Attributes
  AND $18                 ; DE = ScreenAddress
  OR $40
  LD D,A
  LD L,$00
  SRL H
  RR L
  SRL H
  RR L
  SRL H
  RR L
  LD A,H
  OR $58
  LD H,A
  LD A,(Print_Col)
  OR L
  LD L,A
  LD E,A
  RET

PrintAsciiChar:
  CALL LocateOnScreen
  LD A,(Print_Attr)
  LD (HL),A
  LD H,$00
  LD A,(Print_Char)
  LD L,A
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  LD BC,(CHARS)
  ADD HL,BC
  LD B,$08
  LD A,(Print_Mask)
  LD C,A
PrintAsciiChar_0:
  LD A,(HL)
  XOR C
  LD (DE),A
  INC HL
  INC D
  DJNZ PrintAsciiChar_0
  RET

DisplayCharacter:
  LD HL,(CHARS)
  PUSH HL
  LD HL,CharacterGraphics
  LD (CHARS),HL
  XOR A
  LD (Print_Mask),A
  LD HL,CharacterLookupTable ; CharacterDataTable
  LD A,(CharacterToPrint)
  ADD A,A
  LD B,A                  ; *6
  ADD A,A
  ADD A,B
  LD C,A
  LD B,$00
  ADD HL,BC
  LD A,(HL)
  LD (Window_Width),A     ; Depth of Character
  INC HL
  LD A,(HL)
  LD (Window_Depth),A     ; Width of Character
  LD B,A
  LD A,(Row)
  SUB B
  INC A
  LD (Print_Row),A
  INC HL
  LD B,(HL)               ; BC=Address Character Data
  INC HL
  LD C,(HL)
  INC HL
  LD D,(HL)               ; DE=Attributes Character
  INC HL
  LD E,(HL)
  XOR A
  LD H,A
DisplayCharacter_0:
  XOR A
  LD L,A
  LD A,(Column)
  LD (Print_Col),A
DisplayCharacter_1:
  LD A,(BC)
  LD (Print_Char),A
  CP $00
  JR Z,DisplayCharacter_2
  LD A,(DE)
  PUSH HL
  LD H,A
  LD A,(Window_Attr)
  AND H
  LD H,A
  LD A,(Print_Ink)
  OR H
  LD (Print_Attr),A
  PUSH BC
  PUSH DE
  CALL PrintAsciiChar
  POP DE
  POP BC
  POP HL
DisplayCharacter_2:
  INC DE
  INC BC
  LD A,(Print_Col)
  INC A
  LD (Print_Col),A
  INC L
  LD A,(Window_Width)
  CP L
  JR NZ,DisplayCharacter_1
  INC H
  LD A,(Print_Row)        ; New Row
  INC A
  LD (Print_Row),A
  LD A,(Window_Depth)
  CP H                    ; Have We Finised
  JR NZ,DisplayCharacter_0
  POP HL
  LD (CHARS),HL
  RET

CopyScreen:
  XOR A
  LD (Print_Row),A
  LD (Print_Col),A
CopyScreen_0:
  CALL LocateOnScreen
  LD HL,WorkSpaceArea
  LD C,$08
CopyScreen_1:
  LD B,$20
  PUSH DE
CopyScreen_2:
  LD A,(DE)
  LD (HL),A
  INC DE
  INC HL
  DJNZ CopyScreen_2
  POP DE
  INC D
  DEC C
  LD A,C
  CP $00
  JR NZ,CopyScreen_1
  CALL $0ECD
  LD A,(Print_Row)
  INC A
  LD (Print_Row),A
  CP $18
  JR NZ,CopyScreen_0
  LD HL,WorkSpaceArea
  LD B,$00
  XOR A
CopyScreen_3:
  LD (HL),A
  INC HL
  DJNZ CopyScreen_3
  CALL $0ECD
  RET

Bytes_Print_Buffer:
  POP HL
  CALL FillPrintBuffer
  INC HL
  PUSH HL
  RET

DecodeToken:
  LD A,(Print_Temp)       ; A=Token Required
  LD HL,$0000             ; HL=Required Byte
  LD B,A
  INC B                   ; One more than required token
DecodeToken_0:
  LD C,B
  CALL GetRequiredByte
  LD B,C                  ; Is this the start of
  DJNZ DecodeToken_1      ; the Token we want?
  JR GetTokenChars
DecodeToken_1:
  LD D,$00                ; No
  LD E,A                  ; Add on the length of
  ADD HL,DE               ; this token to our required
  JR DecodeToken_0        ; Byte and loop
GetTokenChars:
  DEC A                   ; Length-1
  LD B,A                  ; Set up loop
  LD A,(TextLength)       ; Increment the text buffer length
  ADD A,B
  LD (TextLength),A
  INC HL
  LD DE,(TextBuffer)      ; Position in buffer
DecodeToken_2:
  LD C,B
  CALL GetASCIIchar       ; Get the ASCII byte
  DJNZ DecodeToken_2      ; Loop for all Chars.
  LD (TextBuffer),DE
  RET

PrintWordFromBuffer:
  LD A,(ViewPoint_Col)
  LD B,A                  ; What Column are we on?
  LD A,(TextLength)       ; How Big is this line?
  ADD A,B
  LD C,A
  LD A,(ViewPoint_Width)  ; What's the width of our viewpoint?
  SUB C                   ; Check to see if there's enough space.
  JP P,PrintWordFromBuffer_0 ; We're Okay to print.
  LD A,(ViewPoint_StartCol)
  DEC A
  LD (ViewPoint_Col),A    ; Reset the Column.
  LD A,(ViewPoint_Row)
  INC A                   ; Next Row.
  LD (ViewPoint_Row),A
PrintWordFromBuffer_0:
  LD A,(ViewPoint_Col)    ; Next Column.
  INC A
  LD (Print_Col),A        ; Set column to print at!
  LD A,(ViewPoint_Row)
  LD (Print_Row),A        ; Row That we are on.
  CP $18                  ; Deep shit if we get this far!
  RET Z
  LD HL,WorkSpaceArea     ; Start of buffer to print.
PrintWordFromBuffer_1:
  LD A,(HL)               ; Get Byte to print.
  CALL DecideCase         ; Decide wether the letter needs uppercasing
  LD (Print_Char),A       ; Set byte to print.
  INC HL                  ; Next byte!
  PUSH HL
  CALL PrintAsciiChar     ; Print the character.
  LD A,(Print_Col)
  INC A                   ; One column on.
  LD (Print_Col),A
  POP HL
  LD A,(TextLength)       ; How many Charcters?
  DEC A                   ; One less!
  LD (TextLength),A       ; Store away.
  CP $00                  ; Have we printed them all?
  JR NZ,PrintWordFromBuffer_1 ; Loop until we have
  LD A,(Print_Col)
  LD (ViewPoint_Col),A    ; Update the variables.
  RET

; Print the message to the buffer.
;
; Messages in the game are stored in a tokenised format. As each byte is read
; and is checked to see if it's a special code, otherwise the word is looked up
; in the token dictionary; this word is used in all lowercase. The next token
; is read to check if it's either a CONNECT or LITERAL, if it is then this new
; text is added to the current word and the next token is checked again,
; otherwise the word is printed with a space at the end.
PrintOutBuffer:
  LD HL,(PrintBufferStart)
PrintOutBuffer_0:
  LD DE,WorkSpaceArea     ; Print Output Destination address
  LD (TextBuffer),DE
  XOR A                   ; Reset these variables.
  LD (MakeFirstCharUpper),A
  LD (TextLength),A
PrintOutBuffer_1:
  LD A,(HL)               ; Get the bytes.
PrintOutBuffer_2:
  CP $FF                  ; Was it a TERMINATOR?
  RET Z                   ; Finished if it was.
  CP $FE                  ; Are we expecting a LITERAL?
  JR Z,DealWithLiteral
  CP $FC                  ; UPPERCASE Token?
  JR Z,UppercaseToken
  CP $FB                  ; NEWLINE
  JR Z,StartOfNextLine
PrintOutBuffer_3:
  LD (Print_Temp),A       ; Token to decode.
  PUSH HL
  CALL DecodeToken
  POP HL
PrintOutBuffer_4:
  INC HL
  LD A,(HL)
  CP $FE                  ; LITERAL?
  JR Z,DealWithLiteral
  CP $FD                  ; CONNECT token to last word
  JR Z,ConnectTokenToLast
  PUSH HL                 ; Time to print the last words
  CALL PrintWordFromBuffer ; Made up in buffer.
  POP HL
  JR PrintOutBuffer_0     ; Loop all over again.
UppercaseToken:
  LD (MakeFirstCharUpper),A
  INC HL
  LD A,(HL)
  JR PrintOutBuffer_2
StartOfNextLine:
  LD A,(ViewPoint_StartCol)
  LD (ViewPoint_Col),A
  LD A,(ViewPoint_Row)
  INC A
  LD (ViewPoint_Row),A
  INC HL
  JR PrintOutBuffer_1
DealWithLiteral:
  INC HL
  LD A,(HL)
  LD DE,(TextBuffer)
  LD (DE),A
  INC DE
  LD (TextBuffer),DE
  LD A,(TextLength)
  INC A
  LD (TextLength),A
  JR PrintOutBuffer_4
ConnectTokenToLast:
  INC HL
  LD A,(HL)
  JR PrintOutBuffer_3

DecideCase:
  LD B,A
  LD A,(UpperCaseFlag)    ; If uppercase flag is set
  CP $00                  ; then we'll have to make
  JR NZ,LowerToUpper      ; All characters uppercase!
  LD A,(MakeFirstCharUpper) ; Other wise check wether only
  CP $00                  ; the first char needs making
  JR NZ,LowerToUpperFirstChar ; uppercase
  LD A,B
  RET
LowerToUpperFirstChar:
  XOR A
  LD (MakeFirstCharUpper),A
LowerToUpper:
  LD A,B
  CP $61
  RET M
  CP $7B
  RET P
  AND $DF
  RET

FillPrintBuffer:
  PUSH DE                 ; DE=Start of Print Buffer
  LD DE,(PrintBufferPos)
FillPrintBuffer_0:
  LD A,(HL)               ; Get the byte
  LD (DE),A               ; Store byte away.
  CP $FF                  ; Was it the last one/TERMINATOR?
  JR Z,FillPrintBuffer_1  ; Exit out!
  INC HL                  ; Increase Source
  INC DE                  ; Increase destination
  JR FillPrintBuffer_0    ; Loop.
FillPrintBuffer_1:
  LD (PrintBufferPos),DE
  POP DE
  RET

FlushPrintBuffer:
  CALL TerminatorToBuffer
  LD HL,PrintBuffer
  LD (PrintBufferPos),HL
  LD (PrintBufferStart),HL
  JP PrintOutBuffer

SetTokenToUpperCase:
  LD A,$FC                ; UPPERCASE token

A_IntoPrintBuffer:
  PUSH HL
  LD HL,(PrintBufferPos)
  LD (HL),A
  INC HL
  LD (PrintBufferPos),HL
  POP HL
  RET

SetTokenToLowerCase:
  LD A,$FB
  JR A_IntoPrintBuffer

AddTokenWithConnect:
  PUSH BC
  LD B,A
  LD A,$FD                ; CONNECT
  CALL A_IntoPrintBuffer
  LD A,B
  CALL A_IntoPrintBuffer
  POP BC
  RET

AddLiteralToBuffer:
  PUSH BC
  LD B,A
  LD A,$FE                ; LITERAL
  CALL A_IntoPrintBuffer
  LD A,B
  CALL A_IntoPrintBuffer
  POP BC
  RET

TerminatorToBuffer:
  LD A,$FF                ; TERMINATOR
  JR A_IntoPrintBuffer

SToBuffer:
  LD A,$73
  JR AddLiteralToBuffer

StopToBuffer:
  LD A,$2E
  JR AddLiteralToBuffer

CommaToBuffer:
  LD A,$2C
  JR AddLiteralToBuffer

PercentToBuffer:
  LD A,$25
  JR AddLiteralToBuffer

AndSignTobuffer:
  LD A,$26
  JR AddLiteralToBuffer

PlinkToBuffer:
  LD A,$21
  JR AddLiteralToBuffer

HashToBuffer:
  LD A,$23
  JR AddLiteralToBuffer

SpaceToBuffer:
  LD A,$20
  JR AddLiteralToBuffer

PluralToken:
  CALL A_IntoPrintBuffer
  LD A,(QuantityFlag)
  CP $00
  RET Z
  JR SToBuffer

TestFeatureForPlural:
  LD A,(LocationFeature)
  CP $00
  JR Z,LocationPlural
  CP $06
  JR Z,LocationPlural
  CP $0A
  JR Z,LocationPlural
  CP $0E
  JR NZ,TestFeatureForPlural_0
  INC A
TestFeatureForPlural_0:
  CP $0F
  JR Z,LocationPlural
  LD A,$00
  LD (QuantityFlag),A     ; Location Singular
  LD A,(LocationFeature)
  RET
LocationPlural:
  LD A,$FF                ; TERMINATOR
  LD (QuantityFlag),A
  LD A,(LocationFeature)
  RET

DescribeLocation:
  LD A,(LocDomainFlag)
  CP $00                  ; Is it any where special?
  JR NZ,DescribeFeature   ; If so describe the feature
  CALL TestFeatureForPlural
  CP $03
  JR Z,ItsAHenge
  CP $09
  JR Z,ItsALake
  CP $0A
  JR Z,ItsFrozenWaste
  CP $0E                  ; If it's an army
  JR NZ,DescribeLocation_0
  INC A                   ; Then pretend its a Plain!
  LD (QuantityFlag),A
DescribeLocation_0:
  ADD A,$41               ; Feature Token
  LD B,A
  XOR A                   ; 'The'
  CALL A_IntoPrintBuffer
  CALL SetTokenToUpperCase
  LD A,B                  ; what
  CALL PluralToken
  LD A,$40                ; 'Of'
  CALL A_IntoPrintBuffer

DescribeLocationArea:
  LD A,(LocationArea)
  CP $07                  ; Lost
  JR Z,ItNeedsThe
  CP $20                  ; Moon
  JR Z,ItNeedsThe
  CP $39                  ; Targ
  JR Z,ItNeedsThe

PrintPlaceDescription:
  CALL SetTokenToUpperCase
PrintPlaceDescription_0:
  LD A,(LocationArea)
  JP A_IntoPrintBuffer
ItNeedsThe:
  XOR A
  CALL A_IntoPrintBuffer
  JR PrintPlaceDescription
ItsAHenge:
  CALL PrintPlaceDescription
  LD A,$44
  JP AddTokenWithConnect
ItsALake:
  CALL Bytes_Print_Buffer
  DEFB $FC,$4A,$FC,$FF    ; 'Lake'
  JR PrintPlaceDescription_0
ItsFrozenWaste:
  CALL Bytes_Print_Buffer
  DEFB $00,$FC,$51,$FC,$4B,$FF ; 'The Frozen Waste'
  JP SToBuffer
DescribeFeature:
  CALL TestFeatureForPlural
  LD A,(QuantityFlag)
  CP $00                  ; Single or plural
  JR NZ,PrintPlaceDescription_1 ; Plural!
  LD A,$53                ; 'A'
  CALL A_IntoPrintBuffer
PrintPlaceDescription_1:
  LD A,(LocationFeature)
  CP $0E                  ; Is there an army?
  JR NZ,PrintPlaceDescription_2 ; No.
  INC A                   ; Pretend its plains
PrintPlaceDescription_2:
  ADD A,$41               ; Description Token
  CALL PluralToken
  CALL Bytes_Print_Buffer
  DEFB $54,$00,$FC,$52,$40,$FF ; 'In The Domain of'
  JP DescribeLocationArea

DescribeWhereHeIs:
  CALL Bytes_Print_Buffer
  DEFB $FC,$55,$56,$FE,$73,$FF ; 'He Stands'
  LD HL,(CurrentLocationY)
  LD (WorkingLocation),HL
  CALL CalcMapLocation
  LD A,(LocationArea)     ; Where Abouts are we?
  LD B,A
  LD A,(LocDomainFlag)
  LD C,A
  LD A,(LocationFeature)  ; What is here?
  LD D,A
  PUSH BC
  PUSH DE
  LD B,$00                ; Work out the correct
  LD C,A                  ; terminology for the
  LD HL,WhereTable        ; place we are
  ADD HL,BC               ; AT/IN/ON/BESIDE
  LD A,(HL)
  CALL A_IntoPrintBuffer
  CALL DescribeLocation
  CALL CommaToBuffer
  LD A,$5B                ; 'Looking'
  CALL A_IntoPrintBuffer
  CALL LookingWhere
  LD HL,(LocationLookingAt)
  LD (WorkingLocation),HL
  CALL CalcMapLocation
  POP DE
  POP BC
  LD A,(LocationArea)     ; Different Area?
  CP B
  JR NZ,LookingSomeWhereElse
  LD A,(LocDomainFlag)    ; Different Domain
  CP C
  JR NZ,LookingSomeWhereElse
  LD A,(LocationFeature)  ; Same Feature
  CP D
  JR Z,DescribeWhereHeIs_0
LookingSomeWhereElse:
  LD A,$5C                ; 'To'
  CALL A_IntoPrintBuffer
  CALL DescribeLocation
DescribeWhereHeIs_0:
  JP StopToBuffer

WhereTable:
  DEFB $54,$5D,$54,$5D,$5D,$54,$5E,$5D
  DEFB $5D,$5F,$54,$54,$5D,$5D,$54,$5E

LookingWhere:
  LD A,(CurrentlyLooking)
  LD HL,DirectionTable
  LD B,$00
  ADD A,A
  LD C,A
  ADD HL,BC
  LD A,(HL)
  LD D,A
  INC HL
  LD A,(HL)
  LD E,A
  CALL SetTokenToUpperCase
  LD A,D
  CALL A_IntoPrintBuffer
  LD A,E
  CP $00
  RET Z
  JP AddTokenWithConnect

DirectionTable:
  DEFB $57,$00,$57,$59,$59,$00,$58,$59
  DEFB $58,$00,$58,$5A,$5A,$00,$57,$5A

PrintTimeStatus:
  LD A,(TempVar)
  CP $01
  JR C,KnightTyme
  LD B,$00
  SRL A
  RL B
  CP $08
  JR Z,DawnTyme
  LD C,A
  LD A,B
  CP $00
  JR Z,ActualHoursRemaining
  INC C
  CALL Bytes_Print_Buffer
  DEFB $60,$61,$FF        ; 'Less Than'
ActualHoursRemaining:
  LD A,C
  DEC A
  LD (QuantityFlag),A     ; Token for Number of hours
  LD A,$62
  ADD A,C
  CALL A_IntoPrintBuffer
  LD A,$62                ; 'Hour'
  CALL PluralToken
  CALL Bytes_Print_Buffer
  DEFB $40,$00,$6E,$FF    ; 'Of The Day'
  LD A,(QuantityFlag)
  CP $00
  JR NZ,AFewHourRemain
  INC A                   ; One
  JR HoursRemaining
AFewHourRemain:
  XOR A
HoursRemaining:
  LD (QuantityFlag),A
  LD A,$6D                ; 'Remain'
  JP PluralToken
KnightTyme:
  CALL Bytes_Print_Buffer
  DEFB $6F,$70,$71,$FF    ; 'It Is Night'
  RET
DawnTyme:
  CALL Bytes_Print_Buffer
  DEFB $6F,$70,$3D,$FF    ; 'It is Dawn'
  RET

FindLookingTowards:
  LD HL,(CurrentLocationY)
  LD (WorkingLocation),HL
  LD A,(CurrentlyLooking)
  LD C,A
  LD B,$00
  LD HL,DirectionLookTable
  SLA C
  ADD HL,BC
  LD A,(HL)
  LD (MapYLookAdjust),A
  INC HL
  LD A,(HL)
  LD (MapXLookAdjust),A
  XOR A
  LD (LookForwardCount),A
FindLookingTowards_0:
  LD A,(MapYLookAdjust)
  LD B,A                  ; Looking North/South
  LD A,(WorkingLocation)  ; towards which Location?
  ADD A,B                 ; Recalc
  LD (WorkingLocation),A  ; Well This one of course!
  LD A,(MapXLookAdjust)
  LD B,A
  LD A,(WorkingLocation+$0001)
  ADD A,B
  LD (WorkingLocation+$0001),A
  LD A,(LookForwardCount)
  CP $00
  JR NZ,FindLookingTowards_1
  LD HL,(WorkingLocation)
  LD (DesirableLocation),HL
FindLookingTowards_1:
  CALL CalcMapLocation
  LD A,(LocationFeature)  ; What are we looking at?
  CP $0F
  JR NZ,FindLookingTowards_2 ; No - We found Something
  LD A,(LookForwardCount) ; Yes
  INC A                   ; We can therefore look forward
  LD (LookForwardCount),A ; until we find something or
  CP $03                  ; three locations infront!
  JR NZ,FindLookingTowards_0
FindLookingTowards_2:
  LD HL,(WorkingLocation)
  LD (LocationLookingAt),HL
  RET

DirectionLookTable:
  DEFB $00,$FF,$01,$FF,$01,$00,$01,$01
  DEFB $00,$01,$FF,$01,$FF,$00,$FF,$FF

PrintShieldBit:
  LD A,(Print_Temp)
  ADD A,A
  ADD A,A                 ; A*4
  LD C,A
  LD B,$00
  LD HL,ShieldPartsTable
  ADD HL,BC               ; From Table at LDE8C
  LD E,(HL)
  INC HL                  ; DE=Address of Data
  LD D,(HL)
  INC HL
  LD A,(HL)
  LD (Window_Width),A
  LD B,A
  INC HL
  LD A,(HL)               ; Depth of data
  LD (Window_Depth),A     ; Width of data
  LD C,A
  LD A,(Shield_Ink)       ; Ink
  LD H,A
  LD A,(Shield_Paper)     ; Paper
  OR $40
  ADD A,H
  LD (Print_Attr),A
  LD HL,(Column)          ; L=Row
  INC H                   ; H=Column
  LD A,L
  ADD A,$19
  LD L,A
  LD (Column),HL
  LD (Print_Col),HL
PrintShieldBit_0:
  LD A,(DE)
  CP $00                  ; Is it printable?
  JR Z,PrintShieldBit_1   ; No. skip the print.
  LD (Print_Char),A       ; Yes. Char to print
  PUSH BC
  PUSH DE
  CALL PrintAsciiChar     ; Print it
  POP DE
  POP BC
PrintShieldBit_1:
  LD A,(Print_Col)
  INC A                   ; Next column position
  LD (Print_Col),A
  INC DE
  DJNZ PrintShieldBit_0   ; Loop until finished row!
  LD A,(Column)           ; Reset the print Column
  LD (Print_Col),A
  LD A,(Window_Width)     ; Reset the print width
  LD B,A
  LD A,(Print_Row)        ; One row down.
  INC A
  LD (Print_Row),A
  DEC C                   ; One less of the depth
  LD A,C
  CP $00                  ; Have we finished?
  JR NZ,PrintShieldBit_0  ; Loop until we have.
  RET

PrintShield:
  LD HL,(CHARS)
  PUSH HL
  LD HL,ShieldInc
  LD (CHARS),HL
  LD A,(ShieldNumber)
  ADD A,A
  ADD A,A
  ADD A,A                 ; A*8
  LD C,A
  LD B,$00
  LD HL,ShieldConstructTable ; Entry in ShieldConstructTable
  ADD HL,BC
  LD A,(HL)               ; Get the first byte.
  ADD A,A                 ; This is the shields paper.
  ADD A,A
  ADD A,A                 ; A*8
  LD (Shield_Paper),A
  LD A,$FF
  LD (Print_Mask),A
  XOR A                   ; Part of shield to print!
  LD (Print_Temp),A       ; Is going to be the main shield
  LD (Column),A           ; first at :- Column=0
  LD (Row),A              ; Row=0
  INC A
  LD (Shield_Ink),A       ; Ink of Blue
PrintShield_0:
  PUSH HL
  CALL PrintShieldBit
  POP HL
  INC HL
  LD A,(HL)               ; Get the next bit!
  CP $00                  ; Have we finished?
  JR Z,PrintShield_1      ; Exit if we have.
  LD B,A                  ; Preserve value
  AND $07                 ; First three bits.
  LD (Print_Temp),A       ; Are the bit type 0 to 7
  LD A,B                  ; Restore Value
  SRL A
  SRL A
  SRL A                   ; Next three bits are
  LD (Shield_Ink),A       ; the parts ink. 0 to 31!
  INC HL
  LD A,(HL)               ; Next byte
  LD B,A                  ; Preserve value
  AND $07                 ; First three bits are
  LD (Column),A           ; the column. 0 to 7
  LD A,B                  ; Restore Value
  SRL A
  SRL A
  SRL A                   ; Next threee bits are
  LD (Row),A              ; the row. 0 to 31!
  JR PrintShield_0        ; Loop.
PrintShield_1:
  POP HL
  LD (CHARS),HL
  RET

ClearWindow:
  PUSH HL
  LD HL,Font              ; C=Row, B=Col
  LD (CHARS),HL           ; D=Width
  POP HL                  ; H=Column
  LD A,$20
  LD (Print_Char),A
  LD A,C
  LD (Print_Row),A
  LD L,A
ClearWindow_0:
  LD A,B
  LD (Print_Col),A
  LD E,A
  PUSH BC
  PUSH HL
ClearWindow_1:
  PUSH DE
  CALL PrintAsciiChar
  POP DE
  INC E
  LD A,E
  LD (Print_Col),A
  CP D
  JR NZ,ClearWindow_1
  LD (Print_Col),A
  POP HL
  POP BC
  INC L
  LD A,L
  LD (Print_Row),A
  CP H
  JR NZ,ClearWindow_0
  RET

DoWindowOne:
  LD BC,$0000
  LD D,$20
  LD H,$18
  XOR A
  LD (Print_Mask),A
  LD A,$38
  LD (Print_Attr),A
  LD A,$07
  OUT ($FE),A
  JP ClearWindow

DoWindowTwo:
  LD BC,$0000
  LD D,$20
  LD H,$08
  LD A,$04
  OUT ($FE),A
  LD A,$FF
  LD (Print_Mask),A
  LD A,$79
  LD (Print_Attr),A
  CALL ClearWindow
  JR DoWindowFour

DoWindowThree:
  LD BC,$0002
  LD D,$18
  LD H,$08
  LD A,$FF
  LD (Print_Mask),A
  LD A,$79
  LD (Print_Attr),A
  JP ClearWindow

DoWindowFour:
  LD BC,$0008
  LD D,$20
  LD H,$0E
  LD A,$FF
  LD (Print_Mask),A
  LD A,$49
  LD (Print_Attr),A
  CALL ClearWindow
  LD A,(LowerWindowAttr)
  LD (Print_Attr),A
  XOR A
  LD (Print_Mask),A
  LD BC,$000E
  LD H,$18
  JP ClearWindow

ClearAttributesNight:
  LD HL,$5900
  LD DE,WorkSpaceArea
ClearAttributesNight_0:
  LD A,$79
  LD (HL),A
  INC HL
  LD A,H
  CP D
  JR NZ,ClearAttributesNight_0
  LD A,L
  CP E
  JR NZ,ClearAttributesNight_0
  RET

ClearAttributesDay:
  LD HL,$5900
  LD DE,WorkSpaceArea
ClearAttributesDay_0:
  LD A,$41
  LD (HL),A
  INC HL
  LD A,H
  CP D
  JR NZ,ClearAttributesDay_0
  LD A,L
  CP E
  JR NZ,ClearAttributesDay_0
  RET

FullCharTitle:
  LD A,(CharTitle)
  CP $00
  JR Z,IsMoonprince
  CP $01
  JR Z,IsNobody
  CP $02
  JR Z,IsFey
  CP $03
  JR Z,IsWise
  CP $04
  JR Z,IsDragon
  CP $05
  JR Z,IsSkulkrin
  CP $0A
  JR C,TheLordOf
  JR Z,The_Name_Of
  CALL Bytes_Print_Buffer
  DEFB $FC,$79,$FF        ; 'Lord'
  JR FirstNameToBuffer
IsMoonprince:
  LD A,$7E
  JR FirstName_The_What
IsNobody:
  JP FirstNameToBuffer
IsFey:
  LD A,$7A
  JR FirstName_The_What
IsWise:
  LD A,$7B
  JR FirstName_The_What
IsDragon:
  LD A,$7D
  CALL FirstName_The_What
  LD A,$79                ; -Lord
  JP AddTokenWithConnect
IsSkulkrin:
  LD A,$7C
  JR FirstName_The_What
TheLordOf:
  CALL Bytes_Print_Buffer
  DEFB $00,$FC,$79,$40,$FF ; 'The Lord Of'
  JR FirstNameToBuffer
The_Name_Of:
  CALL TheToBuffer
  CALL FirstNameToBuffer
  LD A,$40                ; 'Of'
  CALL A_IntoPrintBuffer

FirstNameToBuffer:
  CALL SetTokenToUpperCase
  LD A,(CharFirstName)
  JP A_IntoPrintBuffer

TheToBuffer:
  XOR A
  JP A_IntoPrintBuffer

FirstName_The_What:
  PUSH AF
  CALL FirstNameToBuffer
  CALL TheToBuffer
  CALL SetTokenToUpperCase
  POP AF
  JP A_IntoPrintBuffer

CalcCharTablePos:
  LD A,(TempCharacterNo)
  LD L,A
  LD H,$00
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL               ; Mult by 32
  ADD HL,HL
  ADD HL,HL
  LD BC,CharactersTable
  ADD HL,BC               ; Add Offset
  LD DE,CharLocation
  RET

SaveCharDetails:
  CALL CalcCharTablePos
  JP DoReverseSwap

CopyCharDetails:
  CALL CalcCharTablePos
CopyCharDetails_0:
  LD BC,$0020
  LDIR
  RET

; Display what we're looking at
DrawMainScreen:
  LD B,$7F
  LD A,(CharTimeOfDay)    ; Depending what time of day
  CP $00                  ; it is decides the top screens
  JR NZ,DrawMainScreen_0  ; attributes.
  LD B,$40
DrawMainScreen_0:
  LD A,B
  LD (LowerWindowAttr),A
  CALL DoWindowTwo        ; Clear the Top Screen
  LD A,(TempCharacterNo)
  LD (ShieldNumber),A
  CALL PrintShield        ; Draw the Characters Shield
  CALL DefineViewPoint
  DEFB $00,$01,$01,$17,$71,$FF
  LD A,$01
  LD (UpperCaseFlag),A
  CALL FullCharTitle      ; Display the Characters name
  CALL FlushPrintBuffer
  CALL DefineViewPoint
  DEFB $01,$02,$01,$17,$69,$FF
  CALL DescribeWhereHeIs  ; Display the Characters name
  CALL FlushPrintBuffer
  CALL DrawGraphicVision  ; Draw the LANDSCAPE
  LD A,(CharTimeOfDay)
  CP $00                  ; How exatcly is the landscape
  JP Z,ClearAttributesDay ; going to be coloured in?
  JP ClearAttributesNight

DrawMainFeature:
  CALL DoWindowOne
  LD A,(LocationFeature)
  LD (Feature_Draw),A
  XOR A
  LD (Feature_Size),A
  LD HL,$0180             ; = 'l'
  LD (Image_XPixel),HL
  LD A,$60
  LD (Image_YPixel),A
  CALL DrawFeature
  CALL DefineViewPoint
  DEFB $FF,$00,$00,$1F,$3A,$00
  LD (Print_Ink),A
  CALL SetTokenToUpperCase
  CALL FullCharTitle
  CALL FlushPrintBuffer
  LD HL,$090A
  LD (Column),HL
  LD A,$3F
  LD (Window_Attr),A
  LD A,(CharGraphicType)
  LD (CharacterToPrint),A
  CALL DisplayCharacter
  CALL DefineViewPoint
  DEFB $00,$0B,$00,$1F,$3A,$00
  RET

GetFromCharHereTable:
  LD A,(CharInHereTable)
  LD E,A                  ; Character we want
  LD D,$00
  LD HL,CharHereTable     ; Start of table
  ADD HL,DE               ; Position in table.
  LD A,(HL)               ; Get the char No.
  LD (TempCharacterNo),A
  JP CopyCharDetails      ; Get the Character and return.

Initialise:
  LD HL,PrintBuffer
  LD (PrintBufferPos),HL
  LD HL,TokenDictionary
  LD (StartOfTokenTable),HL
Initialise1:
  RET

; Message at FD22
CharKeysTable:
  DEFM "cvbn1234567890qwertyuiopasdfghjk"

SelectCharacter:
  CALL CheckKeyCase
  LD C,A                  ; What Key?
  LD D,$00
  LD HL,CharKeysTable     ; Reference Table
  LD B,$20
SelectCharacter_0:
  LD A,(HL)               ; Check Entry
  CP C                    ; Is it what we pressed?
  JR Z,FoundCharKey       ; Yes
  INC HL
  INC D
  DJNZ SelectCharacter_0
  JR SelectCharacter
FoundCharKey:
  LD A,D
  LD (TempCharacterNo),A
  CALL CopyCharDetails
  LD A,(CharAvailable)
  CP $01
  JR NZ,SelectCharacter
  XOR A
  LD (LASTK),A
  RET

CheckKeyCase:
  LD A,(LASTK)
  CP $41
  RET M
  CP $5B
  RET P
  OR $20
  RET

DisplayPressAKey:
  CALL DoWindowOne
  CALL DefineViewPoint
  DEFB $01,$00,$00,$1F,$3A,$00
  CALL Bytes_Print_Buffer
  DEFB $FC,$7F,$53,$81,$5C,$80,$FE,$2E ; 'Press A Key To Choose....'
  DEFB $FE,$2E,$FE,$2E,$FE,$2E,$FB,$FB
  DEFB $FF
  JP FlushPrintBuffer

RandomishNumber:
  LD HL,(LastRandomNumber)
  LD DE,(L5C78)
  ADD HL,DE
  LD A,R
  ADD A,(HL)
  LD (LastRandomNumber),HL
  RET

InitialiseChoices:
  LD HL,ChooseKeyTable
  LD B,$07                ; Clear out the
InitialiseChoices_0:
  LD (HL),A               ; table of keys
  INC HL
  DJNZ InitialiseChoices_0
  LD A,(CharHideFlag)     ; CanWeSeek
  CP $00                  ; Are We Hidden?
  JR NZ,CanWeHide         ; We Can't Seek Then!
  LD A,$31                ; '1'
  CALL AddToBufferAndKeyTable
  CALL Bytes_Print_Buffer
  DEFB $F0,$FF            ; 'Seek'
CanWeHide:
  LD A,(CharNoWarriors)
  CP $00
  JR NZ,AnyBodyElseHere   ; We can't Hide if we
  LD A,(CharNoRiders)     ; have any Warriors or
  CP $00                  ; Riders!
  JR NZ,AnyBodyElseHere
  LD A,(SaveCurChar)      ; Morkin can't hide either
  CP $01
  JR Z,CanWeFight
  LD A,$32                ; '2'
  CALL AddToBufferAndKeyTable
  LD A,(CharHideFlag)     ; If we are already
  CP $00                  ; hidden then we must
  JR NZ,DoNotHide         ; not hide!
  CALL Bytes_Print_Buffer
  DEFB $EE,$FF            ; 'Hide'
AnyBodyElseHere:
  LD A,(DoomDarksArmyPosInTable)
  CP $00
  RET NZ
  JR CanWeFight           ; No.
DoNotHide:
  CALL Bytes_Print_Buffer
  DEFB $8C,$BC,$FE,$74,$EE,$FF ; 'Do Not Hide'
  RET
CanWeFight:
  LD A,(LocationObject)
  CP $00                  ; Nothing here at all
  JR Z,CanWeRecruit
  CP $05                  ; Anything we can fight?
  JR NC,CanWeRecruit
  LD (ObjectToDescribe),A ; Store Whats Nasty
  LD A,$33                ; '3'
  CALL AddToBufferAndKeyTable
  CALL Bytes_Print_Buffer
  DEFB $F7,$00,$FF        ; 'Fight The'
  CALL DescribeAnObject
CanWeRecruit:
  CALL AnyCharsToRecruit
  LD A,(CharInLocation)   ; Who's in this location?
  CP $00                  ; Any one?
  JR Z,AreWeAtA_Citadel_Keep
  LD (TempCharacterNo),A
  CALL CopyCharDetails
  LD A,$34                ; '4'
  CALL AddToBufferAndKeyTable
  CALL Bytes_Print_Buffer
  DEFB $F6,$FF            ; 'Recruit'
  CALL FullCharTitle
  CALL UpdateCharsVars
AreWeAtA_Citadel_Keep:
  LD A,(LocationFeature)
  CP $01
  JR Z,InitialiseChoices_1
  CP $07
  JR NZ,CanWeBattle
InitialiseChoices_1:
  LD A,(WhoseRaceIsArmy)  ; Check the race of the army against that of the
  LD B,A                  ; character to see if they're friend or foe.
  LD A,(CharRace)         ;
  CP B                    ;
  JR NZ,CanWeBattle       ;
  LD A,(HowManyGuardsThePlace)
  CP $19                  ; Might want to put some men
  JR C,CanWeStandMenOnGuard ; on guard.
  LD A,(WhoGuardsThePlace)
  CP $00                  ; Riders or Warriors?
  JR NZ,InitialiseChoices_2
  LD A,(CharNoWarriors)
  JR CanWeRecruitMen
InitialiseChoices_2:
  LD A,(CharNoRiders)
CanWeRecruitMen:
  CP $EB
  JR NC,CanWeStandMenOnGuard ; Got To Many!
  LD A,$35                ; '5'
  CALL AddToBufferAndKeyTable
  CALL Bytes_Print_Buffer
  DEFB $F6,$CD,$FF        ; 'Recruit Men'
CanWeStandMenOnGuard:
  LD A,(WhoGuardsThePlace)
  CP $00
  JR NZ,RidersGuard
  LD A,(CharNoWarriors)   ; WarriorsGuard
  CP $14                  ; Have we enough Warriors
  JR C,CanWeBattle
OnGuard:
  LD A,$36                ; '6'
  CALL AddToBufferAndKeyTable
  CALL Bytes_Print_Buffer
  DEFB $56,$CD,$5E,$9E,$FF ; 'Stand Men On Guard'
  JR CanWeBattle
RidersGuard:
  LD A,(CharNoRiders)
  CP $14                  ; Have we enough Riders
  JR NC,OnGuard
CanWeBattle:
  LD A,(CharCourageStatus)
  CP $00                  ; Are we a coward?
  RET Z
  LD A,(DoomDarksArmyPosInTable) ; Anything of Doomdarks army to Battle?
  CP $00
  RET NZ                  ; Return if not!
  CALL FlushPrintBuffer
  CALL CheckLocationInfront
  LD A,(DoomDarksArmyPosInTable) ; Anything of Doomdarks army to Battle?
  CP $00
  RET Z                   ; Return if not!
  LD A,(FreeArmyPosInTable)
  CP $1D
  RET NC
  LD A,$37                ; '7'
  CALL AddToBufferAndKeyTable
  CALL Bytes_Print_Buffer
  DEFB $5C,$C3,$FE,$21,$FF ; 'To Battle!'
  RET

AnyCharsToRecruit:
  XOR A
  LD (CharInLocation),A   ; Nobody in location-Ish
  LD A,(CharRecruitingKey) ; Store this of the
  LD (TempCharRecruitingKey),A ; Character at location.
  LD A,(NoInCharHereTable) ; How Many People Are here?
  CP $02                  ; Less than 2 is no good.
  RET C                   ; Which by the way is Zero & one.
  XOR A                   ; Start at begining
AnyCharsToRecruit_0:
  LD (CharInHereTable),A  ; Where we up to?
  CALL GetFromCharHereTable ; Get his details
  LD A,(CharAvailable)    ; Has the character already
  CP $01                  ; been recruited?
  JR Z,AnyCharsToRecruit_1 ; Forget him if he has?
  LD A,(CharRecruitedBy)  ; Can this character
  LD B,A                  ; be recuited by the character
  LD A,(TempCharRecruitingKey) ; at the current location?
  AND B
  CP $00
  JR Z,AnyCharsToRecruit_1 ; No he can't be
  LD A,(TempCharacterNo)
  LD (CharInLocation),A   ; If he can. He's Ready.
AnyCharsToRecruit_1:
  LD A,(NoInCharHereTable)
  LD B,A                  ; Store how many are here.
  LD A,(CharInHereTable)  ; Increment our count!
  INC A
  CP B                    ; Are we at the end?
  JR NZ,AnyCharsToRecruit_0 ; Loop until we are
  JP UpdateCharsVars

LFEFE:
  DEFB $EF,$00

Image_XPixel:
  DEFW $0000

Image_YPixel:
  DEFB $00

LFF03:
  DEFB $00

LFF04:
  DEFB $00

LFF05:
  DEFB $00

LFF06:
  DEFB $00

LFF07:
  DEFB $00

LFF08:
  DEFB $00

Image_PlotOnOff:
  DEFB $00

Image_YOffset:
  DEFB $00

Image_Height:
  DEFB $00

Image_AnotherBit:
  DEFB $00

Image_DrawInstrucs:
  DEFB $00

FeatureAddress:
  DEFB $00,$00

Feature_Draw:
  DEFB $00

Feature_Size:
  DEFB $00

Print_Ink:
  DEFB $00

WorkingLocation:
  DEFB $00,$00

LocationFeature:
  DEFB $00

LocationObject:
  DEFB $00

LocationArea:
  DEFB $00

LocDomainFlag:
  DEFB $F3

LocSpecialFlag:
  DEFB $0D

Landscape_ScrAdjustDoWhat:
  DEFB $CE

Landscape_LeftScrDoWhat:
  DEFB $0B

Landscape_RightScrDoWhat:
  DEFB $E4

Landscape_XAdjustDoWhat:
  DEFB $50

Landscape_LeftXAdjustDoWhat:
  DEFB $CE

Landscape_RightXAdjustDoWhat:
  DEFB $0B

Landscape_YAdjustDoWhat:
  DEFB $E5

Landscape_LeftYAdjustDoWhat:
  DEFB $50

Landscape_RightYAdjustDoWhat:
  DEFB $1C

Landscape_YAdjust:
  DEFB $17

Landscape_XAdjust:
  DEFB $DC

Landscape_ScrAdjust:
  DEFB $0A,$CE

CurrentLocationY:
  DEFB $0B,$EB

CurrentlyLooking:
  DEFB $50

LandscapePosition:
  DEFB $16

Print_Col:
  DEFB $17

Print_Row:
  DEFB $DC

Print_Attr:
  DEFB $0A

Print_Char:
  DEFB $D7

Print_Mask:
  DEFB $18

CharacterToPrint:
  DEFB $B1

Window_Attr:
  DEFB $33

Window_Width:
  DEFB $DE

Window_Depth:
  DEFB $5C

Column:
  DEFB $05

Row:
  DEFB $00

Print_Temp:
  DEFB $DB

LFF37:
  DEFB $02

TextBuffer:
  DEFW $02DB

ViewPoint_Col:
  DEFB $4D

ViewPoint_Row:
  DEFB $00

ViewPoint_StartCol:
  DEFB $C8

ViewPoint_Width:
  DEFB $52

PrintBufferStart:
  DEFW $0038

TextLength:
  DEFB $C7

MakeFirstCharUpper:
  DEFB $52

UpperCaseFlag:
  DEFB $0C

PrintBufferPos:
  DEFW L5C02

QuantityFlag:
  DEFB $0E

TempVar:
  DEFB $C0

LFF47:
  DEFB $57

LFF48:
  DEFB $71

LFF49:
  DEFB $0E

LocationLookingAt:
  DEFW $0DF3

DesirableLocation:
  DEFW $1721

MapYLookAdjust:
  DEFB $C6

MapXLookAdjust:
  DEFB $1E

; Address to start of token table
StartOfTokenTable:
  DEFW $61A8              ; (default value overwritten during initialisation)

LookForwardCount:
  DEFB $76

Shield_Paper:
  DEFB $1B

Shield_Ink:
  DEFB $03

ShieldNumber:
  DEFB $13

LowerWindowAttr:
  DEFB $00

TempCharacterNo:
  DEFB $3E

NoOfUnits:
  DEFB $00

NoOfTens:
  DEFB $3C

NoOfHundreds:
  DEFB $42

NoOfThousands:
  DEFB $42

NoOfMillions:
  DEFB $7E

LastRandomNumber:
  DEFW $4242

LFF5F:
  DEFB $00

CharLocation:
  DEFB $00,$7C

CharLookDirection:
  DEFB $42

CharTimeOfDay:
  DEFB $7C

CharFirstName:
  DEFB $42

CharTitle:
  DEFB $42

CharAvailable:
  DEFB $7C

CharGraphicType:
  DEFB $00

CharNoRiders:
  DEFB $00

CharRidersEnergyStatus:
  DEFB $3C

CharNoWarriors:
  DEFB $42

CharWarriorsEnergyStatus:
  DEFB $40

CharBattleArea:
  DEFB $40

CharRidersLost:
  DEFB $42

CharWarriorsLost:
  DEFB $3C

CharSlew:
  DEFB $00

CharRidersSlew:
  DEFB $00

CharWarriorsSlew:
  DEFB $78

CharBattleStatus:
  DEFB $44

CharLifeStatus:
  DEFB $42

CharEnergyStatus:
  DEFB $42

CharFightStrength:
  DEFB $44

CharCowardess:
  DEFB $78

CharRecruitingKey:
  DEFB $00

CharRecruitedBy:
  DEFB $00

CharCourageStatus:
  DEFB $7E

LFF7A:
  DEFB $40

CharHideFlag:
  DEFB $7C

CharRace:
  DEFB $40

CharHasAHorse:
  DEFB $40

CharObjectCarrying:
  DEFB $7E

CharDeathStatus:
  DEFB $00

; Lookup a token in the token dictionary
;
; Tokens are stored using 5-bit bytes compressed together; the format is
; [length][length*char]. All tokens have to be decoded until the required token
; is found.
GetRequiredByte:
  PUSH HL
  LD D,H                  ; HL=required byte
  LD E,L
  ADD HL,HL               ; Multiply by 5
  ADD HL,HL
  ADD HL,DE
  LD A,L
  AND $07                 ; This is the same as
  INC A                   ; doing A=(HL MOD 8)+1
  LD B,A
  SRL H                   ; HL=HL/8
  RR L                    ; HL=Actual byte position in
  SRL H                   ; the data with B= to no of
  RR L                    ; rotations to get the required
  SRL H                   ; five bits.
  RR L
  LD DE,(StartOfTokenTable)
  ADD HL,DE
  LD E,(HL)
  INC HL
  LD D,(HL)
  JR Rotate_B_Times
Rotate_Once:
  RR D                    ; Rotate one bit
  RR E
Rotate_B_Times:
  DJNZ Rotate_Once        ; Looop until finished
  LD A,E                  ; A=Byte required
  AND $1F                 ; Only need bottom five bits.
  POP HL
  RET

; Reads an ASCII character from the token dictionary
GetASCIIchar:
  PUSH DE
  CALL GetRequiredByte    ; Get the byte from the data
  POP DE
  OR $60                  ; add on 'a'-1
  LD (DE),A               ; Store in buffer
  INC HL                  ; Increase required byte
  INC DE                  ; Increase position in buffer
  LD B,C
  RET

DefineViewPoint:
  POP HL
  LD DE,ViewPoint_Col
  LD BC,$0004
  LDIR
  LD A,(HL)
  LD (Print_Attr),A
  INC HL
  LD A,(HL)
  LD (Print_Mask),A
  XOR A
  LD (UpperCaseFlag),A
  INC HL
  PUSH HL
  RET

; The Pasmo assembler uses this directive when generating a tape image to know
; where to start running the game from.
; end $5B04
