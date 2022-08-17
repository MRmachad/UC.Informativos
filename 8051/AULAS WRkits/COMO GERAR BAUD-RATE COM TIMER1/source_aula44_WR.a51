;
;   Curso de Assembly para 8051 WR Kits
;
;   Aula 44 - Como Gerar Baud Rate com Timer1
;   
;  
;
;   MCU: AT89S51    Clock: 12MHz    Ciclo de Máquina: 1µs
;
;  
;   Sistema Sugerido: PARADOXUS 8051
;
;   Disponível a venda em https://wrkits.com.br/catalog/show/140
;
;
; www.wrkits.com.br | facebook.com/wrkits | youtube.com/user/canalwrkits
;
;   Autor: Eng. Wagner Rambo   |   Data: Abril de 2016
;
;

; --- Vetor de RESET ---
        org     0000h           ;origem no endereço 00h de memória
        sjmp    inicio          ;desvia dos vetores de interrupção


; --- Vetor de Interrupção Serial ---
        org     0023h           ;interrupção serial aponta para este endereço
        sjmp    ser             ;desvia para o endereço da rotina de interrupção


; --- Programa Principal ---
inicio:

        mov     TMOD,#00100000b ;Timer1 no modo 2
        mov     PCON,#10000000b ;
        mov     TH1,#0FAh       ;Timer1 configurado para gerar baud rate de 9600
        setb    TR1             ;Liga Timer1
        mov     IE,#90h         ;Habilita interrupção Serial
        mov     SCON,#01010000b ;Serial no Modo 1, liberando o bit REN


        sjmp    $               ;Loop infinito


; --- Rotina de tratamento da Interrupção ---
ser:

        mov     a,SBUF          ;Lê o conteúdo de SBUF e carrega em acc
        clr     RI              ;limpa bit de interrupção
        reti                    ;retorna da rotina de interrupção


        end                     ;Final do programa
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 