#!/bin/bash

# Task 1: Linux System Administration

# 1. Create systemd service for Node.js backend and React frontend (Linux) or launchd service (macOS)
if [[ "$(uname)" == "Darwin" ]]; then
  cat <<EOF | sudo tee /Library/LaunchDaemons/com.web-app.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>com.web-app</string>
    <key>ProgramArguments</key>
    <array>
      <string>/bin/bash</string>
      <string>-c</string>
      <string>cd /path/to/project/backend && npm start & cd /path/to/project/frontend && npm start</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
  </dict>
</plist>
EOF
  sudo launchctl bootstrap system /Library/LaunchDaemons/com.web-app.plist
  sudo launchctl start com.web-app
else
  cat <<EOF | sudo tee /etc/systemd/system/web-app.service
[Unit]
Description=React Frontend and Node.js Express Backend
After=network.target

[Service]
ExecStart=/bin/bash -c 'cd /path/to/project/backend && npm start & cd /path/to/project/frontend && npm start'
Restart=always
User=www-data
Group=www-data
Environment=PATH=/usr/bin:/usr/local/bin
Environment=NODE_ENV=production
WorkingDirectory=/path/to/project

[Install]
WantedBy=multi-user.target
EOF
  sudo systemctl daemon-reload
  sudo systemctl enable web-app.service
  sudo systemctl start web-app.service
fi

# 2. Kernel Tuning (Increase net.core.somaxconn)
if [[ "$(uname)" == "Darwin" ]]; then
  sudo sysctl -w kern.ipc.somaxconn=1024
else
  echo "net.core.somaxconn=1024" | sudo tee -a /etc/sysctl.conf
  sudo sysctl -p
fi

# 3. Firewall Setup
if [[ "$(uname)" == "Darwin" ]]; then
  sudo pfctl -F all -f /etc/pf.conf
  sudo pfctl -e
else
  sudo ufw allow 80/tcp
  sudo ufw allow 443/tcp
  sudo ufw enable
fi

# Task 2: Bash Scripting

# Health Check Script
cat <<EOF > health_check.sh
#!/bin/bash
LOGFILE="/var/log/web_app_health.log"
timestamp() {
  date +"%Y-%m-%d %H:%M:%S"
}
if [[ "$(uname)" == "Darwin" ]]; then
  if ! pgrep -f "npm start" > /dev/null; then
    echo "\$(timestamp) - Web App is down. Restarting..." | tee -a $LOGFILE
    sudo launchctl start com.web-app
  fi
else
  SERVICE="web-app.service"
  if ! systemctl is-active --quiet $SERVICE; then
    echo "\$(timestamp) - $SERVICE is down. Restarting..." | tee -a $LOGFILE
    sudo systemctl restart $SERVICE
  fi
fi
EOF
chmod +x health_check.sh
sudo chown $(whoami) health_check.sh

# Log Analysis Script
cat <<EOF > log_analysis.sh
#!/bin/bash
LOGFILE="/var/log/nginx/access.log"
echo "Top 3 IP addresses making requests:"
awk '{print $1}' $LOGFILE | sort | uniq -c | sort -nr | head -3
EOF
chmod +x log_analysis.sh
sudo chown $(whoami) log_analysis.sh


