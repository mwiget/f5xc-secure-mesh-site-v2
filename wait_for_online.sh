#!/bin/bash

site_name_filter=$(grep ^project_prefix terraform.tfvars | cut -d\" -f2)

f5xc_api_url=$(grep ^f5xc_api_url terraform.tfvars | cut -d\" -f2)
f5xc_tenant=$(grep ^f5xc_tenant terraform.tfvars | cut -d\" -f2)
api_token=$(grep ^f5xc_api_token terraform.tfvars | cut -d\" -f2)
aws_region=$(grep ^aws_region terraform.tfvars | cut -d\" -f2)
aws_ami_name=$(grep ^aws_ami_name terraform.tfvars | cut -d\" -f2)

master_node_count=$(grep ^master_node_count terraform.tfvars | cut -d= -f2)
aws_site_count=$(grep ^aws_site_count terraform.tfvars | cut -d= -f2)

# "ONLINE" "PROVISIONING" "UPGRADING" "STANDBY" "FAILED" "REREGISTRATION" "WAITINGNODES" "DECOMMISSIONING" "WAITING_FOR_REGISTRATION"

start_time=$(date -u)
SECONDS=0

echo "# aws_region $aws_region f5xc_tenant $f5xc_tenant" aws_ami_name $aws_ami_name
echo "#"
echo "# $aws_site_count sites with $master_node_count master nodes each"
echo "#"
echo "# start_time : $start_time"
echo "#"
echo "# minutes,total,waiting_for_registration,provisioning,upgrading,online,decommissioning,failed"

while true; do

  sites=$(curl -s -X 'GET' \
    "$f5xc_api_url/config/namespaces/system/sites?response_format=GET_RSP_FORMAT_DEFAULT" \
    -H 'accept: application/data' \
    -H 'Access-Control-Allow-Origin: *' \
    -H 'Authorization: APIToken '"$api_token" \
    -H 'x-volterra-apigw-tenant: '"$f5xc_tenant" | jq -r '.items[].name' | grep $site_name_filter)

  status_total=0
  status_online=0
  status_provisioning=0
  status_upgrading=0
  status_failed=0
  status_decommissioning=0
  status_waiting_for_registration=0

  for site in $sites; do
    status=$(curl -s -X 'GET' \
      "$f5xc_api_url/config/namespaces/system/sites/$site?response_format=GET_RSP_FORMAT_DEFAULT" \
      -H 'accept: application/data' \
      -H 'Access-Control-Allow-Origin: *' \
      -H 'Authorization: APIToken '"$api_token" \
      -H 'x-volterra-apigw-tenant: '"$f5xc_tenant" | jq -r '.spec.site_state')

    ((status_total++))
    if [ "$status" == "ONLINE" ]; then ((status_online++)); fi
    if [ "$status" == "PROVISIONING" ]; then ((status_provisioning++)); fi
    if [ "$status" == "UPGRADING" ]; then ((status_upgrading++)); fi
    if [ "$status" == "FAILED" ]; then ((status_failed++)); fi
    if [ "$status" == "DECOMMISSIONING" ]; then ((status_decommissioning++)); fi
    if [ "$status" == "WAITING_FOR_REGISTRATION" ]; then ((status_waiting_for_registration++)); fi

    # echo "$site: $status" >&2
  done

  remaining=$((status_total - status_online))
  # now=$(date -u +'%Y%m%d-%H%M%S')   # 20240809-085528
  minutes=$(echo "scale=1; $SECONDS / 60" | bc)

  echo "$minutes,$status_total,$status_waiting_for_registration,$status_provisioning,$status_upgrading,$status_online,$status_decommissioning,$status_failed # remaining: $remaining"

  if [ $status_total -eq $status_online ]; then
    finish_time=$(date -u)
    echo "#"
    echo "# Sites: $sites"
    echo "#"
    echo "# $status_online site(s) matching $site_name_filter online"
    echo "#"
    echo "# start_time : $start_time"
    echo "# finish_time: $finish_time"
    exit 0
  fi

  sleep 30
done
