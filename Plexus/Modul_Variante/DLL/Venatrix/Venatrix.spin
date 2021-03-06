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
                  SPI-TREIBER   1 COG
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

  slave_adress  = $5

   _CS = 8
   _Clk = 9
   _DIO = 10
   _DO = 11

  STRCOUNT         =64                                    'Größe des Stringpuffers

  HC05 = 16                                               'Statuspin HC05-Bluetooth-Modul

con '1-Wire Konstanten
  OW_DATA           = 17'7  ' 1-wire data pin  *** is this the right pin? ***

  ' One Wire ROM Commands - all devices
  SEARCH_ROM        = $F0
  READ_ROM          = $33
  MATCH_ROM         = $55
  SKIP_ROM          = $CC

  ' DS18B20 commands
  ALARM_SEARCH      = $EC
  READ_SCRATCHPAD   = $BE
  CONVERT_T         = $44
  COPY_SCRATCHPAD   = $48
  RECALL_EE         = $B8
  READ_POWER_SUPPLY = $B4

  ' 1-wire family codes
  FAMILY_DS18B20    = $28
  FAMILY_DS1822     = $22
  FAMILY_DS18S20    = $10

  MAX_DEVICES       = 8                                ' maximum number of 1-wire devices
con 'Dht Konstanten
' pins for data and clock.
' Note sht1x and sht7x protocol is like i2c, but not exactly
' Assumes power = 3.3V
  DPIN = 18'13    ' needs pullup resistor
  'CPIN = 19'14    ' best use pulldown resistor for reliable startup, ~100k okay.

obj
        i2c_slave: "i2c_slave_Venatrix"
        'gc       : "glob-con"       'globale konstanten
        'ser      : "FullDuplexSerialExtended"
        'flash    : "Winbond_DRIVER"
        'ow       : "SpinOneWire"
        fp       : "dwdFloatString2"
        f        : "FloatMath"                           ' could also use Float32
        sht      : "DHT22_Driver"'"Sensirion_integer"

Var
  long plen                                            'länge datenblock loader
  long fcb[4]                                          'File-Control-Block
  long p                                               'DeviceList
  long deviceList[MAX_DEVICES*2]                       '64-bit address buffer
  long temperatur[max_devices+1]
  long busstack[32]
  long buscogid
  byte strpuffer[STRCOUNT]                             'stringpuffer
  byte proghdr[16]                                     'puffer für objektkopf
  byte device                                          'Anzahl Busteilnehmer
  byte bus_value[16]
  byte buslock

PUB main | zeichen,i,c,zaehler,durchlauf                             'chip: kommandointerpreter
''funktionsgruppe               : chip
''funktion                      : kommandointerpreter
''eingabe                       : -
''ausgabe                       : -

  bus_init
  i2c_Slave.Start( SCL_PIN, SDA_PIN, slave_adress)

  waitcnt(clkfreq+cnt)
  'flash.start(_CS, _Clk, _DIO, _DO, -1, -1)
  'ser.start(31,30,0,57600)

  'ow.start(OW_DATA)                      'start 1-wire object mit Pin 17
  sht.DHT_Init(DPIN)                   'start sht-object mit Pin 18,19
  zaehler:=0

'  init

  repeat


    {zaehler++
    if zaehler>50
       device:=ow.search(0, MAX_DEVICES, @deviceList)      'Anzahl Teilnehmer
       Get_Temp
       zaehler:=0
       waitcnt(cnt+clkfreq/1000)
    }
    zeichen := bus_getchar                          'kommandocode empfangen
    case zeichen
      '############ Flash-Dateifunktionen ###########
{        1:flash.firstfile(@fcb)
        2:Flash_Next
        3:Open_File
        4:Delete_File
        5:Putblk
        6:Getblk'readFile(p,a,c)
        8:
        9:'bootFile(p)
       10:'writeStr(p,s)
       11:'dec(p,value)
       12:'hex(p, value, digits)
       13:'bin(p, value, digits)
}
     '############ Flashdaten direktzugriff #########
       14:'readData(addr, data, count)
       15:'writeData(addr, data, count)
       16:'eraseData(addr)

     '############ Flash Info #######################
       '17:bus_putlong(flash.flashSize)

     '############ SPI-SRAM-Zugriff #################
       '18:'readSRAM(addr, data, count)
       '19:'writeSRAM(addr, data, count)

     '############ 1-Wire Funktionen ################
       {19:device:=ow.search(0, MAX_DEVICES, @deviceList)      '1-Wire-Bus nach Anzahl Teilnehmer durchsuchen

       20:c:=bus_getchar
          Get_Temp
          bus_putstr(fp.FloatToFormat(temperatur[c], 6, 2))
       21:bus_putchar(device)
       22:bus_putchar(byte[p])                       'Device Name
       23:bus_putchar(byte[p+7])                     'CRC
       24:bus_putlong(p+6)                           'Adresse
       25:ow.reset                                   'Reset-Befehl
       26:ow.writeByte(bus_getchar)                  'ein Byte schreiben
       27:ow.writeAddress(bus_getlong)               'Adresse schreiben
       28:bus_putlong(ow.readbits(bus_getchar))      'device auslesen
       29:c:=bus_getchar
          Get_Temp
          Bus_putlong(temperatur[c])                 'Temperatur lesen
          }
     '############ DHT Funktionen ###################
       30:'c:=F.FDiv(f.FFloat(sht.Temperatur),f.ffloat(10))
          'bus_putstr(fp.FloatToString(c))           'Temperatur+Feuchte lesen ->Temperatur senden
          bus_putstr(string("21.3"))

       31:'c:=sht.get_hum                            'nur Feuchtewert senden
          'c:=f.FFloat(c)                            'sht.Feuchte funktioniert mit Plexus nicht ->zu schnelle Abfrage
          'bus_putstr(fp.FloatToString(c))           'Feuchte lesen
          bus_putstr(string("33"))
     '############ direkte Portzugriffe #############
       40: bus_putchar(Port2_In)                    'Sende Port-Zustand 2
       41: bus_putchar(Port3_In)                    'Sende Portzustand 3
       42: Port2_Out(bus_getchar)                   'Setze Port 2
       43: Port3_Out(bus_getchar)                   'Setze Port 3
       '44: port0_in
     '############ HC05-Bluetooth-Status-Pin-Abfrage ################
       50: bus_putchar(HC05_Status)                 'Status des HC05-Bluetooth-Moduls

'       ----------------------------------------------  CHIP-MANAGMENT
       96: bus_putchar(mgr_getcogs)                 'freie cogs abfragen
       97: mgr_load                                 'neuen Venatrix-code laden
       98: bus_putlong(Treiberversion)              'Rückgabe Testwert (Version des Venatrix-Treibers)

       99: reboot                                       'Venatrix neu starten

{PRI poller |i,c                                             'plx: pollcog

  repeat
    'semaphore setzen
    repeat until not lockset(buslock) 'auf freien bus warten
    'BUS-Leitungen pollen
    repeat i from 0 to 15
             c:=ina[7..0]
             ifnot c
                 next
             bus_value[i] := c
    lockclr(buslock)            'bus freigeben

pub Init
  Buslock := locknew
  'pollcog starten
  Buscogid := cognew(poller,@busstack)

pub busget_stop
   if(buscogid)
     cogstop(buscogid~ - 1)
     lockret(-1 + buslock~)

PUB run                                                 'plx: polling aktivieren
  lockclr(buslock)            'bus freigeben

PUB halt                                                'plx: polling stoppen

  repeat until not lockset(buslock) 'auf freien bus warten
}
{pub Get_Temp|n,i,b
' ***********************************************
' * Read each device and display its temperature
' ***********************************************
    ow.reset                       ' preparatory command
    ow.writeByte(SKIP_ROM)         ' SKIP_ROM commands all devices at once
    ow.writeByte(CONVERT_T)        ' start temperature conversion

    'repeat                         ' wait for conversion to be done
    '  waitcnt(cnt+clkfreq/1000)*25) ' DS1822/DS18B20 takes 93 to 750 ms for 9, 10, 11, 12
    '  if ow.readBits(1)            ' bit precision conversion, default 12 bits
    '    quit                       ' DS1820/DS18S20 takes 750 ms for it 9 bit precision

    p := @deviceList
    b:=0

    repeat i from 1 to device
      temperatur[b++]:=getTemperature(p)         ' read and display one device temperature
      p += 8

PUB getTemperature(devID) | temp, degC
  ow.reset                              ' preparatory command
  ow.writeByte(MATCH_ROM)               ' match a specific device ID
  ow.writeAddress(devID)                    ' here is that device ID
  ow.writeByte(READ_SCRATCHPAD)         ' send me scratchpad contents
  temp := ow.readBits(16)               ' read temperature

  case byte[devID]                      ' convert to floating point
    $10:    degC := F.FDiv(F.FFloat(temp), 2.0)   ' DS1820/DS18S20
    $22:    degC := F.FDiv(F.FFloat(temp), 16.0)  ' DS1822
    $28:    degC := F.FDiv(F.FFloat(temp), 16.0)  ' DS18B20
    other:  return 0
  return degC

pub Putblk|count
    count:=bus_getlong
    flash.writefile(@fcb,count,4)
    repeat count
           flash.writefile(@fcb,bus_getchar,1)

pub Getblk|c,count
    count:=bus_getlong
    repeat count
           flash.readfile(@fcb,c,1)
           bus_putchar(c)

Pub Delete_File|err
    bus_getstr
    err:=1
    ifnot flash.initFile(@fcb,@strpuffer)
          err:=0
    else
        ifnot flash.eraseFile(@fcb)
              err:=0
    bus_putchar(err)


Pub Open_File|modus,len,err
    modus:=bus_getchar
    bus_getstr
    err:=1
    ifnot flash.initFile(@fcb,@strpuffer)
          err:=0
    else
         case modus
              "w": ifnot flash.createFile(@fcb)
                         err:=0
              "r": ifnot flash.openFile(@fcb)
                         err:=0
    bus_putchar(err)

pub Flash_next|i,b,a
    i:=0
    if flash.nextFile(@fcb)
       bus_putchar(1)
           b := 1
           repeat a from 0 to 7
                if fcb.byte[a] == $FF
                   b++
                else
                   strpuffer[i++]:=fcb.byte[a]
           strpuffer[i++]:="."
           repeat a from 8 to 10
                if fcb.byte[a] == $FF
                   b++
                else
                   strpuffer[i++]:=fcb.byte[a]
           strpuffer[i]:=0
           bus_putstr(@strpuffer)
    else
       bus_putchar(0)

}
{pub port0_in|i
    halt
    repeat i from 0 to 31
           bus_putchar(bus_value[i])
    bytefill(@bus_value,0,32)
    run
}
PUB Port2_In:c

  dira[8..15]~
  c:=ina[15..8]
  dira:=db_in

PUB Port3_In:c
  dira[16..23]~
  c:=ina[23..16]
  dira:=db_in

PUB Port2_Out(char)

  dira[8..15]~~
  outa[8..15]:=char
  dira:=db_in

PUB Port3_Out(char)

  dira[16..23]~~
  outa[16..23]:=char
  dira:=db_in

PUB HC05_Status:c   'Rueckgabewert des HC05-Statuspin
  dira[HC05]~
  c:=ina[HC05]
  dira:=db_in
con'
PUB bus_init|i                                            'bus: initialisiert bussystem
{{bus_init - bus: initialisierung aller bussignale }}
    repeat i from 0 to 7                                'evtl. noch laufende cogs stoppen
      ifnot i == cogid
        cogstop(i)

  dira:= db_in                  ' datenbus auf eingabe schalten
  outa[bus_hs] := 1             ' handshake inaktiv             ,frida
  'outa[23..8]  := 0            ' Port 2 und 3 Null setzen

PUB bus_putchar(zeichen)                                'chip: ein byte über bus ausgeben
''funktionsgruppe               : chip
''funktion                      : senderoutine für ein byte zu regnatix über den systembus
''eingabe                       : byte zeichen
''ausgabe                       : -

  waitpeq(M1,M2,0)                                      'busclk=1? & /prop1=0?
  dira := db_out                                        'datenbus auf ausgabe stellen
  outa[7..0] := zeichen                                 'daten ausgeben
  outa[bus_hs] := 0                                     'daten gültig
  waitpeq(M3,M4,0)                                      'busclk=0?
  dira := db_in
  outa[bus_hs] := 1                                     'daten ungültig

PUB bus_getchar : zeichen                               'chip: ein byte über bus empfangen
''funktionsgruppe               : chip
''funktion                      : emfangsroutine für ein byte von regnatix über den systembus
''eingabe                       : -
''ausgabe                       : byte zeichen
   waitpeq(M1,M2,0)                                     'busclk=1? & prop4=0?
   zeichen := ina[7..0]                                 'daten einlesen
   outa[bus_hs] := 0                                    'daten quittieren
   waitpeq(M3,M4,0)                                     'busclk=0?
   outa[bus_hs] := 1

PUB bus_putstr(stradr) | len,i                         'bus: string zu administra senden

  len := strsize(stradr)
  bus_putchar(len)
  repeat i from 0 to len - 1
    bus_putchar(byte[stradr++])

PUB bus_getstr: stradr | len,i                         'bus: string von administra empfangen

    len  := bus_getchar                                'längenbyte empfangen
    repeat i from 0 to len - 1                          '20 zeichen dateinamen empfangen
      strpuffer[i] := bus_getchar
    strpuffer[i] := 0
    return @strpuffer

PUB bus_getword: wert                                  'bus: 16 bit von bellatrix empfangen hsb/lsb

  wert := bus_getchar << 8
  wert := wert + bus_getchar

PUB bus_putword(wert)                                  'bus: 16 bit an bellatrix senden hsb/lsb

   bus_putchar(wert >> 8)
   bus_putchar(wert)

PUB bus_getlong: wert                                  'bus: long von bellatrix empfangen hsb/lsb

  wert :=        bus_getchar << 24                     '32 bit empfangen hsb/lsb
  wert := wert + bus_getchar << 16
  wert := wert + bus_getchar << 8
  wert := wert + bus_getchar

PUB bus_putlong(wert)                                  'bus: long an bellatrix senden hsb/lsb

   bus_putchar(wert >> 24)                             '32bit wert senden hsb/lsb
   bus_putchar(wert >> 16)
   bus_putchar(wert >> 8)
   bus_putchar(wert)

con'------------------------------------------------ Chiploader -------------------------------------------------------------------------------------------------------------------
PUB mgr_getcogs: cogs |i,c,cog[8]                       'cmgr: abfragen wie viele cogs in benutzung sind
''funktionsgruppe               : cmgr
''funktion                      : abfrage wie viele cogs in benutzung sind
''eingabe                       : -
''ausgabe                       : cogs - anzahl der cogs
''busprotokoll                  : [097][put.cogs]
''                              : cogs - anzahl der belegten cogs

  cogs := i := 0
  repeat 'loads as many cogs as possible and stores their cog numbers
    c := cog[i] := cognew(@entry, 0)
    if c=>0
      i++
  while c => 0
  cogs := i
  repeat 'unloads the cogs and updates the string
    i--
    if i=>0
      cogstop(cog[i])
  while i=>0


PUB mgr_load|i                                          'cmgr: venatrix-loader
''funktionsgruppe               : cmgr
''funktion                      : funktion um einen neuen code in bellatrix zu laden
''

' kopf der bin-datei einlesen                           ------------------------------------------------------
  repeat i from 0 to 15                                 '16 bytes --> proghdr
    byte[@proghdr][i] := bus_getchar

  plen := 0
  plen :=        byte[@proghdr + $0B] << 8
  plen := plen + byte[@proghdr + $0A]
  plen := plen - 8

' objektlänge an regnatix senden
  bus_putchar(plen >> 8)                                'hsb senden
  bus_putchar(plen & $FF)                               'lsb senden

  repeat i from 0 to 7                                  'alle anderen cogs anhalten
    ifnot i == cogid
      cogstop(i)

  dira := 0                                             'diese cog vom bus trennen
  cognew(@loader, plen)

  cogstop(cogid)                                        'cog 0 anhalten

DAT
                        org     0

loader
                        mov     outa,    M_0               'bus inaktiv
                        mov     dira,    DINP              'bus auf eingabe schalten
                        mov     reg_a,   PAR               'parameter = plen
                        mov     reg_b,   #0                'adresse ab 0

                        ' datenblock empfangen
loop
                        call    #get                       'wert einlesen
                        wrbyte  in,      reg_b             'wert --> hubram
                        add     reg_b,   #1                'adresse + 1
                        djnz    reg_a,   #loop

                        ' neuen code starten

                        rdword  reg_a,   #$A               ' Setup the stack markers.
                        sub     reg_a,   #4                '
                        wrlong  SMARK,   reg_a             '
                        sub     reg_a,   #4                '
                        wrlong  SMARK,   reg_a             '

                        rdbyte  reg_a,   #$4               ' Switch to new clock mode.
                        clkset  reg_a                                             '

                        coginit SINT                       ' Restart running new code.


                        cogid   reg_a
                        cogstop reg_a                      'cog hält sich selbst an


get
                        waitpeq M_1,      M_2              'busclk=1? & /cs=0?
                        mov     in,       ina              'daten einlesen
                        and     in,       DMASK            'wert maskieren
                        mov     outa,     M_3              'hs=0
                        waitpeq M_3,      M_4              'busclk=0?
                        mov     outa,     M_0              'hs=1
get_ret                 ret


'     /cs     --------+
'     clk     -------+|
'     /wr     ------+||
'     /hs     -----+|||+------------------------- /cs ->geändert auf 24
'                  |||||                 -------- d0..d7
DINP    long  %00001000000000000000000000000000  'constant dinp hex  \ bus input
DOUT    long  %00001000000000000000000011111111  'constant dout hex  \ bus output

M_0     long  %00001000000000000000000000000000  'bus inaktiv

M_1     long  %00000010000000000000000000000000
M_2     long  %00000011000000000000000000000000  'busclk=1? & /cs=0?

M_3     long  %00000000000000000000000000000000
M_4     long  %00000010000000000000000000000000  'busclk=0?


DMASK   long  %00000000000000000000000011111111  'datenmaske

SINT    long    ($0001 << 18) | ($3C01 << 4)                       ' Spin interpreter boot information.
SMARK   long    $FFF9FFFF                                          ' Stack mark used for spin code.

in      res   1
reg_a   res   1
reg_b   res   1
Dat
                        org

' Entry: dummy-assemblercode fuer cogtest
'
entry                   jmp     entry                   'just loops


