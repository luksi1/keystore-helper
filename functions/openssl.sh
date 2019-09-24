#!/bin/bash 
#
# OpenSSL functions

set -e

###############
# View pkcs12 bundle
# Arguments:
#   in file
# Returns:
#   None
###############
function view_pkcs12_bundle {
  in=$1
  if [[ -f $in && ! -z $PASSWORD ]]; then
    keytool -list -v -keystore $in -storepass $PASSWORD -storetype pkcs12
  elif [[ -f $in ]]; then
    keytool -list -v -keystore $in -storetype pkcs12
  else
    echo "$in does not exist"
  fi
}

###############
# Create an x509 pem file
# Arguments:
#   in file
#   out file
# Returns:
#    None
###############
function create_x509 {
  in=$1
  out=$2
  if [[ -f $in ]]; then
    openssl x509 -inform DER -in $1 -out $2 -outform PEM
  else
    echo "$in does not exist"
  fi
}

################
# Create a pkcs12 certificate without keys
# Arguments:
#   in file
#   out file
# Returns:
#   None
################
function create_pkcs12_cert {
  in=$1
  out=$2
  PASSWORD=$3

  if [[ -f $in && ! -z $PASSWORD ]]; then
    openssl pkcs12 -in $in -out $out -nodes -nokeys -passin pass:${PASSWORD}
    openssl x509 -in $out -out $out -passin pass:${PASSWORD}
  elif [[ -f $in ]]; then
    openssl pkcs12 -in $in -out $out -nodes -nokeys 
    openssl x509 -in $out -out $out
  else
    echo "$in does not exist"
    exit 1
  fi
}

################
# Create a pkcs12 key
# Arguments:
#   in file
#   out file
# Returns:
#   None
################
function create_pkcs12_key {
  in=$1
  out=$2
  PASSWORD=$3

  if [[ -f $in && ! -z $PASSWORD ]]; then
    openssl pkcs12 -in $in -out $out -nodes -nocerts -passin pass:${PASSWORD}
    openssl rsa -in $out -out $out -passin pass:${PASSWORD}
  elif [[ -f $in ]]; then
    openssl pkcs12 -in $in -out $out -nodes -nocerts 
    openssl rsa -in $out -out $out
  else
    echo "$in does not exist"
    exit 1
  fi
}

##################
# Create Diffie-Helman parameter PEM file
# Arguments:
#   block size
#   out file
# Returns:
#   None
##################
function create_dhparam {
  block_size=$1
  out=$2

  if [[ ! -z $block_size && ! -z $out ]]; then
    openssl dhparam $block_size -out $out
  else
    echo "incorrect parameters when caling create_dhparam"
    echo "you need to indicate the 'block size' and the 'out file'"
    exit 1
  fi
}

##################
# Create pcks12 bundle
# Arguments:
#   key file
#   certificate file
#   bundle to create
# Returns:
#   None
##################
function create_pkcs12_bundle {
  key=$1
  in=$2
  out=$3
  if [[ -f $in && ! -z $PASSWORD ]]; then
    openssl pkcs12 -export -inkey $key -in $in -out $out -passin pass:${PASSWORD} -passout pass:${PASSWORD}
  elif [[ -f $in ]]; then
    openssl pkcs12 -export -inkey $key -in $in -out $out
  else
    echo "$in does not exist"
    exit 1
  fi
}

function change_pkcs12_bundle_password {
  in=$1
  oldpass=$2
  newpass=$3
  if [[ -f $in ]]; then
    openssl pkcs12 -in $in -out /tmp/temp.pem -nodes -passin pass:${oldpass}
    if [[ $? -gt 0 ]]; then
      echo "\"openssl pkcs12 -in $in -out /tmp/temp.pem -nodes\" did not work"
      exit 1
    fi
    mv $in ${in}.bak
    openssl pkcs12 -export -out $in -in /tmp/temp.pem -passout pass:${newpass}
    rm /tmp/temp.pem
  fi
}

function convert_jks_to_p12 {

  in=$1
  pass=$2
  alias=$3

  keytool -importkeystore -srckeystore $in -destkeystore "${in}.p12" -srcstoretype JKS -deststoretype PKCS12 -srcstorepass $pass -deststorepass $pass -srcalias $alias -destalias 1 -srckeypass $pass -destkeypass $pass -noprompt
}

function convert_p12_to_jks {

  in=$1
  out=$2
  pass=$3

  keytool -importkeystore -srckeystore $in -srcstoretype pkcs12 -srcstorepass $pass -srcalias 1 -destkeystore $out -deststoretype jks -deststorepass $pass -destalias 1

}

##################
# Create pem files from a Java keystore
# Arguments:
#   keystore
#   password
# Returns:
#   pem files in the form ${alias}.pem
##################
function create_pem_files_from_jks {
  keystore=$1
  pass=$2

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
for i in `keytool -list -v -keystore $keystore -storepass $pass | grep Alias | awk -F: '{print $2}' | sed 's/^\s//g'`; do keytool -keystore $keystore -alias $i -exportcert -storepass $pass -rfc -file ${i}.pem; done

}

function create_crt_from_jks_alias {
  keystore=$1
  pass=$2
  aliasname=$3
  keypass=$4

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
keytool -export -alias $aliasname -file /tmp/${aliasname}.der -keystore $keystore -storepass $pass; openssl x509 -inform der -in /tmp/${aliasname}.der -out ${aliasname}.crt; rm /tmp/${aliasname}.der

}

function create_key_from_jks_alias {
  keystore=$1
  pass=$2
  aliasname=$3
  keypass=$4

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
keytool -importkeystore -srckeystore $keystore -destkeystore /tmp/${aliasname}.p12 -deststoretype PKCS12 -srcstorepass $pass -deststorepass $pass -srckeypass $keypass -destkeypass $keypass -alias $aliasname; openssl pkcs12 -in /tmp/${aliasname}.p12 -nodes -nocerts -out ${aliasname}.key -passin pass:${PASSWORD}; rm /tmp/${aliasname}.p12
}
