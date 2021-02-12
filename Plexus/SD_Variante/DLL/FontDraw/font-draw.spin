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
Name            : Font-Editor
Chip            : Regnatix
Typ             : Plexus-Erweiterungsdatei
Version         : 01
Subversion      : 01


Logbuch         :
'############################################### Version 1.0 ######################################################################################################################

01-07-2014       -Fontbearbeitung abgeschlossen,fehlt nur noch das Speichern des gesamten Font-Satzes
                 -6170 Longs frei

02-07-2014       -Fonteditor soweit fertig, die Pixelroutine funktioniert noch nicht hundertprozentig, es werden manchmal falsche Pixel übernommen
                 -muss ich nochmal drüberschauen
                 -6032 Longs frei

03-07-2014       -Pixelroutine scheint jetzt halbwegs zu funktionieren, mal sehen, wie es sich über die Zeit darstellt
                 -Sanduhr beim Speichern des Font-Satzes eingebaut
                 -6014 Longs frei

04-07-2014       -mit verschiedenen Bit-Operationen herumexperimentiert
                 -Funktionen:Links schieben, rechts schieben, invertieren, horizontal spiegeln
                 -schön wäre noch eine Rotationsfunktion
                 -5984 Longs frei

05-07-2014       -Button-Abfrage etwas eingedampft
                 -Button OK und Abbruch müssen separat gelöscht werden, da sie auch nach dem Verschwinden anklickbar waren ->erledigt
                 -Tastatur-Befehle realisiert
                 -Fehler in der Buttondarstellung behoben, obwohl es nicht nachvollziehbar war, warum falscher Text im Button angezeigt wurde ->Compilierfehler?
                 -Bit-Korrektur bei Mirror und Revers-Funktion (Grau wurde von 2 zu 1 ->diese musste wieder zur 2 werden, sonst wird das Icon falsch dargestellt)
                 -Editor soweit fertig (Rotation fehlt noch, ob ich das hinbekomme weis ich noch nicht)
                 -nun muss noch der Code optimiert werden
                 -5748 Longs frei

'############################################### Version 1.1 ######################################################################################################################

06-07-2014       -Rotationsfunktion eingefügt, funktioniert !
                 -Buttonverarbeitung etwas umgebaut und dadurch Platz gespart
                 -Fehler in der Rotate-Routine behoben, wurde ein gezeichnetes Tile rotiert entstanden Darstellungsfehler
                 -kleinere Korrekturen in der Tastaturabfrage+Mouse
                 -So, jetzt sollte der Editor endlich fehlerfrei sein (hoffentlich)
                 -5765 Longs frei

13-07-2014       -Fehler in der Save-Routine, genauer gesagt, speichert man den Fontsatz(bei existierender Datei), funktioniert die Rückkehr zu Plexus nicht mehr ???
                 -hab noch keine Ahnung was das nun wieder ist :-(
                 -5782 Longs frei

18-07-2014       -Fehler in der Save-Routine behoben (Variable @font war zu klein dimensioniert)
                 -Abfrage in der Save-Routine eingedampft
                 -so, ich hoffe das war's endlich
                 -5788 Longs frei
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
'-------- Speicher für diverse Texte ------------
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
LEFT_KEY     = 3
RIGHT_KEY    = 2
'--------------------------------------------------------------------------------

var

  long systemdir                                        'Plexus-System-Verzeichnis
  long fontdir                                          'Fonts-Verzeichnis
  long einzel_tile[16]                                  'das zu zeichnende Tile
  long tmp[16],temp[16]                                  'das zu zeichnende Tile
  Byte Pix[256]                                         'Pixelmap für Manipulation

  byte tmptime
  byte colors[15]                                       'Farbwerte
  byte ma,mb                                            'Maus-Tasten

  byte windowx[3]
  byte windowy[3]
  byte windowxx[3]
  byte windowyy[3]
  byte menuey[3]                                       'y-Koordinate für Start-Menue-Einträge
  byte popupx,popupxx                                   'x und
  byte popupy,popupyy                                   'y-Koordinaten des Popupmenues
  byte popupmarker                                      'Marker für Popupmenue
  byte infomarker
  byte buttonx[11],buttony[11],buttonl[11]
  byte util
  byte timezaehler
    '----------- DCF-Indikator ------------------------------------
  byte dcf_on

  byte tile_nr_old
  byte tilex_old
  byte tiley_old
  byte paintfarbe                                       'Malfarbe
  byte Set_Marker                                       'Marker, um Tile zu setzen
  byte textline[12]                                     'Texteingabestring
  byte font[25]                                         'Hilfsstring

DAT
   regsys        byte "PLEXUS.DLL",0            'Reg.sys für Rückkehr aus externem Programm

DAT
   Butt0         byte "Clear",0
   Butt1         byte "Start  ",0
   Butt2         byte "Cancel",0
   Butt3         byte " Set ",0
   Butt4         byte "  OK  ",0
   Butt5         byte " Save ",0
   Butt6         byte "Right ",0
   Butt7         byte " Left ",0
   Butt8         byte " Flip ",0                 'Mirror
   Butt9         byte "Invert",0                 'Invert
   Butt10        byte "Rotate",0

   buttons       word @Butt0,@Butt1,@Butt2,@Butt3,@Butt4,@Butt5
                 word @Butt6,@Butt7,@Butt8,@Butt9,@Butt10

   fnt_name      byte ".FNT",0
   new_name      byte "NEW.FNT",0
   fonts         byte "FONTS",0                 'Font-Verzeichnis



PUB main

    ios.start
'    ios.sdmount                                     'sd-card mounten
    '--------------------------------------------------------------------------------------
'    activate_dirmarker(0)                            'ins root
'    ios.sdchdir(@system)                             'System-Verzeichnis lesen
    systemdir:=get_dirmarker                         'Dir-Marker lesen
    ios.sdchdir(@fonts)                              'ins Font-Verzeichnis wechseln
    fontdir:=get_dirmarker                           'Dir-Marker lesen
    activate_dirmarker(systemdir)
    '--------------------------------------------------------------------------------------
    ios.sdunmount
    iniload                                          'Ini-Datei mit Farbwerten laden
    ios.mousepointer(MOUSE_RAM)
    testfenster
    util:=0
    Set_Marker:=0
    tile_nr_old:=0
    tilex_old:=21
    tiley_old:=11
    paintfarbe:=black
    ios.DisplayMouse(1,paintfarbe)
    bytemove(@textline[0],@new_name,strsize(@new_name))
    buttonx[1]:=0
    buttony[1]:=29
    buttonl[1]:=7

    repeat

      os_cmdinput                           'Hauptprogrammschleife

PRI os_cmdinput | x,y ,i,b,dk,key,tile_nr

  repeat
    time                                                                                           'Zeit und Datum anzeigen

    ma:=ios.mouse_button(0)                                                                        'linke Maustaste
    mb:=ios.mouse_button(1)                                                                        'rechte Maustaste
    key:=ios.key
    if key
       Key_Command(key)

'***************************** linke Maustaste **********************************************************************
    if ma==255
       dk:=0
       x:=ios.mousex
       y:=ios.mousey
'****************************** Tile aus Fontdatei vergrößert darstellen ***************************************
       if infomarker==0 and popupmarker==0
          if x=>21 and x=<36 and y=>11 and y=<21

             Tile_nr:=(x-21)+((y-11)*16)
             if Set_marker                                                                                                'gezeichnetes Tile in Fontsatz übernehmen
                Set_Tile(Tile_nr)
                ios.loadtilebuffer(SYS_FONT,2816)
                clear_set
             else
                print_win(string("   "),7,7)                                                                              'Tile-Nr-Feld löschen
                printdec(tile_nr,7,7,colors[act_color],colors[winhcol])'printdec_win(tile_nr,1,1)                         'Anzeige gewähltes Tile  (nr)
                ios.displaytile(tile_nr_old,colors[winhcol],colors[panelcol],0,tiley_old,tilex_old)                       'altes gewähltes tile normal darstellen
                ios.displaytile(tile_nr,colors[panelcol],colors[winhcol],0,y,x)                                           'neues gewähltes Tile revers darstellen
                Draw_tile(tile_nr)                                                                                        'gewähltes Tile vergrößert darstellen
                tile_nr_old:=tile_nr
                tilex_old:=x
                tiley_old:=y


'****************************** im linken Fenster Zeichnen mit der aktuellen Farbe *****************************
          elseif x=>3 and x=<18 and y=>9 and y=<24
                 Paint_Pixel(x,y)
                 if set_marker
                    clear_set

'****************************** Auswahl Zeichenfarbe ***********************************************************
       if y==5
            case x
                 9,10:Key_Command("W")
                 12,13:Key_Command("G")
                 15,16:Key_Command("B")

'****************************** Startmenue anzeigen ************************************************************
       if popupmarker==1
          if x>10 or y<24                                         'Menue loeschen, wenn man woanders hinklickt
             popup_info_weg
             util:=0
          if x=>0 and x=<10 and y=>25 and y=<28
             repeat i from 0 to 1
                 if menuey[i]==y

                    case i
                         0:menueselect(string("Save  - F2"),menuey[i])
                           Save_fenster

                         1:menueselect(string("-EXIT- F12"),menuey[i])
                           ausstieg



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
           repeat b from 0 to 10
              if (x=>buttonx[b]) and (x=<buttonx[b]+buttonl[b]) and (y==buttony[b])
                 if b==6 and popupmarker==1                                     'Button 6 kann durch Startmenue verdeckt sein, dann nicht auswählbar
                    quit
                 buttonpress(b)
                 case b
                      0:Key_Command("C")
                      1:if popupmarker==1
                           popup_info_weg
                        else
                           startmenue
                        mouse_release
                        clear_set
                        quit
                      2:Key_Command(ESC_KEY)
                      3:mouse_release
                        Key_Command("S")
                        quit

                      4:Key_Command(Return_Key)
                      5:Key_Command(F2_Key)                                     'SAVE
                      6:Key_Command(Right_Key)                                  'rechts schieben
                      7:Key_Command(Left_Key)                                   'links schieben
                      8:Key_Command("F")                                        'spiegeln
                      9:Key_Command("I")                                        'revers darstellen
                      10:Key_Command("R")                                       'Icon rotieren, noch offen


pri clear_set
    print_win(string("               "),20,5)
    Set_marker:=0

pri Key_Command(k)|i
    popup_info_weg
    util:=0
    case k
         F1_Key:Display_Info
         F2_Key:Save_Fenster
         F12_Key:ausstieg
         ESC_KEY:popup_info_weg
                 print_win(string("               "),20,5)
                 Set_marker:=0
         RETURN_KEY:popup_info_weg
         "G","g":paintfarbe:=grey                                               'grey
                 ios.DisplayMouse(1,paintfarbe)
         "W","w":paintfarbe:=white                                              'white
                 ios.DisplayMouse(1,paintfarbe)
         "B","b":paintfarbe:=black                                              'black
                 ios.DisplayMouse(1,paintfarbe)
         "S","s":print_win(string("Choose Position"),20,5)                      'SET
                 Set_Marker:=1'set
         "F","f":repeat i from 0 to 15
                        einzel_tile[i]><=32                                     'Icon horizontal spiegeln
                 mirror_tile
                 actuali_tile(1)
         "I","i":repeat i from 0 to 15
                        !einzel_tile[i]                                         'Icon invers darstellen
                 mirror_tile
                 actuali_tile(1)

         "R","r":actuali_tile(0)
                 Rotate_Icon
                 actuali_tile(1)

         "C","c":ios.display2dbox(white,9,3,24,18,0)                            'CLEAR
                 longfill(@einzel_tile,0,16)
                 bytefill(@pix,0,256)

         left_key:repeat i from 0 to 15
                        einzel_tile[i]->=2                                      'Icon nach links schieben
                  actuali_tile(1)
         right_key:repeat i from 0 to 15
                        einzel_tile[i]<-=2                                      'Icon nach rechts schieben
                   actuali_tile(1)

pri Rotate_Icon|i,b,n
    b:=0
    i:=0
    n:=0
    'Rotationroutine
    repeat 16                                                                   'Zeilen
           repeat 16                                                            'Spalten
                  tmp[b]+=pix[(i*16)+b]<<((16-i)*2)                             'alle 256 Pixel umsortieren
                  b++


           b:=0
           i++
    i:=0
    'rotiertes und zusammengesetztes Tile übernehmen
    repeat 16
           einzel_tile[i]:=tmp[i]->2                                            'Tile um eine Position nach links schieben (?)
           i++
pri mirror_tile|i,re,f,b,n                                                      'beim Spiegeln wird aus einer 2 eine 1, dies muss korrigiert werden
      temp:=0
      tmp:=0

      i:=0
      f:=0
      b:=0
      n:=0
      repeat 16
           temp[b]:=einzel_tile[b]
           repeat i from 0 to 15
                tmp[i]:=temp[b] & %%3
                if tmp[i]==1
                   tmp[i]:=2
                temp[b]>>=2

           temp[b]:=0
           repeat i from 0 to 15
                  temp[b]+=tmp[i]<<(i*2)
           einzel_tile[b]:=temp[b]
           b++

pri actuali_tile(mode)|i,x,y,pixel,farbe,n

    tmp:=0
    x:=3
    y:=9
    i:=0
    n:=0
    repeat 16
           tmp[i]:=einzel_tile[i]
           repeat 16
                   pixel:=tmp[i]&3
                   pix[n++]:=pixel                                              'Pixel merken für Rotationsfunktion
                   tmp[i]>>=2
                   if mode
                      farbe:=lookupz(pixel:white,grey,grey,black)
                      ios.displaytile(16,farbe,0,0,y,x++)                       'Pixel am Bildschirm setzen
           x:=3
           y++
           i++

pri draw_tile(n)|adr,i                                                          'ausgewähltes Tile vergrößert darstellen

    adr:=SYS_FONT+(n*64)
    i:=0
    repeat 16
           einzel_tile[i++]:=ios.ram_rdlong(adr)
           adr+=4
    actuali_tile(1)

PRI Set_Tile(n)|adr,i                                                           'gezeichnetes Tile in den Fontsatz übernehmen
    adr:=SYS_FONT+(n*64)
    i:=0
    repeat 16
           ios.ram_wrlong(einzel_tile[i++],adr)
           adr+=4

PRI Paint_Pixel(x,y)|b,i,f                                                      'gezeichnetes Pixel in Tile übernehmen
    tmp:=0
    ios.displaytile(16,paintfarbe,0,0,y,x)
    case paintfarbe
                 white:b:=%%0
                 grey: b:=%%2
                 black:b:=%%3

    i:=y-9
    f:=x-3
    tmp[i]:=%%3<<(2*f)
    einzel_tile[i]|=tmp[i]                                                      'Farbe Schwarz übernehmen

    case b

         %%2:
             tmp[i]:=1<<(2*f)                                                   'Farbe Grau
             einzel_tile[i]&=!tmp[i]

         %%0:tmp[i]:=0
             tmp[i]:=%%3<<(2*f)
             einzel_tile[i]&=!tmp[i]                                            'Farbe weiss




PRI printbin(value, digits,hint,vor,x,y) |c                                                                   'screen: binären zahlenwert auf bildschirm ausgeben

  value <<= 32 - digits
  repeat digits
     c:=(value <-= 1) & 1 + "0"
     ios.displaytile(c-16,hint,0,vor,y,x++)


PRI Text_Input(min_x,max_x,zeile,adr,ch):ausg|k,ii,x,y,blck,inp,adr_tmp,kl,spalte
    {{#######################################################
      ser=serielle Schnittstelle verwenden
      mode=1 - Terminal      mode=0 - Texteingabefeld
      adr=Adresse Parameter-Ram      adr=0 normales Textfeld
      ch=maximale Anzahl Zeichen
      #######################################################
      }}
    ii:=0
    blck:=0
    adr_tmp:=adr+1                                                                                            'Adresse merken
    'tmps:=adr
    inp:=0                                                                                                    'Eingabe Merker, wird aktiviert, wenn was verändert wurde
    spalte:=min_x


             WIN_TILE(6,zeile,spalte)                                                                         'Eingabe-Cursor

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


                 if k==ios#CHAR_BS                                                                            'Backspace
                    if ii>0
                       if spalte<min_x+1
                          spalte:=min_x
                       if k==ios#CHAR_BS
                       WIN_TILE(16,zeile,spalte--)                                                            'Zeichen hinter dem Cursor löschen
                       if spalte>min_x 'or (spalte==min_x and zeile==min_y)
                          WIN_TILE(6,zeile,spalte)                                                            'Cursor einen Schritt zurück
                       else
                          WIN_TILE(16,zeile,spalte)                                                           'Leerzeichen

                       adr--
                       inp:=1                                                                                 'Text wurde verändert
                       ii--
                 if k>13                                                                                      'Alle Zeichen außer Return
                    ii++
                    if ii>ch
                       ii:=ch                                                                                 'Zeichenanzahl nicht mehr erhöhen
                       blck:=1                                                                                'feste Zeichenanzahl-merker

                    if k>96
                       k&=!32
                    WIN_TILE(k-16,zeile,spalte)
                    if spalte+1<max_x
                       WIN_TILE(6,zeile,spalte+1)                                                          'Eingabemarker weiterrücken
                    ifnot blck                                                                             'ist die maximale Zeichenanzahl erreicht, wird nicht weitergeschrieben
                          spalte++
                          adr++
                    inp:=1                                                                                 'Text wurde verändert
                    textline[adr-1]:=k                                                                     'Text in String schreiben


    if inp and ausg==13                                                                                       'neue Eingabe-Daten
       textline[adr]:=0                                                                                       'normaler Text-Modus, String abschliessen
       popup_info_weg


PRI Display_Info
    infofenster(9,10,31,15,string("Program-Info"),1)          'Info-Fenster anzeigen
    Print_win(string("Font-Editor for Hive"),9,10)
    Print_win(string("Version 1.2 - 07/2014"),9,11)
    Print_win(string("Autor:R.Zielinski"),9,12)
    Print_win(string("Hive-Project.de"),9,13)

PRI Save_Fenster:s|l
    infofenster(9,10,29,15,string("Save Fontset"),1)          'Info-Fenster anzeigen
    util:=3
    Print_win(string("Filename:"),9,10)
    scanstr(@textline)
    Print_win(@textline,18,10)
    print_win(string(".FNT"),26,10)
    s:=Text_Input(18,26,10,0,8)
    l:=strsize(@textline)
    if l<1
       bytemove(@textline[0],@new_name,7)
       l:=7
    else
       bytemove(@textline[l],@fnt_name,4)
    textline[l+4]:=0
    ios.display2dbox(colors[winhcol],9,21,9,33,0)
    print_win(@textline,21,9)
    if s==13
       popup_info_weg
       util:=0
       Save_File(@textline)

PRI Save_File(str)
    ios.sdmount
    activate_dirmarker(fontdir)


    if ifexist(str)
       ios.mousepointer(hour_glass)                                            'Sanduhr anzeigen
       ios.sdopen("W",str)
       ios.sdseek(0)
       ios.sdxputblk(SYS_FONT,11264)                                           'Fontsatz in Datei schreiben
       ios.sdclose
       ios.mousepointer(Mouse_ram)                                             'Mauszeiger anzeigen

    else
       ios.sdclose
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

con '********************************************* Ausgabe von Fehlermeldungen ***************************************************************************************************
'PRI error(err)

'    messagebox(ram_txt(err),1)
    '********************** Fehlermeldungen in Messageboxen **********************************************
{    case err
      0:  no error
      1:  Filesys unmounted
      2:  Filesys corrupted
      3:  Filesys unsupported
      4:    not found
      5:  File not found
      6:  Dir not found
      7:  File read only
      8:  End of File
      9:  End of Directory
      10:  End of Root
      11: Directory is full
      12: Directory is not empty
      13: Checksum Error
      14: Reboot Error
      15: bpb corrupt
      16: Filesys corrupt
      17: Dir already exist
      18: File already exist
      19: Out of Disk free Space
      20: Disk  I/O  Error
      21: Command not found
      22:     Timeout
      23: Out of Memory Error
      24: Delete selected File?
      25: Reboot Hive-Computer?
      26: NO FILE SELECTED
      27: SD-CARD Format Ready
      28: Format SD-CARD ?
      29: Delete selected Link?
      30: Delete all Files?
      31: Trash to empty ?
      '****************** ab hier werden die Texte mit -> ram_txt(nummer,TXT_RAM) aufgerufen **************
      32: SD-Card-Info
      33: File-Info
      34: Calendar
      35: Filename:
      36: Filetype:
      37: Directory
      38: File
      39: - Attribute -
      40: R/O HID SYS ARC
      41: Textdisplay
      42: Startmenue
      43: Administra:
      44: Bellatrix :
      45: Regnatix  :
      46: System-Settings
      47: Show hidden Files:
      48: Use Trash        :
      49: Serial-Terminal
      50: Set Baudrate
      51: Systeminfo
      52: Clock-Settings
      53: Color-Settings
      54: Ram-Monitor
      55: Sid-Dmp-Player
      56: Copy  :
      57: Delete:
      58: Venatrix  :
      59: Start-Parameter (für Links)
      60: Venatrix-BUS:
      61: Sepia-Card  :
      62: Cogs
      63: About
      64: Date
      65: Time
      66: Col:
      67: H-RAM:
      68: E-RAM:

}
PRI display_error(er):r
    if er
       messagebox(ram_txt(er))
       r:=abfrage
       'ios.sdclose

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
         repeat while c:=ios.ram_rdbyte(ad++)
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

PRI scanstr(f) | c                                                                                    'Dateiendung extrahieren
      repeat while strsize(f)
             if c:=byte[f] == "."                                                                           'bis punkt springen
                byte[f]:=0
                quit
             f++

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

    'ios.sdmount

    ios.DisplayMouse(1,colors[mousecol])
    ios.mousepointer(hour_glass)
    'activate_dirmarker(systemdir)
    ios.ld_rambin(2)
    'ios.ldbin(@regsys)


pri testfenster|a

    a:=0
    window(0,4,2,1,27,38,string("Font-Draw"))
    rahmen (1,6,38,27)
    rahmen (1,1,38,3)
    rahmen (1,4,38,6)
    ios.displaytile(133,colors[winhcol],0,colors[act_color],6,1)   'Rahmen-Verbindungsstücke
    ios.displaytile(117,colors[winhcol],0,colors[act_color],6,38)
    Print_win(string("Font-Editor for Hive-Computer V1.2"),2,2)

    rahmen(2,8,19,25)
    ios.display2dbox(white,9,3,24,18,0)
    rahmen(20,8,37,25)
    ios.displaypic(colors[winhcol],colors[panelcol],0,11,21,11,16)

    print_win(string("Tile:"),2,7)
'    print_win(string("   "),8,7)
    print_win(@new_name,21,9)

    Print_win(string("Color:"),2,5)
    ios.display2dbox(white,5,9,5,10,0)
    ios.display2dbox(grey,5,12,5,13,0)
    ios.display2dbox(black,5,15,5,16,0)


    button(0,12,7)
    button(3,20,7)
    button(5,28,7)
    button(6,3,26)
    button(7,10,26)
    button(8,17,26)
    button(9,24,26)
    button(10,31,26)

PRI Print_win(str,x,y)
    printfont(str,colors[winhcol],0,colors[act_color],x,y)
PRI Print_win_rev(str,x,y)
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
    ios.get_window
    'Mouse_Release

    repeat 800
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
    menue(0,25,9,28)
    printfont(string("Startmenue"),colors[titelhcol],0,colors[titeltextcol],0,24)

    printfont(string("Save  - F2"),colors[messagehcol],0,colors[messagetextcol],0,25)
    menuey[0]:=25
    'printfont(string("Help  - F1"),colors[messagehcol],0,colors[messagetextcol],0,25)
    'menuey[1]:=25
    separator(0,26,9)

    printfont(string("-EXIT- F12"),colors[messagehcol],0,colors[messagetextcol],0,27)
    menuey[1]:=27
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

DAT

'sepia_ini byte "sepia.ini",0

