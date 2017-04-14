<?php
/**
 * @package     Arastta eCommerce
 * @copyright   2015-2017 Arastta Association. All rights reserved.
 * @copyright   See CREDITS.txt for credits and other copyright notices.
 * @license     GNU GPL version 3; see LICENSE.txt
 * @link        https://arastta.org
 */

class ControllerCaptchaGoogle extends Controller
{

    public function index($error = array())
    {
        $this->load->language('captcha/google');

        $data = $this->language->all();

        if (isset($error['captcha'])) {
            $data['error_captcha'] = $error['captcha'];
        } else {
            $data['error_captcha'] = '';
        }

        $data['site_key'] = $this->config->get('google_captcha_public');

        $this->document->addScript('https://www.google.com/recaptcha/api.js');

        return $this->load->output('captcha/google', $data);
    }

    public function validate()
    {
        $status = false;

        if (empty($this->request->post['g-recaptcha-response'])) {
            return $status;
        }

        $json = file_get_contents('https://www.google.com/recaptcha/api/siteverify?secret=' . urlencode($this->config->get('google_captcha_secret')) . '&response=' . $this->request->post['g-recaptcha-response'] . '&remoteip=' . $this->request->server['REMOTE_ADDR']);

        $json = json_decode($json, true);

        if ($json['success']) {
            $status = true;
        }

        return $status;
    }
}
