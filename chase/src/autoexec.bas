10 'Make sure X-BASIC is available (e.g. on Sanyo PHC-70FD) or loaded
10 on error goto 50
20 CALL BC
30 on error goto 0
40 goto 1000
50 resume 60
60 on error goto 0
70 bload "XBASIC.BIN",R

1000 color 15,1,5 : screen 2,2,0
1010 vdp(1)=vdp(1) and &B10111111
1020 bload "name.bin"    ,S
1030 bload "color1.bin"  ,S
1040 bload "color2.bin"  ,S
1050 bload "color3.bin"  ,S
1060 bload "pattern1.bin",S
1070 bload "pattern2.bin",S
1080 bload "pattern3.bin",S
1090 bload "sprite.bin"  ,S

1100 load  "game.bas"    ,R
