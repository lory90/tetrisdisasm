; ---------------------------------------------------------------------------
; Constants and offsets
; ---------------------------------------------------------------------------	

; ---------------------------------------------------------------------------
; Controller Buttons
;
; Buttons bit numbers
ButtonUp =  0
ButtonDown =  1
ButtonLeft =  2
ButtonRight =  3
Button_B =  4
Button_C =  5
Button_A =  6
ButtonStart =  7
; Buttons masks
ButtonUp_Mask = 1<<ButtonUp	; $01
ButtonDown_Mask =  1<<ButtonDown	; $02
ButtonLeft_Mask =  1<<ButtonLeft	; $04
ButtonRight_Mask =  1<<ButtonRight	; $08
Button_B_Mask =  1<<Button_B	; $10
Button_C_Mask =  1<<Button_C	; $20
Button_A_Mask =  1<<Button_A	; $40
ButtonStart_Mask =  1<<ButtonStart	; $80
; ---------------------------------------------------------------------------


; ---------------------------------------------------------------------------
; Address Constants
; ---------------------------------------------------------------------------


; VDP
VDP_Data_Port =  $C00000
VDP_Control_Port =  $C00004
VDP_Counter =  $C00008

PSG_Input =  $C00011

; Z80
Z80_RAM =  $A00000	; start of Z80 RAM
Z80_RAM_End =  $A02000	; end of non-reserved Z80 RAM
Z80_Bus_Request =  $A11100
Z80_Reset =  $A11200

Security_Addr =  $A14000 

; I/O area
HW_Version =  $A10001
HW_Port_1_Data =  $A10003
HW_Port_2_Data =  $A10005
HW_Expansion_Data =  $A10007
HW_Port_1_Control =  $A10009
HW_Port_2_Control =  $A1000B
HW_Expansion_Control =  $A1000D



; RAM
Ctrl_1 = $FFFFF602
Ctrl_1_Held = $FFFFF602
Ctrl_1_Pressed = $FFFFF603
Ctrl_2 = $FFFFF604
Ctrl_2_Held = $FFFFF604
Ctrl_2_Pressed = $FFFFF605

Game_Mode_Index = $FFFFF600
