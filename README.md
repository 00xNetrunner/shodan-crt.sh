# shodan-crt.sh 🌐🔍

![GitHub](https://img.shields.io/github/license/your-username/shodan-crt.sh)
![GitHub last commit](https://img.shields.io/github/last-commit/your-username/shodan-crt.sh)
![GitHub issues](https://img.shields.io/github/issues/your-username/shodan-crt.sh)
![GitHub stars](https://img.shields.io/github/stars/your-username/shodan-crt.sh?style=social)

`shodan-crt.sh` is a script designed to automate the process of gathering Open Source Intelligence (OSINT) on a particular domain. It extracts subdomains using crt.sh, resolves them to IP addresses, and then queries Shodan for detailed information about these IPs.

## 🚀 Features
- **Subdomain Extraction**: Fetch subdomains from crt.sh.
- **IP Resolution**: Resolve each subdomain to its corresponding IP address.
- **Shodan Lookup**: Query resolved IPs on Shodan for a detailed security footprint.

## 📋 Prerequisites
- [jq](https://stedolan.github.io/jq/): Command-line JSON processor.
- [curl](https://curl.se/): Command-line tool for transferring data with URLs.
- [Shodan CLI](https://cli.shodan.io/): Tool to interact with the Shodan API.

## 🔑 Shodan API Key Setup
Before using the script, initialize your Shodan CLI with your API key:

```bash
shodan init YOUR_API_KEY
```

Replace YOUR_API_KEY with your actual Shodan API key. Get your API key from your Shodan account.

## 🛠️ Installation
Clone the repository and make the script executable:

```bash
git clone https://github.com/your-username/shodan-crt.sh.git
cd shodan-crt.sh
chmod +x shodan-crt.sh
```

## 📝 Usage
Run the script by passing the target domain as an argument:
```bash
./shodan-crt.sh <domain>
```
For example:

```bash
./shodan-crt.sh example.com
```

## ⚙️ Customization
The script can be easily customized to fit more specific OSINT requirements or workflows.
