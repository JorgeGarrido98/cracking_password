#!/bin/bash

# Colors (foreground)
RED="\033[1;31m"
GREEN="\033[1;32m"
BLUE="\033[1;34m"

# Reset
RESET="\033[0m"

# Title Script
echo -e "${RED}"
cat << "EOF"

  /$$$$$$  /$$$$$$$   /$$$$$$   /$$$$$$  /$$   /$$ /$$$$$$ /$$   /$$  /$$$$$$        /$$$$$$$   /$$$$$$   /$$$$$$   /$$$$$$  /$$      /$$  /$$$$$$  /$$$$$$$  /$$$$$$$ 
 /$$__  $$| $$__  $$ /$$__  $$ /$$__  $$| $$  /$$/|_  $$_/| $$$ | $$ /$$__  $$      | $$__  $$ /$$__  $$ /$$__  $$ /$$__  $$| $$  /$ | $$ /$$__  $$| $$__  $$| $$__  $$
| $$  \__/| $$  \ $$| $$  \ $$| $$  \__/| $$ /$$/   | $$  | $$$$| $$| $$  \__/      | $$  \ $$| $$  \ $$| $$  \__/| $$  \__/| $$ /$$$| $$| $$  \ $$| $$  \ $$| $$  \ $$
| $$      | $$$$$$$/| $$$$$$$$| $$      | $$$$$/    | $$  | $$ $$ $$| $$ /$$$$      | $$$$$$$/| $$$$$$$$|  $$$$$$ |  $$$$$$ | $$/$$ $$ $$| $$  | $$| $$$$$$$/| $$  | $$
| $$      | $$__  $$| $$__  $$| $$      | $$  $$    | $$  | $$  $$$$| $$|_  $$      | $$____/ | $$__  $$ \____  $$ \____  $$| $$$$_  $$$$| $$  | $$| $$__  $$| $$  | $$
| $$    $$| $$  \ $$| $$  | $$| $$    $$| $$\  $$   | $$  | $$\  $$$| $$  \ $$      | $$      | $$  | $$ /$$  \ $$ /$$  \ $$| $$$/ \  $$$| $$  | $$| $$  \ $$| $$  | $$
|  $$$$$$/| $$  | $$| $$  | $$|  $$$$$$/| $$ \  $$ /$$$$$$| $$ \  $$|  $$$$$$/      | $$      | $$  | $$|  $$$$$$/|  $$$$$$/| $$/   \  $$|  $$$$$$/| $$  | $$| $$$$$$$/
 \______/ |__/  |__/|__/  |__/ \______/ |__/  \__/|______/|__/  \__/ \______/       |__/      |__/  |__/ \______/  \______/ |__/     \__/ \______/ |__/  |__/|_______/ 

		                 			    		cracking_password.sh - v1.0
                                 		      	      		   Autor -> Jorge Garrido
EOF
echo -e "${RESET}"

# Code
# ---------- Check if exactly two arguments are passed ----------
if [ $# -ne 2 ]; then
        echo -e "${RED}Incorrect Use! <file> <wordlist>${RESET}"
        exit 1
fi

# ---------- Assign arguments to variables ----------
file=$1
wordlist=$2

# ---------- Check the file extension and use the appropriate tool to extract the hash ----------
case "$file" in
        *.zip)
                # Extract hash from a zip file using zip2john
                zip2john "$file" > hash
                ;;
        *.rar)
                # Extract hash from a rar file using rar2john
                rar2john "$file" > hash
                ;;
        *)
                # If file is not supported, exit with a message
                echo "${RED}Unsupported file type. Only .zip and .rar are allowed.${RESET}"
                exit 1
                ;;
esac

# ---------- Use John the Ripper with the provided wordlist to crack the password ----------
john --wordlist="$wordlist" hash

# ---------- Display the cracked password if found ----------
john --show hash

# ---------- Remove the temporary hash file ----------
rm hash
