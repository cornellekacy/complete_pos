<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<base href="<?php echo base_url();?>" />
	<title><?php echo $this->config->item('company').' - POS On' ?></title>
	<link rel="stylesheet" rev="stylesheet" href="<?php echo base_url();?>css/style.css" media="screen"/>
	<link rel="stylesheet" rev="stylesheet" href="<?php echo base_url();?>css/style_print.css"  media="print"/>    
    <link rel="stylesheet" rev="stylesheet" href="<?php echo base_url();?>css/bootstrap.css"  media="screen"/>
    <link rel="stylesheet" rev="stylesheet" href="<?php echo base_url();?>css/bootstrap-responsive.css"  media="screen"/>    
    
	<script>BASE_URL = '<?php echo site_url(); ?>';</script>
	<script src="<?php echo base_url();?>js/jquery-1.2.6.min.js" type="text/javascript" language="javascript" charset="UTF-8"></script>
	<script src="<?php echo base_url();?>js/jquery.color.js" type="text/javascript" language="javascript" charset="UTF-8"></script>
	<script src="<?php echo base_url();?>js/jquery.metadata.js" type="text/javascript" language="javascript" charset="UTF-8"></script>
	<script src="<?php echo base_url();?>js/jquery.form.js" type="text/javascript" language="javascript" charset="UTF-8"></script>
	<script src="<?php echo base_url();?>js/jquery.tablesorter.min.js" type="text/javascript" language="javascript" charset="UTF-8"></script>
	<script src="<?php echo base_url();?>js/jquery.ajax_queue.js" type="text/javascript" language="javascript" charset="UTF-8"></script>
	<script src="<?php echo base_url();?>js/jquery.bgiframe.min.js" type="text/javascript" language="javascript" charset="UTF-8"></script>
	<script src="<?php echo base_url();?>js/jquery.autocomplete.js" type="text/javascript" language="javascript" charset="UTF-8"></script>
	<script src="<?php echo base_url();?>js/jquery.validate.min.js" type="text/javascript" language="javascript" charset="UTF-8"></script>
	<script src="<?php echo base_url();?>js/jquery.jkey-1.1.js" type="text/javascript" language="javascript" charset="UTF-8"></script>
	<script src="<?php echo base_url();?>js/thickbox.js" type="text/javascript" language="javascript" charset="UTF-8"></script>
	<script src="<?php echo base_url();?>js/common.js" type="text/javascript" language="javascript" charset="UTF-8"></script>
	<script src="<?php echo base_url();?>js/manage_tables.js" type="text/javascript" language="javascript" charset="UTF-8"></script>
	<script src="<?php echo base_url();?>js/swfobject.js" type="text/javascript" language="javascript" charset="UTF-8"></script>
	<script src="<?php echo base_url();?>js/date.js" type="text/javascript" language="javascript" charset="UTF-8"></script>
	<script src="<?php echo base_url();?>js/datepicker.js" type="text/javascript" language="javascript" charset="UTF-8"></script>
	
<style type="text/css">
html {
    overflow: auto;
}
</style>

</head>
<body>
<?php
	if(isset($allowed_modules)){
?>
<div class="navbar">
  <div class="navbar-inner">
    <a class="brand" href="<?php echo(base_url()); ?>"><img src="<?php echo(base_url("images/logo-mini.png")); ?>" /> <?php //echo $this->config->item('company'); ?></a>
    <div class="float_right">
    <ul class="nav">
    <?php    
    $i=0;
    foreach($allowed_modules->result() as $module)
	{ $i++;
    ?>
	<li>
	   <a class="f_<?php echo $i; ?>" href="<?php echo site_url("$module->module_id");?>">
        <?php echo $this->lang->line("module_".$module->module_id) ?><span class="shortcut">F<?php echo $i; ?></span>       
       </a>
	</li>
	<?php    
	}
	?>
    <li>
  		<?php echo anchor("home/logout",$this->lang->line("common_logout")); ?>
    </li>    
    </ul>
    </div>
  </div>
</div>

<script language="javascript">
// setting module key press
<?php
	$i=0;
    foreach($allowed_modules->result() as $module)
	{ $i++;
?>
$(window).jkey('f<?php echo $i; ?>',function(){    
    window.location = BASE_URL + '/<?php echo $module->module_id;?>';
});
<?php
	}
?>
</script>


<?php
	}
?>
<div id="content_area_wrapper">
<div id="content_area">
