# 🔐 cracking_password.sh
This Bash script automates the process of extracting password hashes from .zip and .rar files and attempts to crack them using John the Ripper with a given wordlist.

---

## 📜 Description
The script:
- Checks for exactly two input arguments: the target file and a wordlist.
- Determines if the input file is a .zip or .rar.
- Uses the appropriate *2john tool to extract the hash.
- Launches John the Ripper with the provided wordlist to crack the password.
- Displays the result if a password is found.
- Cleans up the generated hash file.

## ⚙️ Usage
```bash
./script.sh <file> <wordlist>
```

## 🧾 Arguments:
- **file**: The .zip or .rar file you want to crack.
- **wordlist**: The path to your wordlist file (e.g. rockyou.txt).

## ✅ Example:
```bash
./script.sh secret.zip /usr/share/wordlists/rockyou.txt
```

## ⚠️ Requirements
1. zip2john or rar2john (depending on file type)
2. John the Ripper
3. A compatible wordlist (e.g., rockyou.txt)

## ❌ Error Handling
- If the number of arguments is incorrect, it shows a usage message.
- If the file extension is unsupported, it notifies the user and exits.

## 📂 Output
- Displays the cracked password if successful.
- Removes the temporary hash file after the process.
