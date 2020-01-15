@ECHO OFF

REM // make sure we can write to the file tetrisbuilt.bin
REM // also make a backup to tetrisbuilt.prev.bin
IF NOT EXIST tetrisbuilt.bin goto LABLNOCOPY
IF EXIST tetrisbuilt.prev.bin del tetrisbuilt.prev.bin
IF EXIST tetrisbuilt.prev.bin goto LABLNOCOPY
move /Y tetrisbuilt.bin tetrisbuilt.prev.bin
IF EXIST tetrisbuilt.bin goto LABLERROR3
:LABLNOCOPY

REM // delete some intermediate assembler output just in case
IF EXIST tetris.p del tetris.p
IF EXIST tetris.p goto LABLERROR2
IF EXIST tetris.h del tetris.h
IF EXIST tetris.h goto LABLERROR1

REM // clear the output window
REM cls

REM // run the assembler
REM // -xx shows the most detailed error output
REM // -E creates log file for errors/warnings
REM // -A gives us a small speedup
set AS_MSGPATH=AS/win32
set USEANSI=n

REM // allow the user to choose to output error messages to file by supplying the -logerrors parameter
IF "%1"=="-logerrors" ( "AS/win32/asw.exe" -xx -c -E -A -L tetris.asm ) ELSE "AS/win32/asw.exe" -xx -c -E -A -L tetris.asm

REM // if there were errors, a log file is produced
IF EXIST tetris.log goto LABLERROR4

REM // combine the assembler output into a rom
IF EXIST tetris.p "AS/win32/tetrisp2bin" tetris.p tetrisbuilt.bin tetris.h

REM // done -- pause if we seem to have failed, then exit
IF NOT EXIST tetris.p goto LABLPAUSE
IF NOT EXIST tetrisbuilt.bin goto LABLPAUSE
fixheader tetrisbuilt.bin
exit /b
:LABLPAUSE

pause


exit /b

:LABLERROR1
echo Failed to build because write access to tetris.h was denied.
pause


exit /b

:LABLERROR2
echo Failed to build because write access to tetris.p was denied.
pause


exit /b

:LABLERROR3
echo Failed to build because write access to tetrisbuilt.bin was denied.
pause

exit /b

:LABLERROR4
REM // display a noticeable message
echo.
echo ***************************************************************************
echo *                                                                         *
echo *   There were build errors/warnings. See tetris.log for more details.    *
echo *                                                                         *
echo ***************************************************************************
echo.
pause

