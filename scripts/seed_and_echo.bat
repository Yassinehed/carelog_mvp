@echo off
REM Temporary wrapper for emulator exec on Windows
cd /d "%~dp0.."
node.exe scripts\seed_firestore.js
echo SEED_DONE
