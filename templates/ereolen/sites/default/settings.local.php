<?php

$databases['default']['default'] = array(
 'database' => 'db',
 'username' => 'db',
 'password' => 'db',
 'host' => 'mariadb',
 'port' => '',
 'driver' => 'mysql',
 'prefix' => '',
);

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

$conf['404_fast_paths_exclude'] = '/\/(?:styles)\//';
$conf['404_fast_paths'] = '/\.(?:txt|png|gif|jpe?g|css|js|ico|swf|flv|cgi|bat|pl|dll|exe|asp)$/i';
$conf['404_fast_html'] = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML+RDFa 1.0//EN" "http://www.w3.org/MarkUp/DTD/xhtml-rdfa-1.dtd"><html xmlns="http://www.w3.org/1999/xhtml"><head><title>404 Not Found</title></head><body><h1>Not Found</h1><p>The requested URL "@path" was not found on this server.</p></body></html>';

/**
 * Varnish configutation.
 */
$conf['reverse_proxy'] = TRUE;
$conf['reverse_proxy_addresses'] = array('varnish');

// Set varnish configuration.
$conf['varnish_control_key'] = 'eca2b7c263eae74c0d746f147691e7ce';
$conf['varnish_socket_timeout'] = 500;
$conf['varnish_version'] = 4;

// Set ding varnish content types to override ding_base.
$conf['ding_varnish_content_types'] = array(
  'ding_page' => 'ding_page',
  'article' => 'article',
  'author_portrait' => 'author_portrait',
  'inspiration' => 'inspiration',
  'ereol_page' => 'ereol_page',
  'video' => 'video',
  'faq' => 'faq',
  'ding_group' => 'ding_group',
  'panel' => 0,
  'webform' => 0,
);

// Set varnish server IP's sperated by spaces
$conf['varnish_control_terminal'] = 'varnish:6082';

