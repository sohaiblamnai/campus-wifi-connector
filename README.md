# 🛜 FSR Campus Connectee - Auto Login

A lightweight and secure automation script to instantly connect to the **Campus Connectee** WiFi network at the Faculty of Sciences in Rabat (FSR). 

No more typing your student ID and password manually every time you open your laptop on campus!

## ✨ Features
* **One-click connection**: Run the script and you're online.
* **Precise targeting**: Designed specifically for the "Campus Connectee" WPA-Enterprise infrastructure.
* **🛡️ Secure by design**: The script is completely transparent. Your credentials are **never** hardcoded, stored in plain text, or sent over the internet. They are only used locally to authenticate with the university's router.

## 🛠️ Prerequisites
This script uses `nmcli` (NetworkManager Command Line Interface) and is optimized for Linux distributions (tested on Ubuntu/Debian).

## 🚀 Installation and Usage

1. **Clone the repository**
   Open your terminal and download the script:
```bash
   git clone https://github.com/sohaiblamnai/campus-wifi-connector.git
   cd wifi_campus.sh 

2. Make the script executable

   chmod +x wifi_campus.sh 

3. Run the connection

  ./wifi_campus.sh 
