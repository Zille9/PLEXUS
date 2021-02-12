'Takes a Screenshot of VGA screen and saves it to SD card as Windows .BMP picture file

'Copyright 2007 Raymond Allen

OBJ
    sdfat: "fsrw" 


PUB  SaveBMP(SD_BasePin, pscreen,pvga_colorbase,ncols,nrows)|i,j,x,y,b1,b2,b3,xtile,ytile, ptile, pcolor, line, pixel, n ,pixelc, color3, ppic,jj
  'Save VGA screen as BMP on SD card
  'VGA is colsxrows of 16x16 (x4 color) tiles 
  'ncols=x, nrows:=y
  sdfat.mount(SD_BasePin)
   
  sdfat.popen(string("Prop_VGA.BMP"), "w")

  'First, write the header 
  biWidth:=ncols*16
  biHeight:=nrows*16
  bfSize:=biWidth*biHeight*3+54  
  sdfat.pwrite(@bfType,2)
  sdfat.pwrite(@bfSize,4)   
  sdfat.pwrite(@bfReserved1,2)   
  sdfat.pwrite(@bfReserved2,2)   
  sdfat.pwrite(@bfOffBits,4)   
  sdfat.pwrite(@biSize,4)   
  sdfat.pwrite(@biWidth,4)   
  sdfat.pwrite(@biHeight,4)   
  sdfat.pwrite(@biPlanes,2)   
  sdfat.pwrite(@biBitCount,2)   
  sdfat.pwrite(@biCompression,4)   
  sdfat.pwrite(@biSizeImage,4)   
  sdfat.pwrite(@biXPelsPerMeter,4)   
  sdfat.pwrite(@biYPelsPerMeter,4)
  sdfat.pwrite(@biClrUsed,4)   
  sdfat.pwrite(@biClrImportant,4)  

  'next, spit out 24-bit color pixels (in reverse order) 
  repeat y from biHeight-1 to 0 
      'vertical line loop
      repeat i from 0 to ncols-1 
        'horizontal tile loop  
        xtile:=i
        ytile:=y/16
        ptile:=word[pscreen+(ytile * ncols + xtile)<<1]  'ptile points to 16x16x4 color character + color info
        pcolor:=ptile>>10
        ptile<<=6      
        line:=long[ptile+4*(y//16)]  'line is now the 16 pixel x 4 color x-band of the character
        repeat pixel from 0 to 15 'to 0 
          'pixel:=x//16  'pixel is now the 0..15 pixel #
          pixelc:=(line>>(pixel*2)) & $03  'pixelc is now the color of the pixel
          color3:=byte[pvga_colorbase+pcolor*4+pixelc]
          r:=(color3 & %%3000)
          g:=(color3 & %%0300)<<2
          b:=(color3 & %%0030)<<4        
          sdfat.pwrite(@RGB,3)

  sdfat.pclose

  'sdfat.stop

   

'fsrw

DAT
RGB byte
b byte 0
g byte 0
r byte 0 

BMPHeader  'Mostly using info from here:  http://www.fortunecity.com/skyscraper/windows/364/bmpffrmt.html
bfType byte "B","M"  ' 19778
bfSize long 0
bfReserved1 word 0
bfReserved2 word 0
bfOffBits long 54
biSize long 40
biWidth long 0
biHeight long 0
biPlanes word 1
biBitCount word 24
biCompression long 0
biSizeImage long 0
biXPelsPerMeter long 0
biYPelsPerMeter long 0
biClrUsed long 0
biClrImportant long 0


