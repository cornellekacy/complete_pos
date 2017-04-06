<?php $this->load->view("partial/header"); ?>
<h3><center><?php echo $this->lang->line('common_welcome_message'); ?></center></h3>
<hr />
<div style="width: 90%; margin: auto;">    
	<?php
	foreach($allowed_modules->result() as $module)
	{
	?>
    <a href="<?php echo site_url("$module->module_id");?>">
    <div class="pull-left radius-5px" style="width: 23%; margin: 5px; padding: 5px; border: 1px solid #ddd;">
        <div class="pull-left">		
		<img src="<?php echo base_url().'images/menubar/'.$module->module_id.'.png';?>" alt="Pilih Menu" />        
        </div>
        <div class="pull-left" style="margin-left:10px; width:45%;">
		<div>
        <h5><?php echo $this->lang->line("module_".$module->module_id) ?></h5>
        </div>
	 	<div><?php echo $this->lang->line('module_'.$module->module_id.'_desc');?></div>
        </div>        
    </div> 
    </a>   
   	<?php
	}
	?>
</div>
<?php $this->load->view("partial/footer"); ?>