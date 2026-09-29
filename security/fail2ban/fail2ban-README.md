# 1. Install fail2ban if not already installed

sudo apt-get update && sudo apt-get install -y fail2ban

# 2. Create or open the jail.local configuration file

sudo nano /etc/fail2ban/jail.local

# (Paste the configuration above, then save and exit)

# 3. Enable and start the fail2ban service

sudo systemctl enable fail2ban
sudo systemctl restart fail2ban

# 4. Check the status of active jails

sudo fail2ban-client status
