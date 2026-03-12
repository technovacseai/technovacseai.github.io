@echo off
setlocal enabledelayedexpansion
title Bixby-FSAI-Exam Project Setup
color 0A

echo ============================================================
echo     Bixby-FSAI-Exam - Full-Stack AI Project Setup
echo     Setting up React, Angular, Node.js, Express, Flask, ML
echo ============================================================
echo.

REM ────────────────────────────────────────────────────────────
REM  PREREQUISITE CHECKS
REM ────────────────────────────────────────────────────────────
echo [INFO] Checking prerequisites...
echo.

REM --- Check Node.js ---
where node >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Node.js is NOT installed or not in PATH.
    echo         Please install Node.js v18+ from https://nodejs.org/
    goto :FAILURE
)
for /f "tokens=*" %%i in ('node -v') do set NODE_VER=%%i
echo [OK]   Node.js found: %NODE_VER%

REM --- Check npm ---
where npm >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [ERROR] npm is NOT installed or not in PATH.
    echo         npm comes bundled with Node.js. Please reinstall Node.js.
    goto :FAILURE
)
for /f "tokens=*" %%i in ('npm -v') do set NPM_VER=%%i
echo [OK]   npm found: v%NPM_VER%

REM --- Check npx ---
where npx >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [ERROR] npx is NOT installed or not in PATH.
    echo         npx comes bundled with npm 5.2+. Please update npm.
    goto :FAILURE
)
echo [OK]   npx found.

REM --- Check Python ---
where python >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Python is NOT installed or not in PATH.
    echo         Please install Python 3.9+ from https://python.org/
    goto :FAILURE
)
for /f "tokens=*" %%i in ('python --version') do set PY_VER=%%i
echo [OK]   Python found: %PY_VER%

REM --- Check pip ---
where pip >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [ERROR] pip is NOT installed or not in PATH.
    echo         pip comes bundled with Python. Please reinstall Python.
    goto :FAILURE
)
for /f "tokens=*" %%i in ('pip --version') do set PIP_VER=%%i
echo [OK]   pip found: %PIP_VER%

echo.
echo [INFO] All prerequisites satisfied!
echo.
echo ============================================================
echo  STEP 1: Creating Root Folder - C:\Bixby-FSAI-Exam
echo ============================================================
echo.

REM ────────────────────────────────────────────────────────────
REM  STEP 1: Create Root Folder
REM ────────────────────────────────────────────────────────────
if not exist "C:\Bixby-FSAI-Exam" (
    mkdir "C:\Bixby-FSAI-Exam"
    if %ERRORLEVEL% neq 0 (
        echo [ERROR] Failed to create root folder C:\Bixby-FSAI-Exam
        echo         Check if you have write permissions on C:\ drive.
        goto :FAILURE
    )
    echo [OK]   Created: C:\Bixby-FSAI-Exam
) else (
    echo [SKIP] C:\Bixby-FSAI-Exam already exists.
)

echo.
echo ============================================================
echo  STEP 2: Setting up APP1
echo ============================================================
echo.

REM ────────────────────────────────────────────────────────────
REM  STEP 2: APP1 Setup
REM ────────────────────────────────────────────────────────────

REM --- Create APP1 folder ---
if not exist "C:\Bixby-FSAI-Exam\APP1" (
    mkdir "C:\Bixby-FSAI-Exam\APP1"
    if %ERRORLEVEL% neq 0 (
        echo [ERROR] Failed to create APP1 folder.
        goto :FAILURE
    )
    echo [OK]   Created: C:\Bixby-FSAI-Exam\APP1
) else (
    echo [SKIP] APP1 folder already exists.
)

REM --- APP1 Backend Setup ---
echo.
echo [INFO] Setting up APP1 Backend (Node.js + Express + MongoDB)...
if not exist "C:\Bixby-FSAI-Exam\APP1\backend" (
    mkdir "C:\Bixby-FSAI-Exam\APP1\backend"
    if %ERRORLEVEL% neq 0 (
        echo [ERROR] Failed to create APP1\backend folder.
        goto :FAILURE
    )
    echo [OK]   Created: APP1\backend
) else (
    echo [SKIP] APP1\backend folder already exists.
)

cd /d "C:\Bixby-FSAI-Exam\APP1\backend"
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Failed to navigate to APP1\backend.
    goto :FAILURE
)

if not exist "package.json" (
    echo [INFO] Initializing npm project in APP1\backend...
    call npm init -y
    if %ERRORLEVEL% neq 0 (
        echo [ERROR] npm init failed in APP1\backend.
        goto :FAILURE
    )
    echo [OK]   npm initialized in APP1\backend.
) else (
    echo [SKIP] package.json already exists in APP1\backend.
)

echo [INFO] Installing backend packages: express, mongoose, cors, body-parser...
call npm install express mongoose cors body-parser
if %ERRORLEVEL% neq 0 (
    echo [ERROR] npm install failed in APP1\backend.
    echo         Check your internet connection and try again.
    goto :FAILURE
)
echo [OK]   Backend packages installed for APP1.

REM --- APP1 Frontend Setup ---
echo.
echo [INFO] Setting up APP1 Frontend (React)...
cd /d "C:\Bixby-FSAI-Exam\APP1"
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Failed to navigate to APP1.
    goto :FAILURE
)

if not exist "frontend" (
    echo [INFO] Creating React app in APP1\frontend (this may take a few minutes)...
    call npx create-react-app frontend
    if %ERRORLEVEL% neq 0 (
        echo [ERROR] create-react-app failed for APP1\frontend.
        echo         Check your internet connection and Node.js version.
        goto :FAILURE
    )
    echo [OK]   React app created in APP1\frontend.
) else (
    echo [SKIP] APP1\frontend already exists. Skipping create-react-app.
)

cd /d "C:\Bixby-FSAI-Exam\APP1\frontend"
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Failed to navigate to APP1\frontend.
    goto :FAILURE
)

echo [INFO] Installing axios in APP1\frontend...
call npm install axios
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Failed to install axios in APP1\frontend.
    goto :FAILURE
)
echo [OK]   axios installed in APP1\frontend.

REM --- APP1 AI Service Setup ---
echo.
echo [INFO] Setting up APP1 AI Service (Flask + ML)...
cd /d "C:\Bixby-FSAI-Exam\APP1"

if not exist "ai-service" (
    mkdir "ai-service"
    if %ERRORLEVEL% neq 0 (
        echo [ERROR] Failed to create APP1\ai-service folder.
        goto :FAILURE
    )
    echo [OK]   Created: APP1\ai-service
) else (
    echo [SKIP] APP1\ai-service folder already exists.
)

cd /d "C:\Bixby-FSAI-Exam\APP1\ai-service"
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Failed to navigate to APP1\ai-service.
    goto :FAILURE
)

echo [INFO] Installing Python packages: flask, flask-cors, numpy, pandas, scikit-learn, joblib, requests...
pip install flask flask-cors numpy pandas scikit-learn joblib requests
if %ERRORLEVEL% neq 0 (
    echo [ERROR] pip install failed in APP1\ai-service.
    echo         Check your Python/pip installation and internet connection.
    goto :FAILURE
)
echo [OK]   Python packages installed for APP1\ai-service.

echo.
echo ============================================================
echo  STEP 3: Setting up APP2
echo ============================================================
echo.

REM ────────────────────────────────────────────────────────────
REM  STEP 3: APP2 Setup (same structure as APP1)
REM ────────────────────────────────────────────────────────────

cd /d "C:\Bixby-FSAI-Exam"

REM --- Create APP2 folder ---
if not exist "C:\Bixby-FSAI-Exam\APP2" (
    mkdir "C:\Bixby-FSAI-Exam\APP2"
    if %ERRORLEVEL% neq 0 (
        echo [ERROR] Failed to create APP2 folder.
        goto :FAILURE
    )
    echo [OK]   Created: C:\Bixby-FSAI-Exam\APP2
) else (
    echo [SKIP] APP2 folder already exists.
)

REM --- APP2 Backend Setup ---
echo.
echo [INFO] Setting up APP2 Backend (Node.js + Express + MongoDB)...
if not exist "C:\Bixby-FSAI-Exam\APP2\backend" (
    mkdir "C:\Bixby-FSAI-Exam\APP2\backend"
    if %ERRORLEVEL% neq 0 (
        echo [ERROR] Failed to create APP2\backend folder.
        goto :FAILURE
    )
    echo [OK]   Created: APP2\backend
) else (
    echo [SKIP] APP2\backend folder already exists.
)

cd /d "C:\Bixby-FSAI-Exam\APP2\backend"
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Failed to navigate to APP2\backend.
    goto :FAILURE
)

if not exist "package.json" (
    echo [INFO] Initializing npm project in APP2\backend...
    call npm init -y
    if %ERRORLEVEL% neq 0 (
        echo [ERROR] npm init failed in APP2\backend.
        goto :FAILURE
    )
    echo [OK]   npm initialized in APP2\backend.
) else (
    echo [SKIP] package.json already exists in APP2\backend.
)

echo [INFO] Installing backend packages: express, mongoose, cors, body-parser...
call npm install express mongoose cors body-parser
if %ERRORLEVEL% neq 0 (
    echo [ERROR] npm install failed in APP2\backend.
    echo         Check your internet connection and try again.
    goto :FAILURE
)
echo [OK]   Backend packages installed for APP2.

REM --- APP2 Frontend Setup ---
echo.
echo [INFO] Setting up APP2 Frontend (React)...
cd /d "C:\Bixby-FSAI-Exam\APP2"
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Failed to navigate to APP2.
    goto :FAILURE
)

if not exist "frontend" (
    echo [INFO] Creating React app in APP2\frontend (this may take a few minutes)...
    call npx create-react-app frontend
    if %ERRORLEVEL% neq 0 (
        echo [ERROR] create-react-app failed for APP2\frontend.
        echo         Check your internet connection and Node.js version.
        goto :FAILURE
    )
    echo [OK]   React app created in APP2\frontend.
) else (
    echo [SKIP] APP2\frontend already exists. Skipping create-react-app.
)

cd /d "C:\Bixby-FSAI-Exam\APP2\frontend"
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Failed to navigate to APP2\frontend.
    goto :FAILURE
)

echo [INFO] Installing axios in APP2\frontend...
call npm install axios
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Failed to install axios in APP2\frontend.
    goto :FAILURE
)
echo [OK]   axios installed in APP2\frontend.

REM --- APP2 AI Service Setup ---
echo.
echo [INFO] Setting up APP2 AI Service (Flask + ML)...
cd /d "C:\Bixby-FSAI-Exam\APP2"

if not exist "ai-service" (
    mkdir "ai-service"
    if %ERRORLEVEL% neq 0 (
        echo [ERROR] Failed to create APP2\ai-service folder.
        goto :FAILURE
    )
    echo [OK]   Created: APP2\ai-service
) else (
    echo [SKIP] APP2\ai-service folder already exists.
)

cd /d "C:\Bixby-FSAI-Exam\APP2\ai-service"
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Failed to navigate to APP2\ai-service.
    goto :FAILURE
)

echo [INFO] Installing Python packages: flask, flask-cors, numpy, pandas, scikit-learn, joblib, requests...
pip install flask flask-cors numpy pandas scikit-learn joblib requests
if %ERRORLEVEL% neq 0 (
    echo [ERROR] pip install failed in APP2\ai-service.
    echo         Check your Python/pip installation and internet connection.
    goto :FAILURE
)
echo [OK]   Python packages installed for APP2\ai-service.

echo.
echo ============================================================
echo  STEP 4: Setting up AngularAPP
echo ============================================================
echo.

REM ────────────────────────────────────────────────────────────
REM  STEP 4: AngularAPP Setup
REM ────────────────────────────────────────────────────────────

REM --- Install Angular CLI Globally ---
echo [INFO] Installing Angular CLI globally...
call npm install -g @angular/cli
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Failed to install @angular/cli globally.
    echo         Try running this script as Administrator.
    goto :FAILURE
)
echo [OK]   Angular CLI installed globally.

REM --- Verify Angular CLI ---
where ng >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Angular CLI (ng) is not available after installation.
    echo         Try closing and reopening your terminal, or run as Administrator.
    goto :FAILURE
)
echo [OK]   Angular CLI verified.

REM --- Create Angular App ---
cd /d "C:\Bixby-FSAI-Exam"
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Failed to navigate to C:\Bixby-FSAI-Exam.
    goto :FAILURE
)

if not exist "AngularAPP" (
    echo [INFO] Creating Angular application (this may take a few minutes)...
    call ng new AngularAPP --routing --style=css --skip-git
    if %ERRORLEVEL% neq 0 (
        echo [ERROR] ng new AngularAPP failed.
        echo         Check your Angular CLI installation and internet connection.
        goto :FAILURE
    )
    echo [OK]   Angular application created: AngularAPP
) else (
    echo [SKIP] AngularAPP folder already exists. Skipping creation.
)

echo.
echo ============================================================
echo  SETUP COMPLETE!
echo ============================================================
echo.
echo  Project Root:  C:\Bixby-FSAI-Exam
echo.
echo  Structure:
echo    C:\Bixby-FSAI-Exam\
echo    +-- APP1\
echo    ^|   +-- backend\       (Node.js + Express + MongoDB)
echo    ^|   +-- frontend\      (React Application)
echo    ^|   +-- ai-service\    (Flask + ML Models)
echo    +-- APP2\
echo    ^|   +-- backend\       (Node.js + Express + MongoDB)
echo    ^|   +-- frontend\      (React Application)
echo    ^|   +-- ai-service\    (Flask + ML Models)
echo    +-- AngularAPP\         (Angular Application)
echo.
echo  To Run:
echo    APP1/APP2 Backend:   cd backend   ^& node server.js
echo    APP1/APP2 Frontend:  cd frontend  ^& npm start
echo    APP1/APP2 AI:        cd ai-service ^& python app.py
echo    AngularAPP:          cd AngularAPP ^& ng serve
echo.
echo  Ports:
echo    APP1 Backend :5000   ^|  APP1 Frontend :3000  ^|  APP1 AI :5001
echo    APP2 Backend :5002   ^|  APP2 Frontend :3001  ^|  APP2 AI :5003
echo    AngularAPP   :4200
echo.
echo ============================================================
goto :END

:FAILURE
echo.
echo ============================================================
echo  [SETUP FAILED] An error occurred during setup.
echo  Please review the error messages above and fix the issue.
echo  You can safely re-run this script - it will skip steps
echo  that have already been completed successfully.
echo ============================================================
echo.

:END
endlocal
pause
