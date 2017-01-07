include <stdafx.inc>

extrn MEMO_SIZE: dword
extrn MEMO_BGND: dword
extrn BRUSH_TYPE: dword
extrn BRUSH_SIZE: dword

public _Paint
public _Repaint

.data

.code
_Paint proc uses eax ebx ecx edx hDC:dword, dwX:dword, dwY:dword
  local @dwBrushColor:dword
  ; get brush color
  .if BRUSH_TYPE == BRUSH_BLACK
    mov @dwBrushColor, 000000H

  .elseif BRUSH_TYPE == BRUSH_RED
    mov @dwBrushColor, 0000ffH

  .elseif BRUSH_TYPE == BRUSH_ERASER
    .if MEMO_BGND == MEMO_BGND_1
    mov @dwBrushColor, 0bdf6faH
    .elseif MEMO_BGND == MEMO_BGND_2
    mov @dwBrushColor, 0ffffffH
    .elseif MEMO_BGND == MEMO_BGND_3
    mov @dwBrushColor, 0c5c5f3H
    .elseif MEMO_BGND == MEMO_BGND_4
    mov @dwBrushColor, 0b8e2c4H
    .elseif MEMO_BGND == MEMO_BGND_5
    mov @dwBrushColor, 0ece0afH
    .endif
  .endif

  mov edx, BRUSH_SIZE
  mov eax, dwX
  mov ebx, dwY
  add eax, edx
  add ebx, edx
  add edx, edx
  inc edx
  mov ecx, edx

  .while (ecx > 0) && (ebx > 30)
    push ecx
    mov ecx, edx
    push eax
    .while ecx > 0
      push eax
      push ebx
      push ecx
      push edx
      invoke SetPixel, hDC, eax, ebx, @dwBrushColor
      ; mov 
      pop edx
      pop ecx
      pop ebx
      pop eax  
      dec eax
      dec ecx
    .endw
    pop eax
    pop ecx
    dec ebx
    dec ecx
  .endw

  ret
_Paint endp

_Repaint proc hDC
  local @dwBrushColor


  ret
_Repaint endp

end
