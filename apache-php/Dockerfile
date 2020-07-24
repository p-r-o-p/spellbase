FROM php:7.4.8-apache
RUN apt-get update
# A bug in the docker-php-ext-install script means we need to install liboneg-dev for the mbstring extention by hand
RUN apt-get install libonig-dev
RUN docker-php-ext-install pdo_mysql mbstring
RUN apt install -y -q curl zip unzip
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN ls composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN rm composer-setup.php
RUN mkdir -p /app/src
RUN ln -s /app/src /var/www/html
RUN echo 'alias ls="ls -ah --color=auto"' >> /root/.bashrc
RUN echo 'alias ll="ls -lah --color=auto"' >> /root/.bashrc