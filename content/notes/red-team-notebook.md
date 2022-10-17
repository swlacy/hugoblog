---
slug: red-team-scratch-page
title: Red Team Scratch Page
authors: [sid]
keywords: ['sid', 'lacy', 'blog', 'website', 'cybersecurity', 'security', 'computer', 'red', 'team', 'tech', 'notes']
tags: [redteam]
description: Collection of common commands, short scripts, and procedures I use while red teaming
summary: Collection of common commands and procedures I use while red teaming
date: 2022-10-15
showtoc: true
cover:
    image: "/media/red-team-scratch-page-cover.jpg"
    alt: "Picture of broken glass"
    caption: "@katelyn_g, (Unsplash, 2022)"
draft: false
---

This page serves as an unordered collection of commands, short scripts, and techniques I often employ while red teaming (AKA the copy-and-paste page). *Note: this page is continually updated.*

## Setup
Set `$targetip` and `$targethost` first.
```bash
# Add /etc/hosts entry
echo "$targetip $targethostname" | sudo tee -a /etc/hosts

# Make work structure in current directory
mkdir $targethost && cd $targethost
mkdir scans files scripts

# Set up notes page with preliminary info, including date, hostname, and IP address
echo -e "# $targethost\n*Date: $(date '+%Y-%m-%d')*\n\nHostname: $targethost\nIP addr: $targetip" > notes.md
```

## Host Enumeration With NMAP
Scan a CTF target for the first time (AKA, an environment which doesn't require stealth):
```bash
nmap -A -T4 -v -oA scans $host
```

 - `-A`: agressive scan with default scripts, OS detection, version detection, and traceroute 
 - `-T4`: agressive timing
 - `-v`: verbose mode; show output live
 - `-oA`: Save scan results in `.nmap`, `.xml`, and `.gnmap` formats

## Webserver Directory Fuzzing With Gobuster
Dir-fuzz a webserver (tailored towards web exploitation HTB machines):
```bash
gobuster dir -u $host -w $wordlist -t 20 -x $filetype1,$filetype2,$filetype3`
```
 - `dir`: Look for directories and files
 - `-w`: word list to use
    - `/usr/share/dirbuster/wordlists/directory-list-2.3-medium.txt` is a good large list (default path on Parrot)
    - `/usr/share/wordlists/dirb/big.txt` is a good small list (default path on Parrot)
 - `-t`: threads (concurrency); default is 10
 - `-x`: filetypes to look for (ex. `php,txt`)
 - `-oA`: Save scan results in .nmap, .xml, and .gnmap formats

## Reverse Shell Stabilization (Linux Victim) With Python and Perl
Upgrade a basic shell to a fully interactive shell:
```bash
# If Python is installed on the victim host, execute this there
python -c 'import pty; pty.spawn("/bin/bash")' # Or whatever shell you desire

# If Perl is installed on the victim host, execute this there
perl -e "exec '/bin/bash';" # Or whatever shell you desire
```

## Login With Custom SSH Identity
Make sure to have the key on hand.
```bash
# Store the SSH identity
echo $key > $id.pub
# Apply required permissions
chmod 600 $id.pub
# Login
ssh -i $id.pub $host
```
