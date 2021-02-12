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

ADM_SPEC       = %00000000_00000000_00000000_01010011
TXT_RAM     = $10A000
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
    activate_dirmarker(0)                            'ins root
    ios.sdchdir(@system)                             'System-Verzeichnis lesen
    systemdir:=get_dirmarker                         'Dir-Marker lesen
    '######## nur für testphase wenn aus BST geladen wird ####
     ' ios.upperstart
    '--------------------------------------------------------------------------------------
    cmd_unmount
    iniload                                          'Ini-Datei mit Farbwerten laden
    ios.mousepointer(MOUSE_RAM)
    testfenster
    util:=0
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
         F2_Key:Adress_Scanner
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
                         0:menueselect(string("Set   - F2"),menuey[i])
                           Adress_Scanner
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
    Print_win(string("IRC-Client for Hive"),9,10)
    Print_win(string("Version 1.0 - 12/2014"),9,11)
    Print_win(string("Autor:R.Zielinski"),9,12)
    Print_win(string("Hive-Project.de"),9,13)

PRI Adress_Scanner|a,ack,z,vx
    infofenster(9,10,29,20,string("Settings"),1)          'Info-Fenster anzeigen
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
    ios.mousepointer(hour_glass)
    'cmd_mount
    'activate_dirmarker(systemdir)
    'ios.sdopen("r",@regsys)
    'ios.ldbin(@regsys)
    ios.ld_rambin(2)

pri testfenster|i,y,a

    a:=0
    window(0,4,2,1,27,38,string("Plexus-IRC"))
    rahmen (1,7,38,27)
    rahmen (1,1,38,3)
    rahmen (1,4,38,6)
    'ios.displaytile(133,colors[winhcol],colors[winhcol],colors[act_color],3,1)   'Rahmen-Verbindungsstücke
    'ios.displaytile(117,colors[winhcol],colors[winhcol],colors[act_color],3,38)

    rahmen (1,22,38,27)
    ios.displaytile(133,colors[winhcol],colors[winhcol],colors[act_color],22,1)   'Rahmen-Verbindungsstücke
    ios.displaytile(117,colors[winhcol],colors[winhcol],colors[act_color],22,38)
    Print_win(string("IRC-Client for Hive-Computer V1.0"),2,2)

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
    ios.get_window
    'Mouse_Release

    repeat 800
        if ios.mouse_button(0)==255
           click++

con'
PRI iniload|i,a
          a:=SETTING_RAM
          repeat i from 0 to 14
               colors[i]:=ios.Read_Flash_Data(a++)'ios.ram_rdbyte(a++)
          dcf_on:=ios.Read_Flash_Data(a+3)'ios.ram_rdbyte(a+3)

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

