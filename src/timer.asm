include stdafx.inc

public _SetTimerClock
public _SetTimerSecond
public _SetTimerMinute
public _SetTimerHour
public _ProcTimer

extrn ALARM_COUNT: dword

.const
szAlarmPudding db 'msc\\pudding.wav', 0


.code

_ProcTimer proc hWnd, uMsg, idEvent, dwTime
  ; check alarm clock every 100ms
  .if ALARM_COUNT == 1
    ret
  .elseif ALARM_COUNT == 0
    invoke PlaySound, addr szAlarmPudding, 0, SND_ASYNC or SND_NODEFAULT or SND_FILENAME
    mov ALARM_COUNT, 1
  .else
    sub ALARM_COUNT, 10
  .endif
  ret
_ProcTimer endp

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
  mov edx, 100
  mul dx
  mov ALARM_COUNT, eax
  ret
_SetTimerSecond endp

_SetTimerMinute proc dMinutes
  mov eax, dMinutes ; stSystemTimeRequired.wMinute
  mov edx, 6000
  mul dx
  shl eax, 1
  and eax, 0fffffffeh
  mov ALARM_COUNT, eax  
  ret
_SetTimerMinute endp

_SetTimerHour proc dHours
  mov eax, dHours ; stSystemTimeRequired.wHour
  mov edx, 360000
  mul dx
  shl eax, 1
  and eax, 0fffffffeh
  mov ALARM_COUNT, eax
  ret
_SetTimerHour endp


end
