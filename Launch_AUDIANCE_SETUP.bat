@echo off
rem Created by Fletcher Salesky
rem AUDIANCE SETUP Powershell Launcher (This verson from 2023-04-14)

Title FRC AUDIANCE LAPTOP SETUP
rem fancy color
color 06
cls
rem Launch Powershell Script
if exist "%~dp0AUDIANCE_SETUP.ps1" (Powershell -noprofile -executionpolicy bypass -file %~dp0AUDIANCE_SETUP.ps1)
pause
