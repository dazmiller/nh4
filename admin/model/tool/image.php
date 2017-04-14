<?php
/**
 * @package     Arastta eCommerce
 * @copyright   2015-2017 Arastta Association. All rights reserved.
 * @copyright   See CREDITS.txt for credits and other copyright notices.
 * @license     GNU GPL version 3; see LICENSE.txt
 * @link        https://arastta.org
 */

class ModelToolImage extends Model {
    public function resize($filename, $width, $height) {
        if (!is_file(DIR_IMAGE . $filename)) {
            return;
        }

        $extension = pathinfo($filename, PATHINFO_EXTENSION);

        $old_image = $filename;
        $new_image = 'cache/' . utf8_substr($filename, 0, utf8_strrpos($filename, '.')) . '-' . $width . 'x' . $height . '.' . $extension;

        if (!is_file(DIR_IMAGE . $new_image) || (filectime(DIR_IMAGE . $old_image) > filectime(DIR_IMAGE . $new_image))) {
            list($width_orig, $height_orig) = getimagesize(DIR_IMAGE . $old_image);

            if ($width_orig != $width || $height_orig != $height) {
                $path = '';

                $directories = explode('/', dirname(str_replace('../', '', $new_image)));

                foreach ($directories as $directory) {
                    $path = $path . '/' . $directory;

                    if (!is_dir(DIR_IMAGE . $path)) {
                        $this->filesystem->mkdir(DIR_IMAGE . $path);
                    }
                }

                $image = new Image(DIR_IMAGE . $old_image);
                $image->resize($width, $height);
                $image->save(DIR_IMAGE . $new_image);
            } else {
                $this->filesystem->copy(DIR_IMAGE . $old_image, DIR_IMAGE . $new_image);
            }
        }

        if ($this->request->server['HTTPS']) {
            return HTTPS_CATALOG . 'image/' . $new_image;
        } else {
            return HTTP_CATALOG . 'image/' . $new_image;
        }
    }
}
