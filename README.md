# Multiplatform SDL2 project template

A multiplatform SDL2 project template for game development.

## Dependencies

Git must be installed on all platforms. The following sections describes the dependencies on each platform.
    
### Linux

- GNU Make
- Bash
- ar
- g++-4.8 or greater
- dpkg-deb  (for Debian package)
- fakeroot
- lintian
- gzip

### Windows

- Cygwin (GNU Make must be installed)
- Visual Studio (cl.exe, lib.exe and link.exe)

The Visual Studio compiler `cl.exe` needs a proper setup to work in Cygwin. Put the script `runcl.bat` below in your PATH:

	@echo off
	:: PATH_TO_SCRIPT is the path to vcvars script in Visual Studio installation. Example:
	:: call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvars64.bat"
	call "PATH_TO_SCRIPT\vcvars64.bat"

	:: PATH_TO_CL is the path to cl.exe in Visual Studio installation. Example:
	:: "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Tools\MSVC\14.10.25017\bin\HostX64\x64\cl.exe" %*
	"C:PATH_TO_CL\cl.exe" %*

Do the same for the `lib.exe` and `link.exe` (scripts `runlib.bat` and `runlink.bat`), changing only the last line, replacing `cl.exe` for the proper tool.

Visual Studio Community does not install C++ support by default. You must select C++ on installer manually.

### Mac OSX

- GNU Make
- Bash
- ar
- clang
