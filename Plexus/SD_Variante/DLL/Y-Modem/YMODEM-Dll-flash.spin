{{
┌──────────────────────────────────────────────────────────────────────────────────────────────────────┐
│ Autor: Reinhard Zielinski                                                                            │
│ Copyright (c) 2013 Reinhard Zielinski                                                                │
│ See end of file for terms of use.                                                                    │
│ Die Nutzungsbedingungen befinden sich am Ende der Datei                                              │
└──────────────────────────────────────────────────────────────────────────────────────────────────────┘

Informationen   : hive-project.de
Kontakt         : zille09@gmail.com
System          : TriOS
Name            : YModem - Treiber für die Dateiübertragung vom Hive zum PC und umgekehrt
Chip            : Regnatix
Typ             : Plexus-Erweiterungsdatei
Version         : 01
Subversion      : 00


Logbuch         :
'############################################### Version 1.0 ######################################################################################################################

20-03-2014      :-Template für DLL-Dateien an die neuen Anforderungen angepasst

21-03-2014       -YModem-Treiber eingebunden, momentan funktioniert nur das Senden
                 -6624 Longs frei

23-03-2014       -Fehler in der Empfangsroutine gefunden
                 -einige kleine Korrekturen im Code des Treibers, am Ende einer Datei wurden falsche Bytes übertragen
                 -jetzt funktioniert der Treiber korrekt
                 -5965 Longs frei

23-03-2014       -Sende-Routine auf SD-Karten-Blocklese-Befehl umgestellt, dadurch die Übertragungsgeschwindigkeit fast verdoppelt :-)
                 -Korrektur beim Lesen der letzten zwei Bytes durchgeführt, jetzt wird die Datei korrekt bis zum letzten Byte übertragen
                 -Korrektur in der Buttonabfrage
                 -kleinere optische Korrekturen
                 -5957 Longs frei

24-03-2014       -doppelten seriell Treiber entfernt
                 -Korrektur in der Empfangsroutine (fehlendes ACK), jetzt funktioniert der Empfang auch mit ZTerm
                 -seltsamerweise wird das Sendefenster in den Terminal-Programmen nach erfolgreichem Empfang nicht geschlossen!?
                 -die Datei wird aber korrekt übertragen
                 -6141 Longs frei

25-03-2014       -Beim Beenden wird jetzt nicht mehr der Desktop gelöscht
                 -dadurch entsteht eine noch bessere Illusion, das die DLL im Plexus integriert ist
                 -6148 Longs frei
}}

obj
        ios: "reg-ios-Modul"
        num: "Numbers"

con
_CLKMODE     = XTAL1 + PLL16X
_XINFREQ     = 5_000_000

'------------- Shell-Farben -----------------------------------------------------
shellhcol       =0           'Hauptfensterfarbe
act_color       =1           'Schriftfarbe
winhcol         =2           'Fensterhintergrundfarbe
winframecol     =3           'Fensterrandfarbe
Titelhcol       =4           'Titelleistenfarbe
titeltextcol    =5           'Titelleistentextfarbe
hcolstatus      =6           'statusleiste hintergrundfarbe
statustextcol   =7           'Statustextfarbe
buttonhcol      =8           'Buttonhintergrundfarbe
buttontextcol   =9           'Buttontextfarbe
messagehcol     =10          'Messagebox-Hintergrundfarbe
messagetextcol  =11          'Messagebox-Textfarbe
selectcol       =12          'selektionsfarbe
mousecol        =13          'Mauszeigerfarbe
panelcol        =14          'Farbe des Utility-Panels

ADM_SPEC       = %00000000_00000000_00000000_01010011
'-------- Speicher für diverse Texte ------------
TXT_RAM     = $10A000
SETTING_RAM = $100000 'Hier stehen die System-Settings
BRAM        = $40000
'-------- Speicher für Systemfont ---------------
SYS_FONT  = $50000 '....$52BFF      ' ab hier liegt der System-Font 11kb
Hour_Glass= $50000+(167*16*4)       ' Platz, wo das Sanduhrsymbol im Systemfont sitzt
MOUSE_RAM = $52C00 '....$52C3F      ' User-Mouse-Pointer 64byte
'-------- YMODEM Temp-Speicher ------------------
YMODEM_RAM= $7E400 '... $7E417   Name, der zu sendenden Datei, Was soll gemacht werden(0Empfang,1Senden)+Dirmarker

'******************Farben ********************************************************
  #$FC, Light_Grey, #$A8, Grey, #$54, Dark_Grey
  #$C0, Light_Red, #$80, Red, #$40, Dark_Red
  #$30, Light_Green, #$20, Green, #$10, Dark_Green
  #$1F, Light_Blue, #$09, Blue, #$04, Dark_Blue
  #$F0, Light_Orange, #$E6, Orange, #$92, Dark_Orange
  #$CC, Light_Purple, #$88, Purple, #$44, Dark_Purple
  #$3C, Light_Teal, #$28, Teal, #$14, Dark_Teal
  #$FF, White, #$00, Black
'----Icon-Nummern----------------------------------------------------------------
BEL_PIC  =14
ADM_PIC  =15
BIN_PIC  =9
BAS_PIC  =107
DIR_PIC  =7
ALL_PIC  =8
DMP_PIC  =120
TXT_PIC  =121
SYS_PIC  =122
COG_PIC  =75
BACK_PIC =124
VOR_PIC  =123
PLAY_PIC =125
STOP_PIC =141
CLR_PIC  =155
EXT_PIC  =156

'------------- F-Tasten für Zusatzfunktionen -------------------------------------
F1_Key       = 208
F2_Key       = 209
F3_Key       = 210
F4_Key       = 211
F5_Key       = 212
F6_Key       = 213
F7_Key       = 214
F8_Key       = 215
F9_Key       = 216
F10_Key      = 217
F11_Key      = 218
F12_Key      = 219
ESC_KEY      = 27
RETURN_KEY   = 13
'--------------------------------------------------------------------------------

var

  byte mountmarker
  long userdir                                                                  'user-Dirmarker
  byte colors[15]                                                               'Farbwerte
  byte ma,mb                                                                    'Maus-Tasten
  byte messagex                                                                 'x-Position der Messagebox

  byte windowx[3]
  byte windowy[3]
  byte windowxx[3]
  byte windowyy[3]
  byte buttonx[5],buttony[5]
  byte util
  long systemdir                                                                'Plexus-System-Verzeichnis
  byte font[25]                                                                 'Hilfsstring für Strings aus dem Ram

    '----------- DCF-Indikator ------------------------------------
  byte dcf_on
  '----------- YMODEM-Variablen ---------------------------------
   byte fbuf[12]
   byte sbuf[30]
   byte pdata[1028]                                                             'packet data
   byte baud
   byte was                                                                     'Was soll ich machen? Senden oder Empfangen

dat
   regsys        byte "plexus.dll",0                                            'Reg.sys für Rückkehr aus externem Programm
   butOK         byte "  OK  ",0
   Abbr          byte "Cancel",0
   SYSTEM        Byte "PLEXUS      ",0                                          'Plexus-Systemverzeichnis
   fertig        byte "Transmission done!",0                                    'fertig-Meldung
{{
'################################################### ACHTUNG ###############################################################
'#                                                                                                                         #
'#              Für eine optimale Übertragungsgeschwindigkeit muss der Puffer im Seriell-Treiber                           #
'#              auf die Mindest-Größe (128) eingestellt werden !!!!                                                        #
'#                                                                                                                         #
'################################################### ACHTUNG ###############################################################
}}
PUB main|yadr,i

    ios.start
    cmd_mount                                                                   'sd-card mounten
    mountmarker:=1                                                              'mount-marker
    '--------------------------------------------------------------------------------------
    activate_dirmarker(0)                                                       'ins root
    ios.sdchdir(@system)                                                        'System-Verzeichnis lesen
    systemdir:=get_dirmarker                                                    'Dir-Marker lesen

    '--------------------------------------------------------------------------------------
    cmd_unmount
    iniload                                                                     'Ini-Datei mit Farbwerten laden
    yadr:=YMODEM_RAM
    i:=0
    was:=ios.ram_rdbyte(YMODEM_RAM+15)                                          'Modus=1 Senden 0=Empfangen
    userdir:=ios.ram_rdlong(YMODEM_RAM+16)
    if was                                                                      'was=1 heisst senden
       repeat 12                                                                'Dateiname aus dem RAM lesen
              fbuf[i++]:=ios.ram_rdbyte(yadr++)
       fbuf[i]:=0

    ios.seropen(bdselect(baud))
    util:=0
    testfenster

    repeat

      os_cmdinput                                                               'Hauptprogrammschleife

PRI os_cmdinput | x,y ,key

  repeat
    'time                                                                       'Zeit und Datum anzeigen

    ma:=ios.mouse_button(0)                                                     'linke Maustaste
    mb:=ios.mouse_button(1)                                                     'rechte Maustaste
    key:=ios.key
    if key
'**************************** Short-Cuts ****************************************************************************
       case key
            ESC_KEY:ausstieg
            RETURN_KEY:ausstieg

'***************************** linke Maustaste **********************************************************************
    if ma
       x:=ios.mousex
       y:=ios.mousey
'****************************** Globale Funktionstasten ********************************************************
       if(x=>buttonx[1]) and (x=<buttonx[1]+5) and (y==buttony[1])              'ok
             buttonpress(1)
             ausstieg
       if(x=>buttonx[2]) and (x=<buttonx[2]+6) and (y==buttony[2])              'cancel
             buttonpress(2)
             ausstieg

con'************************************ YMODEM-Funktion *************************************************************************************************************************
  'XMODEM chars from ymodem.txt
  SOH=$01
  STX=$02
  EOT=$04
  ACK=$06
  NAK=$15
  CAN=$18
  Cee=$43  'liberties here
  Zee=$1A  'or SUB  (DOS EOF?)

PRI bdselect(bauds):bd
    bd:=lookupz(bauds:300,600,1200,4800,9600,19200,38400,57600,115200)

pri Send_file|key,i,size,timer,packet,d,crc,p,j,k,deot,e,position,zaehler,tmp,stand
  'Ymodem protocol: http://timeline.textfiles.com/1988/10/14/1/FILES/ymodem.txt
  '                 http://en.wikipedia.org/wiki/XMODEM
'  ios.seropen(bdselect(baud))'com.start(31, 30, 0, bdselect(baud))
  print_win(@fbuf,10,13)
  print_titel(string("Send"),22,7)
  key:=0
  i:=0
  ios.sdmount
  'Transmit file to host
  activate_dirmarker(userdir)
  e:=ios.sdopen("R",@fbuf)
  if e
    error(e)
    return
  size:=ios.sdfattrib(0)'sdfat.fsize
  printdec_win(size,14,10)
  stand:=size
  tmp:=size/18                                                                  'anzahl bytes pro block
  zaehler:=0

  timer:=cnt
  key:=0
  bytefill(@pdata,0,128)                                                        'Puffer löschen

  repeat until key==Cee                                                         'Wait for NAK from host:  Signal to start sending
    i:=ios.serread'com.rxcheck
    if i>0
      key:=i
    i:=cnt
    if ((cnt-timer)/clkfreq)>10                                                 '10 second timeout
      error(75)
      return                                                                    'fail


                                                                                'start sending packets
  packet:=0
  repeat
    timer:=cnt
    crc:=0
    deot:=false

    ios.sertx(SOH)                                                                 'send header
    ios.sertx(packet)
    ios.sertx(!packet)
                                                                                'construct packet
    if packet==0
      i:=strsize(@fbuf)
      bytemove(@pdata,@fbuf,i+1)
      p:=num.tostr(size,num#DEC)
      j:=strsize(p)
      bytemove(@pdata+i+1,p,j+1)                                                'Send filename and length

    else

        if stand=>128                                                           'Paket von SD-Karte lesen
           ios.sdgetblk(128,@pdata)
           zaehler+=128
           stand-=128

        else
              repeat i from 0 to 127                                            'letztes Paket
                    d:=ios.sdgetc
                    zaehler++
                    if zaehler==size+1
                       repeat i from i to 127
                              pdata[i]:=0
                       stand:=0
                       deot:=true
                       quit
                    pdata[i]:=d


      position:=zaehler/tmp                                                     'balkenposition
      positionsbalken(position,11,11)


    repeat i from 0 to 127                                                      'send packet
      ios.sertx(pdata[i])
      crc:=UpdateCRC(pdata[i],crc)

    ios.sertx((crc>>8)&$FF)
    ios.sertx(crc&$FF)

    repeat
      i:=ios.serread'com.rxcheck
      if i==ACK                                                                 'Paket OK
        quit
      if i==NAK                                                                 'Paket Not OK
                                                                                'retransmit packet
        repeat i from 0 to 127
          ios.sertx(pdata[i])
          ios.sertx((crc>>8)&$FF)
          ios.sertx(crc&$FF)
      if ((cnt-timer)/clkfreq)>10
        ios.sertx(EOT)
        error(78)                                                               '"Timeout failure."))
        return                                                                  'fail
    if (deot==true)                                                             'done
        quit
    else
        packet++
        timer:=cnt



  ios.sertx(EOT)                                                                   'send EOT wait for ACK and send end of batch packet
  repeat
    i:=ios.serread'com.rxcheck
    if i==ACK

      timer:=cnt
      key:=0
      repeat until key==Cee                                                     'now, wait for "C"
        i:=ios.serread'com.rxcheck
        if i>0
          key:=i
        i:=cnt
        if ((cnt-timer)/clkfreq)>10                                             '10 second timeout
          error(75)
          return                                                                'fail
                                                                                'now, transmit null packet and wait for ACK
      key:=0
      repeat until key==ACK
        ios.sertx(SOH)
        ios.sertx(0)
        ios.sertx($FF)
        crc:=0
        repeat 128
          ios.sertx(0)
          crc:=UpdateCRC(0,crc)
        ios.sertx((crc>>8)&$FF)
        ios.sertx(crc&$FF)
        'wait for ack
        key:=ios.serget
        if key<>ACK and key<>NAK
           error(75)
           return                                                               'fail
      quit                                                                      'all done!

  ios.sertx(EOT)

  print_win(@fertig,10,14)
'  waitcnt(cnt+clkfreq)
  ausstieg

PRI positionsbalken(pos,x,y)
    ios.display2dbox(colors[act_color],y,x,y,x+pos,0)

pri Empfang_file|key,i,packet,crc,j,k,timer,bytes,done,zaehler,tmp,position
  'get file from computer and save to SD
  'Ymodem protocol: http://timeline.textfiles.com/1988/10/14/1/FILES/ymodem.txt
  zaehler:=0
  print_titel(string("Receive"),22,7)

  ios.sdmount
                                                                                'Receive file from host
  activate_dirmarker(userdir)

'repeat  'batch reception loop
                                                                                'wait for first packet
    packet:=0
    '############ erstes Paket #################
    repeat until packet==1
        key:=0
        'waitcnt(cnt+clkfreq*3)
        ios.sertx(Cee)
        timer:=cnt
      repeat until key==SOH
          key:=ios.serread
          if(cnt-timer)>clkfreq*5
            ios.sertx(EOT)
             error(75)
             return

                                                                                'analyze first packet
      if(ios.serget==0)
          if(ios.serget==$FF)
            crc:=0
            j:=0
            i:=-1
            done:=0
                                                                                'filename
            repeat until i==0
                  i:=ios.serget
                  fbuf[j++]:=i
                  crc:=UpdateCRC(i,crc)
            print_win(@fbuf,10,13)                                              'Dateiname anzeigen
            i:=-1
            k:=j
            j:=0

            repeat until i==0 or i==32
                  i:=ios.serget
                  if i<>32
                     sbuf[j++]:=i
                  else
                     sbuf[j++]:=0
                  crc:=UpdateCRC(i,crc)

            k+=j

            bytes:=num.fromstr(@sbuf,num#dec)
            tmp:=bytes/18
            printdec_win(bytes,14,10)                                           'Dateigröße anzeigen
            repeat j from k+1 to 128
                   i:=ios.serget
                   crc:=UpdateCRC(i,crc)
          else
              ios.sertx(NAK)
      else
          ios.sertx(NAK)

      i:=ios.serget

      j:=ios.serget

      if i<>(crc>>8) or j<>(crc&$FF)
        ios.sertx(NAK)
      else
        packet:=1

'###################### ende Paket 1 ##################################
    ios.sertx(ACK)


                                                                                'open output file
    ios.sdnewfile(@fbuf)
    ios.sdopen("W",@fbuf)


                                                                                'receive packets
    '################################# restliche Pakete empfangen ####################
    ios.sertx(Cee)
    k:=0
    repeat until k==EOT
      k:=ios.serget
      if k==SOH
        packet:=ios.serget
        i:=ios.serget
        if (255-i)<>packet
           quit

        crc:=0
        repeat j from 0 to 127
          i:=ios.serget
          crc:=UpdateCRC(i,crc)
          pdata[j]:=i
          zaehler++

        i:=ios.serget
        j:=ios.serget
        if i<>(crc>>8) or j<>(crc&$FF)
           ios.sertx(NAK)

        else
                                                                                'write data
          if bytes>128
            ios.sdputblk(128,@pdata)
            bytes-=128

          else
            ios.sdputblk(bytes,@pdata)
            bytes:=0
          ios.sertx(ACK)                                                        'funktioniert auch ohne, ist aber unlogisch
                                                                                'get more
      elseif k==STX
                                                                                '1024 byte packets
          repeat j from 0 to 1027
            pdata[j]:=ios.serget
            zaehler++

          packet:=pdata[0]
          i:=pdata[1]
          if (255-i)<>packet

             quit


          crc:=0
          repeat j from 2 to 1025
            i:=pdata[j]
            crc:=UpdateCRC(i,crc)
          i:=pdata[1026]
          j:=pdata[1027]
          if i<>(crc>>8) or j<>(crc&$FF)
            ios.sertx(NAK)
          else
                                                                                'write data
            if bytes>1024
              ios.sdputblk(1024,@pdata+2)
              bytes-=1024
            else
              ios.sdputblk(bytes,@pdata+2)
              bytes:=0
            ios.sertx(ACK)

      position:=zaehler/tmp                                                   'balkenposition
      positionsbalken(position,11,11)

ios.sertx(ACK)
ios.sdclose
print_win(@fertig,10,14)
ausstieg

PRI UpdateCRC(data,crc):newcrc|i
 'look here:http://web.mit.edu/6.115/www/miscfiles/amulet/amulet-help/xmodem.htm

  crc:=crc^(data<<8)
  repeat i from 0 to 7
    if crc&$8000
      crc:=((crc<<1)&$FFFF)^$1021
    else
      crc:=(crc<<=1)&$FFFF

  return crc&$FFFF
con '********************************************* Ausgabe von Fehlermeldungen ***************************************************************************************************
PRI error(err)

    messagebox(ram_txt(err),1)

PRI messagebox(st,ok)|laenge,mindest
    laenge:=strsize(st)+2
    mindest:= 20
    messagex:=10+laenge
    ios.backup_area(7,10,messagex,17,BRAM)
    ios.display3DBox(white, colors[messagehcol], black, 10, 7, 17, messagex)
    print_message(st,8,11)
    if ok==1
       button(1,@butOK,10,15)
       button(2,@Abbr,1+laenge,15)

PRI ram_txt(nummer)|c,i,ad
    i:=0
    ad:=TXT_RAM+((nummer-1)*25)
         repeat while (c:=ios.Read_Flash_Data(ad++))<$FF'c:=ios.ram_rdbyte(ad++)
                 if c>13
                    byte[@font][i++]:=c
    byte[@font][i]:=0
    return @font

PRI button(n,btext,x,y)
    buttonx[n]:=x
    buttony[n]:=y
    printfont(btext,colors[buttonhcol],0,colors[buttontextcol],x,y)

PRI Mouse_Release
    repeat while ios.mouse_button(0)                                             'warten bis Maustaste losgelassen wird

pri ausstieg
    ios.Mousepointer(hour_glass)
    'cmd_mount
    'activate_dirmarker(systemdir)
    'ios.sdopen("r",@regsys)
    'ios.ldbin(@regsys)
    ios.ld_rambin(2)

pri testfenster|a

    a:=0
    window(2,4,9,9,14,31,string("Filetransfer:"))
    rahmen(10,10,30,12)
    printdec_win(0,9,10)
    printdec_win(100,9,28)
    if was
       Send_File
    else
       Empfang_File
con '---------------------------------------------- Ausgaberoutinen ---------------------------------------------------------------------------------------------------------------
PRI Win_Tile(nu,ty,tx)
    ios.displaytile(nu,colors[winhcol],0,colors[act_color],ty,tx)

PRI print_message(stradr,x,y)
    printfont(stradr,colors[messagehcol],0,colors[messagetextcol],x,y)

PRI printdec_win(n,y,x)
    printdec(n,y,x,colors[winhcol],colors[act_color])

PRI Print_win(str,x,y)
    printfont(str,colors[winhcol],0,colors[act_color],x,y)
PRI print_titel(stradr,x,y)
    printfont(stradr,colors[titelhcol],0,colors[titeltextcol],x,y)
con'
PRI iniload|i,a
          a:=SETTING_RAM
          repeat i from 0 to 14
               colors[i]:=ios.Read_Flash_Data(a++)'ios.ram_rdbyte(a++)
          baud:=ios.Read_Flash_Data(a)'ios.ram_rdbyte(a++)                                             'Übertragungsrate serielles Terminal

          dcf_on:=ios.Read_Flash_Data(a+3)'ios.ram_rdbyte(a+2)

PRI  activate_dirmarker(mark)                                                   'USER-Marker setzen

     ios.sddmput(ios#DM_USER,mark)                                              'usermarker wieder in administra setzen
     ios.sddmact(ios#DM_USER)                                                   'u-marker aktivieren

PRI get_dirmarker:dm                                                            'USER-Marker lesen

    ios.sddmset(ios#DM_USER)
    dm:=ios.sddmget(ios#DM_USER)
PRI cmd_mount :err                                                              'cmd: mount

   repeat 16
       err:=ios.sdmount
       ifnot err
         mountmarker:=1
         quit

PRI cmd_unmount|err                                                             'cmd: unmount
  err:=ios.sdunmount
  ifnot err
        mountmarker:=0

PRI window(numm,cntrl,y,x,yy,xx,strg)                                           'ein Fenster erstellen

    windowx[numm]:=x-1
    windowy[numm]:=y-2
    windowxx[numm]:=xx+1
    windowyy[numm]:=yy+1

    ios.window(numm,0,colors[winhcol],0,colors[winframecol],colors[titelhcol],colors[titeltextcol],colors[hcolstatus],colors[statustextcol],y-2,x-1,yy+1,xx+1,cntrl,0)
    ios.printcursorrate(0)
    ios.printchar(12)                    'cls
    printfont(strg,colors[titelhcol],0,colors[titeltextcol],x,y-2)

PRI printfont(str1,a,b,c,d,e)|f

    repeat strsize(str1)
         f:= byte[str1++]
         if f >96
            f^=32
         f-=16                                                                  'anderer Zeichensatz, Zeichen um -16 Positionen versetzt
         if d>39                                                                'wenn Bildschirmrand erreicht, neue Zeile
            d:=0
            e++
         ios.displayTile(f,a,b,c,e,d)                                           'einzelnes Tile anzeigen   ('displayTile(tnr,pcol,scol,tcol, row, column))

         d++
PRI printdec(value,y,xx,hint,vor) | i ,c ,x                                     'screen: dezimalen zahlenwert auf bildschirm ausgeben
{{printdec(value) - screen: dezimale bildschirmausgabe zahlenwertes}}
 ' if value < 0                                                                 'negativer zahlenwert
 '   -value
    'printchar("-")

  i := 1_000_000_000
  repeat 10                                                                     'zahl zerlegen
    if value => i
      x:=value / i + "0"
      ios.displayTile(x-16,hint,0,vor,y,xx)                                     'printchar(x)
      xx++
      c:=value / i + "0"
      value //= i
      result~~
    elseif result or i == 1
      printfont(string("0"),hint,0,vor,xx,y)                                    'printchar("0")
      xx++
    i /= 10                                                                     'nächste stelle
con '************************************************** Button-Funktionen ********************************************************************************************************

PRI buttonpress(n)
    case n
         1:printfont(@butOK,250,0,0,buttonx[n],buttony[n])
         2:printfont(@Abbr,250,0,0,buttonx[n],buttony[n])

    Mouse_Release
    case n
         1:printfont(@butOK,colors[hcolstatus],0,colors[statustextcol],buttonx[n],buttony[n])
         2:printfont(@Abbr,colors[Buttonhcol],0,colors[buttontextcol],buttonx[n],buttony[n])



PRI rahmen(x,y,xx,yy)|i
    win_tile(137,y,x)
    win_tile(136,yy,x)
    win_tile(157,y,xx)
    win_tile(119,yy,xx)
    repeat i from y+1 to yy-1
           win_tile(2,i,x)
           win_tile(114,i,xx)
    line(x+1,y,xx-1)
    line(x+1,yy,xx-1)

PRI line(x,y,xx)|i
    repeat i from x to xx
            win_tile(130,y,i)

