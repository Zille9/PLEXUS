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
Version         : 00
Subversion      : 01
Funktion        : Bus-System für Erweiterungsmodule

Der integrierte Loader kann Venatrix mit einem beliebigen Code versorgen


COG's           : MANAGMENT     1 COG
                  -------------------
                                1 COG

}}
CON
_CLKMODE     = XTAL1 + PLL16X
_XINFREQ     = 5_000_000

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



{DB_IN            = %00001001_00000000_00000000_00000000 'maske: dbus-eingabe
DB_OUT           = %00001001_00000000_00000000_11111111 'maske: dbus-ausgabe

M1               = %00000010_00000000_00000000_00000000
M2               = %00000010_10000000_00000000_00000000 'busclk=1? & /cs=0?

M3               = %00000000_00000000_00000000_00000000
M4               = %00000010_00000000_00000000_00000000 'busclk=0?



DB_IN            = %00001001_00000000_00000000_00000000 'dira-wert für datenbuseingabe
DB_OUT           = %00001001_00000000_00000000_11111111 'dira-wert für datenbusausgabe

M1               = %00000010_00000000_00000000_00000000 'busclk=1? & /prop1=0?
M2               = %00000010_10000000_00000000_00000000 'maske: busclk & /cs (/prop1)

M3               = %00000000_00000000_00000000_00000000 'busclk=0?
M4               = %00000010_00000000_00000000_00000000 'maske: busclk
}
#0,     D0,D1,D2,D3,D4,D5,D6,D7                         'datenbus (Port A)
#8,     B0,B1,B2,B3,B4,B5,B6,B7                         'Port B
#16,    C0,C1,C2,C3,C4,C5,C6,C7                         'Port C
#24,    BUS_CS                                          'Chip-Select
        BUSCLK                                          'bustakt
        BUS_WR                                          '/wr - schreibsignal
        BUS_HS '                                        '/hs - quittungssignal

  SDA_PIN       = 29
  SCL_PIN       = 28

obj
        ser    :"SerialMirror"                         'debug-ausgabe
        bus    :"Venatrix-Bus"                         'allgemeine Bus-Funktionen
        i2c_slave: "i2c_slave_Venatrix"

Var
  byte proghdr[16]                                     'puffer für objektkopf
  long plen                                            'länge datenblock loader

PUB main | zeichen,i                             'chip: kommandointerpreter
''funktionsgruppe               : chip
''funktion                      : kommandointerpreter
''eingabe                       : -
''ausgabe                       : -
  bus.bus_init
  i2c_Slave.Start( SCL_PIN, SDA_PIN, $5)

  ser.start(31,30,0,9600)
'  repeat
     ser.str(string("Dies ist ein Test des Bluetoothmoduls HC-05",13))
     ser.str(string("===========================================",13))
     ser.tx(13)
     ser.str(string("Dieses Testprogramm wurde als Datei in Venatrix",13))
     ser.str(string("geladen und gestartet.",13))
     ser.str(string("Das Bluetoothmodul startet mit der Grundeinstellung",13))
     ser.str(string("9600 baud 1N8 und ist ohne weitere Zusatzbeschaltung",13))
     ser.str(string("lauffähig. Konfigurierbar ueber AT-Kommandos und als",13))
     ser.str(string("Master oder Slave verwendbar und das alles für nur",13))
     ser.str(string("6,95 Euro. Wenn das nicht cool ist....",13))
     ser.tx(13)
     ser.str(string("Sollte es möglich sein, Bluetooth-Tastaturen an den",13))
     ser.str(string("Hive anzuschliessen ? Weitere Tests werden das zeigen",13))
     ser.tx(13)
     ser.str(string("Als Erstes muss ein Programm her, mit dem das Modul",13))
     ser.str(string("konfiguriert und gezielt mit anderen Bluetooth-",13))
     ser.str(string("Teilnehmern gekoppelt werden kann, dann sehen wir",13))
     ser.str(string("das Potential dieses Winzlings. :-)",13))
     ser.str(string("Schauen wir mal, was wird ;-)",13))
     ser.str(string("------------ Testdatei-Ende ----------------",13))
     ser.str(string("===========================================",13))


  repeat
    zeichen := bus.bus_getchar                                  'kommandocode empfangen
{    ser.dec(zeichen)
    ser.tx(13)
    'err := 0
     ser.str(string("2.Venatrix-Testprogramm Version 1.0",13))
     ser.str(string("=================================",13))
     ser.str(string("Dieses Testprogramm wurde als zweite Datei geladen und gestartet.",13))
     ser.str(string("------------ Testdatei-Ende ----------------",13))
}
    case zeichen

'       ----------------------------------------------  CHIP-MANAGMENT
       96: bus.mgr_getcogs                                 'freie cogs abfragen
       97: bus.mgr_load                                    'neuen bellatrix-code laden
       99: reboot                                      'bellatrix neu starten


