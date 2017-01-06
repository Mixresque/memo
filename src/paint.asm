include <stdafx.inc>

extrn MEMO_SIZE: dword
extrn MEMO_BGND: dword
extrn BRUSH_TYPE: dword
extrn BRUSH_SIZE: dword

public _Paint
public _Repaint

.data
bCanvas db 592 dup( 592 dup( 0 ) )


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
  sub eax, edx
  sub ebx, edx
  add edx, edx
  inc edx
  mov ecx, edx

  ; mov esi, offset bCanvas
  ; mov edi, offset bCanvas
  ; add esi, eax
  ; push eax
  ; push edx
  ; mov dx, 592
  ; mul dx
  ; add edi, eax
  ; pop edx
  ; pop eax


  .while ecx > 0
    push ecx
    mov ecx, edx
    push ebx
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
      inc ebx
      dec ecx
    .endw
    pop ebx
    pop ecx
    inc eax
    dec ecx
  .endw

  ret
_Paint endp

_Repaint proc hDC
  local @dwBrushColor


  

  ret
_Repaint endp

end
