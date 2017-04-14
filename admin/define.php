<?php
/**
 * @package     Arastta eCommerce
 * @copyright   2015-2017 Arastta Association. All rights reserved.
 * @copyright   See CREDITS.txt for credits and other copyright notices.
 * @license     GNU GPL version 3; see LICENSE.txt
 * @link        https://arastta.org
 */

defined('AREXE') or die;

// HTTP
define('HTTP_SERVER', 'http://' . $_SERVER['HTTP_HOST'] . rtrim(dirname(dirname($_SERVER['SCRIPT_NAME'])), '/.\\') . '/admin/');
define('HTTP_CATALOG', 'http://' . $_SERVER['HTTP_HOST'] . rtrim(dirname(dirname($_SERVER['SCRIPT_NAME'])), '/.\\') . '/');
define('HTTP_IMAGE', 'http://' . $_SERVER['HTTP_HOST'] . rtrim(dirname(dirname($_SERVER['SCRIPT_NAME'])), '/.\\') . '/image/');

// HTTPS
define('HTTPS_SERVER', (!empty($_SERVER['HTTPS']) ? 'https://' : 'http://') . $_SERVER['HTTP_HOST'] . rtrim(dirname(dirname($_SERVER['SCRIPT_NAME'])), '/.\\') . '/admin/');
define('HTTPS_CATALOG', (!empty($_SERVER['HTTPS']) ? 'https://' : 'http://') . $_SERVER['HTTP_HOST'] . rtrim(dirname(dirname($_SERVER['SCRIPT_NAME'])), '/.\\') . '/');
define('HTTPS_IMAGE', (!empty($_SERVER['HTTPS']) ? 'https://' : 'http://') . $_SERVER['HTTP_HOST'] . rtrim(dirname(dirname($_SERVER['SCRIPT_NAME'])), '/.\\') . '/image/');

// Variables
define('IS_ADMIN', true);

// Directories
$base = __DIR__;

$parts = explode(DIRECTORY_SEPARATOR, $base);
array_pop($parts);

define('DIR_BASE', $base . '/');
define('DIR_ROOT', implode(DIRECTORY_SEPARATOR, $parts) . '/');
define('DIR_CLI', DIR_ROOT . 'cli/');
define('DIR_INSTALL', DIR_ROOT . 'install/');
define('DIR_SYSTEM', DIR_ROOT . 'system/');
define('DIR_ADMIN', DIR_ROOT . 'admin/');
define('DIR_CATALOG', DIR_ROOT . 'catalog/');
define('DIR_VQMOD', DIR_ROOT . 'vqmod/');
define('DIR_IMAGE', DIR_ROOT . 'image/');
define('DIR_DOWNLOAD', DIR_ROOT . 'download/');
define('DIR_UPLOAD', DIR_ROOT . 'upload/');
define('DIR_CONFIG', DIR_SYSTEM .'config/');
define('DIR_CACHE', DIR_SYSTEM . 'cache/');
define('DIR_LOG', DIR_SYSTEM . 'log/');
define('DIR_MODIFICATION', DIR_SYSTEM . 'modification/');
define('DIR_LANGUAGE', DIR_ADMIN . 'language/');
define('DIR_TEMPLATE', DIR_ADMIN . 'view/template/');

define('DIR_APPLICATION', DIR_ADMIN); // depreciated due to app instances, use DIR_ADMIN
define('DIR_LOGS', DIR_LOG); // depreciated due to plural usage, use DIR_LOG
