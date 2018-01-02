# keystore-helper

## Usage

### Change password for a p12 bundle

``` bash
./change-password -s SOURCE KEYSTORE -o OLD PASSWORD -n NEW PASSWORD
```

#### Convert a p12 file to a Java keystore file

```bash
./convert-p12-to-jks -s SOURCE KEYSTORE -d DESTINATION KEYSTORE -p PASSWORD
```

#### Create cert file

```bash
./create-cert-file -s SOURCE KEYSTORE -p PASSWORD
```

#### Create p12 cert file from a Java keystore alias

```bash
./create-p12-cert-from-jks-alias SOURCE KEYSTORE -p PASSWORD -k KEY PASSWORD -a ALIAS
```

#### Create p12 keys and certs from a Java keystore alias

```bash
./create-p12-keys-and-certs-from-jks-alias SOURCE KEYSTORE -p PASSWORD -k KEY PASSWORD -a ALIAS
```
#### Create pem files from a Java keystore

```bash
./create-pem-files-from-jks -s SOURCE KEYSTORE -p PASSWORD
```
#### Create RSA key

```bash
./create-rsa-key -s SOURCE KEYSTORE -p PASSWORD
```
#### Create a SITHS p12 bundle

```bash
./create-siths-bundle -i CERTIFICATE FILE TO READ FROM -b BUNDLE NAME YOU WISH TO CREATE -e ENVIRONMENT
```
