## Installation

Clone the project, create your .env file and build the container.

```sh
git clone...
cd aws tunnel
cp .env.template .env
make build
```


Build a tunnel:

```sh
make run
```
You can then choose from the services created.

```sh 
1) Service A 
2) Service B 
3) Service C 

Selection (number):
```
```sh
Log in with your Okta credentials.
- Email address
- Password
- Tokens
```

If you have set the email and/or password in your .env, the input will be skipped. Otherwise you will get a prompt:


```sh
Password: *********
Token: *****
```

The authentication is checked. If everything works, a tunnel is built and a connection is waited for

`Waiting for connections...`

The terminal window must remain open as long as the tunnel is to remain in existence.
With `make print_mysql` the mysql statement including token can be generated.

```sh
❯ make print_mysql
    mysql -h 127.0.0.1 -P 33071 -u fly -D fly --enable-cleartext-plugin --password='db.proxy.region.rds.amazonaws.com:3306/?Action=connect&DBUser=username&X-Amz-Algorithm=ABCD-ABCD-ABCDABCD-ABC-Credential...Token=...
```

With this command you can connect to the database.


The binding lasts 15 minutes. If it has expired, you must have a new token generated. `make print_mysql`
