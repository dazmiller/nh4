<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button type="submit" onclick="save('save')" form="form-banner" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-success" data-original-title="Save"><i class="fa fa-check"></i></button>
                <button type="submit" form="form-banner" data-toggle="tooltip" title="<?php echo $button_saveclose; ?>" class="btn btn-default" data-original-title="Save & Close"><i class="fa fa-save text-success"></i></button>
                <button type="submit" onclick="save('new')" form="form-banner" data-toggle="tooltip" title="<?php echo $button_savenew; ?>" class="btn btn-default" data-original-title="Save & New"><i class="fa fa-plus text-success"></i></button>
                <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-times-circle text-danger"></i></a>
            </div>
            <h1><?php echo $heading_title; ?></h1>
        </div>
    </div>
    <div class="container-fluid">
        <?php if ($error_warning) { ?>
        <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>
        <?php if ($success) { ?>
        <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-banner" class="form-horizontal">
            <div class="row">
                <div class="left-col col-sm-8">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <div class="general">
                                <div class="form-group required">
                                    <label class="col-sm-12" for="input-name"><?php echo $entry_name; ?></label>
                                    <div class="col-sm-12">
                                        <input type="text" name="name" value="<?php echo $name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
                                        <?php if ($error_name) { ?>
                                        <div class="text-danger"><?php echo $error_name; ?></div>
                                        <?php } ?>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title"><?php echo $tab_image; ?></h3>
                            <div class="pull-right">
                                <div class="panel-chevron"><i class="fa fa-chevron-up rotate-reset"></i></div>
                            </div>
                        </div>
                        <div class="panel-body">
                            <div class="images">
								<ul class="nav nav-tabs" id="language">
									<?php foreach ($languages as $language) { ?>
									<li><a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
									<?php } ?>
								</ul>
								<div class="tab-content">
									<?php foreach ($languages as $language) { ?>
									<div class="tab-pane" id="language<?php echo $language['language_id']; ?>">
										<table id="images<?php echo $language['language_id']; ?>" class="table table-striped table-hover">
											<thead>
											<tr>
												<td class="text-left"><?php echo $entry_title; ?></td>
												<td class="text-left"><?php echo $entry_link; ?></td>
												<td class="text-left"><?php echo $entry_image; ?></td>
												<td class="text-right hidden"><?php echo $entry_sort_order; ?></td>
												<td></td>
											</tr>
											</thead>
											<tbody>
											<?php $image_row = 0; ?>
											<?php if (isset($banner_images[$language['language_id']])) { ?>
											<?php foreach ($banner_images[$language['language_id']] as $banner_image) { ?>
											<tr id="image-row<?php echo $language['language_id']; ?>-<?php echo $image_row; ?>">
												<td class="text-left"><input type="text" name="banner_image[<?php echo $language['language_id']; ?>][<?php echo $image_row; ?>][title]" value="<?php echo $banner_image['title']; ?>" placeholder="<?php echo $entry_title; ?>" class="form-control" />
													<?php if (isset($error_banner_image[$language['language_id']][$image_row])) { ?>
													<div class="text-danger"><?php echo $error_banner_image[$language['language_id']][$image_row]; ?></div>
													<?php } ?></td>
												<td class="text-left" style="width: 30%;"><input type="text" name="banner_image[<?php echo $language['language_id']; ?>][<?php echo $image_row; ?>][link]" value="<?php echo $banner_image['link']; ?>" placeholder="<?php echo $entry_link; ?>" class="form-control" /></td>
												<td class="text-left"><a href="" id="thumb-image<?php echo $image_row; ?>" data-toggle="image" class="img-thumbnail"><img src="<?php echo $banner_image['thumb']; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
													<input type="hidden" name="banner_image[<?php echo $language['language_id']; ?>][<?php echo $image_row; ?>][image]" value="<?php echo $banner_image['image']; ?>" id="input-image<?php echo $language['language_id']; ?>-<?php echo $image_row; ?>" /></td>
												<td class="text-right hidden" style="width: 10%;"><input type="text" name="banner_image[<?php echo $language['language_id']; ?>][<?php echo $image_row; ?>][sort_order]" value="<?php echo $banner_image['sort_order']; ?>" placeholder="<?php echo $entry_sort_order; ?>" class="form-control" /></td>
												<td class="text-left"><button type="button" onclick="$('#image-row<?php echo $language['language_id']; ?>-<?php echo $image_row; ?>, .tooltip').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger btn-sm btn-basic-list"><i class="fa fa-minus-circle"></i></button></td>
											</tr>
											<?php $image_row++; ?>
											<?php } ?>
											<?php } ?>
											</tbody>
											<tfoot>
											<tr>
												<td colspan="3"></td>
												<td class="text-left"><a onclick="addImage(<?php echo $language['language_id']; ?>);" data-toggle="tooltip" title="<?php echo $button_banner_add; ?>" class="btn btn-primary btn-sm btn-basic-list"><i class="fa fa-plus-circle"></i></a></td>
											</tr>
											</tfoot>
										</table>
									</div>
									<?php } ?>
								</div>
							</div>
						</div>
                    </div>
                </div>
                <div class="right-col col-sm-4">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title"><?php echo $text_publish; ?></h3>
                            <div class="pull-right">
                                <div class="panel-chevron"><i class="fa fa-chevron-up rotate-reset"></i></div>
                            </div>
                        </div>
                        <div class="panel-body">
                            <div class="publish">
                                <div class="form-group">
                                    <label class="col-sm-12"><?php echo $text_enabled; ?></label>
                                    <div class="col-sm-12">
                                        <label class="radio-inline">
                                            <?php if ($status) { ?>
                                            <input type="radio" name="status" value="1" checked="checked" />
                                            <?php echo $text_enabled; ?>
                                            <?php } else { ?>
                                            <input type="radio" name="status" value="1" />
                                            <?php echo $text_enabled; ?>
                                            <?php } ?>
                                        </label>
                                        <label class="radio-inline">
                                            <?php if (!$status) { ?>
                                            <input type="radio" name="status" value="0" checked="checked" />
                                            <?php echo $text_disabled; ?>
                                            <?php } else { ?>
                                            <input type="radio" name="status" value="0" />
                                            <?php echo $text_disabled; ?>
                                            <?php } ?>
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <style type="text/css"><!--
        .images span.input-group-addon, .images .input-group-btn {
            width: 3% !important;
            min-width: 40px !important;
        }
    //--></style>
    <script type="text/javascript"><!--
    var image_row = <?php echo $image_row; ?>;

    function addImage(language_id) {
		html  = '<tr id="image-row' + language_id + '-' + image_row + '">';
		html += '  <td class="text-left"><input type="text" name="banner_image[' + language_id + '][' + image_row + '][title]" value="" placeholder="<?php echo $entry_title; ?>" class="form-control" /></td>';
		html += '  <td class="text-left" style="width: 30%;"><input type="text" name="banner_image[' + language_id + '][' + image_row + '][link]" value="" placeholder="<?php echo $entry_link; ?>" class="form-control" /></td>';
		html += '  <td class="text-left"><a href="" id="thumb-image' + language_id + '-' + image_row + '" data-toggle="image" class="img-thumbnail"><img src="<?php echo $placeholder; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a><input type="hidden" name="banner_image[' + language_id + '][' + image_row + '][image]" value="" id="input-image' + image_row + '" /></td>';
		html += '  <td class="text-right hidden" style="width: 10%;"><input type="text" name="banner_image[' + language_id + '][' + image_row + '][sort_order]" value="" placeholder="<?php echo $entry_sort_order; ?>" class="form-control" /></td>';
		html += '  <td class="text-left"><button type="button" onclick="$(\'#image-row' + language_id + '-' + image_row  + ', .tooltip\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger btn-sm btn-basic-list"><i class="fa fa-minus-circle"></i></button></td>';
		html += '</tr>';

		$('#images' + language_id + ' tbody').append(html);

        image_row++;
    }
    //--></script>
	<script type="text/javascript"><!--
		$('#language a:first').tab('show');
	//--></script></div>
<?php echo $footer; ?>
