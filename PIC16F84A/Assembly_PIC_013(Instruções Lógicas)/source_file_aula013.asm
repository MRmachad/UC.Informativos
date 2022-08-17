;
; Curso de Assembly para PIC Aula 012
;
; Instruções Aritméticas em Assembly
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
  
  
; --- Arquivos incluídos no projeto ---
 #include <p16f84a.inc>							; inclui o arquivo do PIC16F84A  
  
  
; --- FUSE Bits ---
; Cristal oscilador externo 4MHz, sem watchdog timer, com power up timer, sem proteção do código
 __config _XT_OSC & _WDT_OFF & _PWRTE_ON & _CP_OFF
	
 

; --- Paginação de Memória ---
 #define		bank0		bcf	STATUS,RP0		;Cria um mnemônico para o banco 0 de memória
 #define		bank1		bsf STATUS,RP0		;Cria um mnemônico para o banco 1 de memória
  
 
; --- Registradores de Uso Geral ---
 cblock			H'0C'							;inicio da memória do usuário
 
 regist1										;registrador auxiliar
 regist2										;registrador auxiliar
 
 endc  											;final da memória do usuário
                             
; --- Vetor de RESET ---
				org			H'0000'				;Origem no endereço 0000h de memória
				goto		inicio				;Desvia do vetor de interrupção
				
; --- Vetor de Interrupção ---
				org			H'0004'				;Todas as interrupções apontam para este endereço
				retfie							;Retorna de interrupção
				

; --- Programa Principal ---				
inicio:
				bank1							;seleciona o banco 1 de memória
				movlw		H'FF'				;W = B'11111111'
				movwf		TRISA				;TRISA = H'FF' (todos os bits são entrada)
				movlw		H'FF'				;W = B'11110101'
				movwf		TRISB				;TRISB = H'F5' configura RB1 e RB3 como saída
				bank0							;seleciona o banco 0 de memória (padrão do RESET)
 				clrf		regist1
 				clrf		regist2
				
loop:											;Loop infinito

				movlw		B'11110000'			;W = H'F0'
				andlw		B'10100001'			;W = W and B'1111000'
				
				xorwf		regist1,F			; regist1 = H'A0'

				
				

				
				
				goto		loop


				
				end								;Final do programa
				

;     INSTRUÇÕES:
; ----------------------------------
;
; ANDLW		k
;
; Operação:   W = W AND k
;
; Afeta a flag Z do STATUS
;
; ----------------------------------
;
; ANDWF		f,d
;
; Operação:   d = W AND f
;
; d = 0 (W) ou d = 1 (f)
;
; Afeta a flag Z do STATUS
;
; ----------------------------------
;
; COMF		f,d
;
; Operação:   d = NOT f
;
; d = 0 (W) ou d = 1 (f)
;
; Afeta a flag Z do STATUS
;
; ----------------------------------
;
; IORLW		k
;
; Operação:   W = W OR k
;
; Afeta a flag Z do STATUS
;
; ----------------------------------
;
; IORWF		f,d
;
; Operação:   d = W OR f
;
; d = 0 (W) ou d = 1 (f)
;
; Afeta a flag Z do STATUS
;
; ----------------------------------
;
; XORLW		k
;
; Operação:   W = W XOR k
;
; Afeta a flag Z do STATUS
;
; ----------------------------------
;
; XORWF		f,d
;
; Operação:   d = W XOR f
;
; d = 0 (W) ou d = 1 (f)
;
; Afeta a flag Z do STATUS
;
; ----------------------------------