;
; Primeira aula de Assembler- WrKits	
;
; MCU: Pic16F84A	Clock: 4MHz
;
; Autor: Leonardo Machado
	
	
   list	p=16f84A		;microcontrolador utilazado PIC16F84A
	
	
 ; --- Arquivo incluidos no projeto ---
 
   #include <p16f84a.inc>		;inclui o arquivo do Pic16F84A
   
 
 ; --- Fuse Bits ---
 ; Cristal ocilador externo de 4MHz, Sem watchdog timer, com Power Up timer, sem proteção de codigo 
 				__config _XT_OSC & _WDT_OFF & _PWRTE_ON & _CP_OFF
 

 ; --- Paginação de memória ---
    #define		bank0		bcf STATUS,RP0		;Cria um mnemônico para o banco 0 de memória  
    #define		bank1		bsf STATUS,RP0		;Cria um mnemônico para o banco 1 de memória
    
 ; --- Entrada Botão ---
 	#define 	botao			PORTB,RB0		;Botão definido no pino RB0   
 	
 ; --- Saida para led ---	
 	#define 	led				PORTB,RB1		;Saida definida para o led 
 
 ; --- Vetor de RESET ---	
 				org			H'0000' 			;Origem no endereço 000h de memória
 				goto		inicio				;Desvia do vetor de interrupção
 				
 ; --- Vetor de Interrupção ---
 				org			H'0004'				;Todas as interrupções apontam  para este endereço 
 				retfie							;Retorna de interrupção
 				
 ; --- Programa Principal ---
 inicio:
    			bank1								;Seleciona o banco 1 de memoria 
    			movlw		H'FF'					;W = B' 11111111'
    			movwf		TRISA					;TRISA = H'FF'  (Todos os bits são entrada)
    			movlw		H'7F'					;W = B'01111111'
    			movwf		TRISB					;TRISAB	= H'7F  (apenas o RB7 como saida)
    			bank0								;Seleciona o banco 0 de memória (padrão de RESET)
    			movlw		H'FF'					;W = B' 11111111'
    			movwf		PORTB					;RB7 (Configurando como saída)inicio
    		
loop:
				
				btfsc 		botao					;botao precionado (0-sim,vai pro desvio *** 1-nao,vai para "apagaled")
				goto 		apagaled				;desvio pata label 	
				bsf			led						;seta o led ou seja liga ele
				goto		loop					;cria o ciclo de loop
				

apagaled:
			
				bcf			led						;da um clear no led ou seja apaga ele 
				goto		loop					;volta ao loop
    		
    			end									;Final de programa