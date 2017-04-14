<?php
/**
 * @package     Arastta eCommerce
 * @copyright   2015-2017 Arastta Association. All rights reserved.
 * @copyright   See CREDITS.txt for credits and other copyright notices.
 * @license     GNU GPL version 3; see LICENSE.txt
 * @link        https://arastta.org
 */

class Route extends Object
{

    protected $registry;

    public function __construct($registry)
    {
        $this->registry = $registry;
    }

    public function __get($key)
    {
        return $this->registry->get($key);
    }

    public function __set($key, $value)
    {
        $this->registry->set($key, $value);
    }

    public function parse()
    {
        // Stop if SEO is disabled
        if (!$this->config->get('config_seo_url')) {
            return;
        }

        // Attach the URL builder
        $this->url->addRewrite($this);

        $query_string = $this->uri->getQuery();

        $route = str_replace($this->url->getFullUrl(), '', rawurldecode($this->uri->toString()));
        $route = str_replace('?'.$query_string, '', $route);

        // www Redirection
        if ($this->config->get('config_seo_www_red')) {
            $this->checkWwwRedirection();
        }

        // Don't parse if home page
        if (empty($route)) {
            $this->request->get['route'] = 'common/home';

            return;
        }

        // Don't parse if route is already set
        if (!empty($this->request->get['route'])) {
            // non-SEO to SEO URLs Redirection
            if ($this->config->get('config_seo_nonseo_red')) {
                $this->checkNonseoRedirection($this->request->get['route']);
            }

            return;
        }

        // non-SEO variables
        if (!empty($query_string)) {
            $query_array = $this->uri->getQuery(true);
            $this->parseNonSeoVariables($query_array);

            if ($this->config->get('config_seo_canonical')) {
                $canonical_link = htmlspecialchars($this->url->getDomain().$route);

                $this->document->addLink($canonical_link, 'canonical');
            }
        }

        $seo_url = str_replace('index.php', '', $route);
        $seo_url = ltrim($seo_url, '/');

        // Add language code to URL
        $is_lang_home = false;
        if ($this->config->get('config_seo_lang_code')) {
            if ($seo_url == $this->session->data['language']) {
                $is_lang_home = true;
            }

            $seo_url = ltrim($seo_url, $this->session->data['language']);
            $seo_url = ltrim($seo_url, '/');
        }

        // URLs are stored without suffix in database
        if ($this->config->get('config_seo_suffix')) {
            $seo_url = substr($seo_url, 0, -5);
        }

        $parts = explode('/', $seo_url);

        // remove any empty arrays from trailing
        if (utf8_strlen(end($parts)) == 0) {
            array_pop($parts);
        }

        $seo = new Seo($this->registry);
        
        foreach ($parts as $part) {
            $query = $seo->getAliasQuery($part);

            if (!empty($query) && strstr($query, '=')) {
                $url = explode('=', $query);

                switch ($url[0]) {
                    case 'product_id':
                        $this->request->get['product_id'] = $url[1];

                        if (!$this->config->get('config_seo_category')) {
                            $categories = array();

                            $category_id = $seo->getCategoryIdBySortOrder($url[1]);

                            if (!is_null($category_id)) {
                                $categories = $seo->getParentCategoriesIds($category_id);

                                $categories[] = $category_id;
                            }

                            if (!empty($categories)) {
                                $this->request->get['path'] = implode('_', $categories);
                            }
                        }
                        break;
                    case 'category_id':
                        if ($this->config->get('config_seo_category') == 'last') {
                            $categories = $seo->getParentCategoriesIds($url[1]);

                            $categories[] = $url[1];

                            if (!empty($categories)) {
                                $this->request->get['path'] = implode('_', $categories);
                            }
                        } else {
                            if (!isset($this->request->get['path'])) {
                                $this->request->get['path'] = $url[1];
                            } else {
                                $this->request->get['path'] .= '_' . $url[1];
                            }
                        }
                        break;
                    case 'blog_category_id':
                        $this->request->get['route'] = 'blog/category';

                        if ($this->config->get('config_seo_category') == 'last') {
                            $categories = $seo->getParentCategoriesIds($url[1], 'blog_');

                            $categories[] = $url[1];

                            if (!empty($categories)) {
                                $this->request->get['path'] = implode('_', $categories);
                            }
                        } else {
                            if (!isset($this->request->get['path'])) {
                                $this->request->get['path'] = $url[1];
                            } else {
                                $this->request->get['path'] .= '_' . $url[1];
                            }
                        }
                        break;
                    case 'blog_post_id':
                        $this->request->get['route'] = 'blog/post';
                        $this->request->get['post_id'] = $url[1];
                        break;
                    case 'manufacturer_id':
                    case 'information_id':
                    case 'route':
                    default:
                        $this->request->get[$url[0]] = $url[1];
                        break;
                }
            } elseif ($is_lang_home) {
                $this->request->get['route'] = 'common/home';

                break;
            } else {
                $this->request->get['route'] = $seo_url;

                break;
            }
        }

        if (!isset($this->request->get['route'])) {
            if (isset($this->request->get['product_id'])) {
                $this->request->get['route'] = 'product/product';
            } elseif (isset($this->request->get['path'])) {
                $this->request->get['route'] = 'product/category';
            } elseif (isset($this->request->get['manufacturer_id'])) {
                $this->request->get['route'] = 'product/manufacturer/info';
            } elseif (isset($this->request->get['information_id'])) {
                $this->request->get['route'] = 'information/information';
            }
        }

        unset($this->request->get['_route_']); // For B/C purpose
    }

    public function rewrite($link)
    {
        $url = '';
        $is_home = false;

        // common/currency, $data['redirect']
        $link = str_replace('amp;amp;', 'amp;', $link);

        $uri = new Uri($link);

        if ($uri->getVar('route')) {
            $seo = new Seo($this->registry);

            switch ($uri->getVar('route')) {
                case 'common/home':
                    $is_home = true;
                    break;
                case 'product/product':
                    if ($this->config->get('config_seo_category')) {
                        if ($uri->getVar('path') && ($this->config->get('config_seo_category') == 'last')) {
                            $categories = explode('_', $uri->getVar('path'));

                            $categories = array(end($categories));
                        } else {
                            $categories = array();

                            $category_id = $seo->getCategoryIdBySortOrder($uri->getVar('product_id'));

                            if (!is_null($category_id)) {
                                $categories = $seo->getParentCategoriesIds($category_id);

                                $categories[] = $category_id;

                                if ($this->config->get('config_seo_category') == 'last') {
                                    $categories = array(end($categories));
                                }
                            }
                        }

                        foreach ($categories as $category) {
                            $alias = $seo->getAlias($category, 'category');

                            if ($alias) {
                                $url .= '/' . $alias;
                            }
                        }

                        $uri->delVar('path');
                    }

                    if ($uri->getVar('product_id')) {
                        $alias = $seo->getAlias($uri->getVar('product_id'), 'product');

                        if ($alias) {
                            $url .= '/' . $alias;
                        }

                        $uri->delVar('product_id');
                        $uri->delVar('manufacturer_id');
                        $uri->delVar('path');
                        $uri->delVar('search');
                    }
                    break;
                case 'product/category':
                    if ($uri->getVar('path')) {
                        $categories = explode('_', $uri->getVar('path'));

                        foreach ($categories as $category) {
                            $alias = $seo->getAlias($category, 'category');

                            if ($alias) {
                                $url .= '/' . $alias;
                            }
                        }

                        $uri->delVar('path');
                    }
                    break;
                case 'information/information':
                    if ($uri->getVar('information_id')) {
                        $alias = $seo->getAlias($uri->getVar('information_id'), 'information');

                        if ($alias) {
                            $url .= '/' . $alias;
                        }

                        $uri->delVar('information_id');
                    }
                    break;
                case 'product/manufacturer/info':
                    if ($uri->getVar('manufacturer_id')) {
                        $alias = $seo->getAlias($uri->getVar('manufacturer_id'), 'manufacturer');

                        if ($alias) {
                            $url .= '/' . $alias;
                        }

                        $uri->delVar('manufacturer_id');
                    }
                    break;
                case 'blog/category':
                    if ($uri->getVar('path')) {
                        // Add blog home first
                        $blog_home = $seo->getAlias('route=blog/home', 'other');

                        if ($blog_home) {
                            $url .= '/' . $blog_home;
                        }

                        $categories = explode('_', $uri->getVar('path'));

                        foreach ($categories as $category) {
                            $alias = $seo->getAlias($category, 'blog_category');

                            if ($alias) {
                                $url .= '/' . $alias;
                            }
                        }

                        $uri->delVar('path');
                    }
                    break;
                case 'blog/post':
                    if ($uri->getVar('post_id')) {
                        // Add blog home first
                        $blog_home = $seo->getAlias('route=blog/home', 'other');

                        if ($blog_home) {
                            $url .= '/' . $blog_home;
                        }

                        $alias = $seo->getAlias($uri->getVar('post_id'), 'blog_post');

                        if ($alias) {
                            $url .= '/' . $alias;
                        }

                        $uri->delVar('post_id');
                    }
                    break;
                default:
                    $route = $uri->getVar('route');

                    if (!$this->seoDisabled($route)) {
                        $alias = $seo->getAlias('route='.$route, 'other');

                        if (!empty($alias)) {
                            $alias = str_replace('route=', '', $alias);

                            $url = '/' . $alias;
                        } else {
                            $url = '/' . $route;
                        }
                    }

                    break;
            }

            $uri->delVar('route');
        }

        if ($url || $is_home) {
            // Add language code to URL
            if ($this->config->get('config_seo_lang_code')) {
                $url = '/'.$this->session->data['language'].$url;
            }
            $uri->delVar('lang');

            // Append the suffix if enabled
            if ($this->config->get('config_seo_suffix') && !$is_home) {
                $url .= '.html';
            }

            $path = $uri->getPath();

            if ($this->config->get('config_seo_rewrite') || ($is_home && !$this->config->get('config_seo_lang_code'))) {
                $path = str_replace('index.php/', '', $path);
                $path = str_replace('index.php', '', $path);
            }

            $path .= $url;

            $uri->setPath($path);

            return $uri->toString();
        } else {
            return $link;
        }
    }

    public function checkNonseoRedirection($route)
    {
        if ($this->seoDisabled($route)) {
            return;
        }

        $domain = $this->url->getDomain();

        // Home page, redirect to domain with empty query
        if ($route == 'common/home') {
            $url = $this->rewrite($domain);

            $this->response->redirect($url, 301);
        } else {
            $url_data = $this->request->get;
            unset($url_data['lang']);
            unset($url_data['_route_']); // For B/C purpose

            if (!isset($url_data['route'])) {
                $url_data['route'] = 'common/home';
            }

            $query = '';
            if ($url_data) {
                $query = 'index.php?'.urldecode(http_build_query($url_data, '', '&'));
            }

            $url = $domain.$query;

            $url = $this->rewrite($url);

            $this->response->redirect($url, 301);
        }
    }

    public function checkWwwRedirection()
    {
        $redirect = false;

        $host = $this->uri->getHost();

        $www_red = $this->config->get('config_seo_www_red');
        if (($www_red == 'with') and (strpos($host, 'www') !== 0)) {
            $redirect = true;
            $this->uri->setHost('www.'.$host);
        } elseif (($www_red == 'non') and strpos($host, 'www') === 0) {
            $redirect = true;
            $this->uri->setHost(substr($host, 4, strlen($host)));
        }

        if ($redirect === false) {
            return;
        }

        $this->response->redirect($this->uri->toString(), 301);
    }

    public function parseNonSeoVariables($query)
    {
        if (empty($query)) {
            return;
        }

        foreach ($query as $variable => $value) {
            if (is_array($value)) {
                $this->parseNonSeoVariables($value);
            } else {
                // Removed as it breaks search and seems to be out of purpose
                //$value = urlencode($value);

                $this->request->get[$variable] = $value;
            }
        }
    }

    public function seoDisabled($route = '')
    {
        if (IS_ADMIN == true) {
            return true;
        }

        // Do not generate SEO URLs if format available, to be used for format=raw, format=json etc
        /*if (isset($this->request->get['format'])) {
            return true;
        }*/

        // Do not generate SEO URLs for special routes (payments, feeds)
        $disabled_routes = array('payment/', 'feed/');

        foreach($disabled_routes as $disabled_route) {
            if (substr($route, 0, strlen($disabled_route)) == $disabled_route) {
                return true;
            }
        }

        if ($this->request->isAjax()) {
            return true;
        }

        return false;
    }
}
