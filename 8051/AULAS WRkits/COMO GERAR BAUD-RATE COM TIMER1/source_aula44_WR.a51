;
;   Curso de Assembly para 8051 WR Kits
;
;   Aula 44 - Como Gerar Baud Rate com Timer1
;   
;  
;
;   MCU: AT89S51    Clock: 12MHz    Ciclo de M�quina: 1�s
;
;  
;   Sistema Sugerido: PARADOXUS 8051
;
;   Dispon�vel a venda em https://wrkits.com.br/catalog/show/140
;
;
; www.wrkits.com.br | facebook.com/wrkits | youtube.com/user/canalwrkits
;
;   Autor: Eng. Wagner Rambo   |   Data: Abril de 2016
;
;

; --- Vetor de RESET ---
        org     0000h           ;origem no endere�o 00h de mem�ria
        sjmp    inicio          ;desvia dos vetores de interrup��o


; --- Vetor de Interrup��o Serial ---
        org     0023h           ;interrup��o serial aponta para este endere�o
        sjmp    ser             ;desvia para o endere�o da rotina de interrup��o


; --- Programa Principal ---
inicio:

        mov     TMOD,#00100000b ;Timer1 no modo 2
        mov     PCON,#10000000b ;
        mov     TH1,#0FAh       ;Timer1 configurado para gerar baud rate de 9600
        setb    TR1             ;Liga Timer1
        mov     IE,#90h         ;Habilita interrup��o Serial
        mov     SCON,#01010000b ;Serial no Modo 1, liberando o bit REN


        sjmp    $               ;Loop infinito


; --- Rotina de tratamento da Interrup��o ---
ser:

        mov     a,SBUF          ;L� o conte�do de SBUF e carrega em acc
        clr     RI              ;limpa bit de interrup��o
        reti                    ;retorna da rotina de interrup��o


        end                     ;Final do programa
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 