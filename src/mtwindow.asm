include <stdafx.inc>

.data

.data?
hInstance dd  ?
hWinMain dd  ?
hMenu dd ?
.const

szClassName db 'MainWindow', 0
szMenuNewGame db '新游戏(&N)', 0
szMenuQuit db '退出(&Q)', 0
szCaptionMain db '魔塔', 0

.code

_ProcWinMain proc hWnd, uMsg, wParam, lParam
  invoke DefWindowProc, hWnd, uMsg, wParam, lParam
  ret
_ProcWinMain endp



_WinMain proc
  local @stWndClass: WNDCLASSEX
  local @stMsg: MSG
  local @hMenu: HMENU
  local @hIcon: HICON
  invoke GetModuleHandle, NULL
  mov hInstance, eax
  mov @stWndClass.hInstance, eax
  invoke RtlZeroMemory, addr @stWndClass, sizeof @stWndClass 
  mov @stWndClass.hIcon, eax
  mov @stWndClass.hIconSm, eax

  invoke LoadCursor, 0, IDC_ARROW
  mov @stWndClass.hCursor, eax ; 用LoadCursor为光标句柄赋值
  
  mov @stWndClass.cbSize, sizeof WNDCLASSEX
  mov @stWndClass.style, CS_HREDRAW or CS_VREDRAW
  mov @stWndClass.lpfnWndProc, offset _ProcWinMain
  mov @stWndClass.hbrBackground, COLOR_WINDOW + 1
  mov @stWndClass.lpszClassName, offset szClassName

  invoke CreateMenu
  mov hMenu, eax

  invoke LoadMenu, hInstance, IDM_MAIN
  mov @hMenu, eax

  invoke AppendMenu, hMenu, 0, IDM_NEWGAME, offset szMenuNewGame
  invoke AppendMenu, hMenu, 0, IDM_QUIT, offset szMenuQuit

  invoke RegisterClassEx, addr @stWndClass
  ; create a client edged window
  ; whose class is 'szClassName',
  ; and caption is 'szCaptionMain'
  ;  
  invoke CreateWindowEx, WS_EX_CLIENTEDGE, addr szClassName, addr szCaptionMain, WS_OVERLAPPED or WS_CAPTION or WS_SYSMENU, 0, 0, 20 * BLOCK_SIZE + 10, 15 * BLOCK_SIZE + 50, NULL, hMenu, hInstance, NULL
  mov hWinMain, eax ; mark hWinMain as the main window
  invoke UpdateWindow, hWinMain ; send WM_PRINT to hWinMain
  ; set icon
  ; invoke SendMessage, hWinMain, WM_SETICON, ICON_BIG, hIcon
  invoke ShowWindow, hWinMain, SW_SHOWNORMAL ; show window in a normal way
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
  invoke _WinMain
  invoke ExitProcess, 0
__main endp
end __main
