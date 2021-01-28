{{
Template für externe Programme unter Plexus-Shell
}}

obj ios: "reg-ios-64"

con
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
SETTING_RAM = $7FF00 'Hier stehen die System-Settings

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
'--------------------------------------------------------------------------------

var

byte mountmarker,tmptime
long rootdir                     'root-Dirmarker
long userdir                     'user-Dirmarker
byte colors[15]                  'Farbwerte
byte ma,mb,mz                    'Maus-Tasten und Scrollrad

  byte buttonx[8]                  'Knöpfe
  byte buttony[8]
  byte windownum[8]                'Arbeits-Windows
  byte windowx[8]
  byte windowy[8]
  byte windowxx[8]
  byte windowyy[8]
  byte messagex                    'x-Position der Messagebox
  byte tag,monat,stunde,minute sekunde 'Datum -und Zeit
  word jahr
  byte menuemarker                 'Marker für Startmenue
  byte menuey[10]                  'y-Koordinate für Start-Menue-Einträge
  byte popupx                      'x und
  byte popupy                      'y-Koordinaten des Popupmenues
  byte popupmarker                 'Marker für Popupmenue
  byte menue_nr                    'nr des gerade angezeigten Menues
  byte infomarker
dat
'   ini           byte "reg.ini",0               'Ini-Datei für Farbwerte
   regsys        byte "plexus.dll",0            'Reg.sys für Rückkehr aus externem Programm
   butOK         byte "  OK  ",0
   Abbr          byte "Cancel",0

PUB main

    ios.start
    ios.sdmount                                     'sd-card mounten
    mountmarker:=1                                  'mount-marker
    if ios.admgetspec<>ADM_SPEC                     'ADM-Spezifikation SID?
       ios.admreset'ios.admload(@adm)               'Administracode wird im EEPROM erwartet
    if ios.bel_get<>64                              'BEL-Treiber 64 farben Tile ?
       ios.belreset                                 'Bellatrixcode wird im EEPROM erwartet
    '--------------------------------------------------------------------------------------
    rootdir:=get_dirmarker                          'Dir-Marker für root Verzeichnis lesen
    userdir:=rootdir                                'User-Dir-Marker erst mal mit root vorbelegen
    ios.sdunmount
    '--------------------------------------------------------------------------------------
    ios.sdmount
    iniload                                          'Ini-Datei mit Farbwerten laden
    buttonweg
    testfenster
    repeat

      os_cmdinput                           'Hauptprogrammschleife

PRI os_cmdinput | x,y ,i,dk,util

  repeat
    time                                                                                           'Zeit und Datum anzeigen

    ma:=ios.mouse_button(0)                                                                        'linke Maustaste
    mb:=ios.mouse_button(1)                                                                        'rechte Maustaste
    mz:=ios.mousez                                                                                 'scrollrad


'***************************** linke Maustaste **********************************************************************
    if ma==255
       dk:=0
       x:=ios.mousex
       y:=ios.mousey

       repeat i from 1 to 7                                                              'Abfrage auf Fensterloeschen
            if windownum[i]==1
               if (x==windowxx[i]) and (y==windowy[i])
                       windowloesch(i)
                       ios.sdopen("r",@regsys)
                       ios.ldbin(@regsys)


               if (x==windowx[i]) and (y==windowy[i])
                   dk:=doppelklick
                   if dk>1
                       windowloesch(i)
                       ios.sdopen("r",@regsys)
                       ios.ldbin(@regsys)


'****************************** Startmenue anzeigen ************************************************************
       if menuemarker==1
          if x>10 or y<14                                         'Menue loeschen, wenn man woanders hinklickt
             menueweg
             testfenster
          if x=>0 and x=<10 and y=>14 and y=<28
             repeat i from 0 to 5
                 if menuey[i]==y
                    util:=0                                       'eventuelle Utilitie-Fenster deaktivieren
                    case i
                         0:menueselect(string("  -EXIT-  "),menuey[i])
                           windowloesch(7)
                           ios.sdopen("r",@regsys)
                           ios.ldbin(@regsys)
                           'windowloesch(7)

'****************************** IO-Port-Fenster ****************************************************************
       if y==4
          if x==3 or x==20
             toogle_board(x)
'****************************** Globale Funktionstasten ********************************************************

       if (x==39) and (y==0)                                      'Beenden-Knopf

             ios.sdopen("r",@regsys)
             ios.ldbin(@regsys)

       if (x==0) and (y==0)                                       'Beenden bei Doppelklick auf linke obere Ecke
          dk:=doppelklick
          if dk>1
             ios.sdopen("r",@regsys)
             ios.ldbin(@regsys)

       if ((x=>0) and (x=<5)) and (y==29)                         'Start-Knopf
          buttonpress(3)
          if menuemarker==1
             'fensterweg
             Menueweg
             testfenster

          else
             fensterweg
             startmenue
             menuemarker:=1

          '****************************** Globale Abfrage OK und Cancel-Button *****************************
       if(x=>buttonx[1]) and (x=<buttonx[1]+5) and (y==buttony[1])     'ok
            buttonpress(1)
            if windownum[2]==1
               ios.restore(windowx[2],windowy[2],windowxx[2],windowyy[2])
               popup_info_weg



       if(x=>buttonx[2]) and (x=<(buttonx[2]+6)) and (y==buttony[2])   'cancel
            buttonpress(2)
            fensterweg
            testfenster

pri toogle_board(tg)
    case tg
         3:ios.displaytile(138,colors[winhcol],colors[winhcol],255,4,3)
           ios.displaytile(Cog_pic,colors[winhcol],colors[winhcol],255,4,20)
         20:ios.displaytile(Cog_pic,colors[winhcol],colors[winhcol],255,4,3)
           ios.displaytile(138,colors[winhcol],colors[winhcol],255,4,20)

pri testfenster|i
    'dira[24]~
    'i:=ina[24]
    window(7,4,1,27,38,string("I/O-Card-Test"))
    rahmen (1,6,37,25)
    rahmen (1,3,37,5)
    rahmen (3,8,18,18)
    'ios.displaytile(COG_PIC,winhcol,red,0,8+i+i,19+cogs-1)
    ios.displaytile(138,colors[winhcol],colors[winhcol],255,4,3)
    printfont(string("Sepia-Card"),colors[winhcol],0,colors[act_color],4,4)
    'printdec(i,20,20,colors[hcolstatus],colors[statustextcol])
    ios.displaytile(Cog_pic,colors[winhcol],colors[winhcol],255,4,20)
    printfont(string("Venatrix-Card"),colors[winhcol],0,colors[act_color],21,4)
                                           'y,x
    ios.displaytile(COG_PIC,colors[winhcol],green,0,10,6)
    ios.displaytile(COG_PIC,colors[winhcol],green,0,11,5)
    ios.displaytile(COG_PIC,colors[winhcol],green,0,11,7)
    ios.displaytile(COG_PIC,colors[winhcol],green,0,12,6)

    ios.displaytile(COG_PIC,colors[winhcol],green,0,14,6)

    printfont(string("Port 1"),colors[winhcol],0,colors[act_color],4,16)

    ios.displaytile(COG_PIC,colors[winhcol],green,0,10,14)
    ios.displaytile(COG_PIC,colors[winhcol],green,0,11,13)
    ios.displaytile(COG_PIC,colors[winhcol],green,0,11,15)
    ios.displaytile(COG_PIC,colors[winhcol],green,0,12,14)

    ios.displaytile(COG_PIC,colors[winhcol],green,0,14,14)

    printfont(string("Port 2"),colors[winhcol],0,colors[act_color],12,16)

    printfont(string("Joystick-Test"),colors[winhcol],0,colors[act_color],4,8)

    'printfont(string("eingebettetes Programm"),colors[winhcol],0,colors[act_color],3,5)

con'****************************************************** Datum und Zeitanzeige *************************************************************************************************

PRI time|s                             'Zeitanzeige in der Statusleiste

    s:=ios.getminutes
    if s<>tmptime
       displaytime

PRI displaytime|h,m,x,y

       h:=ios.gethours
       m:=ios.getminutes
        if h<10
           printdec(0,29,34,colors[hcolstatus],colors[statustextcol])
           y:=1
        else
           y:=0
        printdec(h,29,34+y,colors[hcolstatus],colors[statustextcol])
        ios.displaytile(42,colors[hcolstatus],0,colors[statustextcol],29,36)
        if m<10
           printdec(0,29,37,colors[hcolstatus],colors[statustextcol])
           x:=1
        else
           x:=0
        printdec(m,29,37+x,colors[hcolstatus],colors[statustextcol])
        tmptime:=m
        date

PRI date|t,m,j,y,x
      t:=ios.getdate
      m:=ios.getmonth
      j:=ios.getyear

        if t<10
           printdec(0,0,29,colors[titelhcol],colors[titeltextcol])
           y:=1
        else
           y:=0
        printdec(t,0,29+y,colors[titelhcol],colors[titeltextcol])
        ios.displaytile(30,colors[titelhcol],0,colors[titeltextcol],0,31)
        if m<10
           printdec(0,0,32,colors[titelhcol],colors[titeltextcol])
           x:=1
        else
           x:=0
        printdec(m,0,32+x,colors[titelhcol],colors[titeltextcol])
        ios.displaytile(30,colors[titelhcol],0,colors[titeltextcol],0,34)
        printdec(j,0,35,colors[titelhcol],colors[titeltextcol])


con '*********************************************** Fenster-Lösch-Funktionen ****************************************************************************************************
PRI windowloesch(num)                               'einzelnes Fenster löschen
    ios.display2dbox(colors[shellhcol], windowy[num], windowx[num], windowyy[num], windowxx[num])  'Fenster loeschen
    'regal(colors[shellhcol],colors[panelcol],0,26,11)
    if menuemarker==1
       menueweg
    win_paraloesch(num)

    'muelleimer:=0
    'util:=0

PRI win_paraloesch(num)                             'Fensterparameter löschen

    windownum[num]:=windowx[num]:=windowy[num]:=windowxx[num]:=windowyy[num]:=-1           'Windowwerte loeschen


PRI fensterweg|i                                    'alle gesetzten Fenster loeschen
    repeat i from 1 to 7
          if windownum[i]==1
             windowloesch(i)

    repeat i from 0 to 7
            buttonx[i]:=-1
            buttony[i]:=-1
con'
PRI doppelklick:click                            'pseudo-doppelklick
    click:=0
    repeat while ios.mouse_button(0)>0

    repeat 500
        if ios.mouse_button(0)==255
           click++
con'
PRI iniload|i,a
          a:=SETTING_RAM
          repeat i from 0 to 14
               colors[i]:=ios.ram_rdbyte(0,a++)
'          repeat i from 0 to 4
'               sys_set[i]:=ios.ram_rdbyte(0,a++)

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
PRI window(num,y,x,yy,xx,strg)|i                         'ein Fenster erstellen
    windowx[num]:=x-1
    windowy[num]:=y-2
    windowxx[num]:=xx+1
    windowyy[num]:=yy+1

    ios.displaytile(0,colors[winhcol],0,colors[winframecol],y-2,x-1)
    repeat i from x to xx
        ios.displaytile(16,colors[Titelhcol],$ff,$ff,y-2,i)
    ios.displaytile(1,colors[winhcol],0,colors[winframecol],y-2,xx+1)
    repeat i from y-1 to yy
       ios.displaytile(2,colors[winhcol],0,colors[winframecol],i,x-1)
       ios.displaytile(77,colors[winhcol],0,colors[winframecol],i,xx+1)
    repeat i from x-1 to xx
       ios.displaytile(6,colors[winhcol],0,colors[winframecol],yy+1,i)

    ios.displaytile(4,colors[winhcol],0,colors[winframecol],yy+1,x-1)
    ios.displaytile(5,colors[winhcol],0,colors[winframecol],y-1,xx+1)
    ios.displaytile(3,colors[winhcol],0,colors[winframecol],yy+1,xx+1)

    ios.printBoxSize(num,y-1, x, yy, xx)
    ios.printBoxColor(num,colors[act_color],colors[winhcol],0)
    ios.printcursorrate(0)
    ios.printchar(12)                    'cls
    windownum[num]:=1
    printfont(strg,colors[titelhcol],0,colors[titeltextcol],x+1,y-2)


PRI printfont(str1,a,b,c,d,e)|f

    repeat strsize(str1)
         f:= byte[str1++]
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

PRI button(n,btext,x,y)
    printfont(btext,colors[buttonhcol],0,colors[buttontextcol],x,y)
    buttonx[n]:=x
    buttony[n]:=y


PRI buttonpress(n)|s
    s:=0
    case n
             1: printfont(@butOK,250,0,0,buttonx[n],buttony[n])
             2: printfont(@Abbr,250,0,0,buttonx[n],buttony[n])
             3: printfont(string("START"),250,0,0,0,29)
                s:=1
             4: printfont(@butOK,250,0,0,buttonx[n],buttony[n])
{
       5,6,7,8:ios.displaytile(144,colors[winhcol],250,0,taby[n-4],tabx[n-4])
               printfont(@buttontext[n*6],250,0,0,buttonx[n],buttony[n])
               ios.displaytile(145,colors[winhcol],250,0,taby[n-4],tabl[n-4])
               s:=2
}
    repeat while ios.mouse_button(0)>0
    case s
         1:printfont(string("START"),colors[hcolstatus],0,colors[statustextcol],0,29)
    '     2:ios.displaytile(144,colors[winhcol],colors[buttonhcol],0,taby[n-4],tabx[n-4])                 'tab wiederherstellen
    '       printfont(@buttontext[n*6],colors[buttonhcol],0,colors[buttontextcol],buttonx[n],buttony[n])
    '       ios.displaytile(145,colors[winhcol],colors[buttonhcol],0,taby[n-4],tabl[n-4])

PRI abfrage:taste|a,x,y
    repeat
      a:=ios.mouse_button(0)
      if a==255
         x:=ios.mousex
         y:=ios.mousey

         if(x=>buttonx[1]) and (x=<buttonx[1]+5) and (y==buttony[1])     'ok
            buttonpress(1)
            taste:=1
            quit
         if(x=>buttonx[2]) and (x=<(buttonx[2]+6)) and (y==buttony[2])   'cancel
            buttonpress(2)
            taste:=2
            quit
    fensterweg
    ios.display2dbox(colors[shellhcol], 10, 7, 17, messagex)
con '*************************************************** Start-Menue *************************************************************************************************************
PRI Menue(x,y,xx,yy)|i
    popup(x,y,xx,yy)
    repeat i from x to xx
        ios.displaytile(16,colors[Titelhcol],$ff,$ff,y-1,i)

PRI menueweg
    ios.display2dbox(colors[shellhcol],14,0,28,9)
    menuemarker:=0

PRI separator(x,y,xx)|i
    repeat i from x to xx
         ios.displaytile(6,colors[Messagehcol],0,colors[winframecol],y,i)

PRI menueselect(stri,y)
    printfont(stri,colors[messagetextcol],0,colors[messagehcol],0,y)
    repeat while ios.mouse_button(0)>0
    printfont(stri,colors[messagehcol],0,colors[messagetextcol],0,y)
    menueweg

PRI Startmenue
    menue(0,26,9,28)
    menuemarker:=1
    printfont(string("Startmenue"),colors[titelhcol],0,colors[titeltextcol],0,25)
    separator(0,26,9)
'    printfont(string("Files"),messagehcol,0,messagetextcol,0,16)
'    menuey[0]:=16
'    separator(0,17,9)
'    printfont(string("Baud"),messagehcol,0,messagetextcol,0,18)
'    menuey[1]:=18
'    separator(0,19,9)
'    printfont(string("Settings"),messagehcol,0,messagetextcol,0,20)
'    menuey[2]:=20
'    separator(0,21,9)
'    printfont(string("Programs"),messagehcol,0,messagetextcol,0,22)
'    menuey[3]:=22
'    separator(0,23,9)
'    printfont(string("About"),messagehcol,0,messagetextcol,0,24)
'    menuey[4]:=24
'    separator(0,25,9)
    printfont(string("  -EXIT-  "),colors[messagehcol],0,colors[messagetextcol],0,27)
    menuey[0]:=27
con '*************************************************** Popup-Menue *************************************************************************************************************

PRI popup(x,y,xx,yy)
    ios.display2dbox(colors[messagehcol],y,x,yy,xx)
    popupx:=x
    popupy:=y

PRI popup_entry(num,strg,sep)
    if sep==1
       separator(popupx,popupy+num,popupx+6)
       num+=1
       printfont(strg,colors[messagehcol],0,colors[messagetextcol],popupx,popupy+num)
    printfont(strg,colors[messagehcol],0,colors[messagetextcol],popupx,popupy+num)
    'popentry[num]:=num

PRI Popup_Info_weg
          if infomarker==1                                                         'Infofenster sichtbar?
             ios.restore(windowx[2],windowy[2],windowxx[2],windowyy[2])            'Hintergrund wiederherstellen
             'win_paraloesch(2)                                                    'Info-Fenster-Parameter loeschen
             infomarker:=0                                                         'Marker loeschen
          if popupmarker==1                                                        'Popupmenue sichtbar?
             ios.restore(popupx,popupy,popupx+6,popupy+7)                          'Hintergrund wiederherstellen
             popupmarker:=0                                                        'Popupmarker loeschen

PRI popupselect(stri,x,y)
    printfont(stri,colors[messagetextcol],0,colors[messagehcol],x,y)
    repeat while ios.mouse_button(0)>0
    printfont(stri,colors[messagehcol],0,colors[messagetextcol],x,y)
    'popupmarker:=0
pri Buttonweg|i
    repeat i from 0 to 7
            buttonx[i]:=-1
            buttony[i]:=-1
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

PRI FRAME_TILE(nu,ty,tx)
    ios.displaytile(nu,colors[winhcol],0,colors[winframecol],ty,tx)

PRI TITEL_TILE(nu,ty,tx)
    ios.displaytile(nu,colors[titelhcol],0,colors[titeltextcol],ty,tx)

PRI print_win(stradr,x,y)
    printfont(stradr,colors[winhcol],0,colors[act_color],x,y)

PRI print_titel(stradr,x,y)
    printfont(stradr,colors[titelhcol],0,colors[titeltextcol],x,y)

PRI Print_button(stradr,x,y)
    printfont(stradr,colors[buttonhcol],0,colors[buttontextcol],x,y)

PRI print_status(stradr,x,y)
    printfont(stradr,colors[hcolstatus],0,colors[statustextcol],x,y)

PRI print_message(stradr,x,y)
    printfont(stradr,colors[messagehcol],0,colors[messagetextcol],x,y)

PRI printdec_win(n,y,x)
    printdec(n,y,x,colors[winhcol],colors[act_color])

PRI printdec_titel(n,y,x)
    printdec(n,y,x,colors[titelhcol],colors[titeltextcol])

