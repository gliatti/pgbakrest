# pgBakRest Test Certificates

The certificates in this directory are used for testing purposes only and are not used for actual services. They are used only by the unit and integration tests and there should be no reason to modify them unless new tests are required.

## Generating the Test CA (pgbakrest-test-ca.crt/key)

This is a self-signed CA that is used to sign all server certificates. No intermediate CAs will be generated since they are not needed for testing.

```
cd [pgbakrest-root]/test/certificate
openssl genrsa -out pgbakrest-test-ca.key 4096
openssl req -new -x509 -extensions v3_ca -key pgbakrest-test-ca.key -out pgbakrest-test-ca.crt -days 99999 \
    -subj "/C=US/ST=All/L=All/O=pgBakRest/CN=test.pgbakrest.org"
openssl x509 -in pgbakrest-test-ca.crt -text -noout
```

## Generating the Server Test Key (pgbakrest-test-server.key)

This key will be used for all server certificates to keep things simple.

```
cd [pgbakrest-root]/test/certificate
openssl genrsa -out pgbakrest-test-server.key 4096
```

## Generating the Server Test Certificate (pgbakrest-test-server.crt/key)

This certificate will be used in unit and integration tests. It is expected to pass verification but won't be subjected to extensive testing.

```
cd [pgbakrest-root]/test/certificate
openssl req -new -sha256 -nodes -out pgbakrest-test-server.csr -key pgbakrest-test-server.key -config pgbakrest-test-server.cnf
openssl x509 -req -in pgbakrest-test-server.csr -CA pgbakrest-test-ca.crt -CAkey pgbakrest-test-ca.key -CAcreateserial \
    -out pgbakrest-test-server.crt -days 99999 -extensions v3_req -extfile pgbakrest-test-server.cnf
openssl x509 -in pgbakrest-test-server.crt -text -noout
```

## Generating the Client Test Key (pgbakrest-test-client.key)

This key will be used for all client certificates to keep things simple.

```
cd [pgbakrest-root]/test/certificate
openssl genrsa -out pgbakrest-test-client.key 4096
```

## Generating the Client Test Certificate (pgbakrest-test-client.crt/key)

This certificate will be used in unit and integration tests. It is expected to pass verification but won't be subjected to extensive testing.

```
cd [pgbakrest-root]/test/certificate
openssl req -new -sha256 -nodes -out pgbakrest-test-client.csr -key pgbakrest-test-client.key -config pgbakrest-test-client.cnf
openssl x509 -req -in pgbakrest-test-client.csr -CA pgbakrest-test-ca.crt -CAkey pgbakrest-test-ca.key -CAcreateserial \
    -out pgbakrest-test-client.crt -days 99999 -extensions v3_req -extfile pgbakrest-test-client.cnf
openssl x509 -in pgbakrest-test-client.crt -text -noout
```
