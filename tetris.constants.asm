; ---------------------------------------------------------------------------
; Constants and offsets
; ---------------------------------------------------------------------------	

; ---------------------------------------------------------------------------
; Offsets for the pieces
; ---------------------------------------------------------------------------

; universally followed object conventions:
render_flags =		  4 ; bitfield
						; Bit 0 is the horizontal mirror flag. If set, the object will be flipped on its horizontal axis.
						; Bit 1 is the vertical mirror flag.
						; Bit 2 is the coordinate system flag. If clear, the object will be positioned by absolute screen coordinates. 
						;   This is used for things like the HUD and menu options. If set, the object will be positioned by the playfield coordinates, i.e. where it is in a level.
						; Bits 3 and 4 are either unused, or their purpose is unknown.
						; Bit 5 is the static mappings flag. If set, this indicates that the mappings pointer for this object points directly to the pieces data for this frame, and implies that the object consists of only one sprite piece.
						; Bit 6 is the compound sprites flag. If set, this indicates that the current object's status table also contains information about other child sprites which need to be drawn using the current object's mappings:
						;  - Word $16 of the status table indicates the number of child sprites.
						;  - Following this word is the actual data for each sprite. The format is six bytes per sprite: the first word is the base X position, the next word is the base Y position, the next byte is ignored and the last byte is the mapping frame to display
						; Bit 7 is the on-screen flag. It will be set if the object is on-screen, and clear otherwise.
height_pixels =		  6 ; byte
width_pixels =		  7 ; byte
priority =		  8 ; word ; in units of $80
art_tile =		 $A ; word ; PCCVH AAAAAAAAAAA ; P = priority, CC = palette line, V = y-flip; H = x-flip, A = starting cell index of art
mappings =		 $C ; long
x_pos =			$10 ; word, or long when extra precision is required
y_pos =			$14 ; word, or long when extra precision is required
mapping_frame =		$22 ; byte
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
Field_mappings = ramaddr($FFFFE000)	; graphics (plane mapping definitions) for the pieces
Field_mappings_2 = ramaddr($FFFFE1C0)	; for Player 2

Field_layout = ramaddr($FFFFE380)	; 0 = empty
									; 1 = yellow
									; 2 = light blue
									; 3 = red
									; 4 = blue
									; 5 = orange
									; 6 = green
									; 7 = purple
									; $FF = border

Field_layout_2 = ramaddr($FFFFE4C0)	; for Player 2

Piece_control_mem = ramaddr($FFFFEA00)

Ctrl_1 = ramaddr($FFFFF602)
Ctrl_1_held = ramaddr($FFFFF602)
Ctrl_1_pressed = ramaddr($FFFFF603)
Ctrl_2 = ramaddr($FFFFF604)
Ctrl_2_held = ramaddr($FFFFF604)
Ctrl_2_pressed = ramaddr($FFFFF605)

Game_mode_index = ramaddr($FFFFF600)
