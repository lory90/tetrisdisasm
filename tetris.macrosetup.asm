	padding off	; Don't want AS padding out dc.b instructions
	;listing off			; Don't need to generate anything for a listing file
	;listing on			; Want full listing file
	;listing noskipped	; Want listing file, but only the non-skipped part of conditional assembly
	listing purecode	; Want listing file, but only the final code in expanded macros
	page	0	; Don't want form feeds
	supmode on	; Don't need warnings about privileged instructions


notZ80 function cpu,(cpu<>128)&&(cpu<>32988)

; make org safer (impossible to overwrite previously assembled bytes)
org macro address
	if notZ80(MOMCPU)
diff := address - *
		if diff < 0
			error "too much stuff before org $\{address} ($\{(-diff)} bytes)"
		else
			while diff > 1024
				; AS can only generate 1 kb of code on a single line
				dc.b [1024]$FF
diff := diff - 1024
			endm
			dc.b [diff]$FF
		endif
	else
		if address < $
			error "too much stuff before org 0\{address}h (0\{($-address)}h bytes)"
		else
			while address > $
				db 0
			endm
		endif
	endif
    endm

; define an alternate org that fills the extra space with 0s instead of FFs
org0 macro address
diff := address - *
	if diff < 0
		error "too much stuff before org0 $\{address} ($\{(-diff)} bytes)"
	else
		while diff > 1024
			; AS can only generate 1 kb of code on a single line
			dc.b [1024]0
diff := diff - 1024
		endm
		dc.b [diff]0
	endif
    endm

; define the cnop pseudo-instruction
cnop macro offset,alignment
	if notZ80(MOMCPU)
		org (*-1+(alignment)-((*-1+(-(offset)))#(alignment)))
	else
		org ($-1+(alignment)-(($-1+(-(offset)))#(alignment)))
	endif
    endm

; define an alternate cnop that fills the extra space with 0s instead of FFs
cnop0 macro offset,alignment
	org0 (*-1+(alignment)-((*-1+(-(offset)))#(alignment)))
    endm

; redefine align in terms of cnop, because the built-in align can be stupid sometimes
align macro alignment
	cnop 0,alignment
    endm

; define an alternate align that fills the extra space with 0s instead of FFs
align0 macro alignment
	cnop0 0,alignment
    endm

; define the even pseudo-instruction
even macro
	align0 2
    endm

; define a trace macro
; lets you easily check what address a location in this disassembly assembles to
trace macro optionalMessageWithoutQuotes
	if MOMPASS=1
		if ("ALLARGS"<>"")
			message "#\{tracenum/1.0}: line=\{MOMLINE/1.0} PC=$\{(*)&$FFFFFFFF} msg=ALLARGS"
		else
			message "#\{tracenum/1.0}: line=\{MOMLINE/1.0} PC=$\{(*)&$FFFFFFFF}"
		endif
tracenum := (tracenum+1)
	endif
   endm
tracenum := 0

chkop function op,ref,(substr(lowstring(op),0,strlen(ref))<>ref)

; 1-arg instruction that's self-patching to remove 0-offset optimization
insn1op	 macro oper,x
	  if (chkop("x","0("))
		!oper	x
	  else
		!oper	1+x
		!org	*-1
		!dc.b	0
	  endif
	 endm

; 2-arg instruction that's self-patching to remove 0-offset optimization
insn2op	 macro oper,x,y
	  if (chkop("x","0("))
		  if (chkop("y","0("))
			!oper	x,y
		  else
			!oper	x,1+y
			!org	*-1
			!dc.b	0
		  endif
	  else
		if chkop("y","d")
		  if (chkop("y","0("))
start:
			!oper	1+x,y
end:
			!org	start+3
			!dc.b	0
			!org	end
		  else
			!oper	1+x,1+y
			!org	*-3
			!dc.b	0
			!org	*+1
			!dc.b	0
		  endif
		else
			!oper	1+x,y
			!org	*-1
			!dc.b	0
		endif
	  endif
	 endm

	; instructions that were used with 0(a#) syntax
	; defined to assemble as they originally did
_move	macro
		insn2op move.ATTRIBUTE, ALLARGS
	endm
_movea	macro
		insn2op movea.ATTRIBUTE, ALLARGS
	endm