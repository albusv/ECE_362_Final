;XDEF dispMenu, dispEngine, dispFuel, dispSpeed, dispPitch
;XDEF dispAltitude, dispThrust, dispTimeMile, dispCombatStat
        XDEF dispPtrArray, initDispMsg

My_variable: section
dispMenu:   ds.b   $21
dispEngine:   ds.b   $21
dispFuel:   ds.b   $21
dispSpeed:   ds.b   $21
dispPitch:   ds.b   $21
dispAltitude:   ds.b   $21
dispThrust:   ds.b   $21
dispTimeMile:   ds.b   $21
dispCombatStat:   ds.b   $21
dispPtrArray:  ds.b   18

My_code: section

initDispMsg:   
            ;intializing string "dispMenu" to be:
            ;"Menu:",0
            movb #'M',dispMenu
            movb #'e',dispMenu+1
            movb #'n',dispMenu+2
            movb #'u',dispMenu+3
            movb #' ',dispMenu+4
            movb #' ',dispMenu+5
            movb #' ',dispMenu+6
            movb #' ',dispMenu+7
            movb #' ',dispMenu+8
            movb #' ',dispMenu+9
            movb #' ',dispMenu+10
            movb #' ',dispMenu+11
            movb #' ',dispMenu+12
            movb #' ',dispMenu+13
            movb #' ',dispMenu+14
            movb #' ',dispMenu+15
            movb #' ',dispMenu+16
            movb #' ',dispMenu+17
            movb #' ',dispMenu+18
            movb #' ',dispMenu+19
            movb #' ',dispMenu+20
            movb #' ',dispMenu+21
            movb #' ',dispMenu+22
            movb #' ',dispMenu+23
            movb #' ',dispMenu+24
            movb #' ',dispMenu+25
            movb #' ',dispMenu+26
            movb #' ',dispMenu+27
            movb #' ',dispMenu+28
            movb #' ',dispMenu+29
            movb #' ',dispMenu+30
            movb #' ',dispMenu+31
            movb #0,dispMenu+32    ;string terminator, acts like '\0'
            ;intializing string "dispEngine" to be:
            ;"Engine:         To Change: 1    ",0
            movb #'E',dispEngine
            movb #'n',dispEngine+1
            movb #'g',dispEngine+2
            movb #'i',dispEngine+3
            movb #'n',dispEngine+4
            movb #'e',dispEngine+5
            movb #':',dispEngine+6
            movb #' ',dispEngine+7
            movb #' ',dispEngine+8
            movb #' ',dispEngine+9
            movb #' ',dispEngine+10
            movb #' ',dispEngine+11
            movb #' ',dispEngine+12
            movb #' ',dispEngine+13
            movb #' ',dispEngine+14
            movb #' ',dispEngine+15
            movb #'T',dispEngine+16
            movb #'o',dispEngine+17
            movb #' ',dispEngine+18
            movb #'C',dispEngine+19
            movb #'h',dispEngine+20
            movb #'a',dispEngine+21
            movb #'n',dispEngine+22
            movb #'g',dispEngine+23
            movb #'e',dispEngine+24
            movb #':',dispEngine+25
            movb #' ',dispEngine+26
            movb #'1',dispEngine+27
            movb #' ',dispEngine+28
            movb #' ',dispEngine+29
            movb #' ',dispEngine+30
            movb #' ',dispEngine+31
            movb #0,dispEngine+32    ;string terminator, acts like '\0'
            ;intializing string "dispFuel" to be:
            ;"Fuel:           To Change: 2    ",0
            movb #'F',dispFuel
            movb #'u',dispFuel+1
            movb #'e',dispFuel+2
            movb #'l',dispFuel+3
            movb #':',dispFuel+4
            movb #' ',dispFuel+5
            movb #' ',dispFuel+6
            movb #' ',dispFuel+7
            movb #' ',dispFuel+8
            movb #' ',dispFuel+9
            movb #' ',dispFuel+10
            movb #' ',dispFuel+11
            movb #' ',dispFuel+12
            movb #' ',dispFuel+13
            movb #' ',dispFuel+14
            movb #' ',dispFuel+15
            movb #'T',dispFuel+16
            movb #'o',dispFuel+17
            movb #' ',dispFuel+18
            movb #'C',dispFuel+19
            movb #'h',dispFuel+20
            movb #'a',dispFuel+21
            movb #'n',dispFuel+22
            movb #'g',dispFuel+23
            movb #'e',dispFuel+24
            movb #':',dispFuel+25
            movb #' ',dispFuel+26
            movb #'2',dispFuel+27
            movb #' ',dispFuel+28
            movb #' ',dispFuel+29
            movb #' ',dispFuel+30
            movb #' ',dispFuel+31
            movb #0,dispFuel+32    ;string terminator, acts like '\0'
            ;intializing string "dispSpeed" to be:
            ;"Speed:          To Change: 3    ",0
            movb #'S',dispSpeed
            movb #'p',dispSpeed+1
            movb #'e',dispSpeed+2
            movb #'e',dispSpeed+3
            movb #'d',dispSpeed+4
            movb #':',dispSpeed+5
            movb #' ',dispSpeed+6
            movb #' ',dispSpeed+7
            movb #' ',dispSpeed+8
            movb #' ',dispSpeed+9
            movb #' ',dispSpeed+10
            movb #' ',dispSpeed+11
            movb #' ',dispSpeed+12
            movb #' ',dispSpeed+13
            movb #' ',dispSpeed+14
            movb #' ',dispSpeed+15
            movb #'T',dispSpeed+16
            movb #'o',dispSpeed+17
            movb #' ',dispSpeed+18
            movb #'C',dispSpeed+19
            movb #'h',dispSpeed+20
            movb #'a',dispSpeed+21
            movb #'n',dispSpeed+22
            movb #'g',dispSpeed+23
            movb #'e',dispSpeed+24
            movb #':',dispSpeed+25
            movb #' ',dispSpeed+26
            movb #'3',dispSpeed+27
            movb #' ',dispSpeed+28
            movb #' ',dispSpeed+29
            movb #' ',dispSpeed+30
            movb #' ',dispSpeed+31
            movb #0,dispSpeed+32    ;string terminator, acts like '\0'
            ;intializing string "dispPitch" to be:
            ;"Pitch:          To Change: 4    ",0
            movb #'P',dispPitch
            movb #'i',dispPitch+1
            movb #'t',dispPitch+2
            movb #'c',dispPitch+3
            movb #'h',dispPitch+4
            movb #':',dispPitch+5
            movb #' ',dispPitch+6
            movb #' ',dispPitch+7
            movb #' ',dispPitch+8
            movb #' ',dispPitch+9
            movb #' ',dispPitch+10
            movb #' ',dispPitch+11
            movb #' ',dispPitch+12
            movb #' ',dispPitch+13
            movb #' ',dispPitch+14
            movb #' ',dispPitch+15
            movb #'T',dispPitch+16
            movb #'o',dispPitch+17
            movb #' ',dispPitch+18
            movb #'C',dispPitch+19
            movb #'h',dispPitch+20
            movb #'a',dispPitch+21
            movb #'n',dispPitch+22
            movb #'g',dispPitch+23
            movb #'e',dispPitch+24
            movb #':',dispPitch+25
            movb #' ',dispPitch+26
            movb #'4',dispPitch+27
            movb #' ',dispPitch+28
            movb #' ',dispPitch+29
            movb #' ',dispPitch+30
            movb #' ',dispPitch+31
            movb #0,dispPitch+32    ;string terminator, acts like '\0'
            ;intializing string "dispAltitude" to be:
            ;"Altitude:       To Change: 5    ",0
            movb #'A',dispAltitude
            movb #'l',dispAltitude+1
            movb #'t',dispAltitude+2
            movb #'i',dispAltitude+3
            movb #'t',dispAltitude+4
            movb #'u',dispAltitude+5
            movb #'d',dispAltitude+6
            movb #'e',dispAltitude+7
            movb #':',dispAltitude+8
            movb #' ',dispAltitude+9
            movb #' ',dispAltitude+10
            movb #' ',dispAltitude+11
            movb #' ',dispAltitude+12
            movb #' ',dispAltitude+13
            movb #' ',dispAltitude+14
            movb #' ',dispAltitude+15
            movb #'T',dispAltitude+16
            movb #'o',dispAltitude+17
            movb #' ',dispAltitude+18
            movb #'C',dispAltitude+19
            movb #'h',dispAltitude+20
            movb #'a',dispAltitude+21
            movb #'n',dispAltitude+22
            movb #'g',dispAltitude+23
            movb #'e',dispAltitude+24
            movb #':',dispAltitude+25
            movb #' ',dispAltitude+26
            movb #'5',dispAltitude+27
            movb #' ',dispAltitude+28
            movb #' ',dispAltitude+29
            movb #' ',dispAltitude+30
            movb #' ',dispAltitude+31
            movb #0,dispAltitude+32    ;string terminator, acts like '\0'
            ;intializing string "dispThrust" to be:
            ;"Thrust:         To Change: 6    ",0
            movb #'T',dispThrust
            movb #'h',dispThrust+1
            movb #'r',dispThrust+2
            movb #'u',dispThrust+3
            movb #'s',dispThrust+4
            movb #'t',dispThrust+5
            movb #':',dispThrust+6
            movb #' ',dispThrust+7
            movb #' ',dispThrust+8
            movb #' ',dispThrust+9
            movb #' ',dispThrust+10
            movb #' ',dispThrust+11
            movb #' ',dispThrust+12
            movb #' ',dispThrust+13
            movb #' ',dispThrust+14
            movb #' ',dispThrust+15
            movb #'T',dispThrust+16
            movb #'o',dispThrust+17
            movb #' ',dispThrust+18
            movb #'C',dispThrust+19
            movb #'h',dispThrust+20
            movb #'a',dispThrust+21
            movb #'n',dispThrust+22
            movb #'g',dispThrust+23
            movb #'e',dispThrust+24
            movb #':',dispThrust+25
            movb #' ',dispThrust+26
            movb #'6',dispThrust+27
            movb #' ',dispThrust+28
            movb #' ',dispThrust+29
            movb #' ',dispThrust+30
            movb #' ',dispThrust+31
            movb #0,dispThrust+32    ;string terminator, acts like '\0'
            ;intializing string "dispTimeMile" to be:
            ;"Flight Time:    Mileage:      ",0
            movb #'F',dispTimeMile
            movb #'l',dispTimeMile+1
            movb #'i',dispTimeMile+2
            movb #'g',dispTimeMile+3
            movb #'h',dispTimeMile+4
            movb #'t',dispTimeMile+5
            movb #' ',dispTimeMile+6
            movb #'T',dispTimeMile+7
            movb #'i',dispTimeMile+8
            movb #'m',dispTimeMile+9
            movb #'e',dispTimeMile+10
            movb #':',dispTimeMile+11
            movb #' ',dispTimeMile+12
            movb #' ',dispTimeMile+13
            movb #' ',dispTimeMile+14
            movb #' ',dispTimeMile+15
            movb #'M',dispTimeMile+16
            movb #'i',dispTimeMile+17
            movb #'l',dispTimeMile+18
            movb #'e',dispTimeMile+19
            movb #'a',dispTimeMile+20
            movb #'g',dispTimeMile+21
            movb #'e',dispTimeMile+22
            movb #':',dispTimeMile+23
            movb #' ',dispTimeMile+24
            movb #' ',dispTimeMile+25
            movb #' ',dispTimeMile+26
            movb #' ',dispTimeMile+27
            movb #' ',dispTimeMile+28
            movb #' ',dispTimeMile+29
            movb #' ',dispTimeMile+30
            movb #' ',dispTimeMile+31
            movb #0,dispTimeMile+32    ;string terminator, acts like '\0'
            ;intializing string "dispCombatStat" to be:
            ;"Thrust:         To Change: 6    ",0
            movb #'C',dispCombatStat
            movb #'o',dispCombatStat+1
            movb #'m',dispCombatStat+2
            movb #'b',dispCombatStat+3
            movb #'a',dispCombatStat+4
            movb #'t',dispCombatStat+5
            movb #':',dispCombatStat+6
            movb #' ',dispCombatStat+7
            movb #' ',dispCombatStat+8
            movb #' ',dispCombatStat+9
            movb #' ',dispCombatStat+10
            movb #' ',dispCombatStat+11
            movb #' ',dispCombatStat+12
            movb #' ',dispCombatStat+13
            movb #' ',dispCombatStat+14
            movb #' ',dispCombatStat+15
            movb #' ',dispCombatStat+16
            movb #' ',dispCombatStat+17
            movb #' ',dispCombatStat+18
            movb #' ',dispCombatStat+19
            movb #' ',dispCombatStat+20
            movb #' ',dispCombatStat+21
            movb #' ',dispCombatStat+22
            movb #' ',dispCombatStat+23
            movb #' ',dispCombatStat+24
            movb #' ',dispCombatStat+25
            movb #' ',dispCombatStat+26
            movb #' ',dispCombatStat+27
            movb #' ',dispCombatStat+28
            movb #' ',dispCombatStat+29
            movb #' ',dispCombatStat+30
            movb #' ',dispCombatStat+31
            movb #0,dispCombatStat+32    ;string terminator, acts like '\0'

            ldx #dispPtrArray
            ldy #dispMenu
            sty 2,x+
            ldy #dispEngine
            sty 2,x+
            ldy #dispFuel
            sty 2,x+
            ldy #dispSpeed
            sty 2,x+
            ldy #dispPitch
            sty 2,x+
            ldy #dispAltitude
            sty 2,x+
            ldy #dispThrust
            sty 2,x+
            ldy #dispTimeMile
            sty 2,x+
            ldy #dispCombatStat
            sty 0,x
            rts
