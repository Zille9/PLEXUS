{{
┌──────────────────────────────────────────────────────────────────────────────────────────────────────┐
│ Autor: Reinhard Zielinski                                                                            │
│ Copyright (c) 2013 Reinhard Zielinski                                                                │
│ See end of file for terms of use.                                                                    │
│ Die Nutzungsbedingungen befinden sich am Ende der Datei                                              │
└──────────────────────────────────────────────────────────────────────────────────────────────────────┘

Informationen   : hive-project.de
Kontakt         : zille09@gmail.com
System          : Plexus
Name            : Plexus-Frontend für den Propeller Signal Generator v1.2 (C) 2012 von Johannes Ahlebrand
Chip            : Regnatix
Typ             : Plexus-Erweiterungsdatei
Version         : 01
Subversion      : 00


Logbuch         :
'############################################### Version 1.0 ######################################################################################################################

10-07-2014       -Bildschirmmaske erstellt
11-07-2014       -Wellenformauswahl erstellt
16-07-2014       -Parametereingabe-Routine begonnen -> ist noch nicht optimal
                 -5665 Longs frei
17-07-2014       -Parametermaske soweit fertig, Mausauswahl fehlt noch
                 -6131 Longs frei
18-07-2014       -Save-Routine erstellt
                 -Load und Iniload-Routine erstellt
                 -speichern und laden funktioniert
                 -jetzt fehlt noch eine Dateiauswahl für zu ladende Parameterdateien und dann kann der Signalgenerator getestet werden
                 -5719 Longs frei

'################################################ Version 1.1 #####################################################################################################################
20-07-2014       -Parameterauswahl per Maus realisiert
                 -Parameterübertragung und Funktion soweit fertig
                 -es fehlt noch die PWM- und Sweep-Automatik
                 -Sweep-Automatik funktioniert, Schleife durch Timer-Abfragen ersetzt
                 -5362 Longs frei

21-07-2014       -PWM-Automatik funktioniert jetzt auch
                 -beide Automatiken mit der Möglichkeit der Inversen Funktion ausgestattet (Werte von From und To können jeweils kleiner oder größer sein)
                 -Grundgerüst Ladefenster erstellt
                 -5167 Longs frei

22-07-2014       -Ladefenster mit Dateiselektion komplettiert ->Mausbedienung fehlt noch
                 -5040 Longs frei

27-07-2014       -Mausbedienung komplett
                 -soweit funktioniert alles, jetzt müsste noch etwas Optimierung ran
                 -4981 Longs frei

14-08-2014       -Darstellungsfehler bei der Parameterübernahme aus Settingdatei behoben und etwas Optimierung
                 -5018 Longs frei

}}

obj
    ios    : "reg-ios-Modul"
    TMRS   : "timer"

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
tmp_buffer  = $41000 'temporärer Parameterspeicher
'-------- Speicher für Dateiliste ---------------
DIR_RAM   = $52C40 '....$5FFFF
'-------- Speicher für Systemfont ---------------
SYS_FONT  = $50000 '....$52BFF      ' ab hier liegt der System-Font 11kb
Hour_Glass= $50000+(167*16*4)       ' Platz, wo das Sanduhrsymbol im Systemfont sitzt
MOUSE_RAM = $52C00 '....$52C3F      ' User-Mouse-Pointer 64byte

'******************Farben ********************************************************
  #$FC, Light_Grey, #$A8, Grey, #$54, Dark_Grey
  #$C0, Light_Red, #$80, Red, #$40, Dark_Red
  #$30, Light_Green, #$20, Green, #$10, Dark_Green
  #$1F, Light_Blue, #$09, Blue, #$04, Dark_Blue
  #$F0, Light_Orange, #$E6, Orange, #$92, Dark_Orange
  #$CC, Light_Purple, #$88, Purple, #$44, Dark_Purple
  #$3C, Light_Teal, #$28, Teal, #$14, Dark_Teal
  #$FF, White, #$00, Black

'------------- Wellenformen ------------------------------------------------------
  MUTE = 14, SAW = 16, TRIANGLE = 18, SQUARE = 22, NOISE = 25, SINE = 32, USER = 42

'------------- TASTENCODES -------------------------------------------------------
Backspace    = $C8                     ' PS/2 keyboard backspace key
ESC_KEY      = 27
RETURN_KEY   = 13
Plus_Key     = 43
Minus_Key    = 45
Space_Key    = 32
TAB_KEY      = 9
ENTF_KEY     = 186
EINF_KEY     = 187
POS1_KEY     = 6
END_KEY      = 7
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
LEFT_KEY     = 3
RIGHT_KEY    = 2
'--------------------------------------------------------------------------------

var

  long systemdir                                        'Plexus-System-Verzeichnis
  long setting[11]
  long tmpwert
  byte mountmarker,tmptime
  byte colors[15]                                       'Farbwerte
  byte ma,mb,mc,mz                                            'Maus-Tasten

  byte windowx[4]
  byte windowy[4]
  byte windowxx[4]
  byte windowyy[4]
  byte menuey[4]                                       'y-Koordinate für Start-Menue-Einträge
  byte popupx,popupxx                                   'x und
  byte popupy,popupyy                                   'y-Koordinaten des Popupmenues
  byte popupmarker                                      'Marker für Popupmenue
  byte infomarker
  byte buttonx[11],buttony[11],buttonl[11]
  byte util
  byte timezaehler
    '----------- DCF-Indikator ------------------------------------
  byte dcf_on


  byte textline[13]                                     'Texteingabestring
  byte tmpline[13]                                      'temp-string
  byte font[25]
  byte pwm_on,sweep_on,mute_on                          'PWM-Sweep-und Mute Marker
  byte Waveform                                         'ausgewählte Wellenform
  byte tabkey                                           'Tab-Tasten-Zähler
  byte tmp_wave                                         'temporärer Waveform-Wert
  byte old                                              'alter tabkey-wert
  byte selection                                        'selektierte Datei
  byte Verzeichnis_counter                              'Verzeichnis-Tiefenzähler
  byte scr                                              'scrollmerker für Pfeiltasten
'  byte filestring[13]              'selektierte Datei
  byte buff[8]                     'Dir-Befehl-variablen
  '----------- Hervorhebungsbalken im Explorer ------------------
  byte y_old                        'alte y-Koordinate
  byte highlight                    'Hervorhebungsmarker des Dateinamens
  byte textline_old[13]           'alter Dateiname
  byte old_color                    'alte Farbe des Dateieintrages merken

  word filenumber                                       'Anzahl Dateien
  long pw_von,pw_bis,pw_step
  long sw_von,sw_bis,sw_step
  long scrollende,scrollanfang,zeilenanfang, zeilenende 'Variablen für Scrollfunktion

DAT
   regsys        byte "PLEXUS.DLL",0            'Reg.sys für Rückkehr aus externem Programm
   SYSTEM        Byte "PLEXUS",0                'Plexus-Systemverzeichnis
   ini_file      byte "WAVE.INI",0              'Ini-Datei

DAT
   Butt0         byte "  SAW   ",0
   Butt1         byte "Start  ",0
   Butt2         byte "Cancel",0
   Butt3         byte "TRIANGLE",0
   Butt4         byte "  OK  ",0
   Butt5         byte " SQUARE ",0
   Butt6         byte "  NOISE ",0
   Butt7         byte "  SINE  ",0
   MUTING        byte "  MUTE  ",0
   Butt8         byte "LOAD",0
   Butt9         byte "SAVE",0

   buttons       word @Butt0,@Butt1,@Butt2,@Butt3,@Butt4,@Butt5,@Butt6,@Butt7,@butt8,@butt9
   tab           byte 9,11,13,15,19,21,23,25,9,14,19
   spalte        byte 19,19,19,19,19,17,17,19,25,25,25
   spaces        byte 3,2,2,2,3,5,5,3,7,2,3

   wvp_name      byte ".WVP",0
   new_name      byte "NEW.WVP",0
   PWM_50        byte "50  ",0
   PWM_25        byte "25  ",0
   PWM_12        byte "12.5",0
   PWM_6         byte "6.25",0
   PWM_3         byte "3.12",0
   PWM_1         byte "1.56",0
   PWM_07        byte "0.78",0
   PWM_03        byte "0.39",0

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
    ios.ram_fill(tmp_buffer,48,0)
    Waveform:=SAW
    bytemove(@textline[0],@new_name,strsize(@new_name))
    iniload                                          'Ini-Datei mit Farbwerten laden
    ios.mousepointer(MOUSE_RAM)
    testfenster
    util:=0
    pwm_on:=0
    sweep_on:=0
    tabkey:=-1
    buttonx[1]:=0
    buttony[1]:=29
    buttonl[1]:=7
    print_form(waveform,2,23)
    ios.plxHalt

    '*********************************** Timer-Cog starten ********************************************************************************************************
    TMRS.start(1000)                                                              'Timer-Objekt starten mit 1ms-Aufloesung

    ios.Gen_Start_FunctionGenerator
    Load_Parameter
    Set_Parameter
    'print_win(@textline,1,1)
    repeat

      os_cmdinput                                                               'Hauptprogrammschleife

PRI os_cmdinput | x,y ,i,b,dk,key,tile_nr,pw_r,sw_r
  pw_r:=0
  sw_r:=0
  highlight:=1                                                                                                'keine Hervorhebung
  scr:=0
  repeat
    time                                                                        'Zeit und Datum anzeigen

    ma:=ios.mouse_button(0)                                                     'linke Maustaste
    mb:=ios.mouse_button(1)                                                     'rechte Maustaste
    mz:=ios.mousez
    key:=ios.key
    if key
       'printdec_win(key,1,1)
       Key_Command(key)
'************************** Modulationsautomatik ***************************************************************
    if pwm_on==1
       ifnot mute_on
             if TMRS.isclr(0)
                if setting[1]<setting[2]
                   pw_von+=pw_step
                   if pw_von => pw_bis
                      pw_von:=(setting[1])

                if setting[1]>setting[2]
                   pw_von-=pw_step
                   if pw_von =< pw_bis
                      pw_von:=setting[1]
                ios.Gen_SetPulseWidth(1<<pw_von)
                TMRS.Set(0,setting[0])


    if sweep_on
       ifnot mute_on
             if TMRS.isclr(1)
                if setting[5]<setting[6]
                   sw_von+=sw_step
                   if sw_von=>sw_bis
                      sw_von:=setting[5]
                if setting[5]>setting[6]
                   sw_von-=sw_step
                   if sw_von=<sw_bis
                      sw_von:=setting[5]
                ios.Gen_Frequency(setting[8]+sw_von)
                TMRS.Set(1,setting[4])

'***************************************************************************************************************

'***************************** linke Maustaste **********************************************************************
    if ma==255
       dk:=0
       x:=ios.mousex
       y:=ios.mousey
'****************************** Tile aus Fontdatei vergrößert darstellen ***************************************
       if infomarker==0 and popupmarker==0


'****************************** Auswahl PWM und SWEEP ***********************************************************
          if x==20
             case y
                  7:Key_Command("P")                                            'PWM on/off
                  17:Key_Command("W")                                           'Sweep on/off

          elseif x==7 and y==18
                 Key_Command("M")                                               'MUTE
          elseif x>13 and x<27 and y>8 and y<26
                 util:=2
                 if x=>25 and x=<27
                    repeat i from 8 to 10
                       if y==tab[i]
                          tabkey:=i
                          quit
                 else
                    repeat i from 0 to 7
                          if y==tab[i]
                             tabkey:=i
                             quit
                 tmpwert:=setting[tabkey]
                 Ausgabe_Wert(old,setting[old],tab[old],spalte[old],0)
                 Ausgabe_Wert(tabkey,setting[tabkey],tab[tabkey],spalte[tabkey],1)
                 old:=tabkey

'****************************** Startmenue anzeigen ************************************************************
       if popupmarker==1
          if x>10 or y<22                                                       'Menue loeschen, wenn man woanders hinklickt
             popup_info_weg
             util:=0
          if x=>0 and x=<10 and y=>23 and y=<28
             repeat i from 0 to 3
                 if menuey[i]==y

                    case i
                         0:menueselect(string("Info  - F1"),menuey[i])
                           Key_Command(F1_Key)
                         1:menueselect(string("Load  - F2"),menuey[i])
                           Key_Command(F2_Key)
                         2:menueselect(string("Save  - F3"),menuey[i])
                           Key_Command(F3_Key)
                         3:menueselect(string("-EXIT- F12"),menuey[i])
                           Key_Command(F12_Key)


       if util==4 and x>12 and x<25 and y>7 and y<18
          selection:=y-7
          getfilename(selection+scrollanfang)                                                       'selektierte Datei nr
          highlight_selection(y)
          if doppelklick
             popup_info_weg
             select_file
             util:=0

'****************************** Globale Funktionstasten ********************************************************



       if y==windowy[2] and x==windowx[2] and Infomarker==1                     'doppelklick in linke obere ecke des Info-Fensters
          if doppelklick>1
             popup_info_weg
             util:=0

       elseif y==windowy[2] and x==windowxx[2] and Infomarker==1
          ios.get_window
          popup_info_weg
          util:=0

       elseif y==0
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
                Key_Command(F1_Key)


       else
           repeat b from 0 to 9
              if (x=>buttonx[b]) and (x=<buttonx[b]+buttonl[b]) and (y==buttony[b])

                 buttonpress(b)
                 case b
                      0:Key_Command("A")                                        'SAW
                      1:if popupmarker==1
                           popup_info_weg
                        else
                           popup_info_weg
                           startmenue
                        mouse_release
                        quit
                      2:Key_Command(ESC_KEY)
                      3:Key_Command("T")                                        'TRIANGLE
                      4:Key_Command(Return_Key)
                      5:Key_Command("Q")                                        'SQUARE
                      6:Key_Command("N")                                        'NOISE
                      7:Key_Command("S")                                        'SINE
                      8:Key_Command(F2_KEY)                                     'Load
                      9:Key_Command(F3_KEY)                                     'Save

'**************************** Maus Scrollrad ****************************************
    if mc>mz or (x==31 and y=>6 and y=<11 and ma==255)                                                         'hochscrollen
      if popupmarker==0
        if util==4                                                                                             'Dateifenster nur scrollen, wenn kein Infofenster angezeigt wird (byte kann keine -1 sein also 255)
           if filenumber>10                                                                                    'Dateianzahl höher als Zeilen im Dateifenster?
              scrollrunter                                                                                     'Bildschirm scrollen
              if scr>0
                 scr--
              mc:=mz

    if mc<mz or (x==31 and y=<18 and y=>12 and ma==255)                                                        'runterscrollen
      if popupmarker==0
        if util==4                                                                                             'Dateifenster nur scrollen, wenn kein Infofenster angezeigt wird
           if filenumber>10
              scrollhoch                                                                                       'Bildschirm scrollen
              if scr<filenumber-10
                    scr++
              mc:=mz

PRI toogle_value(at,x,y)
    Mouse_Release
    if at==1
       Win_Tile(140,y,x)
       at:=0
    else
       at:=1
       Win_Tile(139,y,x)
    return at
pri select_file

    ios.sdmount
    activate_dirmarker(systemdir)
    load_in_ram(@textline)
    ios.sdclose
    save_ini_name
    ios.sdunmount
    Load_Parameter
    Set_Parameter

pri Key_Command(k)|i,tmp
    ifnot util==4' k>5 and k<4
       popup_info_weg
    'util:=0
    case k
         F1_Key:util:=0
                Display_Info
         F2_Key:SD_Card
         F3_Key:Save_fenster
         F12_Key:ausstieg
         ESC_KEY:if util==2
                    setting[tabkey]:=tmpwert
                    Print_Spaces(spaces[tabkey],spalte[tabkey],tab[tabkey])
                    Ausgabe_Wert(tabkey,setting[tabkey],tab[tabkey],spalte[tabkey],0)
                 popup_info_weg
                 util:=0
         RETURN_KEY:if util==2                           'Werteauswahl
                       Print_Spaces(spaces,spalte[tabkey],tab[tabkey])
                       Ausgabe_Wert(tabkey,setting[tabkey],tab[tabkey],spalte[tabkey],0)

                    elseif util==4                          'Load-Fenster
                       '******************************Dateien starten oder Verzeichnis wechseln*************
                       if selection=<filenumber
                          select_file
                          getfilename(selection)                                                                           'selektierte Datei untersuchen und starten oder anzeigen oder Verzeichnis öffnen

                    popup_info_weg
                    util:=0
         TAB_KEY:if infomarker==0 and popupmarker==0
                    tabkey++
                    util:=2
                    if tabkey>10 or tabkey==0
                       tabkey:=0

                    tmpwert:=setting[tabkey]
                    Ausgabe_Wert(old,setting[old],tab[old],spalte[old],0)
                    Ausgabe_Wert(tabkey,setting[tabkey],tab[tabkey],spalte[tabkey],1)
                    old:=tabkey

         "A","a":Waveform:=SAW
         "T","t":Waveform:=TRIANGLE
         "Q","q":Waveform:=SQUARE
         "N","n":Waveform:=NOISE
         "S","s":Waveform:=SINE
         "M","m":Mute_on:=toogle_value(Mute_ON,7,18)                                                     'Mute
                 if mute_on
                    tmp_wave:=waveform
                    waveform:=mute
                 else
                    waveform:=tmp_wave

         "P","p":pwm_on:=toogle_value(pwm_ON,20,7)                                                       'pwm an/aus
                 ifnot pwm_on
                       ios.Gen_SetPulseWidth(setting[10])

         "W","w":sweep_on:=toogle_value(sweep_ON,20,17)                                                  'sweep an/aus
                 ifnot sweep_on
                       ios.Gen_Frequency(setting[8])


         4:if util==2
              setting[tabkey]++
           elseif util==4
                IF selection>1
                   selection--
                   getfilename(selection+scr)

                if selection==1 and scr>0
                   scrollrunter
                   scr--
                highlight_selection(selection+7)

         5:if util==2
              setting[tabkey]--
           elseif util==4
                if selection<filenumber
                   selection++
                   getfilename(selection+scr)
                if selection>10
                   if scr<filenumber-10
                      scrollhoch
                      scr++
                   selection:=10
                highlight_selection(selection+7)                                                              'Bildschirm scrollen

         160:if util==2
                setting[tabkey]+=10
         162:if util==2
                setting[tabkey]-=10
         6:if util==2 and (tabkey==5 or tabkey==6 or tabkey==8)
                setting[tabkey]+=1000
         7:if util==2 and (tabkey==5 or tabkey==6 or tabkey==8)
                setting[tabkey]-=1000
         2:if util==2 and tabkey==8
                setting[tabkey]-=100000
         3:if util==2 and tabkey==8
                setting[tabkey]+=100000

    print_form(waveform,2,23)

    if util==2                                                                                           'Check auf Grenzwerte und anzeigen

       case tabkey
            0,4: setting[tabkey]:=check_limits(setting[tabkey],0,999)
            1..3: setting[tabkey]:=check_limits(setting[tabkey],0,31)
            7:    setting[tabkey]:=check_limits(setting[tabkey],0,999)
            5,6:  setting[tabkey]:=check_limits(setting[tabkey],0,99999)
            8:    setting[tabkey]:=check_limits(setting[tabkey],0,7500000)
            9:    setting[tabkey]:=check_limits(setting[tabkey],0,4)
            10:   setting[tabkey]:=check_limits(setting[tabkey],24,31)

       Print_Spaces(spaces[tabkey],spalte[tabkey],tab[tabkey])
       Ausgabe_Wert(tabkey,setting[tabkey],tab[tabkey],spalte[tabkey],1)
    Set_Parameter

PRI Print_Spaces(n,x,y)
    repeat n
           print_win(string(" "),x++,y)

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
                display_Filename(@textline,8,colors[act_color])'Scan_File(4)
                scrollanfang--
                scrollende--
                y_old++

PRI scrollhoch
             if scrollende<filenumber
                ios.scrollup(1,colors[winhcol], 8, 13, 17, 29,1)
                getfilename(scrollende+1)
                display_Filename(@textline,18,colors[act_color])'Scan_File(24)
                scrollende++
                scrollanfang++
                y_old--
             if scrollende>filenumber
                scrollende:=filenumber
                scrollanfang:=filenumber-9

PRI highlight_selection(position)                                                                            'Dateiname mit einem farbigen Balken hervorheben

  if util==4 and position>7                                                                                  'nur im Dateifenster ab position y==4 hervorheben
    'if highlight                                                                                             'erstes mal Datei angeklickt(keine Old-Parameter)

       display_line(@textline,position,colors[winhcol],colors[act_color])                                    'Dateiname mit Balken anzeigen

    if {highlight and }strsize(@textline_old)>0                                                                'Hervorhebung aktiv und String im Puffer?

       display_line(@textline_old,y_old,colors[act_color],colors[winhcol])                                    'alter Dateiname an alter Position ohne Balken anzeigen
    bytemove(@textline_old,@textline,12)                                                                      'neuen Dateinamen in den Puffer schreiben
    y_old:=position                                                                                           'y-Koordinate merken

PRI display_Line(stradr,ty,vor,hin)                                                                           'Ausgabe Dateiname, Icon, Größe und Erstellungsdatum

    printfont(stradr,hin,0,vor,13,ty)
pri Ausgabe_Wert(n,w,y,x,inv)|j
    if inv
       case n
            0..8:printdec_win_inv(setting[n],tab[n],spalte[n])
            9:   printdec_win_inv(setting[n]*6,tab[n],spalte[n])
            10:  case setting[n]
                             31:print_win_inv(@PWM_50,spalte[n],tab[n])
                             30:print_win_inv(@PWM_25,spalte[n],tab[n])
                             29:print_win_inv(@PWM_12,spalte[n],tab[n])
                             28:print_win_inv(@PWM_6,spalte[n],tab[n])
                             27:print_win_inv(@PWM_3,spalte[n],tab[n])
                             26:print_win_inv(@PWM_1,spalte[n],tab[n])
                             25:print_win_inv(@PWM_07,spalte[n],tab[n])
                             24:print_win_inv(@PWM_03,spalte[n],tab[n])


    else
       case n
            0..8:printdec_win(setting[n],tab[n],spalte[n])
            9:   printdec_win(setting[n]*6,tab[n],spalte[n])
            10:  case setting[n]
                             31:print_win(@PWM_50,spalte[n],tab[n])
                             30:print_win(@PWM_25,spalte[n],tab[n])
                             29:print_win(@PWM_12,spalte[n],tab[n])
                             28:print_win(@PWM_6,spalte[n],tab[n])
                             27:print_win(@PWM_3,spalte[n],tab[n])
                             26:print_win(@PWM_1,spalte[n],tab[n])
                             25:print_win(@PWM_07,spalte[n],tab[n])
                             24:print_win(@PWM_03,spalte[n],tab[n])



pri check_limits(act_wert,min_wert,max_wert):ergebnis
    ergebnis:=act_wert
    if act_wert<min_wert
       ergebnis:=max_wert
    if act_wert>Max_wert
       ergebnis:=min_wert

PRI printdec_win(n,y,x)
    printdec(n,y,x,colors[winhcol],colors[act_color])
PRI printdec_win_inv(n,y,x)
    printdec(n,y,x,colors[act_color],colors[winhcol])
PRI print_titel(stradr,x,y):a
    a:=printfont(stradr,colors[titelhcol],0,colors[titeltextcol],x,y)
pri print_form(n,x,y)

   case n
        SAW:print_win(@Butt0,x,y)
        TRIANGLE:print_win(@Butt3,x,y)
        SQUARE:print_win(@Butt5,x,y)
        NOISE:print_win(@Butt6,x,y)
        SINE:print_win(@Butt7,x,y)
        'USER:print_win(@muting,x,y)



PRI printbin(value, digits,hint,vor,x,y) |c                                                                   'screen: binären zahlenwert auf bildschirm ausgeben

  value <<= 32 - digits
  repeat digits
     c:=(value <-= 1) & 1 + "0"
     ios.displaytile(c-16,hint,0,vor,y,x++)
con'--------------------------------------------------- Datei-Ladefenster ---------------------------------------------------------------------------------------------------------
PRI SD_Card:msz|b
            b:=0
            util:=4
               'reset_Highlight                                                                                'Hervorhebungsparameter löschen
               popup_info_weg
               ios.backup_area(13-1,8-2,30+1,18+1,BRAM)               'Hintergrund sichern
               window(2,8,8,13,18,30,@butt8) 'Programmfenster(8,ios.sdvolname)
               infomarker:=1
               cmd_dir
               msz:=show_always                                                                               'Dateiliste aus dem E-Ram anzeigen


PRI display_list(a,b)|n,tt                                                                                    'Dateiliste aus dem Speicher lesen und anzeigen
    tt:=7
    repeat n from a to b
           getfilename(n)
           display_filename(@textline,tt,colors[act_color])
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


PRI cmd_dir|stradr,n,d,c,ty',sh                                                                                  'cmd: verzeichnis anzeigen
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
         scanstr_ext(stradr,1)
         if strcomp(@buff,@wvp_name)
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

PRI scanstr_ext(f,mode) | z ,c ,a ,i                                                                                  'Dateiendung extrahieren
   if mode==1
      repeat while strsize(f)
             if c:=byte[f++] == "."                                                                           'bis punkt springen
                quit
   f--
   z:=0
   repeat 4                                                                                                   'dateiendung lesen
        c:=byte[f++]
        buff[z++] := c
   buff[z++] := 0
   return @buff
PRI display_Filename(stradr,ty,col)|p                                                                         'Ausgabe Dateiname, Icon, Größe und Erstellungsdatum

    if strsize(stradr)>0 and ty<18
               print_win(stradr,13,ty)

con'--------------------------------------------------- Speicherroutine -----------------------------------------------------------------------------------------------------------
PRI Save_Fenster:s|l
    infofenster(9,10,29,15,string("Save Parameter"),1)          'Info-Fenster anzeigen
    util:=3
    Print_win(string("Filename:"),9,10)
    scanstr(@textline)
    Print_win(@textline,18,10)
    print_win(string(".WVP"),26,10)
    s:=Text_Input(18,26,10,0,8)
    l:=strsize(@textline)
    if l<1
       bytemove(@textline[0],@new_name,7)
       l:=7
    else
       bytemove(@textline[l],@wvp_name,4)
    textline[l+4]:=0
    ios.display2dbox(colors[winhcol],23,25,24,36,0)
    print_win(@textline,25,23)

    if s==13
       popup_info_weg
       util:=0
       Save_File(@textline)

PRI Save_File(str)|adr,count,i
    ios.sdmount
    activate_dirmarker(systemdir)
    adr:=tmp_buffer
    i:=0
    repeat 11                                                                   'Longs in den Tmp-Puffer schreiben
           ios.ram_wrlong(setting[i++],adr)
           adr+=4
    ios.ram_wrbyte(waveform,adr++)
    ios.ram_wrbyte(pwm_on,adr++)
    ios.ram_wrbyte(sweep_on,adr++)
    ios.ram_wrbyte(mute_on,adr)

    adr:=tmp_buffer
    if ifexist(str)
       ios.mousepointer(hour_glass)                                            'Sanduhr anzeigen
       ios.sdopen("W",str)
       ios.sdseek(0)
       repeat 48                                                               'Parameter vom Tmp-Puffer auf SD-Karte schreiben
              ios.sdputc(ios.ram_rdbyte(adr++))
       ios.sdputc(0)
       ios.sdclose

       save_ini_name
       ios.mousepointer(Mouse_ram)                                             'Mauszeiger anzeigen

    else
       ios.sdclose

    ios.sdunmount
pri save_ini_name|i

       i:=0
       ios.sddel(@ini_file)                                                     'alte ini-datei löschen
       ios.sdnewfile(@ini_file)                                                 'datei neu erstellen
       ios.sdopen("W",@ini_file)
       i:=0
       repeat strsize(@textline)
              ios.sdputc(textline[i++])                                         'Dateiname in die ini-Datei schreiben
       ios.sdputc(0)
       ios.sdclose

PRI Load_Parameter|adr,i
    i:=0
    adr:=tmp_buffer

    repeat i from 0 to 10                                                                   'Longs aus dem Tmp-Puffer lesen
           setting[i]:=ios.ram_rdlong(adr)
           Print_Spaces(spaces[i],spalte[i],tab[i])
           Ausgabe_Wert(i,setting[i],tab[i],spalte[i],0)'display_parameter(i++)
           adr+=4
    waveform:=ios.ram_rdbyte(adr++)
    pwm_on  :=ios.ram_rdbyte(adr++)
    sweep_on:=ios.ram_rdbyte(adr++)
    mute_on :=ios.ram_rdbyte(adr++)
    Win_Tile(140-Mute_on,18,7)                                                        'Mute
    Win_Tile(140-pwm_on,7,20)                                                       'pwm an/aus
    Win_Tile(140-sweep_on,17,20)                                                  'sweep an/aus
    print_form(waveform,2,23)
    print_win(@textline,25,23)

    if mute_on
       tmp_wave:=waveform
       waveform:=mute

'pri display_parameter(n)
    'printdec_win(setting[n],tab[n],spalte[n])
'    Ausgabe_Wert(n,setting[n],spalte[n],tab[n],0)

pri Set_Parameter|pwm_wert
    pwm_wert:=1<<setting[10]
    ios.Gen_SetParameter(waveform, setting[8], setting[9], pwm_wert)
    pw_von:=setting[1]
    pw_bis:=setting[2]
    pw_step:=setting[3]
    sw_von:=setting[5]
    sw_bis:=setting[6]
    sw_step:=setting[7]
    TMRS.set(0,setting[0])
    TMRS.set(1,setting[4])

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

PRI ram_txt(nummer)|c,i,ad
    i:=0
    ad:=TXT_RAM+((nummer-1)*25)
         repeat while (c:=ios.Read_Flash_Data(ad++))<$FF'c:=ios.ram_rdbyte(ad++)
                 if c>13
                    font[i++]:=c
    font[i]:=0
    return @font

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

    button(4,10,15)
    button(2,1+laenge,15)

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
                       if spalte>min_x
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

PRI Display_Info
    infofenster(9,10,31,15,string("Program-Info"),1)          'Info-Fenster anzeigen
    Print_win(string("Wave-Generator for Hive"),9,10)
    Print_win(string("Version 1.1 - 07/2014"),9,11)
    Print_win(string("Autor:R.Zielinski"),9,12)
    Print_win(string("Hive-Project.de"),9,13)

PRI infofenster(x,y,xx,yy,strg,knopf)'|i

    ios.backup_area(x-1,y-2,xx+1,yy+1,BRAM)               'Hintergrund sichern
    window(2,4,y,x,yy,xx,strg)                            'Fenster erstellen
    if knopf==1
       button(4,((xx-x)/2)+x-2,yy)
    if knopf==2
       button(2,((xx-x)/2)+x-2,yy)
    infomarker:=1

PRI button(n,x,y)
    buttonx[n]:=x
    buttony[n]:=y
    buttonl[n]:=strsize(@@buttons[n])
    if n==1
       printfont(@@buttons[n],colors[hcolstatus],0,colors[statustextcol],x,y)
    else
       printfont(@@buttons[n],colors[buttonhcol],0,colors[buttontextcol],x,y)

PRI Mouse_Release
    repeat while ios.mouse_button(0)                                             'warten bis Maustaste losgelassen wird

pri ausstieg

    ios.DisplayMouse(1,colors[mousecol])
    ios.mousepointer(hour_glass)
    ios.GEN_Stop_FunctionGenerator
    ios.plxrun
    ios.ld_rambin(2)
    'cmd_mount
    'activate_dirmarker(systemdir)
    'ios.sdopen("r",@regsys)
    'ios.ldbin(@regsys)


pri testfenster|a

    a:=0
    window(0,4,2,1,27,38,string("Wave-Generator V1.1"))
    rahmen (12,5,38,27)
    rahmen (1,1,38,3)
    Print_win(string("Wave-Generator for Hive-Computer"),2,2)

    rahmen (1,5,10,20)
    rahmen (1,21,10,27)
    Print_win(string("Waveform"),2,5)
    Print_win(string("select"),2,21)
    print_win(string("Settings"),13,5)

    rahmen (13,7,22,16)
    print_win(string("PWM"),14,7)
    ios.displaytile(140,colors[winhcol],0,colors[act_color],7,20)
    print_win(string("RATE:"),14,9)
    print_win(string("from:"),14,11)

    print_win(string("to  :"),14,13)

    print_win(string("Step:"),14,15)

    rahmen (13,17,22,26)
    print_win(string("SWEEP"),14,17)
    ios.displaytile(140,colors[winhcol],0,colors[act_color],17,20)
    print_win(string("RATE:"),14,19)
    print_win(string("fr:"),14,21)

    print_win(string("to:"),14,23)

    print_win(string("Step:"),14,25)

    print_win(string("Mute:"),2,18)
    ios.displaytile(140,colors[winhcol],0,colors[act_color],18,7)
    button(0,2,7)
    button(3,2,9)
    button(5,2,11)
    button(6,2,13)
    button(7,2,15)

    rahmen (24,7,37,11)
    print_win(string("Frequency"),25,7)
    print_win(string("HZ"),35,9)

    rahmen (24,12,37,16)
    print_win(string("Damp-Level"),25,12)
    print_win(string("DB"),35,14)

    rahmen (24,17,37,21)
    print_win(string("Pulse-Width"),25,17)
    print_win(string("%"),35,19)

    rahmen(24,22,37,26)
    print_win(string("File"),25,22)
    button(8,25,25)
    button(9,33,25)



PRI Print_win(str,x,y)
    printfont(str,colors[winhcol],0,colors[act_color],x,y)
PRI Print_win_inv(str,x,y)
    printfont(str,colors[act_color],0,colors[winhcol],x,y)

PRI printhex(value, digits,x,y,back,vor)|wert                             'screen: hexadezimalen zahlenwert auf bildschirm ausgeben
{{hex(value,digits) - screen: hexadezimale bildschirmausgabe eines zahlenwertes}}
  value <<= (8 - digits) << 2
  repeat digits
    wert:=lookupz((value <-= 4) & $F : "0".."9", "A".."F")
    ios.displaytile(wert-16,back,0,vor,y,x++)

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
      'printdec(dcf_on,1,1,colors[winhcol],colors[act_color])
con'
PRI doppelklick:click                            'pseudo-doppelklick
    click:=0
    'ios.get_window
    Mouse_Release

    repeat 500
       if ios.mouse_button(0)==255
          click++

con'
PRI iniload|i,a,c,adr
          a:=SETTING_RAM
          repeat i from 0 to 14
               colors[i]:=ios.Read_Flash_Data(a++)'ios.ram_rdbyte(a++)
          dcf_on:=ios.Read_Flash_Data(a+3)'ios.ram_rdbyte(a+3)
     ios.sdmount
     activate_dirmarker(systemdir)
     ifnot ios.sdopen("r",@ini_file)
           i:=0
           '********* Dateinamen der letzten Setting-Datei lesen ********
           repeat
                  c:=ios.sdgetc
                  tmpline[i++]:=c
           until ios.sdeof
           tmpline[i]:=0
           bytemove(@textline[0],@tmpline,strsize(@tmpline))
           ios.sdclose
           'print_win(@textline,1,1)
           '********* Parameter der Setting-Datei in den Ram schreiben **
           load_in_ram(@textline)
           'ifnot ios.sdopen("r",@textline)
           '      adr:=tmp_buffer
           '      repeat
           '             ios.ram_wrbyte(ios.sdgetc,adr++)
           '      until ios.sdeof

     ios.sdclose
     ios.sdunmount
pri load_in_ram(str)|adr

               ifnot ios.sdopen("r",str)
                 adr:=tmp_buffer
                 repeat
                        ios.ram_wrbyte(ios.sdgetc,adr++)
                 until ios.sdeof

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

PRI window(num,cntrl,y,x,yy,xx,strg)                         'ein Fenster erstellen

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
con '************************************************** Button-Funktionen ********************************************************************************************************

PRI buttonpress(n)
    printfont(@@buttons[n],250,0,0,buttonx[n],buttony[n])
    if n==1
       printfont(@@buttons[n],250,0,0,buttonx[n],buttony[n])
       ios.displaytile(144,colors[shellhcol],250,colors[shellhcol],29,7)
    else
       printfont(@@buttons[n],250,0,0,buttonx[n],buttony[n])
    Mouse_Release
    if n==1
       printfont(@@buttons[n],colors[hcolstatus],0,colors[statustextcol],buttonx[n],buttony[n])
       ios.displaytile(144,colors[shellhcol],colors[hcolstatus],colors[shellhcol],29,7)
    else
       printfont(@@buttons[n],colors[Buttonhcol],0,colors[buttontextcol],buttonx[n],buttony[n])

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
    printfont(string("Info  - F1"),colors[messagehcol],0,colors[messagetextcol],0,23)
    menuey[0]:=23
    printfont(string("Load  - F2"),colors[messagehcol],0,colors[messagetextcol],0,24)
    menuey[1]:=24

    printfont(string("Save  - F3"),colors[messagehcol],0,colors[messagetextcol],0,25)
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
             ios.restore_area(popupx,popupy,popupxx,popupyy,BRAM)                          'Hintergrund wiederherstellen
             popupmarker:=0                                                        'Popupmarker loeschen
          if infomarker==1
             ios.restore_area(windowx[2],windowy[2],windowxx[2],windowyy[2],BRAM)                          'Hintergrund wiederherstellen
             buttonx[2]:=buttony[2]:=buttonl[2]:=buttonx[4]:=buttony[4]:=buttonl[4]:=-1                         'Buttonwerte löschen
             infomarker:=0


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

