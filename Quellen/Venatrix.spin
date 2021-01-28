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
'Netzwerk-Puffergrößen (müssen Vielfaches von 2 sein!)
rxlen        = 2048
txlen        = 128
CON 'Signaldefinitionen --------------------------------------------------------------------------

'signaldefinitionen administra (todo: nach glob-con.spin auslagern!!!)

'#20,     A_NETCS,A_NETSCK,A_NETSI,A_NETSO              'Pins zum ENC28J60

CON 'NVRAM Konstanten --------------------------------------------------------------------------

' todo: nach glob-con.spin auslagern!!!
{
#4,     NVRAM_IPADDR
#8,     NVRAM_IPMASK
#12,    NVRAM_IPGW
#16,    NVRAM_IPDNS
#20,    NVRAM_IPBOOT
#24,    NVRAM_HIVE       ' 4 Bytes
}
txpin  = 9
rxpin  = 8
Ack    = 6
Error  =15
obj
        bus      : "Venatrix-Bus"                         'allgemeine Bus-Funktionen
        i2c_slave: "i2c_slave_Venatrix"
'        sock     : "driver_socket"  'LAN
        'gc       : "glob-con"       'globale konstanten
'        num      : "glob-numbers"   'Number Engine
'        ser      : "FullDuplexSerialExtended"

Var
  byte proghdr[16]                                     'puffer für objektkopf
  long plen                                            'länge datenblock loader
'  byte  lan_started                                     'LAN gestartet?
'  long  sockhandle[sock#sNumSockets]                    'Handle für mit sock.connect/sock.listen erstellten Socket
'  byte  bufidx[sock#sNumSockets]                        'zum Handle-Index gehörender Puffer-abschnitt
                                                        '(zum Socket mit dem Handle 2 gehört der Pufferabschnitt aus bufidx[2])
'  byte  bufrx[rxlen*sock#sNumSockets]                   'LAN Empfangspuffer
'  byte  buftx[txlen*sock#sNumSockets]                   'LAN Sendepuffer

PUB main | zeichen,i                             'chip: kommandointerpreter
''funktionsgruppe               : chip
''funktion                      : kommandointerpreter
''eingabe                       : -
''ausgabe                       : -

  bus.bus_init
    'LAN
'  lan_started := false                                 'LAN noch nicht gestartet
  i2c_Slave.Start( SCL_PIN, SDA_PIN, $5)
'  ser.start(rxpin, txpin, 0, 9600)

  repeat
    zeichen := bus.bus_getchar                          'kommandocode empfangen
    'if zeichen
    'else
    '   zeichen:=bus.bus_getchar
    case zeichen

       10: bus.bus_putchar(Port2_In)                    'Sende Port-Zustand 2
       20: bus.bus_putchar(Port3_In)                    'Sende Portzustand 3
       30: Port2_Out(bus.bus_getchar)                   'Setze Port 2
       40: Port3_Out(bus.bus_getchar)                   'Setze Port 3
       50: bus.bus_putchar(HC05_Status)                 'Status des HC05-Bluetooth-Moduls

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

pri Port2_In:c

  dira[8..15]~
  c:=ina[15..8]
  dira:=db_in

pri Port3_In:c
  dira[16..23]~
  c:=ina[23..16]
  dira:=db_in

pri Port2_Out(char)

  dira[8..15]~~
  outa[8..15]:=char
  dira:=db_in

pri Port3_Out(char)

  dira[16..23]~~
  outa[16..23]:=char
  dira:=db_in

pri HC05_Status:c   'Rueckgabewert des HC05-Statuspin
  dira[16]~
  c:=ina[16]
  dira:=db_in

CON ''------------------------------------------------- LAN-FUNKTIONEN

{PRI lan_start | hiveid, hivestr, strpos, macpos, i, a
''funktionsgruppe               : lan
''funktion                      : Netzwerk starten
''eingabe                       : -
''ausgabe                       : -
''busprotokoll                  : [071]

  if (not lan_started)

    'Pufferindex zurücksetzen
    i := 0
    repeat sock#sNumSockets
      bufidx[i++] := $FF  '0xFF: nicht zugewiesen
'######################### Das hier muss nach Administra ################################
    get_ip                                                         'diese funktionen ersetzen den auskommentierten Teil
    hiveid:=bus.bus_putchar(72)                                    'in Administra hiveid ermitteln und übertragen
{
    'IP-Parameter setzen
    if probeRTC
      repeat a from 0 to 15
        ip_addr[a] := rtc.getNVSRAM(NVRAM_IPADDR+a)                ' fill addresses
      hiveid := rtc.getNVSRAM(NVRAM_HIVE)
      hiveid += rtc.getNVSRAM(NVRAM_HIVE+1) << 8
      hiveid += rtc.getNVSRAM(NVRAM_HIVE+2) << 16
      hiveid += rtc.getNVSRAM(NVRAM_HIVE+3) << 24
    else
      dmarker[UMARKER] := sdfat.getDirCluster                       'u-marker setzen
      ifnot dmarker[SMARKER] == TRUE                                's-marker aktivieren
        sdfat.setDirCluster(dmarker[SMARKER])
      ifnot \sdfat.openFile(@strNVRAMFile, "R")
        \sdfat.setCharacterPosition(NVRAM_IPADDR)
        repeat a from 0 to 15
          ip_addr[a] := \sdfat.readCharacter                        'fill addresses
        \sdfat.setCharacterPosition(NVRAM_HIVE)
        hiveid := \sdfat.readCharacter
        hiveid += \sdfat.readCharacter << 8
        hiveid += \sdfat.readCharacter << 16
        hiveid += \sdfat.readCharacter << 24
        \sdfat.closeFile
      ifnot dmarker[UMARKER] == TRUE                                'U-marker aktivieren
        sdfat.setDirCluster(dmarker[UMARKER])

        nach Venatrix senden: ip_addr[0]..[15], hiveid
}
'########################################################################################
    hivestr := num.ToStr(hiveid, num#DEC)
    strpos := strsize(hivestr)
    macpos := 5
    repeat while (strpos AND macpos)
      strpos--
      if(strpos)
        strpos--
      mac_addr[macpos] := num.FromStr(hivestr+strpos, num#HEX)
      byte[hivestr+strpos] := 0
      macpos--

    sock.start(A_NETCS,A_NETSCK,A_NETSI,A_NETSO, -1, @mac_addr, @ip_addr)
    lan_started := true

PRI get_ip|i
    bus.bus_putchar(71)                                             'ip-adresse von Administra empfangen
    repeat i from 0 to 15
           ip_addr[i]:=bus.bus_getchar

PRI lan_stop
''funktionsgruppe               : lan
''funktion                      : Netzwerk anhalten
''eingabe                       : -
''ausgabe                       : -
''busprotokoll                  : [072]

  if lan_started
    sock.stop
    lan_started := false

PRI lan_connect | ipaddr, remoteport, handle, handleidx, i
''funktionsgruppe               : lan
''funktion                      : ausgehende TCP-Verbindung öffnen (mit Server verbinden)
''eingabe                       : -
''ausgabe                       : -
''busprotokoll                  : [073][sub_getlong.ipaddr][sub_getword.remoteport][put.handleidx]
''                              : ipaddr     - ipv4 address packed into a long (ie: 1.2.3.4 => $01_02_03_04)
''                              : remoteport - port number to connect to
''                              : handleidx  - lfd. Nr. der Verbindung (index des kompletten handle)

  ipaddr := bus.bus_getlong
  remoteport := bus.bus_getword

  'freien Pufferabschnitt suchen
  i := 0
  repeat sock#sNumSockets
    if bufidx[i] == $FF  '0xFF: nicht zugewiesen
      quit
    i++

  ifnot (handle := sock.connect(ipaddr, remoteport, @bufrx[i*rxlen], rxlen, @buftx[i*txlen], txlen)) == -102
    sock.resetBuffers(handle)
    handleidx := handle.byte[0]         'extract the handle index from the lower 8 bits
    sockhandle[handleidx] := handle     'komplettes handle zu handle index speichern
    bufidx[i] :=handleidx
    bus.bus_putchar(handleidx)                                      'handleidx senden
  else
    bus.bus_putchar($FF)

PRI lan_listen | port, handle, handleidx, i
''funktionsgruppe               : lan
''funktion                      : Port für eingehende TCP-Verbindung öffnen
''eingabe                       : -
''ausgabe                       : -
''busprotokoll                  : [074][sub_getword.port][put.handleidx]
''                              : port       - zu öffnende Portnummer
''                              : handleidx  - lfd. Nr. der Verbindung (index des kompletten handle)

  port := bus.bus_getword

    'freien Pufferabschnitt suchen
  i := 0
  repeat sock#sNumSockets
    if bufidx[i] == $FF  '0xFF: nicht zugewiesen
      quit
    i++

  ifnot (handle := sock.listen(port, @bufrx[i*rxlen], rxlen, @buftx[i*txlen], txlen)) == -102
    handleidx := handle.byte[0]         'extract the handle index from the lower 8 bits
    sockhandle[handleidx] := handle     'komplettes handle zu handle index speichern
    bufidx[i] :=handleidx
    bus.bus_putchar(handleidx)                                      'handleidx senden
  else
    bus.bus_putchar($FF)

PRI lan_waitconntimeout | handleidx, timeout, t, connected
''funktionsgruppe               : lan
''funktion                      : bestimmte Zeit auf Verbindung warten
''eingabe                       : -
''ausgabe                       : -
''busprotokoll                  : [075][get.handleidx][sub_getword.timeout][put.connected]
''                              : handleidx     - lfd. Nr. der zu testenden Verbindung
''                              : timeout    - Timeout in Millisekunden
''                              : connected  - True, if connected

  handleidx := bus.bus_getchar
  timeout := bus.bus_getword

  t := cnt
  repeat until (connected := sock.isConnected(sockhandle[handleidx])) or (((cnt - t) / (clkfreq / 1000)) > timeout)

  bus.bus_putchar(connected)

PRI lan_close | handleidx, i
''funktionsgruppe               : lan
''funktion                      : TCP-Verbindung (ein- oder ausgehend) schließen
''eingabe                       : -
''ausgabe                       : -
''busprotokoll                  : [076][get.handleidx]
''                              : handleidx - lfd. Nr. der zu schließenden Verbindung

  handleidx := bus.bus_getchar

  sock.close(sockhandle[handleidx])

  'reservierten Pufferabschnitt freigeben
  i := 0
  repeat sock#sNumSockets
    if bufidx[i++] == handleidx  '0xFF: nicht zugewiesen
      bufidx[i++] := $FF
      quit


PRI lan_rxtime | handleidx, timeout, t, rxbyte
''funktionsgruppe               : lan
''funktion                      : angegebene Zeit auf ASCII-Zeichen warten
''                              : nicht verwenden, wenn anderes als ASCII (0 - 127) empfangen wird
''eingabe                       : -
''ausgabe                       : -
''busprotokoll                  : [077][get.handleidx][sub_getword.timeout][put.rxbyte]
''                              : handleidx - lfd. Nr. der Verbindung
''                              : timeout   - Timeout in Millisekunden
''                              : rxbyte    - empfangenes Zeichen (0 - 127) oder
''                              :             sock#RETBUFFEREMPTY (-1) wenn Timeout oder keine Verbindung mehr

  handleidx := bus.bus_getchar
  timeout := bus.bus_getword

  t := cnt
  repeat until (rxbyte := sock.readByteNonBlocking(sockhandle[handleidx])) => 0 or (not sock.isConnected(sockhandle[handleidx])) or (cnt - t) / (clkfreq / 1000) > timeout

  bus.bus_putchar(rxbyte)

PRI lan_rxdata | handleidx, len, rxbyte, error
''funktionsgruppe               : lan
''funktion                      : bei bestehender Verbindung die angegebene Datenmenge empfangen
''eingabe                       : -
''ausgabe                       : -
''busprotokoll                  : [078][get.handleidx][sub_getlong.len][put.byte1][put.byte<len>][put.error]
''                              : handleidx - lfd. Nr. der Verbindung
''                              : len       - Anzahl zu empfangender Bytes
''                              : error     - ungleich Null bei Fehler

  error := FALSE
  handleidx := bus.bus_getchar
  len := bus.bus_getlong

  repeat len
    ifnot error
      repeat while (rxbyte := sock.readByteNonBlocking(sockhandle[handleidx])) < 0
        ifnot sock.isConnected(sockhandle[handleidx])
          error := sock#ERRSOCKETCLOSED
          quit
    bus.bus_putchar(rxbyte)

  bus.bus_putchar(error)

PRI lan_txdata | handleidx, len, txbyte, error
''funktionsgruppe               : lan
''funktion                      : bei bestehender Verbindung die angegebene Datenmenge senden
''eingabe                       : -
''ausgabe                       : -
''busprotokoll                  : [079][get.handleidx][sub_getlong.len][get.byte1][get.byte<len>][put.error]
''                              : handleidx - lfd. Nr. der Verbindung
''                              : len       - Anzahl zu sendender Bytes
''                              : error     - ungleich Null bei Fehler

  error := FALSE
  handleidx := bus.bus_getchar
  len := bus.bus_getlong

  repeat len
    txbyte := bus.bus_getchar
    ifnot error
      repeat while sock.writeByteNonBlocking(sockhandle[handleidx], txbyte) < 0
        ifnot sock.isConnected(sockhandle[handleidx])
          error := sock#ERRSOCKETCLOSED
          quit

  bus.bus_putchar(error)

PRI lan_rxbyte
''funktionsgruppe               : lan
''funktion                      : wenn vorhanden, ein empfangenes Byte lesen
''                              : nicht verwenden, wenn auch $FF empfangen werden kann
''eingabe                       : -
''ausgabe                       : -
''busprotokoll                  : [080][get.handleidx][put.rxbyte]
''                              : handleidx - lfd. Nr. der Verbindung
''                              : rxbyte    - empfangenes Zeichen oder
''                              :             sock#RETBUFFEREMPTY (-1) wenn kein Zeichen vorhanden

  bus.bus_putchar(sock.readByteNonBlocking(sockhandle[bus.bus_getchar]))

PRI lan_isconnected
''funktionsgruppe               : lan
''funktion                      : Returns true if the socket is connected, false otherwise
''eingabe                       : -
''ausgabe                       : -
''busprotokoll                  : [081][get.handleidx][put.connected]
''                              : handleidx - lfd. Nr. der Verbindung
''                              : connected - TRUE wenn verbunden, sonst FALSE

  bus.bus_putchar(sock.isConnected(sockhandle[bus.bus_getchar]))

DAT
                long                                    ' long alignment for addresses
  ip_addr       byte    10,  1, 1, 1                    'ip
  ip_subnet     byte    255, 255, 255, 0                'subnet-maske
  ip_gateway    byte    10,  1, 1, 254                  'gateway
  ip_dns        byte    10,  1, 1, 254                  'dns
  ip_boot       long    0                               'boot-server (IP address in long)
  mac_addr      byte    $c0, $de, $ba, $be, $00, $00    'mac-adresse
}
