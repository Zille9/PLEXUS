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
Name            : PLEXUS - Zentrale Kommunikationseinheit der Borg
Chip            : Regnatix
Typ             : Loader-Programm für Plexus - TRIOS-Version
Version         : 01
Subversion      : 01-TRIOS

Funktion        : "Startdatei für PLEXUS - unter TRIOS lauffähig, startet den Administra- und Bellatrixcode von SD-Karte

Logbuch         :
'############################################# Version 1.00 #################################################################################################################
04-08-2013      : -Erster Versuch der Herauslösung der Startfunktionen aus der eigentlichen Plexus-Shell, es werden alle Startparameter in den E-Ram geladen und dann
                   die eigentliche Shell gestartet
                  -Außerdem wird das Plexus-Logo beim Start angezeigt -> das sieht cool aus ;-)

16-08-2013        -LOGO wurde Borg-mäßig in grün geändert - nu is noch cooler ;-)
                  -Scrolltext für unser Motto hinzugefügt - nu is aber Schluss mit cool

'############################################# Version 1.01 #################################################################################################################
15-10-2013        -LOGO-Farbgebung geändert, jetzt bunter, weil Plexus Version 2.0 geladen wird
19-10-2013        -Fehler in Iniload behoben, es wurde der Venatrix- und Sepia-Marker an die falsche Stelle im Ram abgelegt
07-11-2013        -Fehldarstellung beim Löschen des Start-Logo's behoben (jetzt wird der Bildschirm mit der aktuellen Shell-Hintergrundfarbe gelöscht)

'############################################# VERSION 1.02 #################################################################################################################
19-03-2014        -Laderoutine für die Error-und Systemtexte geändert, jeder Text hat jetzt eine feste Adresse, ist beim laden zwar langsamer aber die Texte
                  -werden viel schneller aus dem Ram geladen und angezeigt, egal wieviele Texte vorhanden sind

'############################################# VERSION 1.05 #################################################################################################################
15-08-2015        -Variante die aus einem Flash-Rom geladen wird
                  -alle Programmteile von Plexus befinden sich im Flash und werden von dort aufgerufen
                  -beim Start wird Plexus.dll aus dem ROM in den Ram transferriert, das Laden aus dem Ram ist erheblich schneller und vermittelt ein flüssigeres Arbeiten mit Plexus
                  -erwartet den richtigen Administra Treiber
                  -der richtige Bildschirmtreiber wird im oberen EEPROM-Bereich von Bellatrix erwartet und bei Bedarf von dort gestartet
                  -das wiederum erwartet eine angepasste Version von Belflash.spin in der die notwendigen EEPROM-Routinen enthalten sind
}}

OBJ
        ios: "reg-ios-Modul"

CON

_CLKMODE     = XTAL1 + PLL16X
_XINFREQ     = 5_000_000

'-------- Speicher für diverse Texte ------------
INI_ROM   = $100000
TXT_RAM   = $10A000'$20000

Verz_RAM  = $22000
'MENU_RAM  = $22000
'-------- Speicher für DLL-Namen ----------------
DLL_RAM   = $21000
'-------- Speicher für Titelliste ---------------
DMP_RAM   = $30000
'-------- Speicher für Screensaver --------------
SCREEN_SV = $101000'$63000
'-------- Speicher für Systemfont ---------------
SYS_FONT  = $50000 '....$52BFF      ' ab hier liegt der System-Font 11kb
SYS_FONT_FLASH = $104000

MOUSE_RAM = $52C00 '....$52C3F      ' User-Mouse-Pointer 64byte
MOUSE_ROM = $100015
'-------- Speicher für Dateiliste ---------------
DIR_RAM   = $52C40 '....$5FFFF
'-------- YMODEM Temp-Speicher ------------------
YMODEM_RAM= $7E400 '... $7E417   Name, der zu sendenden Datei, Was soll gemacht werden(0Empfang,1Senden)+Dirmarker
'-------- Speicher der Fenster-Tiles ------------
WTILE_RAM= $7E500 '.... $7E5FF      ' Win-Tile Puffer hier können die Tiles, aus denen die Fenster gebaut werden geändert werden

RETURN_POINT= $7E420'                 Aktion nach Rückkehr aus YModem (zBsp.Explorer öffnen)

LINK_RAM  = $7FE00
PARA_RAM  = $7FE40
SETTING_RAM = $7FF00 'Hier stehen die System-Settings
SEPIA_RAM   = $7FFA0 '..7FFA1
'Bereich 7FFF1-7FFFF 'Systemflags für Plexus und Basic
START_FLAG  = $7FFFF 'Flag das Plexus schonmal gestartet wurde ->Logo unterdrücken

Plex = $80000

'                                          +----------- flash
'                                          |+---------- com
'                                          || +-------- i2c
'                                          || |+------- rtc
'                                          || ||+------ lan
'                                          || |||+----- sid
'                                          || ||||+---- wav
'                                          || |||||+--- hss
'                                          || ||||||+-- bootfähig
'                                          || |||||||+- dateisystem
 ADM_SPEC       = %00000000_00000000_00000010_11010011

'******************Farben ********************************************************
  #$FC, Light_Grey, #$A8, Grey, #$54, Dark_Grey
  #$C0, Light_Red, #$80, Red, #$40, Dark_Red
  #$30, Light_Green, #$20, Green, #$10, Dark_Green
  #$1F, Light_Blue, #$09, Blue, #$04, Dark_Blue
  #$F0, Light_Orange, #$E6, Orange, #$92, Dark_Orange
  #$CC, Light_Purple, #$88, Purple, #$44, Dark_Purple
  #$3C, Light_Teal, #$28, Teal, #$14, Dark_Teal
  #$FF, White, #$00, Black

 OUTSIDE        = Dark_green
 MIDDELSIDE     = GREEN
 INSIDE         = Light_green
 TITLERAND      = DARK_GREEN
 TEXTCOL        = TEAL
 VERSIONTEXT    = WHITE
 WELCOMTEXT     = BLACK
 LOGOBOX        = TEAL
 LOGOCOL        = BLACK
 LOADERBAR      = TEAL

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

obj    gc:"glob-con"
VAR
'systemvariablen
  'byte font[25]                    'Hilfsstring für Strings aus dem Ram
  byte colors[15]
  byte buttx[15],butty[15]

  byte timezaehler,tmptime
dat
'   ini           byte "REG.INI",0               'Ini-Datei für Farbwerte, Dateiverknüpfungen und Systemeinstellungen
'   errortxt      byte "ERROR.TXT",0
'   Trash         byte "TRASH       ",0
'   dll_lst       byte "DLL.LST",0               'Dll-Namensliste
'   plexus        byte "PLEXUS.DLL",0            'Plexus-Hauptprogramm
'   SYSTEM        Byte "PLEXUS      ",0          'Plexus-Systemverzeichnis
'   Version       byte "Version 2.2",0
   'sepia         byte "sepia.ini",0
'   sysfont       byte "REG.FNT",0
'   scrsaver      byte "PLEXUS.DAT",0
'   scroll        byte "RESISTANCE IS FUTIL.",0

Title     byte "TRIOS-BOOT-Menue V1.3",0
Select    byte "Choose the Operation!",0
Delete    byte "Erase Flash-Rom y/n ?",0
'trios     byte "reg-t.sys",0

oss0 byte "HIVE-TRIOS     1",0
oss1 byte "PLEXUS         2",0
oss2 byte "TRIOS-BASIC    3",0
oss3 byte "----           4",0
oss4 byte "----           5",0
oss5 byte "----           6",0
oss6 byte "----           7",0

oss7  byte "----          A",0
oss8  byte "----          B",0
oss9  byte "----          C",0
oss10 byte "----          D",0
oss11 byte "----          E",0
oss12 byte "ERASE FLASH   F",0
oss13 byte "UPDATER       G",0



os word @oss0,@oss1,@oss2,@oss3,@oss4,@oss5,@oss6,@oss7,@oss8,@oss9,@oss10,@oss11,@oss12,@oss13

'Copy      byte "OS-Selector by Zille9 08/2015",0
{  dll0 byte "YMODEM.DLL",0     $8000
   dll1 byte "BASRUN.DLL",0     $10000
   dll2 byte "SEPIA.DLL",0      $18000
   dll3 byte "VENATRIX.DLL",0   $20000
   dll4 byte "DOS.DLL",0        $28000
   dll5 byte "DCF.DLL",0        $30000
   dll6 byte "BLTOOTH.DLL",0    $38000
   dll7 byte "FONT.DLL",0       $40000
   dll8 byte "WAVE.DLL",0       $48000
   dll9 byte "IRC.DLL",0        $50000
   dll10 byte "EEPROM.DLL",0    $58000
                  :
       Platz für weitere DLL's
                  :
   plexus-reg.sys               $F8000

   }
   windowtile byte 146,148,147,114,116,6,4,2,0,129,1,5,77,3,129,129,129                           'Fenster-Tiles für WIN-Funktion

PUB main | i,a,mx,my,ma,kb

    ios.start
    'ios.upperstart                                      'Start Bellatrix-Treiber aus dem oberen EEPROM-Bereich
    ios.sdunmount
    '****************** Hauptbildschirm ******************************************
    load_farben                                         'Farben aus dem Flash lesen
    ios.mousepointer_flash(MOUSE_ROM)
    ios.printBoxcolor(0,black, colors[shellhcol],95)
    ios.printchar(12)                    'cls
    win_set_tiles
    Fenster
    repeat i from 0 to 6
           create_button(i,2,(i*3)+5,@@os[i])
    repeat i from 7 to 13
           create_button(i,20,((i-7)*3)+5,@@os[i])

    ios.displaymouse(1,colors[mousecol])
    ios.mousebound(0,0,639,479)                                                                               'Maus-Bereich festlegen
    displaytime


    repeat

       time
       mx:=ios.mousex
       my:=ios.mousey

       ma:=ios.mouse_button(0)                                                                                   'linke Maustaste
       kb:=ios.key                                                                                               'Tastenabfrage (für Zusatzfunktionen)
       if (kb) or (ma==255)
          repeat i from 0 to 13
                 if (kb==49+i) or (my=>butty[i] and my=<butty[i]+2 and mx=>buttx[i] and mx=<buttx[i]+2)
                    Press_Button(i)
                    start(i)
                 elseif (kb==97+i-7) or (my=>butty[i] and my=<butty[i]+2 and mx=>buttx[i] and mx=<buttx[i]+20)
                    Press_Button(i)
                    start(i)


PRI time|s                                                                                                    'Zeitanzeige in der Statusleiste
    timezaehler++
    if timezaehler>150
       timezaehler:=0
       'ios.readClock
       s:=ios.getminutes
       if s<>tmptime
          displaytime

PRI displaytime|h,m


       h:=ios.gethours
       m:=ios.getminutes
       print_zehner(h,28,26,colors[act_color],colors[winhcol])

       ios.displaytile(42,colors[winhcol],0,colors[act_color],28,28)                                                   'doppelpunkt
       print_zehner(m,28,29,colors[act_color],colors[winhcol])
       ios.displaytile(16,colors[winhcol],0,colors[act_color],28,31)                                                   'Leerzeichen für evtl.Fehldarstellung

       tmptime:=m
       date
pri print_zehner(wert,y,x,vor,hin)|a                                                                          'Überprüfung Wert<10 dann führende Null anzeigen
    a:=0
    if wert<10
       printdec(0,y,x,hin,vor)
       a:=1
    printdec(wert,y,x+a,hin,vor)
PRI printdec(value,y,xx,hint,vor) | i ,c ,x                                                                   'screen: dezimalen zahlenwert auf bildschirm ausgeben

  i := 1_000_000_000
  repeat 10                                                                                                   'zahl zerlegen
    if value => i
      x:=value / i + "0"
      ios.displayTile(x-16,hint,0,vor,y,xx)
      xx++
      c:=value / i + "0"
      value //= i
      result~~
    elseif result or i == 1
      printfont(string("0"),hint,0,vor,xx,y)
      xx++
    i /= 10                                                                                                   'nächste stelle

PRI date|t,m,j
      t:=ios.getdate
      m:=ios.getmonth
      j:=ios.getyear

      print_zehner(t,28,10,colors[act_color],colors[winhcol])
      win_TILE(30,28,12)                                                                                     'Punkt

      print_zehner(m,28,13,colors[act_color],colors[winhcol])
      win_TILE(30,28,15)                                                                                     'Punkt

      printdec_win(j,28,16)                                                                                  'Jahr
pri create_button(n,x,y,str)
    buttx[n]:=x
    butty[n]:=y
    ios.display3DBox(white,colors[messagehcol],black, butty[n], buttx[n], butty[n]+2, buttx[n]+17)
    printfont(str,colors[messagehcol],0,colors[messagetextcol],buttx[n]+1,butty[n]+1)

PRI printdec_win(n,y,x)
    printdec(n,y,x,colors[winhcol],colors[act_color])

pri start(n)|adr,a

    case n
         0:ios.ld_rambin(32) 'Regime
         1:ios.ld_rambin(33) 'Plexus
         2:ios.ld_rambin(66) 'Basic
         3:return
         4:return
         5:return
         6:return
         7:return
         8:return
         9:return
         10:return
         11:return
         12:Print_win(@delete,2,2) 'erase Flash
           a:=ios.keywait
           if a=="y"
              adr:=ios.FlashSize-$1000
              ios.erase_Flash_Data(adr)
           Print_win(@select,2,2)
           return
         13:ios.ld_rambin(14)  'Flash-Updater

    ios.display2dbox(colors[shellhcol], 0, 0, 29, 39,0)

pri press_button(n)

    ios.display3DBox(black,colors[messagehcol],white, butty[n], buttx[n], butty[n]+2,buttx[n]+17)
    printfont(@@os[n],colors[messagehcol],0,colors[messagetextcol],buttx[n]+1,butty[n]+1)
    mouse_release
    ios.display3DBox(white,colors[messagehcol],black,  butty[n], buttx[n], butty[n]+2,buttx[n]+17)
    printfont(@@os[n],colors[messagehcol],0,colors[messagetextcol],buttx[n]+1,butty[n]+1)

PRI Mouse_Release
    repeat while ios.mouse_button(0)                                                                         'warten bis Maustaste losgelassen wird



pri Fenster|i,y,a

    a:=0
    window(1,4,2,1,28,38,@title)
    rahmen (1,4,38,27)
    rahmen (1,1,38,3)
    Print_win(@select,2,2)

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
PRI Win_Set_Tiles|i,a                                                                                         'Tiles, aus denen die Fenster bestehen, in den Ram schreiben
    i:=WTILE_RAM
    a:=0
    repeat a from 0 to 16
           ios.ram_wrbyte(windowtile[a],i++)                                                                'Standard-Wintiles in den Ram schreiben
    ios.windel(9)                                                                                             'alle Fensterparameter löschen und Win Tiles senden


pri load_farben|i,adr
    adr:=ini_rom
    repeat i from 0 to 14
           colors[i]:=ios.Read_Flash_Data(adr++)
{
    colors[0]:=134
    colors[1]:=60
    colors[2]:=87
    colors[5]:=128
    colors[6]:=56
    colors[7]:=134
    colors[8]:=60
    colors[9]:=87
    colors[10]:=128
    colors[11]:=200
    colors[12]:=55
    colors[13]:=90
    colors[14]:=254
}
PRI window(numm,cntrl,y,x,yy,xx,strg)                                                                          'ein Fenster erstellen


               'Nr,Vord,hint,curs,framecol
    ios.window(numm,0,colors[winhcol],0,colors[winframecol],colors[titelhcol],colors[titeltextcol],colors[titelhcol]{hcolstatus,statustextcol},colors[titeltextcol],y-2,x-1,yy+1,xx+1,cntrl,0)

    ios.printcursorrate(0)
    ios.printchar(12)                    'cls
    print_titel(strg,x+1,y-2)

PRI printfont(str1,a,b,c,x,y)|f

    repeat strsize(str1)
         f:= byte[str1++]
         if f>96
            f&=!32
         if x>39                                                                                              'wenn Bildschirmrand erreicht, neue Zeile
            x:=0
            y++
         ios.displayTile(f-16,a,b,c,y,x)                                                                         'einzelnes Tile anzeigen   ('displayTile(tnr,pcol,scol,tcol, row, column))
         x++
    return x
PRI print_titel(stradr,x,y):a
    a:=printfont(stradr,colors[titelhcol],0,colors[titeltextcol],x,y)
PRI print_win(stradr,x,y):a
    a:=printfont(stradr,colors[winhcol],0,colors[act_color],x,y)
PRI Win_Tile(nu,ty,tx)
    ios.displaytile(nu,colors[winhcol],0,colors[act_color],ty,tx)
'PRI activate_dirmarker(mark)                       'USER-Marker setzen

'     ios.sddmput(ios#DM_USER,mark)                 'usermarker wieder in administra setzen
'     ios.sddmact(ios#DM_USER)                      'u-marker aktivieren

DAT                                                     'lizenz
{{
reg.ini      $100000
plexus.dat   $101000
reg.fnt      $104000
help.txt     $107000
dos.txt      $108000
prg.nfo      $109000
error.txt    $10A000         'Errortexte
VIDEO.NFO    $10B000         'Grafikinfo
SOUND.NFO    $10C000         'Soundinfo
           ->$11D000
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
              
