#!/bin/bash

# Benjamin Foote
# bfoote@meedan.net

function usage() {
    cat <<EOF

     usage:
          $0 /path/to/fake/root

     take files from a FAKEROOT 
     replace all configuration items with environmental variables sourounded by ddENVVARdd
     then copy the file into the proper place based on it's name/dir

     for example, the file
           /path/to/fake/root/etc/dnsmaq/dnsmasq.conf
     would have all ddHOSTNAMEdd variables replaced
     and then it would be copied to 
           /etc/dnsmaq/dnsmasq.conf

EOF

}


ROOT=$1

if [ "" = "${ROOT}" ]
then
    usage
    exit;
fi

function config_replace() {
    VAR=$1
    VAL=$2
    FILE=$3
    CMD="s/dd{{$VAR}}dd/$VAL/g"
    sed -i'.bak' -e ${CMD} ${FILE}
}

function copy_into_place() {
    FILE=$1
    FROM=$FILE
    TO=$(echo $FILE | sed -e "s|^${ROOT}||")
    cp $FROM $TO
}


for FILE in $(find $ROOT -type f)
do
    echo $FILE
    
    for ENV in $( env | cut -d= -f1)
    do
	config_replace $ENV ${!ENV} $FILE
    done

    copy_into_place $FILE

done

exit;

#

