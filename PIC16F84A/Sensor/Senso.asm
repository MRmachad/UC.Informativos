
; Cálculo do Ciclo de Máquina:
;
; Ciclo de máquina = 1/(Freq Cristal / 4) = 1us
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
  
  
; --- Arquivos incluídos no projeto ---
 #include <p16f84a.inc>							; inclui o arquivo do PIC16F84A  
  
  
; --- FUSE Bits ---
; Cristal oscilador externo 4MHz, sem watchdog timer, com power up timer, sem proteção do código
 __config _XT_OSC & _WDT_OFF & _PWRTE_ON & _CP_OFF
	

; --- Paginação de Memória ---
 #define		bank0		bcf	STATUS,RP0		;Cria um mnemônico para o banco 0 de memória
 #define		bank1		bsf STATUS,RP0		;Cria um mnemônico para o banco 1 de memória
 

; --- Entradas ---
 #define		eco 		PORTB,RB0			;botão 1 ligado em RB0

 
 
; --- Saídas ---
 #define		triger		PORTB,RB1			; 1 ligado em RB1
 
; variaveis
 
 cblock			H'0C'							;inicio da memória do usuário
 
 regist1										;registrador auxiliar
 regist2	
 aux
 aux2
 endc    
                             
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
				movlw		H'FD'				;W = B'11111101'
				movwf		TRISB				;TRISB = H'F5' configura RB1 e RB3 como saída
				bank0							;seleciona o banco 0 de memória (padrão do RESET)
				movlw		H'F8'				;W = B'11110100'
				movwf		PORTB				;tigyer em 0 iniciam desligados
				
loop:											;Loop infinito

				bsf			triger
				call		delay10us			;chama sub rotina
				bcf			triger
			
				goto		contagem				;volta para label loop
				
				
				
; --- Desenvolvimento das Sub-Rotinas ---

contagem:
				btfss		eco	
				goto	 	loop1
				incf  		regist1,w
				goto 		contagem
				
loop1:
		
				movlw		D'58'
				call		contagem2
				
				goto 		loop
 				
contagem2:
				subwf		regist1,C		
				btfsc		STATUS,C
				return
				incf		regist2,C
				goto 		contagem2
				
				
delay10us:
				nop 	
				nop
				nop
				nop
				nop	
				nop
			
				
				return
						
				end								;Final do programa