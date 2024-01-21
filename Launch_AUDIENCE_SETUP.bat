@echo off
rem Created by Fletcher Salesky
rem AUDIENCE SETUP Powershell Launcher (This verson from 2023-04-14)

Title FRC AUDIENCE LAPTOP SETUP
rem fancy color
color 06
cls
rem Launch Powershell Script
if exist "%~dp0AUDIENCE_SETUP.ps1" (Powershell -noprofile -executionpolicy bypass -file %~dp0AUDIENCE_SETUP.ps1)
pause
