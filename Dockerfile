FROM php:8.3-apache

# Установка Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Копируем проект
COPY . /var/www/html/

# Переключаем рабочую директорию
WORKDIR /var/www/html/

# Включаем нужные модули Apache
RUN a2enmod rewrite headers

# Обновляем DocumentRoot на public/
RUN sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/public|' /etc/apache2/sites-available/000-default.conf

# Устанавливаем зависимости
RUN composer install || true

EXPOSE 80
