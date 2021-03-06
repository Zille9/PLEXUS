{{
┌──────────────────────────────────────────────────────────────────────────────────────────────────────┐
│ Autor: Reinhard Zielinski -> Original-Code: Ingo Kripahle                                                                                │
│ Copyright (c) 2013 Ingo Kripahle                                                                     │
│ See end of file for terms of use.                                                                    │
│ Die Nutzungsbedingungen befinden sich am Ende der Datei                                              │
└──────────────────────────────────────────────────────────────────────────────────────────────────────┘

Informationen   : hive-project.de
Kontakt         : zille9@googlemail.com
System          : Hive
Name            : Bus-Erweiterung für Hive-Computer
Chip            : Venatrix
Typ             : Treiber
Version         : 01
Subversion      : 00
Funktion        : Bus-System für Erweiterungsmodule

Der integrierte Loader kann Venatrix mit einem beliebigen Code versorgen

20-11-2013      -I2C-Slave Funktion hinzugefügt, damit die Bus-Karte vom Hive (Plexus) erkannt werden kann (Adresse 5)

22-03-2014      -HC05-Bluetoothmodul-Statuspin-Abfrage an Portpin 16 hinzugefügt
                -IP-Stack von Joerg angefangen zu integrieren
                -
COG's           : MANAGMENT     1 COG
                  I2C-Slave     1 COG
                  IP-Stack      1 COG
                  -------------------
                                3 COG's

}}
CON
_CLKMODE     = XTAL1 + PLL16X
_XINFREQ     = 5_000_000
Treiberversion= %00010001
'Treiberdatum  = 20122013


'          /cs     --------+
'          clk     -------+|
'          /wr     ------+||
'          /hs     -----+||| +------------------------- /cs ->bei Venatrix P24 statt P23
'                       |||| |                 -------- d0..d7
DB_IN            = %00001000_00000000_00000000_00000000 'maske: dbus-eingabe
DB_OUT           = %00001000_00000000_00000000_11111111 'maske: dbus-ausgabe

M1               = %00000010_00000000_00000000_00000000 'busclk=1? & /cs=0?
M2               = %00000011_00000000_00000000_00000000 'maske: busclk & /cs (/prop4)

M3               = %00000000_00000000_00000000_00000000 'busclk=0?
M4               = %00000010_00000000_00000000_00000000 'maske busclk




#0,     D0,D1,D2,D3,D4,D5,D6,D7                         'datenbus (Port A)
#8,     B0,B1,B2,B3,B4,B5,B6,B7                         'Port B
#16,    C0,C1,C2,C3,C4,C5,C6,C7                         'Port C
#24,    BUS_CS                                          'Chip-Select
        BUSCLK                                          'bustakt
        BUS_WR                                          '/wr - schreibsignal
        BUS_HS '                                        '/hs - quittungssignal

  SDA_PIN       = 29
  SCL_PIN       = 28

txpin  = 9
rxpin  = 8
Ack    = 6
Error  =15
obj
        bus      : "Venatrix-Bus"                         'allgemeine Bus-Funktionen
        i2c_slave: "i2c_slave_Venatrix"
        ser      : "FullDuplexSerialExtended"

Var
  byte proghdr[16]                                     'puffer für objektkopf
  long plen                                            'länge datenblock loader
  byte x,y
  word Textcolor
PUB main | zeichen,i,a                             'chip: kommandointerpreter
''funktionsgruppe               : chip
''funktion                      : kommandointerpreter
''eingabe                       : -
''ausgabe                       : -

  bus.bus_init
  i2c_Slave.Start( SCL_PIN, SDA_PIN, $5)
  ser.start(rxpin, txpin, 0, 9600)
  waitcnt(cnt+clkfreq*2)
  x:=0
  y:=0


  repeat until ser.rxcheck==6
     ser.tx($55)
  'if ser.rx==6

'  a:=0
  'waitcnt(clkfreq/20+cnt)
  'ser.tx($56)

  repeat while a<20

     waitcnt(clkfreq/20+cnt)
     ser.tx($73)
     ser.tx(0)
     ser.tx(y++)
     ser.tx($10)
     ser.tx($FF)
     ser.tx($FF)
     ser.str(string("Zille-Soft-GmbH praesentiert"))
     ser.tx(0)

     if ser.rx==6
        a++
        next

  'Kreis
  waitcnt(clkfreq/20+cnt)
  ser.tx($43)
  ser.tx(00)
  ser.tx($24)
  ser.tx(00)
  ser.tx($52)
  ser.tx(00)
  ser.tx($14)
  ser.tx(00)
  ser.tx($1F)

  'Hintergrund
  waitcnt(clkfreq/20+cnt)
  ser.tx($42)
  ser.tx($F8)
  ser.tx($0F)

  repeat
    zeichen := bus.bus_getchar                          'kommandocode empfangen
    if zeichen                                                                                           ' > 0
       printCharacter(zeichen)
    else
       zeichen:=bus.bus_getchar
    case zeichen


{
       10: bus.bus_putchar(Port2_In)                    'Sende Port-Zustand 2
       20: bus.bus_putchar(Port3_In)                    'Sende Portzustand 3
       30: Port2_Out(bus.bus_getchar)                   'Setze Port 2
       40: Port3_Out(bus.bus_getchar)                   'Setze Port 3
       }
       '50: bus.bus_putchar(HC05_Status)                 'Status des HC05-Bluetooth-Moduls

'       ----------------------------------------------  LAN-FUNKTIONEN
{       71: lan_start                                    'Start Network
       72: lan_stop                                     'Stop Network
       73: lan_connect                                  'ausgehende TCP-Verbindung öffnen
       74: lan_listen                                   'auf eingehende TCP-Verbindung lauschen
       75: lan_waitconntimeout                          'bestimmte Zeit auf Verbindung warten
       76: lan_close                                    'TCP-Verbindung schließen
       77: lan_rxtime                                   'bestimmte Zeit warten auf Byte aus Empfangspuffer
       78: lan_rxdata                                   'Daten aus Empfangspuffer lesen
       79: lan_txdata                                   'Daten senden
       80: lan_rxbyte                                   'wenn vorhanden, Byte aus Empfangspuffer lesen
       81: lan_isconnected                              'TRUE, wenn Socket verbunden, sonst FALSE
}
'       ----------------------------------------------  CHIP-MANAGMENT
       96: bus.bus_putchar(bus.mgr_getcogs)             'freie cogs abfragen
       97: bus.mgr_load                                 'neuen Venatrix-code laden
       98: bus.bus_putlong(Treiberversion)              'Rückgabe Testwert (Version des Venatrix-Treibers)

       99: reboot                                       'Venatrix neu starten

pri printCharacter(n)

    case n
        4: 'X=0
        5: 'Left
        6: 'right
        7: 'Home
        8: 'Backspace
        9: 'Tab
        10: 'Y+1
        11: 'Y-1
        12: 'cls
            ser.tx("E")
            y:=0
            x:=0
        13: 'Return
            x:=0
            y++
        other: 'character
            ser.tx(84)
            ser.tx(x)
            ser.tx(y)
            ser.tx(Textcolor)
            x++
            if x>39
               y++
               x:=0

