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
}}

OBJ
        ios: "reg-ios-64"

CON

_CLKMODE     = XTAL1 + PLL16X
_XINFREQ     = 5_000_000

'-------- Speicher für diverse Texte ------------
TXT_RAM   = $20000
vidnfo    = $21000
sndnfo    = $21200
prgnfo    = $21400
Verz_RAM  = $21800
MENU_RAM  = $22000
'-------- Speicher für DLL-Namen ----------------
DLL_RAM   = $30000
'-------- Speicher für Titelliste ---------------
DMP_RAM   = $40000
'-------- Speicher für Screensaver --------------
SCREEN_SV = $63000
'-------- Speicher für Systemfont ---------------
SYS_FONT  = $66800 '....$693FF      ' ab hier liegt der System-Font 11kb


MOUSE_RAM = $69400 '....$6943F      ' User-Mouse-Pointer 64byte

'-------- Speicher für Dateiliste ---------------
DIR_RAM   = $69440 '....$6AFFF
'-------- YMODEM Temp-Speicher ------------------
YMODEM_RAM= $7E400 '... $7E417   Name, der zu sendenden Datei, Was soll gemacht werden(0Empfang,1Senden)+Dirmarker

LINK_RAM  = $7FE00
PARA_RAM  = $7FE40
SETTING_RAM = $7FF00 'Hier stehen die System-Settings
'Bereich 7FFF1-7FFFF 'Systemflags für Plexus und Basic
START_FLAG  = $7FFFF 'Flag das Plexus schonmal gestartet wurde ->Logo unterdrücken


ADM_SPEC       = gc#A_FAT|gc#A_LDR|gc#A_SID|gc#A_LAN|gc#A_RTC|gc#A_PLX'%00000000_00000000_00000000_11110011

'******************Farben ********************************************************
  #$FC, Light_Grey, #$A8, Grey, #$54, Dark_Grey
  #$C0, Light_Red, #$80, Red, #$40, Dark_Red
  #$30, Light_Green, #$20, Green, #$10, Dark_Green
  #$1F, Light_Blue, #$09, Blue, #$04, Dark_Blue
  #$F0, Light_Orange, #$E6, Orange, #$92, Dark_Orange
  #$CC, Light_Purple, #$88, Purple, #$44, Dark_Purple
  #$3C, Light_Teal, #$28, Teal, #$14, Dark_Teal
  #$FF, White, #$00, Black

obj    gc:"glob-con"
VAR
'systemvariablen
  byte font[25]                    'Hilfsstring für Strings aus dem Ram
  byte colors[15]
  long systemdir                   'Systemverzeichnis-Marker

dat
   ini           byte "reg.ini",0               'Ini-Datei für Farbwerte, Dateiverknüpfungen und Systemeinstellungen
   errortxt      byte "reg.err",0
'   Trash         byte "TRASH       ",0
   video_inf     byte "VIDEO.NFO",0             'Grafikinfo
   prg_inf       byte "prg.nfo",0               'Programminfo
   sound_nfo     byte "sound.nfo",0             'Soundinfo
   dll_lst       byte "dll.lst",0               'Dll-Namensliste
   plexus        byte "plexus.dll",0            'Plexus-Hauptprogramm
   SYSTEM        Byte "PLEXUS      ",0          'Plexus-Systemverzeichnis
   Version       byte "Version 2.2",0

   sysfont       byte "reg.fnt",0
   scrsaver      byte "plexus.dat",0
   scroll        byte "WE ARE BORG! YOU WILL BE ASSIMILATED. RESISTANCE IS FUTIL.",0

PUB main | i,a

    ios.start
    ios.sdmount                                         'sd-card mounten
    activate_dirmarker(0)
    ios.sdchdir(@system)                                'in's System-Verzeichnis springen
    systemdir:=get_dirmarker                            'System-Dirmarker lesen
    'activate_dirmarker(0)

    'if ios.admgetspec<>ADM_SPEC
    '   ios.admload(string("plexus.adm"))                'Administracode laden

    activate_dirmarker(systemdir)                       'nach dem Neustart von Administra wieder ins Systemverzeichnis springen

    if ios.bel_get<>88
       ios.belload(string("plexus.bel"))                'Bellatrixcode laden


    ios.ram_fill(DIR_RAM,$1BFF,0)                       'Dir-Speicher löschen
    ios.ram_fill(DMP_RAM,$1FFF,0)                       'Dmp-File-Speicher löschen
    ios.ram_fill(TXT_RAM,$2000,0)                       'Error-Text-Speicher löschen
    ios.ram_fill(LINK_RAM,$ff,0)                        'Link-Speicher löschen
    ios.ram_fill(MENU_RAM,$500,0)                       'Menue-Text-Speicher löschen
    ios.ram_fill(dll_RAM,$300,0)                        'Dll-Namen löschen
    ios.ram_fill(YMODEM_RAM,$30,0)                      'YMODEM-RAM löschen
    '--------------------------------------------------------------------------------------
    activate_dirmarker(systemdir)                       'nach dem Neustart von Administra wieder ins Systemverzeichnis springen

    ios.sdopen("R",@errortxt)
    fileload_err(TXT_RAM,25)                            'Fehler-Texte laden
    ios.sdopen("R",@video_inf)
    fileload(vidnfo)                                    'Video-Info laden
    ios.sdopen("R",@sound_nfo)
    fileload(sndnfo)                                    'Sound-Info laden
    ios.sdopen("R",@prg_inf)
    fileload(prgnfo)                                    'Programm-Info laden
    ios.sdopen("R",@dll_lst)
    fileload_err(DLL_RAM,16)                            'dll-namen laden
    '***************** Initialisierung ohne Ini-Datei ****************************
    if iniload                                          'wenn keine Ini da ist, standardwerte setzen
       colors[0]:=light_blue
       colors[1]:=white
       colors[2]:=light_blue
       colors[3]:=white
       colors[4]:=dark_blue
       colors[5]:=white
       colors[6]:=grey
       colors[7]:=white
       colors[8]:=white
       colors[9]:=dark_blue
       colors[10]:=blue
       colors[11]:=white
       colors[12]:=purple
       colors[13]:=black
       colors[14]:=grey
       i:=SETTING_RAM
       a:=0
       repeat 15
           ios.ram_wrbyte(colors[a++],i++)

       ios.ram_wrbyte(7,i++)                'baudrate setzen auf 57600
       ios.ram_wrbyte(1,i++)                'show hidden files
       ios.ram_wrbyte(1,i++)                'use trash
       ios.ram_wrbyte(0,i++)                'Venatrix nicht verwenden
       ios.ram_wrbyte(0,i++)                'Sepia nicht verwenden

    '****************** Hauptbildschirm ******************************************
    ios.printBoxcolor(0,red,orange,95)
    ios.printchar(12)                    'cls

    LoadTiletoRam(@sysfont,SYS_FONT)                  'Systemfont auf jeden Fall in den Ram laden
    '******************************************************************************
    '*Wird Plexus aus beendeten Bin Dateien geladen, wird das Logo nicht angezeigt*
    '******************************************************************************
    if ios.ram_rdbyte(START_FLAG)<>235
       LoadTiletoRam(@scrsaver,SCREEN_SV)                'Plexus-Logo in den Ram laden
       loadtile(SCREEN_SV)                               'Plexus-Logo nach Bella laden
       ios.display2dbox(red,0,0,2,39,0)
       ios.display2dbox(light_red,3,0,5,39,0)
       ios.display2dbox(orange,6,0,9,39,0)

       ios.display2dbox(dark_red,10,0,10,39,0)

       ios.display2dbox(light_orange,11,0,18,39,0)

       ios.display2dbox(dark_red,19,0,19,39,0)

       ios.display2dbox(orange,20,0,23,39,0)
       ios.display2dbox(light_red,24,0,26,39,0)
       ios.display2dbox(red,27,0,29,39,0)

       ios.displaypic(light_orange,black,0,11,10,8,22)'light_orange,0,11,10,8,22)        'Plexus-Logo anzeigen

       ios.setpos(7,15)
       ios.print(string("Welcome to"))
       ios.setpos(21,12)
       ios.print(string("for Hive-Computer"))
       ios.printBoxcolor(0,orange,light_red,95)
       ios.setpos(24,15)
       ios.print(@version)
       ios.printBoxcolor(0,orange,light_orange,95)

       ios.scrollString(@scroll,4, light_orange, red, 27, 0, 39)

    '************************* Plexus wird geladen *************************************
    ios.printchar(12)                    'cls
    ios.printBoxcolor(0,0,ios.ram_rdbyte(SETTING_RAM),0)'ios.ram_rdbyte(0,colors[0],SETTING_RAM)
    ios.printchar(12)                    'cls

    ios.sdopen("R",@plexus)                           'Plexus.Dll öffnen
    ios.ldbin(@plexus)                                'Plexus laden

{
  #$FC, Light_Grey, #$A8, Grey, #$54, Dark_Grey
  #$C0, Light_Red, #$80, Red, #$40, Dark_Red
  #$30, Light_Green, #$20, Green, #$10, Dark_Green
  #$1F, Light_Blue, #$09, Blue, #$04, Dark_Blue
  #$F0, Light_Orange, #$E6, Orange, #$92, Dark_Orange
  #$CC, Light_Purple, #$88, Purple, #$44, Dark_Purple
  #$3C, Light_Teal, #$28, Teal, #$14, Dark_Teal
  #$FF, White, #$00, Black
}
con '***************************************************** Diverse Texte in den E-Ram laden **************************************************************************************

PRI fileload(adr)|cont

    cont:=ios.sdfattrib(0)
    ios.sdxgetblk(adr,cont)
    ios.sdclose

PRI fileload_err(adr,st)| cont,c,b,a,i
    i:=adr

    b:=0
    repeat
           a:=ios.sdgetc

           if a==$0A
              b++
              i:=adr+(st*b)
              next
           else
              ios.ram_wrbyte(a,i++)
    until ios.sdeof
    ios.sdclose

PRI activate_dirmarker(mark)                       'USER-Marker setzen

     ios.sddmput(ios#DM_USER,mark)                 'usermarker wieder in administra setzen
     ios.sddmact(ios#DM_USER)                      'u-marker aktivieren

PRI get_dirmarker:dm                               'USER-Marker lesen

    ios.sddmset(ios#DM_USER)
    dm:=ios.sddmget(ios#DM_USER)

con '********************************* Unterprogramme zur Tile-Verwaltung *********************************************************************************************************
PRI LoadTiletoRam(datei,adress)                         'tile:=tilenr,dateiname,xtile-zahl,ytilezahl

    ios.sdopen("R",datei)')                             'datei öffnen
    ios.sdxgetblk(adress,11264)                         'datei in den Speicher schreiben  (der blockbefehl ist viel schneller als der char-Befehl)
    ios.sdclose

PRI loadtile(adress)                                           'tileset aus eram in bella laden

    'anzahl:=2816        'anzahl longs                 '(16*11*16longs)
    ios.loadtilebuffer(adress,2816) 'laden          'Systemfont-Bereich (Basic verwendet den gleichen Bereich)


PRI iniload:err|i,tmp



       if ios.sdopen("R",@ini)
          err:=1
       else
          err:=0
          i:=SETTING_RAM
          '---- SYSTEM-SETTINGS IN DEN RAM LADEN -------------
          repeat 18
               ios.ram_wrbyte(ios.sdgetc,i++)
          tmp:=i
          '---- DESKTOP-VERKNÜPFUNGEN IN DEN RAM LADEN -------
          i:=LINK_RAM
          repeat 51
               ios.ram_wrbyte(ios.sdgetc,i++)
          '---- USER-MAUSZEIGER IN DEN RAM LADEN -------------
          i:=MOUSE_RAM
          repeat 64
              ios.ram_wrbyte(ios.sdgetc,i++)
          ios.Mousepointer(MOUSE_RAM)            'MAUSZEIGER ANWENDEN
          ios.displaymouse(0,0)
          '---- LINK-PARAMETER IN DEN RAM LADEN --------------
          i:=PARA_RAM
          repeat 192
              ios.ram_wrbyte(ios.sdgetc,i++)
          '---- DCF-Empfänger benutzen -----------------------
          ios.ram_wrbyte(ios.sdgetc,tmp++)
          '---- HC05-Bluetooth-Modul -------------------------
          ios.ram_wrbyte(ios.sdgetc,tmp++)
          '---- Extended Titlebar-Anzeige --------------------
          ios.ram_wrbyte(ios.sdgetc,tmp++)

    ios.sdclose



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
              
