#!/bin/sh
BASEDIR=$(dirname $0)
cd $BASEDIR

ConfFile="./gfw.conf"
TextFile="./gfw.txt"

rm -f $ConfFile".tmp"
cat $TextFile  | grep -v -e '^#' -e '^$' | while read SingleDomain
do
	echo "ipset=/$SingleDomain/vpn" >> $ConfFile".tmp"
	echo "server=/$SingleDomain/208.67.222.222#5353" >> $ConfFile".tmp"
done

set -x
if diff $ConfFile $ConfFile".tmp" > /dev/null; then
	rm $ConfFile".tmp"
else
	mv $ConfFile".tmp" $ConfFile
	md5sum $ConfFile > md5.txt
	gzip -9 -c $ConfFile > $ConfFile".gz"
fi
