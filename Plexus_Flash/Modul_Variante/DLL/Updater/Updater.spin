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
Name            : IRC-Client
Chip            : Regnatix
Typ             : Plexus-Erweiterungsdatei
Version         : 01
Subversion      : 00


Logbuch         :
'############################################### Version 1.0 ######################################################################################################################

24-11-2013      :-Erstellung der Optik des Testfensters
                 -Grundgerüst stammt vom Sepia-Test-Programm
                 -Sepia-Programmteile entfernt
                 -noch hab ich keine Ahnung, was ich überhaupt testen will ???
                 -6538 Longs frei

30-01-2014       -Anpassung an die neue reg.ios (Window-Funktionen)
                 -6624 Longs frei

16-03-2014       -DCF-Indikator in Titelzeile eingebaut
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

error_step  = 25             'Schrittweite der Einträge
header_step = $8             'Schrittweite der Headereinträge
START_FLAG  = $7FFFF 'Flag das Plexus schonmal gestartet wurde ->Logo unterdrücken

ADM_SPEC    = %00000000_00000000_00000000_01010011
TXT_RAM   = $20000                  'Fehlertexte
'TXT_RAM     = $10A000
SETTING_RAM = $7FF00 'Hier stehen die System-Settings
'SETTING_RAM = $100000 'Hier stehen die System-Settings im Flash
BRAM        = $40000
'-------- Speicher für Systemfont ---------------
SYS_FONT  = $50000 '....$52BFF      ' ab hier liegt der System-Font 11kb
'Hour_Glass= $104000+(167*16*4)'$50000+(167*16*4)       ' Platz, wo das Sanduhrsymbol im Systemfont sitzt
MOUSE_RAM = $52C00 '....$52C3F      ' User-Mouse-Pointer 64byte
MOUSE_ROM = $100015
Hour_Glass= $50000+(167*16*4)       ' Platz, wo das Sanduhrsymbol im Systemfont sitzt

Flash_HD  = $21000 '..$21000        'Kopie des Flash-Updatespeichers für Updateprozedur
PLEXUS    = $80000                  'RAM-Kopie von Plexus zum Arbeiten
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
Filenum      = 41               'Anzahl der updatefähigen Dateien
var

  byte mountmarker,tmptime
  long rootdir                     'root-Dirmarker
  long userdir                     'user-Dirmarker
  byte colors[15]                  'Farbwerte
  byte ma,mb                       'Maus-Tasten
  byte messagex
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
  long systemdir                    'Plexus-System-Verzeichnis
  byte timezaehler
  byte font[25]                    'Hilfsstring für Strings aus dem Ram
  byte buff[8]
    '----------- DCF-Indikator ------------------------------------
  byte dcf_on
  '------------- Flash-Variablen ----------------------------------
  long Flashsize                   'Flash-Rom Größe
  long Flash_dat                   'Bereich, wo die Dateidaten abgelegt werden (für Versionsabfrage)
  byte Date_Compare[5]             'Versionsvergleichs-Array Datei
  byte Date_Flash[5]               'Versionsvergleichs-Array Flash
  byte update_marker[Filenum]      'marker für updatefähige Dateien
  byte updatefiles                 'Anzahl der updatefähigen Dateien

dat
   regsys        byte "plexus.dll",0            'Reg.sys für Rückkehr aus externem Programm
   butOK         byte "  OK  ",0
   Abbr          byte "Cancel",0
   SYSTEM        Byte "PLEXUS      ",0          'Plexus-Systemverzeichnis
   UPDATEDIR     byte "UPDATE      ",0          'Updateverzeichnis

'################### Update-Dateien ##################################################################
   File0         byte "PLEXUS.FLS",0            '$0                             'Plexus-Hauptprogramm
   File1         byte "YMODEM.FLS",0            '$8000                          'DLL von Plexus
   File2         byte "BASRUN.FLS",0	        '$10000                         'Runtime von TRIOS-Basic
   File3         byte "SEPIA.FLS",0	        '$18000                         'DLL von Plexus
   File4         byte "VENATRIX.FLS",0          '$20000                         'DLL von Plexus
   File5         byte "DOS.FLS",0	        '$28000                         'DLL von Plexus
   File6         byte "DCF.FLS",0	 	'$30000                         'DLL von Plexus
   File7         byte "BLTOOTH.FLS",0           '$38000                         'DLL von Plexus
   File8         byte "FONT.FLS",0	        '$40000                         'DLL von Plexus
   File9         byte "WAVE.FLS",0	        '$48000                         'DLL von Plexus
   File10        byte "IRC.FLS",0		'$50000                         'DLL von Plexus
   File11        byte "EEPROM.FLS",0	        '$58000                         'DLL von Plexus
   File12        byte "UPDATE.FLS",0            '$60000                         'DLL von Plexus - der Updater
   File13        byte "FREI.FLS",0              '$68000
   File14        byte "FREI.FLS",0              '$70000
   File15        byte "FREI.FLS",0              '$78000
   File16        byte "FREI.FLS",0              '$80000
   File17        byte "FREI.FLS",0              '$88000
   File18        byte "FREI.FLS",0              '$90000
   File19        byte "FREI.FLS",0              '$98000
   File20        byte "FREI.FLS",0              '$A0000
   File21        byte "FREI.FLS",0              '$A8000
   File22        byte "FREI.FLS",0              '$B0000
   File23        byte "FREI.FLS",0              '$B8000
   File24        byte "FREI.FLS",0              '$C0000
   File25        byte "FREI.FLS",0              '$C8000
   File26        byte "FREI.FLS",0              '$D0000
   File27        byte "FREI.FLS",0              '$D8000
   File28        byte "FREI.FLS",0              '$E0000
   File29        byte "BOOT.FLS",0              '$E8000                         'Boot-Selector
   File30        byte "TRIOS.FLS",0             '$F0000                         'Regime von TRIOS

   File31        byte "REG.FLS",0               '$F8000                         'Plexus-Startdatei

   File32        byte "FLASH.INI",0	        '$100000                        'Plexus-Ini-Datei
   File33        byte "PLEXUS.DAT",0		'$101000                        'Plexus-Logo
   File34        byte "REG.FNT",0               '$104000                        'Systemfont von Plexus
   File35        byte "HELP.TXT",0		'$107000                        'Plexus-Hilfedatei
   File36        byte "DOS.TXT",0		'$108000                        'Plexus-DOS-Shell Hilfedatei
   File37        byte "PRG.NFO",0		'$109000                        'Plexus-Programminfo
   File38        byte "ERROR.TXT",0		'$10A000                        'Plexus-Errortexte
   File39        byte "VIDEO.NFO",0		'$10B000                        'Plexus-Grafikinfo
   File40        byte "SOUND.NFO",0		'$10C000                        'Plexus-Soundinfo

   FFILE word @File0,@File1,@File2,@File3,@File4,@File5,@File6,@File7,@File8,@File9,@File10
         word @File11,@File12,@File13,@File14,@File15,@File16,@File17,@File18,@File19,@File20
         word @File21,@File22,@File23,@File24,@File25,@File26,@File27,@File28,@File29,@File30
         word @File31,@File32,@File33,@File34,@File35,@File36,@File37,@File38,@File39,@File40

   FADR  LONG $0,$8000,$10000,$18000,$20000,$28000,$30000,$38000,$40000,$48000,$50000,$58000,$60000
         LONG $68000,$70000,$78000,$80000,$88000,$90000,$98000,$A0000,$A8000,$B0000,$B8000,$C0000
         LONG $C8000,$D0000,$D8000,$E0000,$E8000,$F0000,$F8000                                           'Adressen im Rom
         LONG $100000,$101000,$104000,$107000,$108000,$109000,$10A000,$10B000,$10C000

   FSIZE byte 8,8,8,8,8,8,8,8,8,8
         byte 8,8,8,8,8,8,8,8,8,8
         byte 8,8,8,8,8,8,8,8,8,8
         byte 8,8,1,3,3,1,1,1,1,1                                                    'Bereiche*$1000

   Update_Text    byte "Number of files for update:   ",0
   NO_Update_Text byte "No files found for update !   ",0
   Read_dir_text  byte "READ DIRECTORY...",0
   Write_dat_text byte "Write Update-Informations...",0
   Copy_Text      byte "Copy Plexus to RAM...",0


PUB main|err,m

    ios.start
    cmd_mount                                     'sd-card mounten
    ios.upperstart
    'mountmarker:=1                                  'mount-marker
    m:=0
    '--------------------------------------------------------------------------------------
    activate_dirmarker(0)                            'ins root
    err:=ios.sdchdir(@updatedir)
    ifnot err
          userdir:=get_dirmarker
          m:=1
    activate_dirmarker(0)
    ios.sdchdir(@system)                             'System-Verzeichnis lesen
    systemdir:=get_dirmarker                         'Dir-Marker lesen

    FlashSize:=ios.flashsize                        'Flash-Rom-Größe
    Flash_dat:=FlashSize-$1000                      'Flash-Bereich mit den Updateinformationen
    '--------------------------------------------------------------------------------------
    'cmd_unmount
    iniload                                          'Ini-Datei mit Farbwerten laden
    ios.mousepointer(MOUSE_RAM)
    testfenster
    util:=0
    ifnot m                                          'Updateverzeichnis nicht im Hauptverzeichnis
          err:=ios.sdchdir(@updatedir)
          ifnot err
                userdir:=get_dirmarker
          else
              error(err)
    else
       activate_dirmarker(userdir)

    copy_update_flash(0)

    read_updateliste

    repeat

      os_cmdinput                           'Hauptprogrammschleife

PRI os_cmdinput | x,y ,i,dk,a,b,c,port,key,padr,durchlauf

  repeat
    time                                                                                           'Zeit und Datum anzeigen

    ma:=ios.mouse_button(0)                                                                        'linke Maustaste
    mb:=ios.mouse_button(1)                                                                        'rechte Maustaste
    key:=ios.key
    if key
'       ifnot key=="d" or key=="a"
             popup_info_weg
             util:=0
'**************************** Short-Cuts ****************************************************************************
    case key
         F1_Key:Display_Help
         F2_Key:Update_Fenster
         F12_Key:ausstieg
         ESC_KEY:popup_info_weg
         RETURN_KEY:popup_info_weg

'***************************** linke Maustaste **********************************************************************
    if ma==255
       dk:=0
       x:=ios.mousex
       y:=ios.mousey


'****************************** Startmenue anzeigen ************************************************************
       if popupmarker==1
          if x>10 or y<24                                         'Menue loeschen, wenn man woanders hinklickt
             popup_info_weg
             util:=0
          if x=>0 and x=<10 and y=>24 and y=<28
             repeat i from 0 to 5
                 if menuey[i]==y
                    case i
                         0:menueselect(string("Update- F2"),menuey[i])
                           Update_Fenster
                         1:menueselect(string("Help  - F1"),menuey[i])
                           Display_Help
                         2:menueselect(string("-EXIT- F12"),menuey[i])
                           ausstieg

'****************************** Globale Funktionstasten ********************************************************
       if(x=>buttonx[4]) and (x=<buttonx[4]+5) and (y==buttony[4]) and Infomarker==1     'ok im Infofenster
             buttonpress(4)
             popup_info_weg
             if util==1
                util:=0

       if y==windowy[2] and x==windowx[2] and Infomarker==1                     'doppelklick in linke obere ecke des Info-Fensters
          if doppelklick>1
             popup_info_weg
             util:=0

       if y==windowy[2] and x==windowxx[2] and Infomarker==1
          ios.get_window
          popup_info_weg
          util:=0

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
pri read_updateliste:n|stradr,d,c,i,tok,un
  n:=0
  c:=-1
  updatefiles:=0
  ios.sddir                                                                                                   'kommando: verzeichnis öffnen
  'ios.erase_Flash_Data(Flash_Dat)
  bytefill(@update_marker,0,41)
  repeat  'while (stradr <> 0)

         stradr:=ios.sdnext                                                                                   'ist eintrag gültig?

         if stradr<>0                                                                                                     'wiederhole bis verzeichnisende
            c:=compare_string(stradr)                                                                               'gefundenen Eintrag mit Update-Dateiliste vergleichen

            if c>-1
               Date_compare[0]:=ios.sdfattrib(12)-2000     'Jahr
               Date_compare[1]:=ios.sdfattrib(11)          'Monat
               Date_compare[2]:=ios.sdfattrib(10)          'Tag
               Date_compare[3]:=ios.sdfattrib(15)          'Stunde
               Date_compare[4]:=ios.sdfattrib(14)          'Minuten
               compare_version(c)
               display_File(stradr,c,n)
               if update_marker[c]==1
                  updatefiles++
               n++
            c:=-1
         else
            quit
  if updatefiles>0
     printfont(@Update_text,colors[winhcol],0,colors[act_color],3,5)
     printdec_win(updatefiles,5,30)
  else
     printfont(@No_Update_text,colors[winhcol],0,colors[act_color],3,5)
''                              :       10 = Änderungsdatum - Tag
''                              :       11 = Änderungsdatum - Monat
''                              :       12 = Änderungsdatum - Jahr
''                              :       13 = Änderungsdatum - Sekunden
''                              :       14 = Änderungsdatum - Minuten
''                              :       15 = Änderungsdatum - Stunden
pri write_date(n,datec)|i,c,po
    po:=Flash_dat+(n*header_step)

    repeat i from 0 to 4
           ios.write_Flash_Data(po++,byte[datec++])
pri copy_update_flash(mode)|i,adr,f_adr
    adr:=Flash_HD                                       'Kopie-Buffer des Updatebereiches
    f_adr:=Flash_Dat                                    'Bereich der Updateparameter im Flash-Rom
    if mode
       printfont(@Write_dat_text,colors[winhcol],0,colors[act_color],3,5)
       ios.erase_Flash_Data(Flash_Dat)
       waitcnt(clkfreq/10+cnt)
       repeat $148
           ios.write_Flash_data(f_adr++,ios.ram_rdbyte(adr++))
       ios.mousepointer_flash(Mouse_Rom)
       messagebox(string("Update-Process done !"),1)
       abfrage
       ios.restore_area(popupx,popupy,popupxx,popupyy,BRAM)
       ios.display2dbox(colors[winhcol],5,3,5,30,0)
       ausstieg
    else
       printfont(@Read_dir_text,colors[winhcol],0,colors[act_color],3,5)
       repeat $148
           ios.ram_wrbyte(ios.Read_Flash_Data(f_adr++),adr++)

pri compare_string(str):d|i,c
    d:=-1

    i:=0
    repeat 12
           c:=byte[str++]
           if c<33                                      'Leerzeichen entfernen
              quit
           buff[i++]:=c
    buff[i]:=0

    repeat i from 0 to Filenum                          'Fateinamen mit Updateliste vergleichen
           if strcomp(@@ffile[i],@buff)
              d:=i
              return d

pri display_file(str,mark,n)|x,y,symbol
    x:=(n/20*13)+2
    y:=n-((n/20)*20)+7

    if update_marker[mark]==1
       printfont(str,colors[winhcol],0,colors[selectcol],x,y)
    else
       printfont(str,colors[winhcol],0,colors[act_color],x,y)


pri compare_version(n)|po,j,mo,tg,st,mi,c,erg,i

    po:=Flash_dat+(n*header_step)
    bytefill(@Date_Flash,0,5)

    repeat i from 0 to 4
           if (c:=ios.Read_Flash_Data(po++))<255
               Date_Flash[i]:=c                         'Flashvergleichs-Array füllen

    update_marker[n]:=Datecomp(@Date_Flash,@Date_Compare)'datec)    'Dateidatum vergleichen

''          1    date_flash <  datec    'update durchführen
''          0    date_flash == datec    'kein update
''          2    date_flash >  datec    'kein update

pri Write_Flash_Files|i,adr,p,n,v
    i:=0
    v:=0
    if updatefiles>0
       messagebox(string("Perform the update?"),1)
       v:=abfrage
    else
       messagebox(string("no files for update!"),1)
       abfrage
    if v
       ios.mousepointer_flash(hour_glass)
       ios.restore_area(popupx,popupy,popupxx,popupyy,BRAM)
       repeat i from 0 to filenum-1
              if update_marker[i]==1
                 ios.display2dbox(colors[winhcol],5,3,5,30,0)
                 printfont(@@ffile[i],colors[winhcol],0,colors[act_color],3,5)
                 Write_File_to_Flash(i)
       copy_update_flash(1)                                                     'updateinfo's in den Flash kopieren
    else
       ios.restore_area(popupx,popupy,popupxx,popupyy,BRAM)


pri Write_File_to_Flash(n)|a,b,c,i,adr

    a:=FADR[n]
    b:=FSIZE[n]
    i:=0
    adr:=a

    'printdec(n,5,35,colors[winhcol],colors[act_color])
    repeat b
           ios.erase_Flash_Data(adr+(i*$1000))
           i++
    ios.sdopen("R",@@ffile[n])
    c:=ios.sdfattrib(0)
    '############ aktualisierte Zeitangaben im Ram speichern ######
    adr:=Flash_HD+(n*8)
    ios.ram_wrbyte(ios.sdfattrib(12)-2000,adr++)
    ios.ram_wrbyte(ios.sdfattrib(11),adr++)
    ios.ram_wrbyte(ios.sdfattrib(10),adr++)
    ios.ram_wrbyte(ios.sdfattrib(15),adr++)
    ios.ram_wrbyte(ios.sdfattrib(14),adr++)


    if n==38                                                                    'errortexte werden anders behandelt
       fileload(FADR[n],25,c)
    else
       ios.copytoflash(FADR[n])
    ios.sdclose

    if n==0
          ios.display2dbox(colors[winhcol],5,3,5,30,0)
          printfont(@Copy_Text,colors[winhcol],0,colors[act_color],3,5)
          ios.flxgetblk(PLEXUS,$0,c)                                            'Plexus zusätzlich in den Ram kopieren, so kann gleich mit der neuen Version gearbeitet werden


''                              :       10 = Änderungsdatum - Tag
''                              :       11 = Änderungsdatum - Monat
''                              :       12 = Änderungsdatum - Jahr
''                              :       13 = Änderungsdatum - Sekunden
''                              :       14 = Änderungsdatum - Minuten
''                              :       15 = Änderungsdatum - Stunden
PRI fileload(adr,st,cont)| b,a,i
    i:=adr
    b:=0
    repeat cont
           a:=ios.sdgetc
           if a==$0A
              b++
              i:=adr+(st*b)
              next
           else
              ios.Write_Flash_Data(i++,a)

con'****************************************************** Datumsvergleich der Dateien ********************************************************************************************
PRI Datecomp(ats1,ats2) | i

''  return 2 if ats1 >  ats2
''         0    ats1 == ats2
''         1    ats1 <  ats2

  repeat i from 0 to 4
    if byte[ats1+i] > byte[ats2+i]
      return 2
    if byte[ats1+i] < byte[ats2+i]
      return 1
  return 0

PRI Display_Help
    infofenster(5,10,34,17,string("Help"),1)          'Info-Fenster anzeigen
    Print_win(string("This Program"),5,10)
    Print_win(string("is under Construction!"),5,11)
    'Print_win(string("Press and hold -a- for AD-Port"),5,12)
    'Print_win(string("or -d- for Digital-Port and"),5,13)
    'Print_win(string("click on the Adress do you"),5,14)
    'Print_win(string("want!"),5,15)

PRI Display_Info
    infofenster(9,10,31,15,string("Program-Info"),1)          'Info-Fenster anzeigen
    Print_win(string("Updater for Plexus"),9,10)
    Print_win(string("Version 1.0 - 08/2015"),9,11)
    Print_win(string("Autor:R.Zielinski"),9,12)
    Print_win(string("Hive-Project.de"),9,13)

PRI Update_Fenster|a,ack,z,vx
    'infofenster(5,10,35,15,string("Update"),1)          'Info-Fenster anzeigen
    util:=1
    Write_Flash_Files

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
    if ios.ram_rdbyte(START_FLAG)<>235                                           'Warm-Start-Flag
       ios.ld_rambin(31)                                                         'wurde Plexus noch nicht gestartet, zum Bootmenue zurück
    else
       ios.ld_rambin(2)                                                          'Plexus aus dem E-Ram starten

pri testfenster|i,y,a

    a:=0
    window(1,4,2,1,27,38,string("Plexus-Updater"))
    rahmen (1,6,38,27)
    rahmen (1,1,38,3)
    rahmen (1,4,38,6)
    ios.displaytile(133,colors[winhcol],colors[winhcol],colors[act_color],6,1)   'Rahmen-Verbindungsstücke
    ios.displaytile(117,colors[winhcol],colors[winhcol],colors[act_color],6,38)
    Print_win(string("Plexus-Updater for Hive-Computer 1.0"),2,2)
    printfont(string("Start  "),colors[hcolstatus],0,colors[statustextcol],0,29)
    ios.displaytile(144,colors[shellhcol],colors[hcolstatus],colors[shellhcol],29,7)
    ios.displaytile(145,colors[shellhcol],colors[hcolstatus],colors[shellhcol],29,32)
    ios.displaytile(16,colors[hcolstatus],colors[shellhcol],colors[hcolstatus],29,33)
    ios.displaytile(16,colors[hcolstatus],colors[shellhcol],colors[hcolstatus],29,34)
    displaytime

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
  'else
        'display_error(err)

PRI window(num,cntrl,y,x,yy,xx,strg)|i                         'ein Fenster erstellen

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
    case n
         1:printfont(string("Start  "),250,0,0,0,29)
           ios.displaytile(144,colors[shellhcol],250,colors[shellhcol],29,7)
         2:printfont(@Abbr,250,0,0,buttonx[n],buttony[n])
         4:printfont(@butOK,250,0,0,buttonx[n],buttony[n])

    Mouse_Release
    case n
         1:printfont(string("Start  "),colors[hcolstatus],0,colors[statustextcol],0,29)
           ios.displaytile(144,colors[shellhcol],colors[hcolstatus],colors[shellhcol],29,7)
         2:printfont(@Abbr,colors[Buttonhcol],0,colors[buttontextcol],buttonx[n],buttony[n])
         4:printfont(@butOK,colors[Buttonhcol],0,colors[buttontextcol],buttonx[n],buttony[n])


PRI error(err)

    messagebox(ram_txt(err),1)
    abfrage
    ausstieg

PRI abfrage:taste|a,x,y,k
    repeat
      a:=ios.mouse_button(0)
      k:=ios.key
      if a==255 or k==27 or k==13
         x:=ios.mousex
         y:=ios.mousey

         if((x=>buttonx[4]) and (x=<buttonx[4]+5) and (y==buttony[4]))or k==13                                'ok
            buttonpress(4)
            taste:=1
            quit
         if((x=>buttonx[2]) and (x=<(buttonx[2]+6)) and (y==buttony[2]))or k==27                              'cancel
            buttonpress(2)
            taste:=0
            quit
    popup_info_weg
    ios.display2dbox(colors[winhcol], 10, 7, 17, messagex,0)

PRI messagebox(st,ok)|laenge,mindest
    laenge:=strsize(st)+2
    mindest:= 20
    messagex:=10+laenge
    popupx:=7
    popupy:=10
    popupxx:=messagex
    popupyy:=17
    ios.backup_area(7,10,messagex,17,BRAM)

    ios.display3DBox(white,colors[messagehcol], black, 10, 7, 17, messagex)
    printfont(st,colors[messagehcol],0,colors[messagetextcol],8,11)

    if ok==1
       button(4,@butOK,10,15)
       button(2,@Abbr,1+laenge,15)
con '***************************************************** Diverse Texte aus dem E-Ram lesen *************************************************************************************

PRI ram_txt(nummer)
    return txt_from_ram(txt_ram,nummer,error_step)
{pri dll_txt(nummer)
    return txt_from_ram(dll_ram,nummer,dll_step)
}
pri txt_from_ram(adr,nummer,st)|c,i,ad
    i:=0
    ad:=adr+((nummer-1)*st)
         repeat while (c:=ios.Read_Flash_Data(ad++))<$FF'ram_rdbyte(ad++)
                 if c>13
                    byte[@font][i++]:=c
    byte[@font][i]:=0
    return @font
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

    printfont(string("Update- F2"),colors[messagehcol],0,colors[messagetextcol],0,24)
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
          ios.display2dbox(colors[winhcol],5,2,5,36,0)
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
PRI printdec_win(n,y,x)
    printdec(n,y,x,colors[winhcol],colors[act_color])
