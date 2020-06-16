			    ORG 00H
			    SJMP START
			    ORG 0BH
INTERRUPT_T0:	INC A			;Akudeki deger 1 artirilir
			    CJNE A,#10,JUMP ;Akudeki deger 10 degilse JUMP' a atlar
			    MOV A,#00H		;Akudeki deger 10 a esitse sifirlar
			    CPL P3.5		;P3.5 portuna ait biti tersler.
JUMP:		    RETI
			
			
			ORG 30H
START:		MOV P1,#0FFH	;P1'e ait pinleri aktif eder.
			MOV P2,#00H		;P2' e ait pinleri temizler.
			MOV P3,#00H		;P3'e ait pinleri temizler.
			CLR P3.5		;P3.5 pinini temizler.
			SJMP T0_START 
			JB P1.0,RELEASE
			
STRT: 		JB P3.5,WAIT
LED1:		MOV P3,#0EH		;1.Display'i aktif eder.
			MOV P2,#79H 	;"E" harfi atamasi.
			MOV P2,#00H 	;Harfleri söndürür.
LED2:		MOV P3,#0DH 	;2.Displayi aktif eder.
			MOV P2,#5EH 	;"d" harfini atar.
			MOV P2,#00H 	;Harfleri söndürür.
LED3:		MOV P3,#0BH 	;3. display yakildi
			MOV P2,#06H 	;"1" Sayisini atar.
			MOV P2,#00H 	;Harfleri söndürür.
LED4:		MOV P3,#07H 	;4.Displayi aktif eder.
			MOV P2,#7CH 	;"b" harfini atar.
			MOV P2,#00H 	;Harfleri söndürür.
			JNB P1.0,STRT
RELEASE:		JB P1.0,RELEASE
			SJMP WAIT
WAIT:		JB P3.5,WAIT
			SJMP STRT
T0_START:	MOV IE,#82H
			MOV A,#00H
			MOV TMOD,#01H
			MOV TH0,#00H
			MOV TL0,#00H
			SETB TR0
			JB P1.0,RELEASE
			END