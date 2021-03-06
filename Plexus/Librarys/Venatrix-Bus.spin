{{
┌──────────────────────────────────────────────────────────────────────────────────────────────────────┐
│ Autor: Ingo Kripahle  Anpassungen:Reinhard Zielinski                                                 │
│ Copyright (c) 2013 Ingo Kripahle                                                                     │
│ See end of file for terms of use.                                                                    │
│ Die Nutzungsbedingungen befinden sich am Ende der Datei                                              │
└──────────────────────────────────────────────────────────────────────────────────────────────────────┘

Informationen   : hive-project.de
Kontakt         : zille9@googlemail.com
System          : Hive
Name            : Bus-Erweiterung für Hive-Computer
Chip            : Venatrix-Bus-Protokoll
Typ             : EEProm-Urfile
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


#24,    BUS_CS                                          'Chip-Select
        BUSCLK                                          'bustakt
        BUS_WR                                          '/wr - schreibsignal
        BUS_HS '                                        '/hs - quittungssignal

STRCOUNT         =64                                    'Größe des Stringpuffers

Var
  byte proghdr[16]                                     'puffer für objektkopf
  long plen                                            'länge datenblock loader
  byte strpuffer[STRCOUNT]                              'stringpuffer

PUB bus_init                                            'bus: initialisiert bussystem
{{bus_init - bus: initialisierung aller bussignale }}

  dira:= db_in                 ' datenbus auf eingabe schalten
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

' Entry: dummy-assemblercode fuer cogtest
'
entry                   jmp     entry                   'just loops
