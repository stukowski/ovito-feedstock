setlocal EnableDelayedExpansion

set MENU_DIR=%PREFIX%\Menu
if not exist %MENU_DIR% mkdir %MENU_DIR%

copy %RECIPE_DIR%\ovito.ico %MENU_DIR%
copy %RECIPE_DIR%\menu-windows.json %MENU_DIR%\ovito.json

:: Configure using the CMakeFiles
cmake -G "NMake Makefiles" ^
      -D Python3_ROOT_DIR=%BUILD_PREFIX% ^
      -D Python3_FIND_STRATEGY=LOCATION ^
      -D Python3_FIND_VIRTUALENV=ONLY ^
      -D Python3_EXECUTABLE=%PYTHON% ^
      -D OVITO_BUILD_DOCUMENTATION=ON ^
      -D OVITO_BUILD_GUI=ON ^
      -D OVITO_BUILD_MONOLITHIC=OFF ^
      -D OVITO_REDISTRIBUTABLE_PACKAGE=OFF ^
      -D OVITO_USE_PRECOMPILED_HEADERS=ON ^
      -D OVITO_BUILD_PYTHON_PACKAGE=OFF ^
      -D OVITO_BUILD_CONDA=ON ^
      -D CMAKE_BUILD_TYPE=Release ^
      -D CMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
      -D CMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
      %SRC_DIR%
if errorlevel 1 exit 1

nmake
if errorlevel 1 exit 1

nmake install
if errorlevel 1 exit 1
