;
; Curso de Assembly para PIC Aula 012
;
; Instru��es Aritm�ticas em Assembly
;
;
;  
;
; MCU: PIC16F84A   Clock: 4MHz
;
; www.wrkits.com.br | facebook.com/wrkits | youtube.com/canalwrkits
;
; Autor: Eng. Wagner Rambo   Data: Janeiro de 2016
;


 list		p=16f84A							; microcontrolador utilizado PIC16F84A
  
  
; --- Arquivos inclu�dos no projeto ---
 #include <p16f84a.inc>							; inclui o arquivo do PIC16F84A  
  
  
; --- FUSE Bits ---
; Cristal oscilador externo 4MHz, sem watchdog timer, com power up timer, sem prote��o do c�digo
 __config _XT_OSC & _WDT_OFF & _PWRTE_ON & _CP_OFF
	
 

; --- Pagina��o de Mem�ria ---
 #define		bank0		bcf	STATUS,RP0		;Cria um mnem�nico para o banco 0 de mem�ria
 #define		bank1		bsf STATUS,RP0		;Cria um mnem�nico para o banco 1 de mem�ria
  
 
; --- Registradores de Uso Geral ---
 cblock			H'0C'							;inicio da mem�ria do usu�rio
 
 regist1										;registrador auxiliar
 regist2										;registrador auxiliar
 
 endc  											;final da mem�ria do usu�rio
                             
; --- Vetor de RESET ---
				org			H'0000'				;Origem no endere�o 0000h de mem�ria
				goto		inicio				;Desvia do vetor de interrup��o
				
; --- Vetor de Interrup��o ---
				org			H'0004'				;Todas as interrup��es apontam para este endere�o
				retfie							;Retorna de interrup��o
				

; --- Programa Principal ---				
inicio:
				bank1							;seleciona o banco 1 de mem�ria
				movlw		H'FF'				;W = B'11111111'
				movwf		TRISA				;TRISA = H'FF' (todos os bits s�o entrada)
				movlw		H'FF'				;W = B'11110101'
				movwf		TRISB				;TRISB = H'F5' configura RB1 e RB3 como sa�da
				bank0							;seleciona o banco 0 de mem�ria (padr�o do RESET)
 				clrf		regist1
 				clrf		regist2
				
loop:											;Loop infinito

				movlw		B'11110000'			;W = H'F0'
				andlw		B'10100001'			;W = W and B'1111000'
				
				xorwf		regist1,F			; regist1 = H'A0'

				
				

				
				
				goto		loop


				
				end								;Final do programa
				

;     INSTRU��ES:
; ----------------------------------
;
; ANDLW		k
;
; Opera��o:   W = W AND k
;
; Afeta a flag Z do STATUS
;
; ----------------------------------
;
; ANDWF		f,d
;
; Opera��o:   d = W AND f
;
; d = 0 (W) ou d = 1 (f)
;
; Afeta a flag Z do STATUS
;
; ----------------------------------
;
; COMF		f,d
;
; Opera��o:   d = NOT f
;
; d = 0 (W) ou d = 1 (f)
;
; Afeta a flag Z do STATUS
;
; ----------------------------------
;
; IORLW		k
;
; Opera��o:   W = W OR k
;
; Afeta a flag Z do STATUS
;
; ----------------------------------
;
; IORWF		f,d
;
; Opera��o:   d = W OR f
;
; d = 0 (W) ou d = 1 (f)
;
; Afeta a flag Z do STATUS
;
; ----------------------------------
;
; XORLW		k
;
; Opera��o:   W = W XOR k
;
; Afeta a flag Z do STATUS
;
; ----------------------------------
;
; XORWF		f,d
;
; Opera��o:   d = W XOR f
;
; d = 0 (W) ou d = 1 (f)
;
; Afeta a flag Z do STATUS
;
; ----------------------------------