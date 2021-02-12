m{{
┌──────────────────────────────────────────────────────────────────────────────────────────────────────┐
│ Autor: Reinhard Zielinski                                                                            │
│ Copyright (c) 2013 Reinhard Zielinski                                                                │
│ See end of file for terms of use.                                                                    │
│ Die Nutzungsbedingungen befinden sich am Ende der Datei                                              │
└──────────────────────────────────────────────────────────────────────────────────────────────────────┘

Informationen   : hive-project.de
Kontakt         : zille09@gmail.com
System          : TriOS
Name            : EEPROM-Manager
Chip            : Regnatix
Typ             : Plexus-Erweiterungsdatei
Version         : 01
Subversion      : 00


Logbuch         :
'############################################### Version 1.0 ######################################################################################################################

24-11-2013      :-Erstellung der Optik des Testfensters
                 -Grundgerüst stammt vom Sepia-Test-Programm
                 -6538 Longs frei

30-01-2014       -Anpassung an die neue reg.ios (Window-Funktionen)
                 -6624 Longs frei

16-03-2014       -DCF-Indikator eingebaut
17-05-2015       -Funktionalität wie Ram-Monitor in Plexus realisiert (kann aus Plexus entfernt werden ->ersetzen durch Bankswitching?)
                 -Laden an eingegebene Adresse funktioniert im E-Ram und EEPROM, einzelne Speicherzellen ändern funktioniert ebenfalls
                 -fehlt noch das Laden und starten von eingeladenen Programmen
                 -5403 Longs frei

18-05-2015       -Laden und starten von Programmen funktioniert
                 -fehlt noch das Speichern von Memory-Bereichen
                 -I2C-Routinen ausgetauscht
                 -4952 Longs frei
}}

obj
    ios   : "reg-ios-Modul"
    sdspi : "glob-sdspi"

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

ADM_SPEC        = %00000000_00000000_00000000_01010011
TXT_RAM         = $10A000
error_step      = 25                    'Schrittweite der Einträge
SETTING_RAM     = $100000 'Hier stehen die System-Settings
BRAM            = $40000
tmp_buffer      = $41000 'temporärer Parameterspeicher

'-------- Speicher für Systemfont ---------------
SYS_FONT        = $50000 '....$52BFF      ' ab hier liegt der System-Font 11kb
Hour_Glass      = $50000+(167*16*4)       ' Platz, wo das Sanduhrsymbol im Systemfont sitzt
MOUSE_RAM       = $52C00 '....$52C3F      ' User-Mouse-Pointer 64byte
'-------- Speicher für Dateiliste ---------------
DIR_RAM         = $52C40 '....$5FFFF


'------------- F-Tasten für Zusatzfunktionen -------------------------------------
F1_Key          = 208
F2_Key          = 209
F3_Key          = 210
F4_Key          = 211
F5_Key          = 212
F6_Key          = 213
F7_Key          = 214
F8_Key          = 215
F9_Key          = 216
F10_Key         = 217
F11_Key         = 218
F12_Key         = 219
ESC_KEY         = 27
RETURN_KEY      = 13
Backspace       = $C8                     ' PS/2 keyboard backspace key
Plus_Key        = 43
Minus_Key       = 45
Space_Key       = 32
TAB_KEY         = 9
ENTF_KEY        = 186
EINF_KEY        = 187
PG_UP           = 160
PG_DN           = 162

'Adressraum      = 4           'Adressbereich für Speicher-Monitor, Standardwert 4-stellig (plus 1 für ext.Ram)


PAGESIZE        = 32

LO_EEPROM       = $0000           ' based upon 24LC512 (64KB)
HI_EEPROM       = $8000
SCL             = 28
SDA             = 29
EEPROM          = $50
vbase           = $0008

'******************Farben ********************************************************
  #$FC, Light_Grey, #$A8, Grey, #$54, Dark_Grey
  #$C0, Light_Red, #$80, Red, #$40, Dark_Red
  #$30, Light_Green, #$20, Green, #$10, Dark_Green
  #$1F, Light_Blue, #$09, Blue, #$04, Dark_Blue
  #$F0, Light_Orange, #$E6, Orange, #$92, Dark_Orange
  #$CC, Light_Purple, #$88, Purple, #$44, Dark_Purple
  #$3C, Light_Teal, #$28, Teal, #$14, Dark_Teal
  #$FF, White, #$00, Black


var

  long systemdir                   'Plexus-System-Verzeichnis

  long HEX_ADRESSE                 'Adresse E-Ram-Monitor
  long startadresse,endadresse     'E-Ram-Monitor Variablen
  long pokeram,tmp_poke
  long iocontrol

  long tp                          'Texteingabe-übernahmestring
  long scrollende,scrollanfang,zeilenanfang, zeilenende 'Variablen für Scrollfunktion
  word filenumber                  'Anzahl Dateien

  byte mountmarker,tmptime
  byte colors[15]                  'Farbwerte

  byte windowx[3]
  byte windowy[3]
  byte windowxx[3]
  byte windowyy[3]
  byte menuey[10]                  'y-Koordinate für Start-Menue-Einträge
  byte popupx,popupxx              'x und
  byte popupy,popupyy              'y-Koordinaten des Popupmenues
  byte popupmarker                 'Marker für Popupmenue
  byte infomarker
  byte buttonx[5],buttony[5]
  byte util
  byte timezaehler
    '----------- DCF-Indikator ------------------------------------
  byte dcf_on
  byte dump_ram                    'Anzeige externer oder interner speicher
  byte textline[12]                'Texteingabestring
  '----------------- Maus-Auswertung -----------------------------
  byte ma,mb,mz,mc                 'Maus-Taste und Scrollrad
  byte font[25]                    'Hilfsstring für Strings aus dem Ram
  '----------------- Puffer für I2C ------------------------------
  byte buffer[PAGESIZE]
  '----------------- Dateiexplorer Variablen ---------------------
  byte selection                    'selektierte Datei
  byte scr                          'scrollmerker für Pfeiltasten
  '----------- Hervorhebungsbalken im Explorer ------------------
  byte y_old                        'alte y-Koordinate
  byte highlight                    'Hervorhebungsmarker des Dateinamens
  byte textline_old[13]             'alter Dateiname

  byte bank                         'Bankauswahl-Flag

dat
   'regsys        byte "plexus.dll",0            'Reg.sys für Rückkehr aus externem Programm
   butOK         byte "  OK  ",0
   Abbr          byte "Cancel",0
   SYSTEM        Byte "PLEXUS      ",0          'Plexus-Systemverzeichnis
   starts        byte "Start  ",0
   ROM0          byte "HUB.RAM",0
   ROM1          byte "HUB.ROM",0
   ROM2          byte "ERAM1.RAM",0
   ROM3          byte "ERAM2.RAM",0
   ROM4          byte "EEPROML.ROM",0
   ROM5          byte "EEPROMH.ROM",0
   RAMROML       byte "BANK-L",0
   RAMROMH       byte "BANK-H",0
   Butt8         byte "LOAD",0
   Butt9         byte "SAVE",0
   adressraum    byte 4,5,4                     'Adressraum H-Ram=4 E-Ram=5 EEPROM=4 stellig
   startadr      long $0,$8000,$0,$80000,$0,$8000
   Counts        long $7FFF,$7FFF,$80000,$80000,$8000,$8000

   ROMS word @ROM0,@ROM1,@ROM2,@ROM3,@ROM4,@ROM5

   dumpr         byte 67,68,80
PUB main

    ios.start
    cmd_mount                                     'sd-card mounten
    mountmarker:=1                                  'mount-marker
    '--------------------------------------------------------------------------------------
    activate_dirmarker(0)                            'ins root
    ios.sdchdir(@system)                             'System-Verzeichnis lesen
    systemdir:=get_dirmarker                         'Dir-Marker lesen

    '--------------------------------------------------------------------------------------
    cmd_unmount
    iniload                                          'Ini-Datei mit Farbwerten laden
    ios.mousepointer(MOUSE_RAM)
    testfenster
    Hex_Adresse:=0
    RamDump(HEX_ADRESSE)
    scrollanfang:=HEX_ADRESSE
    startadresse:=HEX_ADRESSE
    endadresse:=HEX_ADRESSE+152

    util:=0
    dump_ram:=0
    'I2C.start(SCL,SDA)
    sdspi.start(@iocontrol)
    repeat

      os_cmdinput                           'Hauptprogrammschleife

PRI os_cmdinput | x,y ,i,dk,key,kn,bd,c

  repeat
    time                                                                                           'Zeit und Datum anzeigen

    ma:=ios.mouse_button(0)                                                                        'linke Maustaste
    mb:=ios.mouse_button(1)                                                                        'rechte Maustaste
    mz:=ios.mousez                                                                                            'scrollrad
    key:=ios.key
    'if key
'       ifnot key=="d" or key=="a"
             'popup_info_weg
             'util:=0
    'printdec(infomarker,0,0,colors[winhcol],white)
'**************************** Short-Cuts ****************************************************************************
    case key
         F1_Key:Key_Command(F1_Key)
         F2_Key:Key_Command(F2_Key)
         F3_Key:Key_Command(F3_Key)
         F12_Key:Key_Command(F12_Key)
         ESC_KEY:popup_info_weg
         RETURN_KEY:popup_info_weg
         "r","R":Key_Command("R")
         "e","E":Key_Command("E")
         "h","H":Key_Command("H")
         "p","P":Key_Command("P")

'***************************** linke Maustaste **********************************************************************
    if ma==255
       dk:=0
       x:=ios.mousex
       y:=ios.mousey


'****************************** Startmenue anzeigen ************************************************************
       if popupmarker==1
          if x>10 or y<23                                        'Menue loeschen, wenn man woanders hinklickt
             popup_info_weg
             'util:=0
          if x=>0 and x=<10 and y=>23 and y=<28
             repeat i from 0 to 3
                 if menuey[i]==y
                    case i
                         0:menueselect(string("INFO  - F1"),menuey[i])
                           Key_Command(F1_Key)
                         1:menueselect(string("Load  - F2"),menuey[i])
                           Key_Command(F2_Key)
                         2:menueselect(string("Save  - F3"),menuey[i])
                           Key_Command(F3_Key)
                         3:menueselect(string("-EXIT- F12"),menuey[i])
                           Key_Command(F12_Key)

       '***************** Dateiauswahl-Fenster *****************************************

       if util==4 and x>12 and x<25 and y>7 and y<18
          selection:=y-7
          getfilename(selection+scrollanfang)                                                       'selektierte Datei nr
          highlight:=1
          highlight_selection(y)

          if doppelklick
             popup_info_weg
             select_file
             'util:=0
             switch_ram(dump_ram,x,y)                                                                  'Ram-Fenster neu aufbauen
             next

       '***************** Save-Fenster *************************************************

       if util==3 and (y==10 or y==12) and x==28
          bank:=switch(x,y)


          '************** Ram-Monitor **************************************************
       if (popupmarker==0) and (infomarker==0)
          if util==0
             if y==5
                if (x=>8) and (x=<13)or key==TAB_KEY
                   Dumpadresse                                                                             'Adresseingabe RAM-Monitpr

                if x==20                                                                                    'Auswahl Hub-Ram
                   switch_ram(0,x,y)

                if x==28                                                                                    'Auswahl E-Ram
                   switch_ram(1,x,y)

                if x==37                                                                                    'Auswahl EEPROM
                   switch_ram(2,x,y)


             if (x=>8) and (x=<23) and (y=>7) and (y=<26) and dump_ram>0                                        'Werte poken nur im eram und eeprom erlaubt
                   pokeram:=tmp_poke:=Poke_Ram(x,y)                                                             'Adresse aus x/y-Koordinaten errechnen
                   bd:=x-8
                   kn:=lookupz(bd:0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7)                                              'kn vorbelegen, damit nur bis zum 8.Byte in einer Zeile geschrieben wird
                   bd:=lookupz(bd:8,8,10,10,12,12,14,14,16,16,18,18,20,20,22,22)                                'ungeraden x-wert korrigieren, damit immer an die richtige Byteposition geschrieben wird
                   x:=bd
                   if dump_ram<2
                      printhex(ios.ram_rdbyte(pokeram),2,x,y,colors[act_color],colors[winhcol])                    'Erste Adresse hervorheben
                   else
                      pokeram += sdspi#bootAddr     ' always use boot EEPROM
                      sdspi.readEEPROM(pokeram,@buffer,1)
                      c:=buffer[0]
                      printhex(c,2,x,y,colors[act_color],colors[winhcol])                    'Erste Adresse hervorheben
                   ram_input(bd,kn,x,y)                                                                         'Eingabe Daten


'****************************** Globale Funktionstasten ********************************************************
       if infomarker
          if(x=>buttonx[4]) and (x=<buttonx[4]+5) and (y==buttony[4])     'ok im Infofenster
                buttonpress(4)
                if util==3
                   Save_File
                'waitcnt(clkfreq*3+cnt)
                popup_info_weg
                'util:=0
          if(x=>buttonx[2]) and (x=<buttonx[2]+5) and (y==buttony[2])     'ok im Infofenster
                buttonpress(2)
                popup_info_weg


          if y==windowy[2] and x==windowx[2]                      'doppelklick in linke obere ecke des Info-Fensters
             if doppelklick>1
                popup_info_weg
                'util:=0

          if y==windowy[2] and x==windowxx[2]
             ios.get_window
             popup_info_weg
             'util:=0

       if y==0
          if (x==39)                                                           'Beenden-Knopf
             ios.displaytile(1,250,0,0,0,39)                                   'Schliessen-Symbol
             Mouse_Release                                                     'warten bis Maustaste losgelassen wird
             ios.displaytile(1,colors[winhcol],0,colors[winframecol],0,39)     'Schliessen-Symbol
             ausstieg

          if (x==0)                                                            'Beenden bei Doppelklick auf linke obere Ecke
             if doppelklick>1
                ausstieg
          if x>1 and x<20                                                      'Doppelklick in die Titelleiste
             if doppelklick>1
                popup_info_weg
                'util:=0
                Display_Info

       if ((x=>0) and (x=<5)) and (y==29)                                   'Start-Knopf
          buttonpress(1)
          if popupmarker==1
             popup_info_weg
             'util:=0

          else
             if infomarker==1
                popup_info_weg
                'util:=0
             startmenue
             popupmarker:=1
'**************************** Maus Scrollrad ****************************************
    if mc>mz or (x==34 and y=>3 and y=<14 and ma==255)                                                         'hochscrollen
      if popupmarker==0

         ifnot infomarker
               adresseminus
               scrolldown(startadresse)
               mc:=mz
         if util==4                                                                                             'Dateifenster nur scrollen, wenn kein Infofenster angezeigt wird (byte kann keine -1 sein also 255)
            if filenumber>10                                                                                    'Dateianzahl höher als Zeilen im Dateifenster?
               scrollrunter                                                                                     'Bildschirm scrollen
               if scr>0
                  scr--
               Highlight_balken
               mc:=mz

    if mc<mz or (x==34 and y=<26 and y=>15 and ma==255)                                                        'runterscrollen
      if popupmarker==0
         ifnot infomarker
               adresseplus
               scrollup(endadresse)
               mc:=mz
         if util==4                                                                                             'Dateifenster nur scrollen, wenn kein Infofenster angezeigt wird
            if filenumber>10
               scrollhoch                                                                                       'Bildschirm scrollen
               if scr<filenumber-10
                  scr++
               Highlight_balken
               mc:=mz

'**************************** Pfeiltasten ****************************************

    if key==4 and popupmarker==0
       ifnot infomarker                                                                            'hochscrollen
            adresseminus
            scrolldown(startadresse)
            mc:=mz
       if util==4                                                                                             'Dateifenster nur scrollen, wenn kein Infofenster angezeigt wird (byte kann keine -1 sein also 255)
          Key_Command(4)

    if key==5 and popupmarker==0                                                                               'runterscrollen
       ifnot infomarker
            adresseplus
            scrollup(endadresse)
            mc:=mz
       if util==4                                                                                             'Dateifenster nur scrollen, wenn kein Infofenster angezeigt wird
          Key_Command(5)


    if key==PG_UP and popupmarker==0 and infomarker==0
       startadresse-=152
       endadresse-=152
       if endadresse<152
          endadresse:=152
       if startadresse<1
          startadresse:=0
       mc:=mz
       dump_page(startadresse)

    if key==PG_DN and popupmarker==0 and infomarker==0
       startadresse+=152
       endadresse+=152
       mc:=mz
       dump_page(startadresse)

'*************************************************************************************
PRI switch(x,y):at
    Mouse_Release
    if y==10
       Win_Tile(139,y,x)
       win_Tile(140,12,x)
       at:=0
    elseif y==12
       Win_Tile(140,10,x)
       Win_Tile(139,y,x)
       at:=1

pri Key_Command(k)
    'ifnot util==4' k>5 and k<4
    '   popup_info_weg
    'util:=0
    case k
         F1_Key:util:=0
                Display_Info
         F2_Key:SD_Card
         F3_Key:Save_fenster
         F12_Key:ausstieg
         ESC_KEY:
                 popup_info_weg
                 util:=0
         "R":Start_eeprom
         "E":switch_ram(1,28,5)
         "H":switch_ram(0,20,5)
         "P":switch_ram(2,37,5)
         RETURN_KEY:if util==2                           'Werteauswahl

                    elseif util==4                          'Load-Fenster
                       '******************************Dateien starten oder Verzeichnis wechseln*************
                       if selection=<filenumber
                          select_file
                          getfilename(selection)                                                                           'selektierte Datei untersuchen und starten oder anzeigen oder Verzeichnis öffnen

                    popup_info_weg
                    util:=0

         4:if util==4
                highlight:=1
                IF selection>1
                   selection--
                   getfilename(selection+scr)

                if selection==1 and scr>0
                   scrollrunter
                   scr--
                highlight_selection(selection+7)

         5:if util==4
                highlight:=1
                if selection<filenumber
                   selection++
                   getfilename(selection+scr)
                if selection>10
                   if scr<filenumber-10
                      scrollhoch
                      scr++
                   selection:=10
                highlight_selection(selection+7)                                                              'Bildschirm scrollen



pri switch_ram(n,x,y)
    Mouse_Release
    dump_ram:=n
    Win_Tile(140,y,20)
    Win_Tile(140,y,28)
    Win_Tile(140,y,37)
    Win_Tile(139,y,x)
    startadresse:=HEX_ADRESSE
    endadresse:=HEX_ADRESSE+152
    scrollanfang:=startadresse/8
    scrollende:=endadresse/8
    ramdump(hex_adresse)

con'--------------------------------------------------- Datei-Ladefenster ---------------------------------------------------------------------------------------------------------
PRI SD_Card:msz|b
            b:=0
            util:=4
               'reset_Highlight                                                                                'Hervorhebungsparameter löschen
               'popup_info_weg
               ios.backup_area(13-1,8-2,30+1,18+1,BRAM)               'Hintergrund sichern
               window(2,8,8,13,18,30,@butt8) 'Programmfenster(8,ios.sdvolname)
               infomarker:=1
               cmd_dir
               msz:=show_always                                                                               'Dateiliste aus dem E-Ram anzeigen
pri show_always:msz
               scrollanfang:=0
               msz:=ios.mousez
               selection:=0
               if filenumber>10
                  zeilenende:=10
                  scrollende:=10
               else
                  zeilenende:=filenumber
                  scrollende:=filenumber
               display_list(zeilenanfang,zeilenende)
               'util:=4
               scr:=0

PRI scrollrunter

             if scrollanfang<0
                scrollanfang:=0
             if scrollanfang>0
                ios.scrolldown(1,colors[winhcol], 8, 13, 17, 29,1)
                getfilename(scrollanfang)
                display_Filename(@textline,8)'Scan_File(4)
                scrollanfang--
                scrollende--
                y_old++

PRI scrollhoch
             if scrollende<filenumber
                ios.scrollup(1,colors[winhcol], 8, 13, 17, 29,1)
                getfilename(scrollende+1)
                display_Filename(@textline,17)'Scan_File(24)
                scrollende++
                scrollanfang++
                y_old--
             if scrollende>filenumber
                scrollende:=filenumber
                scrollanfang:=filenumber-9

pri Highlight_balken                                                                                          'ist der Hevorhebungsbalken außerhalb des Scrollbereiches, dann gemerkte Werte löschen
    if y_old<7 or y_old>17                                                                                    'außerhalb Scrollbereich?
       reset_Highlight                                                                                        'Parameter für die Hervorhebung löschen

pri reset_Highlight                                                                                           'Hervorhebungsparameter löschen (z.Bsp.bei Aufruf eines Unterverzeichnisses)

    highlight:=0                                                                                              'Hervorhebungsmarker löschen
    bytefill(@textline_old,0,12)                                                                            'Dateinamen-Puffer löschen

PRI highlight_selection(position)                                                                            'Dateiname mit einem farbigen Balken hervorheben

  if util==4 and position>7                                                                                   'nur im Dateifenster ab position y==4 hervorheben
    if highlight                                                                                             'erstes mal Datei angeklickt(keine Old-Parameter)

       display_line(@textline,position,colors[winhcol],colors[act_color])                                    'Dateiname mit Balken anzeigen

    if highlight and strsize(@textline_old)>0                                                                'Hervorhebung aktiv und String im Puffer?

       display_line(@textline_old,y_old,colors[act_color],colors[winhcol])                                    'alter Dateiname an alter Position ohne Balken anzeigen
    bytemove(@textline_old,@textline,12)                                                                      'neuen Dateinamen in den Puffer schreiben
    y_old:=position                                                                                           'y-Koordinate merken

PRI display_Line(stradr,ty,vor,hin)                                                                           'Ausgabe Dateiname, Icon, Größe und Erstellungsdatum

    printfont(stradr,hin,0,vor,13,ty)

PRI display_list(a,b)|n,tt                                                                                    'Dateiliste aus dem Speicher lesen und anzeigen
    tt:=7
    repeat n from a to b
           getfilename(n)
           display_filename(@textline,tt)
           tt++

PRI getfilename(nummer)|adress,position,c,z',aus                                                              'Dateiname aus dem E-Ram holen
    position:=(nummer-1)*13
    adress:=DIR_RAM+position                                                                                  'Adresse Dateiname im eRam
    z:=0
    'aus:=0
    bytefill(@textline,12,0)
    repeat 12
            c:=ios.ram_rdbyte(adress++)                                                                       'Dateiname aus Dir-Ram lesen
            textline[z++]:=c

    textline[z]:=0


PRI cmd_dir|stradr,n,c,ty',sh                                                                                  'cmd: verzeichnis anzeigen
{{sddir - anzeige verzeichnis}}
  n:=0
  c:=5
  ty:=8
  ios.sdmount
  activate_dirmarker(systemdir)
  ios.sddir                                                                                                   'kommando: verzeichnis öffnen

  repeat  while (stradr <> 0)                                                                                 'Begrenzung der Einträge auf die mit DIR_ENTRY vereinbarte            'ist eintrag gültig?
                                                                                                              'wiederhole bis verzeichnisende
      stradr:=ios.sdnext                                                                                      'einen eintrag holen
      if stradr <> 0
         if ios.sdfattrib(17)                                                                                 'unsichtbare Dateien ausblenden und Verzeichnisse
            next
         if ios.sdfattrib(19)
            next
         'scanstr_ext(stradr,1)
         n++
         WriteNameToRam(stradr,n)                                                                         'Dateiname zur spaeteren Verwendung in ERam speichern an adresse n

  filenumber:=n
  ios.ram_fill(DIR_RAM+(n*13),$1BFF-(n*13),0)                                                                 'Variablen,Dir-Speicher,nach letzten Eintrag löschen
  ios.sdunmount

PRI WriteNameToRam(st,nummer)|adress,position,c             'Dateiliste in ERam schreiben
    position:=(nummer-1)*13
    adress:=DIR_RAM+position
    repeat strsize(st)
            c:=byte[st++]
            ios.ram_wrbyte(c,adress++)

PRI display_Filename(stradr,ty)                                                                         'Ausgabe Dateiname, Icon, Größe und Erstellungsdatum

    if strsize(stradr)>0 and ty<18
               print_win(stradr,13,ty)

pri select_file
    ios.sdmount
    activate_dirmarker(systemdir)
    load_in_ram(@textline,dump_ram)
    ios.sdclose
    ios.sdunmount

pri load_in_ram(str,mode)|adr

    ifnot ios.sdopen("r",str)
          adr:=Hex_Adresse                                                        'auf eingestellte Adresse laden
          ios.mousepointer(hour_glass)                                            'Sanduhr anzeigen
          if mode==1
             repeat
                  ios.ram_wrbyte(ios.sdgetc,adr++)
             until ios.sdeof
          elseif mode==2
             loadEEPROM(Hex_Adresse)
          ios.mousepointer(Mouse_ram)                                             'Mauszeiger anzeigen
pub Start_eeprom|a
    if dump_ram==2
       if Hex_adresse<$7FFF
          a:=LO_EEPROM                                                            'Programm aus dem unteren EEPROM Bereich starten (ab $0)
       else
          a:=HI_EEPROM                                                            'Programm aus dem oberen EEPROM-Bereich starten (ab $8000)
       sdspi.bootEEPROM(sdspi#bootAddr + a)
    elseif dump_ram==1
       if HEX_ADRESSE>$7FFFF
          a:=((HEX_ADRESSE-$80000)/$8000)+2                                               'Programme werden ab $80000 im Abstand von $8000 gestartet (Offset von 2 damit der Loader zwischen SD-Card und Ram unterscheiden kann)
          ios.ld_rambin(a)

con'--------------------------------------------------- Speicherroutine -----------------------------------------------------------------------------------------------------------
PRI Save_Fenster:s
    infofenster(9,10,29,15,string("Save Memory"),1)          'Info-Fenster anzeigen
    util:=3
                             'x,y
    Print_win(string("Save "),9,10)
    print_win(ram_txt(dumpr[dump_ram]),14,10)
    print_win(@ramroml,21,10)
    WIN_TILE(139,10,28)
    print_win(@ramromh,21,12)
    WIN_TILE(140,12,28)
    bank:=0
    print_win(string("Adr:"),9,12)



PRI Save_File|adr,a,c,z
    ios.sdmount
    activate_dirmarker(systemdir)
    ios.mousepointer(hour_glass)                                            'Sanduhr anzeigen
    a:=bank
    if dump_ram>0
       a:=(dump_ram*2)+bank
    if ios.sdopen("W",@@roms[a])
       ios.sdnewfile(@@roms[a])
    ios.sdopen("W",@@roms[a])
    adr:=startadr[a]
    z:=0
    if dump_ram==2
       adr += sdspi#bootAddr     ' always use boot EEPROM
    repeat counts[a]
           if dump_ram==0
              c:=byte[adr++]
           elseif dump_ram==1
              c:=ios.ram_rdbyte(adr++)
           elseif dump_ram==2
               sdspi.readEEPROM(adr++,@buffer,1)
               c:=buffer[0]
           ios.sdputc(c)
           z++
           if z==4096
              printhex(adr,adressraum[dump_ram],14,12,colors[winhcol],colors[act_color])
              z:=0
    ios.sdclose
    ios.mousepointer(Mouse_ram)                                             'Mauszeiger anzeigen
    ios.sdunmount

PRI ifexist(dateiname):e|d                                                      'abfrage,ob datei schon vorhanden, wenn ja Überschreiben-Sicherheitsabfrage
   e:=0
   d:=ios.sdnewfile(dateiname)                                                  'existiert die dateischon?
   if d                                                                         '"File exist! Overwrite? y/n"    'fragen, ob ueberschreiben
      ios.sdclose
      if d==18
         e:=display_error(d)                                                    'abfrage Datei überschreiben oder nicht
      else
          display_error(d)                                                      'Fehlerausgabe, wenn erfolglos
   else
      e:=1                                                                      'kein Fehler

PRI scanstr(f) | c                                                                                    'Dateiendung extrahieren
      repeat while strsize(f)
             if c:=byte[f] == "."                                                                           'bis punkt springen
                byte[f]:=0
                quit
             f++
PRI display_error(er):r
    if er
       messagebox(ram_txt(er))
       r:=abfrage

PRI abfrage:taste|a,x,y,k
    repeat
      a:=ios.mouse_button(0)
      k:=ios.key
    until a==255 or k==27 or k==13
         x:=ios.mousex
         y:=ios.mousey

         if((x=>buttonx[4]) and (x=<buttonx[4]+5) and (y==buttony[4]))or k==13                                'ok
            buttonpress(4)
            taste:=1

         if((x=>buttonx[2]) and (x=<(buttonx[2]+6)) and (y==buttony[2]))or k==27                              'cancel
            buttonpress(2)
            taste:=0

    popup_info_weg

PRI messagebox(st)|laenge,mindest,messagex
    laenge:=strsize(st)+2
    mindest:= 20
    messagex:=10+laenge
    ios.backup_area(7,10,messagex,17,BRAM)               'Hintergrund sichern
    ios.display3DBox(white, colors[messagehcol], black, 10, 7, 17, messagex)
    windowx[2]:=7
    windowy[2]:=10
    windowxx[2]:=messagex
    windowyy[2]:=17
    print_message(st,8,11)
    Infomarker:=1

    button(4,@butOK,10,15)
    button(2,@Abbr,1+laenge,15)

PRI print_message(stradr,x,y)
    printfont(stradr,colors[messagehcol],0,colors[messagetextcol],x,y)

con'
PRI Text_Input(min_x,max_x,zeile,adr,ch):ausg|k,ii,x,y,blck,inp,adr_tmp,kl,spalten
    {{#######################################################
      adr=Adresse Parameter-Ram      adr=0 normales Textfeld
      ch=maximale Anzahl Zeichen
      #######################################################
      }}
    ii:=1
    blck:=0
    adr_tmp:=adr+1                                                                                            'Adresse merken
    'tmps:=adr
    inp:=0                                                                                                    'Eingabe Merker, wird aktiviert, wenn was verändert wurde
    spalten:=min_x


             WIN_TILE(6,zeile,spalten)                                                                         'Eingabe-Cursor

             repeat
                 time                                                                                         'Zeitaktualisierung
                 k:=ios.key
                 ma:=ios.mouse_button(0)

                 if k==27 or ma                                                                               'Abbruch mit ESC
                    x:=ios.mousex
                    y:=ios.mousey
                    kl:=ios.get_window//10                                                                    'Icon-Button-Nummer des Fensters
                    if (kl==1) or (kl==2)  or (k==27)                                                         'Abfrage auf Fensterloeschen
                       popup_info_weg
                       quit

                    if(x=>buttonx[4]) and (x=<buttonx[4]+5) and (y==buttony[4])                                  'ok im Infofenster
                      buttonpress(4)
                      popup_info_weg
                                                                                                     'Button muss extra gelöscht werden, sonst Fehldarstellungen
                      ausg:=13
                      quit

                 if k==13
                    ausg:=13
                    quit

                 if k==9
                    ausg:=9
                    quit
                 if k==ios#BEL_BS                                                                            'Backspace
                    if ii>1
                       if spalten<min_x+1
                          spalten:=min_x
                       'if ii<ch
                       WIN_TILE(16,zeile,spalten--)                                                         'Zeichen hinter dem Cursor löschen
                       if spalten>min_x
                          WIN_TILE(6,zeile,spalten)                                                            'Cursor einen Schritt zurück
                       else
                          WIN_TILE(16,zeile,spalten)                                                           'Leerzeichen

                       adr--
                       inp:=1                                                                                 'Text wurde verändert
                       ii--
                       blck:=0

                 if k>13                                                                                      'Alle Zeichen außer Return
                    if ii>ch
                       ii:=ch                                                                                 'Zeichenanzahl nicht mehr erhöhen
                       blck:=1                                                                                'feste Zeichenanzahl-merker
                    else
                       ii++
                    if k>96
                       k&=!32
                    if spalten+1<max_x
                       WIN_TILE(6,zeile,spalten+1)                                                              'Eingabemarker weiterrücken
                    ifnot blck                                                                                 'ist die maximale Zeichenanzahl erreicht, wird nicht weitergeschrieben
                          WIN_TILE(k-16,zeile,spalten)
                          textline[adr]:=k                                                                     'Text in String schreiben
                          spalten++
                          adr++
                          inp:=1                                                                                 'Text wurde verändert
                    else
                       ausg:=13                                                                                'automatisch rausspringen, wenn max-Zeichenzahl erreicht ist
                       quit


    if inp and ausg==13                                                                                       'neue Eingabe-Daten
       textline[adr]:=0                                                                                       'normaler Text-Modus, String abschliessen
       popup_info_weg
    elseif ausg==9
       popup_info_weg

con'
PRI Display_Info
    infofenster(9,10,31,15,string("Program-Info"),1)          'Info-Fenster anzeigen
    Print_win(string("Memory-Manager for Hive"),9,10)
    Print_win(string("Version 1.0 - 05/2015"),9,11)
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

PRI Mouse_Release
    repeat while ios.mouse_button(0)                                             'warten bis Maustaste losgelassen wird

pri ausstieg
    ios.mousepointer(hour_glass)
    ios.ld_rambin(2)

pri testfenster|a

    a:=0
    window(0,4,2,1,27,38,string("Plexus-Memory-Manager"))
    rahmen (1,6,38,27)
    rahmen (1,1,38,3)
    rahmen (1,4,38,6)
    ios.displaytile(133,colors[winhcol],colors[winhcol],colors[act_color],6,1)   'Rahmen-Verbindungsstücke
    ios.displaytile(117,colors[winhcol],colors[winhcol],colors[act_color],6,38)
    Print_win(string("Memory-Manager for Hive-Computer V1"),2,2)


PRI Print_win(str,x,y)
    printfont(str,colors[winhcol],0,colors[act_color],x,y)

PRI printhex(value, digits,x,y,back,vor)|wert                             'screen: hexadezimalen zahlenwert auf bildschirm ausgeben
{{hex(value,digits) - screen: hexadezimale bildschirmausgabe eines zahlenwertes}}
  value <<= (8 - digits) << 2
  repeat digits
    wert:=lookupz((value <-= 4) & $F : "0".."9", "A".."F")
    ios.displaytile(wert-16,back,0,vor,y,x++)

con''****************************************************** Memory-Anzeige *******************************************************************************************************
PRI RamDump(start)
    'a:=start
    print_win(@starts,2,5)

    print_win(ram_txt(67),14,5)
    print_win(ram_txt(68),22,5)
    print_win(ram_txt(80),30,5)
    WIN_TILE(140,5,20)
    WIN_TILE(140,5,28)
    WIN_TILE(140,5,37)
    case dump_ram
             0:WIN_TILE(139,5,20)
             1:WIN_TILE(139,5,28)
             2:WIN_TILE(139,5,37)
    dump_page(start)

pri dump_page(a)|i

    printhex(a,adressraum[dump_ram],8,5,colors[winhcol],colors[act_color])
    ios.displayTile(16,colors[winhcol],0,colors[act_color],5,8+adressraum[dump_ram])       'einzelnes Tile anzeigen   ('displayTile(tnr,pcol,scol,tcol, row, column))printfont(16,colors[winhcol],0,colors[act_color],5,12+ad)

    ios.display2dbox(colors[winhcol], 7, 2, 26, 37,0)
    repeat i from 7 to 26
           dump(a,2,i,dump_ram)
           a+=8

{pri dump_all|adr,c,a                                      'H-Ram auf SD-Karte speichern
    if dump_ram>0
       a:=bank*2
    if ios.sdopen("W",@@roms[a])
       ios.sdnewfile(@@roms[a])
    ios.sdopen("W",@@roms[a])
    adr:=startadresse[a]

    repeat counts[a]
           c:=byte[adr++]
           ios.sdputc(c)
    ios.sdclose
…}
PRI Dump(adr,x,y,mode) |c[8],a,i                                                                              'adresse, anzahl zeilen,ram oder xram

    a:=25
    printhex(adr,adressraum[dump_ram],x,y,colors[winhcol],colors[act_color])
    x+=5
    WIN_TILE(42,y,x)
    x++
    if mode==2
       adr += sdspi#bootAddr     ' always use boot EEPROM
    repeat i from 0 to 7
            if mode==0
               c:=byte[adr++]
            elseif mode==1
               c:=ios.ram_rdbyte(adr++)
            else
               sdspi.readEEPROM(adr++,@buffer,1)
               c:=buffer[0]

            printhex(c,2,x++,y,colors[winhcol],colors[act_color])
            if c>175 or c<16
               c:=46
            Grossbuchstabe(c,y,a++)
            x++

PRI Dumpadresse|k,sp,i,ok                                                                                  '***********Adresseingabe im E-Ram-Monitor****************
    sp:=8
    i:=0
    printhex(HEX_ADRESSE, adressraum[dump_ram],8,5,colors[act_color],colors[winhcol])                                                           'Eingabe revers darstellen

             repeat
                 k:=ios.key
                 ma:=ios.mouse_button(0)
                 sp:=i+8
                 if k==13                                                                                     'Return? dann neue Zeile
                    ok:=1
                    textline[i++]:=0
                    quit
                 if k==27                                                                                     'Abbruch
                    ok:=0
                    quit
                 if k==ios#BEL_BS                                                                            'Backspace
                    if i>0
                       'WIN_TILE(26,4,sp)
                       WIN_TILE(16,5,sp+1)
                       i--
                 if k=>"0" and k =< "9"  or k=>"A" and k=<"F" or k=>"a" and k=<"f"                            'Nur Zahlen 0-9 und A-F
                    WIN_TILE(k-16,5,sp)'sp++)
                    textline[i++]:=k
                    if i>adressraum[dump_ram]                                                                                   'Adressraum-Eingrenzung Hubram 4-stellig, E-Ram 5-stellig
                       i:=adressraum[dump_ram]

    if ok==1
       tp:= @textline
       HEX_ADRESSE:=gethexnumber
    ramdump(HEX_ADRESSE)
    startadresse:=HEX_ADRESSE
    endadresse:=HEX_ADRESSE+152
    scrollanfang:=startadresse/8
    scrollende:=endadresse/8

PRI Poke_Ram(x,y):inp                                                                                         'Werte im E-Ram aendern
    x-=8
    y-=7
    inp:=startadresse+(x/2)+(y*8)

pri ram_input(bdn,knn,x,y)|i,k,zahl                                                                           'Eingabe in den RAM-Monitor

    i:=0
    repeat                                                                                                    'Tasteneingabe
         k:=ios.key
         if i==2                                                                                              'ein Byte geschrieben
            textline[i++]:=0                                                                                  'String abschliessen
            tp:= @textline
            zahl:=getHexnumber                                                                                'Hex-String in Zahl umwandeln
            if dump_ram<2
               ios.ram_wrbyte(zahl,pokeram++)                                                                    'in ERam schreiben
            else
               buffer[0]:=zahl
               sdspi.writeEEPROM(pokeram,@buffer,1)         'puffer --> eeprom
               sdspi.writeWait(pokeram)                       'warte auf ende des schreibvorgangs
               pokeram++

            i:=0                                                                                              'Zeichen-Zähler auf null
            knn++                                                                                             'Spaltenzähler erhöhen
         if (k=>"0" and k =< "9")  or (k=>"A"or k=>"a") and (k=<"F"or k=<"f")                                 'Nur Zahlen und A-F
            WIN_TILE(k-16,y,x++)                                                                              'Zeichen ausgeben
            textline[i++]:=k                                                                                  'Zeichen in String schreiben
         if k==27 or k==13 or knn==8                                                                          'ende bei esc oder enter oder Zeile voll
            dump(tmp_poke-((bdn-8)/2),2,y,Dump_ram)                                                           'geänderte Zeile anzeigen
            quit

con '***************************************************** Diverse Texte aus dem E-Ram lesen *************************************************************************************

PRI ram_txt(nummer)
    return txt_from_ram(txt_ram,nummer,error_step)

pri txt_from_ram(adr,nummer,st)|c,i,ad
    i:=0
    ad:=adr+((nummer-1)*st)
         repeat while (c:=ios.Read_Flash_Data(ad++))<$FF'c:=ios.ram_rdbyte(ad++)
                 if c>13
                    byte[@font][i++]:=c
    byte[@font][i]:=0
    return @font

con'****************************************************** Datum und Zeitanzeige *************************************************************************************************

PRI time|s                             'Zeitanzeige in der Statusleiste
    timezaehler++
    if timezaehler>150
       timezaehler:=0
       'ios.ReadClock
       s:=ios.getminutes
       'Status_extern(ios.dcf_sync,dcf_on,170,34,29,green,black)                                         'Anzeige des aktuellen Status in der Titelzeile
       if s<>tmptime
          displaytime

PRI displaytime|hr,mi

       hr:=ios.gethours
       mi:=ios.getminutes

        print_zehner(hr,29,35,colors[hcolstatus],colors[statustextcol])
        ios.displaytile(42,colors[hcolstatus],0,colors[statustextcol],29,37)

        print_zehner(mi,29,38,colors[hcolstatus],colors[statustextcol])
        tmptime:=mi
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
      'printdec(dcf_on,1,1,colors[winhcol],colors[act_color])
con'
PRI doppelklick:click                            'pseudo-doppelklick
    click:=0
    'ios.get_window
    Mouse_Release

    repeat 800
        if ios.mouse_button(0)==255
           click++
PRI adresseminus
          startadresse-=8
          endadresse-=8
          if endadresse<152
             endadresse:=152
          if startadresse<1
             startadresse:=0

PRI adresseplus
          startadresse+=8
          endadresse+=8


PRI scrollup(adresse)
    ios.scrollup(1, colors[winhcol], 7, 2, 26, 32,1)
    scrollanfang++
    dump(adresse,2,26,dump_ram)

PRI scrolldown(adresse)
    if scrollanfang>0
       scrollanfang--
       ios.scrolldown(1, colors[winhcol], 7, 2, 26, 32,1)
       dump(adresse,2,7,dump_ram)
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
PRI cmd_mount :err                                     'cmd: mount

   repeat 16
       err:=ios.sdmount
       ifnot err
         mountmarker:=1
         quit
       else
         display_error(err)
         quit

PRI cmd_unmount|err                                         'cmd: unmount
  err:=ios.sdunmount
  ifnot err
        mountmarker:=0
  else
        display_error(err)

PRI window(num,cntrl,y,x,yy,xx,strg)                        'ein Fenster erstellen

    windowx[num]:=x-1
    windowy[num]:=y-2
    windowxx[num]:=xx+1
    windowyy[num]:=yy+1

    ios.window(num,0,colors[winhcol],0,colors[winframecol],colors[titelhcol],colors[titeltextcol],colors[hcolstatus],colors[statustextcol],y-2,x-1,yy+1,xx+1,cntrl,0)
    ios.printcursorrate(0)
    ios.printchar(12)                    'cls
    printfont(strg,colors[titelhcol],0,colors[titeltextcol],x,y-2)

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

PRI Grossbuchstabe(n,y,x)
    if n>96                                                            'in Großbuchstaben umwandeln
       n&=!32
    n-=16
    WIN_TILE(n,y,x)

PRI getHEXNumber | c, t
         c := byte[tp]
         if (t := hexDigit(c)) < 0
            return                                                                                            '("invalid hex character")
         result := t
         c := byte[++tp]
         repeat until (t := hexDigit(c)) < 0
            result := result << 4 | t
            c := byte[++tp]

pri getnumber |c
         c := byte[tp]
         result := c - "0"
         c := byte[++tp]
         repeat while c => "0" and c =< "9"
            result := result * 10 + c - "0"
            c := byte[++tp]

PRI hexDigit(c)
                                                                                                              'Convert hexadecimal character to the corresponding value or -1 if invalid.
   if c => "0" and c =< "9"
      return c - "0"
   if c => "A" and c =< "F"
      return c - "A" + 10
   if c => "a" and c =< "f"
      return c - "a" + 10
   return -1


con '************************************************** Button-Funktionen ********************************************************************************************************

PRI buttonpress(n)
    case n
         1:printfont(string("Start  "),250,0,0,0,29)
           ios.displaytile(144,colors[shellhcol],250,colors[shellhcol],29,7)
         4:printfont(@butOK,250,0,0,buttonx[n],buttony[n])
         2:printfont(@ABBR,250,0,0,buttonx[n],buttony[n])

    Mouse_Release
    case n
         1:printfont(string("Start  "),colors[hcolstatus],0,colors[statustextcol],0,29)
           ios.displaytile(144,colors[shellhcol],colors[hcolstatus],colors[shellhcol],29,7)
         4:printfont(@butOK,colors[Buttonhcol],0,colors[buttontextcol],buttonx[n],buttony[n])
         2:printfont(@ABBR,colors[Buttonhcol],0,colors[buttontextcol],buttonx[n],buttony[n])


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
    menue(0,23,9,28)
    printfont(string("Startmenue"),colors[titelhcol],0,colors[titeltextcol],0,22)

    printfont(string("INFO  - F1"),colors[messagehcol],0,colors[messagetextcol],0,23)
    menuey[0]:=23
    printfont(string("LOAD  - F2"),colors[messagehcol],0,colors[messagetextcol],0,24)
    menuey[1]:=24
    printfont(string("SAVE  - F3"),colors[messagehcol],0,colors[messagetextcol],0,25)
    menuey[2]:=25
    separator(0,26,9)

    printfont(string("-EXIT- F12"),colors[messagehcol],0,colors[messagetextcol],0,27)
    menuey[3]:=27
    popupmarker:=1

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
             ios.restore_area(popupx,popupy,popupxx,popupyy,BRAM)                  'Hintergrund wiederherstellen
             popupmarker:=0                                                        'Popupmarker loeschen
          if infomarker==1
             ios.restore_area(windowx[2],windowy[2],windowxx[2],windowyy[2],BRAM)                          'Hintergrund wiederherstellen
             buttonx[2]:=buttony[2]:=buttonx[4]:=buttony[4]:=-1                         'Buttonwerte löschen
             infomarker:=0
          util:=0

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
con '---------------------------------------------- I2C Routinen -------------------------------------------------------------------------------------------------------------------
PRI loadEEPROM(adr) | a, c, d
  adr += sdspi#bootAddr     ' always use boot EEPROM

  a := ios.sdfattrib(0)'word[@buffer+vbase]   'use actual size of program
  ios.sdgetblk(PAGESIZE,@buffer)
  sdspi.writeEEPROM(adr,@buffer,PAGESIZE)         'puffer --> eeprom
  sdspi.writeWait(adr)                       'warte auf ende des schreibvorgangs

  repeat c from PAGESIZE to a-1 step PAGESIZE
    d := (a - c) <# PAGESIZE
    ios.sdgetblk(d,@buffer)
    sdspi.writeEEPROM(adr+c,@buffer,d)         'puffer --> eeprom
    sdspi.writeWait(adr+c)                       'warte auf ende des schreibvorgangs

