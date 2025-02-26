#!/bin/bash
LOGFILE="/var/log/nginx/access.log"
echo "Top 3 IP addresses making requests:"
awk '{print }'  | sort | uniq -c | sort -nr | head -3
