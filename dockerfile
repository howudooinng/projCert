FROM devopsedu/webapp:latest
COPY website/ /var/www/html/
RUN rm -f /var/www/html/index.html || true
RUN chown -R www-data:www-data /var/www/html
EXPOSE 80
CMD ["/usr/sbin/apache2ctl","-D", "FOREGROUND"]

