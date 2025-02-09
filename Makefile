CPPFLAGS = -nologo -std:c++17 -DNDEBUG -MD -O2 -GF -GR- -GL -EHsc
HEADERS = shim_executable.h shim.h
SHIMS = shim_gui.exe shim_console.exe

all: shim_executable.exe cleanup

.SILENT:

# SHIMS
$(SHIMS): $*.cpp $*.rc $(HEADERS)
	echo Building $*.exe
	$(RC) /nologo $*.rc
	$(CPP) $(CPPFLAGS) $*.cpp $*.res
	echo.


# Main Application
shim_executable.exe: $*.cpp $*.rc $*.h $(SHIMS)
	echo Building $*.exe
	$(RC) /nologo $*.rc
	$(CPP) $(CPPFLAGS) $*.cpp $*.res
	echo.


cleanup: 
	echo Removing intermediate files
	rm *.obj
	rm *.res
	rm $(SHIMS)

	echo Created checksum
	checksum shim_executable.exe -t sha256 > shim_executable.sha256

	echo Renamed and moved to .\bin
	mv shim_executable.exe .\bin\shim_exec.exe
	mv shim_executable.sha256 .\bin\shim_exec.sha256
