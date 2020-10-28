setlocal EnableDelayedExpansion

set MENU_DIR=%PREFIX%\Menu
if not exist %MENU_DIR% mkdir %MENU_DIR%

copy %RECIPE_DIR%\ovito.ico %MENU_DIR%
copy %RECIPE_DIR%\menu-windows.json %MENU_DIR%\ovito.json

:: Configure using the CMakeFiles
cmake -G "NMake Makefiles" ^
      -DOVITO_BUILD_DOCUMENTATION=ON ^
      -DOVITO_BUILD_GUI=ON ^
      -DOVITO_BUILD_MONOLITHIC=OFF ^
      -DOVITO_REDISTRIBUTABLE_PACKAGE=OFF ^
      -DOVITO_USE_PRECOMPILED_HEADERS=ON ^
      -DOVITO_BUILD_PYTHON_PACKAGE=OFF ^
      -DOVITO_BUILD_CONDA=ON ^
      -DCMAKE_BUILD_TYPE=Release ^
      -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
      -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
      %SRC_DIR%
if errorlevel 1 exit 1

nmake
if errorlevel 1 exit 1

nmake install
if errorlevel 1 exit 1
