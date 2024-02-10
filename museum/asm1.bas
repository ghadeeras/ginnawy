10 CLEAR120,&HA000
15 SCREEN2,0,0:B$=CHR$(&HEF):SPRITE$(0)=B$+B$+B$+B$+B$+B$+B$+B$:PUTSPRITE0,(10,50),1,0:PUTSPRITE1,(20,70),3,0
20 FORA=0TO113:READB$:POKEA+&HA000,VAL("&h"+B$):NEXT:DEFUSR=&HA000
30 A=USR(0):END
40 DATA 3e,0,cd,d5,0,21,1,1b,57,cd,32,a0,dd,21,ab,fc,dd,cb,0,46,c0
50 DATA 3e,0,cd,d8,0,28,e4,fd,21,6,a0,fd,cb,0,56,28,6,fd,cb,0,96,18,d4,fd,cb,0,d6,18,ce
60 DATA 14,14,cb,42,c8,cb,4a,28,1,2b,cd,4a,0,3d,cb,52,28,2,c6,2,47,e5,48,cd,5f,a0,57,2c,cb,8d,cd,4a,0,4f,cd,5f,a0,b2,c8
70 DATA e1,78,cd,4d,0,c9,2c,2c,2c,2c,cb,9d,cd,4a,0,91,cb,7f,28,2,ed,44,e6,f8,c9
