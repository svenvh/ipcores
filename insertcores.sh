#!/bin/bash
#
# Inserts implementations of known cores into an ESPAM-generated ISE/XPS pcores directory.
# Usage:
#   insertcores.sh <espam-output-directory>
#
# Sven van Haastregt, LIACS, Leiden University.

# Script configuration:
# Path to the IP core library:
IPCORELIBPATH="/projects/ipcores"

# Handles a simple core consisting of only 1 VHDL file
handle_simplecore() {
  CORENAME=$1
  TARGETDIR=$2
  LATENCY=$3
  IP_II=$4
  echo -n "${CORENAME} ... "
  cp ${IPCORELIBPATH}/$CORENAME.vhd $TARGETDIR/hdl/vhdl
  sed -r -i "s/c_STAGES       : natural := [0-9]+;/c_STAGES       : natural := ${LATENCY};/" $TARGETDIR/hdl/vhdl/HWN_*.vhd
  sed -r -i "s/c_IP_II        : natural := [0-9]+;/c_IP_II        : natural := ${IP_II};/" $TARGETDIR/hdl/vhdl/HWN_*.vhd
  echo -n "L=${LATENCY} II=${IP_II}"
}

if [ $# -ne 1 ]; then
  echo "Usage: insertcores.sh <espam-output-directory>"
  echo "       The specified directory should have a subdirectory 'pcores'."
  exit 0
fi

DESTDIR=$1
shopt -s nullglob
FILELIST=$DESTDIR/pcores/HWN*

for f in $FILELIST; do
  echo -n "Analyzing $f ...  "
  COREDIR=$f/hdl/vhdl/*.vhd
  for g in $COREDIR; do
    filename=`basename $g .vhd`
    case $filename in
      copy|copy1|copy2|copy3)
        handle_simplecore $filename $f 1 1
      ;;

      copyneg)
        handle_simplecore $filename $f 1 1
      ;;

      add)
        handle_simplecore $filename $f 1 1
      ;;

      mul)
        handle_simplecore $filename $f 4 1
      ;;

      multacc)
        handle_simplecore $filename $f 4 1
      ;;

      # Sort
      compareswap1|compareswap2)
        handle_simplecore $filename $f 1 1
      ;;
    esac
  done
  echo
done
