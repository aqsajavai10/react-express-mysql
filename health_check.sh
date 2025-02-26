#!/bin/bash
LOGFILE="/var/log/web_app_health.log"
timestamp() {
  date +"%Y-%m-%d %H:%M:%S"
}
if [[ "Darwin" == "Darwin" ]]; then
  if ! pgrep -f "npm start" > /dev/null; then
    echo "$(timestamp) - Web App is down. Restarting..." | tee -a 
    sudo launchctl start com.web-app
  fi
else
  SERVICE="web-app.service"
  if ! systemctl is-active --quiet ; then
    echo "$(timestamp) -  is down. Restarting..." | tee -a 
    sudo systemctl restart 
  fi
fi
