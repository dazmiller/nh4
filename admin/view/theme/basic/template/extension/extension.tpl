<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <h1><?php echo $heading_title; ?></h1>
            <div class="pull-right">
                <a href="<?php echo $add; ?>" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-success" data-original-title="<?php echo $button_add; ?>"><i class="fa fa-plus"></i></a>
                <a href="<?php echo $upload; ?>" data-toggle="tooltip" title="<?php echo $button_upload; ?>" class="btn btn-default" data-original-title="<?php echo $button_upload; ?>"><i class="fa fa-upload"></i></a>
            </div>
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
                <h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $text_list; ?></h3>
                <div class="pull-right">
                    <button type="button" data-toggle="tooltip" title="<?php echo $button_show_filter; ?>" class="btn btn-primary btn-sm" id="showFilter"><i class="fa fa-eye"></i></button>
                    <button type="button" data-toggle="tooltip" title="<?php echo $button_hide_filter; ?>" class="btn btn-primary btn-sm" id="hideFilter"><i class="fa fa-eye-slash"></i></button>
                </div>
            </div>
            <div class="panel-body">
                <div class="well" style="display:none;">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="input-group">
                                <div class="input-group-btn">
                                    <button type="button" class="btn btn-default dropdown-toggle basic-filter-button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        <div class="filter-type"><?php echo $column_name; ?></div> <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li><a class="filter-list-type" onclick="changeFilterType('<?php echo $column_name; ?>', 'filter_name');"><?php echo $column_name; ?></a></li>
                                        <li><a class="filter-list-type" onclick="changeFilterType('<?php echo $column_author; ?>', 'filter_author');"><?php echo $column_author; ?></a></li>
                                        <li><a class="filter-list-type" onclick="changeFilterType('<?php echo $column_type; ?>', 'filter_type');"><?php echo $column_type; ?></a></li>
                                        <li><a class="filter-list-type" onclick="changeFilterType('<?php echo $column_status; ?>', 'filter_status');"><?php echo $column_status; ?></a></li>
                                    </ul>
                                </div>
                                <input type="text" name="filter_name"  value="<?php echo $filter_name; ?>" placeholder="<?php echo $text_filter . $column_name; ?>" id="input-name" class="form-control filter" autocomplete="off" />
                                <input type="text" name="filter_author" value="<?php echo $filter_author; ?>" placeholder="<?php echo $text_filter . $column_author; ?>" id="input-author" class="form-control filter hidden" autocomplete="off" />
                                <select name="filter_type" class="form-control filter hidden">
                                    <option value="*"><?php echo $text_filter . $column_type; ?></option>
                                    <option value="payment" <?php echo ($filter_type == 'payment') ? 'selected="selected"' : ''; ?> ><?php echo $text_payment; ?></option>
                                    <option value="shipping" <?php echo ($filter_type == 'shipping') ? 'selected="selected"' : ''; ?> ><?php echo $text_shipping; ?></option>
                                    <option value="module" <?php echo ($filter_type == 'module') ? 'selected="selected"' : ''; ?> ><?php echo $text_module; ?></option>
                                    <option value="total" <?php echo ($filter_type == 'total') ? 'selected="selected"' : ''; ?> ><?php echo $text_total; ?></option>
                                    <option value="feed" <?php echo ($filter_type == 'feed') ? 'selected="selected"' : ''; ?> ><?php echo $text_feed; ?></option>
                                    <option value="editor" <?php echo ($filter_type == 'editor') ? 'selected="selected"' : ''; ?> ><?php echo $text_editor; ?></option>
                                    <option value="captcha" <?php echo ($filter_type == 'captcha') ? 'selected="selected"' : ''; ?> ><?php echo $text_captcha; ?></option>
                                    <option value="twofactorauth" <?php echo ($filter_type == 'twofactorauth') ? 'selected="selected"' : ''; ?> ><?php echo $text_twofactorauth; ?></option>
                                    <option value="analytics" <?php echo ($filter_type == 'analytics') ? 'selected="selected"' : ''; ?> ><?php echo $text_analytics; ?></option>
                                    <option value="antifraud" <?php echo ($filter_type == 'antifraud') ? 'selected="selected"' : ''; ?> ><?php echo $text_antifraud; ?></option>
                                    <option value="other" <?php echo ($filter_type == 'other') ? 'selected="selected"' : ''; ?> ><?php echo $text_other; ?></option>
                                </select>
                                <select name="filter_status" id="input-status" class="form-control filter hidden">
                                    <option value="*"><?php echo $text_filter . $column_status; ?></option>
                                    <?php if ($filter_status) { ?>
                                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                    <?php } else { ?>
                                    <option value="1"><?php echo $text_enabled; ?></option>
                                    <?php } ?>
                                    <?php if (!$filter_status && !is_null($filter_status)) { ?>
                                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                    <?php } else { ?>
                                    <option value="0"><?php echo $text_disabled; ?></option>
                                    <?php } ?>
                                </select>
                            </div>
                        </div>
                    </div>
                    <?php if (!empty($filter_name) || !empty($filter_author) || !empty($filter_type) || isset($filter_status)) { ?>
                    <div class="row">
                        <div class="col-lg-12 filter-tag">
                            <?php if ($filter_name) { ?>
                            <div class="filter-info pull-left">
                                <label class="control-label"><?php echo $column_name; ?>:</label> <label class="filter-label"> <?php echo $filter_name; ?></label>
                                <a class="filter-remove" onclick="removeFilter(this, 'filter_name');"><i class="fa fa-times"></i></a>
                            </div>
                            <?php } ?>
                            <?php if ($filter_author) { ?>
                            <div class="filter-info pull-left">
                                <label class="control-label"><?php echo $column_author; ?>:</label> <label class="filter-label"> <?php echo $filter_author; ?></label>
                                <a class="filter-remove" onclick="removeFilter(this, 'filter_author');"><i class="fa fa-times"></i></a>
                            </div>
                            <?php } ?>
                            <?php if ($filter_type) { ?>
                            <div class="filter-info pull-left">
                                <label class="control-label"><?php echo $column_type; ?>:</label> <label class="filter-label"> 
                                <?php 
                                if ($filter_type == 'payment') {
                                    echo $text_payment;
                                } elseif ($filter_type == 'shipping') {
                                    echo $text_shipping;
                                } elseif ($filter_type == 'module') {
                                    echo $text_module;
                                } elseif ($filter_type == 'total') {
                                    echo $text_total;
                                } elseif ($filter_type == 'feed') {
                                    echo $text_feed;
                                } elseif ($filter_type == 'editor') {
                                    echo $text_editor;
                                } elseif ($filter_type == 'captcha') {
                                    echo $text_captcha;
                                } elseif ($filter_type == 'twofactorauth') {
                                    echo $text_twofactorauth;
                                } elseif ($filter_type == 'analytics') {
                                    echo $text_analytics;
                                } elseif ($filter_type == 'antifraud') {
                                    echo $text_antifraud;
                                } elseif ($filter_type == 'other') {
                                    echo $text_other;
                                }
                                ?></label>
                                <a class="filter-remove" onclick="removeFilter(this, 'filter_type');"><i class="fa fa-times"></i></a>
                            </div>
                            <?php } ?>
                            <?php if (isset($filter_status)) { ?>
                            <div class="filter-info pull-left">
                                <label class="control-label"><?php echo $column_status; ?>:</label> <label class="filter-label"> <?php echo ($filter_status) ? $text_enabled : $text_disabled; ?></label>
                                <a class="filter-remove" onclick="removeFilter(this, 'filter_status');"><i class="fa fa-times"></i></a>
                            </div>
                            <?php } ?>
                        </div>
                    </div>
                    <?php } ?>
                </div>
                <div class="table-responsive">
                    <form id="form-extension" method="post">
                        <table class="table table-hover">
                            <thead>
                            <tr>
                                <?php if ($sortable_active) { ?>
                                <td class="text-center">
                                    <div id="sort-order-list" data-toggle="tooltip" title="<?php echo $column_sortable; ?>">
                                        <i class="fa fa-sort" aria-hidden="true"></i>
                                    </div>
                                </td>
                                <?php } ?>
                                <td style="width: 70px;" class="text-center">
                                    <?php if ($filter_type != 'module') { ?>
                                    <div class="bulk-action">
                                        <input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" />
                                        <span class="bulk-caret"><i class="fa fa-caret-down"></i></span>
                                        <span class="item-selected"></span>
                                        <span class="bulk-action-button">
                                          <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                              <b><?php echo $text_bulk_action; ?></b>
                                              <span class="caret"></span>
                                          </a>
                                          <ul class="dropdown-menu dropdown-menu-left alerts-dropdown">
                                              <li class="dropdown-header"><?php echo $text_bulk_action; ?></li>
                                              <li><a onclick="changeStatus(1)"><i class="fa fa-check-circle text-success"></i> <?php echo $button_enable; ?></a></li>
                                              <li><a onclick="changeStatus(0)"><i class="fa fa-times-circle text-danger"></i> <?php echo $button_disable; ?></a></li>
                                          </ul>
                                        </span>
                                    </div>
                                    <?php } else { ?>
                                    <div class="bulk-action">
                                        <input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" />
                                        <span class="bulk-caret"><i class="fa fa-caret-down"></i></span>
                                        <span class="item-selected" style="border-bottom-right-radius: 3px; border-top-right-radius: 3px;"></span>
                                    </div>
                                <?php } ?></td>
                                <td class="text-left"><?php if ($sort == 'name') { ?>
                                    <a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
                                    <?php } else { ?>
                                    <a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
                                    <?php } ?>
                                </td>
                                <td class="text-left"><?php if ($sort == 'author') { ?>
                                    <a href="<?php echo $sort_author; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_author; ?></a>
                                    <?php } else { ?>
                                    <a href="<?php echo $sort_author; ?>"><?php echo $column_author; ?></a>
                                    <?php } ?>
                                </td>
                                <td class="text-left column-120"><?php echo $column_version; ?></td>
                                <?php if (!$filter_type) { ?>
                                <td class="text-left"><?php if ($sort == 'type') { ?>
                                    <a href="<?php echo $sort_type; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_type; ?></a>
                                    <?php } else { ?>
                                    <a href="<?php echo $sort_type; ?>"><?php echo $column_type; ?></a>
                                    <?php } ?>
                                </td>
                                <?php } ?>
                                <td class="text-left column-120"><?php echo $column_status; ?></td>
                                <td class="text-right column-120"><?php echo $column_sort_order; ?></td>
                            </tr>
                            </thead>
                            <?php if ($sortable_active) { ?>
                            <?php if ($sortable) { ?>
                            <tbody class="sortable-list">
                            <?php } else { ?>
                            <tbody>
                                <input type="hidden" name="sort_order_type"  id="sort-order-type" value="sort_order" class="form-control"/>
                            <?php } ?>
                            <?php } else { ?>
                            <tbody>
                            <?php } ?>
                            <?php if ($extensions) { ?>
                            <?php foreach ($extensions as $extension) { ?>
                            <tr>
                                <?php if ($sortable_active) { ?>
                                <td class="text-center sortable">
                                    <?php if ($sortable) { ?>
                                    <i class="fa fa-bars" aria-hidden="true"></i>
                                    <?php } else { ?>
                                    <div data-toggle="tooltip" title="<?php echo $text_sortable; ?>">
                                        <i class="fa fa-bars" aria-hidden="true"></i>
                                    </div>
                                    <?php } ?>
                                </td>
                                <?php } ?>
                                <td class="text-center"><input type="checkbox" name="selected[]" value="<?php echo $extension['type'] . '/' . $extension['code']; ?>" /></td>
                                <td class="text-left">
                                    <a href="<?php echo $extension['edit']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>"  class="btn btn-primary btn-sm btn-basic-list"><i class="fa fa-pencil"></i></a>
                                    <a onclick="confirmItemSetLink('<?php echo $text_confirm_title; ?>', '<?php echo $text_confirm; ?>', '<?php echo $extension['uninstall']; ?>');" data-toggle="tooltip" title="<?php echo $button_uninstall; ?>"  class="btn btn-danger btn-sm btn-basic-list"><i class="fa fa-minus-circle"></i></a>
                                    <?php echo $extension['name']; ?>
                                    <?php if ($extension['instances']) { ?>
                                    <?php foreach ($extension['instances'] as $instance) { ?>
                                    <table>
                                        <tr>
                                            <td class="text-left">&nbsp;</td>
                                            <td class="text-left" colspan="6">
                                                &nbsp;&nbsp;&nbsp;&#8618;&nbsp;&nbsp;<?php echo $instance['name']; ?>&nbsp;&nbsp;
                                                <a href="<?php echo $instance['edit']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary btn-sm btn-basic-list"><i class="fa fa-pencil"></i></a>
                                                <a onclick="confirmItemSetLink('<?php echo $text_confirm_title; ?>', '<?php echo $text_confirm; ?>', '<?php echo $instance['delete']; ?>');" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger btn-sm btn-basic-list"><i class="fa fa-trash"></i></a>
                                            </td>
                                        </tr>
                                    </table>
                                    <?php } ?>
                                    <?php } ?>
                                </td>
                                <td class="text-left"><?php echo $extension['author'] ?></td>
                                <td class="text-left"><?php echo $extension['version'] ?></td>
                                <?php if (!$filter_type) { ?>
                                <td class="text-left"><?php echo $extension['type_name'] ?></td>
                                <?php } ?>
                                <td class="text-left"><?php echo $extension['status'] ?></td>
                                <td class="text-right"><?php echo $extension['sort_order']; ?></td>
                                <td class="hidden">
                                    <input type="hidden" name="items[code][]" value="<?php echo $extension['code']; ?>" class="form-control"/>
                                    <input type="hidden" name="items[sort_order][]" value="<?php echo $extension['extension_id']; ?>" class="form-control"/>
                                </td>
                            </tr>
                            <?php } ?>
                            <?php } else { ?>
                            <tr>
                                <?php if ($sortable_active) { ?>
                                <td class="text-center" colspan="9"><?php echo $text_no_results; ?></td>
                                <?php } else { ?>
                                <td class="text-center" colspan="8"><?php echo $text_no_results; ?></td>
                                <?php } ?>
                            </tr>
                            <?php } ?>
                            </tbody>
                        </table>
                    </form>
                    <div class="row">
                        <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
                        <div class="col-sm-6 text-right"><?php echo $results; ?></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript"><!--
function filter() {
    url = 'index.php?route=extension/extension&token=<?php echo $token; ?>';

    var filter_name = $('input[name=\'filter_name\']').val();

    if (filter_name) {
        url += '&filter_name=' + encodeURIComponent(filter_name);
    }

    var filter_author = $('input[name=\'filter_author\']').val();

    if (filter_author) {
        url += '&filter_author=' + encodeURIComponent(filter_author);
    }

    var filter_type = $('select[name=\'filter_type\']').val();

    if (filter_type != '*') {
        url += '&filter_type=' + encodeURIComponent(filter_type);
    }

    var filter_status = $('select[name=\'filter_status\']').val();

    if (filter_status != '*') {
        url += '&filter_status=' + encodeURIComponent(filter_status);
    }

    var filter_sortable = getURLVar('sortable');

    if (filter_sortable) {
        url += '&order=ASC&sortable=active';
    }

    location = url;
}
//--></script>
<?php echo $footer; ?>
