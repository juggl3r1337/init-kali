# AI - Windows Privilege Escalation

## ⚡ PrivEsc Checklist
- [ ] **WinPEAS** -> [[#WinPEAS]]
- [ ] **System Info** -> [[#System Info]]
- [ ] **User Privs** -> [[#User & Group Info]]
- [ ] **Network** -> [[#Network]]
- [ ] **Services** -> [[#Services]]

---

## Automated Enumeration

### WinPEAS
*Download and run WinPEAS executable.*
```blade-bash tab="ops" pane="one"
winPEASx64.exe
```

---

## Manual Enumeration

### System Info
*Get OS version and patches.*
```blade-bash tab="ops" pane="one"
systeminfo
```

### User & Group Info
*Current user privileges.*
```blade-bash tab="ops" pane="one"
whoami /priv
```

*List all users.*
```blade-bash tab="ops" pane="one"
net user
```

*List local administrators.*
```blade-bash tab="ops" pane="one"
net localgroup administrators
```

### Network
*Active connections.*
```blade-bash tab="ops" pane="one"
netstat -ano
```

*Routing table.*
```blade-bash tab="ops" pane="one"
route print
```

### Services
*List running services.*
```blade-bash tab="ops" pane="one"
tasklist /svc
```

*Check for unquoted service paths.*
```blade-bash tab="ops" pane="one"
wmic service get name,displayname,pathname,startmode | findstr /i "auto" | findstr /i /v "c:\\windows\\" | findstr /i /v ""
```