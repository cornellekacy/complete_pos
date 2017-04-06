<?php $this->load->view("partial/header"); ?>
<?php echo form_open('login') ?>
<div id="login-container"  class="round">
<?php echo validation_errors(); ?>
	<div id="login_form" class="radius-5px" style="">
		<div id="welcome_message">
        <div><img src="<?php echo(base_url('images/logo.png')) ?>" /></div>
		<h4><?php echo $this->lang->line('login_welcome_message'); ?></h4>
		</div>
		<div style="height: 50px;">
		<div class=" pull-left" style="width: 120px;"><?php echo $this->lang->line('login_username'); ?>: </div>
		<div class="pull-left">
		<?php echo form_input(array(
		'name'=>'username', 
		'size'=>'20')); ?>
		</div>
        </div>
        
        <div style="height: 50px;">
		<div class="pull-left" style="width: 120px;"><?php echo $this->lang->line('login_password'); ?>: </div>
		<div class="pull-left">
		<?php echo form_password(array(
		'name'=>'password', 
		'size'=>'20')); ?>		
		</div>
		</div>		
        <input class="btn btn-primary btn-block " type="submit" name="loginButton" value="<?php echo $this->lang->line('login_login'); ?>"  />		
        <hr />
        <div align="center">
        Point Of Sale Online (POS-ON) v.<?php echo $this->config->item('application_version'); ?><br />
        <a href="http://www.bpinternusa.com" target="_blank"><h4>www.bpinternusa.com</h4></a>        
        </div>
	</div>
</div>
<?php echo form_close(); ?>
<?php $this->load->view("partial/footer"); ?>