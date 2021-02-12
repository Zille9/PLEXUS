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
Name            : Bluetooth-Testprogramm - Test der Funktionen der HC05 Bluetooth-Karte
Chip            : Regnatix
Typ             : Plexus-Erweiterungsdatei
Version         : 01
Subversion      : 00


Logbuch         :
'############################################### Version 1.0 ######################################################################################################################

24-11-2013      :-Erstellung der Optik des Testfensters
                 -Grundgerüst stammt vom Sepia-Test-Programm
                 -Sepia-Programmteile entfernt
                 -Bluetooth-Test-und Konfigurationsprogramm
                 -6538 Longs frei

30-01-2014       -Anpassung an die neue reg.ios (Window-Funktionen)
                 -6624 Longs frei

16-03-2014       -DCF-Indikator in Titelleiste eingebaut
                 -6648 Longs frei

18-03-2014       -Parameterabfrage funktioniert jetzt korrekt (kein Datenmüll mehr auf dem Bildschirm)
                 -Parametereingabefenster zur Konfiguration hinzugefügt ->funktioniert
                 -jetzt müsste noch ein Scanner her, der die Geräte in der Nähe anzeigt
                 -kleinere optische Korrekturen
                 -6303 Longs frei

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
TEXT_RAM    = $23000
SETTING_RAM = $100000 'Hier stehen die System-Settings
BRAM        = $40000
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
  byte colors[15]                  'Farbwerte
  byte ma,mb                       'Maus-Tasten

  byte textline[40]                'Texteingabestring
  long tp                          'Texteingabe-übernahmestring
  byte Show_Hid_Files
  byte Use_Trash
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
  long systemdir                   'Plexus-System-Verzeichnis
  byte timezaehler
  byte baud
    '----------- DCF-Indikator ------------------------------------
  byte dcf_on

dat
   regsys        byte "plexus.dll",0            'Reg.sys für Rückkehr aus externem Programm
   butOK         byte "  OK  ",0
   Abbr          byte "Cancel",0
   SYSTEM        Byte "PLEXUS      ",0          'Plexus-Systemverzeichnis
'----------------------- Liste der Kommandos ----------------------------------------------
   at_name       byte "AT+NAME",0
   at_addr       byte "AT+ADDR",0
   at_role       byte "AT+ROLE",0
   at_class      byte "AT+CLASS",0
   at_access     byte "AT+IAC",0
   at_passwd     byte "AT+PSWD",0
   at_uart       byte "AT+UART",0
   at_cmode      byte "AT+CMODE",0
   at_polar      byte "AT+POLAR",0
   at_ipscan     byte "AT+IPSCAN",0
   at_sniff      byte "AT+SNIFF",0
   at_senm       byte "AT+SENM",0
   at_adcn       byte "AT+ADCN",0
   at_mrad       byte "AT+MRAD",0
   at_state      byte "AT+STATE",0
   at_frage      byte "AT",0
   ok_antwort    byte "OK",0

   at_Master     byte "AT+ROLE=1",0
   at_scan       byte "AT+INQ",0

PUB main|a

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
    ios.mousepointer(MOUSE_RAM)                      'Sanduhr durch Mauszeiger ersetzen
    testfenster
    util:=0
    ios.ram_fill(Text_Ram,$1000,0)
    a:=bdselect(baud)
    ios.serclose
    ios.seropen(a)                                'ser. Schnittstelle virtuell öffnen
    buttonweg
    Abfrage_Bluetooth_Parameter

    repeat

      os_cmdinput                                    'Hauptprogrammschleife


PRI os_cmdinput | x,y ,i,a,b,c,port,key,padr,durchlauf

  repeat
    time                                                                                           'Zeit und Datum anzeigen

    ma:=ios.mouse_button(0)                                                                        'linke Maustaste
    mb:=ios.mouse_button(1)                                                                        'rechte Maustaste
    key:=ios.key

'**************************** Short-Cuts ****************************************************************************
    case key
         F1_Key:'Scanner_Display
         F2_Key:Command_Display
         F12_Key:ausstieg
         ESC_KEY:popup_info_weg
         RETURN_KEY:popup_info_weg

    if util==1
       b:=texteingabe(10)
       if b==1                                                                  'Kommando eingeben
          if strsize(@textline)>1
             print_win(string("                           "),8,10)              'Eingabezeilen löschen
             print_win(string("                           "),8,12)
             ios.Set_Bluetooth_Command_Mode                                     'Kommando-Mode einschalten
             get_antwort(@textline,15,8,12,2)                                   'Kommando senden
             ios.Clear_Bluetooth_Command_Mode                                   'Kommando-Mode ausschalten

       elseif b==2
          testfenster                                                           'Bildschirm neu aufbauen
          date                                                                  'Datum in der Titelzeile wieder herstellen
          Abfrage_Bluetooth_Parameter                                           'Parameter einlesen
          util:=0

'***************************** linke Maustaste **********************************************************************
    if ma==255
       x:=ios.mousex
       y:=ios.mousey

'****************************** Globale Buttonabfrage ********************************************************
       a:=Global_Button_Press(x,y)

'****************************** Startmenue anzeigen ************************************************************
       if popupmarker==1
          if x>10 or y<24                                         'Menue loeschen, wenn man woanders hinklickt
             popup_info_weg
             util:=0
          if x=>0 and x=<10 and y=>24 and y=<28
             repeat i from 0 to 5
                 if menuey[i]==y
                    case i
                         0:menueselect(string("Set   - F2"),menuey[i])
                           Command_Display
                         1:menueselect(string("Help  - F1"),menuey[i])
                           'Scanner_Display
                         2:menueselect(string("-EXIT- F12"),menuey[i])
                           ausstieg




PRI Abfrage_Bluetooth_Parameter

    ios.Set_Bluetooth_Command_Mode
    Abfrage_ok

    get_antwort(@at_name,0,2,5,1)
    get_antwort(@at_addr,1,2,8,1)
    get_antwort(@at_class,2,21,8,1)

    get_antwort(@at_role,3,2,11,1)
    get_antwort(@at_access,4,21,11,1)

    get_antwort(@at_passwd,5,2,13,1)
    get_antwort(@at_uart,6,21,13,1)

    get_antwort(@at_cmode,7,2,15,1)
    get_antwort(@at_polar,8,21,15,1)

    get_antwort(@at_ipscan,9,2,17,1)

    get_antwort(@at_sniff,10,2,19,1)
    get_antwort(@at_senm,11,21,19,1)

    get_antwort(@at_adcn,12,2,22,1)
    get_antwort(@at_mrad,13,2,23,1)
    get_antwort(@at_state,14,2,25,1)

    ios.Clear_Bluetooth_Command_Mode

pri abfrage_ok|a,nx                                                                'diese Routine garantiert, das das Modul korrekt antwortet
    a:=1
    nx:=0
    repeat while a
           get_antwort(@at_frage,15,0,0,0)
           nx++
           if strcomp(@textline,@ok_antwort) or nx>20                              'nach 20 Versuchen oder OK als Rückgabewert->Ausstieg
              a:=0

pri get_antwort(str,n,x,y,mode)|c,i,adr,v,fx,nx
    adr:=Text_Ram+(n*40)
    if mode==1                                                                  'Abfrage-Bluetooth-Parameter
       v:=adr+mode
    if mode==0 or mode==2                                                       'Abfrage oder Eingaberückmeldung
       v:=adr
    i:=0
    fx:=0
    nx:=0
    ios.serstr(str)
    ios.sertx(13)
    ios.sertx(10)
    waitcnt(cnt + clkfreq/10)                                                   'einen kleinen Moment warten
    repeat
           c:=ios.serread
           nx++
           print_win(string(" "),30,5)
           if c>0
              nx:=0
              if c>31
                 ios.ram_wrbyte(c,adr++)

              if c==13
                 QUIT

           if nx>50
              quit

    repeat while c:=ios.ram_rdbyte(v++)
                textline[i++]:=c

    textline[i]:=0
    if mode                                                                     'im Modus 0 wird der Text nicht ausgegeben
       print_win(@textline,x,y)
    ios.serflush
    ios.ram_fill(Text_Ram+(15*40),40,0)




PRI bdselect(bauds):bd
    bd:=lookupz(bauds:300,600,1200,4800,9600,19200,38400,57600,115200)

pri Global_Button_Press(x,y):antwort

       if(x=>buttonx[4]) and (x=<buttonx[4]+5) and (y==buttony[4]) and Infomarker==1     'ok im Infofenster
             buttonpress(4)
             popup_info_weg
             antwort:=1

       if(x=>buttonx[2]) and (x=<buttonx[2]+5) and (y==buttony[2]) and Infomarker==1     'cancel im Infofenster
             buttonpress(2)
             popup_info_weg
             antwort:=2

       if y==windowy[2] and x==windowx[2] and Infomarker==1                     'doppelklick in linke obere ecke des Info-Fensters
          if doppelklick>1
             popup_info_weg
             antwort:=2

       if y==windowy[2] and x==windowxx[2] and Infomarker==1
          ios.get_window
          popup_info_weg
          antwort:=2

       if y==0 and infomarker==0
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
                Display_Info

       if ((x=>0) and (x=<5)) and (y==29)                                       'Start-Knopf
          buttonpress(1)
          if popupmarker==1
             popup_info_weg

          else
             if infomarker==1
                popup_info_weg
                antwort:=0
             startmenue
             popupmarker:=1

{PRI Scanner_Display|i
    infofenster(5,10,34,17,string("Device-Scanner"),1)          'Info-Fenster anzeigen
    Abfrage_ok
    get_antwort(@at_Master,16,5,10,0)
    ios.serstr(@at_scan)
    ios.sertx(13)
    ios.sertx(10)
    waitcnt(cnt + clkfreq/10)                                                   'einen kleinen Moment warten

    scanning(5)


pri scanning(y)|x,nx,c
    x:=5
    repeat
           c:=ios.serread
           nx++
           print_win(string(" "),30,5)
           if c>0
              nx:=0
              if c>31
                 win_tile(c-16,x++,y)
              if c==13 or x>34
                 y++
                 x:=5
           if nx>50
              quit
              }
PRI Display_Info
    infofenster(9,8,31,13,string("Program-Info"),1)          'Info-Fenster anzeigen
    Print_win(string("Bluetooth-Settings HC05"),9,8)
    Print_win(string("Version 1.1 - 03/2014"),9,9)
    Print_win(string("Autor:R.Zielinski"),9,10)
    Print_win(string("Hive-Project.de"),9,11)

PRI Command_Display|a,ack,z,vx
    infofenster(7,10,35,15,string("Bluetooth-Command"),2)                                                             'Infofenster mit OK-Knopf anzeigen
    'printfont(@filestring,colors[Titelhcol],0,colors[Titeltextcol],20,8)                                                      'verlinkte Datei in Titelleiste anzeigen
    rahmen(7,9,35,13)
    util:=1

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
    ios.Mousepointer(hour_glass)
    ios.serclose
    'cmd_mount
    'activate_dirmarker(systemdir)
    'ios.sdopen("r",@regsys)
    'ios.ldbin(@regsys)
    ios.ld_rambin(2)

pri testfenster|i,y,a

    a:=0
    window(0,4,2,1,27,38,string("HC05-Bluetooth-Module"))
    rahmen (1,6,38,27)
    rahmen (1,1,38,3)
    rahmen (1,4,38,6)
    ios.displaytile(133,colors[winhcol],colors[winhcol],colors[act_color],6,1)   'Rahmen-Verbindungsstücke
    ios.displaytile(117,colors[winhcol],colors[winhcol],colors[act_color],6,38)

    rahmen (1,10,38,20)
    ios.displaytile(133,colors[winhcol],colors[winhcol],colors[act_color],10,1)   'Rahmen-Verbindungsstücke
    ios.displaytile(117,colors[winhcol],colors[winhcol],colors[act_color],10,38)
    ios.displaytile(133,colors[winhcol],colors[winhcol],colors[act_color],20,1)   'Rahmen-Verbindungsstücke
    ios.displaytile(117,colors[winhcol],colors[winhcol],colors[act_color],20,38)

    Print_win(string("Bluetooth for Hive-Computer V1.1"),2,2)

PRI Print_win(str,x,y)
    printfont(str,colors[winhcol],0,colors[act_color],x,y)

PRI printhex(value, digits,x,y,back,vor)|wert                             'screen: hexadezimalen zahlenwert auf bildschirm ausgeben
{{hex(value,digits) - screen: hexadezimale bildschirmausgabe eines zahlenwertes}}
  value <<= (8 - digits) << 2
  repeat digits
    wert:=lookupz((value <-= 4) & $F : "0".."9", "A".."F")
    ios.displaytile(wert-16,back,0,vor,y,x++)

PRI texteingabe(y):ok|k,sp,i,mx,my                                                                                  '************** Texteingabe im Dateifenster ******************
    sp:=8
    i:=0
    WIN_TILE(26,y,sp)
    bytefill(@textline,40,0)                                                                                  'Stringpuffer löschen
             repeat
                 k:=ios.key
                 ma:=ios.mouse_button(0)
                 if ma==255
                    mx:=ios.mousex
                    my:=ios.mousey

                    if Global_Button_Press(mx,my)==2
                       ok:=2
                       quit
                    'else
                    '   ok:=0
                    '   quit
                 if k==13                                                                                     'Return? dann String abschliessen
                    ok:=1
                    textline[i++]:=0
                    quit
                 if k==27                                                                                     'Abbruch
                    ok:=2
                    quit
                 if k==ios#BEL_BS                                                                            'Backspace
                    if i>0
                       WIN_TILE(16,y,sp--)
                       WIN_TILE(26,y,sp)
                       i--
                 if k=>32 and k=<122                                                                          'Buchstaben und Zahlen
                    WIN_TILE(k-16,y,sp++)
                    textline[i++]:=k
                    if i>39
                       i:=39                                                                                  'Zeichen von Tastatur
                    WIN_TILE(26,y,sp)

                    if sp>34
                       sp:=34

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

con'
PRI doppelklick:click                            'pseudo-doppelklick
    click:=0
    ios.get_window
    'Mouse_Release

    repeat 800
        if ios.mouse_button(0)==255
           click++

pri Buttonweg|i
    repeat i from 0 to 7
            buttonx[i]:=-1
            buttony[i]:=-1

con'
PRI iniload|i,a
          a:=SETTING_RAM
          repeat i from 0 to 14
               colors[i]:=ios.Read_Flash_Data(a++)'ram_rdbyte(a++)

          baud:=ios.Read_Flash_Data(a)'ios.ram_rdbyte(a++)                                                                           'Übertragungsrate serielles Terminal
          'Show_Hid_Files:=ios.Read_Flash_Data(a++)'ios.ram_rdbyte(a++)                                                                 'unsichtbare Dateien anzeigen? ja/nein
          'Use_Trash:=ios.Read_Flash_Data(a++)'ios.ram_rdbyte(a++)                                                                      'Mülleimer verwenden? ja/nein
          dcf_on:=ios.Read_Flash_Data(a+3)'ios.ram_rdbyte(a++)                                                                              'DCF-Empfänger benutzen



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

    printfont(string("Set   - F2"),colors[messagehcol],0,colors[messagetextcol],0,24)
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

sepia_ini byte "sepia.ini",0

