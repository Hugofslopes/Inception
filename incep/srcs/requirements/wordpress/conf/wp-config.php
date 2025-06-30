<?php

// Load secrets if available
$secret_db_password = @file_get_contents('/run/secrets/db_password');

// Fallback to environment variables if secrets not found
define('DB_NAME', getenv('DB_NAME'));
define('DB_USER', getenv('DB_USER'));
define('DB_PASSWORD', $secret_db_password ?: getenv('DB_PASSWORD'));
define('DB_HOST', getenv('DB_HOST'));
