include stdafx.inc

public _SetTimerClock

extrn ALARM_COUNT: dword

.data?



.const




.code


_SetTimerClock proc
  local @stSystemTimeInitial: SYSTEMTIME
  invoke GetLocalTime, addr @stSystemTimeInitial
  xor eax, eax
  xor ecx, ecx
  xor edx, edx
  mov al, 11  ; stSystemTimeRequired.wHour
  mov cl, byte ptr @stSystemTimeInitial.wHour
  sub al, cl
  mov dx, 60
  mul dx
  add eax, 59  ; stSystemTimeRequired.wMinute
  mov cl, byte ptr @stSystemTimeInitial.wMinute
  sub eax, ecx
  mov dx, 60
  mul dx
  add eax, 59  ; stSystemTimeRequired.wSecond
  shl eax, 1
  and eax, 0fffffffeh
  mov ALARM_COUNT, eax
  ret
_SetTimerClock endp

_SetTimerSecond proc dSeconds
  mov eax, dSeconds ; stSystemTimeRequired.wSecond
  shl eax, 1
  and eax, 0fffffffeh
  mov ALARM_COUNT, eax
  ret
_SetTimerSecond endp

_SetTimerMinute proc dMinutes
  mov eax, dMinutes ; stSystemTimeRequired.wMinute
  mov edx, 60
  mul dx
  shl eax, 1
  and eax, 0fffffffeh
  mov ALARM_COUNT, eax  
  ret
_SetTimerMinute endp

_SetTimerHour proc dHours
  mov eax, dHours ; stSystemTimeRequired.wHour
  mov edx, 3600
  mul dx
  shl eax, 1
  and eax, 0fffffffeh
  mov ALARM_COUNT, eax
  ret
_SetTimerHour endp


end
