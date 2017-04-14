<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button type="submit" onclick="save('save')" form="form-stock-status" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-success"><i class="fa fa-check"></i></button>
                <button type="submit" form="form-stock-status" data-toggle="tooltip" title="<?php echo $button_saveclose; ?>" class="btn btn-default" data-original-title="Save & Close"><i class="fa fa-save text-success"></i></button>
                <button type="submit" onclick="save('new')" form="form-stock-status" data-toggle="tooltip" title="<?php echo $button_savenew; ?>" class="btn btn-default" data-original-title="Save & New"><i class="fa fa-plus text-success"></i></button>
                <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-times-circle text-danger"></i></a></div>
            <h1><?php echo $heading_title; ?></h1>
            <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                <?php } ?>
            </ul>
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
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_form; ?></h3>
            </div>
            <div class="panel-body">
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-stock-status" class="form-horizontal">
                    <ul class="nav nav-tabs" id="language">
                        <?php foreach ($languages as $language) { ?>
                        <li><a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
                        <?php } ?>
                    </ul>
                    <div class="tab-content">
                        <?php foreach ($languages as $language) { ?>
                        <div class="tab-pane" id="language<?php echo $language['language_id']; ?>">
                            <div class="form-group required">
                                <label class="col-sm-2 control-label"><?php echo $entry_name; ?></label>
                                <div class="col-sm-10">
                                    <div class="input-group">
                                        <input type="text" name="stock_status[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($stock_status[$language['language_id']]) ? $stock_status[$language['language_id']]['name'] : ''; ?>" placeholder="<?php echo $entry_name; ?>" class="form-control" />
                                    </div>
                                    <?php if (isset($error_name[$language['language_id']])) { ?>
                                    <div class="text-danger"><?php echo $error_name[$language['language_id']]; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label"><?php echo $entry_color; ?></label>
                                <div class="col-sm-10">
                                    <div class="customizer-control-content">
                                        <div class="wp-picker-container">
                                            <span class="wp-picker-input-wrap">
                                                <div class="input-group">
                                                    <input type="text" name="stock_status[<?php echo $language['language_id']; ?>][color]" id="stock_status_color_<?php echo $language['language_id']; ?>" class="color-picker-hex wp-color-picker" maxlength="7" value="<?php echo isset($stock_status[$language['language_id']]) ? $stock_status[$language['language_id']]['color'] : ''; ?>" data-default-color="<?php echo isset($stock_status[$language['language_id']]) ? $stock_status[$language['language_id']]['color'] : ''; ?>" style="display: none;">
                                                    <input type="button" class="button button-small hidden wp-picker-default" value="<?php echo $entry_default; ?>">
                                                </div>
                                            </span>
                                            <div class="wp-picker-holder"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-stock-status-preorder-<?php echo $language['language_id']; ?>"><span data-toggle="tooltip" title="<?php echo $help_preorder; ?>"><?php echo $entry_preorder; ?></span></label>
                                <div class="col-sm-10">
                                    <select name="stock_status[<?php echo $language['language_id']; ?>][preorder]" id="input-stock-status-preorder-<?php echo $language['language_id']; ?>" class="form-control">
                                        <?php if (isset($stock_status[$language['language_id']]['preorder'])) { ?>
                                        <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                                        <option value="0"><?php echo $text_no; ?></option>
                                        <?php } else { ?>
                                        <option value="1"><?php echo $text_yes; ?></option>
                                        <option value="0" selected="selected"><?php echo $text_no; ?></option>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <?php } ?>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var wpColorPickerL10n = {"clear":"<?php echo $entry_clear; ?>","defaultString":"<?php echo $entry_default; ?>","pick":"<?php echo $entry_pick; ?>","current":"<?php echo $entry_current; ?>"};
</script>
<script type="text/javascript"><!--
$('#language a:first').tab('show');
//--></script>
<script type="text/javascript"><!--
function save(type){
    var input = document.createElement('input');
    input.type = 'hidden';
    input.name = 'button';
    input.value = type;
    form = $("form[id^='form-']").append(input);
    form.submit();
}
//--></script>
<script type="text/javascript">
    <?php foreach ($languages as $language) { ?>
        picker = $('#stock_status_color_<?php echo $language["language_id"]; ?>');
        picker.val('<?php echo isset($stock_status[$language["language_id"]]) ? $stock_status[$language["language_id"]]["color"] : '#000'; ?>').wpColorPicker();
        <?php } ?>
</script>
<?php echo $footer; ?>
