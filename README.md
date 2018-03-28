# Instashell v1.5.2
## Creator: github.com/thelinuxchoice   
## Co-author: github.com/XIshArkIX (Currently Translate Repository)

Instashell is an Shell Script to perform brute force attack against Instagram, this script can bypass login limiting on wrong passwords, so basically it can test infinite number of passwords.

![instashell](https://user-images.githubusercontent.com/34893261/37567580-c98d3a58-2aa7-11e8-9022-a5bc86326302.png)

### Before usage:
```bash
git clone https://github.com/XIshArkIX/instashell
cd instashell
chmod +x installreq.sh
sudo ./installreq.sh
```

### Usage:
```bash
chmod +x instashell.sh
sudo ./instashell.sh
```

#### Features from original repository:
* Save/Resume sessions
* Anonymous attack through TOR
* Multi-thread (400 pass/min, 20 threads)

### How it works?

Script uses an Android ApkSignature to perform authentication in addition using TOR to change the ip address once blocked for many tries and continue attack.
