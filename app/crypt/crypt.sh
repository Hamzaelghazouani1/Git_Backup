#!/bin/bash

# Function to encrypt a zipped folder using AES
encrypt() {
    # Check if number of arguments is correct
    if [ "$#" -ne 3 ]; then
        echo "Usage: encrypt <zip_file> <output_enc_file> <password>"
        return 1
    fi

    zip_file="$1"           # Path to the zip file to be encrypted
    output_enc_file="$2"    # Path where the encrypted file will be saved
    password="$3"           # Password for encryption

    # Check if zip file exists
    if [ ! -f "$zip_file" ]; then
        echo "Error: Zip file '$zip_file' not found."
        return 1
    fi

    # Encrypt the zip file using AES
    openssl enc -aes-256-cbc -salt -pbkdf2 -in "$zip_file" -out "$output_enc_file" -k "$password"
    if [ $? -ne 0 ]; then
        echo "Error: Encryption failed."
        return 1
    fi

    echo "Encryption completed. Encrypted file: $output_enc_file"
}

# Function to decrypt an encrypted file using AES
decrypt() {
    # Check if number of arguments is correct
    if [ "$#" -ne 3 ]; then
        echo "Usage: decrypt <encrypted_file> <output_zip_file> <password>"
        return 1
    fi
  
    encrypted_file="$1"         # Path to the encrypted file
    output_zip_file="$2"        # Path where the decrypted file will be saved
    password="$3"               # Password for decryption

    # Check if encrypted file exists
    if [ ! -f "$encrypted_file" ]; then
        echo "Error: Encrypted file '$encrypted_file' not found."
        return 1
    fi

    # Decrypt the encrypted file using AES
    openssl enc -d -aes-256-cbc -pbkdf2 -in "$encrypted_file" -out "$output_zip_file" -k "$password"
    if [ $? -ne 0 ]; then
        echo "Error: Decryption failed."
        return 1
    fi

    echo "Decryption completed. Decrypted file: $output_zip_file"
}

# Example usage
# Encrypting a zipped folder
# encrypt "/home/med-amine/Desktop/Git_Backup-main/test.zip" "/home/med-amine/Desktop/test.enc" "20030629"
# Decrypting an encrypted file
# decrypt "/home/med-amine/Desktop/test.enc" "/home/med-amine/Desktop/decrypted_test.zip" "20030629"
