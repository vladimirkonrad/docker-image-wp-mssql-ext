# FROM amd64/wordpress:latest
# FROM wordpress:latest
FROM wordpress:6.2-php8.0-apache


# Install PHP extensions
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git && \
    apt-get install -y sudo && \
    apt-get install -y zip && \
    apt-get install -y wget 
# apt-get install -y mc && \
# apt-get install -y htop && \
# apt-get install -y default-jre && \
# apt-get install -y default-jdk


RUN apt-get update && apt-get install -y gnupg2

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN sudo apt-get update

# RUN sudo apt-get update --allow-unauthenticated
# RUN sudo apt-get update --allow-insecure-repositories

RUN sudo ACCEPT_EULA=Y apt-get install -y msodbcsql17

RUN sudo apt install -y unixodbc-dev 

# sudo apt install unixodbc-dev
# RUN sudo apt remove -y odbcinst1debian2
RUN sudo apt install unixodbc=2.3.7 unixodbc-dev=2.3.7 odbcinst1debian2=2.3.7 odbcinst=2.3.7

# for INTEL
RUN sudo pecl install sqlsrv
RUN sudo pecl install pdo_sqlsrv

# for ARM m1
# RUN sudo CXXFLAGS="-I/opt/homebrew/opt/unixodbc/include/" LDFLAGS="-L/opt/homebrew/lib/" pecl install sqlsrv
# RUN sudo CXXFLAGS="-I/opt/homebrew/opt/unixodbc/include/" LDFLAGS="-L/opt/homebrew/lib/" pecl install pdo_sqlsrv

RUN sudo printf 'extension=sqlsrv.so' >  /usr/local/etc/php/conf.d/docker-php-ext-sqlsrv.ini
RUN sudo printf 'extension=pdosqlsrv.so' >  /usr/local/etc/php/conf.d/docker-php-ext-pdo_sqlsrv.ini

