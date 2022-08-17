;
; Curso de Assembly para PIC Aula 009
;
; Aciona LED1 ligado em RB1 e apaga LED2 ligado em RB3
; aguarda 500 milissegundos
; Aciona LED2 ligado em RB3 e apaga LED1 ligado em RB1
; aguarda 500 milissegundos
;
;
; OBS.:
;
; LEDs ligados no modo current sourcing:
;
; '0' - apaga
; '1' - acende
;
; C�lculo do Ciclo de M�quina:
;
; Ciclo de m�quina = 1/(Freq Cristal / 4) = 1us
;
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
 

; --- Entradas ---
 #define		botao1		PORTB,RB0			;bot�o 1 ligado em RB0
 #define		botao2		PORTB,RB2			;bot�o 2 ligado em RB2
 
 
; --- Sa�das ---
 #define		led1		PORTB,RB1			;LED 1 ligado em RB1
 #define		led2		PORTB,RB3			;LED 2 ligado em RB3
                       
                             
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
				movlw		H'F5'				;W = B'11110101'
				movwf		TRISB				;TRISB = H'F5' configura RB1 e RB3 como sa�da
				bank0							;seleciona o banco 0 de mem�ria (padr�o do RESET)
				movlw		H'F5'				;W = B'11110101'
				movwf		PORTB				;LEDs iniciam desligados
				
loop:											;Loop infinito

				bsf			led1				;liga LED1
				bcf			led2				;desliga LED2
				call		delay500ms			;chama sub rotina
				bcf			led1				;desliga LED1
				bsf			led2				;liga LED2
				call		delay500ms			;chama sub rotina

				goto		loop				;volta para label loop
				
				
				
; --- Desenvolvimento das Sub-Rotinas ---
 				
				
delay500ms:

				movlw		D'200'				;Move o valor para W
				movwf		H'0C'				;Inicializa a vari�vel tempo0 

												; 4 ciclos de m�quina

aux1:
				movlw		D'250'				;Move o valor para W
				movwf		H'0D'				;Inicializa a vari�vel tempo1
	
												; 2 ciclos de m�quina

aux2:
				nop								;Gastar 1 ciclo de m�quina
				nop
				nop
				nop
				nop
				nop
				nop

				decfsz		H'0D'				;Decrementa tempo1 at� que seja igual a zero
				goto		aux2				;Vai para a label aux2 

												; 250 x 10 ciclos de m�quina = 2500 ciclos

				decfsz		H'0C'				;Decrementa tempo0 at� que seja igual a zero
				goto		aux1				;Vai para a label aux1

												; 3 ciclos de m�quina

												; 2500 x 200 = 500000

				return							;Retorna ap�s a chamada da sub rotina
				
				
				end								;Final do programa