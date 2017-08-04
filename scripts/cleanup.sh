#!/bin/bash
#
# Clean all autogenerated files.
#

# Main
echo "Cleaning up..."
find . -name '*.o' -exec rm -f {} \;
find . -name '*.a' -exec rm -f {} \;
find . -name '*~' -exec rm -f {} \;
find . -name '*.obj' -exec rm -f {} \;
find . -name '*.deb' -exec rm -f {} \;
find . -name '*.msi' -exec rm -f {} \;

find src/ -name '*.lib' -exec rm -f {} \;

rm -rf bin/* .tmp

echo "Done"
