ns=$1
if [[ -z "$ns" ]]; then
	echo "1.Namespace argument missing"
	exit
fi

version=$2
if [[ -z "$version" ]]; then
	echo "2.Version argument missing"
	exit
fi

kubectl get deployments -n $ns \
    | grep blade \
    | cut -d' ' -f 1 \
    | xargs -I {} kubectl patch deployment -n $ns {} --patch  \
    '{"spec": {"template": {"spec": {"containers":[{ "name": "{}", "image": "devhub-docker.cisco.com/cloudcenter-dev-docker/blade-5.0.0/cloudcenter/cloudblade:blade-5.0.0-'$version'-5.0.0-SNAPSHOT" }] }}}}'

patchSetup=$3
if [[  "$patchSetup" == "Y" ]]; then 
    kubectl get deployments -n $ns \
    | grep setup \
    | cut -d' ' -f 1 \
    | xargs kubectl patch deployment -n $ns --patch \
    '{"spec": {"template": {"spec": {"containers":[{ "name": "cloudcenter-cloud-setup", "env": [{ "name": "CB_WORKER_IMAGE_TAGPREFIX", "value": "'$version'" }] }] }}}}'
fi