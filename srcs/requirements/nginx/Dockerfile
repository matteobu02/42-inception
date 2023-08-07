FROM debian:11

RUN	apt-get update && apt-get install -y openssl nginx

RUN mkdir -p /etc/nginx/ssl /var/run/nginx

# Generate certificate and key
# req = certificate request and certificate generating utility.
# It can additionally create self signed certificates for use as root CAs for example.
# -x509 = self signed
# -nodes = if this option is specified then if a private key is created it will not be encrypted.
# -keyout = where to write the key
# -subj = info for ssl key Country,State,...
RUN openssl req -x509 -nodes \
	-out /etc/nginx/ssl/mbucci.42.fr.crt \
	-keyout /etc/nginx/ssl/mbucci.42.fr.key \
	-subj "/C=BE/ST=Belgium/L=Brussels/O=42/OU=19/CN=mbucci.42.fr/UID=mbucci"

COPY ./conf/nginx.conf /etc/nginx/sites-enabled/default.conf

EXPOSE 443

CMD	[ "nginx", "-g", "daemon off;" ]
