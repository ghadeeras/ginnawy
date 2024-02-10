10 dim B%(4) : for I=0 to 4 : B%(I)=base(10+I) : next I

100 'TURBO ON, if X-BASIC is available
100 on error goto 120
110 goto 150
120 resume 130
130 on error goto 0
140 goto 200
150 CALL TURBO ON(B%())

200 'Init
200 defint A-Z
210 dim PX(3), PY(3), VX(3), VY(3), AX(3), AY(3), S(3), CX(3), CY(3), C(3), H(3), HC(23), XA(8), YA(8)
220 XA(0)= 0 : YA(0)= 0
230 XA(1)= 0 : YA(1)=-2
240 XA(2)= 2 : YA(2)=-2
250 XA(3)= 2 : YA(3)= 0
260 XA(4)= 2 : YA(4)= 2
270 XA(5)= 0 : YA(5)= 2
280 XA(6)=-2 : YA(6)= 2
290 XA(7)=-2 : YA(7)= 0
300 XA(8)=-2 : YA(8)=-2
310 gosub 9000 : VA=B%(0)+30 : for Y=0 to 23 : HC(Y)=vpeek(VA) : VA=VA+32 : next Y
320 vdp(1)=vdp(1) or &B01000000
330 on key gosub 350,,,,360
340 key(1) on  : key(5) on : goto 500
350 key(1) on  : return 500
360 key(1) off : return 1500

500 'Reset
500 PX(0)=480 : PY(0)=352 : PX(1)=0 : PY(1)=0 : PX(2)=960 : PY(2)=0 : PX(3)=480 : PY(3)=704 : C(0)=15 : C(1)=12 : C(2)=8 : C(3)=4
510 for E=0 to 3 : VX(E)=0 : VY(E)=0 : AX(E)=0 : AY(E)=0 : S(E)=0 : CX(E)=0 : CY(E)=0 : H(E)=1024 : next E

1000 'Loop
1000 DT=5 : MT=&H7F00 : T=0 : TIME=0
1010 if (TIME-T)<DT goto 1010 else T=T+DT : if T>MT then T=T-MT : TIME=TIME-MT
1020 gosub 3000 : gosub 6000 : gosub 4000 : gosub 5000
1030 E=0 : DH=1 : gosub 2000 : DH=-1 : for E=1 to 3 : gosub 2000 : next E 
1040 goto 1010

1500 'Exit
1500 end

2000 'Health adjust
2000 if H(E)>0 then 2030
2010 if H(E)>-5 then H(E)=H(E)-1 
2020 return
2030 H(E)=H(E)+DH : if H(E)<0 then H(E)=0 else if H(E)>1024 then H(E)=1024
2040 return

3000 'Input
3000 if H(0)<=0 then S(0)=0 else S(0)=stick(0)
3010 AX(0)= XA(S(0)) : AY(0)=YA(S(0))
3020 return

4000 'Engine
4010 for E=0 to 3
4020 AX(E)=AX(E)-sgn(VX(E)) : AY(E)=AY(E)-sgn(VY(E))
4030 VX(E)=VX(E)+AX(E) : if VX(E)> 32 then VX(E)= 32 else if VX(E)<-32 then VX(E)=-32
4040 VY(E)=VY(E)+AY(E) : if VY(E)> 31 then VY(E)= 32 else if VY(E)<-32 then VY(E)=-32
4050 PX(E)=PX(E)+VX(E) : if PX(E)>832 or PX(E)<0 then VX(E)=-VX(E) : PX(E)=PX(E)-2*(PX(E) mod 832) : DH=-4*abs(VX(E)) : gosub 2000
4060 PY(E)=PY(E)+VY(E) : if PY(E)>704 or PY(E)<0 then VY(E)=-VY(E) : PY(E)=PY(E)-2*(PY(E) mod 704) : DH=-4*abs(VY(E)) : gosub 2000
4070 next E
4080 return

5000 'Renderer
5000 Y=4
5010 for E=0 to 3 : HE=H(E)\64 : L=((HE+4)\8)*5+2
5020 for C=0 to 3
5030 if HE>4 then HC(Y)=L+4 else if HE>0 then HC(Y)=L+HE else HC(Y)=L
5040 Y=Y-1 : HE=HE-4
5050 next C
5060 Y=Y+10
5070 next E
5080 for E=0 to 3
5090 if H(E)>=0 then SE=S(E) else SE=8-H(E)
5100 put sprite E,(PX(E)\4-XA(S(E)),PY(E)\4-YA(S(E))-1),C(E),SE
5110 next E
5120 VA=B%(0)+62 : for Y=1 to 22 : vpoke VA,HC(Y) : VA=VA+32 : next Y
5130 return

6000 'AI
6000 CX(1)=VX(0)*8 : CY(1)=VY(0)*8 : CX(2)=-CY(1) : CY(2)=CX(1) : CX(3)=CY(1) : CY(3)=-CX(1) : HD=0
6010 for E=1 to 3 : if H(E)<=0 then AX(E)=0 : AY(E)=0 : S(E)=0 : goto 6110
6020 DX=PX(0)-PX(E) : DY=PY(0)-PY(E)
6030 OX=32-abs(DX) : OY=32-abs(DY) : if OX>0 and OY>0 then DH=OX+OY : gosub 2000 : HD=HD-DH
6040 DX=DX+CX(E) : DY=DY+CY(E) : SX=sgn(DX) : SY=sgn(DY)
6050 if SX=0 and SY=0 or H(0)<=0 then AX(E)=0 : AY(E)=0 : S(E)=0 : goto 6110
6060 HC=7*abs(DX) : VC=7*abs(DY) : DC=5*(abs(DX)+abs(DY))
6070 if DC>HC and DC>VC then 6100 else if VC>HC then 6090
6080 AX(E)=2*SX : AY(E)=   0 : S(E)=(1-SX)*2+3 : goto 6110
6090 AX(E)=   0 : AY(E)=2*SY : S(E)=(1+SY)*2+1 : goto 6110
6100 AX(E)=2*SX : AY(E)=2*SY : if SX<>SY then S(E)=(2-SX)*2 else S(E)=(3-SX)*2 
6110 next E
6120 if HD<0 then E=0 : DH=HD : gosub 2000
6130 return

9000 return
