;
; CUrso de Assembly para 8051 WR Kits
;
; Aula 10: Acessando Dados de um Banco
;
; Eng. Wagner Rambo
;
; Agosto de 2015
;

; --- Vetor de RESET ---
	org	0000h		;Origem no endere?o 00h de mem?ria
	mov	r0,#0d		;Move a constante 0 para r0
	mov	dptr,#banco	;Endere?o inicial do banco para dptr

; --- Rotina Principal ---
princ:
	mov	a,r0		;Move o conte?do de r0 para acc
	movc	a,@a+dptr	;Move o byte relativo de dptr somado
				;com o valor de acc para o acc
	mov	p0,a		;Move o conte?do de acc para Port0
	inc	r0		;Incrementa r0
	cjne	r0,#8d,princ	;Compara r0 com 0 e pula se n?o for igual
	ajmp	$		;Segura o c?digo nesta linha

; --- Banco ---
banco:
	db	01h		; 00000001b
	db	02h		; 00000010b
	db	04h		; 00000100b
	db	08h		; 00001000b
	db	10h		; 00010000b
	db	20h		; 00100000b
	db	40h		; 01000000b
	db	80h		; 10000000b

	end			;Final do programa

















