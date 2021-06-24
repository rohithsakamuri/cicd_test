#!/bin/bash -f
echo "** This is the bash shell wrapper to submit 'N' deployments **"

MAX_DEPLOY=25
deploys=1

while [ $deploys -le $MAX_DEPLOY ]
do
	echo "INFO: Deploy start ${deploys}"
	sed '4s/\(.*\)\"\(.*\)\": \"\(.*\)\"/\1\"\2\": \"\3'${deploys}'\"/' aNomura_ES_and_2VMs_Nov24th.json > aNomura_ES_and_2VMs_Nov24th_${deploys}.json
	sed -n '4p' aNomura_ES_and_2VMs_Nov24th_${deploys}.json
	let "deploys = deploys + 1"
done


