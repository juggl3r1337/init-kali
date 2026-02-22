# AI - Web Enumeration

## ⚡ Web Checklist
- [ ] **Directories** -> [[#Directory Fuzzing]]
- [ ] **Virtual Hosts** -> [[#VHost Fuzzing]]
- [ ] **Extensions** -> [[#Extension Fuzzing]]
- [ ] **Parameters** -> [[#Parameter Fuzzing]]
- [ ] **CMS Scan** -> [[#CMS Scanning]]
- [ ] **Vuln Scan** -> [[#Nikto]]

---

## Ffuf (Fuzz Faster U Fool)

### Directory Fuzzing
*Basic directory scan.*
```blade-bash tab="ops" pane="one"
ffuf -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-small.txt:FUZZ -u http://$ip/FUZZ
```

### VHost Fuzzing
*Filter by size (-fs) to hide default responses.*
```blade-bash tab="ops" pane="one"
ffuf -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt:FUZZ -u http://$domain -H "Host: FUZZ.$domain" -fs 000
```

### Extension Fuzzing
*Look for php, txt, bak, zip files.*
```blade-bash tab="ops" pane="one"
ffuf -w /usr/share/seclists/Discovery/Web-Content/web-extensions.txt:FUZZ -u http://$ip/indexFUZZ
```

### Parameter Fuzzing
*Fuzz GET parameters.*
```blade-bash tab="ops" pane="one"
ffuf -w /usr/share/seclists/Discovery/Web-Content/burp-parameter-names.txt:FUZZ -u http://$ip/page.php?FUZZ=key -fs 000
```

---

## Nikto

### Basic Scan
```blade-bash tab="ops" pane="one"
nikto -h http://$ip
```

---

## CMS Scanning

### WPScan (WordPress)
*Enumerate users and vulnerable plugins.*
```blade-bash tab="ops" pane="one"
wpscan --url http://$ip --enumerate p,t,u
```