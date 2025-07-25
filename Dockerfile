# Используем официальный PHP-образ
FROM php:8.3-apache

# Копируем файлы проекта в контейнер
COPY . /var/www/html/

# Устанавливаем рабочую директорию
WORKDIR /var/www/html/

# Включаем mod_rewrite (если нужно .htaccess)
RUN a2enmod rewrite

# Устанавливаем Composer, если он используется
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Установка зависимостей
RUN composer install || true

# Обеспечиваем, что папка public используется как DocumentRoot
RUN sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/public|' /etc/apache2/sites-available/000-default.conf

# Открываем порт
EXPOSE 80
