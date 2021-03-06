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
Name            : PLEXUS - Zentrale Kommunikationseinheit der Borg
Chip            : Regnatix
Typ             : Programm
Version         : 01
Subversion      : 00

Funktion        : "Programm schaltet von TRIOS zu Plexus um

Logbuch         :
################################################### Version 1.00 ################################################################################################################
}}
OBJ
        ios: "reg-ios"

CON

_CLKMODE     = XTAL1 + PLL16X
_XINFREQ     = 5_000_000

VAR
  '----------- Verzeichnismarker --------------------------------
  long rootdir                     'root-Dirmarker
  long systemdir                   'system-Dirmarker

DAT
   sys_file      byte "reg.sys",0               'Plexus oder Trios-Startdatei
   sys_tmp       byte "reg.tmp",0               'temporäre Plexus-Startdatei
   sys_trs       byte "reg.trs",0               'temporäre TRIOS-Startdatei

PUB Main|e,err

          activate_dirmarker(0)
          ios.sdrename(@sys_file,@sys_trs)
          e:=ios.os_error(ios.sdrename(@sys_tmp,@sys_file))
          if e                                                                                                'keine TRIOS-Startdatei vorhanden
             ios.sdrename(@sys_trs,@sys_file)                                                                 'Tmp-Datei zurück in Sys
          else
             ios.admreset                                                                                     'alle chips resetten
             ios.belreset

             waitcnt(cnt+clkfreq*3)
             reboot


PRI activate_dirmarker(mark)                                                                                  'USER-Marker setzen

     ios.sddmput(ios#DM_USER,mark)                                                                            'usermarker wieder in administra setzen
     ios.sddmact(ios#DM_USER)                                                                                 'u-marker aktivieren

PRI get_dirmarker:dm                                                                                          'USER-Marker lesen

    ios.sddmset(ios#DM_USER)
    dm:=ios.sddmget(ios#DM_USER)


