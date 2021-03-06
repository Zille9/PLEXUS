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
Name            : Venatrix-Testprogramm - Test der Funktionen der Venatrix-Bus-Erweiterung
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
}}

obj
    ios: "reg-ios-64"

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
  byte colors[15]                                       'Farbwerte
  byte ma,mb                                            'Maus-Tasten

  byte windowx[3]
  byte windowy[3]
  byte windowxx[3]
  byte windowyy[3]
  byte menuey[10]                                       'y-Koordinate für Start-Menue-Einträge
  byte popupx,popupxx                                   'x und
  byte popupy,popupyy                                   'y-Koordinaten des Popupmenues
  byte popupmarker                                      'Marker für Popupmenue
  byte infomarker
  byte buttonx[5],buttony[5]
  byte util
  long systemdir                                        'Plexus-System-Verzeichnis
  byte timezaehler

dat
   regsys        byte "plexus.dll",0                    'Reg.sys für Rückkehr aus externem Programm
   butOK         byte "  OK  ",0
   Abbr          byte "Cancel",0
   SYSTEM        Byte "PLEXUS      ",0                  'Plexus-Systemverzeichnis

PUB main

    ios.start
    cmd_mount                                           'sd-card mounten
    mountmarker:=1                                      'mount-marker
    '--------------------------------------------------------------------------------------
    activate_dirmarker(0)                               'ins root
    ios.sdchdir(@system)                                'System-Verzeichnis lesen
    systemdir:=get_dirmarker                            'Dir-Marker lesen

    '--------------------------------------------------------------------------------------
    cmd_unmount
    iniload                                             'Ini-Datei mit Farbwerten laden
    ios.mousepointer(MOUSE_RAM)
    testfenster
    util:=0
    displaytime                                         'Datum/Zeit
    repeat

      os_cmdinput                                       'Hauptprogrammschleife

PRI os_cmdinput | x,y ,i,dk,key,sync,dcferror,bit_tmp,lvl_tmp,bit_num,bit_lvl,gt_act,act_tmp

  repeat
    time                                                'Zeit und Datum anzeigen

    ma:=ios.mouse_button(0)                             'linke Maustaste
    mb:=ios.mouse_button(1)                             'rechte Maustaste
    key:=ios.key

    if popupmarker==0 and infomarker==0
       sync:=ios.dcf_sync
       dcferror:=ios.dcf_geterror
       plot_status(sync,18,8,1)
       plot_status(dcferror,18,9,0)
       printdec(ios.dcf_getdatacount,10,18,colors[winhcol],colors[act_color])
       bit_num:=ios.dcf_getbitnumber
       if bit_tmp<>bit_num
          Print_win(string("  "),19,11)
       printdec(bit_num,11,18,colors[winhcol],colors[act_color])
       bit_tmp:=bit_num
       bit_lvl:=ios.dcf_getbitlevel
       if lvl_tmp<>bit_lvl
          Print_win(string("  "),19,12)
       lvl_tmp:=bit_lvl
       printdec(bit_lvl,12,18,colors[winhcol],colors[act_color])
       printdec(ios.dcf_gettimezone,14,18,colors[winhcol],colors[act_color])
       gt_act:=ios.dcf_getactive
       if gt_act<>act_tmp
          Print_win(string("  "),19,15)
       act_tmp:=gt_act
       printdec(gt_act,15,18,colors[winhcol],colors[act_color])
   '####################### DCF-Empfangssymbol in der Titelleiste #########################################################
       if sync==1
          ios.displaytile(170,colors[hcolstatus],green,0,29,34)
       else
          ios.displaytile(170,colors[hcolstatus],grey,0,29,34)                                                       'dcf-Symbol grau

   '####################### DCF-Zeit anzeigen #############################################################################
    dcf_time
    if key
       popup_info_weg
       util:=0
'**************************** Short-Cuts ****************************************************************************
    case key
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
          if x>10 or y<24                                                       'Menue loeschen, wenn man woanders hinklickt
             popup_info_weg
             util:=0
          if x=>0 and x=<10 and y==27
             menueselect(string("-EXIT- F12"),menuey[0])
             ausstieg



'****************************** Globale Funktionstasten ********************************************************
       if(x=>buttonx[4]) and (x=<buttonx[4]+5) and (y==buttony[4]) and Infomarker==1     'ok im Infofenster
             buttonpress(4)
             popup_info_weg
             if util==1
                util:=0

       if y==windowy[2] and x==windowx[2] and Infomarker==1                     'doppelklick in linke obere ecke des Info-Fensters
          if doppelklick
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
             if doppelklick
                ausstieg
          if x>1 and x<20                                                      'Doppelklick in die Titelleiste
             if doppelklick
                popup_info_weg
                util:=0
                Display_Info

       if ((x=>0) and (x=<5)) and (y==29)                                       'Start-Knopf
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

pri plot_status(wert,x,y,act)
    if wert==act
       ios.displaytile(COG_PIC,colors[winhcol],green,0,y,x)
    else
       ios.displaytile(COG_PIC,colors[winhcol],red,0,y,x)

PRI Display_Info
    infofenster(9,10,31,15,string("Program-Info"),1)                            'Info-Fenster anzeigen
    Print_win(string("DCF77-Test for Hive"),9,10)
    Print_win(string("Version 1.0 - 01/2014"),9,11)
    Print_win(string("Autor:R.Zielinski"),9,12)
    Print_win(string("Hive-Project.de"),9,13)


PRI infofenster(x,y,xx,yy,strg,knopf)'|i

    ios.backup_area(x-1,y-2,xx+1,yy+1,BRAM)                                     'Hintergrund sichern
    window(2,4,y,x,yy,xx,strg)                                                  'Fenster erstellen
    if knopf==1
       button(4,@butOK,((xx-x)/2)+x-2,yy)                                       'Button 4 gibt es nur im SD-Card-Info-Fenster
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
    'ios.dcf_down
    'ios.display3DBox(255, colors[winhcol], 0, 12, 8, 14, 28)
    'Print_win(string("Return to Plexus..."),9,13)
    ios.mousepointer(hour_glass)
    'cmd_mount
    'activate_dirmarker(systemdir)
    'ios.sdopen("r",@regsys)
    'ios.ldbin(@regsys)
    ios.ld_rambin(2)

pri testfenster|a

    a:=0
    window(0,4,2,1,27,38,string("DCF77-Receiver-Test"))
    rahmen (1,6,38,27)
    rahmen (1,1,38,3)
    rahmen (1,4,38,6)
    ios.displaytile(133,colors[winhcol],colors[winhcol],colors[act_color],6,1)  'Rahmen-Verbindungsstücke
    ios.displaytile(117,colors[winhcol],colors[winhcol],colors[act_color],6,38)
    Print_win(string("DCF77-Clock for Hive-Computer V1.0"),2,2)

    Print_win(string("Sync-Status   :"),2,8)
    Print_win(string("Receive-Error :"),2,9)
    Print_win(string("Receive-Count :"),2,10)
    Print_win(string("Receive-Bit   :"),2,11)
    Print_win(string("Bit-Level     :"),2,12)

    Print_win(string("Time-Zone     :"),2,14)
    Print_win(string("DCF-active    :"),2,15)


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

       s:=ios.getminutes
       if s<>tmptime
          displaytime

PRI displaytime|h,m,x,y

       h:=ios.gethours
       m:=ios.getminutes

        print_zehner(h,29,35,colors[hcolstatus],colors[statustextcol])
        ios.displaytile(42,colors[hcolstatus],0,colors[statustextcol],29,37)

        print_zehner(m,29,38,colors[hcolstatus],colors[statustextcol])
        tmptime:=m
        date

PRI date|t,m,j
      t:=ios.getdate
      m:=ios.getmonth
      j:=ios.getyear


        print_zehner(t,0,29,colors[titelhcol],colors[titeltextcol])
        ios.displaytile(30,colors[titelhcol],0,colors[titeltextcol],0,31)

        print_zehner(m,0,32,colors[titelhcol],colors[titeltextcol])
        ios.displaytile(30,colors[titelhcol],0,colors[titeltextcol],0,34)
        printdec(j,0,35,colors[titelhcol],colors[titeltextcol])

pri dcf_time|h,m,s
       h:=ios.dcf_gethours
       m:=ios.dcf_getminutes
       s:=ios.dcf_getseconds

        print_zehner(h,5,21,colors[winhcol],colors[act_color])
        ios.displaytile(42,colors[winhcol],0,colors[act_color],5,23)

        print_zehner(m,5,24,colors[winhcol],colors[act_color])
        ios.displaytile(42,colors[winhcol],0,colors[act_color],5,26)

        print_zehner(s,5,27,colors[winhcol],colors[act_color])
        dcf_date

PRI dcf_date|t,m,j
      t:=ios.dcf_getday
      m:=ios.dcf_getmonth
      j:=ios.dcf_getyear

        print_zehner(t,5,9,colors[winhcol],colors[act_color])
        ios.displaytile(30,colors[winhcol],0,colors[act_color],5,11)

        print_zehner(m,5,12,colors[winhcol],colors[act_color])
        ios.displaytile(30,colors[winhcol],0,colors[act_color],5,14)
        printdec(j,5,15,colors[winhcol],colors[act_color])

pri print_zehner(wert,y,x,hin,vor)|a
    if wert<10
       printdec(0,y,x,hin,vor)
       a:=1
    else
       a:=0
    printdec(wert,y,x+a,hin,vor)

con'
PRI doppelklick:click                            'pseudo-doppelklick
    click:=0
    ios.get_window
    repeat while ios.mouse_button(0)
    'Mouse_Release

    repeat 500
        if ios.mouse_button(0)==255
           click++

con'
PRI iniload|i,a
          a:=SETTING_RAM
          repeat i from 0 to 14
               colors[i]:=ios.ram_rdbyte(a++)

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
    menue(0,26,9,28)
    printfont(string("Startmenue"),colors[titelhcol],0,colors[titeltextcol],0,25)
    printfont(string("-EXIT- F12"),colors[messagehcol],0,colors[messagetextcol],0,27)
    menuey[0]:=27
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

