<?php
/**
 * @package     Arastta eCommerce
 * @copyright   2015-2017 Arastta Association. All rights reserved.
 * @copyright   See CREDITS.txt for credits and other copyright notices.
 * @license     GNU GPL version 3; see LICENSE.txt
 * @link        https://arastta.org
 */

class Document {

    private $title;
    private $description;
    private $keywords;
    private $metas = array();
    private $links = array();
    private $styles = array();
    private $scripts = array();
    private $style_declarations = array();
    private $script_declarations = array();

    public function setTitle($title) {
        $this->title = $title;
    }

    public function getTitle() {
        return $this->title;
    }

    public function setDescription($description) {
        $this->description = $description;
    }

    public function getDescription() {
        return $this->description;
    }

    public function setKeywords($keywords) {
        $this->keywords = $keywords;
    }

    public function getKeywords() {
        return $this->keywords;
    }

    public function addMeta($name, $content) {
        $this->metas[$name] = array(
            'name'      => $name,
            'content'   => $content
        );
    }

    public function getMetas() {
        return $this->metas;
    }

    public function addLink($href, $rel) {
        $this->links[$href] = array(
            'href' => $href,
            'rel'  => $rel
        );
    }

    public function getLinks() {
        return $this->links;
    }

    public function addStyle($href, $rel = 'stylesheet', $media = 'screen') {
        $this->styles[$href] = array(
            'href'  => $href,
            'rel'   => $rel,
            'media' => $media
        );
    }

    public function getStyles() {
        return $this->styles;
    }

    public function addStyleDeclaration($content, $type = 'text/css', $add_tag = true) {
        $this->style_declarations[] = array(
            'content' => $content,
            'type' => $type,
            'add_tag' => $add_tag,
        );

        return $this->style_declarations;
    }

    public function getStyleDeclarations() {
        return $this->style_declarations;
    }

    public function addScript($script) {
        $this->scripts[md5($script)] = $script;
    }

    public function getScripts() {
        return $this->scripts;
    }

    public function addScriptDeclaration($content, $type = 'text/javascript', $add_tag = true) {
        $this->script_declarations[] = array(
            'content' => $content,
            'type' => $type,
            'add_tag' => $add_tag,
        );

        return $this->script_declarations;
    }

    public function getScriptDeclarations() {
        return $this->script_declarations;
    }
}
