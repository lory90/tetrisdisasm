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
VDP_data_port =  $C00000
VDP_control_port =  $C00004
VDP_counter =  $C00008

PSG_input =  $C00011

; Z80
Z80_RAM =  $A00000	; start of Z80 RAM
Z80_RAM_end =  $A02000	; end of non-reserved Z80 RAM
Z80_bus_request =  $A11100
Z80_reset =  $A11200

Security_addr =  $A14000 

; I/O area
HW_version =  $A10001
HW_port_1_data =  $A10003
HW_port_2_data =  $A10005
HW_expansion_data =  $A10007
HW_port_1_control =  $A10009
HW_port_2_control =  $A1000B
HW_expansion_control =  $A1000D


; sign-extends a 32-bit integer to 64-bit
; all RAM addresses are run through this function to allow them to work in both 16-bit and 32-bit addressing modes
ramaddr function x,(-(x&$80000000)<<1)|x

; RAM addresses
Ctrl_1 = ramaddr($FFFFF602)
Ctrl_1_held = ramaddr($FFFFF602)
Ctrl_1_pressed = ramaddr($FFFFF603)
Ctrl_2 = ramaddr($FFFFF604)
Ctrl_2_held = ramaddr($FFFFF604)
Ctrl_2_pressed = ramaddr($FFFFF605)

Game_mode_index = ramaddr($FFFFF600)
