include <stdafx.inc>
include <image.inc>
include <paint.inc>
include <timer.inc>

public MEMO_SIZE
public MEMO_BGND
public BRUSH_TYPE
public BRUSH_SIZE
public ALARM_COUNT

system proto c :dword

_WinMain proto

; invoke MessageBox, hWnd, addr szMenuBgndPink, addr szMenuBgndYellow, MB_OK

.data
MEMO_SIZE dd MEMO_SIZE_MINI  ; default memo size is mini
MEMO_BGND dd MEMO_BGND_1     ; default memo background color is yellow
BRUSH_TYPE dd BRUSH_BLACK    ; default brush type is black pen
BRUSH_SIZE dd BRUSH_MIDDLE   ; default brush size is middle
ALARM_COUNT dd 1 ; timer never sounds when ALARM_COUNT equals 1
bMouseStatus db 0 ; mouse status initialized as up
bDrawOrText db 0
bTextBufferStatus db 0
sii STARTUPINFO <>
pii PROCESS_INFORMATION <>
dTextPos Position <0, 30>

.data?
hInstance dd ?
hWndMain dd ?
hMenu dd ?
hPPMenu dd ?
hWndEdit dd ?
hDCTmp dd ?

.const

; menu choice
szMenuTimerChoice db '定时提醒', 0
szMenuTimerClock db '某时刻', 0
szMenuTimerSecond db '几秒后', 0
szMenuTimerMinute db '几分钟后', 0
szMenuTimerHour db '几小时后', 0
szMenuMemosize db '便签大小', 0
szMenuBgnd db '背景颜色', 0
szMenuBrush db '笔刷类型', 0
szMenuBshsize db '笔刷大小', 0
szMenuMemosizeMini db '迷你', 0
szMenuMemosizeSmall db '小', 0
szMenuMemosizeBig db '大', 0
szMenuMemosizeGiant db '特大', 0
szMenuBgndYellow db '黄色', 0
szMenuBgndWhite db '白色', 0
szMenuBgndPink db '粉色', 0
szMenuBgndGreen db '绿色', 0
szMenuBgndBlue db '蓝色', 0
szMenuBrushEraser db '橡皮擦', 0
szMenuBrushBlack db '黑笔', 0
szMenuBrushRed db '红笔', 0
szMenuBshsizeSmall db '小笔刷', 0
szMenuBshsizeMiddle db '普通笔刷', 0
szMenuBshsizeBig db '大笔刷', 0

szClassName db 'MainWindow', 0
szEditClass db 'EDIT', 0
szCaptionMain db 'MEMO', 0
szFork db 'main.exe', 0

.code

; CreatePPMenu
_CreatePPMenu proc  
  local @hPopMenu0: HMENU
  local @hPopMenu1: HMENU
  local @hPopMenu2: HMENU
  local @hPopMenu3: HMENU
  local @hPopMenu4: HMENU
  local @hPopMenu5: HMENU

  invoke CreatePopupMenu  
  mov @hPopMenu0, eax  

  invoke CreatePopupMenu
  mov @hPopMenu1, eax
  invoke CreatePopupMenu  
  mov @hPopMenu2, eax  
  invoke CreatePopupMenu  
  mov @hPopMenu3, eax  
  invoke CreatePopupMenu  
  mov @hPopMenu4, eax  
  invoke CreatePopupMenu  
  mov @hPopMenu5, eax  

  invoke AppendMenu, @hPopMenu0, MF_POPUP, @hPopMenu1, offset szMenuTimerChoice
  invoke AppendMenu, @hPopMenu0, MF_POPUP, @hPopMenu2, offset szMenuMemosize
  invoke AppendMenu, @hPopMenu0, MF_POPUP, @hPopMenu3, offset szMenuBgnd
  invoke AppendMenu, @hPopMenu0, MF_POPUP, @hPopMenu4, offset szMenuBrush
  invoke AppendMenu, @hPopMenu0, MF_POPUP, @hPopMenu5, offset szMenuBshsize

  invoke AppendMenu, @hPopMenu1, MF_BYCOMMAND, IDM_TIMERCLOCK, offset szMenuTimerClock
  invoke AppendMenu, @hPopMenu1, MF_BYCOMMAND, IDM_TIMERSECOND, offset szMenuTimerSecond
  invoke AppendMenu, @hPopMenu1, MF_BYCOMMAND, IDM_TIMERMINUTE, offset szMenuTimerMinute
  invoke AppendMenu, @hPopMenu1, MF_BYCOMMAND, IDM_TIMERHOUR, offset szMenuTimerHour
  invoke  AppendMenu, @hPopMenu2, MF_BYCOMMAND, IDM_MEMOSIZEMINI, offset szMenuMemosizeMini
  invoke  AppendMenu, @hPopMenu2, MF_BYCOMMAND, IDM_MEMOSIZESMALL, offset szMenuMemosizeSmall
  invoke  AppendMenu, @hPopMenu2, MF_BYCOMMAND, IDM_MEMOSIZEBIG, offset szMenuMemosizeBig
  invoke  AppendMenu, @hPopMenu2, MF_BYCOMMAND, IDM_MEMOSIZEGIANT, offset szMenuMemosizeGiant
  invoke  AppendMenu, @hPopMenu3, MF_BYCOMMAND, IDM_BGND1, offset szMenuBgndYellow
  invoke  AppendMenu, @hPopMenu3, MF_BYCOMMAND, IDM_BGND2, offset szMenuBgndWhite
  invoke  AppendMenu, @hPopMenu3, MF_BYCOMMAND, IDM_BGND3, offset szMenuBgndPink
  invoke  AppendMenu, @hPopMenu3, MF_BYCOMMAND, IDM_BGND4, offset szMenuBgndGreen
  invoke  AppendMenu, @hPopMenu3, MF_BYCOMMAND, IDM_BGND5, offset szMenuBgndBlue
  invoke  AppendMenu, @hPopMenu4, MF_BYCOMMAND, IDM_BRUSHERASER, offset szMenuBrushEraser
  invoke  AppendMenu, @hPopMenu4, MF_BYCOMMAND, IDM_BRUSHBLACK, offset szMenuBrushBlack
  invoke  AppendMenu, @hPopMenu4, MF_BYCOMMAND, IDM_BRUSHRED, offset szMenuBrushRed
  invoke  AppendMenu, @hPopMenu5, MF_BYCOMMAND, IDM_BSHSIZESMALL, offset szMenuBshsizeSmall
  invoke  AppendMenu, @hPopMenu5, MF_BYCOMMAND, IDM_BSHSIZEMIDDLE, offset szMenuBshsizeMiddle
  invoke  AppendMenu, @hPopMenu5, MF_BYCOMMAND, IDM_BSHSIZEBIG, offset szMenuBshsizeBig

  push @hPopMenu0
  pop eax  
  ret  
_CreatePPMenu endp  

_ProcWndEdit proc hWnd, uMsg, wParam, lParam
  ; local @stPaintStruct: PAINTSTRUCT
  ; local @hDC
  ; local @hDCTmp
  ; .if uMsg == WM_CREATE
  ;   invoke BeginPaint, hWnd, addr @stPaintStruct
  ;   mov @hDC, eax
  ;   invoke CreateCompatibleDC, @hDC
  ;   mov @hDCTmp, eax ; Background DC
  ;   invoke SelectObject, @hDCTmp, hBitmapBgnd
  ;   mov eax, MEMO_SIZE
  ;   sub eax, 30
  ;   invoke BitBlt, @hDC, 0, 0, MEMO_SIZE, eax, @hDCTmp, 0, 0, SRCCOPY
  ;   invoke DeleteDC, @hDCTmp
  ; .endif

  ;    .if uMsg == WM_DESTROY

  ;    .endif
  ; xor eax, eax
  ; ret
_ProcWndEdit endp


_ProcWndMain proc hWnd, uMsg, wParam, lParam
  local @stPaintStruct: PAINTSTRUCT
  local @stPosMouse: POINT  
  local @SystemTimeInitial: SYSTEMTIME
  local @SystemTimeRequired: SYSTEMTIME
  local @stRect: RECT
  local @hPPMenu
  local @hDC
  local @hDCTmp
  local @hDCEdit
  local @dTimer
  local @bHour: byte
  local @bMinute: byte
  local @bSecond: byte

  mov eax, uMsg
  .if eax == WM_CREATE

  .elseif eax == WM_PAINT
    ; initialize memo
    invoke BeginPaint, hWnd, addr @stPaintStruct
    mov @hDC, eax
    invoke CreateCompatibleDC, @hDC
    mov @hDCTmp, eax
    invoke SelectObject, @hDCTmp, hBitmapAdd
    invoke BitBlt, @hDC, 0, 0, 30, 30, @hDCTmp, 0, 0, SRCCOPY
    invoke SelectObject, @hDCTmp, hBitmapDrag
    invoke BitBlt, @hDC, 30, 0, MEMO_SIZE, 30, @hDCTmp, 0, 0, SRCCOPY
    invoke SelectObject, @hDCTmp, hBitmapText
    invoke TransparentBlt, @hDC, 30, 0, 30, 30, @hDCTmp, 0, 0, 30, 30, 0FFFFFFh
    invoke SelectObject, @hDCTmp, hBitmapDelete
    mov eax, MEMO_SIZE
    sub eax, 30
    invoke BitBlt, @hDC, eax, 0, 30, 30, @hDCTmp, 0, 0, SRCCOPY
    invoke SelectObject, @hDCTmp, hBitmapBgnd
    invoke BitBlt, @hDC, 0, 30, MEMO_SIZE, MEMO_SIZE, @hDCTmp, 0, 0, SRCCOPY
    invoke DeleteDC, @hDCTmp
    
  .elseif eax == WM_RBUTTONDOWN 
    ; right mouse button down, pop up a menu
    
    invoke _CreatePPMenu
    mov @hPPMenu, eax
    invoke GetCursorPos, addr @stPosMouse
    invoke TrackPopupMenu, @hPPMenu, TPM_LEFTALIGN, @stPosMouse.x, @stPosMouse.y, NULL, hWnd, NULL

  .elseif eax == WM_LBUTTONDOWN 
    invoke GetCursorPos, addr @stPosMouse
    invoke GetWindowRect, hWnd, addr @stRect
    mov ecx, @stPosMouse.x
    sub ecx, @stRect.left
    mov edx, @stPosMouse.y
    sub edx, @stRect.top
    .if edx <= 30
      mov eax, MEMO_SIZE
      sub eax, 30
      .if ecx > eax
        invoke SendMessage, hWnd, WM_COMMAND, IDM_DELETE, 0
      .elseif ecx < 30
        invoke SendMessage, hWnd, WM_COMMAND, IDM_NEWMEMO, 0
      .elseif ecx < 60
        .if bDrawOrText == 2
          .if bTextBufferStatus == 0
            invoke GetWindowDC, hWndEdit
            mov @hDCEdit, eax
            invoke GetWindowDC, hWnd
            mov @hDC, eax
            invoke CreateCompatibleDC, @hDC
            mov hDCTmp, eax
            invoke CreateCompatibleBitmap, @hDC, TEXT_SIZE_X, TEXT_SIZE_Y
            invoke SelectObject, hDCTmp, eax
            invoke BitBlt, hDCTmp, 0, 0, TEXT_SIZE_X, TEXT_SIZE_Y, @hDCEdit, 0, 0, SRCCOPY
            invoke DestroyWindow, hWndEdit
            mov bTextBufferStatus, 1
          .else
            invoke GetWindowDC, hWndMain
            mov @hDC, eax
            invoke TransparentBlt, @hDC, dTextPos.x, dTextPos.y, TEXT_SIZE_X, TEXT_SIZE_Y, hDCTmp, 0, 0, TEXT_SIZE_X, TEXT_SIZE_Y, 0FFFFFFh
            invoke DeleteDC, hDCTmp
            mov bTextBufferStatus, 0
            mov bDrawOrText, 0
          .endif
        .else
          mov bDrawOrText, 1
        .endif
      .else
        invoke UpdateWindow, hWnd ;即时刷新 
        invoke ReleaseCapture  
        invoke SendMessage, hWnd, WM_NCLBUTTONDOWN, HTCAPTION, 0
      .endif
    .else
      .if bDrawOrText == 0
          mov bMouseStatus, 1
      .elseif bDrawOrText == 2
        invoke DestroyWindow, hWndEdit
        mov bDrawOrText, 0
        .if bTextBufferStatus == 1
          invoke DeleteDC, hDCTmp
          mov bTextBufferStatus, 0
        .endif
      .else
        ; create text area
        invoke GetCursorPos, addr @stPosMouse
        invoke GetWindowRect, hWnd, addr @stRect
        mov eax, @stPosMouse.x
        sub eax, @stRect.left
        mov ebx, @stPosMouse.y
        sub ebx, @stRect.top
        mov dTextPos.x, eax
        mov dTextPos.y, ebx
        invoke CreateWindowEx, WS_EX_APPWINDOW, addr szEditClass, NULL, \
                WS_CHILD+WS_VISIBLE+ES_MULTILINE, eax, ebx, TEXT_SIZE_X, TEXT_SIZE_Y, \
                  hWnd, NULL, hInstance, NULL
        mov hWndEdit, eax
        invoke SetFocus, hWndEdit
        mov bDrawOrText, 2
      .endif
    .endif

  .elseif eax == WM_LBUTTONUP
    mov bMouseStatus, 0

  .elseif eax == WM_MOUSEMOVE
    ; left mouse button down, draw
    .if bMouseStatus == 1   
      invoke GetWindowDC, hWnd
      mov @hDC, eax
      invoke GetCursorPos, addr @stPosMouse
      invoke GetWindowRect, hWnd, addr @stRect
      mov ecx, @stPosMouse.x
      sub ecx, @stRect.left
      mov edx, @stPosMouse.y
      sub edx, @stRect.top
      invoke _Paint, @hDC, ecx, edx
    .endif

  .elseif eax == WM_COMMAND
    .if wParam == IDM_TEXT
      invoke GetWindowDC, hWndMain
      mov @hDC, eax
      invoke TransparentBlt, @hDC, dTextPos.x, dTextPos.y, TEXT_SIZE_X, TEXT_SIZE_Y, hDCTmp, 0, 0, TEXT_SIZE_X, TEXT_SIZE_Y, 0FFFFFFh
      invoke DeleteDC, hDCTmp
    .elseif wParam == IDM_DELETE
      invoke PostQuitMessage, 0
     .elseif wParam == IDM_NEWMEMO
      invoke CreateProcess, addr szFork, NULL, NULL, NULL, FALSE, NULL, NULL, NULL, addr sii, addr pii

    .elseif wParam == IDM_MEMOSIZEMINI
      mov MEMO_SIZE, MEMO_SIZE_MINI
      invoke GetWindowRect, hWnd, addr @stRect
      invoke SetWindowPos, hWnd, HWND_TOP, @stRect.left, @stRect.top, MEMO_SIZE, MEMO_SIZE, SWP_SHOWWINDOW
      invoke GetClientRect, hWnd, addr @stRect
      invoke InvalidateRect, hWnd, addr @stRect, TRUE
      invoke UpdateWindow, hWnd
    .elseif wParam == IDM_MEMOSIZESMALL
      mov MEMO_SIZE, MEMO_SIZE_SMALL
      invoke GetWindowRect, hWnd, addr @stRect
      invoke SetWindowPos, hWnd, HWND_TOP, @stRect.left, @stRect.top, MEMO_SIZE, MEMO_SIZE, SWP_SHOWWINDOW
      invoke GetClientRect, hWnd, addr @stRect
      invoke InvalidateRect, hWnd, addr @stRect, TRUE
      invoke UpdateWindow, hWnd
    .elseif wParam == IDM_MEMOSIZEBIG
      mov MEMO_SIZE, MEMO_SIZE_BIG
      invoke GetWindowRect, hWnd, addr @stRect
      invoke SetWindowPos, hWnd, HWND_TOP, @stRect.left, @stRect.top, MEMO_SIZE, MEMO_SIZE, SWP_SHOWWINDOW
      invoke GetClientRect, hWnd, addr @stRect
      invoke InvalidateRect, hWnd, addr @stRect, TRUE
      invoke UpdateWindow, hWnd
    .elseif wParam == IDM_MEMOSIZEGIANT
      mov MEMO_SIZE, MEMO_SIZE_GIANT
      invoke GetWindowRect, hWnd, addr @stRect
      invoke SetWindowPos, hWnd, HWND_TOP, @stRect.left, @stRect.top, MEMO_SIZE, MEMO_SIZE, SWP_SHOWWINDOW
      invoke GetClientRect, hWnd, addr @stRect
      invoke InvalidateRect, hWnd, addr @stRect, TRUE
      invoke UpdateWindow, hWnd

    .elseif wParam == IDM_BGND1
      mov edx, hBitmapBgnd1
      mov hBitmapBgnd, edx
      mov edx, hBitmapAdd1
      mov hBitmapAdd, edx
      mov edx, hBitmapDelete1
      mov hBitmapDelete, edx
      mov edx, hBitmapDrag1
      mov hBitmapDrag, edx
      mov MEMO_BGND, MEMO_BGND_1
      invoke GetClientRect, hWnd, addr @stRect
      invoke InvalidateRect, hWnd, addr @stRect, TRUE
      invoke UpdateWindow, hWnd
    .elseif wParam == IDM_BGND2
      mov edx, hBitmapBgnd2
      mov hBitmapBgnd, edx
      mov edx, hBitmapAdd2
      mov hBitmapAdd, edx
      mov edx, hBitmapDelete2
      mov hBitmapDelete, edx
      mov edx, hBitmapDrag2
      mov hBitmapDrag, edx
      mov MEMO_BGND, MEMO_BGND_2
      invoke GetClientRect, hWnd, addr @stRect
      invoke InvalidateRect, hWnd, addr @stRect, TRUE
      invoke UpdateWindow, hWnd
    .elseif wParam == IDM_BGND3
      mov edx, hBitmapBgnd3
      mov hBitmapBgnd, edx
      mov edx, hBitmapAdd3
      mov hBitmapAdd, edx
      mov edx, hBitmapDelete3
      mov hBitmapDelete, edx
      mov edx, hBitmapDrag3
      mov hBitmapDrag, edx
      mov MEMO_BGND, MEMO_BGND_3
      invoke GetClientRect, hWnd, addr @stRect
      invoke InvalidateRect, hWnd, addr @stRect, TRUE
      invoke UpdateWindow, hWnd
    .elseif wParam == IDM_BGND4
      mov edx, hBitmapBgnd4
      mov hBitmapBgnd, edx
      mov edx, hBitmapAdd4
      mov hBitmapAdd, edx
      mov edx, hBitmapDelete4
      mov hBitmapDelete, edx
      mov edx, hBitmapDrag4
      mov hBitmapDrag, edx
      mov MEMO_BGND, MEMO_BGND_4
      invoke GetClientRect, hWnd, addr @stRect
      invoke InvalidateRect, hWnd, addr @stRect, TRUE
      invoke UpdateWindow, hWnd
    .elseif wParam == IDM_BGND5
      mov edx, hBitmapBgnd5 
      mov hBitmapBgnd, edx
      mov edx, hBitmapAdd5
      mov hBitmapAdd, edx
      mov edx, hBitmapDelete5
      mov hBitmapDelete, edx
      mov edx, hBitmapDrag5
      mov hBitmapDrag, edx
      mov MEMO_BGND, MEMO_BGND_5
      invoke GetClientRect, hWnd, addr @stRect
      invoke InvalidateRect, hWnd, addr @stRect, TRUE
      invoke UpdateWindow, hWnd

    .elseif wParam == IDM_BRUSHERASER
      mov BRUSH_TYPE, BRUSH_ERASER
    .elseif wParam == IDM_BRUSHBLACK
      mov BRUSH_TYPE, BRUSH_BLACK    
    .elseif wParam == IDM_BRUSHRED
      mov BRUSH_TYPE, BRUSH_RED
    
    .elseif wParam == IDM_BSHSIZESMALL
      mov BRUSH_SIZE, BRUSH_SMALL
    .elseif wParam == IDM_BSHSIZEMIDDLE
      mov BRUSH_SIZE, BRUSH_MIDDLE
    .elseif wParam == IDM_BSHSIZEBIG
      mov BRUSH_SIZE, BRUSH_BIG

    .elseif wParam == IDM_TIMERCLOCK
      mov @bHour, 2
      mov @bMinute, 2
      mov @bSecond, 0
      invoke _SetTimerClock, @bHour, @bMinute, @bSecond
    .elseif wParam == IDM_TIMERSECOND
      mov @dTimer, 5
      invoke _SetTimerSecond, @dTimer
    .elseif wParam == IDM_TIMERMINUTE
      mov @dTimer, 1
      invoke _SetTimerMinute, @dTimer
    .elseif wParam == IDM_TIMERHOUR
      mov @dTimer, 1
      invoke _SetTimerHour, @dTimer
    .endif

  .elseif eax == WM_CLOSE  
    invoke DestroyWindow, hWndMain  
    invoke PostQuitMessage, NULL  

  .else
    invoke DefWindowProc, hWnd, uMsg, wParam, lParam
  .endif
  ret
_ProcWndMain endp

_WinMain proc
  local @stWndClass: WNDCLASSEX
  local @stMsg: MSG
  local @hIcon: HICON

  invoke GetModuleHandle, NULL
  mov hInstance, eax
  mov @stWndClass.hInstance, eax
  invoke RtlZeroMemory, addr @stWndClass, sizeof @stWndClass 
  mov @stWndClass.hIcon, eax
  mov @stWndClass.hIconSm, eax

  ; LoadCursor set the handler for cursor
  invoke LoadCursor, 0, IDC_ARROW
  mov @stWndClass.hCursor, eax
  
  mov @stWndClass.cbSize, sizeof WNDCLASSEX
  mov @stWndClass.style, CS_HREDRAW or CS_VREDRAW
  mov @stWndClass.lpfnWndProc, offset _ProcWndMain
  mov @stWndClass.hbrBackground, COLOR_WINDOW + 1
  mov @stWndClass.lpszClassName, offset szClassName
  
  invoke RegisterClassEx, addr @stWndClass
  ; create a pop-up window with no edges
  invoke CreateWindowEx, WS_EX_APPWINDOW, addr szClassName, \
                         addr szCaptionMain, WS_POPUP, \
                         800, 190, MEMO_SIZE, MEMO_SIZE, NULL, \
                         hMenu, hInstance, NULL
  mov hWndMain, eax ; sava main window handler in hWndMain
  
  invoke SetTimer, hWndMain, 0, 100, _ProcTimer  ; call _ProcTimer every 100ms
  invoke UpdateWindow, hWndMain ; send WM_PRINT to hWndMain
  invoke SendMessage, hWndMain, WM_SETICON, ICON_BIG, hIcon  ; set icon
  invoke ShowWindow, hWndMain, SW_SHOWNORMAL ; show window in a normal way
  ; main loop
  .while 1
    invoke GetMessage, addr @stMsg, NULL, 0, 0
    .break .if eax == 0 ; WM_QUIT => eax == 0
    invoke TranslateMessage, addr @stMsg
    invoke DispatchMessage, addr @stMsg
  .endw
  ret
_WinMain endp

__main proc
  call _ImagesPreload
  invoke _WinMain
  invoke ExitProcess, 0
__main endp
end __main
