#####################################
# PHP:
#####################################

FROM php:7.2.4-fpm


RUN apt-get update && apt-get install -y \
    mysql-client libmagickwand-dev --no-install-recommends \
    git \
    zip \
    libzip-dev \
    unzip

# Install the PHP pdo_mysql extention
RUN docker-php-ext-install pdo_mysql

# Install the PHP zip extention
RUN docker-php-ext-configure zip --with-libzip

# Add zip this is Deprecated and is probably going to be removed
RUN docker-php-ext-install zip

#####################################
# Composer:
#####################################

# Install composer and add its bin to the PATH.
RUN curl -s http://getcomposer.org/installer | php && \
    echo "export PATH=${PATH}:/var/www/vendor/bin" >> ~/.bashrc && \
    mv composer.phar /usr/local/bin/composer

RUN apt-get update && apt-get install -y gnupg

# Install Node.js
RUN curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt-get install nodejs -y
RUN npm install npm@6.4.0 -g
RUN command -v node
RUN command -v npm

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y yarn

# Source the bash
RUN . ~/.bashrc