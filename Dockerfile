FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y apache2 php libapache2-mod-php
COPY website/ /var/www/html/
RUN rm -f /var/www/html/index.html || true 
RUN chown -R www-data:www-data /var/www/html 
CMD ["apache2ctl", "-D", "FOREGROUND"]
EXPOSE 80

