'' ------------------
'' |   MOD Player   |
'' ------------------
'' (c)2012..2014 Andy Schenk, Insonix.ch    ("Ariba" on the Propeller Forum)
''
'' Plays Amiga MOD files with 4 channels and max 31 instruments direct from SD card.
'' Needs a temporary file called "temp1m.dat" for the pattern-sequences on the card.
'' This file and all the MOD files must have contiguous sectors, so write the files
'' to a fresh formated SD card, and don't delete them (you can rename a MOD file, to
'' exclude it from the play list).
'' You can find thousands of MOD files on the Net for exampe at: WWW.MODARCHIVE.ORG
''
'' !! There is still a big poblem with the sample-loops, so many instruments play with
'' a glitch on every loop. 
'' 
CON
  _clkmode  = xtal1 + pll16x
  _xinfreq  = 5_000_000

' ----- pin & mode settings -----     defaults for Activity Board
  SD_PINS = 10'22   'SD card basepin
  DAC_L   = 8'26   'Audio L/mono out
  DAC_R   = 9'27   'Audio R (-1 = mono)
  TUNE_FQ = 7264040 / 2    'tune for 62.5 kHz
  M_VOL   = 1    '1..5  MasterVolume
' -------------------------------
  SMP_FRQ = 62500
  CLS     = 0

' ------------------
' Terminal Interface
' ------------------
OBJ
  ser :  "FullDuplexSerialExtended"
  sd  :  "FSRW" '26b"

VAR
  long  sdlock, ipoff
  long  selMod, maxpatt, songend
  long  songnr, pattnr, sector, tempsect, smpstart
  long  smpbeg[31]
  word  smpsize[31], smploop[31], smpllen[31]
  byte  smptune[31], smpvol[31]
  byte  buff[32], fsel[32], strbuf[22*24]
  byte  song[128]     'pattern list
  long  pattern[256]  '64 patterns a 4 longs

PUB Main : err | c
  {sdlock := locknew
  ser.start(31,30,0,115200)
  waitcnt(clkfreq*3 + cnt)      'Delay for Terminal start (3 sec)
  ser.str(string("Propeller SD-card MOD Player"))
  err := \sd.mount(SD_PINS)     'Try to mount SD cadr
  if err < 0
    ser.str(string("SD mount error: "))
    ser.dec(err)
    return}
  ticks := 6                    'Init Parameters
  bpm := 125
  ipoff := 1
  'ser.tx(CLS)
  'ser.str(string("Propeller SD-card MOD Player"))
  selMod := -1
  showFiles
  start

  repeat                        'Command Loop
    'ser.str(string(13,13,"Menu: l=List-MODs p=Play s=Stop 0..9=sel f=Filter"))
    c := ser.rx
    case c
      "l": selMod := -1
           showFiles
      "p": ticks := 6
           bpm := 125
           playFlg := 1
           'ser.str(string(13,"playing... "))
      "s": playFlg := 0
           'ser.str(string("..stopped"))
           waitcnt(clkfreq/4 + cnt)
           bytefill(@vcbuff,0,8*512) 
      "f": ipoff ^= 1
           if ipoff
             'ser.str(string(" Filter ON"))
           else
             'ser.str(string(" Filter OFF"))
      "0".."9": selMod := c-"0"
                'showFiles
                'ser.str(string(13,"Selected: "))
                'ser.str(@fsel)
                loadMod(@fsel)
      

PUB showFiles : i               '' show first 10 MOD files on SD card
  if selMod<0 
    ser.str(string(13,"==== MOD Files ===="))
  \sd.opendir
  i:=0
  repeat
    if \sd.nextfile(@buff) < 0' or i > 9
      quit
    if strcomp(@buff+strsize(@buff)-4, string(".MOD"))
      if selMod<0               'if selMod = -1 then show filenames
        ser.tx(13)
        ser.dec(i)
        ser.tx(":")
        ser.str(@buff)
      elseif i==selMod          'if selMod> -1 then select filename
        bytemove(@fsel,@buff,31)
      i++

PRI readWord : v                'read BigEndian word from SD
  \sd.pread(@v+1,1)
  \sd.pread(@v,1)

PRI readLong : v                'read BigEndian long from SD
  \sd.pread(@v+3,1)
  \sd.pread(@v+2,1)
  \sd.pread(@v+1,1)
  \sd.pread(@v,1)

PUB loadMod(strp) : err | i,p,n   '' load a MOD file
  tempsect := sector := 0
  err := \sd.popen(string("temp1m.dat"),"r")
  if err => 0
    tempsect := sd.getStartSector 'start of temp file which holds the patterns
    \sd.pclose
  err := \sd.popen(strp,"r") <# 0
  ifnot err
    sector := sd.getStartSector   'startsector for samples access + 2108=samples
    \sd.pread(@buff,20)           'title
    ser.str(string(13,"MOD File: "))
    ser.str(@buff)
    ser.str(string(13,"Loading ..please wait..  "))
    bytefill(@strbuf,0,22*24)
    repeat i from 0 to 30         'read sample parameters for all 31 instruments
      \sd.pread(@buff,22)         'sample name
      buff[21] := 0
      bytemove(@strbuf+i*22,@buff,22)
      smpsize[i] := readWord <<1   
      \sd.pread(@smptune[i],1)    'signed nibble -8..+7
      \sd.pread(@smpvol[i],1)     '0..64
      smploop[i] := readWord <<1
      smpllen[i] := readWord <<1
    \sd.pread(@songend,1)         'number of patterns in List to play
    \sd.pread(@buff,1)            '-
    \sd.pread(@song, 128)         'pattern list
    \sd.pread(@buff, 4)           'ID "M.K." or "8CHN" or so
    ser.str(string("Type: "))
    repeat i from 0 to 3          'show ID
      ser.tx(buff[i])
    maxpatt := 0
    repeat i from 0 to 127        'find highest pattern number
      maxpatt #>= song[i]
    ser.str(string(13,"Patterns: "))
    ser.dec(maxpatt)
    ser.str(string(" kBytes"))
    smpstart := 1084              'header+song+id
    repeat p from 0 to maxpatt 
      repeat i from 0 to 255
        pattern[i] := readLong    'read pattern data from MOD file
      smpstart += 1024
      if tempsect
        \sd.writeSector(tempsect+p*2, @pattern)   'write pattern to temp file
        \sd.writeSector(tempsect+p*2+1, @pattern+512)
    p := smpstart
    n := 0
    repeat i from 0 to 30         'calc sample pos on SD (2 smp resolution)
      smpbeg[i] := (sector<<9 + p)>>1
      p += smpsize[i]
      if smpsize[i] > 0
        n++
  \sd.pclose
  ser.str(string(13,"Sample Memory: "))
  ser.dec((p-smpstart)/1024)
  ser.str(string(" kBytes for "))
  ser.dec(n)
  ser.str(string(" Instruments"))
  ticks := 6
  bpm := 125
  songnr := mute := divnr := 0
  pattnr := song[songnr]
  loadPattern
  repeat i from 0 to 5
    vibr[i] := 1
'  selYe := 0

PUB loadPattern : i             '' load a pattern from temp file  (num in pattnr)
  loadSector(tempsect+pattnr<<1, @pattern)
  loadSector(tempsect+pattnr<<1+1, @pattern+512)

PUB stopPlay : i
 repeat i from 0 to 3
   byte[@vol[i]] := 0
   freq[i] := 0
   playFlg := 0

PRI loadSector(num, hubp)
'  repeat while lockset(sdlock)
  \sd.readSector(num, hubp)
'  lockclr(sdlock)

  
CON
' -------- 
'  Player
' -------- 
VAR
  long smppins, sfreq, freq[4], sloop[4], vol[4], sbufp[4]   'PASM parameters (vol also smpstart+NextSector)

  long snum[4], rate[4], gate[4], vibr[4]
  long tickcnt, ticks, bpm, bpmticks, playFlg, mute
  long lfosaw, lfotri
  long divnr, eff[4], per[4], sld[4], loopstp, loopcnt
  long cog1, cog2, stack[64]
  byte oldS0[4], oldS1[4]
  byte vcbuff[4*2*512]                                'sample buffers 1kB per voice

PUB start : i
  cog1 := cognew(playMod, @stack)+1
  smppins := DAC_R<<8 + DAC_L
  repeat i from 0 to 3
    sbufp[i] := @vcbuff + i<<10
  sfreq := clkfreq / SMP_FRQ
  cog2 := cognew(@smpplay, @smppins)+1

PUB stop
  if cog1        
    cogstop(cog1~ -1)
  if cog2        
    cogstop(cog2~ -1)

        
PUB playMod : time | i,c,v,instr,nxtPatt,vp, vc    '' plays the MOD file in own cog
  vp := @vcbuff
  vc := 0
  repeat
    ifnot playFlg
      bpmticks := clkfreq/bpm*60/24
      nxtPatt := 0
      loopstp := 0
      loopcnt := 0
      tickcnt := ticks
      time := cnt+bpmticks
      next
    if playFlg==3     'single step
      time += clkfreq/4
    repeat while time-cnt > 0       'wait for tick-time
      'load sample buffers while waiting
      v := vol[vc]>>8 & $7F     'next sector to load
      if v&1
        if v <> oldS1[vc]       'changed?
          loadSector(smpbeg[snum[vc]]>>8 + v, vp+512)
          oldS1[vc] := v
      else
        if v <> oldS0[vc]       'changed?
          loadSector(smpbeg[snum[vc]]>>8 + v, vp)
          oldS0[vc] := v
      vp += 1024  
      if ++vc == 4
        vc := 0
        vp := @vcbuff
    if playFlg==3        'single step
      mute := 0
      playFlg := 0

    time += bpmticks
    if --tickcnt == 0
      tickcnt := ticks
      repeat c from 0 to 3
        v := pattern[divnr<<2+c]       'get pattern step data
        instr := (v&|<28)>>24 + (v&$F000)>>12
        eff[c] := v & $FFF
        i := 0
        if instr>0
          i := 1
        elseif v>>16&$FFF > 0               'use previous instr
          instr := snum[c]+1
        if instr--                          'or new one
          snum[c] := instr
          case eff[c]>>8
            3 :  sld[c] := v>>16 & $FFF     'glide
                 sld[c] -= (smptune[instr]<<28~>28)*sld[c]/136
            9 :  i := v&$FF<<9              'sample offset
            $E:  if v>>4&$F == $C           'gate sample
                   gate[c] := v&$F
            other: per[c] := v>>16 & $FFF   'or new pitch
                   per[c] -= (smptune[instr]<<28~>28)*per[c]/136
                   sld[c] := per[c]
        if v>>16 & $FFF > 0 and mute & |<c == 0
          'set sample start and freq if period set
          v := smpbeg[instr] + i
          loadSector(v>>8, sbufp[c]+(v&$100))  'load first sector
          oldS0[c] := oldS1[c] := -1
          if smpllen[instr] > 2
            sloop[c] := (smploop[instr]+smpllen[instr]-i-1)<<16 + smpllen[instr] 'set loop
          else
            sloop[c] := (smpsize[instr]-i-1)<<16 + 1  'no loop (loop last sample)
          if i==1
            i := smpvol[instr]  
          else
            i := vol[c] & $7F                  'old sample volume for eff9 or note only
          vol[c] := (v&$1FF)<<17 + $8000 + i   'start sample
          freq[c] := TUNE_FQ / per[c]          'set freq
          byte[@sbufp+c<<2+3] := ipoff         'interpolation on/off
      divnr++
      if divnr > 63                            'all steps in pattern done?
        divnr := 0
        if playFlg==1
          songnr++                             'next pattern from song list
          if songnr => songend
            stopPlay
          pattnr := song[songnr]
          nxtPatt := 1
        else
          stopPlay
          mute := 0
    repeat c from 0 to 3          'per tick effects
      if gate[c] > 0
        if --gate[c] == 0
          byte[@vol+c<<2] := 0
      if eff[c]
        v := eff[c] & $FF
        if tickcnt<>ticks 
          case eff[c]>>8
            1: per[c] := per[c] - v #> 113                       'freq slide
               freq[c] := TUNE_FQ / per[c]
            2: per[c] := per[c] + v <# 856                       
               freq[c] := TUNE_FQ / per[c]
            3: if v==0
                 v := rate[c]
               else
                 rate[c] := v
               if per[c] > sld[c]                               'slide to freq
                 per[c] := per[c] + v <# sld[c]
               else
                 per[c] := per[c] - v #> sld[c]
               freq[c] := TUNE_FQ / per[c]
            4: if v&15 > 0
                 vibr[c] := v & 15
               per[c] := sld[c]*vibr[c]/136 ** lfotri + sld[c]    'vibrato
               freq[c] := TUNE_FQ / per[c]
            5,6,$A: byte[@vol+c<<2] := (vol[c]&$FF) - (v&$F) + v>>4 #>0 <#63  'vol slide
                    if eff[c]>>8 == 6
                      per[c] := sld[c]*vibr[c]/80 ** lfotri + sld[c] '+vibrato
                      freq[c] := TUNE_FQ / per[c]
        if tickcnt==ticks            'per division
          case eff[c]>>8  
            $B: songnr := v <#127                              'jump to songstep
                nxtPatt := 1
            $C: byte[@vol+c<<2] := v <#63                      'set volume
            $D: pattnr := song[songnr++]                       'break pattern
                divnr := v
                nxtPatt := 1
            $E: if v>>4==6                                     '$E effects 
                  if v&$F==0                                   'loop pattern
                    if loopstp<>divnr-1
                      loopcnt := -1
                    loopstp := divnr-1
                  else
                    if loopcnt < 0
                      loopcnt := v&$0F
                    if loopcnt > 0
                      divnr := loopstp
                      loopcnt--
'                elseif v>>4==0                                 'Filter on/off
'                  ipoff := v&1    
            $F: if v =< 32                                     'set speed
                  ticks := v #> 1
                else
                  bpm := v  
                bpmticks := clkfreq/bpm*60/24
    lfosaw += $1000_0000                                       'Vibrato LFO
    lfotri := ||lfosaw-$4000_0000
    if nxtPatt~
      loadPattern 


DAT   'Sample Player (Paula like)
      '--------------------------
      '(c)2012 Andy Schenk, Insonix.ch
        org   0
smpplay mov   t1, par           'get parameters
        rdlong t2, t1           'pins
        movi  ctra, #%00110_000 'DUTY mode
        movs  ctra, t2
        shr   t2, #8
        test  t2, #1<<7  wz     'mono?
  if_z  movi  ctrb, #%00110_000 'DUTY mode
  if_z  movs  ctrb, t2
        mov   t2, #1
        shl   t2, ctra
        mov   dira, t2          'set DAC pins to output
        mov   t2, #1
        shl   t2, ctrb
  if_z  or    dira, t2

        add   t1, #4            'get sample freq ticks
        rdlong period, t1
        mov   tm, cnt           'setup Fs timer
        add   tm, period

        add   t1, #4            
        mov   par0, t1          'pointer to channel parameters (4 longs/voice)

:loop   waitcnt tm, period      '62.5 kHz sample freq
        mins  mixL, limMin
        maxs  mixL, limMax
        mins  mixR, limMin
        maxs  mixR, limMax
        test  t2, bit24  wc     'Filter On?
  if_nc jmp   #:dac       
        sub   mixL, lpl0        '6db/oct LP
        sar   mixL, #1          
        add   lpl0, mixL        
        sub   mixR, lpr0
        sar   mixR, #1
        add   lpr0, mixR
        mov   mixL, lpl0
        mov   mixR, lpr0
:dac    cmp   ctrb, #0  wz      'mono? 
  if_z  add   mixL, mixR        'yes: mix L+R
  if_z  rcr   mixL, #1
        shl   mixL, #1
        shl   mixR, #1
        add   mixL, middle
        add   mixR, middle
        mov   frqa, mixL
        mov   frqb, mixR        'to DACs
        mov   mixL, #0
        mov   mixR, #0
        mov   parp, par0        'first channel parameter

        rdlong t1, parp         'Voice 1: get freq
        add   parp, #16
        add   phs0, t1          'DDS Oscillator  [pos15..0|fract15..0]
        rdlong t2, parp         'get loop [loopEnd15..0|loopLength15..0]
        add   parp, #16
        mov   t3, t2 
        cmp   phs0, t2  wc      '>=loop end?
        shl   t2, #16
  if_ae sub   phs0, t2          'ves: to loop start
        mov   t1, phs0
        add   t1, sectAdd       'calc next needed sector (for preload)
        cmp   t1,t3     wc
  if_ae sub   t1,t2      
        shr   t1, #16+9         '=sector
        rdlong fakt, parp       'get vol+ [smplstart15..0|flag/sect7..0|vol7..0]
        add   parp, #1
        test  fakt, trigBit wc  'new sample start?
        wrbyte t1, parp         'write next sector to Spin vol[].byte1
        add   parp, #15
  if_c  mov   phs0, fakt        'set sample start
        mov   t1, phs0
        shr   t1, #16
        and   t1, k1023         '=offset in sample buffer
        mov   t3, t1
        rdlong t2, parp         'get sample buffer addr
        sub   parp, #44         'point to next voice parameters (-48+4)
        add   t2, t1
        rdbyte t1, t2           'read sample (signed 8 bit)
        shl   t1, #24           'extend to 32 bits
        call  #mul6             'volume multiply
        add   mixL, t1          'mix to Left

        rdlong t1, parp         'Voice 2
        add   parp, #16
        add   phs1, t1
        rdlong t2, parp
        add   parp, #16
        mov   t3, t2
        cmp   phs1, t2  wc
        shl   t2, #16
  if_ae sub   phs1, t2
        mov   t1, phs1
        add   t1, sectAdd
        cmp   t1, t3    wc
  if_ae sub   t1, t2
        shr   t1, #16+9
        rdlong fakt, parp
        add   parp, #1
        test  fakt, trigBit wc
        wrbyte t1, parp
        add   parp, #15
  if_c  mov   phs1, fakt
        mov   t1, phs1
        shr   t1, #16
        and   t1, k1023
        mov   t3,t1
        rdlong t2, parp
        sub   parp, #44
        add   t2, t1
        rdbyte t1, t2
        shl   t1, #24
        call  #mul6
        add   mixR, t1          'mix to Right

        rdlong t1, parp         'Voice 3
        add   parp, #16
        add   phs2, t1
        rdlong t2, parp
        add   parp, #16
        mov   t3, t2
        cmp   phs2, t2  wc
        shl   t2, #16
  if_ae sub   phs2, t2
        mov   t1, phs2
        add   t1, sectAdd
        cmp   t1, t3    wc
  if_ae sub   t1, t2
        shr   t1, #16+9
        rdlong fakt, parp
        add   parp, #1
        test  fakt, trigBit wc
        wrbyte t1, parp
        add   parp, #15
  if_c  mov   phs2, fakt
        mov   t1, phs2
        shr   t1, #16
        and   t1, k1023
        mov   t3,t1
        rdlong t2, parp
        sub   parp, #44
        add   t2, t1
        rdbyte t1, t2
        shl   t1, #24
        call  #mul6
        add   mixR, t1          'mix to Right

        rdlong t1, parp         'Voice 4
        add   parp, #16
        add   phs3, t1
        rdlong t2, parp
        add   parp, #16
        mov   t3, t2
        cmp   phs3, t2  wc
        shl   t2, #16
  if_ae sub   phs3, t2
        mov   t1, phs3
        add   t1, sectAdd
        cmp   t1, t3    wc
  if_ae sub   t1, t2
        shr   t1, #16+9
        rdlong fakt, parp
        test  fakt, trigBit wc
        add   parp, #1
        wrbyte t1, parp
        add   parp, #15
  if_c  mov   phs3, fakt
        mov   t1, phs3
        shr   t1, #16
        and   t1, k1023
        mov   t3,t1
        rdlong t2, parp
'        sub   parp, #48+16
        add   t2, t1
        rdbyte t1, t2
        shl   t1, #24
        call  #mul6
        add   mixL, t1          'mix to Left

        jmp   #:loop        
        
          
' subroutines
mul6    and  fakt,#$7F
        max  fakt,#$3F
        movs t1,fakt            'Mult signed t1[31..9] by unsigned fakt[5..0]
        sar  t1,#1     wc       'signed result in t1[31..0]
        mov  fakt,t1
        andn fakt,#$FF
  if_nc sub  t1,fakt
        sar  t1,#1     wc
  if_c  add  t1,fakt
        sar  t1,#1     wc
  if_c  add  t1,fakt
        sar  t1,#1     wc
  if_c  add  t1,fakt
        sar  t1,#1     wc
  if_c  add  t1,fakt
        sar  t1,#1     wc
  if_c  add  t1,fakt
       sar  t1, #M_VOL+1
mul6_ret  ret                   '19*4 cycles with call


' initialized data
d_inc   long  1<<9
middle  long  1<<31
period  long  80_000 / 48
mixL    long  1<<31
mixR    long  1<<31
neg1    long  -1
limMin  long  $C000_FFFF
limMax  long  $3FFF_0000
maskL   long  $000F_FFFF
trigBit long  $8000
k1023   long  1023
sectAdd long  $200_0000
bit15   long  1<<15
bit14   long  1<<14
bit13   long  1<<13
bit12   long  1<<12
bit24   long  1<<24

' registers
phs0    res   1
phs1    res   1
phs2    res   1
phs3    res   1

t1      res   1
t2      res   1
t3      res   1
vcnt    res   1
tm      res   1
par0    res   1
parp    res   1
fakt    res   1
frac    res   1
lpl0    res   1
lpl1    res   1      
lpr0    res   1
lpr1    res   1      
    
