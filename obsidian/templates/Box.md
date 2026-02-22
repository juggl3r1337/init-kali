# 📦 Target Analysis: {{title}}

📅 **Date:** {{date}}
⏰ **Time:** {{time}}
🖥️ **OS:** 
🎯 **IP:** 
```blade-bash tab="ops" pane="one"
# Set Target IP Variable for Blade Runner
ip="CHANGE_ME"
```

---

## 🏁 Killchain Checklist
*Insert these templates as you progress through the engagement.*

- [ ] **Reconnaissance**
    - `AI-Web-Enumeration` (Ffuf, Nikto, WPScan)
    - `AI-Network-Recon` (DNS, SMTP, SNMP, SQL)
- [ ] **Enumeration**
    - `AI-ActiveDirectory-Enum` (NetExec, BloodHound, BloodyAD)
- [ ] **Initial Access**
    - `AI-File-Transfers` (PowerShell, Certutil, SMB)
- [ ] **Lateral Movement**
    - `AI-Pivoting` (Chisel, Ligolo-ng, SSH)
- [ ] **Privilege Escalation**
    - `AI-Linux-PrivEsc` (LinPEAS, SUID, Kernel)
    - `AI-Windows-PrivEsc` (WinPEAS, System Info)
- [ ] **Post-Exploitation**
    - `AI-ActiveDirectory-Attacks` (Dumping, Kerberoasting, GPP)

---

## 🚀 Startup Commands

### Fast Scan (RustScan)
```blade-bash tab="ops" pane="one"
sudo rustscan -t 3000 --tries 2 -b 8192 -u 16384 -a $ip -- -sC -sV -A -T4
```

### UDP Scan
```blade-bash tab="ops" pane="one"
sudo rustscan -t 3000 --tries 2 -b 8192 -u 16384 -a $ip -- -sU --top-ports 100
```

### AutoRecon
```blade-bash tab="ops" pane="one"
sudo $(which autorecon) $ip -v --heartbeat 20
```

---

## 🔍 1. Reconnaissance (Web & Network)



---

## 👤 2. Enumeration (Users & AD)

### 👥 Users


### 🔑 Credentials


### 🏰 AD Enumeration


---

## 🔓 3. Initial Access & Exploitation

### Working Exploits


### Initial Access Shell


---

## 🦀 4. Lateral Movement (Pivoting)


---

## 👑 5. Privilege Escalation

### Strategy & vectors


---

## 🏴 6. Post-Exploitation


---

## 🏁 7. PWND (Proof)

### Linux Proof
```blade-bash tab="ops" pane="one"
hostname && id && cat /root/proof.txt && ip a
```

### Windows Proof
```blade-bash tab="ops" pane="one"
hostname && whoami && type C:\Users\Administrator\Desktop\proof.txt && ipconfig
```

---

## 📝 Notes & Reporting

### 💡 Take Away Concepts
*   

### 🚩 Problems & Blockers
*   

### 🧐 Interesting Findings
*   
