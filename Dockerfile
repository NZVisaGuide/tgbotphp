# Используем официальный образ PHP с Apache
FROM php:8.2-apache

# Устанавливаем необходимые пакеты и расширения PHP
RUN apt-get update && apt-get install -y \
    zip unzip git curl libzip-dev libonig-dev \
    && docker-php-ext-install zip mbstring

# Включаем mod_rewrite
RUN a2enmod rewrite

# Копируем файлы проекта внутрь контейнера
COPY . /var/www/html/

# Устанавливаем рабочую директорию
WORKDIR /var/www/html

# Устанавливаем зависимости composer, если есть composer.json
COPY --from=composer:2.6 /usr/bin/composer /usr/bin/composer
RUN if [ -f composer.json ]; then composer install; fi

# Настройки Apache (если нужно)
COPY ./public/.htaccess /var/www/html/public/.htaccess

# Разрешаем Apache доступ к public/
RUN chown -R www-data:www-data /var/www/html

# Указываем, что DocumentRoot будет в /var/www/html/public
RUN sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/public|g' /etc/apache2/sites-available/000-default.conf
