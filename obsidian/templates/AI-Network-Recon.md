# AI - Network Reconnaissance

## ⚡ Service Checklist
*Identify open ports and jump to the relevant enumeration strategy.*

- [ ] **DNS** (53) -> [[#DNS Enumeration]]
- [ ] **FTP** (21) -> [[#FTP Enumeration]]
- [ ] **SMTP** (25) -> [[#SMTP Enumeration]]
- [ ] **SNMP** (161) -> [[#SNMP Enumeration]]
- [ ] **NFS** (111/2049) -> [[#NFS Enumeration]]
- [ ] **MSSQL** (1433) -> [[#MSSQL (Port 1433)]]
- [ ] **MySQL** (3306) -> [[#MySQL (Port 3306)]]

---

## DNS Enumeration
*Basic and advanced DNS queries.*

**Zone Transfer**
```blade-bash tab="ops" pane="one"
dig axfr $domain @$ip
```

**Any Query**
```blade-bash tab="ops" pane="one"
dig any $domain @$ip
```

**Subdomain Brute Force**
```blade-bash tab="ops" pane="one"
dnsenum --dnsserver $ip --enum -p 0 -s 0 -o subdomains.txt -f /usr/share/seclists/Discovery/DNS/subdomains-top1million-110000.txt $domain
```

---

## SMTP Enumeration
*Mail server interaction.*

**Open Relay & User Enum**
```blade-bash tab="ops" pane="one"
sudo nmap $ip -p25 --script smtp-open-relay,smtp-enum-users -v
```

**Manual Verification**
```blade-bash tab="ops" pane="one"
nc -nv $ip 25
```

---

## SNMP Enumeration
*Community string brute force and enumeration.*

**Public Walk**
```blade-bash tab="ops" pane="one"
snmpwalk -v2c -c public $ip
```

**Brute Force Community Strings**
```blade-bash tab="ops" pane="one"
onesixtyone -c /usr/share/seclists/Discovery/SNMP/snmp.txt $ip
```

---

## FTP Enumeration
*File transfer protocol checks.*

**Download All Files**
```blade-bash tab="ops" pane="one"
wget -m --no-passive ftp://anonymous:anonymous@$ip
```

**Nmap Scripts**
```blade-bash tab="ops" pane="one"
sudo nmap -sV -p21 -sC -A $ip
```

---

## Database Enumeration

### MSSQL (Port 1433)
**Impacket Client**
```blade-bash tab="ops" pane="one"
impacket-mssqlclient $user@$ip -windows-auth
```

**Nmap Script Scan**
```blade-bash tab="ops" pane="one"
sudo nmap --script ms-sql-* --script-args mssql.username=sa,mssql.password=$password -p 1433 $ip
```

### MySQL (Port 3306)
**Connect**
```blade-bash tab="ops" pane="one"
mysql -u root -p$password -h $ip
```

**Nmap Script Scan**
```blade-bash tab="ops" pane="one"
sudo nmap -sV -sC -p3306 --script mysql* $ip
```

---

## NFS Enumeration
*Network File System shares.*

**List Exports**
```blade-bash tab="ops" pane="one"
showmount -e $ip
```

**Mount Share**
```blade-bash tab="ops" pane="one"
mkdir /mnt/nfs_share
sudo mount -t nfs $ip:/ /mnt/nfs_share -o nolock
```

**Nmap Script Scan**
```blade-bash tab="ops" pane="one"
sudo nmap --script nfs* -p 111,2049 $ip
```