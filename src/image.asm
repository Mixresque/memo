include stdafx.inc

public hIcon
public hBitmapBgnd
public hBitmapBgnd1
public hBitmapBgnd2
public hBitmapBgnd3
public hBitmapBgnd4
public hBitmapBgnd5

public ImagesPreload

.data?
hIcon dd ?
hBitmapBgnd dd ?
hBitmapBgnd1 dd ?
hBitmapBgnd2 dd ?
hBitmapBgnd3 dd ?
hBitmapBgnd4 dd ?
hBitmapBgnd5 dd ?

.const
szIcon db 'img\\mysterious\\icon.ico', 0
szBitmapBgnd1 db 'img\\background\\1.bmp', 0
szBitmapBgnd2 db 'img\\background\\2.bmp', 0
szBitmapBgnd3 db 'img\\background\\3.bmp', 0
szBitmapBgnd4 db 'img\\background\\4.bmp', 0
szBitmapBgnd5 db 'img\\background\\5.bmp', 0

.code
ImagesPreload proc
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
    mov hIcon, eax
    ret
ImagesPreload endp
end
