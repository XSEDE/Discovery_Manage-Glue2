openssl req  -new -x509 -days 2000 -nodes -out cert.pem -keyout cert.pem
Generating a 2048 bit RSA private key
.....................................+++
.........+++
writing new private key to 'cert.pem'
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:US
State or Province Name (full name) [Some-State]:Illinois
Locality Name (eg, city) []:Chicago
Organization Name (eg, company) [Internet Widgits Pty Ltd]:XSEDE
Organizational Unit Name (eg, section) []:Software Development and Integration
Common Name (e.g. server FQDN or YOUR name) []:Collector Client
Email Address []:navarro@mcs.anl.gov
