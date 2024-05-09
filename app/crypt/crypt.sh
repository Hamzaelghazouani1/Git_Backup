#!/bin/bash


# how to use this script:

# we have two functions in this script, one to encrypt a zipped folder and another to decrypt an encrypted file
# to use the encrypt function, you need to pass the zip file and the password as arguments
# to use the decrypt function, you need to pass the encrypted file in this format : encrypted_zippedFileName 
# and the password as arguments

# Function to encrypt a zipped folder using AES
encrypt() {
    # Check if number of arguments is correct
    if [ "$#" -ne 2 ]; then
        echo "Usage: encrypt <zip_file> <password>"
        return 1
    fi

    zip_file="$1"
    password="$2"
    encrypted_file="encrypted_${zip_file}"

    # Check if zip file exists
    if [ ! -f "$zip_file" ]; then
        echo "Error: Zip file '$zip_file' not found."
        return 1
    fi

    # Encrypt the zip file using AES
    openssl enc -aes-256-cbc -salt -pbkdf2 -in "$zip_file" -out "$encrypted_file" -k "$password"
    if [ $? -ne 0 ]; then
        echo "Error: Encryption failed."
        return 1
    fi

    echo "Encryption completed. Encrypted file: $encrypted_file"
}

# Function to decrypt an encrypted file using AES
decrypt() {
    # Check if number of arguments is correct
    if [ "$#" -ne 2 ]; then
        echo "Usage: decrypt <encrypted_file> <password>"
        return 1
    fi
  
    encrypted_file="$1"
    password="$2"
    decrypted_file="decrypted_$(basename "$encrypted_file" .enc)"

    # Check if encrypted file exists
    if [ ! -f "$encrypted_file" ]; then
        echo "Error: Encrypted file '$encrypted_file' not found."
        return 1
    fi

    # Decrypt the encrypted file using AES
    openssl enc -d -aes-256-cbc -pbkdf2 -in "$encrypted_file" -out "$decrypted_file" -k "$password"
    if [ $? -ne 0 ]; then
        echo "Error: Decryption failed."
        return 1
    fi

    echo "Decryption completed. Decrypted file: $decrypted_file"
}

# Example usage
# Encrypting a zipped folder
# encrypt "test.zip" "20030629"

# Decrypting an encrypted file
# decrypt "encrypted_test.zip" "20030629"
