#!/bin/bash
# 下面这些需要填写
API_KEY="你的APIKEY"
API_EMAIL="你的邮箱"
ZONE_ID="你的空间ID"
RECORD_NAME="你的域名"
# CloudflareST的目录路径
cf_directory="/root"
#上面的内容需要填写
cd "$cf_directory"
record_info=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records?type=A&name=$RECORD_NAME" \
     -H "X-Auth-Email: $API_EMAIL" \
     -H "X-Auth-Key: $API_KEY" \
     -H "Content-Type: application/json")
record_id=$(echo "$record_info" | grep -oP '(?<="id":")[^"]+' | head -1)
if [ -z "$record_id" ]; then
  echo "无法提取记录ID"
  exit 1
fi
echo "域名$RECORD_NAME 的RECORD NAME为 $record_id"
./CloudflareST -n 100 -f ip.txt
bestip=$(sed -n '2p' ./result.csv | cut -d ',' -f 1)
update_result=$(curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$record_id" \
     -H "X-Auth-Email: $API_EMAIL" \
     -H "X-Auth-Key: $API_KEY" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'"$RECORD_NAME"'","content":"'"$bestip"'","ttl":1,"proxied":false}')
