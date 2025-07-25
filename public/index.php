<?php

// d:\server538\openserver\modules\php\PHP_8.0\php.exe composer.phar require irazasyed/telegram-bot-sdk

error_reporting(-1);
ini_set('display_errors', 0);
ini_set('log_errors', 'on');
ini_set('error_log', __DIR__ . '/errors.log');

require __DIR__.'/vendor/autoload.php';
require_once 'config.php';
require_once 'functions.php';

$telegram = new \Telegram\Bot\Api(TOKEN);
$update = $telegram->getWebhookUpdate();

debug($update);

$chat_id = $update['message']['chat']['id'] ?? 0;
//$text = isset($update->message->text) ? "You wrote: <i>{$update->message->text}</i>" : "<u>I need some text</u>";
$text = $update['message']['text'] ?? '';
$name = $update['message']['from']['first_name'] ?? 'Guest';

if (!$chat_id) {
    die;
}

if ($text == '/help') {
    try {
        $telegram->sendMessage([
            'chat_id' => $chat_id,
            'text' => "Show bot help",
            'parse_mode' => 'HTML',
        ]);
    } catch (\Telegram\Bot\Exceptions\TelegramSDKException $e) {
        error_log($e->getMessage() . PHP_EOL, 3, __DIR__ . '/errors.log');
    }
} elseif ($text == '/test') {
    $telegram->sendMessage([
        'chat_id' => $chat_id,
        'text' => "Hello, <b>{$name}</b>!" . PHP_EOL . "Test command...",
        'parse_mode' => 'HTML',
    ]);
} elseif (!empty($text)) {
    $telegram->sendMessage([
        'chat_id' => $chat_id,
        'text' => "Hello, <b>{$name}</b>!" . PHP_EOL . "You wrote: <i>{$text}</i>",
        'parse_mode' => 'HTML',
    ]);
} else {
    $telegram->sendMessage([
        'chat_id' => $chat_id,
        'text' => "Hello, <b>{$name}</b>!" . PHP_EOL . "<u>I need some text</u>",
        'parse_mode' => 'HTML',
    ]);
}

/*
// var_dump(BASE_URL . 'setWebhook?url=https://webformyself-bots.space/bots/1/');

$update = json_decode(file_get_contents('php://input'));

debug($update);

$text = isset($update->message->text) ? "You wrote: <i>{$update->message->text}</i>" : "<u>I need some text</u>";
$chat_id = $update->message->chat->id ?? 0;
$name = $update->message->from->first_name ?? 'Guest';

if ($chat_id) {
    $res = send_request('sendMessage', [
        'chat_id' => $chat_id,
        'text' => "Hello, <b>{$name}</b>!" . PHP_EOL . $text,
        'parse_mode' => 'HTML',
    ]);
}
*/