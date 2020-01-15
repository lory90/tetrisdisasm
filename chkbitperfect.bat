@ECHO OFF

REM // build the ROM
call build %1

REM  // run fc
echo -------------------------------------------------------------
IF EXIST tetrisbuilt.bin ( fc /b tetrisbuilt.bin tetrisoriginal.bin
) ELSE echo tetrisbuilt.bin does not exist, probably due to an assembly error

REM // clean up after us
IF EXIST tetris.p del tetris.p
IF EXIST tetris.h del tetris.h
IF EXIST tetris.lst del tetris.lst
IF EXIST tetrisbuilt.bin del tetrisbuilt.bin
IF EXIST tetrisbuilt.prev.bin del tetrisbuilt.prev.bin
IF EXIST tetris.log ( IF "%1"=="-pe" del tetris.log )

REM // if someone ran this from Windows Explorer, prevent the window from disappearing immediately
pause
