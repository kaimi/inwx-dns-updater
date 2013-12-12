#!/usr/bin/env bash

configfile="nsupdate.conf"
xmlfile="nsupdatedata.xml"
site="http://www.myip.ch"

while getopts :c: o
do
  case $o in
    c)
      configfile=$OPTARG
      ;;
    \?)
      echo "ERROR: invalid option -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "ERROR: option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

if [ ! -f $configfile ]
then
  echo "ERROR: config file '$configfile' not found" >&2
  exit 1
fi
source $configfile

ns_ip=$(dig +short $hostname @ns.inwx.de)
wan_ip=$(curl -s www.myip.ch | grep -Po '(\d+\.){3}\d+')
date=$(date "+%F %T")

if [ ! "${ns_ip}" == "${wan_ip}" ]
then
  elements=${#entity_id[@]}
  for (( i=0;i<$elements;i++))
  do
    curl -sfo /dev/null -d "$(cat ${xmlfile} | sed "s/%user%/${username}/g;s/%pass%/${password}/g;s/%ns_ent_id%/${entity_id[${i}]}/g;s/%wan_ip%/${wan_ip}/g")" https://api.domrobot.com/xmlrpc/
  done
  retcode=$?
  if [ $retcode -ne 0 ]
  then
    echo "ERROR: failed to call xmlrpc API, curl return code: ${retcode}" >&2
  else
    echo "${date} – ${hostname} → ${wan_ip}"
  fi
fi
