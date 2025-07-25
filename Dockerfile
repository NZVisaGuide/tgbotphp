# 1. Используем официальный PHP-образ
FROM php:8.2-cli

# 2. Устанавливаем необходимые расширения
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    git \
    && docker-php-ext-install sockets

# 3. Копируем файлы проекта внутрь контейнера
WORKDIR /app
COPY . .

# 4. Устанавливаем зависимости, если используешь composer
# (если не используешь — удали этот шаг)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer install --no-dev --optimize-autoloader || true

# 5. Указываем порт и команду запуска
EXPOSE 80

# Если index.php находится в корне:
CMD ["php", "-S", "0.0.0.0:80", "index.php"]

# Если index.php в public/ — поменяй строку выше на:
# CMD ["php", "-S", "0.0.0.0:80", "-t", "public"]
