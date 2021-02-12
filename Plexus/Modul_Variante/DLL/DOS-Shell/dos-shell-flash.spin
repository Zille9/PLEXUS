{{
┌──────────────────────────────────────────────────────────────────────────────────────────────────────┐
│ Autor: Ingo Kripahle                                                                                 │
│ Copyright (c) 2010 Ingo Kripahle                                                                     │
│ See end of file for terms of use.                                                                    │
│ Die Nutzungsbedingungen befinden sich am Ende der Datei                                              │
└──────────────────────────────────────────────────────────────────────────────────────────────────────┘

Informationen   : hive-project.de
Kontakt         : drohne235@googlemail.com
System          : TriOS
Name            : Regime
Chip            : Regnatix
Typ             : Programm
Version         : 00
Subversion      : 02

Funktion        : "Regime" ist ein einfacher Kommandozeileninterpreter.

Logbuch         :

22-03-2010-dr235  - anpassung trios
10-04-2010-dr235  - alternatives dir-marker-system eingefügt
17-04-2010-dr235  - dm-user wird jetzt auch beim start aus dem aktuellen dir gesetzt
30-04-2010-dr235  - mount robuster gestaltet
19-09-2010-dr235  - integration ramdisk
                  - kommandos: xdir, xdel, xrename, xload, xsave, xtype
20-09-2010-dr235  - blocktransfer für xload/xsave (wesentlich bessere geschwindigkeit!!!)



25-02-2014        - Integration von Regime in Plexus begonnen -> soll die DOS-Shell von Plexus werden

28-02-2014        - optische Anpassung an Plexus, Handling entsprechend angepasst (Fenster und Menues)
                  - Ram-Disk-Funktionen entfernt (Plexus benutzt den Ram, daher keine Ram-Disk Funktion möglich)
                  - Funktionen aus Perplex (Sepia-Karten-Funktionen) übernommen und an die neuen Administra-Sepia-Funktionen angepasst
                  - 4528 Longs frei

16-03-2014        -DCF-Indikator in Titelleiste eingebaut
                  -4501 Longs frei

29-03-2014        -Fehler im Aufruf der Hilfe-Funktion behoben, durch das Plexus-Verzeichnis wurde die Hilfe-Datei nicht mehr gefunden
                  -dies wurde durch Setzen des Systemdirmarkers behoben
                  -4473 Longs frei

18-05-2014        -direkter Start von Basic-Dateien (.BAS) über Runtime-Modul möglich, dabei ist die Dateiendung wegzulassen
                  -4480 Longs frei
}}

OBJ
        ios: "reg-ios-Modul"
        str: "glob-string"
        numm: "glob-numbers"
        sdspi :"glob-sdspi"

CON

_CLKMODE     = XTAL1 + PLL16X
_XINFREQ     = 5_000_000

OS_TIBLEN       = 64                                    'größe des inputbuffers
OS_MLEN         = 8
ERAM            = 1024 * 512 * 2                        'größe eram
HRAM            = 1024 * 32                             'größe hram

RMON_ZEILEN     = 16                                    'speichermonitor - angezeigte zeilen
RMON_BYTES      = 8                                     'speichermonitor - zeichen pro byte

TILE_RAM  = $40000 '....$67FFF      ' hier beginnt der Tile-Speicher fuer 10 Tiledateien
SYS_FONT  = $50000 '....$52BFF      ' ab hier liegt der System-Font 11kb
Hour_Glass= $50000+(167*16*4)       ' Platz, wo das Sanduhrsymbol im Systemfont sitzt
MOUSE_RAM = $52C00 '....$52C3F      ' User-Mouse-Pointer 64byte
HELP_ROM  = $108000
'******************Farben ********************************************************
  #$FC, Light_Grey, #$A8, Grey, #$54, Dark_Grey
  #$C0, Light_Red, #$80, Red, #$40, Dark_Red
  #$30, Light_Green, #$20, Green, #$10, Dark_Green
  #$1F, Light_Blue, #$09, Blue, #$04, Dark_Blue
  #$F0, Light_Orange, #$E6, Orange, #$92, Dark_Orange
  #$CC, Light_Purple, #$88, Purple, #$44, Dark_Purple
  #$3C, Light_Teal, #$28, Teal, #$14, Dark_Teal
  #$FF, White, #$00, Black

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
SETTING_RAM = $100000 'Hier stehen die System-Settings
BRAM        = $40000

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
CON ''------------------------------------------------- BELLATRIX
DCOL       = 8               'dump spaltenzahl
DROW       = 16              'dump zeilenzahl
PAGESIZE   = 32
BUFFERSIZE = DCOL * DROW
LO_EEPROM  = $0
HI_EEPROM  = $8000
IMAGESIZE  = $8000           'größe eines rom-images

VAR
'systemvariablen
  byte tib[OS_TIBLEN]           'tastatur-input-buffer
  byte cmdstr[OS_TIBLEN]        'kommandostring für interpreter
  byte token1[OS_TIBLEN]        'parameterstring 1 für interpreter
  byte token2[OS_TIBLEN]        'parameterstring 2 für interpreter
  byte tibpos                   'aktuelle position im tib
  byte rows                     'aktuelle anzahl der nutzbaren zeilen
  byte cols                     'aktuelle Anzahl der nutzbaren spalten
  byte cog[8]                   'array for free-cog counter
'  byte act_color                'Speicher für gewählte zeichenfarbe
  long startadresse[16]         'startadresse des tiles im eram
  byte xtiles[16]               'xtiles fuer tilenr        '
  byte ytiles[16]               'ytiles fuer tilenr
  byte str0                     'String fuer Fontfunktion in Fenstern
  byte aktuellestileset         'nummer des aktuellen tilesets
  byte mountmarker,tmptime
  byte windowx[3]
  byte windowy[3]
  byte windowxx[3]
  byte windowyy[3]
  byte menuey[10]                  'y-Koordinate für Start-Menue-Einträge
  byte popupx,popupxx                      'x und
  byte popupy,popupyy                      'y-Koordinaten des Popupmenues
  byte popupmarker                 'Marker für Popupmenue

  long rootdir                     'root-Dirmarker
  long userdir                     'user-Dirmarker
  byte colors[15]                  'Farbwerte
  byte ma,mb                       'Maus-Tasten
  byte infomarker
  byte buttonx[5],buttony[5]
  byte util
  '----------- Venatrix Variablen -------------------------------
  byte venatrix                     'Venatrix-Marker
  '----------- Sepia Variablen ----------------------------------
  byte sepia                        'Sepia-Marker

  byte  device                  'adresse des geöffneten devices
  byte  polling                 'status polling
  byte  open                    'status device

  long systemdir                'system-Dirmarker
  byte timezaehler

    '----------- DCF-Indikator ------------------------------------
  byte dcf_on
  '----------------------- EEPROM Variablen ---------------------------------------------------------------
  long      ioControl[2]
  byte      buffer[BUFFERSIZE]

dat
   root          byte "..",0
   regsys        byte "plexus.dll",0            'Reg.sys für Rückkehr aus externem Programm
   butOK         byte "  OK  ",0
   Abbr          byte "Cancel",0
   SYSTEM        Byte "PLEXUS      ",0          'Plexus-Systemverzeichnis
   BAS_RT        Byte "basrun.dll",0
PUB main | flag ,a,x,y,i,d

    ios.start
    ios.sdmount                                      'sd-card mounten
    activate_dirmarker(0)                            'ins root
    ios.sdchdir(@system)                             'System-Verzeichnis lesen
    systemdir:=get_dirmarker                         'Dir-Marker lesen

    iniload
    ios.mousepointer(MOUSE_RAM)
    testfenster
    ios.printCursorRate(3)

  sdspi.start(@iocontrol)                               'spi-treiber starten

  mountmarker:=1
  ios.sddmact(ios#DM_ROOT)                              'wieder in userverzeichnis wechseln
  rows := 30'ios.belgetrows                             'zeilenzahl bei bella abfragen
  cols := 40'ios.belgetcols                             'spaltenzahl bei bella abfragen

  ios.setpos(28,0)
  ios.print(@prompt1)
  repeat

    os_cmdinput                                         'kommandoeingabe
    os_cmdint                                           'kommandozeileninterpreter

pri testfenster|i,y,a

    window(1,3,2,1,27,38,string("DOS-Shell"))

PRI window(num,cntrl,y,x,yy,xx,strg)|i                         'ein Fenster erstellen

    windowx[num]:=x-1
    windowy[num]:=y-2
    windowxx[num]:=xx+1
    windowyy[num]:=yy+1

    ios.window(num,0,colors[winhcol],0,colors[winframecol],colors[titelhcol],colors[titeltextcol],colors[hcolstatus],colors[statustextcol],y-2,x-1,yy+1,xx+1,cntrl,0)
    ios.printcursorrate(0)
    ios.printchar(12)                    'cls
    printfont(strg,colors[titelhcol],0,colors[titeltextcol],x,y-2)
    ios.printBoxColor(1,colors[act_color],colors[winhcol],0)


con'
PRI doppelklick:click                            'pseudo-doppelklick
    click:=0
    ios.get_window
    'Mouse_Release

    repeat 800
        if ios.mouse_button(0)==255
           click++

con'
PRI iniload|i,a
          a:=SETTING_RAM
          repeat i from 0 to 14
               colors[i]:=ios.Read_Flash_Data(a++)'ram_rdbyte(a++)
          dcf_on:=ios.Read_Flash_Data(a+3)'ram_rdbyte(a+3)

PRI  activate_dirmarker(mark)                       'USER-Marker setzen

     ios.sddmput(ios#DM_USER,mark)                  'usermarker wieder in administra setzen
     ios.sddmact(ios#DM_USER)                      'u-marker aktivieren

PRI get_dirmarker:dm                                'USER-Marker lesen

    ios.sddmset(ios#DM_USER)
    dm:=ios.sddmget(ios#DM_USER)

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

PRI Print_win(strg,x,y)
    printfont(strg,colors[winhcol],0,colors[act_color],x,y)

PRI printhex(value, digits,x,y,back,vor)|wert                             'screen: hexadezimalen zahlenwert auf bildschirm ausgeben
{{hex(value,digits) - screen: hexadezimale bildschirmausgabe eines zahlenwertes}}
  value <<= (8 - digits) << 2
  repeat digits
    wert:=lookupz((value <-= 4) & $F : "0".."9", "A".."F")
    ios.displaytile(wert-16,back,0,vor,y,x++)

PRI Display_Info
    infofenster(9,10,33,15,string("Program-Info"),1)          'Info-Fenster anzeigen
    Print_win(string("Plexus-DOS-Shell for Hive"),9,10)
    Print_win(string("Version 1.0 - 02/2014"),9,11)
    Print_win(string("Autor:R.Zielinski"),9,12)
    Print_win(string("Hive-Project.de"),9,13)

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
con '************************************************** Button-Funktionen ********************************************************************************************************

PRI buttonpress(n)
    case n
         1:printfont(string("Start  "),250,0,0,0,29)
           ios.displaytile(144,colors[shellhcol],250,colors[shellhcol],29,7)

           'ios.displaytile(164,0,colors[shellhcol],250,29,7)

         4:printfont(@butOK,250,0,0,buttonx[n],buttony[n])

    Mouse_Release
    case n
         1:printfont(string("Start  "),colors[hcolstatus],0,colors[statustextcol],0,29)
           ios.displaytile(144,colors[shellhcol],colors[hcolstatus],colors[shellhcol],29,7)

           'ios.displaytile(164,0,colors[shellhcol],colors[hcolstatus],29,7)
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

    printfont(string("Info  - F2"),colors[messagehcol],0,colors[messagetextcol],0,24)
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
    ios.printCursorRate(0)
    ios.backup_area(popupx,popupy,popupxx,popupyy,BRAM)
    ios.display2dbox(colors[messagehcol],y,x,yy,xx,0)

PRI Popup_Info_weg
          if popupmarker==1                                                        'Popupmenue sichtbar?
             ios.restore_area(popupx,popupy,popupxx,popupyy,BRAM)                          'Hintergrund wiederherstellen
             popupmarker:=0                                                        'Popupmarker loeschen
          if infomarker==1
             ios.restore_area(windowx[2],windowy[2],windowxx[2],windowyy[2],BRAM)                          'Hintergrund wiederherstellen
             infomarker:=0
          ios.printwindow(1)
          ios.setpos(28,0)
          ios.printCursorRate(3)

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
PRI Mouse_Release
    repeat while ios.mouse_button(0)                                             'warten bis Maustaste losgelassen wird

con '---------------------------------------------- Ausgaberoutinen ---------------------------------------------------------------------------------------------------------------
PRI Win_Tile(nu,ty,tx)
    ios.displaytile(nu,colors[winhcol],0,colors[act_color],ty,tx)

CON ''------------------------------------------------- INTERPRETER

PUB os_cmdinput | charc ,a,status,k,dk,x,y,i                                'sys: stringeingabe eine zeile
''funktionsgruppe               : sys
''funktion                      : stringeingabe eine zeile
''eingabe                       : -
''ausgabe                       : -
''variablen                     : tib     - eingabepuffer zur string
''                              : tibpos  - aktuelle position im tib

  ios.print(@prompt3)
  tibpos := 0
  repeat                                         'tibposition auf anfang setzen

    ma:=ios.mouse_button(0)
    time
    charc:=ios.key
    if charc
       if charc==F12_Key
          cmd_exit
       if charc==F1_Key
          cmd_help
          charc:=return_key
       if charc==F2_Key
          Display_Info

       if charc==ESC_KEY or charc==RETURN_KEY
          if infomarker==1
             popup_info_weg
          charc:=return_key

       ifnot infomarker                                    'keine Eingabe bei Anzeige des Info-Fensters
          if (tibpos + 1) < OS_TIBLEN                         'zeile noch nicht zu lang?
            case charc
              ios#BEL_BS:                                    'backspace
                if tibpos > 0                                 'noch nicht anfang der zeile erreeicht?
                   tib[tibpos--] := 0                          'ein zeichen aus puffer entfernen
                   ios.printbs                                 'backspace an terminal senden
              other:                                          'zeicheneingabe
                if charc==$0D
                   quit
                else
                   tib[tibpos++] := charc                        'zeichen speichern
                   ios.printchar(charc)                          'zeichen ausgeben

'***************************** linke Maustaste **********************************************************************
    if ma==255
       dk:=0
       x:=ios.mousex
       y:=ios.mousey


'****************************** Startmenue anzeigen ************************************************************
       if popupmarker==1
          if x>10 or y<24                                         'Menue loeschen, wenn man woanders hinklickt
             popup_info_weg
          if x=>0 and x=<10 and y=>24 and y=<28
             repeat i from 0 to 5
                 if menuey[i]==y

                    case i
                         0:menueselect(string("Info  - F2"),menuey[i])
                           Display_Info
                         1:menueselect(string("Help  - F1"),menuey[i])
                           cmd_help
                         2:menueselect(string("-EXIT- F12"),menuey[i])
                           cmd_exit



'****************************** Globale Funktionstasten ********************************************************
       if(x=>buttonx[4]) and (x=<buttonx[4]+5) and (y==buttony[4]) and Infomarker==1     'ok im Infofenster
             buttonpress(4)
             popup_info_weg
             quit


       if y==windowy[2] and x==windowx[2] and Infomarker==1                     'doppelklick in linke obere ecke des Info-Fensters
          if doppelklick>1
             popup_info_weg

       if y==windowy[2] and x==windowxx[2] and Infomarker==1
          ios.get_window
          popup_info_weg

       if y==0
          if (x==39)                                                           'Beenden-Knopf
             ios.displaytile(1,250,0,0,0,39)                                   'Schliessen-Symbol
             Mouse_Release                                                     'warten bis Maustaste losgelassen wird
             ios.displaytile(1,colors[winhcol],0,colors[winframecol],0,39)     'Schliessen-Symbol
             cmd_exit

          if (x==0)                                                            'Beenden bei Doppelklick auf linke obere Ecke
             if doppelklick>1
                cmd_exit
          if x>1 and x<20                                                      'Doppelklick in die Titelleiste
             if doppelklick>1
                popup_info_weg
                Display_Info

       if ((x=>0) and (x=<5)) and (y==29)                                   'Start-Knopf
          buttonpress(1)
          if popupmarker==1
             popup_info_weg
             ios.printwindow(1)

          else
             if infomarker==1
                popup_info_weg
             startmenue
             popupmarker:=1

  ios.printnl
  tib[tibpos] := 0                                      'string abschließen
  tibpos := charc := 0                                  'werte rücksetzen

con'****************************************************** Datum und Zeitanzeige *************************************************************************************************

PRI time|s                             'Zeitanzeige in der Statusleiste
    timezaehler++
    if timezaehler>150
       timezaehler:=0
       'ios.ReadClock
       show_time

pri show_time |s
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

con'****************************************************** Perplex-Funktionen *************************************************************************************************
PRI plx_map|ack,adr,n,i

  ios.plxHalt
  n := 0
  i := 0
  ios.printcursorrate(0)
  ios.printcls
  repeat
    ios.setpos(0,0)
    ios.printnl
    ios.print(string("   0123456789ABCDEF"))
    ios.printnl
    show_time
    repeat adr from 0 to 127

      ack := ios.plxping(adr)
      if n == 0
        ios.printhex(adr,2)
        ios.printchar(" ")
      if ack
        ios.printqchar("┼")
      else
        ios.printqchar("•")
      if n++ == 15
        ios.printnl
        n := 0
    ios.printnl
    ios.print(string("Scan : "))
    ios.printdec(i++)
  until ios.key
  ios.printnl
  ios.printcursorrate(3)
  ios.plxRun

PRI plx_scan|ack,adr

  ios.plxHalt
  ios.printnl
  repeat adr from 0 to 127
    ack := ios.plxping(adr)
    ifnot ack
      ios.print(string("Ping : $"))
      ios.printhex(adr,2)
      ios.print(string(" : "))
      ios.printdec(adr)
      ios.printnl
  ios.printnl
  ios.plxRun

PRI plx_put|wert

    device:=numm.FromStr(os_nxtoken1,numm#HEX)
    wert := numm.FromStr(os_nxtoken2,numm#HEX)
    'ios.plxOut(device,wert)

PRI plx_get
  '################## das funktioniert noch nicht ?! ####################
    device:=numm.FromStr(os_nxtoken1,numm#HEX)
    ios.print(string("Get : "))
    'ios.printhex(ios.plxIn(device),2)
    ios.printnl

PRI plx_test

  ios.printcursorrate(0)
  ios.printcls
  repeat
    ios.setpos(0,0)
    ios.printnl
    print_port(1,ios.getreg(4))
    print_port(2,ios.getreg(5))
    print_port(3,ios.getreg(6))
    ios.printnl
    print_chan(0,ios.getreg(0))
    print_chan(1,ios.getreg(1))
    print_chan(2,ios.getreg(2))
    print_chan(3,ios.getreg(3))
    show_time                                           'Zeitanzeige aktualisieren
  until ios.key
  ios.printnl
  ios.printcursorrate(3)

PRI print_chan(cnr,wert)

  ios.print(string("A/D"))
  ios.printdec(cnr)
  ios.printchar(" ")
  ios.printhex(wert,2)
  'ios.printchar(" ")
  ios.printchar("[")
  repeat wert>>3
    ios.printqchar("‣")
  repeat (255-wert)>>3
    ios.printqchar(" ")
  ios.printchar("]")
  ios.printnl

PRI print_port(pnr,wert)

  ios.print(string("Port "))
  ios.printdec(pnr)
  ios.print(string(" ["))

  repeat 8
    if wert & 1
      ios.printqchar("‣")
    else
      ios.printqchar(" ")
    wert := wert >> 1
  ios.printchar("]")
  ios.printnl
{PRI print_paddle(cnr,wert)

  ios.print(string("Paddle "))
  ios.printdec(cnr)
  ios.printchar(" ")
  ios.printhex(wert,2)
  ios.printchar(" ")
  ios.printchar("[")
  repeat wert>>3
    ios.printqchar("‣")
  repeat (255-wert)>>3
    ios.printqchar(" ")
  ios.printchar("]")
  ios.printnl

PRI print_joystick(wert)

  ios.print(string("Joystick "))
  ios.print(string("   ["))

  repeat 8
    if wert & 1
      ios.printqchar("‣")
    else
      ios.printqchar(" ")
    wert := wert >> 1
  ios.printchar("]")
  ios.printnl
  }
con'****************************************************** Befehlstoken lesen *************************************************************************************************

PUB os_nxtoken1: stradr                                 'sys: token 1 von tib einlesen
''funktionsgruppe               : sys
''funktion                      : nächsten token im eingabestring suchen und stringzeiger übergeben
''eingabe                       : -
''ausgabe                       : stradr  - adresse auf einen string mit dem gefundenen token
''variablen                     : tib     - eingabepuffer zur string
''                              : tibpos  - aktuelle position im tib
''                              : token   - tokenstring

  stradr := os_tokenize(@token1)

PUB os_nxtoken2: stradr                                 'sys: token 2 von tib einlesen
''funktionsgruppe               : sys
''funktion                      : nächsten token im eingabestring suchen und stringzeiger übergeben
''eingabe                       : -
''ausgabe                       : stradr  - adresse auf einen string mit dem gefundenen token
''variablen                     : tib     - eingabepuffer zur string
''                              : tibpos  - aktuelle position im tib
''                              : token   - tokenstring

  stradr := os_tokenize(@token2)

PUB os_tokenize(token):stradr | i                       'sys: liest nächsten token aus tib
                     
  i := 0  
  if tib[tibpos] <> 0                                   'abbruch bei leerem string
    repeat until tib[tibpos] > ios#CHAR_SPACE           'führende leerzeichen ausbenden
      tibpos++
    repeat until (tib[tibpos] == ios#CHAR_SPACE) or (tib[tibpos] == 0) 'wiederholen bis leerzeichen oder stringende
      byte[token][i] := tib[tibpos]
      tibpos++
      i++
  byte[token][i] := 0
  stradr := token

PUB os_nextpos: tibpos2                                 'sys: setzt zeiger auf nächste position
''funktionsgruppe               : sys
''funktion                      : tibpos auf nächstes token setzen
''eingabe                       : -
''ausgabe                       : tibpos2 - position des nächsten tokens in tib
''variablen                     : tib     - eingabepuffer zur string
''                              : tibpos  - aktuelle position im tib

  if tib[tibpos] <> 0
    repeat until tib[tibpos] > ios#CHAR_SPACE               'führende leerzeichen ausbenden
      tibpos++
  return tibpos

PUB os_cmdint                                           'sys: kommandointerpreter
''funktionsgruppe               : sys
''funktion                      : kommandointerpreter; zeichenkette ab tibpos wird als kommando interpretiert
''                              : tibpos wird auf position hinter token gesetzt
''eingabe                       : -
''ausgabe                       : -
''variablen                     : tib     - eingabepuffer zur string
''                              : tibpos  - aktuelle position im tib

  repeat                                                'kommandostring kopieren
    cmdstr[tibpos] := tib[tibpos]                       
    tibpos++
  until (tib[tibpos] == ios#CHAR_SPACE) or (tib[tibpos] == 0) 'wiederholen bis leerzeichen oder stringende
  cmdstr[tibpos] := 0                                   'kommandostring abschließen
  os_cmdexec(@cmdstr)                                   'interpreter aufrufen
  tibpos := 0                                           'tastaturpuffer zurücksetzen
  tib[0] := 0

DAT ' Kommandostrings

cmd1    byte  "help",0
cmd2    byte  "mount",0
cmd3    byte  "dir",0
cmd4    byte  "type",0
cmd5    byte  "rload",0
cmd6    byte  "cls",0
cmd7    byte  "bload",0
cmd8    byte  "del",0
cmd9    byte  "unmount",0
cmd10   byte  "free",0
cmd11   byte  "attrib",0
cmd12   byte  "cd",0
cmd13   byte  "aload",0
cmd14   byte  "mkdir",0
cmd15   byte  "rename",0
cmd16   byte  "format",0
cmd17   byte  "reboot",0
cmd18   byte  "sysinfo",0
cmd19   byte  "color",0
cmd20   byte  "cogs",0
cmd21   byte  "dm",0
cmd22   byte  "dmset",0
cmd23   byte  "dmclr",0
cmd24   byte  "dmlist",0
cmd25   byte  "debug",0
cmd26   byte  "time",0
cmd27   byte  "date",0
cmd28   byte  "xdir",0
cmd29   byte  "xrename",0
cmd30   byte  "xdel",0
cmd31   byte  "xtype",0
cmd32   byte  "forth",0
cmd33   byte  "admdmp",0
cmd34   byte  "beldmp",0
cmd35   byte  "regdmp",0
cmd36   byte  "ramdmp",0
cmd37   byte  "exit",0
'cmd38   byte  "plxadr",0
'cmd39   byte  "plxclose",0
cmd40   byte  "plxput",0
cmd41   byte  "plxget",0
cmd42   byte  "plxmap",0
cmd43   byte  "plxscan",0
cmd44   byte  "plxtest",0
cmd45   byte  "buflash",0     'oberen EEPROM von Bellatrix flashen
cmd46   byte  "blflash",0     'unteren EEPROM von Bellatrix flashen
cmd47   byte  "belupper",0   'starte oberen EEPROM-Bereich von Bella
cmd48   byte  "bellower",0   'starte unteren EEPROM-Bereich von Bella
cmd49   byte  "ruflash",0    'Regnatix oberer EEPROM flashen
cmd50   byte  "rlflash",0    'Regnatix unterer EEPROM flashen
cmd51   byte  "regupper",0   'oberen Regnatix-EEPROM starten
cmd52   byte  "flash",0      'Flash-Rom beschreiben
cmd53   byte  "dump",0       'Memory-Dump 0=hub,1=e-ram,2=flash

PUB os_cmdexec(stradr)  |fehler                                'sys: kommando ausführen
{{os_smdexec - das kommando im übergebenen string wird als kommando interpretiert
  stradr: adresse einer stringvariable die ein kommando enthält}}
fehler:=0

if     strcomp(stradr,@cmd14)                           'mkdir - verzeichnis erstellen
       cmd_mkdir
elseif strcomp(stradr,@cmd15)                           'rename - datei/verzeichnis umbenennen
       cmd_rename
elseif strcomp(stradr,@cmd16)                           'format - sd-card formatieren
       cmd_format
elseif strcomp(stradr,@cmd17)                           'reboot
       cmd_reboot
elseif strcomp(stradr,@cmd18)                           'sysinfo
       cmd_sysinfo
elseif strcomp(stradr,@cmd19)                           'color
       cmd_color
elseif strcomp(stradr,@cmd20)                           'cogs
       cmd_cogs
elseif strcomp(stradr,@cmd21)                           'dm
       cmd_dm
elseif strcomp(stradr,@cmd22)                           'dmset
       cmd_dmset
elseif strcomp(stradr,@cmd23)                           'dmclr
       cmd_dmclr
elseif strcomp(stradr,@cmd24)                           'dmlist
       cmd_dmlist
'elseif strcomp(stradr,@cmd25)                           'debug
'       cmd_debug
elseif strcomp(stradr,@cmd1)                             'help
       cmd_help
elseif strcomp(stradr,@cmd2)                          'mount - sd-card mounten
       cmd_mount(0)
elseif strcomp(stradr,@cmd3)                          'dir - verzeichnis anzeigen
       cmd_dir
elseif strcomp(stradr,@cmd4)                          'type - textdatei auf bildschirm ausgeben
       cmd_type
elseif strcomp(stradr,@cmd5)                          'rload - lade regnatix-code
       os_load
elseif strcomp(stradr,@cmd6)                          'cls - bildschirm löschen
       ios.printcls
       ios.setpos(28,0)
elseif strcomp(stradr,@cmd7)                          'bload - lade bellatrix-code
       cmd_bload
elseif strcomp(stradr,@cmd8)                          'del - datei löschen
       cmd_del
elseif strcomp(stradr,@cmd9)                          'unmount - medium abmelden
       cmd_unmount
elseif strcomp(stradr,@cmd10)                         'free - anzeige datenträgerbelegung
       cmd_free
elseif strcomp(stradr,@cmd11)                         'attrib - attribute ändern
       cmd_attrib
elseif strcomp(stradr,@cmd12)                         'cd - verzeichnis wechseln
       cmd_cd
elseif strcomp(stradr,@cmd13)                         'aload - lade administra-code
       cmd_aload
'elseif strcomp(stradr,@cmd26)                         'xload
'  settime
'elseif strcomp(stradr,@cmd27)                         'xsave
'  setdate
'elseif strcomp(stradr,@cmd28)                         'xdir
'  rd_dir
'elseif strcomp(stradr,@cmd29)                         'xrename
'  rd_rename
'elseif strcomp(stradr,@cmd30)                         'xdel
'  rd_del
'elseif strcomp(stradr,@cmd31)                         'xtype
'  rd_type
elseif strcomp(stradr,@cmd32)                         'forth
  reboot
elseif strcomp(stradr,@cmd33)                         'admdmp
       cmd_admdmp
elseif strcomp(stradr,@cmd34)                         'beldmp
       cmd_beldmp
elseif strcomp(stradr,@cmd35)                         'regdmp
       cmd_regdmp
elseif strcomp(stradr,@cmd36)                         'ramdmp
       cmd_ramdmp
elseif strcomp(stradr,@cmd37)
       cmd_exit
elseif os_testbin(stradr)                             '.bin
elseif os_testadm(stradr)                             '.adm
elseif os_testbel(stradr)                             '.bel
elseif os_testbas(stradr)
'elseif strcomp(stradr,@cmd38)
'    plx_open
'elseif strcomp(stradr,@cmd39)
'    plx_close
elseif strcomp(stradr,@cmd40)
    plx_put
elseif strcomp(stradr,@cmd41)
    plx_get
elseif strcomp(stradr,@cmd42)
    plx_map
elseif strcomp(stradr,@cmd43)
    plx_scan
elseif strcomp(stradr,@cmd44)
    plx_test
elseif strcomp(stradr,@cmd45)                         'flash
  cmd_bflash($8000)                                    'Bellatrix upper EEPROM neu flashen
elseif strcomp(stradr,@cmd46)                         'flash
  cmd_bflash($0)                                       'Bellatrix upper EEPROM neu flashen
elseif strcomp(stradr,@cmd47)                         'oberer Bellatrix-EEPROM starten
  ios.upperstart
elseif strcomp(stradr,@cmd48)                         'unterer Bellatrix-EEPROM starten
  ios.lowerstart
elseif strcomp(stradr,@cmd49)                         'flash
  cmd_rflash($8000)                                    'Regnatix upper EEPROM neu flashen
elseif strcomp(stradr,@cmd50)                         'flash
  cmd_rflash($0)                                       'Regnatix upper EEPROM neu flashen
elseif strcomp(stradr,@cmd51)                         'oberen Regnatix-EEPROM starten
  sdspi.bootEEPROM(HI_EEPROM+sdspi#bootAddr)
elseif strcomp(stradr,@cmd52)
  cmd_flashrom

else                                                  'kommando nicht gefunden
    ios.print(stradr)                       'Text mit aktuellen Font darstellen(stradr)
    ios.print(@msg3)
    fehler:=1

ios.print(@prompt1)                  'Text mit aktuellen Font darstellen(@prompt1)

pri cmd_dump|stradr,adr,mode
    adr:=str.hexadecimalToNumber(os_nxtoken1)
    mode:=str.hexadecimalToNumber(os_nxtoken2)
    repeat
           ios.Dump(adr,10,mode)
           if ios.keywait==27
              quit
           adr+=80
           ios.printnl

pri cmd_flashrom|stradr,adr,ln
    stradr:=os_nxtoken1
    adr:=str.hexadecimalToNumber(os_nxtoken2)

    ios.sdopen("R",stradr)
    ln:=ios.sdfattrib(0)
    Write_File_to_Flash(adr,ln)

pri Write_File_to_Flash(adr,ln)|a,c,i,m

    a:=adr
    i:=0
    m:=0
    if a<32768
       c:=7
    else
       c:=(a/$1000)+1
       m:=1
    repeat c
           ios.erase_Flash_Data(adr+(i*$1000))
           i++
    if m
       ios.wr_flashlong(adr,a)                          'bei dateien >32kb Dateilänge schreiben
       adr+=4
    ios.copytoflash(adr)

    ios.sdclose

pri cmd_bflash(m)|status,stradr                             'EEPROM: bellatrix-code flashen

  stradr := os_nxtoken1
  ios.flash_eeprom(stradr,m)

PRI cmd_rflash(eeAdr)|stradr,i,rc,plen,pos,dif,pcnt                    'EEPROM: datei flashen

    stradr := os_nxtoken1
    rc := ios.sdopen("r",stradr)                               'datei öffnen
    repeat i from 0 to 15                              'erste page --> puffer
        byte[@buffer][i] := ios.sdgetc

    ios.sdclose
    plen := word[@buffer+$A]                           '$a ist stackposition und damit länge der objektdatei
    ios.print(string("EEPROM-Bereich "))
    ios.printhex(eeadr,4)
    ios.print(string(" loeschen !"))
    clear(eeAdr)
    eeAdr += sdspi#bootAddr                           'deviceadresse hinzufügen

    'datei kpl. einlesen und flashen
    pcnt := plen / PAGESIZE / 10
    ios.sdopen("r",stradr)                               'datei öffnen
    ios.print(stradr)
    ios.print(string(" flashen !"))

    repeat pos from 0 to plen - 1 step PAGESIZE
        dif := (plen - pos) <# PAGESIZE
        ios.sdgetblk(dif,@buffer)
        sdspi.writeEEPROM(eeAdr+pos,@buffer,dif)         'puffer --> eeprom
        sdspi.writeWait(eeAdr+pos)                       'warte auf ende des schreibvorgangs

        ios.printchar("‣")
    ios.sdclose
    return


PRI clear(eeAdr)|len,pcnt,i,pos                         'flash: löschen

  eeAdr += sdspi#bootAddr                                'deviceadresse hinzufügen
  len := IMAGESIZE
  pcnt := len / PAGESIZE / 10

  'puffer löschen
  repeat i from 0 to BUFFERSIZE-1
    byte[@buffer][i] := 0

  'rom löschen
  repeat pos from 0 to IMAGESIZE-1 step PAGESIZE
    sdspi.writeEEPROM(eeAdr+pos,@buffer,PAGESIZE)
    sdspi.writeWait(eeAdr+pos)
    pcnt--
    ios.printchar("X")
    if pcnt == 0
       pcnt := len / PAGESIZE / 10
  return
PUB os_error(err):error                                 'sys: fehlerausgabe

  if err
    ios.printnl
    ios.print(@err_s1)
    ios.printdec(err)
    ios.print(string(" : $"))
    ios.printhex(err,2)
    ios.printnl
    ios.print(@err_s2)
    case err
      0: ios.print(@err0)
      1: ios.print(@err1)
      2: ios.print(@err2)
      3: ios.print(@err3)
      4: ios.print(@err4)
      5: ios.print(@err5)
      6: ios.print(@err6)
      7: ios.print(@err7)
      8: ios.print(@err8)
      9: ios.print(@err9)
      10: ios.print(@err10)
      11: ios.print(@err11)
      12: ios.print(@err12)
      13: ios.print(@err13)
      14: ios.print(@err14)
      15: ios.print(@err15)
      16: ios.print(@err16)
      17: ios.print(@err17)
      18: ios.print(@err18)
      19: ios.print(@err19)
      20: ios.print(@err20)
      OTHER: ios.print(@errx)
    ios.printnl
  error := err

PUB os_load | len,i,stradr1,stradr2                     'sys: startet bin-datei über loader
{{ldbin - startet bin-datei über loader}}
  ios.paraset(@tib + os_nextpos)                        'parameterstring kopieren
'  ios.belreset
  ios.ldbin(os_nxtoken1)

PUB os_testbin(stradr): flag | status,i,len             'sys: testet ob das kommando als bin-datei vorliegt
{{testbin(stradr): flag - testet ob das kommando als bin-datei vorliegt
                        - string bei stradr wird um .bin erweitert
                        - flag = TRUE - kommando gefunden}}

  flag := FALSE
  len := strsize(stradr)
  repeat i from 0 to 3                                  '.bin anhängen
    byte[stradr][len + i] := byte[@ext1][i]
  byte[stradr][len + i] := 0

' im aktuellen dir suchen
  ios.sddmset(ios#DM_USER)                              'u-marker setzen
  status := ios.sdopen("r",stradr)                      'datei vorhanden?
  if status == 0                                        'datei gefunden
'     ios.belreset
     flag := TRUE
     ios.paraset(@tib + os_nextpos)                     'parameterstring kopieren

     ios.ldbin(stradr)                                  'anwendung starten
     ios.sdclose

'im system-dir suchen
  ios.sddmset(ios#DM_USER)                              'u-marker setzen
  ios.sddmact(ios#DM_SYSTEM)                            's-marker aktivieren
  status := ios.sdopen("r",stradr)                      'datei vorhanden?
  if status == 0                                        'datei gefunden
'     ios.belreset
     flag := TRUE
     ios.paraset(@tib + os_nextpos)                     'parameterstring kopieren

     ios.ldbin(stradr)                                  'anwendung starten
  ios.sdclose
  ios.sddmact(ios#DM_USER)                              'u-marker aktivieren

'vorbereiten für suche nach anderen dateien
  byte[stradr][len] := 0                                'extender wieder abschneiden

PUB os_testadm(stradr): flag | status,i,len             'sys: test ob kommando als adm-datei vorliegt

  flag := FALSE
  len := strsize(stradr)
  repeat i from 0 to 3                                  '.adm anhängen
    byte[stradr][len + i] := byte[@ext2][i]
  byte[stradr][len + i] := 0

' im aktuellen dir suchen
  status := ios.sdopen("r",stradr)                      'datei vorhanden?
  if status == 0                                        'datei gefunden
     flag := TRUE
    ios.admload(stradr)                                 'administra-code laden
  else                                                  'datei nicht gefunden
  ios.sdclose

'im system-dir suchen
  ios.sddmset(ios#DM_USER)                              'u-marker setzen
  ios.sddmact(ios#DM_SYSTEM)                            's-marker aktivieren
  status := ios.sdopen("r",stradr)                      'datei vorhanden?
  if status == 0                                        'datei gefunden
    flag := TRUE
    ios.admload(stradr)                                 'administra-code laden
  else                                                  'datei nicht gefunden
  ios.sdclose
  ios.sddmact(ios#DM_USER)                              'u-marker aktivieren

  byte[stradr][len] := 0                                'extender wieder abschneiden

PUB os_testbel(stradr): flag | status,i,len             'sys: test ob kommando als bel-datei vorliegt

  flag := FALSE
  len := strsize(stradr)
  repeat i from 0 to 3                                  '.bel anhängen
    byte[stradr][len + i] := byte[@ext3][i]
  byte[stradr][len + i] := 0

' im aktuellen dir suchen
  status := ios.sdopen("r",stradr)                      'datei vorhanden?
  if status == 0                                        'datei gefunden
    flag := TRUE
    ios.belload(stradr)                                 'bellatrix-code laden
    'ios.screeninit(0,1)                                 'systemmeldung
  else                                                  'datei nicht gefunden
  ios.sdclose

'im system-dir suchen
  ios.sddmset(ios#DM_USER)                              'u-marker setzen
  ios.sddmact(ios#DM_SYSTEM)                            's-marker aktivieren
  status := ios.sdopen("r",stradr)                      'datei vorhanden?
  if status == 0                                        'datei gefunden
    flag := TRUE
    ios.belload(stradr)                                 'bellatrix-code laden
    'ios.screeninit(0,1)                                 'systemmeldung
  else                                                  'datei nicht gefunden
  ios.sdclose
  ios.sddmact(ios#DM_USER)                              'u-marker aktivieren

  byte[stradr][len] := 0                                'extender wieder abschneiden
PUB os_testbas(stradr): flag | status,i,len             'sys: test ob kommando als bel-datei vorliegt

  flag := FALSE
  len := strsize(stradr)
  repeat i from 0 to 3                                  '.bel anhängen
    byte[stradr][len + i] := byte[@ext4][i]
  byte[stradr][len + i] := 0

' im aktuellen dir suchen
  status := ios.sdopen("r",stradr)                      'datei vorhanden?
  if status == 0                                        'datei gefunden
    flag := TRUE
    ios.paraset(stradr)
    ios.ldbin(@BAS_RT)
  else                                                  'datei nicht gefunden
  ios.sdclose

  ios.sddmact(ios#DM_USER)                              'u-marker aktivieren

  byte[stradr][len] := 0                                'extender wieder abschneiden

PRI os_printstr(strptr1,strptr2):strptr3                

  ios.print(strptr1)
  ios.print(strptr2)
  ios.printnl
  strptr3 := strptr2

PRI os_printdec(strptr, wert):wert2                     

  ios.print(strptr)
  ios.printdec(wert)
  ios.printnl
  wert2 := wert

CON ''------------------------------------------------- KOMMANDOS

{PRI rd_dir | stradr,len                                 'rd: dir anzeigen

if ios.ram_rdbyte(ios#RAMDRV)
  'ios.rd_dir
  repeat
    'len := ios.rd_dlen
    'stradr := ios.rd_next
    if stradr
      ios.print(stradr)
      'ios.printtab
      ios.printdec(len)
      ios.printnl
  until stradr == 0
else
  ios.os_error(1)

PRI rd_load | stradr,len,fnr,i                          'rd: datei in ramdisk laden

{  stradr := os_nxtoken1                                 'dateinamen von kommandozeile holen
  ifnot ios.os_error(ios.sdopen("r",stradr))            'datei öffnen
    len := ios.sdfattrib(ios#F_SIZE)
    ios.rd_newfile(stradr,len)                          'datei erzeugen
    fnr := ios.rd_open(stradr)
    ios.rd_seek(fnr,0)
    ios.print(string("Datei laden... "))
    i := 0
    ios.sdxgetblk(fnr,len)                              'daten als block direkt in ext. ram einlesen
    ios.sdclose
    ios.rd_close(fnr)
}
PRI rd_save | stradr,fnr,len,i                          'rd: datei aus ramdisk speichern
{
  stradr := os_nxtoken1
  fnr := ios.rd_open(stradr)
  ifnot fnr == -1
    len := ios.rd_len(fnr)
    ifnot ios.os_error(ios.sdnewfile(stradr))
      ifnot ios.os_error(ios.sdopen("W",stradr))
        ios.print(string("Datei schreiben... "))
        i := 0
        ios.sdxputblk(fnr,len)                          'daten als block schreiben
        ios.sdclose
        ios.printnl
    ios.rd_close(fnr)
}
PRI rd_rename                                           'rd: datei in ramdisk umbenennen

'  ios.os_error(ios.rd_rename(os_nxtoken1,os_nxtoken2))

PRI rd_del | adr                                        'rd: datei löschen

'  ios.os_error(ios.rd_del(os_nxtoken1))

PRI rd_type | stradr,len,fnr                            'rd: text ausgeben

{  stradr := os_nxtoken1                                 'dateinamen von kommandozeile holen
  fnr := ios.rd_open(stradr)                            'datei öffnen
  ifnot fnr == -1
    len := ios.rd_len(fnr)
    ios.rd_seek(fnr,0)
    repeat len
      ios.printchar(ios.rd_get(fnr))
    ios.rd_close(fnr)
}
}
{PUB cmd_debug|stradr,len,fnr,i,x                        'cmd: temporäre debugfunktion

  ios.print(string("Debug : "))
  ios.printnl
  stradr := os_nxtoken1                                 'dateinamen von kommandozeile holen
  ifnot ios.os_error(ios.sdopen("r",stradr))            'datei öffnen
    len := ios.sdfattrib(ios#F_SIZE)
    ios.rd_newfile(stradr,len)                          'datei erzeugen
    fnr := ios.rd_open(stradr)
    ios.rd_seek(fnr,0)
    ios.print(string("Datei laden... "))
    i := 0
    x := ios.curgetx
    ios.curoff
    ios.sdxgetblk(fnr,len)                              'daten als block direkt in ext. ram einlesen
    ios.print(string("ok"))
    ios.curon
    ios.sdclose
    ios.rd_close(fnr)
}
PUB cmd_dm|wert                                         'cmd: dir-marker aktivieren

  ios.os_error(ios.sddmact(cmd_dm_nr))

PUB cmd_dmset                                           'cmd: dir-marker setzen

  ios.sddmset(cmd_dm_nr)

PUB cmd_dmclr                                           'cmd: dir-marker löschen

  ios.sddmclr(cmd_dm_nr)

PUB cmd_dmlist                                          'cmd: dir-marker auflisten

  ios.printBoxColor(1,colors[act_color],colors[winhcol],0)
  ios.print(@msg25)
  cmd_dm_status(ios#DM_ROOT)
  ios.print(@msg24)
  cmd_dm_status(ios#DM_SYSTEM)
  ios.print(@msg26)
  cmd_dm_status(ios#DM_USER)
  ios.printBoxColor(1,colors[act_color],colors[winhcol],0)
  ios.print(@msg27)
  cmd_dm_status(ios#DM_A)
  ios.print(@msg28)
  cmd_dm_status(ios#DM_B)
  ios.print(@msg29)
  cmd_dm_status(ios#DM_C)
  
PRI cmd_dm_status(markernr)                             

  if ios.sddmget(markernr) == TRUE
    ios.print(@msg31)
  else
    ios.print(@msg30)
    
PRI cmd_dm_nr:wert                                     

  case byte[os_nxtoken1]
    "r": wert := 0              'root
    "s": wert := 1              'system
    "u": wert := 2              'user
    "a": wert := 3              'marker a
    "b": wert := 4              'marker b
    "c": wert := 5              'marker c
    other: wert := 0

PUB cmd_color                                           'cmd: zeichenfarbe wählen

  'ios.setcolor(str.decimalToNumber(colors[act_color] := os_nxtoken1))
  ios.printBoxColor(1,str.decimalToNumber(colors[act_color]:= os_nxtoken1),colors[winhcol],0)
  'str.decimalToNumber(colors[act_color] := os_nxtoken1)

PUB cmd_sysinfo                                         'cmd: systeminformationen anzeigen

  ios.printnl
  os_printstr(@msg22,@syst)
  os_printstr(@msg14,@prog)
  os_printstr(@msg23,@copy)
  if ios.sdcheckmounted                                 'test ob medium gemounted ist
    os_printstr(@msg21,ios.sdvolname)
  'ios.printnl
'  os_printstr(@msg15,str.numberToBinary(ios#CHIP_VER,32))
  os_printstr(@msg16,str.numberToBinary(ios#CHIP_SPEC,32))
'  os_printstr(@msg17,str.numberToBinary(ios.admgetver,32))
  os_printstr(@msg18,str.numberToBinary(ios.admgetspec,32))
'  os_printstr(@msg19,str.numberToBinary(ios.belgetver,32))
  os_printstr(@msg20,str.numberToBinary(ios.belgetspec,32))
  os_printstr(@msg32,string("40x15"))'str.numberToDecimal(40,4))
  'os_printstr(@msg33,str.numberToDecimal(15,4))
  '
  os_printstr(@msg34,string("640x480"))'str.numberToDecimal(640,4))
  'os_printstr(@msg35,str.numberToDecimal(480,4))


PUB cmd_mount(mode) | err                                     'cmd: mount

    repeat 16
       err := ios.sdmount
       ifnot err
         mountmarker:=1
         quit
    ios.os_error(err)
    ifnot err
      ifnot mode
         ios.print(@msg4)
         ios.print(ios.sdvolname)
         ios.printnl
         ios.print(@msg25)
         cmd_dm_status(ios#DM_ROOT)
         ios.print(@msg24)
         cmd_dm_status(ios#DM_SYSTEM)
         ios.printnl

      'ios.setcolor(colors[act_color])

PUB cmd_unmount                                         'cmd: unmount

  ios.os_error(ios.sdunmount)
  mountmarker:=0
  ios.print(string("SD-Card unmounted"))
PUB cmd_free | wert                                     'cmd: anzeige freier speicher

  os_printstr(@msg5,ios.sdvolname)
  wert := os_printdec(@msg6,ios.sdcheckfree*512/1024)
  wert += os_printdec(@msg7,ios.sdcheckused*512/1024)
          os_printdec(@msg8,wert)

  ios.printnl
  ios.print(string("RBAS   : $"))
  ios.printhex(ios.ram_rdlong(ios#RAMBAS),8)
  ios.printnl
  ios.print(string("REND   : $"))
  ios.printhex(ios.ram_rdlong(ios#RAMEND),8)
  ios.printnl
  ios.print(string("USER   : $"))
  wert := ios.ram_rdlong(ios#RAMEND)
  wert := wert - ios.ram_rdlong(ios#RAMBAS)
  ios.printhex(wert,8)
  ios.printnl
  ios.print(string("RAMDRV : $"))
  ios.printhex(ios.ram_rdbyte(ios#RAMDRV),2)
  ios.printnl
  ios.print(string("SYSVAR : $"))
  ios.printhex(ios#SYSVAR,8)
  ios.printnl

PUB cmd_attrib                                          'cmd: dateiattribute ändern

  ios.os_error(ios.sdchattrib(os_nxtoken1,os_nxtoken2))

PUB cmd_rename                                          'cmd: datei/verzeichnis umbenennen

  ios.os_error(ios.sdrename(os_nxtoken1,os_nxtoken2))

PUB cmd_cd                                              'cmd: verzeichnis wechseln

  ifnot ios.os_error(ios.sdchdir(os_nxtoken1))
        userdir:=get_dirmarker
PUB cmd_mkdir                                           'cmd: verzeichnis erstellen

  ios.os_error(ios.sdnewdir(os_nxtoken1))

PUB cmd_del | stradr,char                               'cmd: datei auf sdcard löschen
{{sddel - datei auf sdcard löschen}}

  stradr := os_nxtoken1                                 'dateinamen von kommandozeile holen
  ios.print(@msg2)       
  if ios.keywait == "j"
    ios.os_error(ios.sddel(stradr))

PUB cmd_format | stradr                                 'cmd: sd-card formatieren

  stradr := os_nxtoken1                                 'dateinamen von kommandozeile holen
  ios.print(@msg12)
  if ios.keywait == "j"
    ios.os_error(ios.sdformat(stradr))

PUB cmd_reboot | key, stradr                            'cmd: reboot

  ios.print(@msg13)
  key := ios.keywait
  case key
    "c": ios.ram_wrbyte(0,ios#MAGIC)
         ios.ram_wrbyte(0,ios#RAMDRV)
         ios.admreset
         ios.belreset
         waitcnt(cnt+clkfreq*3)
         reboot
    "w": ios.ram_wrbyte(0,ios#SIFLAG)
         reboot
pri cmd_exit

    'ios.display3DBox(255, colors[winhcol], 0, 12, 8, 14, 28)
    'Print_win(string("Return to Plexus..."),9,13)
    ios.mousepointer(hour_glass)
    'cmd_mount(1)
    'activate_dirmarker(systemdir)                                                                                      'System-Verzeichnis lesen
    'ios.sdopen("r",@regsys)
    'ios.ldbin(@regsys)
    ios.ld_rambin(2)

PUB cmd_aload|status,stradr                             'cmd: administra-code laden

  stradr := os_nxtoken1
  status := ios.sdopen("r",stradr)
  if status == 0
    ios.admload(stradr)                                 'administra-code laden
  else
    ios.os_error(status)
  
PUB cmd_bload | stradr,status                           'cmd: bellatrix-code laden
{{bload - treiber für bellatrix laden}}

  stradr := os_nxtoken1
  status := ios.sdopen("r",stradr)
  if status == 0
    ios.belload(stradr)                                 'treiberupload
    'ios.screeninit(0,1)                                 'systemmeldung
    ios.print(@prog)                                    'programmversion
  else
    ios.os_error(status)
    
PUB cmd_type | stradr,char,n                            'cmd: textdatei ausgeben
{{sdtype <name> - textdatei ausgeben}}

  stradr := os_nxtoken1                                 'dateinamen von kommandozeile holen
  n := 1
  ifnot ios.os_error(ios.sdopen("r",stradr))            'datei öffnen
    repeat                                              'text ausgeben
      if ios.printchar(ios.sdgetc) == ios#BEL_CRLF      'zeilenzahl zählen und stop
        if ++n == 10
          n := 1
          if ios.keywait == 27
            ios.sdclose
            return
    until ios.sdeof                                     'ausgabe bis eof
  ios.sdclose                                           'datei schließen

PUB cmd_help | i,char,n ,x,y ,stradr,c ,a,b,ad                              'cmd: textdatei ausgeben
'ios.printwindow(2)
  'stradr := @help1                                 'dateinamen von kommandozeile holen
  n := 1
  b:=0
  ad:=HELP_ROM
  'activate_dirmarker(systemdir)
  'ifnot ios.os_error(ios.sdopen("r",stradr))            'datei öffnen
      ios.printcls
      x:=1
      y:=5
      repeat
          c:=ios.Read_Flash_Data(ad++)'ios.sdgetc

          if x==38 or c==10                                   'zeilenumbruch bei spalte 38
             x:=1
             y+=1
          if y==27
             repeat
                a:=ios.key
                if a==27
                   b:=1
                   quit
             until a==13 or a==32                                      'solange bis button 10 gedrückt wurde
             if b==1
                ios.sdclose
                ios.printcls
                ios.setpos(28,0)
                return
             y:=5
             ios.printcls
          if c==10 or c==13                                   'return oder linefeed nicht als zeichen anzeigen
             next
          if c>96
             c-=32
          ios.displayTile(c-16,colors[winhcol],0,colors[act_color],y,x)                       'text mit systemfont anzeigen
          x++

      until c==$FF'ios.sdeof                                         'ausgabe bis eof
  ios.setpos(28,0)
  'ios.sdclose
  'activate_dirmarker(userdir)

PUB cmd_dir|fcnt,stradr,hflag                           'cmd: verzeichnis anzeigen
{{sddir - anzeige verzeichnis}}

  if ios.sdcheckmounted                                 'test ob medium gemounted ist

    hflag := 1
    stradr := os_nxtoken1                               'parameter einlesen
    ios.print(@msg10)                                   
    ios.print(@msg5)
    ios.print(ios.sdvolname)
    ifnot ios.os_error(ios.sddir)                       'verzeichnis öffnen
      if str.findCharacter(stradr,"h")
        hflag := 0
      if str.findCharacter(stradr,"w")
        fcnt := cmd_dir_w(hflag)
      else
        fcnt := cmd_dir_l(hflag)                        'dir l
      ios.printnl
      ios.print(@msg10)
      ios.print(@msg9)
      ios.printdec(fcnt)
  else
    ios.os_error(1)

PRI cmd_dir_w(hflag):fcnt|stradr,lcnt,wcnt,a,b,k

    fcnt := 0
    lcnt := (rows - 6)/2
    wcnt := 3
    ios.printnl
    repeat while (stradr := ios.sdnext)
       ifnot ios.sdfattrib(ios#F_HIDDEN) & hflag                                'versteckte dateien anzeigen?
         if ios.sdfattrib(ios#F_DIR)                                            'verzeichnisname
           ios.setx(1)
           ios.printBoxColor(1,colors[selectcol],colors[winhcol],0)
           ios.printchar("*")
           ios.print(stradr)
         elseif ios.sdfattrib(ios#F_HIDDEN)
           ios.setx(2)
           ios.printBoxColor(1,colors[messagetextcol],colors[winhcol],0)
           str.charactersToLowerCase(stradr)
           ios.print(stradr)
         else                                                                   'dateiname
           ios.setx(2)
           ios.printBoxColor(1,colors[act_color],colors[winhcol],0)
           str.charactersToLowerCase(stradr)
           ios.print(stradr)
         ifnot wcnt--                                                           
           wcnt := 3
           ios.printnl
         else
         fcnt++
         ifnot --lcnt
           lcnt := (rows - 6) /2
           b:=0

           repeat
                a:=ios.mouse_button(0)
                k:=ios.key
                if a==255 or k == 27
                   b:=1
                   quit

           until a==1 or k==32 or k==13
          if b==1
             return

PRI cmd_dir_l(hflag):fcnt|stradr,lcnt,a,b,tmp,k

  fcnt := 0
  lcnt := (rows - 6)/2
  repeat while (stradr := ios.sdnext)
    ifnot ios.sdfattrib(ios#F_HIDDEN) & hflag                                   'versteckte dateien anzeigen?
       ios.printnl
       if ios.sdfattrib(ios#F_DIR)                                              'verzeichnisname
           ios.setx(1)
           ios.printBoxColor(1,colors[selectcol],colors[winhcol],0)
           ios.printchar("*")
           ios.print(stradr)
       elseif ios.sdfattrib(ios#F_HIDDEN)
         ios.setx(2)
           ios.printBoxColor(1,colors[messagetextcol],colors[winhcol],0)
         str.charactersToLowerCase(stradr)
         ios.print(stradr)
       else                                                                     'dateiname
         ios.setx(2)
         ios.printBoxColor(1,colors[act_color],colors[winhcol],0)
         str.charactersToLowerCase(stradr)
         ios.print(stradr)
       
       ios.print(str.numberToDecimal(ios.sdfattrib(ios#F_SIZE),6))             'dateigröße

       ios.setx(22)                                                      'attribute
       if ios.sdfattrib(ios#F_READONLY)
          ios.printchar("r")
       else
          ios.printchar("-")
       if ios.sdfattrib(ios#F_HIDDEN)
          ios.printchar("h")
       else
          ios.printchar("-")
       if ios.sdfattrib(ios#F_SYSTEM)
          ios.printchar("s")
       else
          ios.printchar("-")
       if ios.sdfattrib(ios#F_ARCHIV)
          ios.printchar("a")
       else
          ios.printchar("-")

       ios.setx(27)                                                       'änderungsdatum
       ios.print(str.numberToDecimal(ios.sdfattrib(ios#F_CDAY),2))
       ios.printchar(".")
       ios.print(str.numberToDecimal(ios.sdfattrib(ios#F_CMONTH),2) + 1)
       ios.printchar(".")
       ios.print(str.numberToDecimal(ios.sdfattrib(ios#F_CYEAR),4) + 1)
       fcnt++
       ifnot --lcnt
         lcnt := (rows - 6)/2
         b:=0
         repeat
                a:=ios.mouse_button(0)
                k:=ios.key
                if a==255 or k == 27
                   b:=1
                   quit
         until a==1 or k==32 or k==13
       if b==1
          return
PRI Scan_Expansion_Card|ack,adr,counter_s,counter_V

'######################################################################################################
'#   Durch diverse Versuche hat sich herausgestellt, das die Ping-Funktion allein nicht ausreicht um  #
'#   das Vorhandensein der Sepia oder Venatrix-Karte zu detektieren, da eine nicht angeschlossene     #
'#   eine Null zurückgibt, genauso wie ein angeschlossener I2C-Teilnehmer. Deshalb wird beim Scan die #
'#   Anzahl Nullen mit der Gesamtanzahl der Adressen verglichen. Ist die Anzahl zurückgegebener Nullen#
'#   mit der Anzahl Adressen identisch, so ist offensichtlich keine Karte vorhanden. Diese Methode    #
'#   verhindert Fehldetektionen und gerade in Verbindung mit der Venatrixkarte ein Festfahren des HIVE#
'#   zum Beispiel bei Aufruf der Cog-Anzeige.                                                         #
'######################################################################################################

    ios.plxHalt
       Sepia:=0
       venatrix:=0
       counter_s:=0
       counter_v:=0
       repeat adr from 32 to 79                                                                               'standard-Sepia-Adressbereich $20-$4f
              ack := ios.plxping(adr)

              ifnot ack
                    counter_s++                                                                               'Anzahl der vorhandenen I2C-Teilnehmer

       repeat adr from 0 to 5
              if ios.plxping(adr)
                 counter_v++

    ios.plxRun
    if counter_s<48
       sepia:=1
    if counter_v==5
       Venatrix:=1
PUB cmd_cogs | i,l                                      'cmd: belegung der cogs anzeigen

  ios.print(@cogs4)
  ios.printnl  

  i := ios.reggetcogs                                   'regnatix
  cmd_cogs_print(8-i,i,@cogs1)

  i := ios.admgetcogs                                   'administra
  cmd_cogs_print(8-i,i,@cogs2)

  i := ios.belgetcogs                                   'bellatrix
  cmd_cogs_print(8-i,i,@cogs3)

  'Scan_Expansion_Card                                   'nach Venatrix-Karte scannen
  'if venatrix
  '   i := ios.VEN_GETCOGS
  '   cmd_cogs_print(8-i,i,@cogs6)

  ios.printBoxColor(1,colors[act_color],colors[winhcol],0)
  ios.print(@cogs4)
  ios.printnl
  ios.print(string(" ("))
  ios.printBoxColor(1,$80,colors[winhcol],0)
  ios.print(string("•"))
  ios.printBoxColor(1,colors[act_color],colors[winhcol],0)
  ios.print(@cogs5)
  ios.printnl

PRI cmd_cogs_print(used,free,stradr)
  
  ios.print(stradr)
  if used > 0
    repeat
        ios.printBoxColor(1,$80,colors[winhcol],0)
        ios.print(string("•"))
        used--
    until used == 0
  if free > 0
    repeat
        ios.printBoxColor(1,green,colors[winhcol],0)
        ios.print(string("•"))
        free--
    until free == 0

  ios.printBoxColor(1,colors[act_color],colors[winhcol],0)
  ios.printnl
pri cmd_admdmp |stradr
    ifnot (stradr := getanynumber(os_nxtoken1))
      ' ios.beldmp(stradr)

pri cmd_beldmp |stradr
    if (stradr := getanynumber(os_nxtoken1))> -1
      ' ios.beldmp(stradr)

pri cmd_regdmp|stradr
    if (stradr := getanynumber(os_nxtoken1))> -1
       ios.Dump(stradr,100,0)
pri cmd_ramdmp|stradr

    if (stradr := getanynumber(os_nxtoken1))> -1
       ios.Dump(stradr,100,1)
pri cmd_ramdmp1|stradr
       Dump(0,$1F400,1)

PUB Dump(adr,lines,mod) |zeile ,a,b   'adresse, anzahl zeilen,ram oder xram
  zeile:=0
  repeat lines
    ios.printnl
    ios.printhex(adr,5)
    ios.printchar(":")
    'printchar(" ")

    repeat 8
      if mod>0
         ios.printhex(ios.ram_rdbyte(adr++),2)
      else
         ios.printhex(byte[adr++],2)
      ios.printchar(" ")

    adr := adr - 8
    repeat 8
      if mod>0
         ios.printqchar(ios.ram_rdbyte(adr++))
      else
         ios.printqchar(byte[adr++])
    zeile++
    if zeile == 12
       ios.printnl
       ios.print(string("<WEITER?>"))
       b:=0
         repeat
                a:=ios.mouse_button(0)
                if a==255 'ios.keywait == 27
                   b:=1
                   quit
               ' if a==6
               '    quit
         until a==6
         if b==1
            quit
       zeile:=0

PRI getAnyNumber(tp) | c, t,fnumber,i,count,quote
   'quote:=34
   count:=0
   case c := byte[tp]
      'quote:
      '   if result := byte[++tp]
      '      if byte[++tp] == quote
      '        tp++
      '      else
      '         abort @msg3'string("missing closing quote")
      '   else
      '      abort @msg3'string("end of line in string")
      "$":
         c := byte[++tp]
         if (t := hexDigit(c)) < 0
             ios.print(@msg3)
             result:=-1

         result := t
         c := byte[++tp]
         repeat until (t := hexDigit(c)) < 0
            result := result << 4 | t
            c := byte[++tp]
      "%":
         c := byte[++tp]
         if not (c == "0" or c == "1")
            result:=-1
            ios.print( @msg3)

         result := c - "0"
         c := byte[++tp]
         repeat while c == "0" or c == "1"
            result := result << 1 | (c - "0")
            c := byte[++tp]

      "0".."9":                                   'Originalcode
          result := c - "0"
          c := byte[++tp]
          repeat while c => "0" and c =< "9"
             result := result * 10 + c - "0"
             c := byte[++tp]
     other:
             result:=-1
             ios.print(@msg3)


PRI hexDigit(c)
'' Convert hexadecimal character to the corresponding value or -1 if invalid.
   if c => "0" and c =< "9"
      return c - "0"
   if c => "A" and c =< "F"
      return c - "A" + 10
   if c => "a" and c =< "f"
      return c - "a" + 10
   return -1

DAT                                                     'strings
'system1       byte  "▶Hive: Regime", 0
syst          byte  "Plexus",0
prog          byte  "DOS-Shell",0
copy          byte  "20-02-2014 • zille9",0
prompt1       byte  "ok", $0D,0
prompt2       byte  "~ ", 0
prompt3       byte  "∞ ", 0
msg1          byte  "Datei nicht gefunden!",0
msg2          byte  "Datei löschen? <j/*> : ",0
msg3          byte  " ? ",0
msg4          byte  "Volume      : ",0
msg5          byte  "Datenträger : ",0
msg6          byte  "Frei        : ",0
msg7          byte  "Belegt      : ",0
msg8          byte  "Gesamt      : ",0
msg9          byte  "Anzahl der Dateien : ",0
msg10         byte  "• ",0
msg11         byte  " KB",0
msg12         byte  "SD-Card formatieren? <j/*> : ",0
msg13         byte  "Neu starten? <[c]old/[w]arm/*> : ",0
msg14         byte  "CLI       : ",0
msg15         byte  "RegVer:",0
msg16         byte  "RegSpc:",0
msg17         byte  "AdmVer:",0
msg18         byte  "AdmSpc:",0
msg19         byte  "BelVer:",0
msg20         byte  "BelSpc:",0
msg21         byte  "Medium    : ",0
msg22         byte  "OS        : ",0
msg23         byte  "Copyright : ",0
msg24         byte  "[S]ystem    : ",0
msg25         byte  "[R]oot      : ",0
msg26         byte  "[U]ser      : ",0
msg27         byte  "Marker [A]  : ",0
msg28         byte  "Marker [B]  : ",0
msg29         byte  "Marker [C]  : ",0
msg30         byte  "gesetzt",13,0
msg31         byte  "frei",13,0
msg32         byte  "Bellatrix  Spalten/Zeilen: ",0
'msg33         byte  "Bellatrix  Textzeilen    : ",0
msg34         byte  "Bellatrix  Auflösung     : ",0
'msg35         byte  "Bellatrix  Auflösung Y   : ",0
ext1          byte  ".BIN",0
ext2          byte  ".ADM",0
ext3          byte  ".BEL",0
ext4          byte  ".BAS",0
wait1         byte  "<WEITER? */q:>",0

cstr          byte    "••••••••",0
cogs1         byte  "Regnatix  : ",0
cogs2         byte  "Administra: ",0
cogs3         byte  "Bellatrix : ",0
cogs6         byte  "Venatrix  : ",0
cogs4         byte  "────────────────────",0
cogs5         byte   " = running cog)",0

help1         byte  "dos.txt",0
'gdriver       byte  "bel.sys", 0                         'name des grafiktreibers

{
help1         file  "regime.txt"
              byte  13,0
}




con '********************************* Unterprogramme zur Tile-Verwaltung *********************************************************************************************************
{pri LoadTiletoRam(datei)|c,adress ,count             'tile:=tilenr,dateiname,xtile-zahl,ytilezahl

    count:=11264                                      '(16*11*64 (64 byte sind 16longs))
    adress:=$66800                                    'Systemfont-Bereich (Basic verwendet den gleichen Bereich)
    ios.sddmset(ios#DM_ROOT)
    os_error(ios.sdopen("R",datei))               'datei öffnen
    ios.sdxgetblk(adress,11264)                       'datei in den Speicher schreiben  (der blockbefehl ist viel schneller als der char-Befehl)
    ios.sdclose

pri loadtile|c,adress,anzahl            'tileset aus eram in bella laden

    anzahl:=2816        'anzahl longs                 '(16*11*16longs)
    ios.loadtilebuffer($66800,anzahl) 'laden          'Systemfont-Bereich (Basic verwendet den gleichen Bereich)
}
{pri printfont(str1,a,b,c,d,e)|f,n

    repeat strsize(str1)
         f:= byte[str1++]
         if d>39                            'wenn Bildschirmrand erreicht, neue Zeile
            d:=0
            e++
         if f>96
            f-=32
         ios.displayTile(f,a,b,c,e,d)       'einzelnes Tile anzeigen   ('displayTile(tnr,pcol,scol,tcol, row, column))

         d++
         }
{pri close
   sdset(0)     'ins root
   ios.sdclose
   ios.sdunmount
PRI mount
     ios.sdmount
     sdset(0)
pri sdset(str1)                                         'Verzeichniswechsel
    ios.sdchdir(str1)
    ios.sddmset(str1)
    }
DAT                                                     'systemfehler
err_s1  byte "Fehlernummer : ",0
err_s2  byte "Fehler       : ",0

err0    byte "no error",0
err1    byte "fsys unmounted",0
err2    byte "fsys corrupted",0
err3    byte "fsys unsupported",0
err4    byte "not found",0
err5    byte "file not found",0
err6    byte "dir not found",0
err7    byte "file read only",0
err8    byte "end of file",0
err9    byte "end of directory",0
err10   byte "end of root",0
err11   byte "dir is full",0
err12   byte "dir is not empty",0
err13   byte "checksum error",0
err14   byte "reboot error",0
err15   byte "bpb corrupt",0
err16   byte "fsi corrupt",0
err17   byte "dir already exist",0
err18   byte "file already exist",0
err19   byte "out of disk free space",0
err20   byte "disk io error",0
err21   byte "command not found",0
err22   byte "timeout",0
errx    byte "undefined",0

DAT                                                     'lizenz
{{

┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                                   TERMS OF USE: MIT License                                                  │                                                            
├──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation    │ 
│files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy,    │
│modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software│
│is furnished to do so, subject to the following conditions:                                                                   │
│                                                                                                                              │
│The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.│
│                                                                                                                              │
│THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE          │
│WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR         │
│COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,   │
│ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.                         │
└──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
}}
              
