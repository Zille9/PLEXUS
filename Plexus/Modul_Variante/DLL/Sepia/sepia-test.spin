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
Name            : Sepia-Testprogramm - Test der Funktionen der Sepia-IO-Card
Chip            : Regnatix
Typ             : Plexus-Erweiterungsdatei
Version         : 01
Subversion      : 02


Logbuch         :
'############################################### Version 1.0 ######################################################################################################################

02-11-2013      :-Erstellung der Optik des Testfensters
                 -erste Funktionalität integriert -> Digital-Port-Eingabe und Joystickabfrage funktioniert
                 -AD-Kanal-Werte als Balken und Zahlenwert ->funktioniert noch nicht, da noch kein Chip gesteckt ist
                 -6125 Longs frei

03-11-2013      :-Setzen und lesen der Digitalports funktioniert jetzt fehlerfrei (hoffentlich, werde es mit Tests beobachten)
                 -fehlt noch die AD-Port-Abfrage (noch kein PCF8591 vorhanden)
                 -6335 Longs frei

05-11-2013       -Portfunktionen und AD-Wandler-Kanäle io.
                 -fehlt noch die neu in TRIOS hinzugekommene Adressänderung der Ports
                 -6311 Longs frei

'############################################### Version 1.1 ######################################################################################################################
06-11-2013       -Adresseingabe und Änderung zur Laufzeit mit Hilfe von Drohne235 hinzugefügt
                 -Code von überflüssigen Teilen befreit
                 -Beenden Funktion mit Hinweisfenster ergänzt
                 -Programm soweit fertig, kann aber noch optimiert werden
                 -6268 Longs frei

08-11-2013       -Portadresswerte werden in sepia.ini gespeichert und beim Start geladen
                 -6255 Longs frei

12-11-2013       -Adressport-Scanner eingebaut, nun könnte man noch die Adressübernahme direkt aus dem Scannerfenster realisieren
                 -6081 Longs frei

13-11-2013       -Adressübernahme direkt aus dem Scanner-Fenster realisiert Taste "a" für AD Taste "d" für Digitalport drücken und auf die gewünschte Adresse klicken
                 -dadurch etwas Code gespart
                 -6124 Longs frei

'############################################### Version 1.2 ######################################################################################################################

20-11-2013       -Venatrix-Karte wird über den Venatrix-EEPROM (Adresse $50) am Sepia-I2C-Bus erkannt
                 -Eigenen I2C-Treiber in Venatrix eingebunden, Venatrix hat die Adresse 5 (beide Adressen werden im Scan-Fenster blau dargestellt)
                 -5918 Longs frei

22-11-2013       -Echtzeitscanner eingebaut, die I2C-Adressen werden jetzt im Scanner-Fenster zur Laufzeit aktualisiert, so ist jede Veränderung sofort sichtbar
                 -das Programm hat erst mal seinen Endstand erreicht und ist zur Veröffentlichung bereit
                 -noch etwas Codeoptimierung
                 -5985 Longs frei

11-12-2013       -Farbunterscheidung für Venatrix-karte im Scannerfenster verworfen, sonst wird bei nicht angeschlossener Venatrix falsch dargestellt
                 -5992 Longs frei

30-01-2014       -Anpassung an die neue reg.ios (window-Funktionen)
                 -6090 Longs frei

16-03-2014       -DCF-Indikator in Titelleiste eingebaut
                 -Code optimiert
                 -6055 Longs frei
}}

obj
    ios: "reg-ios-Modul"

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
TXT_RAM     = $20000
SETTING_RAM = $7FF00 'Hier stehen die System-Settings
BRAM      = $50000
'-------- Speicher für Systemfont ---------------
SYS_FONT  = $66800 '....$693FF      ' ab hier liegt der System-Font 11kb
Hour_Glass= $66800+(167*16*4)       ' Platz, wo das Sanduhrsymbol im Systemfont sitzt
MOUSE_RAM = $69400 '....$6943F      ' User-Mouse-Pointer 64byte

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

  byte mountmarker,tmptime
  long rootdir                     'root-Dirmarker
  long userdir                     'user-Dirmarker
  long systemdir                   'Plexus-Systemverzeichnis
  byte colors[15]                  'Farbwerte
  byte ma,mb                       'Maus-Tasten

  byte windowx[3]
  byte windowy[3]
  byte windowxx[3]
  byte windowyy[3]
  byte menuey[10]                  'y-Koordinate für Start-Menue-Einträge
  byte popupx,popupxx                      'x und
  byte popupy,popupyy                      'y-Koordinaten des Popupmenues
  byte popupmarker                 'Marker für Popupmenue
  byte PORT_IO[7]                  'In-Out-Richtungsmarker in=0 out=1
  byte PORT_BIT[8]                 'BIT-Wert-Marker
  byte port_bit_old[8]             'temp-puffer
  byte bitmuster[9]                'bit-muster puffer
  byte bitfarbe[9]
  byte bit_muster4[9],bit_muster5[9],bit_muster6[9]   'Ausgabe-Bitmuster der Digital-Ports
  byte ADDA_ADR,PORT_ADR
  byte infomarker
  byte buttonx[5],buttony[5]
  byte util
  byte timezaehler
    '----------- DCF-Indikator ------------------------------------
  byte dcf_on

dat
   regsys        byte "plexus.dll",0            'Reg.sys für Rückkehr aus externem Programm
   butOK         byte "  OK  ",0
   Abbr          byte "Cancel",0
   SYSTEM        Byte "PLEXUS      ",0          'Plexus-Systemverzeichnis

PUB main

    ios.start
    cmd_mount                                     'sd-card mounten
    mountmarker:=1                                  'mount-marker
    '--------------------------------------------------------------------------------------
    activate_dirmarker(0)
    ios.sdchdir(@system)
    systemdir:=get_dirmarker                        'Dir-Marker für System-Verzeichnis lesen

    '--------------------------------------------------------------------------------------
    cmd_unmount
    iniload                                          'Ini-Datei mit Farbwerten laden
    ADDA_ADR:=$48                                    'Standard-Portadressen vorbelegen
    PORT_ADR:=$20
    sepia_iniload                                    'sepia-ini datei lesen mit gespeicherten Portadressen
    ios.set_plxAdr(ADDA_ADR,PORT_ADR)                'Portadressen setzen
    ios.mousepointer(MOUSE_RAM)

    testfenster
    port_setting
    util:=0
    repeat

      os_cmdinput                           'Hauptprogrammschleife

PRI os_cmdinput | x,y ,i,dk,a,b,c,port,key,padr,durchlauf,kl

  repeat
    time                                                                                           'Zeit und Datum anzeigen

    ma:=ios.mouse_button(0)                                                                        'linke Maustaste
    mb:=ios.mouse_button(1)                                                                        'rechte Maustaste
    key:=ios.key
    if key
       ifnot key=="d" or key=="a"
             popup_info_weg
             util:=0
       case key
            F1_Key:Display_Help
            F2_Key:Adress_Scanner
            F12_Key:ausstieg
            ESC_KEY:popup_info_weg
            RETURN_KEY:popup_info_weg
            F3_Key:util:=0
                   Display_Info

    if infomarker==0
       Lese_register                                                                               'alle portregister lesen, wenn nicht das Scannerfenster angezeigt wird
    if util==1
       durchlauf++
       if durchlauf >100                                                                            'bei jedem 100ten Durchlauf wird gescannt, so bleibt genug Zeit für die restlichen Abfragen
          Scan
          durchlauf:=0
'***************************** linke Maustaste **********************************************************************
    if ma==255
       dk:=0
       x:=ios.mousex
       y:=ios.mousey
       kl:=ios.get_window//10
'****************************** Scannerfenster Aktionen ************************************************************
       if util==1
          if x=>12 and x=<27 and y=>11 and y=<18
             padr:=(x-12)+((y-11)*16)                    'angewählte Adresse berechnen
             if key=="a"                                 'Taste a für AD-Wandler-Adresse
                ADDA_ADR:=padr
                printhex(ADDA_ADR,2,21,5,colors[winhcol],colors[act_color])
             if key=="d"                                 'Taste d für DigitalPort-Adresse
                PORT_ADR:=padr
                printhex(PORT_ADR,2,32,5,colors[winhcol],colors[act_color])
             ios.set_plxAdr(ADDA_ADR,PORT_ADR)           'neue Adressen setzen


'****************************** Startmenue anzeigen ************************************************************
       if popupmarker==1
          if x>10 or y<24                                         'Menue loeschen, wenn man woanders hinklickt
             popup_info_weg
             util:=0
          if x=>0 and x=<10 and y=>24 and y=<28
             repeat i from 0 to 5
                 if menuey[i]==y
                    case i
                         0:menueselect(string("Scan  - F2"),menuey[i])
                           Adress_Scanner
                         1:menueselect(string("Help  - F1"),menuey[i])
                           Display_Help
                         2:menueselect(string("-EXIT- F12"),menuey[i])
                           ausstieg


'****************************** IO-Port-Fenster ****************************************************************
       if infomarker==0
          if x==32                                                  'Input Radio-Button
            case y
                 11:port_io[4]:=toogle_value(0,x,y)
                    port:=0
                    bytefill(@bit_muster4,0,9)
                 13:port_io[5]:=toogle_value(0,x,y)
                    port:=1
                    bytefill(@bit_muster5,0,9)
                 15:port_io[6]:=toogle_value(0,x,y)
                    port:=2
                    bytefill(@bit_muster6,0,9)
           ios.plxOut(PORT_ADR+port,255)                            'Port auf null setzen
           port_io[port+4]:=0                                       'Portwert auf null setzen

          if x==34                                                  'Output Radiobutton
             case y
                 11:port_io[4]:=toogle_value(1,x,y)
                 13:port_io[5]:=toogle_value(1,x,y)
                 15:port_io[6]:=toogle_value(1,x,y)

          if x=>23 and x=<30                                        'Portzustände
            if y==11 or y==13 or y==15
               a:=b:=c:=0
               case y
                    11:if port_io[4]==1
                          bit_muster4[30-x]:=toogle_bit(bit_muster4[30-x],x,y)
                          repeat i from 0 to 7
                                 a:=a+bit_muster4[i]<<(i)
                          port_bit[4]:=a
                          port:=0
                    13:if port_io[5]==1
                          bit_muster5[30-x]:=toogle_bit(bit_muster5[30-x],x,y)
                          repeat i from 0 to 7
                                 b:=b+bit_muster5[i]<<(i)
                          port_bit[5]:=b
                          port:=1
                    15:if port_io[6]==1
                          bit_muster6[30-x]:=toogle_bit(bit_muster6[30-x],x,y)
                          repeat i from 0 to 7
                                 c:=c+bit_muster6[i]<<(i)
                          port_bit[6]:=c
                          port:=2


               ios.plxOut(PORT_ADR+port,!port_bit[port+4])

'****************************** Globale Funktionstasten ********************************************************
       if(x=>buttonx[4]) and (x=<buttonx[4]+5) and (y==buttony[4]) and Infomarker==1     'ok im Infofenster
             buttonpress(4)
             popup_info_weg
             if util==1
                testfenster
                port_setting
                lese_register
                sepia_binsave
                util:=0
       if kl==1                                                  'doppelklick in linke obere ecke des Info-Fensters
             if doppelklick>1
                popup_info_weg
                util:=0
       if kl==2                                                  'Klick auf rechte obere Ecke
             popup_info_weg
             util:=0

       if y==0
          if (x==39)                                                           'Beenden-Knopf
             ios.displaytile(1,250,0,0,0,39)                                   'Schliessen-Symbol
             ausstieg

          if (x==0)                                                            'Beenden bei Doppelklick auf linke obere Ecke
             if doppelklick>1
                ausstieg
          if x>1 and x<16                                                      'Doppelklick in die Titelleiste
             if doppelklick>1
                popup_info_weg
                util:=0
                Display_Info

       if ((x=>0) and (x=<5)) and (y==29)                                   'Start-Knopf
          buttonpress(1)
          if popupmarker==1
             popup_info_weg
             util:=0

          else
             if infomarker==1
                popup_info_weg
                util:=0
             startmenue
             popupmarker:=1

PRI Display_Help
    infofenster(5,10,34,17,string("Help"),1)          'Info-Fenster anzeigen
    Print_win(string("Change Adress:"),5,10)
    Print_win(string("Choose Start -> Scan,"),5,11)
    Print_win(string("Press and hold -a- for AD-Port"),5,12)
    Print_win(string("or -d- for Digital-Port and"),5,13)
    Print_win(string("click on the Adress do you"),5,14)
    Print_win(string("want!"),5,15)

PRI Display_Info
    infofenster(9,10,31,15,string("Program-Info"),1)          'Info-Fenster anzeigen
    Print_win(string("Sepia-Test for Hive"),9,10)
    Print_win(string("Version 1.3 - 01/2014"),9,11)
    Print_win(string("Autor:R.Zielinski"),9,12)
    Print_win(string("Hive-Project.de"),9,13)

PRI Adress_Scanner|a,ack,z,vx
    infofenster(9,10,29,20,string("Adress-Scanner"),1)          'Info-Fenster anzeigen
    util:=1
    Print_win(string("0123456789ABCDEF"),12,10)
    Scan

pri SCAN|ack,a,z,vx
    z:=11    'Zeile
    vx:=12
    ios.plxhalt
    repeat a from 0 to 127
        ack:=ios.plxping(a)
        if vx==12
           printhex(a,2,10,z,colors[winhcol],colors[act_color])

        if ack
           ios.displaytile(Cog_pic,colors[winhcol],green,0,z,vx++)  'unbelegte Adressen
        else
              ios.displaytile(Cog_pic,colors[winhcol],red,0,z,vx++) 'belegte Adressen anzeigen

        if vx>27
           vx:=12
           z++

    ios.plxrun
PRI infofenster(x,y,xx,yy,strg,knopf)'|i

    ios.backup_area(x-1,y-2,xx+1,yy+1,BRAM)               'Hintergrund sichern
    window(2,4,y,x,yy,xx,strg)                            'Fenster erstellen
    if knopf==1
       button(4,@butOK,((xx-x)/2)+x-2,yy)                 'Button 4 gibt es nur im SD-Card-Info-Fenster
    if knopf==2
       button(2,@Abbr,((xx-x)/2)+x-2,yy)
    infomarker:=1

PRI button(n,btext,x,y)
    buttonx[n]:=x
    buttony[n]:=y
    printfont(btext,colors[buttonhcol],0,colors[buttontextcol],x,y)

PRI Mouse_Release
    repeat while ios.mouse_button(0)                                             'warten bis Maustaste losgelassen wird

pri ausstieg
    'ios.display3DBox(255, colors[winhcol], 0, 12, 8, 14, 28)
    'Print_win(string("Return to Plexus..."),9,13)
    ios.mousepointer(hour_glass)
    'cmd_mount
    'activate_dirmarker(systemdir)
    'ios.sdopen("r",@regsys)
    'ios.ldbin(@regsys)
    ios.ld_rambin(2)

pri toogle_bit(value,vx,vy):wert
    Mouse_Release                         'warten bis maustaste losgelassen wird
    if value==0
       ios.displaytile(Cog_pic,colors[winhcol],red,0,vy,vx)
       wert:=1
    if value==1
       ios.displaytile(Cog_pic,colors[winhcol],green,0,vy,vx)
       wert:=0


pri lese_register|i
    repeat i from 0 to 6
          PORT_BIT[i]:=!ios.getreg(i)

    zeige_register

pri zeige_register|i,b,c,a

    repeat i from 0 to 6
          if port_io[i]==0          'Port auf Eingang?
             c:=port_bit[i]
             c <<= 32 - 8
             repeat b from 1 to 8
                  bitmuster[b]:=(c <-= 1) & 1 '+ "0"
                  if bitmuster[b]==0
                     bitfarbe[b]:=green
                  else
                     bitfarbe[b]:=red
             if port_bit[i]<>port_bit_old[i]                                       'nur geänderte werte anzeigen
                case i
                     0:balken(port_bit[0],21)
                     1:balken(port_bit[1],22)
                     2:balken(port_bit[2],23)
                     3:balken(port_bit[3],24)
                     4:Show_Joybit(bitfarbe[8],10,6) 'hoch
                       Show_Joybit(bitfarbe[6],11,5) 'links
                       Show_Joybit(bitfarbe[5],11,7) 'rechts
                       Show_Joybit(bitfarbe[7],12,6) 'runter
                       Show_Joybit(bitfarbe[4],14,6) 'feuer
                       repeat a from 1 to 8
                             Show_Joybit(bitfarbe[a],11,23+a-1)    'Port-Icon
                     5:Show_Joybit(bitfarbe[8],10,14)
                       Show_Joybit(bitfarbe[6],11,13)
                       Show_Joybit(bitfarbe[5],11,15)
                       Show_Joybit(bitfarbe[7],12,14)
                       Show_Joybit(bitfarbe[4],14,14)
                       repeat a from 1 to 8
                             Show_Joybit(bitfarbe[a],13,23+a-1)    'Port-Icon
                     6:repeat a from 1 to 8
                             Show_Joybit(bitfarbe[a],15,23+a-1)    'Port-Icon
             port_bit_old[i]:=port_bit[i]



pri balken(pwert,y)|light,x

    light:=pwert*25/255
    repeat x from 0 to light
          ios.displaytile(129,colors[winhcol],colors[winhcol],colors[act_color],y,x+5) 'Wertebalken

    repeat x from light+5 to 30
          ios.displaytile(129,colors[winhcol],colors[winhcol],colors[winhcol],y,x)     'Balken nach dem Wertebalken

    Print_win(string("   "),32,y)                  'AD-Wert löschen
    printdec(pwert,y,32,colors[winhcol],colors[act_color])                             'neuen AD-Wert schreiben

pri toogle_value(tg,tx,ty)
    if tg==0
       ios.displaytile(138,colors[winhcol],colors[winhcol],colors[act_color],ty,tx)
       ios.displaytile(Cog_pic,colors[winhcol],colors[winhcol],colors[act_color],ty,tx+2)
       return 0
    if tg==1
       ios.displaytile(Cog_pic,colors[winhcol],colors[winhcol],colors[act_color],ty,tx-2)
       ios.displaytile(138,colors[winhcol],colors[winhcol],colors[act_color],ty,tx)
       return 1

pri port_setting|i,b
    b:=0
    repeat i from 4 to 6
           port_io[i]:=0
           ios.displaytile(138,colors[winhcol],colors[winhcol],colors[act_color],11+i-4+b,32)       'Digital-Ports IN anzeigen
           ios.displaytile(Cog_pic,colors[winhcol],colors[winhcol],colors[act_color],11+i-4+b,34)   'Radiobutton OUT
           b++

pri Show_Joybit(farbe,y,x)
    ios.displaytile(COG_PIC,colors[winhcol],farbe,0,y,x)

pri testfenster|i,y,a

    a:=0
    window(0,4,2,1,27,38,string("I/O-Card-Test"))
    rahmen (1,6,38,27)
    rahmen (1,1,38,3)
    rahmen (1,4,38,6)
    rahmen (3,8,18,18)
    rahmen (21,8,36,18)
    rahmen (3,19,36,26)
    ios.displaytile(133,colors[winhcol],colors[winhcol],colors[act_color],6,1)   'Rahmen-Verbindungsstücke
    ios.displaytile(117,colors[winhcol],colors[winhcol],colors[act_color],6,38)
    Print_win(string("Sepia-Test for Hive-Computer V1.2"),4,2)
    Print_win(string("Adress  AD-Port:$   D-Port:$"),4,5)
    printhex(ADDA_ADR,2,21,5,colors[winhcol],colors[act_color])
    printhex(PORT_ADR,2,32,5,colors[winhcol],colors[act_color])

                                               'y,x
    Show_Joybit(green,10,6)
    Show_Joybit(green,11,5)
    Show_Joybit(green,11,7)
    Show_Joybit(green,12,6)

    Show_Joybit(green,14,6)

    Print_win(string("Port 1"),4,16)

    Show_Joybit(green,10,14)
    Show_Joybit(green,11,13)
    Show_Joybit(green,11,15)
    Show_Joybit(green,12,14)

    Show_Joybit(green,14,14)

    Print_win(string("Port 2"),12,16)

    Print_win(string("Joystick-Test"),4,8)
    Print_win(string("Digital-Ports"),22,8)
    Print_win(string("A/D-Channels"),4,19)

    repeat y from 0 to 5 step 2

       repeat i from 0 to 7
           if y==0
              printdec(7-i,10,23+i,colors[winhcol],colors[act_color])      'Port-Bits
           printdec(a+1,11+y,22,colors[winhcol],colors[act_color])       'Port Nr
           Show_Joybit(green,11+y,23+i)    'Port-Icon
       a++
    Print_win(string("I"),32,10)

    Print_win(string("O"),34,10)

    repeat i from 0 to 3
           printdec(i,21+i,4,colors[winhcol],colors[act_color])       'Port Nr der AD-Kanäle

PRI Print_win(str,x,y)
    printfont(str,colors[winhcol],0,colors[act_color],x,y)

PRI printhex(value, digits,x,y,back,vor)|wert                             'screen: hexadezimalen zahlenwert auf bildschirm ausgeben
{{hex(value,digits) - screen: hexadezimale bildschirmausgabe eines zahlenwertes}}
  value <<= (8 - digits) << 2
  repeat digits
    wert:=lookupz((value <-= 4) & $F : "0".."9", "A".."F")
    ios.displaytile(wert-16,back,0,vor,y,x++)

con'****************************************************** Datum und Zeitanzeige *************************************************************************************************

PRI time|s                             'Zeitanzeige in der Statusleiste
    timezaehler++
    if timezaehler>50
       timezaehler:=0
       s:=ios.getminutes
       'Status_extern(ios.dcf_sync,dcf_on,170,34,29,green,black)                                         'Anzeige des aktuellen Status in der Titelzeile
       if s<>tmptime
          displaytime

PRI displaytime|h,m

       h:=ios.gethours
       m:=ios.getminutes

        print_zehner(h,29,35,colors[hcolstatus],colors[statustextcol])
        ios.displaytile(42,colors[hcolstatus],0,colors[statustextcol],29,37)

        print_zehner(m,29,38,colors[hcolstatus],colors[statustextcol])
        tmptime:=m
        date

PRI date

        print_zehner(ios.getdate,0,29,colors[titelhcol],colors[titeltextcol])
        ios.displaytile(30,colors[titelhcol],0,colors[titeltextcol],0,31)

        print_zehner(ios.getmonth,0,32,colors[titelhcol],colors[titeltextcol])
        ios.displaytile(30,colors[titelhcol],0,colors[titeltextcol],0,34)
        printdec(ios.getyear,0,35,colors[titelhcol],colors[titeltextcol])

pri print_zehner(wert,y,x,hin,vor)|a
    a:=0
    if wert<10
       printdec(0,y,x,hin,vor)
       a:=1
    printdec(wert,y,x+a,hin,vor)

pri Status_extern(wert1,wert2,tnr_act,x,y,col,f3)

       if wert1==1
          ios.displaytile(tnr_act,colors[hcolstatus],col,f3,y,x)                                                       'Status ok-anzeigen
       else
          if wert2                                                                                                    'Externe Komponente in Settingmenue ausgewählt?
             ios.displaytile(tnr_act,colors[hcolstatus],grey,0,y,x)                                                    'Symbol grau
          else
             ios.displaytile(16,colors[hcolstatus],colors[statustextcol],0,y,x)                                         'Ohne externe Komponente arbeiten (kein Symbol)

con'
PRI doppelklick:click                            'pseudo-doppelklick
    click:=0
    Mouse_Release

    repeat 500
        if ios.mouse_button(0)==255
           click++
con'
PRI iniload|i,a
          a:=SETTING_RAM
          repeat i from 0 to 14
               colors[i]:=ios.ram_rdbyte(a++)
          dcf_on:=ios.ram_rdbyte(a+3)

PRI  activate_dirmarker(mark)                       'USER-Marker setzen

     ios.sddmput(ios#DM_USER,mark)                  'usermarker wieder in administra setzen
     ios.sddmact(ios#DM_USER)                      'u-marker aktivieren

PRI get_dirmarker:dm                                'USER-Marker lesen

    ios.sddmset(ios#DM_USER)
    dm:=ios.sddmget(ios#DM_USER)

PRI cmd_mount :err                                     'cmd: mount

   repeat 16
       err:=ios.sdmount
       ifnot err
         mountmarker:=1
         quit
       else
        ' display_error(err)
         quit

PRI cmd_unmount|err                                         'cmd: unmount
  err:=ios.sdunmount
  ifnot err
        mountmarker:=0
  else
        'display_error(err)

PRI window(num,cntrl,y,x,yy,xx,strg)|i                         'ein Fenster erstellen

    windowx[num]:=x-1
    windowy[num]:=y-2
    windowxx[num]:=xx+1
    windowyy[num]:=yy+1
    ios.window(num,0,colors[winhcol],0,colors[winframecol],colors[titelhcol],colors[titeltextcol],colors[hcolstatus],colors[statustextcol],y-2,x-1,yy+1,xx+1,cntrl,0)
    ios.printcursorrate(0)
    ios.printchar(12)                    'cls
    'windownum[num]:=1
    printfont(strg,colors[titelhcol],0,colors[titeltextcol],x+1,y-2)

PRI printfont(str1,a,b,c,d,e)|f

    repeat strsize(str1)
         f:= byte[str1++]
         if f >96
            f^=32
         f-=16                              'anderer Zeichensatz, Zeichen um -16 Positionen versetzt
         if d>39                            'wenn Bildschirmrand erreicht, neue Zeile
            d:=0
            e++
         ios.displayTile(f,a,b,c,e,d)       'einzelnes Tile anzeigen   ('displayTile(tnr,pcol,scol,tcol, row, column))

         d++
PRI printdec(value,y,xx,hint,vor) | i ,c ,x                             'screen: dezimalen zahlenwert auf bildschirm ausgeben
{{printdec(value) - screen: dezimale bildschirmausgabe zahlenwertes}}
 ' if value < 0                                          'negativer zahlenwert
 '   -value
    'printchar("-")

  i := 1_000_000_000
  repeat 10                                             'zahl zerlegen
    if value => i
      x:=value / i + "0"
      ios.displayTile(x-16,hint,0,vor,y,xx)                'printchar(x)
      xx++
      c:=value / i + "0"
      value //= i
      result~~
    elseif result or i == 1
      printfont(string("0"),hint,0,vor,xx,y)                 'printchar("0")
      xx++
    i /= 10                                             'nächste stelle
con '************************************************** Button-Funktionen ********************************************************************************************************

PRI buttonpress(n)
    case n
         1:printfont(string("Start  "),250,0,0,0,29)
           ios.displaytile(144,colors[shellhcol],250,colors[shellhcol],29,7)
         4:printfont(@butOK,250,0,0,buttonx[n],buttony[n])

    Mouse_Release
    case n
         1:printfont(string("Start  "),colors[hcolstatus],0,colors[statustextcol],0,29)
           ios.displaytile(144,colors[shellhcol],colors[hcolstatus],colors[shellhcol],29,7)
         4:printfont(@butOK,colors[Buttonhcol],0,colors[buttontextcol],buttonx[n],buttony[n])


con '*************************************************** Start-Menue *************************************************************************************************************
PRI Menue(x,y,xx,yy)|i
    popup(x,y,xx,yy)
    repeat i from x to xx
        ios.displaytile(16,colors[Titelhcol],$ff,$ff,y-1,i)

PRI separator(x,y,xx)|i
    repeat i from x to xx
         ios.displaytile(6,colors[Messagehcol],0,colors[winframecol],y,i)

PRI menueselect(stri,y)
    printfont(stri,colors[messagetextcol],0,colors[messagehcol],0,y)
    Mouse_Release
    printfont(stri,colors[messagehcol],0,colors[messagetextcol],0,y)
    popup_info_weg

PRI Startmenue
    menue(0,24,9,28)
    printfont(string("Startmenue"),colors[titelhcol],0,colors[titeltextcol],0,23)

    printfont(string("Scan  - F2"),colors[messagehcol],0,colors[messagetextcol],0,24)
    menuey[0]:=24
    printfont(string("Help  - F1"),colors[messagehcol],0,colors[messagetextcol],0,25)
    menuey[1]:=25
    separator(0,26,9)

    printfont(string("-EXIT- F12"),colors[messagehcol],0,colors[messagetextcol],0,27)
    menuey[2]:=27
con '*************************************************** Popup-Menue *************************************************************************************************************

PRI popup(x,y,xx,yy)
    popupx:=x
    popupy:=y-1
    popupyy:=yy
    popupxx:=xx
    ios.backup_area(popupx,popupy,popupxx,popupyy,BRAM)
    ios.display2dbox(colors[messagehcol],y,x,yy,xx,0)

PRI Popup_Info_weg
          if popupmarker==1                                                        'Popupmenue sichtbar?
             ios.restore_area(popupx,popupy,popupxx,popupyy,BRAM)                          'Hintergrund wiederherstellen
             popupmarker:=0                                                        'Popupmarker loeschen
          if infomarker==1
             ios.restore_area(windowx[2],windowy[2],windowxx[2],windowyy[2],BRAM)                          'Hintergrund wiederherstellen
             infomarker:=0
             ios.windel(2)

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

con '---------------------------------------------- Ausgaberoutinen ---------------------------------------------------------------------------------------------------------------
PRI Win_Tile(nu,ty,tx)
    ios.displaytile(nu,colors[winhcol],0,colors[act_color],ty,tx)

pri sepia_binsave
    cmd_mount
    activate_dirmarker(systemdir)
    ios.sddel(@sepia_ini)
    ios.sdnewfile(@sepia_ini)
    ios.sdopen("W",@sepia_ini)
    ios.sdputc(ADDA_ADR)
    ios.sdputc(PORT_ADR)
    ios.sdclose
    cmd_unmount

pri sepia_iniload|e
    cmd_mount
    activate_dirmarker(systemdir)
    e:=ios.sdopen("R",@sepia_ini)                                          'datei öffnen
    ifnot e
         ADDA_ADR:=ios.sdgetc
         PORT_ADR:=ios.sdgetc
         ios.sdclose
    cmd_unmount

DAT

sepia_ini byte "sepia.ini",0

