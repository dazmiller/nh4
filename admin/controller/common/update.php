<?php
/**
 * @package     Arastta eCommerce
 * @copyright   2015-2017 Arastta Association. All rights reserved.
 * @copyright   See CREDITS.txt for credits and other copyright notices.
 * @license     GNU GPL version 3; see LICENSE.txt
 * @link        https://arastta.org
 */

class ControllerCommonUpdate extends Controller
{

    public function index()
    {
        $this->language->load('common/update');

        $data = $this->language->all();

        $this->document->setTitle($data['heading_title']);

        if (!$this->validate('access')) {
            exit();
        }

        if (isset($this->session->data['msg_success'])) {
            $data['text_success'] = $this->session->data['msg_success'];
            unset($this->session->data['msg_success']);
        }

        if (isset($this->session->data['msg_error'])) {
            $data['text_error'] = $this->session->data['msg_error'];
            unset($this->session->data['msg_error']);
        }
        
        // Check if the version has been updated
        if (!empty($this->request->get['upd_version']) && (VERSION != $this->request->get['upd_version'])) {
            unset($data['text_success']);
            $data['text_error'] = $this->language->get('text_update_error');
        }

        if (!extension_loaded('xml')) {
            $data['text_error'] = $this->language->get('error_xml');
        }

        if (!extension_loaded('zip')) {
            $data['text_error'] = $this->language->get('error_zip');
        }

        if (!is_writable(DIR_ROOT . 'upload')) {
            $data['text_error'] = $this->language->get('error_upload');
        }

        $data['token'] = $this->session->data['token'];

        $data['check'] = $this->url->link('common/update/check', 'token=' . $this->session->data['token'], 'SSL');
        $data['update'] = $this->url->link('common/update/update', 'token=' . $this->session->data['token'], 'SSL');
        $data['changelog'] = $this->url->link('common/update/changelog', 'token=' . $this->session->data['token'], 'SSL');

        $this->load->model('extension/marketplace');
        $data['addons'] = $this->model_extension_marketplace->getAddons(true);

        $this->load->model('common/update');
        $data['updates'] = $this->model_common_update->getUpdates();

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('common/update.tpl', $data));
    }

    public function check()
    {
        if ($this->validate('modify')) {
            $this->load->model('common/update');

            // Check
            if (!$this->model_common_update->check()) {
                $this->session->data['msg_error'] = $this->language->get('text_check_error');
            } else {
                $this->session->data['msg_success'] = $this->language->get('text_check_success');
            }
        }

        // Return
        $this->response->redirect($this->url->link('common/update', 'token=' . $this->session->data['token'], 'SSL'));
    }

    public function update()
    {
        $this->language->load('common/update');

        if ($this->validate('modify') and !empty($this->request->get['product_id'])) {
            $this->load->model('common/update');

            set_time_limit(600); // 10 minutes

            // Update
            if (!$this->model_common_update->update()) {
                $this->session->data['msg_error'] = $this->language->get('text_update_error');
            } else {
                $this->request->get['extensionInstaller'] = 1;
                $this->load->controller('extension/modification/refresh');
                unset($this->request->get['extensionInstaller']);
                
                $this->session->data['msg_success'] = $this->language->get('text_update_success');
                
                $this->model_common_update->check();
            }
        }

        // Return
        $this->response->redirect($this->url->link('common/update', 'upd_version=' . $this->request->get['version'] . '&token=' . $this->session->data['token'], 'SSL'));
    }

    public function changelog()
    {
        $this->load->model('common/update');

        $output = $this->model_common_update->changelog();

        $this->response->setOutput($output);
    }

    protected function validate($type)
    {
        if (!$this->user->hasPermission($type, 'common/update')) {
            $this->session->data['msg_error'] = $this->language->get('error_permission');

            return false;
        }

        return true;
    }
}
