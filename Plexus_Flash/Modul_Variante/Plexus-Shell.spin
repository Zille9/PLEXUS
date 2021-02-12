{{VARIANTE NUR FÜR PLEXUS-MODUL
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
Version         : 02
Subversion      : 02

Funktion        : TRIOS-Shell für den Hive

Logbuch         :

'#################################################################################################################################################################################
'####################################### PLEXUS 2.0  mit VENATRIX und SEPIA-Unterstützung ########################################################################################
'#################################################################################################################################################################################
'############################################################### Version 2.1 ####################################################################################################
29-05-2014        -optischer Umbau der Statusleiste, Explorerfenster erhält eine eigene Statusleiste (für Verzeichnisnamen)
                  -dadurch im unteren Bereich 2 Zeilen mehr Platz, Utility-Panel rutscht um eine Zeile nach unten, sieht optisch besser aus
                  -Verzeichnisnamen-Anzeige muss noch überarbeitet werden, es wird immer nur das aktuelle Verzeichnis angezeigt, nicht der komplette Pfad, das ist doof
                  -Statusleistentext wird nur noch angezeigt, wenn das Explorerfenster zu sehen ist
                  -1294 Longs frei

31-05-2014        -Sanduhr beim Start von Bin-Dateien hizugefügt, da die Statusleiste nicht immer sichtbar ist
                  -1283 Longs frei

08-06-2014        -Verzeichnispfad-Anzeige im Explorerfenster zeigt jetzt den kompletten Pfad an, ist der Pfad länger als 3 Verzeichnisse, wird entsprechend später mit
                  -der Anzeige begonnen
                  -dadurch einige Routinen gekürzt bzw. gelöscht
                  -Optische Frischzellenkur, untere Statusleiste existiert nicht mehr, nur noch Startbutton und Uhrzeitanzeige
                  -Shell-Titelzeile nur noch im mittleren Bildschirmteil existent mit abgerundeten Ecken
                  -1284 Longs frei

09-06-2014        -optisch noch einige Kleinigkeiten geändert
                  -Fehler in der Scrollroutine behoben, war das Startmenue sichtbar, wurde es durch scrollen zerstört
                  -1264 Longs frei

12-06-2014        -Fehler in der Pfadanzeige im TRASH-Fenster behoben
                  -falsche Darstellung bei Dateien ohne Dateiendung (wurden fälschlicherweise als Verzeichnisse interpretiert) behoben
                  -überflüssige DAT-Anweisungen entfernt
                  -Statusleiste des Explorerfensters hat jetzt die gleiche Farbe wie die Titelzeile
                  -Korrekturen beim Datei-Hervorhebungsbalken, noch wird beim runterscrollen an der letzten Position der Balken nicht korrekt gelöscht
                  -1265 Longs frei

14-06-2014        -kleine optische Änderung in der TAB-Anzeige der Systeminfo um Tiles einzusparen
                  -Anzeigekorrektur bei der Datei-Datumsanzeige. Tages-und Monatswerte <10 haben jetzt eine führende Null
                  -Als hilfreich könnte sich noch ein Tastencode-Scanner erweisen, da man öfter den ASCII-Code einer Taste braucht, mal sehen, wie ich das realisiere
                  -1263 Longs frei

15-06-2014        -Keyboardscanner in der oberen Titelzeile eingebaut(linker Teil), aktivierbar über die Taste K,k, erweitert die Titelzeile rechts und links
                  -im rechten Titelzeilen-Teil werden die Maus-Koordinaten angezeigt
                  -1209 Longs frei

16-06-2014        -Umbau Keyboardscanner, dadurch etwas Platz gespart (2 Longs)
                  -DCF-Indikator nach unten neben der Uhr verschoben, da wo er hingehört
                  -DCF-OK-Anzeige erfolgt jetzt generell in Grün
                  -DLL's ebenfalls angepasst
                  -Korrektur Mülleimerpfadanzeige (wurde in der falschen Hintergrundfarbe dargestellt)
                  -1211 Longs frei

20-06-2014        -optische Veränderung der App-Bar, dadurch werden Tiles eingespart
                  -Dll's entsprechend angepasst
                  -Fenster (Explorer,Terminal,Programms und Ram-Monitor) wurde um eine Zeile vergrößert
                  -Scroll-Handling verbessert
                  -einige CLR-Dateien angepasst an die neue Optik
                  -Fehler in Startmenue-Auswahl behoben (nachdem der Mülleimer aufgerufen wurde, wurde ein Klick auf Help im Startmenue als Show-Trash interpretiert)
                  -Cancel-Button in der Coganzeige und der Systeminfo entfernt (macht keinen Sinn, OK-Button reicht)
                  -1205 Longs frei

21-06-2014        -weiterer optischer Umbau, Regal bleibt (sieht einfach besser aus)
                  -Statusleiste am unteren Bildschirmrand wird über Extended Titlebar sichtbar/unsichtbar
                  -Textausgaben entsprechend angepasst
                  -DLL's mit neuem Start-Button ausgestattet
                  -nun muss ich noch etwas Code-Optimierung durchführen
                  -1173 Longs frei

22-06-2014        -Panel ist jetzt dynamisch
                  -sitzt ganz unten und springt eine Zeile hoch,wenn die extended Titlebar aktiviert wird (und umgekehrt)
                  -1167 Longs frei

23-06-2014        -Möglichkeit, des Austausches der Fontdatei geschaffen.Dadurch wird Plexus optisch aufgewertet
                  -unterschiedliche Fontdateien erstellt
                  -Icon für Fontdateien im Explorerfenster erstellt
                  -Wechsel des Fonts erfolgt durch Doppelklick auf eine Fontdatei im Explorerfenster, aktivierter Font wird zum Systemfont
                  -1129 Longs frei

24-06-2014        -Font Dateien befinden sich im Unterverzeichnis FONTS
                  -ausgewählte Fontdatei wird ins Systemverzeichnis kopiert und in Reg.Fnt umbenannt (war etwas tückisch, funktioniert aber jetzt endlich)
                  -1125 Longs frei

25-06-2014        -Sanduhr beim Laden eines neuen Fonts eingebaut(dauert ja doch etwas länger)
                  -die neuen Fontdateien etwas bearbeitet
                  -1123 Longs frei

27-06-2014        -Textausgaben auf Großschreibung umgestellt, das spart Tiles im Fontsatz und erlaubt zusätzliche Icons und Grafiktiles
                  -diverse optische Experimente getätigt, aber nichts brauchbares herausgekommen :-(
                  -nach Tests mit der Toolbox3 (TRIOS-R57) wird die SD-Karte geschreddert, da ich keine Lust habe, jedes Programm PLEXUS-Konform umzubasteln,
                  -werde ich im Fenster PROGRAMS einen Punkt TRIOS einbauen, um den HIVE in den TRIOS-Modus zu versetzen
                  -mal sehen, ob das funktioniert und wie ich zurück zu Plexus komme
                  -1117 Longs frei

28-06-2014        -Umstieg auf TRIOS funktioniert nur mit abgezogener Venatrix-Erweiterung, da im Code von TRIOS der PIN24 (Regnatix LED) nicht gesetzt ist
                  -muss ich also doch was Umbauen, das nervt
                  -außerdem muss ich im Regime-Code (reg.sys von TRIOS) noch den Umstieg zurück auf Plexus realisieren.
                  -Variablen-Liste in VAR umsortiert und dadurch über 30 Longs eingespart
                  -goplexus.bin kreiert, um von TRIOS zurück zu Plexus zu gelangen
                  -1144 Longs frei

01-07-2014        -Font-Editor bis auf die Speicherfunktion fertiggestellt
                  -erreichbar über das Programms-Fenster
                  -1113 Longs frei

06-07-2014        -Font-Editor jetzt komplett fertig :-)
                  -Dll's auf Großschreibung umgestellt, dadurch können mehr Icons in den Fontsatz aufgenommen werden
                  -dank Kuroneko 20 Longs in der Regflash.bin eingespart, was den Heap größer werden läßt(mehr Platz im Ram :-))
                  -1113 Longs frei

10-07-2014        -Fehler des "ein Long zu lange Regflash.bin" von Kuroneko gefunden ->behoben (war meine Schuld :-( (peinlich!))

11-07-2014        -Einbindung eines Signalgenerators als Dll begonnen (Code von Ahle2)
                  -bei Aufruf des Signalgenerators wird die SidCog gestoppt (um Cogs frei zu bekommen) und nach Beendigung wieder gestartet
                  -1119 Longs frei

12-07-2014        -DLL-Programmnamen in den Ram ausgelagert und entsprechende Startroutinen umgebaut, dadurch Platz gespart
                  -1141 Longs frei

13-08-2014        -Durch den Umbau von Groß/Klein-Schreibung auf Großschreibung, einige Änderungen und Zusammenfassungen im Code durchgeführt
                  -kleinere Fehler beseitigt
                  -ein kleiner Texteditor wäre nicht schlecht, mal sehen was ich assimilieren kann ;-)
                  -1150 Longs frei

'############################################################### Version 2.2F (Flash) ####################################################################################################
24-08-2014        -Fehler entdeckt, bei Kartentausch werden die DLL's nicht mehr gefunden ->Systemmarker muss bei SD-Kartentausch aktualisiert werden
14-09-2014        -Fehler entdeckt, im Programms-Fenster wurde die 1 für Sepia-Testprogramm nicht abgefragt
10-10-2014        -Terminal-Echo on/off im Baud-Setting Fenster hinzugefügt ->wird aber nur lokal gespeichert (nach Neustart wieder auf Standard EIN)
                  -1122 Longs frei

14-12-2014        -Com-Engine von Kwabena W. Agyeman verwendet, bessere Kommunikationssicherheit
                  -YModem.dll und Bluetooth.dll mit neuer Com-Engine compiliert
                  -1066 Longs frei

16-12-2014        -Beginn der Schaffung eines einfachen IRC-Clienten für Plexus
                  -Icon und Aufrufmöglichkeit im Programms-Fenster erstellt
                  -1052 Longs frei

10-05-2015        -Regflash.spin um die Möglichkeit erweitert, Programme aus dem E-Ram zu laden und zu starten
                  -Plexus-Programme mit der neuen Ram-Load Möglichkeit ausgestattet
                  -beim Start von Plexus werden alle Programmteile in den Ram geladen, danach werden sie von dort gestartet
                  -in den Ram passen bis zu 15 Programmteile(ab Adresse $80000)
                  -1056 Longs frei

14-05-2015        -etwas Code umgebaut, vidnfo,sndnfo und prgnfo werden jetzt zur Laufzeit nur angezeigt, nicht in den Ram geladen.
                  -Ram-Bereiche anders verteilt, 123kb frei gemacht
                  -Basrun.dll wird ebenfalls beim Start in den Ram geladen, dadurch kann Dll.lst und Routine zum dll-Aufruf entfallen
                  -1056 Longs frei

24-05-2015        -Ram Monitor nur noch als Anzeige ->Editierfunktion als externe DLL ausgelagert (E-RAM,EEPROM)
                  -CR und LF Flag eingefügt, wird im Baud-Fenster eingestellt, so kann bestimmt werden, was beim Druck auf Enter gesendet wird CR,LF,beides oder garnichts
                  -1073 Longs frei

01-062015         -Untertitelleiste eingebaut, soll Zusatzinfos anzeigen ->Temperaturwerte zweier DS1820 Temperatursensoren (nur mit Venatrix-Board)
                  -674 Longs frei

18-06-2015        -Übertragung der Temperaturwerte der DS1820 erfolgt als String, dadurch kann das Objekt FloatString2 entfallen->platzsparender
                  -das Laden der einzelnen Programmteile in den Ram dauert beim Start zu lange, um einen merklichen Effekt zu erreichen
                  -es wird nur noch Plexus selbst in den Ram geladen, das ist annehmbar schnell und spart Ladezeit bei Rückkehr aus Dll's
                  -1014 Longs frei

11-07-2015        -Fehler in Startprozedur entdeckt, beim Erststart wurde der RETURN_POINT-Marker falsch gelesen, da ein zufälliger Wert im Speicher stand
                  -das führte dazu, das ebenfalls ein zufälliger Dirmarker aus dem Ram gelesen und gesetzt wurde
                  -das Resultat war die Anzeige von wirren Zeichen im Explorer, erst ein unmount und mount-Befehl behob dies
                  -RETURN-POINT-Marker wird jetzt beim Start in der reg.sys auf Null gesetzt
                  -1011 Longs frei

29-07-2015        -ersten Aufruf der Scan-Routine für externe Erweiterungskarten verschoben, wird jetzt vor dem ersten Bildschirmaufbau aufgerufen
                  -so ist ein dynamisches Einblenden der Untertitelleiste (für Temp-Anzeige) möglich
                  -durch den Bau des Hive-Cube und dessen Hardwareänderungen wird die Ansteuerung der Venatrix komplett auf I2C umgebaut
                  -Vorteil:-kein Festfahren des Hive bei Aufruf von Venatrix-Befehlen ohne Venatrix-Karte
                           -nur noch zwei Befehle zum Abfragen bzw. Setzen der I2C-Register von Venatrix
                           -dadurch wird Platz geschaffen und die Kompatibilität zu Nicht-Venatrix-Usern ist besser
                  -1008 Longs frei

07-08-2015        -in Administra begonnen einen Winbond-Treiber einzubinden
                  -für alle Hive-Computer ohne LAN-Chip besteht die Möglichkeit stattdessen einen Winbond Flash-Rom Chip zu installieren
                  -Memory Fenster in der Plexus-Shell wird zum Flash-Rom-Dateifenster
                  -im Setting Fenster wird der Typ und die Größe des Flash-Rom's angezeigt
                  -Code des Ram-Monitors entfernt, Ram-Monitor existiert als externe Dll
                  -1205 Longs frei

08-08-2015        -Dateinamen aus dem Flashrom lesen funktioniert
                  -bin aber am Überlegen, ob es nicht einfacher ist, statt des Flash-Roms nicht einfach eine zweite SD-Karte zu verwenden
                  -der Treiber in Administra wäre der gleiche, wie für SD-Karte1 und das Handling wäre auch einfacher !?!
                  -1092 Longs frei

10-08-2015        -Flash-Rom beinhaltet jetzt alle DLL's und startet diese auch aus Plexus heraus, bringt jedoch gegenüber SD-Card keinen Geschwindigkeits-Vorteil
                  -werde wohl dem Ram eine Backup-Batterie spendieren, so fungiert der E-Ram als Ramdisk, das ist deutlich schneller
                  -hat aber den Nachteil, das nach Basic wieder alle DLL's geladen werden müssen, irgendwie ist das alles Mist :-(

15-08-2015        -Plexus startet jetzt komplett aus dem Flash, hat den Vorteil, das man auch SD-Karten ohne System verwenden kann, das System startet trotzdem
                  -will man Trios starten, muß ein angepasstes Trios verwendet werden, da im ursprünglichen Trios keine Systemdateiabfrage existiert,
                  -um den richtigen Grafiktreiber zu starten
                  -950 Longs frei

20-08-2015        -Funktionen zum Beschreiben des Flash-ROM eingebaut
                  -die Flash-Datei Funktion ist nicht ausgereift und zu umständlich, einfacher ist der direkte Speicherzugriff
                  -Memory-Fenster jetzt mit E-Ram und Flash-Rom Anzeige
                  -Speicherbereich auswählen und im Explorer Programm-Datei auswählen, ALT-F10 drücken und die Datei landet im Flash
                  -von dort kann sie innerhalb eines Programms mit der Startadresse gestartet werden (entsprechende Routine in Regflash enthalten)
                  -958 Longs frei

21-08-2015        -Als nächstes müsste ein Updater konstruiert werden, der es erlaubt bei laufendem Plexus, dieses im Flash upzudaten ->Neustart ->neues Plexus
                  -Steuerdatei enthält alle upzudatenden Dateinamen und Adressen
                  -cool wäre eine Versionsabfrage, die nur veraltete Dateien flasht
                  -die jeweiligen Versionsnummern müssten in einem separaten Flashbereich liegen, da nicht gestartete Programme keine Versionsnummern zurückgeben können
                  -das hört sich einfacher an,als es ist da ein zu beschreibender Flashbereich immer erst gelöscht werden muss und dieser Bereich ist mindestens 4kb groß

23-08-2015        -Plexus-Updater für die Flashvariante funktioniert
                  -dieser flasht nur die neuen Dateien und schreibt sie in den Rom
                  -das erspart sehr viel Arbeit beim Testen und macht den Speicher frei
                  -1013 Longs frei

25-08-2015        -Updater startbar über Taste ALT_F10
                  -im Explorer ist es möglich, mit der Taste B eine selektierte Datei in den oberen EEPROM-Bereich von Bellatrix zu flashen
                  -996 Longs frei

03-09-2015        -durch Optimierung des Flash_Rom-Datentransfers ist ein Laden von Plexus aus dem Ram nicht mehr nötig, die Flash-Rom-Routine ist nun schnell genug
                  -Regflash angepasst (Ram-Routine nicht notwendig, dadurch mehr Heap)
                  -über Alt_F9 kann im Explorerfenster eine Datei in den Flashrom übertragen werden, Start der Datei im Memoryfenster mit Taste R
                  -929 Longs frei

04-09-2015        -Plexus-Start-Logo für die Flash-Variante wird in blauen Farben dargestellt ->bessere Unterscheidung zwischen SD-Card und Flash-Variante
                  -940 Longs frei

12-11-2015        -Fehler in der Tastenabfrage im Programms-Fenster behoben, Zahlen 1-9 wurden falsch abgefragt
                  896 Longs frei

13-03-2016        -Bluetooth-Statusabfrage erfolgt in dieser Variante über den ADM-Port18
                  -dies ist nur für die Plexus-Modul-Variante vorgesehen (Hive-Cube)
                  -die Standard-Abfrage erfolgt sonst über Venatrix-Port16
                  -mittlerweile existieren 3 Varianten von Plexus, das schreit nach Aufräumen!!!
                  -Plexus-Standard, Plexus-Flash, Plexus-Flash-Modul
                  -893 Longs frei

############################################### Hive-Max-Version 2.3 ##############################################################################
22-07-2019        -Plexus wird komplett umgebaut, um an die neuen Hardwarebedingungen angepasst zu werden
                  -zur Zeit gibt es noch unergründete SD-Karten Probleme, Inhalte werden teilweise falsch gelesen
                  -Directory-Einträge werden manchmal zerschossen dargestellt
                  -ob das am Bellatrix-Ram liegt oder einen Fehler in Administra oder BUS-Probleme muss noch erforscht werden
                  -erweiterte Titelleiste wieder entfernt, kaum Nutzen und zu oft falsche Anzeige
                  -790Longs frei

31-07-2019        -Scanfunktion der Sepia Karte wieder aktiviert - funktioniert jetzt wieder
                  -Das SD-Karten-leseproblem wurde behoben, offensichtlich war Administra (durch ungünstiges PCB-Layout?) zu langsam im Empfang
                  -von bus_putchar - Befehlen, eine kleine Repeatschleife bot Abhilfe ohne merkliche Geschwindigkeitseinbußen.(siehe reg.ios-modul.spin)
                  -765 Longs frei

12-02-2021        -einige Funktionen des Programmsfesters entfernt, Programmteile sind mittlerweile überholt und nicht mehr sinnvoll
                  -als DOS-Shell wird eine Variante der ZShell verwendet (fehlt noch)
                  -Venatrix-Test, DCF-Test entfernt, braucht man nicht
                  -Mauspfeil wird nach dem Starten von Plexus nicht korrekt angezeigt!? liegt das an der Ini Datei?
                  -nach dem Laden einer Mau-Datei ist die Anzeige korrekt.
                  -1256 Longs frei

Notizen         : Window 0 = Hauptbildschirm, darf nicht anderweitig genutzt werden !!!
                  Window 1 = Utilitie-Fenster (serielles Terminal, Uhr-Einstellung,Color-Settings, Ram-Monitor,Player,Systemsettings,Baud-Einstellung)
                  Window 2 = Infofenster (SD-Card-Info,Kopierfenster,Messagebox,Datei-Info)
}}

OBJ
             ios: "reg-ios-Modul"
             'fp : "dwdFloatString2"

CON

_CLKMODE     = XTAL1 + PLL16X
_XINFREQ     = 5_000_000

'-------- Speicher für diverse Texte ------------
TXT_RAM   = $20000
error_step  = 25                    'Schrittweite der Einträge
vidnfo    = $21000
sndnfo    = $21200
prgnfo    = $21400
Verz_RAM  = $21800
hlptxt    = $25000
'-------- Speicher für DLL-Namen ----------------
DLL_RAM   = $30000
dll_step  = 25                      'Schrittweite der Einträge
'-------- Speicher für Titelliste ---------------
DMP_RAM   = $40000
'-------- Overlay-Puffer ------------------------
BRAM      = $50000
'-------- Speicher für Systemfont ---------------
SYS_FONT  = $66800 '....$693FF      ' ab hier liegt der System-Font 11kb
Hour_Glass= $66800+(167*16*4)       ' Platz, wo das Sanduhrsymbol im Systemfont sitzt
MOUSE_RAM = $69400 '....$6943F      ' User-Mouse-Pointer 64byte

'-------- Speicher für Dateiliste ---------------
DIR_RAM   = $69440 '....$7DFFF
'-------- YMODEM Temp-Speicher ------------------
YMODEM_RAM  = $7E400 '... $7E417      Name, der zu sendenden Datei, Was soll gemacht werden(0Empfang,1Senden)+Dirmarker
MARKER_RAM  = $7E410 '... $7E414      Dirmarker-Speicher
RETURN_POINT= $7E420'                 Aktion nach Rückkehr aus YModem (zBsp.Explorer öffnen)
'-------- Speicher der Fenster-Tiles ------------
WTILE_RAM= $7E500 '.... $7E5FF      ' Win-Tile Puffer hier können die Tiles, aus denen die Fenster gebaut werden geändert werden
'-------- Speicher für Verknüpfungen ------------
LINK_RAM  = $7FE00
PARA_RAM  = $7FE40



SETTING_RAM = $7FF00 'Hier stehen die System-Settings
FLAG_RAM    = $7FF30
YMODE_FLAG  = $7FF30 'Plexus sitzt an Stelle 0 im Map-RAM ->Ymodem_dll an Position 1
SEPIA_FLAG  = $7FF31 '2
VENAT_FLAG  = $7FF32 '3
SHELL_FLAG  = $7FF33 '4
DCF77_FLAG  = $7FF34 '5
BLUTH_FLAG  = $7FF35 '6
FONTE_FLAG  = $7FF36 '7
WAVEG_FLAG  = $7FF37 '8
PLIRC_FLAG  = $7FF38 '9

EEPROM_FLAG = $7FF39 '10

START_FLAG  = $7FFFF 'Flag das Plexus schonmal gestartet wurde ->Logo unterdrücken
RETURN_FLAG = $7FFFE 'Rückkehr-Flag aus gestarteter Bin-Datei


Adressraum     =5           'Adressbereich für Speicher-Monitor, Standardwert 4-stellig (plus 1 für ext.Ram)

caseBit     = !32


'******************* Spezifikation für Bellatrix **********************

BEL_COLORS     =64
BEL_X          =640
BEL_Y          =480
BEL_ZEILEN     =30
BEL_SPALTEN    =40

'******************Farben ********************************************************
  #$FC, Light_Grey, #$A8, Grey, #$54, Dark_Grey
  #$C0, Light_Red, #$80, Red, #$40, Dark_Red
  #$30, Light_Green, #$20, Green, #$10, Dark_Green
  #$1F, Light_Blue, #$09, Blue, #$04, Dark_Blue
  #$F0, Light_Orange, #$E6, Orange, #$92, Dark_Orange
  #$CC, Light_Purple, #$88, Purple, #$44, Dark_Purple
  #$3C, Light_Teal, #$28, Teal, #$14, Dark_Teal
  #$FF, White, #$00, Black

len          = 80                      'länge der Eingabezeile im Terminal
'------------- TASTENCODES -------------------------------------------------------
Backspace    = $C8                     ' PS/2 keyboard backspace key
ESC_KEY      = 27
RETURN_KEY   = 13
Plus_Key     = 43
Minus_Key    = 45
Space_Key    = 32
TAB_KEY      = 9
ENTF_KEY     = 186
EINF_KEY     = 187
PG_UP        = 160
PG_DN        = 162


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
'------------- ALTGR+F ----------------------------------------------------------
ALT_F1       = 159
ALT_F2       = 158
ALT_F3       = 157
ALT_F4       = 156
ALT_F5       = 144
ALT_F6       = 145
ALT_F7       = 146
ALT_F8       = 147
ALT_F9       = 151
ALT_F10      = 150
ALT_F11      = 149
ALT_F12      = 148
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
FNT_PIC  =113
'--------------------------------------------------------------------------------

VAR
'systemvariablen
  '---------------- Fenster ------------------------------------------
  byte windownum[3]                'Arbeits-Windows
  byte windowx[3]
  byte windowy[3]
  byte windowxx[3]
  byte windowyy[3]
  byte messagex                    'x-Position der Messagebox
  byte infomarker                  'Marker für Info-Fenster-Anzeige

  '---------------- Farben -------------------------------------------
  byte act_color                   'Speicher für gewählte zeichenfarbe
  byte hcolstatus                  'statusleiste hintergrundfarbe
  byte winhcol                     'Fensterhintergrundfarbe
  byte winframecol                 'Fensterrandfarbe
  byte shellhcol                   'Hauptfensterfarbe
  byte Titelhcol                   'Titelleistenfarbe
  byte titeltextcol                'Titelleistentextfarbe
  byte statustextcol               'Statustextfarbe
  byte buttonhcol                  'Buttonhintergrundfarbe
  byte buttontextcol               'Buttontextfarbe
  byte messagehcol                 'Messagebox-Hintergrundfarbe
  byte messagetextcol              'Messagebox-Textfarbe
  byte selectcol                   'selektionsfarbe
  byte mousecol                    'Mauszeigerfarbe
  byte panelcol                    'Farbe des Utilitie-Panels
  '------------------------------------------------------------------
  byte iconnr[30]                  'Tilenummer des Icons
  byte iconx[30]                   'Icon Koordinaten
  byte icony[30]
  byte iconf1[30],iconf2[30],iconf3[30] 'Iconfarben

  '----------------- Maus-Auswertung -----------------------------
  byte ma,mb,mz,mc                 'Maus-Taste und Scrollrad
  long scrollende,scrollanfang,zeilenanfang, zeilenende 'Variablen für Scrollfunktion
  '----------------- Text-Variablen ------------------------------
  byte zeile,spalte                'Zeilen und spalten für terminalfenster
  byte inputline[len]              'Eingabezeile Terminal
  '----------------- Datum/Zeit Anzeige --------------------------
  byte tag,monat,stunde,minute sekunde 'Datum -und Zeit
  byte tmptime                     'Vergleichsvariable für Time-Funktion
  word jahr
  '---------------- Variablen für Dateibehandlung ----------------
  long filelen                     'Dateigröße
  byte file_info[7]                 '0=Filedir, 1=rdonly, 2=hidden, 3=system, 4=archiv, 5=day, 6=month
  byte selection                   'selektierte Datei
  byte menuemarker                 'Marker für Startmenue
  byte buff[8]                     'Dir-Befehl-variablen
  byte filestring[13]              'selektierte Datei
  byte copystring[13]              'kopier-string
  byte mountmarker                 'Marker für Mountbefehl
  word filenumber,dirnumber        'Anzahl Dateien und Verzeichnisse im aktuellen Verzeichnis
  word fileyear                    'Datei Erstellungsjahr
  '--------------- Popupmenue-Variablen --------------------------
  byte popupx                      'x und
  byte popupy                      'y-Koordinaten des Popupmenues
  byte popupyy                     '2te y-koordinate
  byte popupxx                     '2te x-koordinate
  byte popupmarker                 'Marker für Popupmenue
  byte menue_nr                    'nr des gerade angezeigten Menues
  byte textline[12]                'Texteingabestring
  byte lines                       'Zeilen im Dateifenster
  byte attrmarker[4]               'Datei-Attribute-Marker
  byte tabx[3],taby[3],tabl[3]     'Tab-Parameter
  long tp                          'Texteingabe-übernahmestring
  '------------ Variablen für den DMP-Player --------------------
  byte playerposition              'Position im Dmp-File
  byte dumpstring[13]              'dmp-datei
  byte play                        'Player läuft oder nicht
  long dmplen                      'Länge des Dmp-Files
  word dumpnummer                  'aktuelle Dmp-Nummer
  word tmpplay                     'temporäre Dmp-Nummer
  word dmpfiles                    'Anzahl Dmp-Files im Verzeichnis
  '------------ Button-Variablen --------------------------------
  byte buttonx[8]                  'Knöpfe
  byte buttony[8]
  byte buttontext[50]              'String mit allen Button-Texten (8*6 Zeichen)
  byte attribute[4]                'Attribute-Set
  byte font[25]                    'Hilfsstring für Strings aus dem Ram
  '----------- Verzeichnismarker --------------------------------
  long rootdir                     'root-Dirmarker
  long systemdir                   'system-Dirmarker
  long trashdir                    'Muelleimer-Dirmarker
  long userdir                     'user-Dirmarker
  long targetdir                   'Ziel-Dirmarker
  '----------- RAM-Monitor Variablen ----------------------------
  long HEX_ADRESSE                 'Adresse E-Ram-Monitor
  long startadresse,endadresse     'E-Ram-Monitor Variablen
  byte dump_ram                    'Anzeige externer oder interner speicher

  '----------- Anzahl Einträge im Trash-Ordner ------------------
  word trashcounter                'Muellzähler
  '----------- diverse Hilfsvariablen ---------------------------
  byte pfeil,pfeil_old             'Positionspfeil im Color-Fenster
  byte change_marker               'Merker, das Verzeichnis geändert wurde
  byte do_restore                  'merker, ob Displayhintergrund wieder hergestellt wird
  byte link_merker                 'merker, ob bei geöffnetem Explorer ein Link angeklickt wird
  byte attribut_fenster            'merker für Datei-Info-Fenster

  '---------- Variablen für Programmverknüpfungen ---------------
  byte link_string[40]              'String für die drei Links
  byte link_pointer                 'Linkposition
  byte link_counter                 'Linkzaehler
  byte Verzeichnis_counter          'Verzeichnis-Tiefenzähler
  byte muelleimer                   'Marker für Muelleimerfenster
  byte util                         'Utilitie-Marker
  long Link_marker[3]               'Dir_marker der 3 Links

  '----------- Kalender-Variablen -------------------------------
  byte today
  byte tag_zahl                     'Anzahl Tage im Monat und Schaltjahrerkenner
  byte Wert_Monat
  word Wert_Jahr
  '----------- Hervorhebungsbalken im Explorer ------------------
  byte y_old                        'alte y-Koordinate
  byte highlight                    'Hervorhebungsmarker des Dateinamens
  byte filestring_old[13]           'alter Dateiname
  byte break                        'Abbruch-Marker Kopier und Löschfunktion
  byte old_color                    'alte Farbe des Dateieintrages merken
  '----------- Venatrix Variablen -------------------------------
  byte venatrix                     'Venatrix-Marker
  '----------- Sepia Variablen ----------------------------------
  byte sepia                        'Sepia-Marker
  '----------- spezielle Fensterfunktionen
  byte tab_taste                    'Tab-Tasten-Zähler
  byte kz                           'Position im Scrollfenster Pfeiltasten
  byte scr                          'scrollmerker für Pfeiltasten
  '----------- DCF-Indikator ------------------------------------
  byte timezaehler
  '----------- Bluetooth-Variablen ------------------------------
  byte bl_connect
  byte serial
  byte echo_on  'Terminal-Echo
  '----------- externe Programme --------------------------------
  byte return_merker                'Rückkehraktion aus DLL
  '----------- extended Menue -----------------------------------
  '___________ Kopier-Variablen ---------------------------------
  byte copy_all                     'gesamten Verzeichnisinhalt kopieren
  byte copy_marker                  'Kopier-Marker
  long dmpaste,dmcopy               'Quell,Zielpfad-Merker

  '----------- Terminal Flags -----------------------------------
  byte CR_Flag, LF_Flag

  '----------- Systemsettings -----------------------------------
  byte system_setting[6]            '0=baud, 1=Schow_Hid_Files, 2=Use_Trash, 3=dcf_on, 4=Bluetooth_on, 5=keyscanner


dat
   ini           byte "Reg.ini",0               'Ini-Datei für Farbwerte, Dateiverknüpfungen und Systemeinstellungen
'   flash_ini     byte "flash.ini",0             'Flash-ini


   root          byte "..          ",0
   dirhoch       byte ".           ",0
   Trash         byte "TRASH       ",0
   SYSTEM        Byte "PLEXUS      ",0          'Plexus-Systemverzeichnis
   binfile       byte "BIN",0
   extfile       byte "DLL",0                   'externe-Plexus-Programme
   txtfile       byte "TXT",0
   dmpfile       byte "DMP",0
   basfile       byte "BAS",0
   admfile       byte "ADM",0
   belfile       byte "BEL",0
   venfile       byte "VNX",0                   'Venatrix-Treiber
   sysfile       byte "SYS",0
   colorfile     byte "CLR",0                   'Farb-Schemen-Dateien
   maus          byte "MAU",0                   'Mauszeiger-Dateien
   fontdat       byte "FNT",0                   'Font-Dateien

   butOK         byte "  OK  ",0
   Abbr          byte " Quit ",0
   sysfont       byte "reg.fnt",0
   promt         byte "OK>",0
   Version       byte "2.5",0
   New_dir       byte "NEWDIR",0
   '------------ Tage ------------------------------------
   DAY1          byte "MO",0
   DAY2          byte "TU",0
   DAY3          byte "WE",0
   DAY4          byte "TH",0
   DAY5          byte "FR",0
   DAY6          byte "SA",0
   DAY7          byte "SO",0

   DAYS     word @DAY1,@DAY2,@DAY3,@DAY4,@DAY5,@DAY6,@DAY7

   '------------ Monate ----------------------------------
   MON1         byte "JAN",0
   MON2         byte "FEB",0
   MON3         byte "MAR",0
   MON4         byte "APR",0
   MON5         byte "MAY",0
   MON6         byte "JUN",0
   MON7         byte "JUL",0
   MON8         byte "AUG",0
   MON9         byte "SEP",0
   MON10        byte "OKT",0
   MON11        byte "NOV",0
   MON12        byte "DEC",0

   MONS   word @MON1,@MON2,@MON3,@MON4,@MON5,@MON6,@MON7,@MON8,@MON9,@MON10,@MON11,@MON12
  '------------- Menueeinträge ---------------------------
   info         byte "Info   ",0
   show         byte "Show   ",0
   link         byte "Link   ",0
   flash        byte "Flash  ",0
   paste        byte "Paste  ",0
   copy         byte "Copy   ",0
   rename       byte "Rename ",0
   send         byte "Send   ",0
   receive      byte "Receive",0
   newdir       byte "New Dir",0
   delete       byte "Delete ",0
   parameter    byte "Param. ",0
   starts       byte "Start  ",0
   unmount      byte "Unmount",0
   mounts       byte "Mount  ",0
   format       byte "Format ",0
   empty        byte "Empty  ",0
   Files        byte "Files     ",0
   Help         byte "Help      ",0
   Dirs         byte "Dirs     ",0
   settings     byte "Settings  ",0
   Programs     byte "Programs  ",0
   reboots      byte " -REBOOT- ",0
   baud_set     byte "Baud      ",0

   on           byte "on ",0
   off          byte "off",0

   video_inf    byte "VIDEO.NFO",0             'Grafikinfo
   prg_inf      byte "PRG.NFO",0               'Programminfo
   sound_nfo    byte "SOUND.NFO",0             'Soundinfo
   basrun       byte "basrun.dll",0
   'Speicher     byte "dump.ram",0
   'Testfile     byte "Plexus.bin",0

   windowtile byte 146,148,147,114,116,6,4,2,0,129,1,5,77,3,129,129,129                           'Fenster-Tiles für WIN-Funktion
   prg byte 0,1,2,3,4,5,6,7,8,9,10,11,12,64                                                       'Startplätze der Programmteile im Programmsfenster

PUB main | i

    ios.start

    'ios.startfat
    ios.sdmount                                                                                               'sd-card mounten
    mountmarker:=1                                                                                            'mount-marker

    activate_dirmarker(0)
    rootdir:=get_dirmarker                                                                                                'Dir-Marker für root Verzeichnis lesen
    userdir:=rootdir                                                                                          'User-Dir-Marker erst mal mit root vorbelegen

    'Systemverzeichnis-marker lesen
    ios.sdchdir(@system)                                                                                      'System-Verzeichnis lesen
    systemdir:=get_dirmarker                                                                                  'Dir-Marker lesen
    activate_dirmarker(rootdir)                                                                               'wieder zurüeck ins root-Verzeichnis
    ios.printchar(12)                                                                                         'cls

    'load_ini_in_ram
    iniload                                                                                                   'Ini-Datei mit Farbwerten laden
    win_set_tiles                                                                                             'Fenster-Tiles in den Speicher laden

    repeat i from 0 to 2
        windownum[i]:=windowx[i]:=windowxx[i]:=windowy[i]:=windowyy[i]:=-1                                    'Windowwerte initialisieren
        buttonx[i]:=buttony[i]:=-1
    '****************** Hauptbildschirm ******************************************
    Scan_Expansion_Card                                                                                       'nach Venatrix scannen

    ios.loadtilebuffer(SYS_FONT,2816)                                                                         'Systemfont aus E-Ram nach Bella laden
    Bildschirmaufbau

    Muelleimer_erstellen

    dmpfiles:=0                                                                                               'Dmp-File-Zähler auf null
    tmpplay:=1                                                                                                'Titelnummer auf eins
    tab_taste:=0                                                                                              'Tab_Tasten-Zähler auf null setzen
    Verzeichnis_counter:=0                                                                                    'Verzeichnis-Tiefenzähler auf null
    play:=0                                                                                                   'Player aus
    activate_dirmarker(userdir)                                                                               'Usermarker setzen
    ios.ram_wrbyte(236,START_FLAG)                                                                            'Warm-Start-Flag Flashvariante
    buttonweg                                                                                                 'button-Werte resetten
    change_marker:=0                                                                                          'Dateiverzeichnis muss eingelesen werden
    do_restore:=1                                                                                             'Hintergrund wieder herstellen
    '------------- Terminal-Flags -------------
    echo_on:=1                                                                                                'Local Echo On
    CR_Flag:=1                                                                                                'Carrige Return ON
    LF_Flag:=0                                                                                                'Linefeed Off
    '------------------------------------------
    return_merker:=ios.ram_rdbyte(RETURN_POINT)
    if return_merker>0
       ios.ram_wrbyte(0,RETURN_POINT)                                                                         'Rückkehraktion löschen
       userdir:=ios.ram_rdlong(MARKER_RAM)
       Verzeichnis_counter:=ios.ram_rdbyte(RETURN_POINT+1)
       ios.ram_wrbyte(0,RETURN_POINT+1)                                                                       'Verzeichnis_counter lesen und RAM-Platz danach löschen

    ios.mousebound(0,0,639,479)                                                                               'Maus-Bereich festlegen
    ios.seropen(19200)
    repeat

      os_cmdinput                                                                                             'Hauptprogrammschleife


PRI Win_Set_Tiles|i,a                                                                                         'Tiles, aus denen die Fenster bestehen, in den Ram schreiben
    i:=WTILE_RAM
    a:=0
    repeat 17
           ios.ram_wrbyte(windowtile[a++],i++)                                                                'Standard-Wintiles in den Ram schreiben
    ios.windel(9)                                                                                             'alle Fensterparameter löschen und Win Tiles senden


CON '################################################### Hauptprogrammschleife ####################################################################################################
    '##############################################################################################################################################################################

PRI os_cmdinput | x,y ,i,col,dk,kb,b,kl,fst,term_aus,{kn,bd,}tmp,dl

  lines:=21                                                                                                   'Zeilen im Dateifenster
  zeilenanfang:=1                                                                                             'erste Zeile im Dateifenster
  playerstop                                                                                                  'Player stoppen, wenn läuft
  term_aus:=0                                                                                                 'Terminal aus
  copy_marker:=0                                                                                              'Kopiermarker löschen
  copy_all:=0                                                                                                 'Marker für alle Dateien-Operation löschen
  muelleimer:=0                                                                                               'Mülleimer-Marker
  y_old:=3                                                                                                    'Initialwert für Hervorhebungsbalken
  highlight:=0                                                                                                'keine Hervorhebung
  scr:=0
  pfeil:=system_setting[0]+6
  if return_merker
     keyboardscan(return_merker)
'##################################### Hier gehts los #############################################################################################################################
  repeat

    time                                                                                                      'Zeit und Datum anzeigen


    ma:=ios.mouse_button(0)                                                                                   'linke Maustaste
    mb:=ios.mouse_button(1)                                                                                   'rechte Maustaste
    mz:=ios.mousez                                                                                            'scrollrad
    kb:=ios.key                                                                                               'Tastenabfrage (für Zusatzfunktionen)

'********************** Dmp_Player-Automatik -> spielt alle im Verzeichnis befindlichen Dmp-Dateien ab ******************************************************
    if play==1
       if ios.sid_dmppos<1                                                                                    'Playerposition abfragen, Player stoppen, wenn Titel abgespielt wurde
          playerstop
          tmpplay++                                                                                           'und zum nächsten Titel springen, wenn vorhanden
          if tmpplay>dmpfiles
             tmpplay:=1                                                                                       'wenn letzter Titel abgespielt wurde, zum ersten springen
             selection:=1                                                                                     'Selection zurücksetzen
             scr:=0                                                                                           'Scrollmarker löschen
             if util==11                                                                                      'Dateifenster sichtbar?
                show_always                                                                                   'Dateiliste neu aufbauen
                selection:=2
          if util==11 and infomarker==0 and highlight==1                                                      'Dateifenster nur scrollen, wenn kein Infofenster angezeigt wird
             kb:=5                                                                                            'nächsten Titel im Dateifenster hervorheben
          getdmpname(tmpplay-1)                                                                               'Titelnamen holen
          Player_sichtbar                                                                                     'wenn Player sichtbar, dann Titel im Playerfenster anzeigen

          abspielen(Windownum[1])                                                                             'Player starten (wenn Fenster da ist, balken löschen)

'**************************************** Globale Tasten-Abfrage ********************************************************************************************
    if kb
       keyboardscan(kb)                                                                                       'Tastatur auf Befehls-Tasten abfragen
       case util
               2:i:=kb-"0"                                                                                    'System-Info-Fenster
                 if i>0 and i<4
                    show_tab(i)

               7:i:=0
                 case kb                                                                                       '1...9 momentan 1-9
                      "1".."9":i:=kb-"0"                                                                              'im Programms-Fenster per Nummerntaste Programm auswählen
                      "a","A":i:=10                                                                               'Flash-Updater
                      "b","B":i:=62                                                                               'Basic
                 if i                                                                                          'wird nichts sinnvolles gedrückt, passiert auch nichts
                    do_restore~
                    popup_info_weg                                                                                'Popup-Menues löschen
                    RUN_SYS(dll_txt(i+2),F3_KEY)
                    'RUN_SYS(F3_KEY,i+2)


'************** DMP-Player-Fenster ******* Steuerung durch Mausbedienung ************************************************************************************
    if util==6 and windownum[1]==1                                                                            'Fenster sichtbar?


             if ios.sid_dmppos>0 and play>0
                tmp:=dmplen/19                                                                                'anzahl Samples pro block
                printdec_win(dmplen-ios.sid_dmppos,8,9)                                                       'aktuelle Sampleposition anzeigen
                playerposition:=(dmplen-ios.sid_dmppos)/tmp                                                   'balkenposition
                positionsbalken(playerposition,8,11)                                                          'Fortschrittsbalken aktualisieren
             printdec_titel(dmpfiles,6,25)                                                                    'Anzahl der gefundenen DMP-Files in der Titelleiste anzeigen

             if ma==255                                                                                       'Mouse-Taste gedrückt
                x:=ios.mousex                                                                                 'x und y-Position der Maus beim drücken
                y:=ios.mousey
                repeat i from 10 to 12
                      if x==iconx[i] and y==icony[i] and dmpfiles>0                                           'Playertasten gedrückt und mindestens eine Dmp-Datei im Verzeichnis
                         if i==11 and play==1                                                                 'icon stop, wenn Player läuft
                            iconnr[11]:=PLAY_PIC
                         else
                            iconnr[11]:=STOP_PIC                                                              'icon Play anzeigen
                         iconpress(i,0)                                                                       'icon-drücken-Effekt
                         case i
                              10:tmpplay:=wert_plusminus(2,tmpplay,1,dmpfiles)                                'titel zurück
                              11:if play==1                                                                   'play/stop
                                    play:=0
                                    balkenleer                                                                'Positionszähler auf Null setzen
                                 else
                                    play:=1
                              12:tmpplay:=wert_plusminus(1,tmpplay,1,dmpfiles)                                'titel vor
                         playsong(tmpplay,1)
                         dmp_name                                                                             'Titel und Samples im Playerfenster anzeigen



'*********************************************************************************************************************************************************************************

'**************************************** rechte Maustaste ***********************************************************************************************************************
    if mb==255
       do_restore:=1                                                                                          'bei Maus-Bedienung Hintergrund wieder herstellen
       popup_info_weg
       repeat while ios.mouse_button(1)>0
       x:=ios.mousex
       y:=ios.mousey

      '--------------------------------------------- SD-Card-Symbol -----------------------------------------------------------------------------------
       if ((x=>36) and (x=<37) and (y=>4) and (y=<5))                                                         'SD-Card-Symbol mit der rechten Maustaste anklicken ( Mount/Unmount)
          popup(33,6,39,9)                                                                                    'feste Position, sonst sind Fehldarstellungen möglich
          popup_entry(0,@info,0)
          if mountmarker==1                                                                                   'wenn SD-Card gemounted, unmount anzeigen
             popup_entry(1,@unmount,0)
          else
             popup_entry(1,@mounts,0)                                                                         'Mount anzeigen, wenn SD-Card nicht gemounted ist

          popup_entry(2,@format,1)
          menue_nr:=2                                                                                         'Marker SD-Card-Popupmenue
       '-------------------------------------------- Mülleimer-Symbol ----------------------------------------------------------------------------------
       if ((x=>36) and (x=<37) and (y=>23) and (y=<24))                                                       'Mülleimer-Symbol mit der rechten Maustaste anklicken ( Mount/Unmount)
          popup(33,25,39,27)                                                                                  'feste Position, sonst sind Fehldarstellungen möglich
          popup_entry(0,@empty,0)
          popup_entry(1,@show,1)
          menue_nr:=3                                                                                         'Marker Mülleimer-Popupmenue

       '-------------------------------------------- Link-Symbole ---------------------------------------------------------------------------------------

       if ((x==37) and ((y==8) or (y==13) or (y==18)))                                                        'Link-Symbol mit der rechten Maustaste anklicken
          i:=linkpos(y-8)                                                                                     'erster Eintrag bei popupy=8+2 (da das Popupmenue 2 Zeilen unter dem Symbol angezeigt wird)
          get_link(LINK_RAM,i,1)                                                                                'Link-Name holen
          if strsize(@filestring)>1                                                                           'Link-Name gültig?                                                                                                              'sonst wird im zweifelsfall zuwenig wieder hergestellt
             popup(33,y+2,39,y+5)                                                                             'feste Position, sonst sind Fehldarstellungen möglich
             popup_entry(0,@starts,0)                                                                         'Link starten
             popup_entry(1,@parameter,0)                                                                      'Startparameter für Link
             popup_entry(2,@delete,1)                                                                         'Link löschen
             menue_nr:=4                                                                                      'Marker Link-Popupmenue

       '---------------------------------------- Dateifenster rechtsklick -------------------------------------------------------------------------------
       if ((x=>4) and (x=<16) and (y=>3) and (y=< 24))
          if util==11 'or util==5

              selection:=y-3                                                                                  'selektierte Datei nr
              if util==11
                 getfilename(selection+scrollanfang)
              'if util==5
              '   getflashfilename(selection+scrollanfang)
              if y<>y_old and selection=<filenumber                                                           'nur einmal hervorheben und nur im gültigen bereich
                 highlight++                                                                                  'angeklickter Dateiname wird hervorgehoben
                 highlight_selection(y)
              'if util==11
              if selection=<filenumber and selection>0  and not (strcomp(@filestring,@dirhoch))              'Popupfenster soll nur im gültigen bereich auftauchen
                    Show_popupmenue(x,y)
              'if util==5
              '   Show_popupmenue(x,y)                                                                       'im Flashfenster kann das Popupfenster überall auftauchen

'******************************************** linke Maustaste ********************************************************************************************************************
    if ma==255

       dk:=0
       x:=ios.mousex
       y:=ios.mousey
       kl:=ios.get_window//10                                                                                 'Icon-Button-Nummer des Fensters
       fst:=kl/10                                                                                             'Nummer des Fensters
       do_restore:=1                                                                                          'bei Maus-Bedienung Hintergrund wieder herstellen
'------------------------------------------------- Fenster-Schließen -------------------------------------------------------------------------------------------------------------
       if kl==1 or kl==2
          Close_Window(fst)
          if attribut_fenster
             mc:=SD_CARD
             attribut_fenster:=0

       '----------- SD-Card-Symbol -------------------
       if (x==36 or x==37)                                                                                    'SD-Card-Symbol druecken
          if (y==4 or y==5)
             keyboardscan(F2_KEY)                                                                             'Dateifenster anzeigen

       '----------- Mülleimer-Symbol -----------------
          elseif (y==23 or y==24) and (not popupmarker)                                                       'Mülleimer-Symbol druecken, wenn kein Menue angezeigt wird
             keyboardscan("T")                                                                                'Mülleimerfenster anzeigen
       '********************** Desktopverknüpfungen starten ********************************************************
       if (x==37) and (y==8 or y==13 or y==18)
           if doppelklick
               i:=(y/5)-1                                                                                     'Linknummer errechnen
               LINK_START(i)

'########################################################### Globale Funktionstasten ############################################################################################

       '*********************** Mausklick in Titelleiste *******************************************************
       if y==0                                                                                                'Beenden-Knopf
           if x==34
             cmd_reboot(1)

       '------------ Kalender aufrufen -----------------------------------
           elseif (x=>22) and (x=<31)
                 if doppelklick
                    keyboardscan(F11_Key)

       '------------ About-Box aufrufen ----------------------------------
           elseif x=>8 and x=<17
                  if doppelklick
                     about

       '*********************** Mausklick in Statusleiste ******************************************************
       '------------ Zeit/Datum-Einstellungen ----------------------------
       if y==29
          if(x=>35) and (x=<39)
                 if doppelklick
                    keyboardscan(F7_Key)

       '------------ Start-Menue -----------------------------------------
          elseif (x=>0) and (x=<6)                                                                            'Start-Knopf
                 buttonpress(3)
                 do_restore:=1
                 if menuemarker==1
                    popup_info_weg
                 else
                    popup_info_weg
                    startmenue


       '****************************** Globale Abfrage OK und Cancel-Button *****************************

       if(x=>buttonx[4]) and (x=<buttonx[4]+5) and (y==buttony[4])                                            'ok im SD-Card-Infofenster
          buttonpress(4)
          do_restore:=1
          popup_info_weg
          buttonweg                                                                                           'Button muss extra gelöscht werden, sonst Fehldarstellungen

       if(x=>buttonx[1]) and (x=<buttonx[1]+5) and (y==buttony[1])                                            'ok
            buttonpress(1)
            keyboardscan(13)                                                                                  'Utilfenster, bei dem bei Druck auf OK etwas gespeichert werden muss

       if(x=>buttonx[2]) and (x=<(buttonx[2]+6)) and (y==buttony[2])                                          'cancel
            buttonpress(2)
            keyboardscan(27)



'***************************************************************************************************************
'##################################################################################################################################################################################

'############################################### Popup-Menues #####################################################################################################################

       '********************** Popup-Menue-SD-Card abfragen ********************************************************
       if popupmarker==1 and menue_nr==2
             if x=>popupx and x=<popupx+10

                          case y
                                popupy:popupselect(@info,popupx,popupy)
                                       infofenster(12,10,27,20,ram_txt(32),1)                                                    'SD-Card-Info-Fenster anzeigen
                                       SD_CARD_INFO                                                                              'Fenster mit Info's füllen
'                                       keyboardscan("I")
                                       do_restore:=1                                                          'Info-Fenster-Hintergrund soll wieder hergestellt werden

                              popupy+1:if mountmarker==1
                                          popupselect(@unmount,popupx,y)
                                       else
                                          popupselect(@mounts,popupx,y)
                                       keyboardscan("M")

                              popupy+3:popupselect(@format,popupx,y)
                                       keyboardscan("F")



             else
                do_restore:=1
                popup_info_weg

       '********************** Popup-Menue-Mülleimer abfragen ********************************************************
       if popupmarker==1 and menue_nr==3
             if(x=>popupx) and (x=<popupx+10)

                          case y
                                popupy:popupselect(@empty,popupx,y)                                           'Mülleimer leeren
                                       keyboardscan("E")
                              popupy+2:popupselect(@show,popupx,y)                                            'Mülleimer anzeigen
                                       keyboardscan("T")

             else
                do_restore:=1
                popup_info_weg                                                                                'Hintergrund wiederherstellen

       '********************** Popup-Menue-Links abfragen ************************************************************
       if popupmarker==1 and menue_nr==4
          if(x=>popupx) and  (x=<popupx+6)
            i:=linkpos(popupy-10)                                                                             'erster Eintrag bei popupy=8+2 (da das Popupmenue 2 Zeilen unter dem Symbol angezeigt wird)
            get_link(LINK_RAM,i,1)                                                                              'Link-Name holen
                 case y
                        popupy:popupselect(@starts,popupx,y)
                               LINK_START(i)                                                                  'starte Link 0 bis 2
                        popupy+1:popupselect(@parameter,popupx,y)
                                 link_merker:=1
                                 fensterweg
                                 LINK_PARAMETERS(i)
                                 b:=Text_Input(0,3,30,10,12,0,PARA_RAM+(i*64)-1,63)                           'Parameter eingeben
                                 keyboardscan(b)

                      popupy+3:popupselect(@delete,popupx,y)
                               link_merker:=1
                               abfrage_link_del(i)

          else
             do_restore:=1
             popup_info_weg                                                                                   'Popup-Fenster löschen

'##################################################################################################################################################################################



'****************************** Startmenue anzeigen ************************************************************
       if menuemarker==1

          if x=>0 and x=<9
                    case y
                         18:popupselect(@Help,0,y)
                            keyboardscan(F1_Key)

                         20:popupselect(@baud_set,0,y)
                            keyboardscan(ALT_F5)

                         22:popupselect(@settings,0,y)
                            keyboardscan(ALT_F2)

                         24:popupselect(@programs,0,y)
                            keyboardscan(F3_Key)

                         27:popupselect(@reboots,0,y)
                            keyboardscan(F12_Key)
          else
             do_restore:=1
             popup_info_weg                                                                                   'Menue loeschen, wenn man woanders hinklickt


'*****************************************************************************************************************
'##########################################################################################################################################

'****************************** ICON-Regal-Funktionsaufruf ********************************************************
       ifnot popupmarker
             repeat i from 0 to 6
                    if (x=>iconx[i] and x=<iconx[i]+1 and y==icony[i])
                       iconpress(i,1)                                                                              'Icon-drücken-Effekt anzeigen
                       util:=i                                                                                     'Nummer des Unterprogramms
                       keyboardscan(i+211)

          '****************************** Hilfs-und Einstellfenster *****************************

       '----------- Utility-Fenster ---------------------
       case util
          '********************* Seriell-Terminal ************************
          ' nach keyboardscan ausgelagert
          '*************** System-Info *************************************************
            2:
             repeat i from 1 to 3
                 if x=>tabx[i] and x=<tabl[i] and y==taby[i]
                    buttonpress(i+4)
                    show_tab(i)


          '*************** Uhr-Datum-Einstellungen ***************************************
            3:
             if y==9
                case x
                   10:Date_Time(1,1)
                   13:Date_Time(1,2)
                   16:Date_Time(2,1)
                   19:Date_Time(2,2)
                   22:Date_Time(3,1)
                   27:Date_Time(3,2)

             if y==14
                case x
                    10:Date_Time(4,1)
                    13:Date_Time(4,2)
                    16:Date_Time(5,1)
                    19:Date_Time(5,2)
                    22:Date_Time(6,1)
                    25:Date_Time(6,2)


          '*************** Color Settings **********************************************
            4:
             if (x=>7) and (x=<22) and (y=>4) and (y=<7)                                                      'angeklickte farbe ermitteln
                col:=((x-7)*4)+(((y-4)*16)*4)
                print_win(string("   "),19,9)
                printdec_win(col,9,19)                                                                        'Farbwert dezimal anzeigen
                'system_setting[pfeil-9]:=col
                farbe(pfeil-9,col)
                refreshpaint


             if (x=>7) and (x=<16) and (y=>9) and (y=<23)                                                     'Auswahl Eintrag
                pfeil:=y
                WIN_TILE(16,pfeil_old,6)
                WIN_TILE(46,pfeil,6)
                print_win(string("   "),19,9)
                printdec_win(get_farbe(pfeil-9),9,19)
                pfeil_old:=pfeil

          '************** Ram-Monitor **************************************************
            5:
              if y==4
                 if (x=>8) and (x=<13)
                    keyboardscan(TAB_KEY)                                                                     'Adresseingabe

                 if x==23                                                                                     'Auswahl Hub-Ram
                    keyboardscan("E")

                 if x==31                                                                                     'Auswahl E-Ram
                    keyboardscan("F")


            7:  '****************** Programms-Fenster, noch nicht fertig *******************
                  repeat i from 13 to 26
                       if (x==iconx[i] or x==iconx[i]+1) and (icony[i]==y)
                          if i<13 or i>15
                             iconpress(i,1)                                                                   'Icon-drücken-Effekt Zweitile-Icon anzeigen
                          else
                             iconpress(i,0)                                                                   'icon-drücken-Effekt Eintile-ICON
                          do_restore:=1
                          popup_info_weg                                                                      'Popup-Menues löschen
                          dl:=((iconx[i]-3)/6)+3+((icony[i]-3)-1)                                             'DLL-Namens-Nr errechnen
                          RUN_SYS(dll_txt(dl),F3_KEY)
                          'RUN_SYS(F3_KEY,prg[dl])

          '*********************************************************************************

          '************** System-Settings **************************************************

            8:if x==18
                if y==8                                                                                       'Settings tooglen
                   keyboardscan("S")                                                                          'Versteckte Dateien anzeigen oder nicht
                elseif y==10
                   Keyboardscan("U")                                                                          'Mülleimer benutzen oder nicht
              if x==32
                if y==8
                   keyboardscan("D")                                                                          'DCF-Empfang on/off
                elseif y==10
                   keyboardscan("B")                                                                          'HC05-Bluetooth-Module ja/nein

          '*************** Kalender ********************************************************
            9:if y==5
                 repeat i from 15 to 18
                     if iconx[i]==x
                        iconpress(i,0)
                        case i
                             15:Wert_Monat:=wert_plusminus(2,Wert_Monat,1,12)
                             16:Wert_Monat:=wert_plusminus(1,Wert_Monat,1,12)
                             17:Wert_Jahr:=wert_plusminus(2,Wert_Jahr,1600,2500)
                             18:Wert_Jahr:=wert_plusminus(1,Wert_Jahr,1600,2500)
                 Zeichne_Kal(Wert_Monat,Wert_Jahr)

       '------------ Baud-Einstellung ____________________
            10:pfeil_old:=system_setting[0]+6
               if x=>13 and x=<18 and y=>6 and y=<14
                  pfeil:=y
                  WIN_TILE(16,pfeil_old,12)
                  WIN_TILE(46,pfeil,12)
                  pfeil_old:=pfeil
                  system_setting[0]:=pfeil-6
               if x==21 and y==15
                  keyboardscan("E")

'******************************* Aktionen im Dateifenster ************************************************************************************************************************
            11:

          '************************ Info-Fenster ****Dateiattribute setzen*********************

                if infomarker==1
                   Mouse_Release
                   repeat i from 11 to 23 step 4

                        if (x==i) and (y==windowy[2]+6)
                           case i
                                11:keyboardscan("R")
                                15:keyboardscan("H")
                                19:keyboardscan("S")
                                23:keyboardscan("A")

          '************************ Popupmenue ************************************************
                if popupmarker==1 and menue_nr==1

                        if(x=>popupx) and x=<popupx+6
                           highlight:=-1                                                                        'muss -1 sein, damit Klick ins Popupmenue ignoriert wird
                               case y
                                      popupy:popupselect(@info,popupx,y)
                                             keyboardscan("I")
                                             do_restore:=1                                                    'Info-Fenster-Hintergrund soll wieder hergestellt werden
                                    popupy+1:popupselect(@show,popupx,y)
                                             keyboardscan("S")

                                    popupy+2:popupselect(@link,popupx,y)                                      'Dateiverknüpfung erstellen
                                             keyboardscan("L")

                                    popupy+4:if copy_marker==1                                                'Einfügen
                                                popupselect(@paste,popupx,y)
                                                keyboardscan("P")
                                             else
                                                popupselect(@copy,popupx,y)
                                                keyboardscan("C")

                                    popupy+5:popupselect(@rename,popupx,y)
                                             keyboardscan("R")

                                    popupy+6:popupselect(@newdir,popupx,y)                                    'neues Verzeichnis erstellen
                                             keyboardscan("N")
                                    popupy+7:popupselect(@send,popupx,y)                                      'Datei senden
                                             keyboardscan("Y")
                                    popupy+8:popupselect(@receive,popupx,y)                                   'Datei empfangen
                                             keyboardscan("Z")
                                    popupy+10:popupselect(@delete,popupx,y)                                   'Datei löschen
                                             keyboardscan(ENTF_KEY)


                        else
                           do_restore:=1
                           popup_info_weg                                                                       'Popupfenster löschen


              '************************ Doppelklick auf Datei *************************************

                if (x=>2) and (x=<14) and (y=>3) and (y=< 24) and infomarker==0
                    popup_info_weg
                    selection:=y-3
                    kz:=selection
                    'if util==5
                    '   getflashfilename(selection+scrollanfang)
                    'if util==11
                    getfilename(selection+scrollanfang)                                                       'selektierte Datei nr
                    'if y<>y_old                                                                               'nur einmal hervorheben
                    highlight++                                                                            'angeklickter Dateiname wird hervorgehoben
                    if highlight>0                                                                         'erster Klick hebt hervor, Popupmenueklick wird ignoriert da -1
                       highlight_selection(y)

                    if doppelklick and mountmarker==1
                       keyboardscan(Return_Key)


'#############################################################################################################################


'**************************** Maus Scrollrad ****************************************
    if mc>mz or (x==34 and y=>3 and y=<14 and ma==255)                                                         'hochscrollen
      if popupmarker==0
        if util==11  and infomarker==0                                                                          'Dateifenster nur scrollen, wenn kein Infofenster angezeigt wird (byte kann keine -1 sein also 255)
           if filenumber>21                                                                                    'Dateianzahl höher als Zeilen im Dateifenster?
              scrollrunter                                                                                     'Bildschirm scrollen
              if scr>0
                 scr--
              Highlight_balken                                                                                 'auf Gültigkeit der Balkenposition prüfen
              mc:=mz
        if util==5                                                                                             'E-Ram-Monitor
           adresseminus(1)
           scrolldown(startadresse)
           mc:=mz

    if mc<mz or (x==34 and y=<26 and y=>15 and ma==255)                                                        'runterscrollen
      if popupmarker==0
        if util==11 and infomarker==0                                                                          'Dateifenster nur scrollen, wenn kein Infofenster angezeigt wird
           if filenumber>21
              scrollhoch                                                                                       'Bildschirm scrollen
              if scr<filenumber-21
                    scr++
              Highlight_balken                                                                                 'auf Gültigkeit der Balkenposition prüfen
              mc:=mz
        if util==5                                                                                             'E-Ram-Monitor
           adresseplus(1)
           scrollup(endadresse)
           mc:=mz

'**************************** Pfeiltasten ****************************************
    if kb==2                                                                                                  'nach rechts
       case util
            9:Wert_Monat:=wert_plusminus(2,Wert_Monat,1,12)                                                   'Kalender-Monat vorwärts blättern
              Zeichne_Kal(Wert_Monat,Wert_Jahr)
    if kb==3                                                                                                  'nach links
       case util
            9:Wert_Monat:=wert_plusminus(1,Wert_Monat,1,12)                                                   'Kalender-Monat zurückblättern
              Zeichne_Kal(Wert_Monat,Wert_Jahr)

    if kb==160 and popupmarker==0 and util==5                                                                 'Page_Up Memoryfenster
       adresseminus(19)
       ramdump(startadresse)
       mc:=mz

    if kb==4 and popupmarker==0                                                                               'hochscrollen
       case util
          3: Date_Time(tab_taste,1)                                                                           'Datum-Zeit-Einstellung

          4: if pfeil>9                                                                                       'Farbeinstell-Fenster
                pfeil--
                WIN_TILE(16,pfeil_old,6)
                WIN_TILE(46,pfeil,6)
                print_win(string("   "),19,9)
                printdec_win(get_farbe(pfeil-9),9,19)
                pfeil_old:=pfeil

          5:                                                                                                  'E-Ram-Monitor
            adresseminus(1)
            scrolldown(startadresse)
            mc:=mz
          9:                                                                                                  'Kalender-Jahr zurückblättern
            Wert_Jahr:=wert_plusminus(1,Wert_Jahr,1600,2500)
            Zeichne_Kal(Wert_Monat,Wert_Jahr)

          10:pfeil_old:=system_setting[0]+6                                                                                'Baud-Setting-Fenster
             if pfeil-6>0
                  pfeil--
                  WIN_TILE(16,pfeil_old,12)
                  WIN_TILE(46,pfeil,12)
                  pfeil_old:=pfeil
                  system_setting[0]:=pfeil-6

          11:if infomarker==0                                                                                 'Dateifenster nur scrollen, wenn kein Infofenster angezeigt wird (byte kann keine -1 sein also 255)
                   highlight:=1
                  IF selection>1
                     selection--
                     getfilename(selection+scr)

                  if selection==1 and scr>0
                     scrollrunter
                     scr--
                  highlight_selection(selection+3)

    if kb==162 and popupmarker==0 and util==5                                                                 'Page_Down Memoryfenster
       adresseplus(19)
       ramdump(startadresse)
       mc:=mz

    if kb==5 and popupmarker==0                                                                               'runterscrollen
       case util
          3: Date_Time(tab_taste,2)                                                                           'Datum-Zeit-Einstellung

          4:                                                                                                  'Farbfenster
             if pfeil<23
                pfeil++
                WIN_TILE(16,pfeil_old,6)
                WIN_TILE(46,pfeil,6)
                print_win(string("   "),19,9)
                printdec_win(get_farbe(pfeil-9),9,19)
                pfeil_old:=pfeil

          5:                                                                                                  'E-Ram-Monitor
            adresseplus(1)
            scrollup(endadresse)
            mc:=mz

          9:                                                                                                  'Kalender-Jahr weiterblättern
            Wert_Jahr:=wert_plusminus(2,Wert_Jahr,1600,2500)
            Zeichne_Kal(Wert_Monat,Wert_Jahr)

          10:pfeil_old:=system_setting[0]+6
             if (pfeil-6)<8
                  pfeil++
                  WIN_TILE(16,pfeil_old,12)
                  WIN_TILE(46,pfeil,12)
                  pfeil_old:=pfeil
                  system_setting[0]:=pfeil-6

          11:if infomarker==0                                                                                 'Dateifenster nur scrollen, wenn kein Infofenster angezeigt wird
                  highlight:=1
                  if selection<filenumber
                     selection++
                     getfilename(selection+scr)
                  if selection>21
                     if scr<filenumber-21
                        scrollhoch
                        scr++
                     selection:=21
                  highlight_selection(selection+3)                                                              'Bildschirm scrollen

'*************************************************************************************
pri Show_popupmenue(x,y)
    if y>19                                                                                      'popupmenue passt nicht, wenn y>23 ist
       popup(x,19,x+6,30)
    else
       popup(x,y,x+6,y+10)
    popup_entry(0,@info,0)
    popup_entry(1,@show,0)
    popup_entry(2,@link,0)
    if copy_marker==1
       popup_entry(3,@paste,1)
    else
       popup_entry(3,@copy,1)
    popup_entry(5,@rename,0)
    popup_entry(6,@newdir,0)
    popup_entry(7,@send,0)
    popup_entry(8,@receive,0)
    popup_entry(9,@delete,1)
    menue_nr:=1                                                                                  'Marker-Dateifenster-Popupmenu

pri show_tab(n)

    tabframe(n,windowx[1]+1,windowxx[1]-1,windowyy[1]-1)
    clear_tabframe

    case n
         1:textdisplay(2,6,8,vidnfo)'print_info(vidnfo,6,8)
         2:textdisplay(2,6,8,sndnfo)'print_info(sndnfo,6,8)
           printbin(ios.admgetspec,16,winhcol,0,act_color,15,8)
         3:print_win(@sysfont,10,8)
           ios.displaypic(winhcol,panelcol,0,10,10,11,16)

pri Date_Time(tabs,up_down)

       case tabs
            1:tag:=wert_plusminus(up_down,tag,1,31)                                                         'op=operation +/- 1/2 ,aktueller wert, mindestwert,maxwert
            2:monat:=wert_plusminus(up_down,monat,1,12)
            3:jahr:=wert_plusminus(up_down,jahr,2000,2099)
            4:stunde:=wert_plusminus(up_down,stunde,0,23)
            5:minute:=wert_plusminus(up_down,minute,0,59)
            6:sekunde:=wert_plusminus(up_down,sekunde,0,59)

    clock_refresh
    Date_refresh
pri close_all_Win

    popup_info_weg
    Fensterweg
    selection:=1
    scr:=0


pri scan_number_key:c|m
    m:=0
    repeat
        c:=ios.key
        if c or ios.mouse_button(0) or ios.mouse_button(1)
           if c=>"0" and c=<"9"
              c-="0"
           m:=1
    until m==1

pri input_zahl(y,x,old_farbe)|k,sp,i,ok ,ad                                                                   'Eingabe von Zahlenwerten
    sp:=x-1
    i:=0
    ad:=3                                                                                                     'anzahl Zeichen
             repeat
                 k:=ios.key
                 ma:=ios.mouse_button(0)

                 if k==13                                                                                     'Return? dann neue Zeile
                    ok:=1
                    textline[i++]:=0
                    quit
                 if k==27                                                                                     'Abbruch
                    ok:=0
                    quit
                 if k==ios#BEL_BS                                                                            'Backspace
                    if i>0
                       WIN_TILE(16,y,sp+i)
                       i--
                 if k=>"0" and k =< "9"                                                                       'Nur Zahlen 0-9
                    textline[i++]:=k
                    WIN_TILE(k-16,y,sp+i)
                    if i==ad
                       textline[i++]:=0
                       ok:=1
                       quit

    if ok==1
       tp:= @textline
       result:=getnumber
    else
       result:=old_farbe

{pub Flash_Rom(adr)|a,c,i,m

    ios.sdopen("R",@filestring)
    a:=ios.sdfattrib(0)
    i:=0
    m:=0
    if a<32769
       c:=8
    else
       c:=(a/$1000)+1
       m:=1
    repeat c
           ios.erase_Flash_Data(adr+(i*$1000))
           i++
    if m
       ios.wr_flashlong(adr,a)                          'bei dateien >32kb Dateilänge schreiben
       adr+=4
    ios.copytoflash(adr)

    ios.sdclose
}

pri save_ini_to_sd|adr,c

    if mountmarker==1
          playerstop                                                                                          'eventuell laufenden Player anhalten
          activate_dirmarker(systemdir)                                                                       'Systemverzeichnis setzen
          ios.sddel(@ini)                                                                                     'alte Ini-Datei löschen
          ios.sdnewfile(@ini)                                                                                 'neue Ini-Datei erstellen
          ios.sdopen("W",@ini)                                                                                'Datei öffnen
          binsave                                                                                             'alle Systemparameter speichern
    ios.sdclose                                                                                               'Datei schließen
    activate_dirmarker(userdir)                                                                               'wieder zurück ins User-Verzeichnis



{
    ios.sddel(@flash_ini)
    ios.sdnewfile(@flash_ini)
    ios.sdopen("W",@flash_ini)
    adr:=INI_ROM
    repeat $55
           ios.sdputc(ios.Read_Flash_Data(adr++))
    ios.sdclose
}
{pri flash_eeprom
    ios.flash_eeprom(@filestring,$8000)
}
con'***************************************** Tastatur-Abfragen ******************************************************************************************************************
pri keyboardscan(k)|i,err,a,c,d,e,formatok                                                                    'Tastatur-Befehlsabfrage
    do_restore~                                                                                               'bei Tastenbedienung, Hintergrund nicht herstellen
    'if system_setting[5]
    '      print_titel(string("   "),1,0)
    '      printdec_titel(k,0,1)                                                                               'Tastencode anzeigen
    case k
          9:'Tab-Taste
             case util
                    3:                                                                                        'Datum-Uhrzeit-Einstellung
                      c:=0
                      d:=0
                      e:=1
                      print_win(string(" "),21,9+5)                                                           'untere letzte Position löschen
                      print_win(string(" "),21,9)                                                             'obere letzte Position löschen
                      tab_taste++
                      if tab_taste>6
                         tab_taste:=1
                      if tab_taste>3
                         c:=5                                                                                 'Y-Position für Zeit-Einstellung
                         d:=3

                      a:=((tab_taste-d-1)*6)+9                                                                'X-Position errechnen für ausgewählten Wert
                      print_win(string("*"),a,9+c)                                                            'Auswahl markieren mit Stern
                      if tab_taste>1
                         if tab_taste<>4
                            print_win(string(" "),((tab_taste-d-e-1)*6)+9,9+c)                                'alte Position Stern löschen (untere Reihe)

                    4:                                                                                        'Color-Setting-Fenster
                      a:=get_farbe(pfeil-9)                                                                   'Farbwert des der Auswahl holen
                      printdec_win_revers(a,9,19)                                                             'Zahleneingabefeld hervorheben
                      c:=Input_Zahl(9,19,a)                                                                   'neue Zahl eingeben

                      farbe(pfeil-9,c)                                                                        'geänderte Farbe setzen
                      refreshpaint                                                                            'Ansicht aktualisieren
                      print_win(string("   "),19,9)                                                           'Zahlenfeld löschen
                      printdec_win(c,9,19)                                                                    'Zahlenwert normal darstellen

                    5:Dumpadresse                                                                             'Adresseingabe RAM-Monitpr


         13:'Enter bzw.OK
             case util                                                                                        'Utilfenster, bei dem bei Druck auf OK etwas gespeichert werden muss
                    0,2:close_all_win                                                                         'Cogs-Fenster, Systeminfo
                    3:tab_taste:=0
                      'ios.settime(sekunde,minute,stunde,today,tag,monat,jahr)
                      ios.setdate(tag)                                                                        'Systemuhr setzen
                      ios.setmonth(monat)
                      ios.setyear(jahr)
                      ios.sethours(stunde)
                      ios.setminutes(minute)
                      ios.setseconds(sekunde)

                      displaytime
                      close_all_win
                    4:inisave                                                                                 'Farbwerte saven
                      Bildschirmaufbau
                      util:=0                                                                                 'neue Farbwerte für Windowloesch Routine

                    5:ios.sid_mdmpplay(HEX_ADRESSE)                                                           'DMP-Datei aus dem Flash abspielen


                    8,10:inisave                                                                              'Baudrate saven,Systemsettings saven
                         Bildschirmaufbau

                    11:scanstr(@filestring,1)
                       '******************************Dateien starten oder Verzeichnis wechseln*************
                         if selection=<filenumber
                            FILE_START                                                                          'selektierte Datei untersuchen und starten oder anzeigen oder Verzeichnis öffnen
                    13:inisave                                                                                'Link-Parameter saven
                       close_all_win


         27:if util==11 and infomarker==1                                                                     'Datei-Info-Fenster im Explorer löschen
               do_restore:=1
               popup_info_weg
            else
               copy_marker:=0                                                                                 'Kopier-Marker beim Schließen löschen
               close_all_win
               tab_taste:=0                                                                                   'Tab-Zähler löschen


         "A","a":if util==11 and infomarker==1
                    attrmarker[3]:=toogle_value(attrmarker[3],15,14,2)
                    write_attrib
         "B","b":if util==8                                                                                   'Systemsettings
                    system_setting[4]:=toogle_value(system_setting[4],30,10,1)                                'HC05-Bluetooth benutzen oder nicht
                 if util==11
                    playerstop
                    getfilename(selection+scrollanfang)
                    'ios.eraseEEPROM
                    'flash_eeprom                                                                              'oberen EEPROM-Bereich von Bellatrix mit der selektierten Datei flashen

         "C","c":if util==11                                                                                  'Nur im Dateifenster
                    copy_marker:=1                                                                            'Kopieren
                    if strcomp(@filestring,@root)                                                             'bei Klick auf ".." alle Dateien kopieren
                       copy_all:=1                                                                            'alle Dateien
                    else
                       bytemove(@copystring,@filestring,12)
                       ios.sdopen("R",@copystring)
                        if ios.sdfattrib(19)                                                                  'Verzeichnisse werden nicht kopiert
                           display_error(26)
                           ios.sdclose
                           mc:=SD_Card
                           return
                    dmcopy := get_dirmarker                                                                   'Quellmarker von administra holen
                 elseif util==10
                    CR_FLAG:=toogle_value(CR_FLAG,13,5,2)

         "D","d":if util==8                                                                                   'Systemsettings
                    system_setting[3]:=toogle_value(system_setting[3],30,8,1)                                                       'DCF-Empfänger benutzen oder nicht
                    'dcf_onoff                                                                                 'DCF-Empfänger starten/stoppen

         "E","e":if util==5
                    dump_ram:=0
                    toogle_value(0,21,4,1)
                    toogle_value(1,29,4,1)
                    ramdump(hex_adresse)
                 if util==10
                    echo_on:=toogle_value(echo_on,21,15,2)
                 else
                    if trashcounter>0                                                                         'ist was im Mülleimer drin?
                       if display_error(31)                                                                   'fragen, ob endgültig löschen? 'Abfrage auf OK
                          SCAN_Trash(1)                                                                       'Inhalt löschen
         "F","f":if util==0                                                                                   'kein anderes Fenster offen
                    if display_error(28)                                                                      'Frage Format? anzeigen und abfragen
                       formatok:=ios.sdformat(string("PLEXUS"))                                               'SD-Card-Name
                       if formatok
                          display_error(formatok)                                                             'Fehlerausgabe wenn erfolglos
                       else
                          Display_error(27)                                                                   'wenn geklappt -> Fertigstellungs-Fenster
                          mount                                                                               'sicherheitshalber unmounten
                          wait(80000)                                                                         'etwas warten
                          mount                                                                               'und wieder mounten
                          LINK_LOAD(0)
                          Bildschirmaufbau
                          inisave
                          Muelleimer_erstellen                                                                'Trash-Verzeichnismarker aktualisieren
                 if util==5
                    dump_ram:=1
                    toogle_value(0,29,4,1)
                    toogle_value(1,21,4,1)
                    ramdump(hex_adresse)

         "H","h":{if util==5
                    dump_ram:=0
                    toogle_value(dump_ram,21,4,1)
                    toogle_value(1,29,4,1)
                    ramdump(hex_adresse)
                    }
                 if util==11 and infomarker==1
                    attrmarker[1]:=toogle_value(attrmarker[1],7,14,2)
                    write_attrib

         "I","i":if util==11                                                                                  'Nur im Dateifenster
                    infofenster(8,10,28,14,ram_txt(33),0)                                                     'Infofenster hat jetzt feste Position
                    FILE_INFO_FENSTER
                    attribut_fenster:=1
                 else
                    infofenster(12,10,27,20,ram_txt(32),1)                                                    'SD-Card-Info-Fenster anzeigen
                    SD_CARD_INFO                                                                              'Fenster mit Info's füllen

         "L","l":if util==11                                                                                  'Link erstellen
                    playerstop
                    getfilename(selection+scrollanfang)
                    if muelleimer==0                                                                          'Links aus dem Muelleimer sind nicht zulässig
                       Make_link(get_dirmarker)
                       'Flash_Rom(HEX_ADRESSE)

                 elseif util==10
                    LF_FLAG:=toogle_value(LF_FLAG,17,5,2)
                 else
                    i:=scan_number_key
                    if i=>0 and i=<Link_counter                                                               'auf gültige Nummer abfragen
                       LINK_START(i-1)

         "M","m":playerstop                                                                                   'eventuell laufenden Player stoppen
                 mount                                                                                        'SD-Card mounten/unmounten
                 load_ini_in_ram
                 Bildschirmaufbau                                                                             'Bildchirm aktualisieren
                 Muelleimer_erstellen                                                                         'Trash-Verzeichnismarker aktualisieren

         "N","n":if (util==11) and (get_dirmarker<>trashdir)                                                  'Nur im Dateifenster (nicht im Mülleimer)
                    playerstop
                    cmd_mkdir
                    change_marker:=0                                                                          'Verzeichnis muss neu eingelesen werden
                    mc:=SD_CARD

         "P","p":if util==11 and link_merker==0                                                               'Nur im Dateifenster
                    if copy_marker==1
                       playerstop
                       copy_marker:=0
                       dmpaste := get_dirmarker                                                               'usermarker von administra holen
                       if copy_all==1                                                                         'Marker für alle Dateien kopieren
                          targetdir:=dmpaste
                          userdir:=dmcopy
                          activate_dirmarker(userdir)
                          File_All(0)
                          copy_all:=0
                          activate_dirmarker(targetdir)
                       else
                          copy_function(dmcopy,dmpaste,@copystring,0)                                         'nur eine Datei kopieren
                       change_marker:=0                                                                       'Verzeichnis muss neu eingelesen werden
                       mc:=SD_CARD

                 else                                                                                         'Link-Parameter-Fenster
                    fensterweg                                                                                'alle anderen Fenster löschen
                    i:=scan_number_key
                    if i=>0 and i=<link_counter                                                               'auf gültige Nummer abfragen
                       get_link(LINK_RAM,i-1,1)                                                                   'Link-Name holen
                       LINK_PARAMETERS(i-1)                                                                     'Parameter für Link 0 bis 2
                       d:=Text_Input(0,3,30,10,12,0,PARA_RAM+((i-1)*64)-1,63)
                       keyboardscan(d)



         "R","r":if util==11                                                                                  'Rename
                    ifnot infomarker
                          ifnot strcomp(@filestring,@root)                                                    'nicht ".." umbenennen
                                playerstop
                                if Text_Input(0,3,14,selection+3,selection+3,0,0,13)==13
                                   err:= ios.sdrename(@filestring,@textline)                                  'rename durchfuehren
                                   if err
                                      display_error(err)                                                      'fehler wenn rename erfolglos
                                change_marker:=0                                                              'Verzeichnis muss neu eingelesen werden
                                mc:=SD_CARD
                    else
                       attrmarker[0]:=toogle_value(attrmarker[0],3,14,2)
                       write_attrib
                 if util==5
                    sanduhr(Hex_adresse/$8000)

         "S","s":if util==11 'or util==5                                                                                 'Show Nur im Dateifenster
                    ifnot infomarker
                          fensterweg                                                                          'Dateifenster löschen
                          textfenster                                                                         'Textfenster öffnen
                          playerstop
                          print_titel(@filestring,15,2)
                          'if system_setting[5]
                          '   print_status(@filestring,14,29)
                          'if util==5
                          '   ios.Init_Flash_File(@filestring)
                          '   ios.Open_Flash_File
                          '   Textdisplay(1,2,4,2)
                          'else
                          Textdisplay(1,2,4,0)


                    else
                       attrmarker[2]:=toogle_value(attrmarker[2],11,14,2)
                       write_attrib


                 if util==8                                                                                   'Systemsettings
                    system_setting[1]:=toogle_value(system_setting[1],16,8,1)                                       'Versteckte Dateien anzeigen oder nicht
                    change_marker:=0                                                                          'Verzeichnis neu in den Ram laden

         "T","t":activate_dirmarker(trashdir)                                                                 'Mülleimer-Verzeichnismarker setzen
                 muelleimer:=1                                                                                'Marker für Mülleimerfenster
                 change_marker:=0                                                                             'nach dem Mülleimer immer Verzeichnis neu einlesen
                 mc:=SD_CARD
                 change_marker:=0
                 if util==11
                    print_titel(@trash,2,26)                                                                    'Trashverzeichnis in der Statusleiste anzeigen


         "U","u":if util==8                                                                                   'Systemsettings
                    system_setting[2]:=toogle_value(system_setting[2],16,10,1)                                                'Mülleimer benutzen oder nicht


         "Y","y":YMODEM_Tool(1)'Sende-File

         "Z","z":YMODEM_Tool(0)'Empfange-File


         ENTF_KEY:if util==11 and link_merker==0                                                              'Nur im Dateifenster
                    playerstop
                    ifnot strcomp(@filestring,@dirhoch)                                                       '"." nicht löschen
                          ifnot strcomp(@filestring,@root)                                                    'nicht ".." ?
                                cmd_del(@filestring)                                                          'einzelne Datei loeschen

                          else                                                                                'bei Klick auf ".." können alle Dateien gelöscht werden
                                if display_error(30)
                                   File_All(1)
                          change_marker:=0                                                                    'Verzeichnis muss neu eingelesen werden
                          mc:=SD_CARD

                  else                                                                                        'Löschen von Links
                     i:=scan_number_key
                     if i=>0 and i=<link_counter                                                              'auf gültige Nummer abfragen
                        abfrage_Link_del(i-1)



         '********************* Steuerung DMP-Player durch Tastatur (+/-,Space)***************************************************************************************
         32,43,45:if tmpplay>0
                     case k
                          plus_key:tmpplay:=wert_plusminus(1,tmpplay,1,dmpfiles)                              'titel vor
                          minus_key:tmpplay:=wert_plusminus(2,tmpplay,1,dmpfiles)                             'titel zurück
                          Space_Key:if play==1                                                                'play/stop
                                       play:=0
                                    else
                                       play:=1
                     playsong(tmpplay,Windownum[1])                                                           'Player starten (wenn Fenster da ist, balken löschen)
                     Player_sichtbar                                                                          'Titel und Samples im Playerfenster anzeigen

         159:about                                                                                            'ALT_F1 About-Box
         158:util:=8
             setting_window                                                                                   'ALT_F2 Setting-Window
         {157:if system_setting[5]==1                                                                                 'ALT_F3 Tastaturscanner ein und ausschalten (erweiterte Titelzeile)
                system_setting[5]:=0
                print_shell(string("   "),0,0)
                del_keyscan
             else
                system_setting[5]:=1
                status_onoff
         }

         156:'ALT_F4
         144:util:=10                                                                                         'ALT_F5 Baud-Einstellfenster
             baudselect(system_setting[0])
         145:'ALT_F6
         146:'ALT_F7
              playerstop
              save_ini_to_sd
         147:'ALT_F8
         151:'ALT_F9
              if util==11                                                                                  'Link erstellen
                 playerstop
                 getfilename(selection+scrollanfang)
                 'Flash_rom(Hex_adresse)
         150:'ALT_F10
              sanduhr(12)                                                                                     'ALT_F10 - Updater starten
         149:'ALT_F11

         148:'ALT_F12
              cmd_reboot(0)                                                                                   'ALT_F12 - Kaltstart-Reboot

         208:Show_Help                                                                                        'F1 Hilfe
         209:activate_dirmarker(userdir)                                                                      'Verzeichnismarker setzen
             util:=11
             mc:=SD_Card                                                                                      'F2 datei-fenster
             if Verzeichnis_counter>0
                Get_Verz_Name
         210:util:=7
             Programms                                                                                        'F3 Programms-Fenster
         211:util:=0
             CoreAnzeige                                                                                      'F4 Belegung der Cogs anzeigen
         212:util:=1
             Terminal                                                                                         'F5 serielles Terminal
             bytefill(@inputline,0,80)
             Text_Input(1,2,33,4,25,1,0,0)

         213:util:=2
             Sysinfo                                                                                          'F6 Systeminformationen anzeigen
             textdisplay(2,6,8,vidnfo)'print_info(vidnfo,6,8)
         214:util:=3
             Clock                                                                                            'F7 Uhr-und Datums-Einstellfenster
         215:util:=4
             Color                                                                                            'F8 Farb-Einstell-Fenster
             pfeil:=9
             pfeil_old:=9
         216:util:=5
             RamDump(HEX_ADRESSE)                                                                             'F9 RAM-Rom-Fenster anzeigen
             scrollanfang:=HEX_ADRESSE
             startadresse:=HEX_ADRESSE
             endadresse:=HEX_ADRESSE+152
         217:util:=6
             Player(tmpplay-1)                                                                                'F10 - Sid-Dmp-Player anzeigen
         218:util:=9                                                                                          'F11 - Kalender
             Kalender
         219:cmd_reboot(1)                                                                                    'F12 - Warmstart-Reboot

pri YMODEM_Tool(mode)|a,i                                                                                     'Aufruf der YMODEM-Routine
    a:=YMODEM_RAM
    i:=0
    if mode
       repeat strsize(@filestring)
              ios.ram_wrbyte(filestring[i++],a++)                                                             'Dateiname merken
    ios.ram_wrbyte(mode,YMODEM_RAM+15)                                                                        'was soll gemacht werden (senden/empfangen)
    run_sys(F2_KEY,1)                                                                                         'Rückkehraktion

{pri YMODEM_Tool(mode)|a,i                                                                                     'Aufruf der YMODEM-Routine
    a:=YMODEM_RAM
    i:=0
    if mode
       repeat strsize(@filestring)
              ios.ram_wrbyte(filestring[i++],a++)                                                             'Dateiname merken
    ios.ram_wrbyte(mode,YMODEM_RAM+15)                                                                        'was soll gemacht werden (senden/empfangen)
    run_sys(dll_txt(1),F2_KEY)                                                                                   'Rückkehraktion
}
pri abfrage_Link_del(n)                                                                                       'Abfrage, ob link gelöscht werden soll

             error(29)                                                                                        'Messagebox-Link-löschen?
             get_link(LINK_RAM,n,1)                                                                             'Link-Name holen
             print_message(@filestring,15,13)                                                                 'Link-Name in Messagebox anzeigen
             if abfrage                                                                                       'OK-Taste abfragen
                Delete_Link(n,(n*5)+8)                                                                        'Link löschen

{pri run_sys(mark,n)              'starten der eingebetteten Programme
    playerstop
    ios.ram_wrlong(userdir,MARKER_RAM)                                                                        'aktuellen Verzeichnismarker merken
    ios.ram_wrbyte(mark,RETURN_POINT)                                                                         'Aktion nach Rückkehr setzen
    ios.ram_wrbyte(verzeichnis_counter,RETURN_POINT+1)                                                        'Verzeichnis-Tiefenzähler muss auch gemerkt werden
    sanduhr(n)}
pri run_sys(str,mark)              'starten der eingebetteten Programme
    playerstop
    ios.ram_wrlong(userdir,MARKER_RAM)                                                                        'aktuellen Verzeichnismarker merken
    ios.ram_wrbyte(mark,RETURN_POINT)                                                                         'Aktion nach Rückkehr setzen
    ios.ram_wrbyte(verzeichnis_counter,RETURN_POINT+1)                                                        'Verzeichnis-Tiefenzähler muss auch gemerkt werden
    activate_dirmarker(systemdir)
    sanduhr(str)
{pri run_sys(str,mark)              'starten der eingebetteten Programme
    playerstop
    ios.ram_wrlong(userdir,MARKER_RAM)                                                                        'aktuellen Verzeichnismarker merken
    ios.ram_wrbyte(mark,RETURN_POINT)                                                                         'Aktion nach Rückkehr setzen
    ios.ram_wrbyte(verzeichnis_counter,RETURN_POINT+1)                                                        'Verzeichnis-Tiefenzähler muss auch gemerkt werden
    activate_dirmarker(systemdir)
    sanduhr(str)
}
{pri sanduhr(str)
    ifnot OPEN_FILE(str)
          ios.mousepointer(Hour_Glass)                                                                        'Sanduhr anzeigen
          ios.ldbin(str)
}
{
YMODEM   =  '1 $8000Plexus sitzt an Stelle 0 im Map-RAM ->Ymodem_dll an Position 1
BASRUN   =     $10000
SEPIA    =  '2 $18000
VENATRIX =  '3 $20000
SHELL    =  '4 $28000
DCF77    =  '5 $30000
BLUETOOTH=  '6 $38000
FONTEDIT =  '7 $40000
WAVEGEN  =  '8 $48000
PLIRC    =  '9 $50000
EEPROM   =  'A $58000
}
pri sanduhr(str)                                                                                                 'Ab Version 2.2 arbeitet Plexus aus dem E-Ram
    ifnot OPEN_FILE(str)
          ios.mousepointer(Hour_Glass)                                                                        'Sanduhr anzeigen
          ios.ldbin(str)

'       ios.mousepointer_flash(HourGlass_FLASH)                                                                            'Sanduhr anzeigen
'       ios.ld_rambin(n+2)                                                                                      'wenn ja, dann aus dem E-Ram laden

pri Highlight_balken                                                                                          'ist der Hevorhebungsbalken außerhalb des Scrollbereiches, dann gemerkte Werte löschen
    if y_old<4 or y_old>24                                                                                    'außerhalb Scrollbereich?
       reset_Highlight                                                                                        'Parameter für die Hervorhebung löschen

pri reset_Highlight                                                                                           'Hervorhebungsparameter löschen (z.Bsp.bei Aufruf eines Unterverzeichnisses)

    highlight:=0                                                                                              'Hervorhebungsmarker löschen
    bytefill(@filestring_old,0,12)                                                                            'Dateinamen-Puffer löschen

PRI highlight_selection(position)                                                                             'Dateiname mit einem farbigen Balken hervorheben
  ' printdec_win(y_old,1,1)
  if (util==11 or util==5) and position>3                                                                                  'nur im Dateifenster ab position y==4 hervorheben
    if highlight                                                                                              'erstes mal Datei angeklickt(keine Old-Parameter)

       display_line(@filestring,position,winhcol,act_color)                                                   'Dateiname mit Balken anzeigen

    if highlight and strsize(@filestring_old)>0 'and position<>y_old                                           'Hervorhebung aktiv und String im Puffer?

       display_line(@filestring_old,y_old,old_color,winhcol)                                                  'alter Dateiname an alter Position ohne Balken anzeigen
    bytemove(@filestring_old,@filestring,12)                                                                  'neuen Dateinamen in den Puffer schreiben
    y_old:=position                                                                                           'y-Koordinate merken

    scanstr(@filestring,1)                                                                                    'Datei auf Endung scannen
    old_color:=act_color                                                                                      'Farbe zurücksetzen (Standardschriftfarbe)
    if file_info[0]==255                                                                                           'Wenn Verzeichnis
       old_color:=selectcol                                                                                   'Select-Farbe verwenden

con '*********************************** Datei-Handling **************************************************************************************************************************
PRI OPEN_FILE(str):err
    err:=ios.sdopen("R",str)
    if err
       display_error(err)
       ios.sdclose

pri start_file(mode)|a,c

    'status_onoff
    ifnot OPEN_FILE(@filestring)

          case mode
          '***************************** BIN-Dateien starten ***********************************
               1:'ios.ram_wrbyte(0,START_FLAG)
                 ios.ldbin(@filestring)
               2:ios.belload(@filestring)
               3:ios.admload(@filestring)
               4:'if venatrix
                 '   ios.venload(@filestring)

               5:ios.paraset(@filestring)
                 ios.ram_wrbyte(0,START_FLAG)
                 run_sys(F2_KEY,2)
                 'ios.ldbin(@basrun)
          '****************************** SID-DMP-Dateien abspielen *****************************
               6:bytemove(@dumpstring,@filestring,12)
                 tmpplay:=dumpnummer                                                               'Positionszähler aktualisieren
                 OPEN_FILE(@dumpstring)
                 ios.sid_sdmpplay(@dumpstring)
                 play:=1
          '***************************** Text-Dateien anzeigen *********************************
               7:windowloesch                                                                         'Dateifenster löschen
                 textfenster                                                                          'Textfenster öffnen
                 print_titel(@filestring,15,2)
                 Textdisplay(0,2,4,0)
          '***************************** Color-Schemen-Dateien laden ***************************
               8:repeat a from 0 to 14
                        c:=ios.sdgetc
                        farbe(a,c)
                 ios.sdseek(69)
                 lmouse
                 bytemove(@textline,@filestring,12)                                             'Backup von @filestring
                 Bildschirmaufbau                                                               'Bildschirm mit den neuen Farben darstellen
                 mc:=SD_Card
                 bytemove(@filestring,@textline,12)                                             'restore von @filestring
                 'status_onoff
          '****************************** Maus-Pfeil laden **************************************
               9:loadMouse(@filestring)
          '****************************** Font-Datei laden **************************************
              10:ios.mousepointer(Hour_Glass)                                                    'Sanduhr anzeigen
                 load_Font
                 ios.mousepointer(Mouse_ram)                                                    'Mauszeiger anzeigen


pri load_Font

    LoadTiletoRam(@filestring,SYS_FONT)                                                                  'neue Fontdatei in den Ram laden
    ios.loadtilebuffer(SYS_FONT,2816)                                                                    'Systemfont aus E-Ram nach Bella laden
    activate_dirmarker(systemdir)                                                                        'ins Systemverzeichnis
    ios.sddel(@sysfont)                                                                                  'bisherigen Systemfont löschen
    ios.sdnewfile(@filestring)                                                                           'neue leere Datei (neue Font-Datei) erzeugen
    ios.sdcopy(userdir,systemdir,@filestring)                                                            'ausgewählte Fontdatei ins Systemverzeichnis kopieren
    activate_dirmarker(rootdir)                                                                          'nach dem kopieren muß erst mal ins Root-Verzeichnis gesprungen werden
    activate_dirmarker(systemdir)                                                                        'gehe ins Systemverzeichnis

    ios.sdrename(@filestring,@sysfont)                                                                   'Font-Datei in Reg.Fnt umbenennen

    activate_dirmarker(userdir)                                                                          'wieder ins User-Verzeichnis springen



PRI LoadTiletoRam(datei,adress)                         'tile:=tilenr,dateiname,xtile-zahl,ytilezahl
    ios.sdopen("R",datei)                               'datei öffnen
    ios.sdxgetblk(adress,11264)                         'datei in den Speicher schreiben  (der blockbefehl ist viel schneller als der char-Befehl)
    ios.sdclose

PRI FILE_START|dirmark

    if mountmarker==1
       playerstop
       dirmark:=get_dirmarker

          '***************************** BIN-Dateien starten ***********************************
                      if strcomp(@buff,@binfile)                                                              'BIN-Datei, Ext-Datei starten
                               start_file(1)
                      if strcomp(@buff,@belfile)                                                              'BEL-Datei starten
                               start_file(2)
                      if strcomp(@buff,@admfile)                                                              'ADM-Datei starten
                               start_file(3)
                      if strcomp(@buff,@venfile)
                               start_file(4)
                      if strcomp(@buff,@basfile)                                                              'Basic-Runtime starten
                               start_file(5)
          '****************************** Maus-Pfeil laden **************************************
                      if strcomp(@buff,@maus)
                               start_file(9)
          '****************************** SID-DMP-Dateien abspielen *****************************
                      if strcomp(@buff,@dmpfile)                                                              'Sid-Dmp-Dateien abspielen
                               start_file(6)
          '***************************** Text-Dateien anzeigen *********************************
                      if strcomp(@buff,@txtfile)                                                              'Txt Dateien anzeigen
                               start_file(7)
          '*************************************************************************************
                      if strcomp(@buff,@fontdat)
                               start_file(10)
          '***************************** Color-Schemen-Dateien laden ***************************
                      if strcomp(@buff,@colorfile)                                                            'Farb-Einstellungs-Dateien laden
                         '---- Farb-SETTINGS IN DEN RAM LADEN -------------
                               start_file(8)
          '****************************** Verzeichnis öffnen ***********************************

                      if file_info[0]==255 or strcomp(@filestring,@dirhoch) or strcomp(@filestring,@root)          'Verzeichnis? dann öffnen
                               highlight:=0                                                                   'Hervorhebung zurücksetzen
                               bytefill(@filestring_old,0,12)                                                 'Dateinamepuffer löschen
                         ifnot(strcomp(@filestring,@trash))
                               if dirmark<>trashdir                                                           'Im Trashordner kann das Verzeichnis nicht gewechselt werden
                                     dmpfiles:=0                                                              'Dmp-List-Zähler zurücksetzen
                                     change_marker:=0                                                         'Merker, das Verzeichnis geändert wurde

                                     if strcomp(@filestring,@dirhoch)                                         'Ins Root-Verzeichnis
                                        activate_dirmarker(rootdir)
                                        Verzeichnis_counter:=0
                                        userdir:=rootdir
                                     else
                                        ios.sdchdir(@filestring)
                                        userdir:=get_dirmarker                                                'User-Marker lesen

                                        if strcomp(@filestring,@root)                                         'Verzeichnis-tiefenzähler aktualisieren
                                           Verzeichnis_counter--

                                        else
                                           Verzeichnis_counter++
                                           Put_Verz_Name

                                     scrollanfang:=0                                                          'Scrollparameter setzen
                                     kz:=1
                                     scr:=0
                                     mc:=SD_Card

                                     if filenumber>lines
                                        zeilenende:=lines
                                        scrollende:=lines
                                     else
                                        zeilenende:=filenumber
                                        scrollende:=filenumber


Pri PUT_Pfad(n)|i,sp,tm,tc
    tm:=1
    tc:=n
    sp:=2
    repeat while tc>3                                                'Bei Verzeichnistiefe größer 3 beginne mit Verzeichnisname - letztes Verzeichnis-3
           tm+=1
           tc-=1
    if tm>1
       ios.displaytile(76,titelhcol,0,titeltextcol,26,sp++)

    repeat i from tm to n
           GET_LINK(Verz_Ram,i,0)
           sp:=print_titel(@filestring,sp,26)
           ios.displaytile(76,titelhcol,0,titeltextcol,26,sp++)

Pri Get_Verz_Name
    GET_LINK(Verz_Ram,Verzeichnis_counter,0)

Pri Put_Verz_Name
    WriteDmpToRam(Verz_RAM,@filestring,12,Verzeichnis_counter)

pri Bildschirmaufbau
    ios.printBoxSize(0,1, 0, 29, 39)
    ios.printBoxColor(0,0,shellhcol,black)
    ios.printchar(12)                                                                                         'cls
    ios.printcursorrate(0)
    'side_panel
    if mountmarker==1
       icon(1,1)                                                                                              'sd-card-symbol
    else
       icon(1,0)
    icon(2,1)                                                                                                 'mülleimer
    Show_Trash                                                                                                'Mülleimer anzeigen

    Shell
    statusleiste                                                                                              'Statusleiste anzeigen
    panel                                                                                                     'Utilitiepanel
    ios.printwindow(0)                                                                                        'Hauptfenster 0 setzen
    ios.Mousepointer(MOUSE_RAM)                                                                               'Maus-Pointer einlesen
    ios.displaymouse(1,mousecol)                                                                              'Mousezeiger sichtbar
    FILL_LINK                                                                                                 'Desktopverknüpfungen wiederherstellen
    displaytime                                                                                               'Zeit+Datum anzeigen

con'****************************************************** Datum und Zeitanzeige *************************************************************************************************

PRI time|s                                                                                                    'Zeitanzeige in der Statusleiste
    timezaehler++
    if timezaehler>190
       timezaehler:=0
       'ios.readClock
       s:=ios.getminutes
'       Status_extern(ios.dcf_sync,system_setting[3],170,34,29,hcolstatus,green,black)                          'Anzeige des aktuellen Status in der Statusleiste neben der Uhr
'       if venatrix==1
'          ios.bus_putchar3(50)                                                                                 'Status HC05 abfragen
'          bl_connect:=ios.bus_getchar3
'          Status_extern(bl_connect,system_setting[4],169,19,0,titelhcol,blue,white)                            'Anzeige des aktuellen Status in der Titelzeile

          'printfont(ios.dht_temp,titelhcol,0,act_color,12,1)                                                   'Anzeige DHT22 Temperatur
'          printfont(string("C "),titelhcol,0,act_color,17,1)
'          repeat 10000
          'printfont(ios.dht_hum,titelhcol,0,act_color,24,1)                                                    'Anzeige DHT22 Feuchte
'          printfont(string("%"),titelhcol,0,act_color,27,1)

'       else
'          ios.bus_putchar1(254)                                                                                 'Status HC05 abfragen
'          bl_connect:=ios.bus_getchar1
'          Status_extern(bl_connect,system_setting[4],169,19,0,titelhcol,blue,white)                                'Anzeige des aktuellen Status in der Titelzeile
       if s<>tmptime
          displaytime



PRI displaytime|h,m


       h:=ios.gethours
       m:=ios.getminutes
       print_zehner(h,29,35,statustextcol,hcolstatus)

       ios.displaytile(42,hcolstatus,0,statustextcol,29,37)                                                   'doppelpunkt
       print_zehner(m,29,38,statustextcol,hcolstatus)
       'ios.displaytile(16,hcolstatus,0,statustextcol,29,39)                                                   'leerfeld
       tmptime:=m
       date


{pri Status_extern(wert1,wert2,tnr_act,x,y,f1,col,f3)

          if wert2==1                                                                                         'Externe Komponente in Settingmenue ausgewählt?
             if wert1==1
                ios.displaytile(tnr_act,f1,col,f3,y,x)                                                 'Status ok-anzeigen
             else
                ios.displaytile(tnr_act,f1,grey,0,y,x)                                                 'Symbol grau
          else
             ios.displaytile(16,f1,titeltextcol,0,y,x)                                                 'Ohne externe Komponente arbeiten (kein Symbol)
}

PRI date|t,m,j
      t:=ios.getdate
      m:=ios.getmonth
      j:=ios.getyear

      print_zehner(t,0,22,titeltextcol,titelhcol)
      TITEL_TILE(30,0,24)                                                                                     'Punkt

      print_zehner(m,0,25,titeltextcol,titelhcol)
      TITEL_TILE(30,0,27)                                                                                     'Punkt

      printdec_titel(j,0,28)                                                                                  'Jahr

con'************************************ Kalender-Funktion ********************************************************************************************************************
pri Kalender|i,day,x,y,f,tok','mo,tg
    Wert_Monat:=ios.getmonth
    Wert_Jahr:=ios.getyear
    today:=ios.getdate
    window(1,4,5,5,19,26,ram_txt(34))

    Frame_Tile(133,4,4)
    Frame_Tile(117,4,27)
    Frame_Tile(133,6,4)
    Frame_Tile(117,6,27)

    iconbutton(15,124,6,5)
    iconbutton(16,123,10,5)

    iconbutton(17,124,20,5)
    iconbutton(18,123,25,5)



    repeat i from 5 to 26
           Frame_Tile(130,4,i)
           Frame_Tile(130,6,i)


    day:=0
    x:=3
    y:=9
    i:=0
    f:=act_color

    repeat 7
          tok:=@@DAYS[i++]                                                                                    'Tage anzeigen
          if i==7
             f:=$80                                                                                           'Sonntag rot
          printfont(tok,winhcol,0,f,x+=3,y-2)
          Win_Tile(130,y-1,x)
          Win_Tile(130,y-1,x+1)
          if i<7
             Win_Tile(130,y-1,x+2)

    Zeichne_Kal(ios.getmonth,ios.getyear)


pri Zeichne_Kal(mo,jr)|x,y,day,i,tag_anfang,tok,farb


    day:=0
    x:=3
    y:=9
    i:=0

    tok:=@@MONS[mo-1]
    print_win(tok,7,y-4)                                                                                      'Monat anzeigen
    printdec_win(Wert_Jahr,5,21)                                                                              'Jahr anzeigen

    tag_anfang:=wochentag(1,mo,jr)
    tag_zahl:=anzahl_tage(mo,jr)
    x:=((tag_anfang)*3)
    ios.display2dbox(winhcol,9,6,19,25,0)
    repeat 6
           repeat 7
                 day++
                 farb:=act_color
                 if wochentag(day,mo,jr)//7==0                                                                'Sonntage sind rot
                    farb:=$80
                 if day==today and mo==ios.getmonth and jr==ios.getyear
                    print_zehner(day,y,x+=3,winhcol,act_color )                                               'Heute hervorheben
                 else
                    print_zehner(day,y,x+=3,farb,winhcol)                                                     'restliche Tage

                 if day==tag_zahl
                    quit
                 if x>22
                    quit
           y+=2
           x:=3
           if day==tag_zahl
              quit

pri anzahl_tage(mon,jhr):anz
    '------------------ Anzahl Tage im Monat ---------------------------
    anz:=lookupz(mon:0,31,28,31,30,31,30,31,31,30,31,30,31)

    if mon==2 and (jhr//4)==0                                                                                 'Schaltjahr
       anz:=29


pri wochentag(tg,mon,jr)|a,b,c,d,e,f

   a:= tg // 7
   '------------- Merkziffern für die Monate ---------------------------
   b:=lookupz(mon:0,0,3,3,6,1,4,6,2,5,0,3,5)


   c:=jr/100                                                                                                  'Jahrhundert
   d:=jr-(c*100)                                                                                              'Jahr
   case c                                                                                                     'Jahrhundertziffer
        19, 23, 27:e:=0
        18, 22, 26:e:=2
        17, 21, 25:e:=4
        16, 20, 24:e:=6

   c:=(d + (d / 4)) // 7                                                                                      'Jahresziffer

   '-------- Schaltjahrkorrektur --------------
   f:=0
   if (jr//4==0) and (mon<3)                                                                                  'im Schaltjahr muss bei einem Datum vor dem 1.März eine 6 addiert werden
      f:=6
   result:=(a + b + c + e + f) // 7
   if result==0
      result:=7


                                                                                                              'Ergebnis ist der Wochentag

con '***************************************************** Dateiattribute setzen *************************************************************************************************

PRI FILE_INFO_FENSTER
    print_win(ram_txt(35),windowx[2]+1,windowy[2]+1)
    print_win(@filestring,windowx[2]+1+9,windowy[2]+1)
    print_win(ram_txt(36),windowx[2]+1,windowy[2]+2)
    if file_info[0]
       print_win(ram_txt(37),windowx[2]+1+9,windowy[2]+2)
    else
       print_win(ram_txt(38),windowx[2]+1+9,windowy[2]+2)
    print_win(ram_txt(39),windowx[2]+1+3,windowy[2]+4)
    print_win(ram_txt(40),windowx[2]+3,windowy[2]+5)

    get_attrib(file_info[1],0,3,2)

    get_attrib(file_info[2],1,7,2)
    get_attrib(file_info[3],2,11,2)
    get_attrib(file_info[4],3,15,2)

PRI get_attrib(atr,n,x,win)
    if atr==255
       attrmarker[n]:=1
       Win_Tile(139,windowy[win]+6,windowx[win]+1+x)
    else
       attrmarker[n]:=0
       Win_Tile(140,windowy[win]+6,windowx[win]+1+x)

PRI toogle_value(at,x,y,win)
    Mouse_Release
    if at==1
       Win_Tile(140,y,windowx[win]+1+x)
       at:=0
    else
       at:=1
       Win_Tile(139,y,windowx[win]+1+x)
    return at

PRI write_attrib|i,e
    i:=0
    playerstop
    bytefill(@attribute,0,4)                                                                                  'Dateiattribute ändern
    if attrmarker[0]==1
       attribute[i++]:="R"
    if attrmarker[1]==1
       attribute[i++]:="H"
    if attrmarker[2]==1
       attribute[i++]:="S"
    if attrmarker[3]==1
       attribute[i++]:="A"
    attribute[i]:=0
    e:=ios.sdchattrib(@filestring,@attribute)
    if e
       display_error(e)
    change_marker:=0                                                                                                   'Verzeichnis neu in den Ram laden

con '***************************************************** Diverse Texte aus dem E-Ram lesen *************************************************************************************

PRI ram_txt(nummer)
    return txt_from_ram(txt_ram,nummer,error_step)

pri dll_txt(nummer)
    return txt_from_ram(dll_ram,nummer,dll_step)

pri txt_from_ram(adr,nummer,st)|c,i,ad
    i:=0
    ad:=adr+((nummer-1)*st)
         repeat while c:=ios.ram_rdbyte(ad++)
                 if c>13
                    byte[@font][i++]:=c
    byte[@font][i]:=0
    return @font
con '***************************************************** Die einzelnen Fenster *************************************************************************************************
PRI SD_CARD_INFO|fr,us,pr,str

      ifnot Checkmount                                                                                        'test ob medium gemounted ist

         fr:=ios.sdcheckfree/1024*512
         us:=ios.sdcheckused/1024*512
         print_win(string("Vol.:"),12,10)
         str:=ios.sdvolname
         printfont(str,winhcol,0,act_color,17,10)
         print_win(string("Free Kb:"),12,13)
         printdec(fr,13,20,winhcol,act_color)
         print_win(string("Used Kb:"),12,14)
         printdec(us,14,20,winhcol,act_color)
         pr:=fr+us
         print_win(string("All  Kb:"),12,12)
         printdec(pr,12,20,winhcol,act_color)
         pr:=100*fr/pr
         print_win(string("Free % :"),12,16)
         printdec(pr,16,20,winhcol,act_color)


PRI SD_Card:msz|b
            b:=0
            ifnot Checkmount
               reset_Highlight                                                                                'Hervorhebungsparameter löschen
               fensterweg
               Programmfenster(8,ios.sdvolname)
               ifnot change_marker                                                                            'Dir neu einlesen, wenn das Verzeichnis geändert wurde
                  playerstop                                                                                  'Player stoppen
                  tmpplay:=0                                                                                  'Song-Zähler auf null
                  cmd_dir
                  change_marker:=1                                                                            'Verzeichnis wurde geändert
               print_titel(@files,22,2)
               print_titel(@dirs,13,2)
               printdec_titel(filenumber-dirnumber,2,28)
               if (verzeichnis_counter>0) or (get_dirmarker==trashdir)                                        'im Unterverzeichnis oder Mülleimer wird 2 abgezogen da . und .. mitgezählt wurden
                  b:=2
               printdec_titel(dirnumber-b,2,18)
               msz:=show_always                                                                               'Dateiliste aus dem E-Ram anzeigen
            else
               windowloesch
               return

pri show_always:msz
               scrollanfang:=0
               msz:=ios.mousez
               selection:=3
               if filenumber>21
                  zeilenende:=21
                  scrollende:=21
               else
                  zeilenende:=filenumber
                  scrollende:=filenumber
               display_list(zeilenanfang,zeilenende)
               util:=11
               if verzeichnis_counter>0 and get_dirmarker<>trashdir
                  Put_Pfad(Verzeichnis_counter)
               scr:=0

PRI textfenster
    Programmfenster(4,ram_txt(41))

PRI Startmenue
    'ios.backup_area(0,16,9,28,BRAM)
    popup(0,16,9,28)
    print_titel(ram_txt(42),0,16)
    separator(0,17,9)
    print_message(@Help,0,18)
    separator(0,19,9)
    print_message(@baud_set,0,20)
    separator(0,21,9)
    print_message(@settings,0,22)
    separator(0,23,9)
    print_message(@programs,0,24)
    separator(0,25,9)
    print_message(@reboots,0,27)
    menuemarker:=1
    menue_nr:=0

PRI Coreanzeige|c[4],i,cogs,loops
    window(1,4,8,8,16,27,ram_txt(62))
    print_win(ram_txt(43),8,8)
    print_win(ram_txt(44),8,10)
    print_win(ram_txt(45),8,12)

    c[0]:=ios.admgetcogs
    c[1]:=ios.belgetcogs
    c[2]:=ios.reggetcogs
    loops:=3
    'Scan_Expansion_Card                                                                                       'nach Venatrix-Karte scannen
    {if venatrix
       c[3]:=ios.VEN_GETCOGS
       print_win(ram_txt(58),8,14)
       loops:=4
    }
    i:=0
    cogs:=1
    repeat loops
         repeat 8
             if (cogs=<(8-c[i]))                                                                              'freie cogs = belegte cogs -8
                ios.displaytile(COG_PIC,winhcol,red,0,8+i+i,19+cogs-1)
             else
                ios.displaytile(COG_PIC,winhcol,green,0,8+i+i,19+cogs-1)
             cogs++
         cogs:=1
         i++

    button(1,@butOK,15,16)
    'button(2,@Abbr,20,16)

PRI Setting_window|a

    window(1,4,6,2,20,33,ram_txt(46))
    rahmen(2,6,19,11)
    print_win(ram_txt(47),3,8)                                                                                'Show-Hidden Files
    print_win(ram_txt(48),3,10)                                                                               'Use Trash
    print_win_rev(ram_txt(71),3,6)                                                                            'Explorer
    WIN_TILE(140-system_setting[1],8,18)
    WIN_TILE(140-system_setting[2],10,18)

    rahmen(21,6,33,11)
    print_win_rev(ram_txt(72),22,6)                                                                           'Option
    print_win(ram_txt(69),22,8)                                                                               'Use DCF-Receiver
    print_win(ram_txt(70),22,10)                                                                              'Use HC05-Bluetooth
    WIN_TILE(140-system_setting[3],8,32)
    WIN_TILE(140-system_setting[4],10,32)
    WIN_TILE(170,8,30)                                                                                        'DCF-Symbol
    WIN_TILE(169,10,30)                                                                                       'Bluetooth-Symbol

    rahmen(2,13,19,18)
    print_win_rev(ram_txt(73),3,13)                                                                           'Detect-Hardware
    print_win(ram_txt(60),3,15)                                                                               'Venatrix-BUS
    print_win(ram_txt(61),3,17)                                                                               'Sepia-Card
    Scan_Expansion_Card                                                                                       'nach Sepia-und Venatrix-Karte scannen
    Show_Card_ON_OFF                                                                                          'anzeigen, ob die Karten da sind

    rahmen(21,13,33,18)                                                                                       'noch leerer Rahmen
    print_win_rev(string("Flash-Rom"),22,13)

    if (a:=ios.flashsize)>0
       print_win(string("CAP :"),22,17)
       a/=$100000
       printdec_win(a,17,27)
       print_win(string("MB"),31,17)
       print_win(string("CHIP:"),22,15)
       print_win(string("W25X"),27,15)

       printdec_win(a*8,15,31)
    else
       print_win(string("none"),22,15)

    button(1,@butOK,10,20)
    button(2,@Abbr,20,20)

PRI Scan_Expansion_Card|ackn,adr,counter_s,counter_V

'######################################################################################################
'#   Durch diverse Versuche hat sich herausgestellt, das die Ping-Funktion allein nicht ausreicht um  #
'#   das Vorhandensein der Sepia oder Venatrix-Karte zu detektieren, da eine nicht angeschlossene     #
'#   eine Null zurückgibt, genauso wie ein angeschlossener I2C-Teilnehmer. Deshalb wird beim Scan die #
'#   Anzahl Nullen mit der Gesamtanzahl der Adressen verglichen. Ist die Anzahl zurückgegebener Nullen#
'#   mit der Anzahl Adressen identisch, so ist offensichtlich keine Karte vorhanden. Diese Methode    #
'#   verhindert Fehldetektionen und gerade in Verbindung mit der Venatrixkarte ein Festfahren des HIVE#
'#   zum Beispiel bei Aufruf der Cog-Anzeige.                                                         #
'######################################################################################################

    ios.plxHalt
       Sepia:=0
       'venatrix:=0
       counter_s:=0
       counter_v:=0
       repeat adr from 32 to 79                                                                               'standard-Sepia-Adressbereich $20-$4f
              ackn := ios.plxping(adr)

              ifnot ackn
                    counter_s++                                                                               'Anzahl der vorhandenen I2C-Teilnehmer

       'repeat adr from 0 to 5
       '       if ios.plxping(adr)
       '          counter_v++

    ios.plxRun
    if counter_s <47
       sepia:=1
'    if counter_v==5
'       Venatrix:=1

PRI Show_Card_ON_OFF
    if sepia==0
       print_win(@off,16,17)
    else
       print_win(@on,16,17)

    'if venatrix==0
       print_win(@off,16,15)
    'else
    '   print_win(@on,16,15)

con '********************************************** Verwaltung der Desktopverknüpfungen ******************************************************************************************
PRI Make_link(dm)|i,n                                                                                         'Desktopverknüpfung erzeugen
    bytemove(@textline,@filestring,12)                                                                        '@filestring merken
    repeat i from 0 to 2                                                                                      'Test auf freie Position
         get_link(LINK_RAM,i,1)                                                                                 'Link holen
         if strsize(@filestring)<1                                                                            'Position frei?
            link_pointer:=i                                                                                   'dann diese Position verwenden
            quit
    bytemove(@filestring,@textline,12)                                                                        'Kopie von @filestring zurückschreiben
    n:=link_pointer*13                                                                                        'Stringposition in @link_string
    SHOW_LINK(n)                                                                                              'Link auf dem Desktop anzeigen
    WriteDmpToRam(LINK_RAM,@filestring,dm,link_pointer)                                                       'im Link_ram merken
    link_marker[link_pointer]:=dm                                                                             'Verzeichnismarker speichern
    inisave                                                                                                   'Link in Ini-Datei speichern

    link_pointer++                                                                                            'Link-Zähler erhöhen
    link_counter++
    if link_counter>3
       link_counter:=3
    if link_pointer>2                                                                                         'nur 3 Links sind gestattet (0-2)
       link_pointer:=0


PRI LINK_START(numm)|nu
    ifnot Checkmount
          nu:=0
          activate_dirmarker(link_marker[numm])                                                                'Verzeichnis öffnen
          cmd_dir                                                                                             'Verzeichnis einlesen
          GET_LINK(LINK_RAM,numm,1)                                                                              'Link holen
          ios.paracopy(PARA_RAM+(numm*64))                                                                     'Parameter in den System-Parameter-Ram kopieren
          scanstr(@filestring,1)                                                                              'Dateiendung scannen

          repeat dmpfiles                                                                                     'Wenn Song, dann Songnummer ermitteln
                 getdmpname(nu++)
                 if strcomp(@dumpstring,@filestring)                                                          'Dateiname mit Dumpfiles vergleichen
                    dumpnummer:=nu                                                                            'Nummer des Songs an dumpnummer übergeben
                    quit
          if strsize(@filestring)>0
             FILE_START                                                                                       'Link starten

PRI LINK_PARAMETERS(i)
    infofenster(2,10,31,15,ram_txt(59),1)                                                                     'Infofenster mit OK-Knopf anzeigen
    printfont(@filestring,Titelhcol,0,Titeltextcol,20,8)                                                      'verlinkte Datei in Titelleiste anzeigen
    rahmen(2,9,31,13)
    util:=13
    Display_Param(3,10,i)

PRI DISPLAY_PARAM(tx,ty,n)|c,txtmp,a
    txtmp:=tx
    a:=PARA_RAM+(n*64)
    repeat while c:=ios.ram_rdbyte(a++)

           if tx==30 or c==10                                                                                 'zeilenumbruch bei spalte 30 oder bei linefeed
              tx:=txtmp
              ty+=1
           if c==10 or c==13                                                                                  'return oder linefeed nicht als zeichen anzeigen
              next
           Grossbuchstabe(c,ty,tx++)

PRI FILL_LINK                                                                                                 'Link-Parameter füllen

    link_marker[0]:=ios.ram_rdlong(LINK_RAM+$0C)
    link_marker[1]:=ios.ram_rdlong(LINK_RAM+$1D)
    link_marker[2]:=ios.ram_rdlong(LINK_RAM+$2E)
    Plot_Link

PRI DISPLAY_LINK(numm)
    GET_LINK(LINK_RAM,numm,1)                                                                                    'string holen
    if strsize(@filestring)>0                                                                                 'Link gültig?
       SHOW_LINK(numm*13)                                                                                      'an entsprechender Position anzeigen
       link_counter++

PRI PLOT_LINK|i
    repeat i from 0 to 2
            DISPLAY_LINK(i)

PRI GET_LINK(basis,numm,mode)|n,c,adr,i                                                                 'Link-String aus e-ram holen
    i:=0
    n:=numm*17
    if mode
       link_pointer:=numm
    adr:=basis+n
    repeat while (c:=ios.ram_rdbyte(adr++))>32' from 0 to 11
          filestring[i++]:=c
    filestring[i]:=0

PRI SHOW_LINK(n)|p                                                                                            'Link auf dem Desktop anzeigen

    scanstr(@filestring,1)
    bytemove(@link_string[n],@filestring,5)
    p:=get_pic(@buff)
    ios.displaytile(p,shellhcol,0,act_color,8+(link_pointer*5),37)
    printfont(@link_string[n],shellhcol,0,act_color,35,9+(link_pointer*5))

PRI Delete_Link(n,y)|i,a
    bytefill(@link_string[n*13],0,12)                                                                         'Link-String löschen
    link_marker[n]:=-1                                                                                        'Link-Verzeichnismarker löschen
    ios.displaytile(16,shellhcol,0,0,y,37)                                                                    'Linksymbol auf dem Desktop löschen
    printfont(string("     "),shellhcol,0,0,35,y+1)                                                           'Linkname auf dem Desktop löschen
    link_pointer:=n
    a:=LINK_RAM+(n*17)                                                                                        'Adresse im eRam
    repeat i from a to a+16
           ios.ram_wrbyte(0,i)                                                                                'im Link_ram löschen
    a:=PARA_RAM+(n*64)
    repeat i from a to a+63
           ios.ram_wrbyte(0,i)
    inisave                                                                                                   'in Ini-Datei speichern
    link_counter--
    if link_counter<1
       link_counter:=0

pri LinkPos(p)                                                                                                'Position des angeklickten Links ermitteln
    if p>2                                                                                                    'ist i>2 dann ist entweder das 2. oder 3. Symbol angeklickt worden
       p-=4                                                                                                   '4 abziehen
    if p>2                                                                                                    'ist i jetzt immer noch grösser 2, dann wurde das 3.Symbol angeklickt
       p-=4                                                                                                   '4 abziehen so ergibt sich eine Zahl von 0-2 für Link 0-2
    return p

con '**************************************** Serielles Terminal *****************************************************************************************************************
PRI Terminal
    Programmfenster(4,ram_txt(49))
    ios.seropen(bdselect(system_setting[0]))'(31, 30, 0, bdselect(baud))
    serial:=1

PRI baudselect(rate)|bd,i
    window(1,4,5,10,17,22,ram_txt(50))
    button(1,@butOK,10,17)
    button(2,@Abbr,17,17)
    print_win(string("CR:  LF:"),10,5)
    if CR_FLAG
       WIN_TILE(139,5,13)
    else
       WIN_TILE(140,5,13)
    if LF_FLAG
       WIN_TILE(139,5,17)
    else
       WIN_TILE(140,5,17)
    repeat i from 6 to 14
          bd:=bdselect(i-6)
          printdec_win(bd,i,13)
    WIN_TILE(46,6+rate,12)
    if echo_on
       WIN_TILE(139,15,21)
    else
       WIN_TILE(140,15,21)
    print_win(string("Local-Echo:"),10,15)

PRI bdselect(bauds):bd
    bd:=lookupz(bauds:300,600,1200,4800,9600,19200,38400,57600,115200)


PRI Text_Input(ser,min_x,max_x,min_y,max_y,mode,adr,ch):ausg|k,ii,x,y,serchar,blck,inp,adr_tmp,w,kl,tmp
    {{#######################################################
      ser=serielle Schnittstelle verwenden
      mode=1 - Terminal      mode=0 - Texteingabefeld
      adr=Adresse Parameter-Ram      adr=0 normales Textfeld
      ch=maximale Anzahl Zeichen
      #######################################################
      }}
    ii:=0
    blck:=0
    adr_tmp:=adr+1                                                                                            'Adresse merken
    tmp:=adr
    inp:=0                                                                                                    'Eingabe Merker, wird aktiviert, wenn was verändert wurde
    zeile:=min_y
    spalte:=min_x
    do_restore:=1                                                                                             'Hintergrund muss wieder hergestellt werden

             WIN_TILE(6,zeile,spalte)                                                                         'Eingabe-Cursor

             repeat
                 time                                                                                         'Zeitaktualisierung
                 k:=ios.key
                 ma:=ios.mouse_button(0)

                 if ser
                    serchar:=ios.serread'com.rxcheck                                                          'Zeichen von der com. Schnittstelle lesen
                 if k==27 or ma                                                                               'Abbruch mit ESC
                    x:=ios.mousex
                    y:=ios.mousey
                    kl:=ios.get_window//10                                                                    'Icon-Button-Nummer des Fensters
                    if (kl==1) or (kl==2)  or (k==27)                                                         'Abfrage auf Fensterloeschen
                          if ser                                                                              'Terminalfenster
                             fensterweg
                             ios.serclose
                             serial:=0
                          else
                             Close_Window(2)                                                                  'Eingabefenster
                          quit

                    if(x=>buttonx[4]) and (x=<buttonx[4]+5) and (y==buttony[4])                               'ok im Infofenster
                      buttonpress(4)
                      Close_Window(2)
                      buttonweg                                                                               'Button muss extra gelöscht werden, sonst Fehldarstellungen
                      ausg:=13
                      quit

                 if mode
                                                                                                              'Terminal-Modus
                    if k==13 or serchar==13                                                                   'Return? dann neue Zeile
                       if echo_on or serchar==13                                                              'Zeichen nur zeigen,wenn echo_on=1
                          zeile++
                          spalte:=min_x
                          WIN_TILE(6,zeile,spalte)
                    if ser
                       if k==13                                                                                'Return von Tastatur? -> zur Schnittstelle senden
                          if CR_FLAG
                             ios.sertx($0D)                                                                      'CR
                          if LF_FLAG
                             ios.sertx($0A)                                                                     'manche Terminalprogramme brauchen das LF
                 else
                     if k==13
                        ausg:=13
                        quit


                 if k==ios#BEL_BS or serchar==ios#BEL_BS                                                    'Backspace
                    if ii>0
                       if spalte<min_x+1
                          spalte:=max_x
                          zeile--
                       if zeile<min_y+1
                          zeile:=min_y
                       if k==ios#BEL_BS
                          if ser
                             ios.sertx(k)'com.tx(k)

                       WIN_TILE(16,zeile,spalte--)                                                            'Zeichen hinter dem Cursor löschen
                       if spalte>min_x or (spalte==min_x and zeile==min_y)
                          WIN_TILE(6,zeile,spalte)                                                            'Cursor einen Schritt zurück
                       else
                          WIN_TILE(16,zeile,spalte)                                                           'Leerzeichen
                       ifnot mode                                                                             'Bei Texteingabefeld Zeichenanzahl verringern
                             adr--
                       inp:=1                                                                                 'Text wurde verändert
                       ii--
                 if k>13 or (serchar>13 and ser==1)                                                           'Alle Zeichen außer Return
                    ii++
                    ifnot mode                                                                                'maximale Zeichenanzahl erreicht
                      if ii>ch-1
                         ii:=ch                                                                               'Zeichenanzahl nicht mehr erhöhen
                         blck:=1                                                                              'feste Zeichenanzahl-merker

                    if k                                                                                      'Zeichen von Tastatur
                       if echo_on or mode==0                                                                  'Zeichen nur anzeigen wenn echo_on=1 oder kein Terminalmode
                          Grossbuchstabe(k,zeile,spalte)
                          if spalte+1<max_x
                             WIN_TILE(6,zeile,spalte+1)                                                          'Eingabemarker weiterrücken
                          ifnot blck                                                                             'ist die maximale Zeichenanzahl erreicht, wird nicht weitergeschrieben
                                spalte++
                                adr++
                          inp:=1                                                                                 'Text wurde verändert

                       ifnot mode
                             if tmp>0                                                                         'Zeichen in den Ram schreiben
                                ios.ram_wrbyte(k,adr)
                             else
                                textline[adr-1]:=k                                                            'Text in String schreiben
                       if ser
                          ios.sertx(k)
                    elseif serchar                                                                            'Zeichen von der com. Schnittstelle
                       Grossbuchstabe(serchar,zeile,spalte++)

                    if spalte>max_x                                                                           'Zeilenumbruch bei Spalte max x
                       if tmp==0 and ser==0                                                                   'normale Texteingabe in String (Rename)
                          spalte:=max_x                                                                       'an letzter Position bleiben
                       else
                          spalte:=min_x                                                                       'Text in Ram schreiben (Parameter)
                          zeile++                                                                             'neue Zeile


                 if zeile==max_y+1                                                                            'letzte Zeile erreicht, dann eine Zeile hochscrollen
                    if mode
                       ios.scrollup(1,winhcol, min_y, min_x, max_y, max_x,1)
                    zeile:=max_y                                                                              'Zeilennummer wieder auf max_y setzen

    if inp and ausg==13                                                                                       'neue Eingabe-Daten
       ifnot mode                                                                                             'Texteingabefenster
             if tmp>0                                                                                         'Parameter-Modus
                w:=64-ii
                ios.ram_fill(adr_tmp+ii,w,0)                                                                  'rest löschen
             else
                textline[adr]:=0                                                                              'normaler Text-Modus, String abschliessen


con '************************************** Systeminfo-Programms-Fenster *******************************************************************************************************************

PRI Sysinfo
    window(1,4,5,5,24,31,ram_txt(51))
    tab(1,5,6,6)                                                                                              'tabnummer,textlänge,x-pos,y-pos)
    bytemove(@buttontext[5*6],string("Video"),5)
    button(5,@buttontext[5*6],7,6)
    tab(2,5,13,6)
    bytemove(@buttontext[6*6],string("Sound"),5)
    button(6,@buttontext[6*6],14,6)
    tab(3,4,20,6)
    bytemove(@buttontext[7*6],string("Font"),4)
    button(7,@buttontext[7*6],21,6)
    tabframe(1,5,31,24)
    button(1,@butOK,15,24)

PRI Programms                                                                                                 'Fenster für Zusatzprogramme
    Programmfenster(4,@programs)
'####################################### 1.Zeile #############################
    printdec_win(1,4,3)
    display_icon(19,162,winhcol,panelcol,4,4)
    print_win(string("Sepia"),2,5)
    print_win(string("I/O"),3,6)
    'printdec_win(2,4,10)
    'display_icon(20,162,winhcol,panelcol,4,11)
    'print_win(string("Venatrix"),8,5)
    'print_win(string("Test"),10,6)
    printdec_win(3,4,17)
    display_icon(21,160,winhcol,panelcol,4,18)
    print_win(string("Shell"),17,5)
    'printdec_win(4,4,24)
    'iconbutton(13,170,25,4)
    'print_win(string("DCF77"),23,5)
'######################################## 2.Zeile ############################
    printdec_win(5,8,3)
    iconbutton(14,169,4,8)
    print_win(string("Blue-"),2,9)
    print_win(string("tooth"),2,10)

    printdec_win(6,8,10)
    iconbutton(15,113,11,8)
    print_win(string("Font-"),9,9)
    print_win(string("Edit"),9,10)

    printdec_win(7,8,17)
    display_icon(22,162,winhcol,panelcol,8,18)
    print_win(string("Wave-"),17,9)
    print_win(string("Gen."),17,10)

    printdec_win(8,8,24)
    display_icon(23,162,winhcol,panelcol,8,25)'iconbutton(16,168,25,8)
    print_win(string("PLEX-"),23,9)
    print_win(string("IRC"),24,10)

'######################################## 3.Zeile ############################
    printdec_win(9,12,3)
    display_icon(24,158,winhcol,panelcol,12,4)'iconbutton(24,159,4,12)
    print_win(string("MEM-"),3,13)
    print_win(string("EDIT"),3,14)

'    print_win(string("A"),10,12)
'    display_icon(25,96,winhcol,panelcol,12,11)'iconbutton(24,159,4,12)
'    print_win(string("FLASH"),9,13)
'    print_win(string("UPDATE"),9,14)

'    print_win(string("B"),17,12)
'    display_icon(26,98,winhcol,panelcol,12,18)'iconbutton(24,159,4,12)
'    print_win(string("TRIOS"),17,13)
'    print_win(string("BASIC"),17,14)

pri Show_Help                                                                                                 'Hilfefenster anzeigen
    Programmfenster(4,@Help)
    util:=12
    textdisplay(2,2,4,hlptxt)

PRI Programmfenster(mode,strg)
    window(1,mode,4,2,25,33,strg)

PRI tab(numm,l,x,y)                                                                                            'Registerzunge anzeigen L ist die Textlänge

    tabx[numm]:=x
    taby[numm]:=y
    tabl[numm]:=x+1+l

    ios.displaytile(165,0,winhcol,buttonhcol,y,x)
    ios.displaytile(164,0,winhcol,buttonhcol,y,x+1+l)

PRI tabframe(numm,wx,xx,yy)|i                                                                                  'Rahmen für Tabulatorfenster erstellen

    repeat i from taby[numm]+2 to yy-2                                                                         'rechter und linker Rand
          FRAME_TILE(2,i,wx)
          FRAME_TILE(114,i,xx)
    FRAME_TILE(136,yy-1,wx)
    FRAME_TILE(119,yy-1,xx)

    repeat i from wx+1 to xx-1                                                                                'oberer Rand bis Tab und ab Tab
           if i=>tabx[numm] and i=< tabl[numm]
              FRAME_TILE(16,taby[numm]+1,i)
           else
              FRAME_TILE(148,taby[numm]+1,i)

           FRAME_TILE(130,yy-1,i)

    FRAME_TILE(146,taby[numm]+1,wx)
    FRAME_TILE(147,taby[numm]+1,xx)

PRI clear_tabframe
    ios.display2dbox(winhcol,windowy[1]+5,windowx[1]+2,windowyy[1]-3,windowxx[1]-2,0)

con '************************************************ About-Box ******************************************************************************************************************
PRI about
    window(1,4,8,6,18,31,string("About"))
    'print_info(prgnfo,6,8)
    textdisplay(2,6,8,prgnfo)
    button(1,@butOK,16,18)
    util:=0
con '************************************************ Clock-Settings ******************************************************************************************************************

PRI Clock|i
    window(1,4,8,8,18,28,ram_txt(52))
    print_win(ram_txt(64),16,7)
    tag:=ios.getdate
    monat:=ios.getmonth
    Jahr:=ios.getyear
    stunde:=ios.gethours
    minute:=ios.getminutes
    sekunde:=ios.getseconds
    i:=10
    repeat 3
       FRAME_TILE(5,9,i)
       FRAME_TILE(5,14,i)
       i+=3
       FRAME_TILE(3,9,i)
       FRAME_TILE(3,14,i)
       i+=3


    FRAME_TILE(3,9,27)
    print_win(ram_txt(65),16,12)

    button(1,@butOK,10,18)
    button(2,@Abbr,20,18)
    Date_refresh
    Clock_refresh

PRI clock_refresh
    print_zehner(Stunde,14,11,act_color,winhcol)
    print_zehner(Minute,14,17,act_color,winhcol)
    print_zehner(Sekunde,14,23,act_color,winhcol)
    wait(20000)                                                                                               'etwas warten, sonst ändern sich die Werte zu schnell

PRI date_refresh
    print_zehner(Tag,9,11,act_color,winhcol)
    print_zehner(Monat,9,17,act_color,winhcol)
    printdec_win(Jahr,9,23)
    wait(20000)                                                                                               'etwas warten, sonst ändern sich die Werte zu schnell

pri print_zehner(wert,y,x,vor,hin)|a                                                                          'Überprüfung Wert<10 dann führende Null anzeigen
    a:=0
    if wert<10
       printdec(0,y,x,hin,vor)
       a:=1
    printdec(wert,y,x+a,hin,vor)

PRI wait(ms)
    repeat ms
con '************************************************ Color-Einstell-Box ******************************************************************************************************************

PRI Color
    window(1,4,4,6,24,23,ram_txt(53))
    ios.Displaypalette(7,4)
    rahmen(18,8,22,10)
    print_win(ram_txt(66),14,9)
    printdec_win(shellhcol,9,19)
    refreshpaint
    WIN_TILE(46,9,6)
    button(1,@butOK,8,24)
    button(2,@Abbr,16,24)

PRI farbe(i,c)

    case i
         0:shellhcol:=c
         1:act_color:=c
         2:winhcol:=c
         3:winframecol:=c
         4:titelhcol:=c
         5:titeltextcol:=c
         6:hcolstatus:=c
         7:statustextcol:=c
         8:buttonhcol:=c
         9:buttontextcol:=c
        10:messagehcol:=c
        11:messagetextcol:=c
        12:selectcol:=c
        13:mousecol:=c
        14:panelcol:=c


pri get_farbe(n):c
    c:=lookupz(n:shellhcol,act_color,winhcol,winframecol,titelhcol,titeltextcol,hcolstatus,statustextcol{
                 },buttonhcol,buttontextcol,messagehcol,messagetextcol,selectcol,mousecol,panelcol)

PRI refreshpaint

        printfont(string("Back"),shellhcol,0,act_color,7,9)
        print_win(string("Text"),7,10)
        print_win(string("Window"),7,11)
        printfont(string("Winframe"),winhcol,0,winframecol,7,12)
        print_titel(string("Title"),7,13)
        print_titel(string("Titletext"),7,14)
        print_status(string("Statusback"),7,15)
        print_status(string("Statustext"),7,16)
        Print_button(string("Button"),7,17)
        Print_button(string("Buttontext"),7,18)
        print_message(string("Message"),7,19)
        print_message(string("Messagetext"),7,20)
        printfont(string("Select"),winhcol,0,selectcol,7,21)
        printfont(string("Mouse"),winhcol,0,mousecol,7,22)
        printfont(string("Panel"),shellhcol,0,panelcol,7,23)
        ios.DisplayMouse(1,mousecol)


con '************************************************ E-Ram-Monitor ******************************************************************************************************************

PRI RamDump(start)|i,a
    Programmfenster(6,ram_txt(54))
    a:=start
    print_win(@starts,2,4)
    printhex(start,adressraum+dump_ram,8,4,winhcol,act_color)
    print_win(ram_txt(68),17,4) 'e-ram
    print_win(ram_txt(81),25,4) 'flash
    WIN_TILE(140,4,23)
    WIN_TILE(140,4,31)

    if dump_ram==1
       WIN_TILE(139,4,31)
    else
       WIN_TILE(139,4,23)


    repeat i from 6 to 25
           dump(a,2,i,dump_ram)
           a+=8

PRI Dump(adr,x,y,mode) |c[8],a,i                                                                              'adresse, anzahl zeilen,ram oder xram

    a:=26
    printhex(adr,adressraum+dump_ram,x,y,winhcol,act_color)
    x+=6
    WIN_TILE(42,y,x)
    x++
    repeat i from 0 to 7
         if mode
            c[i]:=ios.Read_Flash_Data(adr++)'ram_rdbyte(adr++)
         else
            c[i]:=ios.ram_rdbyte(adr++)'byte[adr++]
         printhex(c[i],2,x++,y,winhcol,act_color)
         if c[i]>175 or c[i]<16
            c[i]:=46
         Grossbuchstabe(c[i],y,a++)
         x++

PRI Dumpadresse|k,sp,i,ok ,ad                                                                                 '***********Adresseingabe im E-Ram-Monitor****************
    sp:=8
    i:=0
    ad:=adressraum+dump_ram
    printhex(HEX_ADRESSE, ad,8,4,act_color,winhcol)                                                           'Eingabe revers darstellen

             repeat
                 k:=ios.key
                 if k>96
                    k&=CaseBit                                                                             'Buchstaben in große umwandeln
                 ma:=ios.mouse_button(0)
                 sp:=i+8
                 if k==13                                                                                     'Return? dann neue Zeile
                    ok:=1
                    textline[i++]:=0
                    quit
                 if k==27                                                                                     'Abbruch
                    ok:=0
                    quit
                 if k==ios#BEL_BS                                                                            'Backspace
                    if i>0
                       WIN_TILE(16,4,sp+1)
                       i--
                 if k=>"0" and k =< "9"  or k=>"A" and k=<"F"                                                 'Nur Zahlen 0-9 und A-F
                    WIN_TILE(k-16,4,sp)'sp++)
                    textline[i++]:=k
                    if i>ad                                                                                   'Adressraum-Eingrenzung Hubram 4-stellig, E-Ram 5-stellig
                       i:=ad

    if ok==1
       tp:= @textline
       HEX_ADRESSE:=gethexnumber
    ramdump(HEX_ADRESSE)
    startadresse:=HEX_ADRESSE
    endadresse:=HEX_ADRESSE+152
    scrollanfang:=startadresse/8
    scrollende:=endadresse/8


con '************************************************ Sid-Dmp-Player *************************************************************************************************************
PRI Player(n)|a
    window(1,4,8,8,13,27,ram_txt(55))
    iconbutton(10,BACK_PIC,8,13)
    a:=PLAY_PIC
    if play==1
       a:=STOP_PIC
    iconbutton(11,a,10,13)
    iconbutton(12,VOR_PIC,12,13)
    rahmen(8,7,16,9)
    rahmen(19,7,27,9)
    line(8,10,27)
    if ios.sid_dmppos>0
       dmp_name
    if dmpfiles>0
       getdmpname(n)
       dmp_name

pri Player_sichtbar
    if util==6 and windownum[1]==1                                                                            'Player sichtbar?
          dmp_name                                                                                            'Titelname anzeigen

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

PRI positionsbalken(pos,x,y)
    ios.display2dbox(act_color,y,x,y,x+pos,0)

PRI balkenleer
    ios.display2dbox(winhcol,11,9,11,27,0)
    print_win(string("0      "),9,8)

PRI abspielen(mode)
    ios.sdopen("R",@dumpstring)
    ios.sid_sdmpplay(@dumpstring)
    play:=1
    'if system_setting[5]                                                                                             'Statusleiste sichtbar?
    '   print_status(@dumpstring,14,29)
    if mode==1 and util==6                                                                                    'Playerfenster sichtbar
       balkenleer

PRI playsong(nu,mode)
    getdmpname(nu-1)
    if play==1
       playerstop
       abspielen(mode)
    elseif play==0
       playerstop

PRI playerstop
    ios.sid_dmpstop
    play:=0
    ios.sdclose

PRI getdmpname(nummer)|adress,position,c,z                                                                    'Dmp Datei-Name aus dem E-Ram holen
    position:=(nummer)*17
    adress:=DMP_RAM+position                                                                                  'Adresse Dateiname im eRam
    z:=0
    bytefill(@dumpstring,12,0)
    repeat 12
            c:=ios.ram_rdbyte(adress++)                                                                       'Dateiname aus Dir-Ram lesen
            dumpstring[z++]:=c
    dumpstring[z]:=0
    dmplen:=ios.ram_rdlong(adress++)/25

PRI dmp_name
       print_win(@dumpstring,15,13)
       print_win(string("       "),20,8)
       printdec_win(dmplen,8,20)

con '***************************************************** Unterprogramme für die Fensterverwaltung ******************************************************************************

PRI icon(numm,mode)|a

    if mode==1
       a:=panelcol
    else
       a:=grey
    case numm
         1:  icon_tile(10,a,4,36)                                                                             'SD-Card 'f1-30,f2-255,f3-0
             icon_tile(11,a,4,37)
             icon_tile(12,a,5,36)
             icon_tile(13,a,5,37)
         2:  icon_tile(153,a,23,36)                                                                           'Mülleimer leer 'f1-30,f2-255,f3-0
             icon_tile(154,a,23,37)
             icon_tile(151,a,24,36)                                                                           'Mülleimerunterteil
             icon_tile(152,a,24,37)
         3:  icon_tile(149,a,23,36)                                                                           'Mülleimer voll 'f1-30,f2-255,f3-0
             icon_tile(150,a,23,37)

PRI icon_tile(numm,mode_farbe,y,x)

    ios.displaytile(numm,shellhcol,mode_farbe,0,y,x)

PRI statusleiste
    ios.display2dbox(hcolstatus,29,0,29,4,0)
    ios.displaytile(144,shellhcol,hcolstatus,shellhcol,29,7)

    ios.displaytile(145,shellhcol,hcolstatus,shellhcol,29,32)
    ios.displaytile(16,hcolstatus,shellhcol,hcolstatus,29,33)
    ios.displaytile(16,hcolstatus,shellhcol,hcolstatus,29,34)

    print_status(@starts,0,29)


PRI panel
    ios.display2dbox(shellhcol,27,9,27,30,0)
    regal(shellhcol,panelcol,28{-system_setting[5]},13)

PRI shell|i
    ios.display2dbox(shellhcol,0,0,0,39,0)
    ios.displaytile(164,0,titelhcol,shellhcol,0,4)
    print_titel(string(" "),5,0)

    ios.displaytile(164,0,shellhcol,titelhcol,0,6)

    ios.displaytile(164,0,titelhcol,shellhcol,0,7)
    ios.display2dbox(titelhcol,0,8,0,31,0)
    ios.displaytile(165,0,titelhcol,shellhcol,0,32)
    print_titel(string("PLEXUS"),8,0)
    print_titel(@version,15,0)
    ios.displaytile(165,0,shellhcol,titelhcol,0,33)
    ios.displaytile(166,titelhcol,winhcol,winframecol,0,34)
    ios.displaytile(165,0,titelhcol,shellhcol,0,35)

    '########Unterleiste für Temp-Anzeige###############
    {if venatrix
       ios.displaytile(164,0,titelhcol,shellhcol,1,11)
       ios.displaytile(165,0,titelhcol,shellhcol,1,28)
       repeat i from 12 to 27
              ios.displaytile(16,titelhcol,0,shellhcol,1,i)}
    '###################################################
    'status_onoff

{pri status_onoff

    if system_setting[5]
       show_keyscan
       ios.display2dbox(hcolstatus,29,9,29,30,0)
       ios.displaytile(145,hcolstatus,shellhcol,0,29,31)
       ios.displaytile(144,hcolstatus,shellhcol,0,29,8)
       print_status(@filestring,14,29)
    else
       ios.display2dbox(shellhcol,29,8,29,31,0)
    panel
}

{pri del_keyscan
    shell
    date
}
{pri show_keyscan
    ios.displaytile(164,0,titelhcol,shellhcol,0,0)
    ios.display2dbox(titelhcol,0,1,0,4,0)
    ios.displaytile(165,0,titelhcol,shellhcol,0,39)
    ios.display2dbox(titelhcol,0,35,0,38,0)
}
PRI Regal(f1,f2,y,x)|i,c
    ios.displaytile(112,f1,f2,0,y,12)
    ios.displaytile(115,f1,f2,0,y,27)

    ios.displaytile(128,shellhcol,panelcol,0,y+1,12)
    repeat i from 13 to 26
           ios.displaytile(132,shellhcol,panelcol,0,y+1,i)
    ios.displaytile(131,shellhcol,panelcol,0,y+1,27)

    c:=x
    x:=display_icon(0,78,f1,f2,y,x)
    x:=display_icon(1,108,f1,f2,y,x)
    x:=display_icon(2,110,f1,f2,y,x)
    x:=display_icon(3,126,f1,f2,y,x)
    x:=display_icon(4,142,f1,f2,y,x)
    x:=display_icon(5,158,f1,f2,y,x)
    x:=display_icon(6,174,f1,f2,y,x)

PRI display_icon(ic,inr,f1,f2,y,x):xx
    ios.displaytile(inr,f1,f2,0,y,x)
    ios.displaytile(inr+1,f1,f2,0,y,x+1)
    if ic<9 or ic>18                                                                                          'Icon-Nr <9 und >18 werden die Koordinaten gemerkt
       iconx[ic]:=x
       icony[ic]:=y
       iconnr[ic]:=inr
       iconf1[ic]:=f1
       iconf2[ic]:=f2
    xx:=x+2

PRI window(numm,cntrl,y,x,yy,xx,strg)                                                                          'ein Fenster erstellen
    windowx[numm]:=x-1
    windowy[numm]:=y-2
    windowxx[numm]:=xx+1
    windowyy[numm]:=yy+1

               'Nr,Vord,hint,curs,framecol
    ios.window(numm,0,winhcol,0,winframecol,titelhcol,titeltextcol,titelhcol{hcolstatus,statustextcol},titeltextcol,y-2,x-1,yy+1,xx+1,cntrl,0)

    ios.printcursorrate(0)
    ios.printchar(12)                    'cls
    windownum[numm]:=1
    print_titel(strg,x+1,y-2)


PRI infofenster(x,y,xx,yy,strg,knopf)'|i

    ios.backup_area(x-1,y-2,xx+1,yy+1,bram)                                                                   'Hintergrund sichern
    window(2,4,y,x,yy,xx,strg)                                                                                'Fenster erstellen
    if knopf==1
       button(4,@butOK,((xx-x)/2)+x-2,yy)                                                                     'Button 4 gibt es nur im SD-Card-Info-Fenster und im LINK-Parameter-Fenster
    if knopf==2
       button(2,@Abbr,((xx-x)/2)+x-2,yy)
    infomarker:=1

con '*************************************************** Start- und Popup-Menue *************************************************************************************************************

PRI popup(x,y,xx,yy)
    ios.backup_area(x,y,xx,yy,BRAM)
    ios.display2dbox(messagehcol,y,x,yy,xx,0)
    popupx:=x
    popupy:=y
    popupyy:=yy
    popupxx:=xx
    popupmarker:=1

PRI popup_entry(numm,strg,sep)
    if sep==1
       separator(popupx,popupy+numm,popupx+6)
       numm+=1
       print_message(strg,popupx,popupy+numm)
    print_message(strg,popupx,popupy+numm)

PRI Popup_Info_weg

          if infomarker==1                                                                                    'Infofenster sichtbar?
             if do_restore                                                                                    'Infofensterhintergrund wieder herstellen?
                ios.restore_area(windowx[2],windowy[2],windowxx[2],windowyy[2],bram)                          'Hintergrund wiederherstellen
             infomarker:=0                                                                                    'Marker loeschen
             windownum[2]:=windowx[2]:=windowy[2]:=windowxx[2]:=windowyy[2]:=-1                               'Windowwerte loeschen
             ios.windel(2)
          if popupmarker==1                                                                                   'Popupmenue sichtbar?
             ios.restore_area(popupx,popupy,popupxx,popupyy,bram)                                             'Hintergrund wiederherstellen
             popupmarker:=0                                                                                   'Popupmarker loeschen
             menuemarker:=0
          link_merker:=0

PRI popupselect(stri,x,y)

    printfont(stri,messagetextcol,0,messagehcol,x,y)
    Mouse_Release
    print_message(stri,x,y)
    popup_info_weg

PRI separator(x,y,xx)|i
    repeat i from x to xx
         ios.displaytile(6,Messagehcol,0,winframecol,y,i)

con '************************************************** Button-Funktionen ********************************************************************************************************

PRI button(n,btext,x,y)
    print_button(btext,x,y)
    buttonx[n]:=x
    buttony[n]:=y

PRI buttonpress(n)|s
    s:=0
    case n
             1: printfont(@butOK,250,0,0,buttonx[n],buttony[n])
             2: printfont(@Abbr,250,0,0,buttonx[n],buttony[n])
             3: printfont(@starts,250,0,0,0,29)
                ios.displaytile(144,shellhcol,250,shellhcol,29,7)

                'ios.displaytile(164,0,shellhcol,250,29,7)
                s:=1
             4: printfont(@butOK,250,0,0,buttonx[n],buttony[n])

       5,6,7,8:ios.displaytile(165,0,winhcol,250,taby[n-4],tabx[n-4])
               printfont(@buttontext[n*6],250,0,0,buttonx[n],buttony[n])
               ios.displaytile(164,0,winhcol,250,taby[n-4],tabl[n-4])
               s:=2


    Mouse_Release
    case s
         1:print_status(@starts,0,29)
           'ios.displaytile(164,0,shellhcol,hcolstatus,29,7)
           ios.displaytile(144,shellhcol,hcolstatus,shellhcol,29,7)


         2:ios.displaytile(165,0,winhcol,buttonhcol,taby[n-4],tabx[n-4])                                      'tab wiederherstellen
           print_button(@buttontext[n*6],buttonx[n],buttony[n])
           ios.displaytile(164,0,winhcol,buttonhcol,taby[n-4],tabl[n-4])

PRI abfrage:taste|a,x,y,k
    repeat
      a:=ios.mouse_button(0)
      k:=ios.key
      if a==255 or k==27 or k==13
         x:=ios.mousex
         y:=ios.mousey

         if((x=>buttonx[1]) and (x=<buttonx[1]+5) and (y==buttony[1]))or k==13                                'ok
            buttonpress(1)
            taste:=1
            quit
         if((x=>buttonx[2]) and (x=<(buttonx[2]+6)) and (y==buttony[2]))or k==27                              'cancel
            buttonpress(2)
            taste:=0
            quit
    fensterweg
    ios.display2dbox(shellhcol, 10, 7, 17, messagex,0)
con '*********************************************** Fenster-Lösch-Funktionen ****************************************************************************************************
PRI windowloesch                                                                                              'einzelnes Fenster löschen

    popup_info_weg                                                                                            'Popup-oder Infofenster loeschen
    ios.display2dbox(shellhcol, 2, 1, 26, 34,0)                                                               'Fenster loeschen
    windownum[1]:=windowx[1]:=windowy[1]:=windowxx[1]:=windowyy[1]:=-1                                        'Windowwerte loeschen
    ios.windel(1)
    'printdec_win(util,1,1)
    if util==4
       Load_ini_in_ram
       'iniload                                                                                                'eventuell geänderte Farben wiederherstellen
       bildschirmaufbau
    muelleimer:=0
    util:=0                                                                                                   'Utilitie-Marker löschen
    buttonweg                                                                                                 'Button-löschen

PRI Close_window(win)

    if win==2 or infomarker==1
       popup_info_weg
    else
       windowloesch
    copy_marker:=0                                                                                            'Kopier-Marker beim Schließen löschen
    if serial
       ios.serclose'com.stop                                                                                              'serielle Schnittstelle schliessen
       serial:=0

PRI fensterweg                                                                                                'alle gesetzten Fenster loeschen
    windowloesch
    Buttonweg

pri Buttonweg|i
    repeat i from 0 to 7
            buttonx[i]:=-1
            buttony[i]:=-1

con '************************************************* Textaus-und Eingabe ***************************************************************************************************************

PRI textdisplay(mode,xx,yy,ad)|tx,tt,c,x,adr,b                                                                         '********* Text-oder Hex-Ausgabe
                         'if mode<>2
                         ios.sdopen("R",@filestring)
                         tx:=xx
                         tt:=yy
                         adr:=0
                         repeat

                                if mode==0 or mode==2                                                                   'Mode 0= Textausgabe
                                  if mode==0
                                     if ios.sdeof
                                        quit
                                     c:=ios.sdgetc
                                  else
                                     c:=ios.ram_rdbyte(ad++)'Read_Flash_Data(ad++)
                                     ifnot c                                                                  'Textende im Ram
                                        quit
                                  if tx==34 or c==10                                                          'zeilenumbruch bei spalte 30 oder bei linefeed
                                     tx:=xx
                                     tt+=1
                                  if c==10 or c==13                                                           'return oder linefeed nicht als zeichen anzeigen
                                     next


                                if tt>25                                                                      'bis Zeile 24
                                   repeat
                                          ma:=ios.mouse_button(0)
                                          b:=ios.key
                                          if ios.get_window//10==2 or b==27
                                              windowloesch                                                    'Textfenster löschen
                                              if mode<>2
                                                 ios.sdclose
                                              return
                                   until ma==255 or b==32                                                     'warten bis maustaste oder Space gedrückt

                                   ios.printchar(12)
                                   tt:=yy
                                   tx:=xx
                                if mode==1                                                                   'Mode=1 Ausgabe im Hexformat
                                       if ios.sdeof
                                          quit
                                       printhex(adr,5,tx,tt,winhcol,act_color)
                                       tx+=5
                                       WIN_TILE(42,tt,tx)
                                       tx++
                                       x:=tx+17
                                       repeat 8
                                            c:=ios.sdgetc
                                            printhex(c,2,tx++,tt,winhcol,act_color)
                                            if c>175 or c<16                                                   'Zeichencode ausserhalb darstellbarer Zeichen
                                               c:=46
                                            Grossbuchstabe(c,tt,x++)
                                            tx++
                                            adr++
                                       tx:=xx
                                       tt+=1
                                else
                                   Grossbuchstabe(c,tt,tx)
                                   tx++
                         if mode<>2
                            ios.sdclose

PRI Grossbuchstabe(n,y,x)
    if n>96                                                            'in Großbuchstaben umwandeln
       n&=!32
    n-=16
    WIN_TILE(n,y,x)

PRI printfont(str1,a,b,c,d,e)|f

    repeat strsize(str1)
         f:= byte[str1++]
         if f>96
            f&=!32
         if d>39                                                                                              'wenn Bildschirmrand erreicht, neue Zeile
            d:=0
            e++
         ios.displayTile(f-16,a,b,c,e,d)                                                                         'einzelnes Tile anzeigen   ('displayTile(tnr,pcol,scol,tcol, row, column))
         d++
    return d

PRI printdec(value,y,xx,hint,vor) | i ,c ,x                                                                   'screen: dezimalen zahlenwert auf bildschirm ausgeben

  i := 1_000_000_000
  repeat 10                                                                                                   'zahl zerlegen
    if value => i
      x:=value / i + "0"
      ios.displayTile(x-16,hint,0,vor,y,xx)
      xx++
      c:=value / i + "0"
      value //= i
      result~~
    elseif result or i == 1
      printfont(string("0"),hint,0,vor,xx,y)
      xx++
    i /= 10                                                                                                   'nächste stelle

PRI getHEXNumber | c, t
         c := byte[tp]
         if (t := hexDigit(c)) < 0
            return                                                                                            '("invalid hex character")
         result := t
         c := byte[++tp]
         repeat until (t := hexDigit(c)) < 0
            result := result << 4 | t
            c := byte[++tp]

pri getnumber |c
         c := byte[tp]
         result := c - "0"
         c := byte[++tp]
         repeat while c => "0" and c =< "9"
            result := result * 10 + c - "0"
            c := byte[++tp]

PRI hexDigit(c)
                                                                                                              'Convert hexadecimal character to the corresponding value or -1 if invalid.
   if c => "0" and c =< "9"
      return c - "0"
   if c => "A" and c =< "F"
      return c - "A" + 10
   if c => "a" and c =< "f"
      return c - "a" + 10
   return -1

PRI printhex(value, digits,x,y,back,vor)|wert                                                                 'screen: hexadezimalen zahlenwert auf bildschirm ausgeben

  value <<= (8 - digits) << 2
  repeat digits
    wert:=lookupz((value <-= 4) & $F : "0".."9", "A".."F")
    ios.displaytile(wert-16,back,0,vor,y,x++)

con '---------------------------------------------- Ausgaberoutinen ---------------------------------------------------------------------------------------------------------------
PRI Win_Tile(nu,ty,tx)
    ios.displaytile(nu,winhcol,0,act_color,ty,tx)

PRI FRAME_TILE(nu,ty,tx)
    ios.displaytile(nu,winhcol,0,winframecol,ty,tx)

PRI TITEL_TILE(nu,ty,tx)
    ios.displaytile(nu,titelhcol,0,titeltextcol,ty,tx)

PRI print_win(stradr,x,y)
    printfont(stradr,winhcol,0,act_color,x,y)

PRI print_shell(stradr,x,y)
    printfont(stradr,shellhcol,0,act_color,x,y)

PRI print_win_rev(stradr,x,y)                     'reverse Darstellung
    printfont(stradr,act_color,0,winhcol,x,y)

PRI print_titel(stradr,x,y):a
    a:=printfont(stradr,titelhcol,0,titeltextcol,x,y)

PRI Print_button(stradr,x,y)
    printfont(stradr,buttonhcol,0,buttontextcol,x,y)

PRI print_status(stradr,x,y):a
    a:=printfont(stradr,hcolstatus,0,statustextcol,x,y)

PRI print_message(stradr,x,y)
    printfont(stradr,messagehcol,0,messagetextcol,x,y)

PRI printdec_win(n,y,x)
    printdec(n,y,x,winhcol,act_color)

PRI printdec_shell(n,y,x)
    printdec(n,y,x,shellhcol,act_color)

PRI printdec_win_revers(n,y,x)
    printdec(n,y,x,act_color,winhcol)

PRI printdec_titel(n,y,x)
    printdec(n,y,x,titelhcol,titeltextcol)

con '**************************************************** diverse Hilfsunterprogramme ********************************************************************************************

PRI wert_plusminus(op,wertx,minwert,maxwert)                                                                  'op=operation +/- 1/2 ,aktueller wert, mindestwert,maxwert
    case op
         1:wertx++
           if wertx>maxwert
              wertx:=minwert
         2:wertx--
           if wertx<minwert
              wertx:=maxwert

    return wertx


PRI printbin(value, digits,f1,f2,f3,x,y) |c                                                                   'screen: binären zahlenwert auf bildschirm ausgeben

  value <<= 32 - digits
  repeat digits
     c:=(value <-= 1) & 1 + "0"
     ios.displaytile(c-16,f1,f2,f3,y,x++)


PRI Poke_Ram(x,y):inp                                                                                         'Werte im E-Ram aendern
    x-=8
    y-=6
    inp:=startadresse+(x/2)+(y*8)

PRI adresseminus(n)
          startadresse-=(n*8)
          endadresse-=(n*8)
          if endadresse<152
             endadresse:=152
          if startadresse<1
             startadresse:=0

PRI adresseplus(n)
          startadresse+=(n*8)
          endadresse+=(n*8)


PRI scrollup(adresse)
    ios.scrollup(1, winhcol, 6, 2, 25, 33,1)
    scrollanfang++
    dump(adresse,2,25,dump_ram)

PRI scrolldown(adresse)
    if scrollanfang>0
       scrollanfang--
       ios.scrolldown(1, winhcol, 6, 2, 25, 33,1)
       dump(adresse,2,6,dump_ram)

PRI scrollrunter

             if scrollanfang<0
                scrollanfang:=0
             if scrollanfang>0
                ios.scrolldown(1, winhcol, 4, 2, 24, 32,1)
                getfilename(scrollanfang)
                Scan_File(4)
                scrollanfang--
                scrollende--
                y_old++

PRI scrollhoch
             if scrollende<filenumber
                ios.scrollup(1, winhcol, 4, 2, 24, 32,1)
                getfilename(scrollende+1)
                Scan_File(24)
                scrollende++
                scrollanfang++
                y_old--
             if scrollende>filenumber
                scrollende:=filenumber
                scrollanfang:=filenumber-21

PRI doppelklick|click                                                                                         'pseudo-doppelklick
    click:=0
    popup_info_weg
    Mouse_Release

    repeat 500
        if ios.mouse_button(0)==255
           click++

    if click>1
       return 1

PRI Scan_File(y)|col                                                                                          'scannt den Dateinamen nach erweiterung ->keine Erweiterung=Verzeichnis=andere Farbe
    col:=act_color
    if file_info[0]==255                                                                                           'verzeichnis
       col:=selectcol
    if file_info[2]==255                                                                                        'versteckte Dateien werden grau dargestellt
       col:=grey
    display_filename(@filestring,y,col)
    ios.serstr(@filestring)
    ios.sertx(13)

PRI display_list(a,b)|n,tt                                                                                    'Dateiliste aus dem Speicher lesen und anzeigen
    tt:=4
    'playerstop
    repeat n from a to b
           getfilename(n)
           Scan_File(tt)
           tt++

con '********************************************* Ausgabe von Fehlermeldungen ***************************************************************************************************
PRI error(err)

    messagebox(ram_txt(err),1)
    '********************** Fehlermeldungen in Messageboxen **********************************************
{    case err
      0:  no error
      1:  Filesys unmounted
      2:  Filesys corrupted
      3:  Filesys unsupported
      4:    not found
      5:  File not found
      6:  Dir not found
      7:  File read only
      8:  End of File
      9:  End of Directory
      10:  End of Root
      11: Directory is full
      12: Directory is not empty
      13: Checksum Error
      14: Reboot Error
      15: bpb corrupt
      16: Filesys corrupt
      17: Dir already exist
      18: File already exist
      19: Out of Disk free Space
      20: Disk  I/O  Error
      21: Command not found
      22:     Timeout
      23: Out of Memory Error
      24: Delete selected File?
      25: Reboot Hive-Computer?
      26: NO FILE SELECTED
      27: SD-CARD Format Ready
      28: Format SD-CARD ?
      29: Delete selected Link?
      30: Delete all Files?
      31: Trash to empty ?
      '****************** ab hier werden die Texte mit -> ram_txt(nummer,TXT_RAM) aufgerufen **************
      32: SD-Card-Info
      33: File-Info
      34: Calendar
      35: Filename:
      36: Filetype:
      37: Directory
      38: File
      39: - Attribute -
      40: R/O HID SYS ARC
      41: Textdisplay
      42: Startmenue
      43: Administra:
      44: Bellatrix :
      45: Regnatix  :
      46: System-Settings
      47: Show hidden Files:
      48: Use Trash        :
      49: Serial-Terminal
      50: Set Baudrate
      51: Systeminfo
      52: Clock-Settings
      53: Color-Settings
      54: Ram-Monitor
      55: Sid-Dmp-Player
      56: Copy  :
      57: Delete:
      58: Venatrix  :
      59: Start-Parameter (für Links)
      60: Venatrix-BUS:
      61: Sepia-Card  :
      62: Cogs
      63: About
      64: Date
      65: Time
      66: Col:
      67: H-RAM:
      68: E-RAM:

}
PRI display_error(er):r
    if er
       error(er)
       r:=abfrage
       ios.sdclose

PRI messagebox(st,ok)|laenge,mindest
    laenge:=strsize(st)+2
    mindest:= 20
    messagex:=10+laenge
    ios.display3DBox(white, messagehcol, black, 10, 7, 17, messagex)
    print_message(st,8,11)
    if ok==1
       button(1,@butOK,10,15)
       button(2,@Abbr,1+laenge,15)

con '************************************************** Dateioperationen *********************************************************************************************************

PRI mount
            if mountmarker==1
               ifnot cmd_unmount
                     trashcounter:=0                                                                          'bei unmount, Mülleimer schliessen
                     util:=0                                                                                  'Utils auf null
                     tmpplay:=0                                                                               'Song-Zähler auf null
                     Verzeichnis_counter:=0

            elseif mountmarker==0
               ifnot cmd_mount
                     userdir:=rootdir                                                                         'Neu geöffnete SD-Karte beginnt immer im Root-Verzeichnis

PRI cmd_mount :err

   'repeat 16
       err:=ios.sdmount
       ifnot err
         mountmarker:=1
         icon(1,1)
         'quit
       else
         display_error(err)
         'quit
pri Checkmount:err
    err:=0
    if mountmarker<1
       display_error(1)
       err:=1
       icon(1,0)

PRI cmd_unmount|err
  ios.sdclose
  err:=ios.sdunmount
  ifnot err
        mountmarker:=0
        icon(1,0)
  else
        display_error(err)

PRI cmd_mkdir|e                                                                                               'cmd: verzeichnis erstellen

  e:=ios.sdnewdir(@New_Dir)

  if e
     display_error(e)

PRI activate_dirmarker(mark)                                                                                  'USER-Marker setzen

     ios.sddmput(ios#DM_USER,mark)                                                                            'usermarker wieder in administra setzen
     ios.sddmact(ios#DM_USER)                                                                                 'u-marker aktivieren

PRI get_dirmarker:dm                                                                                          'USER-Marker lesen

    ios.sddmset(ios#DM_USER)
    dm:=ios.sddmget(ios#DM_USER)

PRI File_All(mode)|n,stradr,dcopy

  n:=1
  ios.sddir                                                                                                   'kommando: verzeichnis öffnen
  break:=0
  dcopy := get_dirmarker                                                                                     'usermarker von administra holen
         case mode
              '---------------------------- Alle Dateien ins Zielverzeichnis kopieren ----------------------------------------------
                0:repeat while (stradr<>0)
                       if break                                                                               'abbruch
                          quit
                       activate_dirmarker(userdir)                                                            'Quellverzeichnis öffnen

                '###### diese 2.schleife ist nötig um die nächste Datei auszuwählen, da durch den Wechsel des Dirmarkers ############
                '###### jedes mal das Verzeichnis zurückgesetzt wird und der ios.sdnext-Befehl bei 1 anfängt ######################
                       repeat n
                              stradr:=ios.sdnext

                       if stradr<>0                                                                           'gültiger eintrag?
                          ifnot ios.sdfattrib(19)                                                             'Verzeichnis?
                              copy_function(userdir,targetdir,stradr,0)                                       'Datei in den Zielordner kopieren
                       n++                                                                                    'Dateizähler erhöhen
                  activate_dirmarker(targetdir)                                                               'Zielverzeichnis öffnen
              '--------------------------- Alle Dateien in den Mülleimer verschieben -----------------------------------------------
                1:repeat  while (stradr <> 0)                                                                 'ist eintrag gültig?
                          if break                                                                            'abbruch
                             quit
                          stradr:=ios.sdnext                                                                  'einen eintrag holen
                          if stradr <> 0                                                                      'eintrag gültig?
                             if ios.sdfattrib(19)                                                             'Verzeichnis?,dann ignorieren
                                next
                             if system_setting[2] and dcopy<>trashdir                                                'wird der Mülleimer benutzt?,und nur kopieren, wenn nicht im Mülleimerverzeichnis
                                copy_function(dcopy,trashdir,stradr,1)                                       'Datei in den Muelleimer kopieren
                                activate_dirmarker(dcopy)                                                    'Quellmarker setzen
                             ifnot break                                                                      'Abfrage Abbruchmarker
                                   ios.sddel(stradr)                                                          'Quelldatei loeschen

                  scan_trash(0)                                                                               'Mülleimer scannen
                  if system_setting[2]
                     activate_dirmarker(dcopy)                                                               'Quellverzeichnis öffnen

PRI cmd_del(strg)|e,dcopy                                                                                    'cmd: datei auf sdcard löschen
{{sddel - datei auf sdcard löschen}}
  break:=0
  error(24)                                                                                                   'Datei löschen?
  print_message(@filestring,8,13)
  e:=0
  ios.sdopen("R",@filestring)
  e:=ios.sdfattrib(16)                                                                                        'Datei schreibgeschützt
  ios.sdclose
  if abfrage                                                                                                  'OK gedrückt, Datei löschen
     if e
          display_error(7)                                                                                    'schreibgeschützte Datei kann nicht gelöscht werden
          return
     ifnot file_info[0]
           if system_setting[2]
              dcopy := get_dirmarker                                                                          'usermarker von administra holen
              copy_function(dcopy,trashdir,strg,1)                                                            'Datei in den Muelleimer kopieren
              scan_trash(0)
              activate_dirmarker(dcopy)                                                                       'Quellmarker setzen
     ifnot break                                                                                              'wenn nicht Abbruch gedrückt wurde,
           ios.sddel(strg)                                                                                    'ursprüngliche Datei löschen

PRI Copy_fenster(source,mode)
    if mode==0
       infofenster(8,6,30,10,ram_txt(56),2)                                                                   'Kopierfenster oeffnen
    else
       infofenster(8,6,30,10,ram_txt(57),2)                                                                   'Delete-Fenster oeffnen
    print_titel(source,16,4)
    printdec_win(0,6,9)                                                                                       'Null und
    printdec_win(100,6,27)                                                                                    'einhundert anzeigen
    rahmen(9,7,29,9)                                                                                          'Rahmen um den Fortschrittsbalken

PRI copy_function(cm,pm,source,mode)|laenge,i,d,n,e,x,y
    copy_fenster(source,mode)                                                                                 'Kopier- oder Delete-Fenster anzeigen
    activate_dirmarker(pm)                                                                                    'Zielmarker setzen
    break:=0
    e:=ios.sdnewfile(source)                                                                                  'neue Datei erstellen

    if e                                                                                                      'Fehler?
       if e==18                                                                                               'Datei existiert schon
          if mode==0                                                                                          'im Kopiermodus wird gefragt, ob eine existierende Datei überschrieben werden soll

             if display_error(18)                                                                             'Anzeige-> Datei existiert schon  'OK angeklickt
                copy_fenster(source,mode)                                                                     'Kopier- oder Delete-Fenster anzeigen
                ios.sddel(source)                                                                             'dann löschen
                ios.sdnewfile(source)                                                                         'neue Datei erstellen
             else
                ios.sdclose                                                                                   'Cancel angeklickt
                return                                                                                        'ohne Aktion zurück
          else                                                                                                'im Delete-Modus wird überschrieben ohne zu fragen (Mülleimer)
             ios.sddel(source)                                                                                'dann löschen
             ios.sdnewfile(source)                                                                            'neue Datei erstellen
       else
          display_error(e)                                                                                    'Fehlerausgabe, wenn erfolglos
          ios.sdclose
          return                                                                                              'zurück

    ios.sdclose
    activate_dirmarker(cm)                                                                                    'wieder quellmarker setzen
    ios.sdopen("R",source)                                                                                    'zu kopierende Datei oeffnen

    laenge:=ios.sdfattrib(0)                                                                                  'um Dateilänge zu lesen (für Fortschrittsbalken)
    ios.sdclose

    ios.sdcopy(cm,pm,source)                                                                                  'Datei kopieren

    repeat                                                                                                    'Fortschritt im Fortschrittsfenster anzeigen
             ma:=ios.Mouse_Button(0)                                                                          'Maustastenabfrage
             if ma==255
                x:=ios.mousex                                                                                 'x und y-Position der Maus beim drücken
                y:=ios.mousey
             if(x=>buttonx[2]) and (x=<(buttonx[2]+6)) and (y==buttony[2])                                    'Abbruch gedrückt?
                buttonpress(2)
                ios.bus_putchar1(1)                                                                           'Abbruchsignal an Administra senden
                break:=1                                                                                      'Abbruchmarker setzen
                quit                                                                                          'und raus
             else
                ios.bus_putchar1(0)                                                                           'Administra sagen, das nicht Abbruch gedrückt wurde
             i:=ios.bus_getlong1                                                                              'Kopierfortschritt von Administra empfangen
             d:=laenge/19                                                                                     'Kopierbalken-Länge berechnen
             n:=i/d
             if n>-1                                                                                          'bei Abbruch wird -1 von Administra gesendet
                ios.display2dbox(act_color,8,10,8,10+n,0)                                                     'Kopierbalken aktualisieren


    until i<0

    Popup_info_Weg                                                                                            'Nach erfolgreicher Operation, Info-Fenster schliessen
    infomarker:=0                                                                                             'Info-Marker loeschen



con '************************************************* Mülleimer *****************************************************************************************************************

PRI Muelleimer_erstellen
    if ios.sdchdir(@trash)                                                                                    'Trash-Verzeichnis nicht vorhanden
       ios.sdnewdir(@TRASH)                                                                                   'Trash-Verzeichnis erstellen
       ios.sdchattrib(@TRASH,string("RHS"))                                                                   'Attribute setzen (R/O, Hidden,System)
       ios.sdchdir(@trash)                                                                                    'ins Trash-Verzeichnis wechseln
    trashdir:=get_dirmarker                                                                                   'Dir-Marker lesen
    scan_trash(0)                                                                                             'gucken, ob was im Mülleimer ist, wenn ja Icon Voll anzeigen
    activate_dirmarker(rootdir)                                                                               'wieder zurüeck ins root-Verzeichnis



PRI scan_trash(mode)|n,stradr                                                                                 'Mülleimer auf Anzahl Einträge scannen

  if mountmarker<1
        return
  playerstop
  activate_dirmarker(trashdir)

  n:=0

  if mode==1                                                                                                  'löschen?
     n:=trashcounter

  ios.sddir                                                                                                   'kommando: verzeichnis öffnen

  repeat  while (stradr <> 0)                                                                                 'ist eintrag gültig? 'wiederhole bis verzeichnisende

      stradr:=ios.sdnext                                                                                      'einen eintrag holen
      if stradr <> 0
               if ios.sdfattrib(19)                                                                           'Verzeichnis?,dann ignorieren
                  next
               if mode==0                                                                                     'einträge nur lesen und zählen
                  n++

               else                                                                                           'einträge löschen (Mülleimer leeren) und rückwärts zählen
                  ios.sddel(stradr)
                  n--
  trashcounter:=n
  Show_Trash
  activate_dirmarker(userdir)                                                                                 'Userverzeichnis setzen

PRI Show_Trash
  if trashcounter>0
     icon(3,1)                                                                                                'Mülleimer voll anzeigen (Deckel weg)
  else
     icon(2,1)                                                                                                'Mülleimer leer anzeigen (Deckel drauf)

con '***************************************************** Reboot-Funktion *******************************************************************************************************
PRI cmd_reboot(mode)|e,f                                                                                      'cmd: reboot
    e:=0
        ios.displaytile(166,titelhcol,winframecol,winhcol,0,34)
        Mouse_Release
        ios.displaytile(166,titelhcol,winhcol,winframecol,0,34)
        e:=display_error(25)                                                                                  'Frage Reboot anzeigen und abfragen

      if e
         playerstop                                                                                           'eventuell laufenden Player stoppen
         ios.Clear_Bluetooth_Command_Mode                                                                     'Kommando-Mode ausschalten
         'ifnot mode
         ios.ram_wrbyte(0,START_FLAG)
         ios.admreset
         ios.belreset
         waitcnt(cnt+clkfreq)
         reboot

PRI Mouse_Release
    repeat while ios.mouse_button(0)                                                                          'warten bis Maustaste losgelassen wird

con '***************************************************** Directory anzeigen ****************************************************************************************************
PRI cmd_dir|stradr,n,d,c',sh                                                                                  'cmd: verzeichnis anzeigen
{{sddir - anzeige verzeichnis}}
  n:=0
  d:=0
  dmpfiles:=0
  'activate_dirmarker(systemdir)
  ios.sddir                                                                                                   'kommando: verzeichnis öffnen

  repeat  while  stradr:=ios.sdnext '(stradr <> 0)                                                                                 'Begrenzung der Einträge auf die mit DIR_ENTRY vereinbarte            'ist eintrag gültig?
                                                                                                              'wiederhole bis verzeichnisende
      'stradr:=ios.sdnext                                                                                      'einen eintrag holen
      'ios.serstr(stradr)
      'ios.sertx(13)
      if stradr <> 0
         if system_setting[1]==0
            if ios.sdfattrib(17)                                                                              'unsichtbare Dateien ausblenden
               next
         n++
         if (ios.sdfattrib(19))
             d++
         scanstr(stradr,1)
         if strcomp(@buff,@dmpfile)
            WriteDmpToRam(DMP_RAM,stradr,ios.sdfattrib(0),dmpfiles++)
            c:=dmpfiles
         WriteNameToRam(stradr,ios.sdfattrib(0),ios.sdfattrib(10),ios.sdfattrib(11),ios.sdfattrib(12),ios.sdfattrib(19),ios.sdfattrib(16),ios.sdfattrib(17),ios.sdfattrib(18),ios.sdfattrib(20),c,n)                                             'Dateiname zur spaeteren Verwendung in ERam speichern an adresse n
         ios.serstr(stradr)
         ios.sertx(13)
         c:=0
         if n>255                                                                                              'Max Anzahl Einträge - wgen SD-Problemen
            quit
  filenumber:=n
  dirnumber:=d
  'ios.ram_fill(DIR_RAM+(n*28),$1BFF-(n*28),0)                                                                 'Variablen,Dir-Speicher,nach letzten Eintrag löschen
  'ios.ram_fill(DMP_RAM+(dmpfiles*17),$1FFF-(dmpfiles*17),0)                                                   'Dmp-File-Speicher nach letztem Eintrag löschen


PRI display_Filename(stradr,ty,col)|p                                                                         'Ausgabe Dateiname, Icon, Größe und Erstellungsdatum
    scanstr(stradr,1)
    p:=get_pic(@buff)
    if strcomp(@buff,@admfile) or strcomp(@buff,@belfile) or strcomp(@buff,@binfile)                          '*.BIN, *.BEL, *.ADM - Files hervorheben
       col:=messagetextcol
    if strsize(stradr)>0 and ty<25
                ios.displaytile(p,winhcol,winframecol,col,ty,2)
                display_line(stradr,ty,col,winhcol)
                if file_info[0]                                                                                'Verzeichnisse hervorheben
                   printfont(string("Dir"),winhcol,0,col,16,ty)
                else
                   printdec(filelen,ty,16,winhcol,col)
                print_zehner(file_info[5],ty,23,col,winhcol)
                ios.displaytile(29,winhcol,0,col,ty,25)
                print_zehner(file_info[6],ty,26,col,winhcol)
                ios.displaytile(29,winhcol,0,col,ty,28)
                printdec(fileyear,ty,29,winhcol,col)

PRI display_Line(stradr,ty,vor,hin)                                                                           'Ausgabe Dateiname, Icon, Größe und Erstellungsdatum

    printfont(stradr,hin,0,vor,3,ty)

PRI get_pic(stradr):pic                                                                                       'Icon für spezifische Dateiendung zuweisen

    pic:=ALL_PIC
    if strcomp(stradr,@binfile)
       pic:=BIN_PIC
    elseif strcomp(stradr,@admfile)
       pic:=ADM_PIC
    elseif strcomp(stradr,@belfile)
       pic:=BEL_PIC
    elseif strcomp(stradr,@basfile)
       pic:=BAS_PIC
    elseif strcomp(stradr,@dmpfile)
       pic:=DMP_PIC
    elseif strcomp(stradr,@txtfile)
       pic:=TXT_PIC
    elseif strcomp(stradr,@sysfile)
       pic:=SYS_PIC
    elseif strcomp(stradr,@colorfile)
       pic:=CLR_PIC
    elseif strcomp(stradr,@extfile)
       pic:=EXT_PIC
    elseif strcomp(stradr,@fontdat)
       pic:=FNT_PIC
    elseif file_info[0] 'or strsize(stradr)<1
       pic:=DIR_PIC

PRI scanstr(f,mode) | z ,c                                                                                    'Dateiendung extrahieren
   if mode==1
      repeat while strsize(f)
             if c:=byte[f++] == "."                                                                           'bis punkt springen
                quit

   z:=0
   repeat 3                                                                                                   'dateiendung lesen
        c:=byte[f++]
        buff[z++] := c & caseBit
   buff[z++] := 0
   return @buff

con '*************************************************** Datei-Verwaltung im E-Ram ***********************************************************************************************

PRI WriteNameToRam(st,laenge,t,m,j,dir,rdonly,hidden,sys,archiv,dpos,nummer)|adress,position,c             'Dateiliste in ERam schreiben
    position:=(nummer-1)*28
    adress:=DIR_RAM+position
    repeat strsize(st)
            c:=byte[st++]
            ios.ram_wrbyte(c,adress++)
    ios.ram_wrlong(laenge,adress++) '4
    adress+=4
    ios.ram_wrword(dpos,adress++)'2
    adress++
    ios.ram_wrbyte(dir,adress++) '1
    ios.ram_wrbyte(rdonly,adress++) '1
    ios.ram_wrbyte(hidden,adress++) '1
    ios.ram_wrbyte(sys,adress++) '1
    ios.ram_wrbyte(archiv,adress++) '1
    ios.ram_wrbyte(t,adress++)'1
    ios.ram_wrbyte(m,adress++)'1
    ios.ram_wrword(j,adress++)'2

PRI WriteDmpToRam(basis,st,ln,n)|adress,position,c                                                            'dmp-File-Liste in E-Ram schreiben
    position:=n*17
    adress:=basis+position
    repeat strsize(st)
            c:=byte[st++]
            ios.ram_wrbyte(c,adress++)
    ios.ram_wrlong(ln,adress++)

PRI getfilename(nummer)|adress,position,c,z,i',aus                                                              'Dateiname aus dem E-Ram holen
    position:=(nummer-1)*28
    adress:=DIR_RAM+position                                                                                  'Adresse Dateiname im eRam
    z:=0
    'aus:=0
    bytefill(@filestring,12,0)
    repeat 12
            c:=ios.ram_rdbyte(adress++)                                                                       'Dateiname aus Dir-Ram lesen
            filestring[z++]:=c

    filestring[z]:=0
    filelen:=ios.ram_rdlong(adress++)
    dmplen:=filelen/25
    adress+=4
    dumpnummer:=ios.ram_rdword(adress++)
    adress++
    repeat i from 0 to 6
         file_info[i]:=ios.ram_rdbyte(adress++)
    fileyear:=ios.ram_rdword(adress++)


con '*********************************************** Icon-Buttons ****************************************************************************************************************
PRI iconbutton(n,t,x,y)
    ios.displaytile(t,winhcol,panelcol,0,y,x)
    iconx[n]:=x
    icony[n]:=y
    iconnr[n]:=t
    iconf1[n]:=winhcol
    iconf2[n]:=panelcol
    iconf3[n]:=0


PRI iconpress(n,mode)
    ios.displaytile(iconnr[n],0,0,255,icony[n],iconx[n])                                                      'ein-Tile Icon
    if mode
       ios.displaytile(iconnr[n]+1,0,0,255,icony[n],iconx[n]+1)                                               'zwei-Tile Icon

    Mouse_Release
    ios.displaytile(iconnr[n],iconf1[n],iconf2[n],iconf3[n],icony[n],iconx[n])                                'ein-Tile Icon
    if mode
       ios.displaytile(iconnr[n]+1,iconf1[n],iconf2[n],iconf3[n],icony[n],iconx[n]+1)                         'zwei-Tile Icon

con '********************************** Speicher und Laderoutinen als Binaerdateien *************************
PRI binsave|i,a,b


    b:=SETTING_RAM

          repeat i from 0 to 20'14
                if i<15
                   a:=get_farbe(i)
                   ios.sdputc(a)
                else
                   ios.sdputc(system_setting[i-15])
      i:=LINK_RAM
      repeat 51                                                                                               'Links in INI-Datei schreiben
           ios.sdputc(ios.ram_rdbyte(i++))

      i:=MOUSE_RAM
      repeat 64
           ios.sdputc(ios.ram_rdbyte(i++))                                                                    'Maus-Pointer in INI-Datei schreiben

      i:=PARA_RAM
      repeat 192
           ios.sdputc(ios.ram_rdbyte(i++))                                                                    'Link-Parameter in INI-Datei schreiben



PRI iniload|i,a

    i:=SETTING_RAM
          repeat a from 0 to 20
              if a<15
                 farbe(a,ios.ram_rdbyte(i++))                                                                 'Farbwerte einlesen
              else
                 system_setting[a-15]:=ios.ram_rdbyte(i++)


'          baud:=ios.ram_rdbyte(i++)                                                                           'Übertragungsrate serielles Terminal
'          Show_Hid_Files:=ios.ram_rdbyte(i++)                                                                 'unsichtbare Dateien anzeigen? ja/nein
'          Use_Trash:=ios.ram_rdbyte(i++)                                                                      'Mülleimer verwenden? ja/nein
'          dcf_on:=ios.ram_rdbyte(i++)                                                                         'DCF-Empfänger benutzen
'          bluetooth_on:=ios.ram_rdbyte(i++)                                                                   'Bluetooth-Modul
'          keyscanner:=ios.ram_rdbyte(i++)                                                                     'Merker für extended Titlebar
          ios.Mousepointer(MOUSE_RAM)                                                                          'Maus-Pointer einlesen


{
    i:=SETTING_RAM
          repeat a from 0 to 20
                 if a<15
                    farbe(a,ios.ram_rdbyte(i++))                                                                 'Farbwerte einlesen
                 else
                    system_setting[a-15]:=ios.ram_rdbyte(i++)

          ios.Mousepointer_flash(MOUSE_RAM)                                                                         'Maus-Pointer einlesen
}
pri load_ini_in_ram
       change_marker:=0
       playerstop
       'activate_dirmarker(systemdir)
       activate_dirmarker(0)
       ios.sdchdir(@system)                                                                                      'System-Verzeichnis lesen
       systemdir:=get_dirmarker
       if ios.sdopen("R",@ini)                                                                                'INI-Datei laden
             LINK_LOAD(0)
       else
             LINK_LOAD(1)
       activate_dirmarker(userdir)

PRI LINK_LOAD(mode)|i,c,ad
    'ad:=INI_ROM

      i:=LINK_RAM
    '******** auf SD-Karte *****
      repeat 51
           if mode==1                                                                                         'INI-Datei vorhanden ->Links einlesen
              c:=ios.sdgetc
           else                                                                                               'keine Ini-Datei vorhanden
              c:=0
           ios.ram_wrbyte(c,i++)                                                                              'Linkspeicher mit Nullen füllen
      '***** auf SD-Karte ******
      i:=PARA_RAM
      repeat 192
           if mode==1
              c:=ios.sdgetc
           else
              c:=0
           ios.ram_wrbyte(c,i++)
     '******* in ROM ***********
     iniload

PRI inisave

    if mountmarker==1
          playerstop                                                                                          'eventuell laufenden Player anhalten
          activate_dirmarker(systemdir)                                                                       'Systemverzeichnis setzen
          ios.sddel(@ini)                                                                                     'alte Ini-Datei löschen
          ios.sdnewfile(@ini)                                                                                 'neue Ini-Datei erstellen
          ios.sdopen("W",@ini)                                                                                'Datei öffnen
          binsave                                                                                             'alle Systemparameter speichern
    ios.sdclose                                                                                               'Datei schließen
    activate_dirmarker(userdir)                                                                               'wieder zurück ins User-Verzeichnis


pri loadMouse(datei)|e
    e:=ios.sdopen("R",datei)                                                                                  'datei öffnen
    ifnot e
          lmouse
pri lmouse
          ios.sdxgetblk(MOUSE_RAM,64)                                                                         'datei in den Speicher schreiben  (der blockbefehl ist viel schneller als der char-Befehl)
          ios.sdclose
          ios.Mousepointer(MOUSE_RAM)

DAT
                                    'lizenz
{{

┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                                   TERMS OF USE: MIT License                                                  │                                                            
├──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation    │ 
│files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy,    │
│modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software│
│is furnished to do so, subject to the following conditions:                                                                   │
│                                                                                                                              │
│The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.│
│                                                                                                                              │
│THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE          │
│WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR         │
│COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,   │
│ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.                         │
└──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
}}
              
