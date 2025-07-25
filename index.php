<?php
// Получаем входящие данные от Telegram
$update = json_decode(file_get_contents("php://input"), true);

// Пример простой реакции на сообщение
if (isset($update["message"]["text"])) {
    $text = $update["message"]["text"];
    $chat_id = $update["message"]["chat"]["id"];

    // Отправка ответа
    file_get_contents("https://api.telegram.org/bot" . getenv("BOT_TOKEN") .
        "/sendMessage?chat_id=$chat_id&text=" . urlencode("Вы сказали: $text"));
}

// Обязательно верни 200 OK, чтобы Telegram не ругался
http_response_code(200);
echo "OK";
