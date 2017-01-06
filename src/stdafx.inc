.386
.model flat, stdcall
option casemap: none

include windows.inc
include gdi32.inc
includelib gdi32.lib
include msimg32.inc
includelib msimg32.lib
include user32.inc
includelib user32.lib
include kernel32.inc
includelib kernel32.lib
include masm32.inc
includelib masm32.lib
include debug.inc
includelib debug.lib


MEMO_SIZE_MINI equ 100h  ; MEMO size as mini
MEMO_SIZE_SMALL equ 150h  ; MEMO size as small
MEMO_SIZE_BIG equ 200h  ; MEMO size as big
MEMO_SIZE_GIANT equ 250h  ; MEMO size as giant


IDM_NEWMEMO equ 2001h
IDM_QUIT equ 2002h
IDM_MEMOSIZEMINI equ 2011h
IDM_MEMOSIZESMALL equ 2012h
IDM_MEMOSIZEBIG equ 2013h
IDM_MEMOSIZEGIANT equ 2014h
IDM_BGND1 equ 2021h
IDM_BGND2 equ 2022h
IDM_BGND3 equ 2023h
IDM_BGND4 equ 2024h
IDM_BGND5 equ 2025h
IDM_BRUSHERASER equ 2031h
IDM_BRUSHBLACK equ 2032h
IDM_BRUSHRED equ 2033h
IDM_BSHSIZESMALL equ 2041h
IDM_BSHSIZEMIDDLE equ 2042h
IDM_BSHSIZEBIG equ 2043h





;-----------------------------------------------------
MAP_SIZE equ 0Dh

ICO_BIG equ 1000h
IDM_MAIN equ 2000h

Position struct
    x dd ?
    y dd ?
Position ends

Braver struct
    HP dd 1000
    ATK dd 100
    DEF dd 100
    MON dd 0
    pos Position <>
    POSY dd 0
Braver ends
