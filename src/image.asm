include stdafx.inc

public hIcon
public hBitmapText
public hBitmapBgnd
public hBitmapBgnd1
public hBitmapBgnd2
public hBitmapBgnd3
public hBitmapBgnd4
public hBitmapBgnd5
public hBitmapAdd
public hBitmapAdd1
public hBitmapAdd2
public hBitmapAdd3
public hBitmapAdd4
public hBitmapAdd5
public hBitmapDelete
public hBitmapDelete1
public hBitmapDelete2
public hBitmapDelete3
public hBitmapDelete4
public hBitmapDelete5
public hBitmapDrag
public hBitmapDrag1
public hBitmapDrag2
public hBitmapDrag3
public hBitmapDrag4
public hBitmapDrag5

public _ImagesPreload

.data?
hIcon dd ?
hBitmapBgnd dd ?
hBitmapBgnd1 dd ?
hBitmapBgnd2 dd ?
hBitmapBgnd3 dd ?
hBitmapBgnd4 dd ?
hBitmapBgnd5 dd ?
hBitmapAdd dd ?
hBitmapAdd1 dd ?
hBitmapAdd2 dd ?
hBitmapAdd3 dd ?
hBitmapAdd4 dd ?
hBitmapAdd5 dd ?
hBitmapDelete dd ?
hBitmapDelete1 dd ?
hBitmapDelete2 dd ?
hBitmapDelete3 dd ?
hBitmapDelete4 dd ?
hBitmapDelete5 dd ?
hBitmapDrag dd ?
hBitmapDrag1 dd ?
hBitmapDrag2 dd ?
hBitmapDrag3 dd ?
hBitmapDrag4 dd ?
hBitmapDrag5 dd ?
hBitmapText dd ?

.const
szIcon db 'img\\mysterious\\icon.ico', 0
szBitmapText db 'img\\mysterious\\text.bmp', 0
szBitmapBgnd1 db 'img\\background\\1.bmp', 0
szBitmapBgnd2 db 'img\\background\\2.bmp', 0
szBitmapBgnd3 db 'img\\background\\3.bmp', 0
szBitmapBgnd4 db 'img\\background\\4.bmp', 0
szBitmapBgnd5 db 'img\\background\\5.bmp', 0
szBitmapAdd1 db 'img\\add\\1.bmp', 0
szBitmapAdd2 db 'img\\add\\2.bmp', 0
szBitmapAdd3 db 'img\\add\\3.bmp', 0
szBitmapAdd4 db 'img\\add\\4.bmp', 0
szBitmapAdd5 db 'img\\add\\5.bmp', 0
szBitmapDelete1 db 'img\\delete\\1.bmp', 0
szBitmapDelete2 db 'img\\delete\\2.bmp', 0
szBitmapDelete3 db 'img\\delete\\3.bmp', 0
szBitmapDelete4 db 'img\\delete\\4.bmp', 0
szBitmapDelete5 db 'img\\delete\\5.bmp', 0
szBitmapDrag1 db 'img\\drag\\1.bmp', 0
szBitmapDrag2 db 'img\\drag\\2.bmp', 0
szBitmapDrag3 db 'img\\drag\\3.bmp', 0
szBitmapDrag4 db 'img\\drag\\4.bmp', 0
szBitmapDrag5 db 'img\\drag\\5.bmp', 0



.code
_ImagesPreload proc
  invoke LoadImage, NULL, addr szBitmapBgnd1, IMAGE_BITMAP, 592, 592, LR_LOADFROMFILE
  mov hBitmapBgnd, eax ; default background color
  mov hBitmapBgnd1, eax
  invoke LoadImage, NULL, addr szBitmapBgnd2, IMAGE_BITMAP, 592, 592, LR_LOADFROMFILE
  mov hBitmapBgnd2, eax
  invoke LoadImage, NULL, addr szBitmapBgnd3, IMAGE_BITMAP, 592, 592, LR_LOADFROMFILE
  mov hBitmapBgnd3, eax
  invoke LoadImage, NULL, addr szBitmapBgnd4, IMAGE_BITMAP, 592, 592, LR_LOADFROMFILE
  mov hBitmapBgnd4, eax
  invoke LoadImage, NULL, addr szBitmapBgnd5, IMAGE_BITMAP, 592, 592, LR_LOADFROMFILE
  mov hBitmapBgnd5, eax
  invoke LoadImage, NULL, addr szIcon, IMAGE_ICON, 16, 16, LR_LOADFROMFILE

  invoke LoadImage, NULL, addr szBitmapAdd1, IMAGE_BITMAP, 30, 30, LR_LOADFROMFILE
  mov hBitmapAdd, eax ; default Add color
  mov hBitmapAdd1, eax
  invoke LoadImage, NULL, addr szBitmapAdd2, IMAGE_BITMAP, 30, 30, LR_LOADFROMFILE
  mov hBitmapAdd2, eax
  invoke LoadImage, NULL, addr szBitmapAdd3, IMAGE_BITMAP, 30, 30, LR_LOADFROMFILE
  mov hBitmapAdd3, eax
  invoke LoadImage, NULL, addr szBitmapAdd4, IMAGE_BITMAP, 30, 30, LR_LOADFROMFILE
  mov hBitmapAdd4, eax
  invoke LoadImage, NULL, addr szBitmapAdd5, IMAGE_BITMAP, 30, 30, LR_LOADFROMFILE
  mov hBitmapAdd5, eax
  invoke LoadImage, NULL, addr szIcon, IMAGE_ICON, 16, 16, LR_LOADFROMFILE

  invoke LoadImage, NULL, addr szBitmapDelete1, IMAGE_BITMAP, 30, 30, LR_LOADFROMFILE
  mov hBitmapDelete, eax ; default Delete color
  mov hBitmapDelete1, eax
  invoke LoadImage, NULL, addr szBitmapDelete2, IMAGE_BITMAP, 30, 30, LR_LOADFROMFILE
  mov hBitmapDelete2, eax
  invoke LoadImage, NULL, addr szBitmapDelete3, IMAGE_BITMAP, 30, 30, LR_LOADFROMFILE
  mov hBitmapDelete3, eax
  invoke LoadImage, NULL, addr szBitmapDelete4, IMAGE_BITMAP, 30, 30, LR_LOADFROMFILE
  mov hBitmapDelete4, eax
  invoke LoadImage, NULL, addr szBitmapDelete5, IMAGE_BITMAP, 30, 30, LR_LOADFROMFILE
  mov hBitmapDelete5, eax
  invoke LoadImage, NULL, addr szIcon, IMAGE_ICON, 16, 16, LR_LOADFROMFILE

  invoke LoadImage, NULL, addr szBitmapDrag1, IMAGE_BITMAP, 532, 30, LR_LOADFROMFILE
  mov hBitmapDrag, eax ; default Drag color
  mov hBitmapDrag1, eax
  invoke LoadImage, NULL, addr szBitmapDrag2, IMAGE_BITMAP, 532, 30, LR_LOADFROMFILE
  mov hBitmapDrag2, eax
  invoke LoadImage, NULL, addr szBitmapDrag3, IMAGE_BITMAP, 532, 30, LR_LOADFROMFILE
  mov hBitmapDrag3, eax
  invoke LoadImage, NULL, addr szBitmapDrag4, IMAGE_BITMAP, 532, 30, LR_LOADFROMFILE
  mov hBitmapDrag4, eax
  invoke LoadImage, NULL, addr szBitmapDrag5, IMAGE_BITMAP, 532, 30, LR_LOADFROMFILE
  mov hBitmapDrag5, eax

  
  invoke LoadImage, NULL, addr szBitmapText, IMAGE_BITMAP, 30, 30, LR_LOADFROMFILE
  mov hBitmapText, eax
  invoke LoadImage, NULL, addr szIcon, IMAGE_ICON, 16, 16, LR_LOADFROMFILE
  mov hIcon, eax
  ret
_ImagesPreload endp
end
