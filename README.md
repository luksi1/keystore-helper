# keystore-helper

## Usage

### Change password for a p12 bundle

```sh
./change-password -s SOURCE KEYSTORE -o OLD PASSWORD -n NEW PASSWORD
```

### Convert a p12 file to a Java keystore file

```sh
./convert-p12-to-jks -s SOURCE KEYSTORE -d DESTINATION KEYSTORE -p PASSWORD
```

### Create cert file

```sh
./create-cert-file -s SOURCE KEYSTORE -p PASSWORD
```

### Create p12 cert file from a Java keystore alias

```sh
./create-p12-cert-from-jks-alias SOURCE KEYSTORE -p PASSWORD -k KEY PASSWORD -a ALIAS
```

### Create p12 keys and certs from a Java keystore alias

```sh
./create-p12-keys-and-certs-from-jks-alias SOURCE KEYSTORE -p PASSWORD -k KEY PASSWORD -a ALIAS
```

### Create pem files from a Java keystore

```sh
./create-pem-files-from-jks -s SOURCE KEYSTORE -p PASSWORD
```

### Create RSA key

```sh
./create-rsa-key -s SOURCE KEYSTORE -p PASSWORD
```

### Create a SITHS p12 bundle

```sh
./create-siths-bundle -i CERTIFICATE FILE TO READ FROM -b BUNDLE NAME YOU WISH TO CREATE -e ENVIRONMENT
```

### Extract the key and certificate from a PFX or P12 file

```sh
./extract-cert-and-key-from-pfx -s SOURCE KEYSTORE -p PASSWORD
```

### Extract the key with RSA password removed and certificate from a PFX or P12 file

```sh
./extract-cert-and-key-from-pfx-and-remove-rsa-password -s SOURCE KEYSTORE -p PASSWORD
```
