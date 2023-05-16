# CloudFlareUpdateIP

执行CloudflareST并更新cloudflare中域名的A记录

## 这个脚本要配合CloudFlareST一起使用

你需要下载并编辑 start.sh中的

```bash
API_KEY="你的APIKEY"
API_EMAIL="你的邮箱"
ZONE_ID="你的空间ID"
RECORD_NAME="你的域名"
# CloudflareST的目录路径
cf_directory="/root"
```

字段

还需要提前设置好Cloudflare的域名解析，A记录 随便填一个IP

CloudflareST：https://github.com/XIU2/CloudflareSpeedTest

