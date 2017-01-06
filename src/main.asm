include <stdafx.inc>
include <image.inc>


.data
MEMO_SIZE dd MEMO_SIZE_MINI  ; default memo size is mini
BRUSH_TYPE dd ?  ; default brush type
BRUSH_SIZE dd ?  ; default brush size


.data?
hInstance dd  ?
hWinMain dd  ?
hMenu dd ?
hPPMenu dd ?

.const



; menu choice
szClassName db 'MainWindow', 0
szMenuNewMemo db '�½�(&N)', 0
szMenuQuit db 'ɾ��(&Q)', 0
szMenuTimerChoice db '��ʱ����(&A)', 0
szMenuTimerClock db 'ĳʱ��(&T)', 0
szMenuTimerSecond db '�����(&S)', 0
szMenuTimerMinute db '�����Ӻ�(&M)', 0
szMenuTimerHour db '��Сʱ��(&H)', 0
szMenuMemosize db '��ǩ��С', 0
szMenuBgnd db '������ɫ', 0
szMenuBrush db '��ˢ����', 0
szMenuBshsize db '��ˢ��С', 0
szMenuMemosizeMini db '����', 0
szMenuMemosizeSmall db 'С', 0
szMenuMemosizeBig db '��', 0
szMenuMemosizeGiant db '�ش�', 0
szMenuBgndYellow db '��ɫ', 0
szMenuBgndWhite db '��ɫ', 0
szMenuBgndPink db '��ɫ', 0
szMenuBgndGreen db '��ɫ', 0
szMenuBgndBlue db '��ɫ', 0
szMenuBrushEraser db '��Ƥ��', 0
szMenuBrushBlack db '�ڱ�', 0
szMenuBrushRed db '���', 0
szMenuBshsizeSmall db 'С��ˢ', 0
szMenuBshsizeMiddle db '��ͨ��ˢ', 0
szMenuBshsizeBig db '���ˢ', 0

szCaptionMain db 'MEMO', 0

.code

; CreatePPMenu
_CreatePPMenu proc  
  LOCAL @hPopMenu0
  LOCAL @hPopMenu1
  LOCAL @hPopMenu2
  LOCAL @hPopMenu3
  LOCAL @hPopMenu4

  invoke CreatePopupMenu  
  mov @hPopMenu0,eax  

  invoke CreatePopupMenu  
  mov @hPopMenu1,eax  
  invoke CreatePopupMenu  
  mov @hPopMenu2,eax  
  invoke CreatePopupMenu  
  mov @hPopMenu3,eax  
  invoke CreatePopupMenu  
  mov @hPopMenu4,eax  

  invoke AppendMenu,@hPopMenu0,MF_POPUP,@hPopMenu1,offset szMenuMemosize
  invoke AppendMenu,@hPopMenu0,MF_POPUP,@hPopMenu2,offset szMenuBgnd
  invoke AppendMenu,@hPopMenu0,MF_POPUP,@hPopMenu3,offset szMenuBrush
  invoke AppendMenu,@hPopMenu0,MF_POPUP,@hPopMenu4,offset szMenuBshsize

  invoke  AppendMenu,@hPopMenu1,MF_BYCOMMAND,IDM_MEMOSIZEMINI,offset szMenuMemosizeMini
  invoke  AppendMenu,@hPopMenu1,MF_BYCOMMAND,IDM_MEMOSIZESMALL,offset szMenuMemosizeSmall
  invoke  AppendMenu,@hPopMenu1,MF_BYCOMMAND,IDM_MEMOSIZEBIG,offset szMenuMemosizeBig
  invoke  AppendMenu,@hPopMenu1,MF_BYCOMMAND,IDM_MEMOSIZEGIANT,offset szMenuMemosizeGiant
  invoke  AppendMenu,@hPopMenu2,MF_BYCOMMAND,IDM_BGND1,offset szMenuBgndYellow
  invoke  AppendMenu,@hPopMenu2,MF_BYCOMMAND,IDM_BGND2,offset szMenuBgndWhite
  invoke  AppendMenu,@hPopMenu2,MF_BYCOMMAND,IDM_BGND3,offset szMenuBgndPink
  invoke  AppendMenu,@hPopMenu2,MF_BYCOMMAND,IDM_BGND4,offset szMenuBgndGreen
  invoke  AppendMenu,@hPopMenu2,MF_BYCOMMAND,IDM_BGND5,offset szMenuBgndBlue
  invoke  AppendMenu,@hPopMenu3,MF_BYCOMMAND,IDM_BRUSHERASER,offset szMenuBrushEraser
  invoke  AppendMenu,@hPopMenu3,MF_BYCOMMAND,IDM_BRUSHBLACK,offset szMenuBrushBlack
  invoke  AppendMenu,@hPopMenu3,MF_BYCOMMAND,IDM_BRUSHRED,offset szMenuBrushRed
  invoke  AppendMenu,@hPopMenu4,MF_BYCOMMAND,IDM_BSHSIZESMALL,offset szMenuBshsizeSmall
  invoke  AppendMenu,@hPopMenu4,MF_BYCOMMAND,IDM_BSHSIZEMIDDLE,offset szMenuBshsizeMiddle
  invoke  AppendMenu,@hPopMenu4,MF_BYCOMMAND,IDM_BSHSIZEBIG,offset szMenuBshsizeBig

  push @hPopMenu0
  pop eax  
  ret  
_CreatePPMenu endp  


_ProcWinMain proc hWnd, uMsg, wParam, lParam
  local @stPos:POINT  
  local @hPPMenu  
  mov eax,uMsg
  .if eax == WM_CREATE


  ; right mouse button down, pop up a menu
  .elseif eax == WM_RBUTTONDOWN 
    invoke _CreatePPMenu
    mov @hPPMenu,eax  
    invoke GetCursorPos,addr @stPos  
    invoke TrackPopupMenu,@hPPMenu,TPM_LEFTALIGN,@stPos.x,@stPos.y,NULL,hWnd,NULL  

  .elseif eax == WM_COMMAND
    .if wParam == IDM_NEWMEMO

    .elseif wParam == IDM_QUIT
      invoke PostQuitMessage, 0

    .elseif wParam == IDM_MEMOSIZEMINI
    
    .elseif wParam == IDM_MEMOSIZESMALL
    
    .elseif wParam == IDM_MEMOSIZEBIG
    
    .elseif wParam == IDM_MEMOSIZEGIANT
    

    .elseif wParam == IDM_BGND1
    
    .elseif wParam == IDM_BGND2
    
    .elseif wParam == IDM_BGND3
    
    .elseif wParam == IDM_BGND4
    
    .elseif wParam == IDM_BGND5
    

    .elseif wParam == IDM_BRUSHERASER
    
    .elseif wParam == IDM_BRUSHBLACK
    
    .elseif wParam == IDM_BRUSHRED
    

    .elseif wParam == IDM_BSHSIZESMALL
    
    .elseif wParam == IDM_BSHSIZEMIDDLE
    
    .elseif wParam == IDM_BSHSIZEBIG
      

    .elseif wParam == IDM_TIMERCLOCK

    .elseif wParam == IDM_TIMERSECOND

    .elseif wParam == IDM_TIMERMINUTE

    .elseif wParam == IDM_TIMERHOUR

    .endif

  .elseif eax == WM_CLOSE  
    invoke DestroyWindow,hWinMain  
    invoke PostQuitMessage,NULL  

  .else
    invoke DefWindowProc, hWnd, uMsg, wParam, lParam
  .endif
  ret
_ProcWinMain endp



_WinMain proc
  local @stWndClass: WNDCLASSEX
  local @stMsg: MSG
  local @hMenu: HMENU
  local @hMenuTimerChoice: HMENU
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
  mov @stWndClass.lpfnWndProc, offset _ProcWinMain
  mov @stWndClass.hbrBackground, COLOR_WINDOW + 1
  mov @stWndClass.lpszClassName, offset szClassName

  invoke CreateMenu
  mov hMenu, eax
  invoke LoadMenu, hInstance, IDM_MAIN
  mov @hMenu, eax
  invoke CreatePopupMenu
  mov @hMenuTimerChoice, eax

  invoke AppendMenu, hMenu, MF_BYCOMMAND, IDM_NEWMEMO, offset szMenuNewMemo
  invoke AppendMenu, hMenu, MF_POPUP, @hMenuTimerChoice, offset szMenuTimerChoice
  invoke AppendMenu, hMenu, 0, IDM_QUIT, offset szMenuQuit

  invoke AppendMenu, @hMenuTimerChoice, MF_BYCOMMAND, IDM_TIMERCLOCK, offset szMenuTimerClock
  invoke AppendMenu, @hMenuTimerChoice, MF_BYCOMMAND, IDM_TIMERSECOND, offset szMenuTimerSecond
  invoke AppendMenu, @hMenuTimerChoice, MF_BYCOMMAND, IDM_TIMERMINUTE, offset szMenuTimerMinute
  invoke AppendMenu, @hMenuTimerChoice, MF_BYCOMMAND, IDM_TIMERHOUR, offset szMenuTimerHour
  
  invoke RegisterClassEx, addr @stWndClass
  ; create a client edged window
  ; whose class is 'szClassName',
  ; and caption is 'szCaptionMain'
  ;  
  invoke CreateWindowEx, WS_EX_CLIENTEDGE, addr szClassName,\
                         addr szCaptionMain, WS_SYSMENU or WS_POPUP,\
                         0, 0, MEMO_SIZE, MEMO_SIZE, NULL,\
                         hMenu, hInstance, NULL
  mov hWinMain, eax ; mark hWinMain as the main window
  invoke UpdateWindow, hWinMain ; send WM_PRINT to hWinMain
  ; set icon
  invoke SendMessage, hWinMain, WM_SETICON, ICON_BIG, hIcon
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
  call ImagesPreload
  invoke _WinMain
  invoke ExitProcess, 0
__main endp
end __main
