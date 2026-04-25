import sys

if len(sys.argv) != 3:
    print("Encrypt/Decrypt config file")
    print(f"Usage\n{sys.argv[0]} <in file> <out file>")
    sys.exit(0)

def xor_file(input_path, output_path, key):
    key_bytes = key.encode()
    key_len = len(key_bytes)
    with open(input_path, 'rb') as f_in, open(output_path, 'wb') as f_out:
        xorin = f_in.read()
        xorout = bytes([b ^ key_bytes[i % key_len] for i, b in enumerate(xorin)])
        print(f"Data len {len(xorout)}")
        f_out.write(xorout)


# recovered from /lib/libmib.so function xor_encrypt #XOR_KEY_ptr@PAGE
xor_key = 'tecomtec'
# XOR is bi-dir, same func can do both encrypt or decrypt
xor_file(sys.argv[1], sys.argv[2], xor_key)
