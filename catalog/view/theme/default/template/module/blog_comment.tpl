<h3 class="module-title"><span><?php echo $heading_title; ?></span></h3>
<?php if ($comments) { ?>
<div class="blog-comments-module">
<?php foreach ($comments as $comment) { ?>
    <div class="blog-comment-module">
        <h4><a href="<?php echo $comment['href']; ?>"><?php echo $comment['name']; ?></a></h4>
        <p><?php echo $text_write; ?> <a href="<?php echo $comment['href']; ?>"><?php echo $comment['author']; ?></a></p>
        <p><img src="<?php echo $comment['thumb']; ?>" class="img-circle pull-left" style="margin:0 10px 10px 0" alt="<?php echo $comment['author']; ?>" /> <?php echo $comment['text']; ?></p>
    </div>
    <?php } ?>
</div>
<?php } ?>
