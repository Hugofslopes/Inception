<?php

define('DB_NAME', trim(file_get_contents('/var/www/inception/secrects/db_name')));
define('DB_USER', trim(file_get_contents('/var/www/inception/secrects/db_user')));
define('DB_PASSWORD', trim(file_get_contents('/var/www/inception/secrects/db_password')));
define('DB_HOST', getenv('DB_HOST') ?: 'mariadb:3306');

require_once ABSPATH . 'wp-settings.php';