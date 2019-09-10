#
# Wrap a shell script for execution in the development runtime environment.
#

if [ $# -ne 2 ] ; then
    echo "Usage: $0 source dest" 1>&2 
    exit 1
fi

src=$1
dst=$2



cat > $dst <<EOF1
#!/bin/sh
export KB_TOP=$KB_TOP
export KB_RUNTIME=$KB_RUNTIME
export PATH=$KB_RUNTIME/bin:$KB_TOP/bin:\$PATH
EOF1
for var in $WRAP_VARIABLES ; do
	val=${!var}
	if [ "$val" != "" ] ; then
		echo "export $var='$val'" >> $dst
	fi
done
cat >> $dst <<EOF
/bin/sh $src "\$@"
EOF

chmod +x $dst
