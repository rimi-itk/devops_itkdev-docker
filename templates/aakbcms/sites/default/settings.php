<?php

$databases = array (
  'default' => 
  array (
    'default' => 
    array (
      'database' => 'db',
      'username' => 'db',
      'password' => 'db',
      'host' => 'mariadb',
      'port' => '',
      'driver' => 'mysql',
      'prefix' => '',
    ),
  ),
);

$update_free_access = FALSE;

ini_set('session.gc_probability', 1);
ini_set('session.gc_divisor', 100);
ini_set('session.gc_maxlifetime', 200000);
ini_set('session.cookie_lifetime', 2000000);

$conf['404_fast_paths_exclude'] = '/\/(?:styles)|(?:system\/files)\//';
$conf['404_fast_paths'] = '/\.(?:txt|png|gif|jpe?g|css|js|ico|swf|flv|cgi|bat|pl|dll|exe|asp)$/i';
$conf['404_fast_html'] = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML+RDFa 1.0//EN" "http://www.w3.org/MarkUp/DTD/xhtml-rdfa-1.dtd"><html xmlns="http://www.w3.org/1999/xhtml"><head><title>404 Not Found</title></head><body><h1>Not Found</h1><p>The requested URL "@path" was not found on this server.</p></body></html>';

/**
 * Memcached configuration.
 */
include_once('./includes/cache.inc');
include_once('./profiles/ding2/modules/contrib/memcache/memcache.inc');
// Forms cache table.
$conf['cache_class_cache_form'] = 'DrupalDatabaseCache';
$conf['cache_backends'][] = 'profiles/ding2/modules/contrib/memcache/memcache.inc';
$conf['cache_default_class'] = 'MemCacheDrupal';
$conf['memcache_key_prefix'] = $databases['default']['default']['database'];
$conf['memcache_servers'] = array(
  'memcached:11211' => 'default',
);
$conf['memcache_bins'] = array(
  'cache' => 'default',
);
$conf['memcache_log_data_pieces'] = 10;

$conf['samesite_cookie_attribute_value'] = '';
