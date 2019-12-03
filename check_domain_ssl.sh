#!/usr/bin/env sh
export LANG="en_US.UTF-8"

if [ ! -n "$1" ];then
    echo "usage: ./check_domain_ssl.sh domain"
    exit
fi

domain=$1
endtime=$(echo | openssl s_client -servername $domain -connect ${domain}:443 2>/dev/null| openssl x509 -noout -dates|grep After | awk -F '=' '{print $2}'| awk '{print $1,$2,$4 }')
nowtime=$(date | awk -F ' +'  '{print $2,$3,$6}')
endtimestamp=$(date +%s -d "$endtime")
nowtimestamp=$(date +%s -d "$nowtime")
let diffstamp=$endtimestamp-$nowtimestamp
let oneday=60*60*24
let result=diffstamp/oneday
echo $result
