<?php $this->load->view("partial/header"); ?>
<script type="text/javascript">
$(document).ready(function() 
{ 
    init_table_sorting();
    enable_select_all();
    enable_row_selection();
    enable_search('<?php echo site_url("$controller_name/suggest")?>','<?php echo $this->lang->line("common_confirm_search")?>');
    enable_email('<?php echo site_url("$controller_name/mailto")?>');
    enable_delete('<?php echo $this->lang->line($controller_name."_confirm_delete")?>','<?php echo $this->lang->line($controller_name."_none_selected")?>');
}); 

function init_table_sorting()
{
	//Only init if there is more than one row
	if($('.tablesorter tbody tr').length >1)
	{
		$("#sortable_table").tablesorter(
		{ 
			sortList: [[1,0]], 
			headers: 
			{ 
				0: { sorter: false}, 
				8: { sorter: false} 
			} 

		}); 
	}
}

function post_person_form_submit(response)
{
	if(!response.success)
	{
		set_feedback(response.message,'error_message',true);	
	}
	else
	{
		/*
        //This is an update, just update one row
		if(jQuery.inArray(response.person_id,get_visible_checkbox_ids()) != -1)
		{
			update_row(response.person_id,'<?php echo site_url("$controller_name/search")?>');
			set_feedback(response.message,'success_message',false);	
			
		}
		else //refresh entire table
		{
			do_search(true,function()
			{
				//highlight new row
				hightlight_row(response.person_id);
				set_feedback(response.message,'success_message',false);		
			});
		}
        */
        do_search(true,function()
			{
				//highlight new row
				hightlight_row(response.person_id);
				set_feedback(response.message,'success_message',false);		
			});
	}
}
</script>

<div id="title_bar">
	<div id="page_title"><?php echo $this->lang->line('common_list_of').' '.$this->lang->line('module_'.$controller_name); ?></div>
	<div id="new_button">
		<?php echo anchor("$controller_name/view/-1/width:$form_width",
		"<button class='btn btn-primary' style='float: left;'>".$this->lang->line($controller_name.'_new')." (alt+n)</button>",
		array('class'=>'thickbox none alt_n','title'=>$this->lang->line($controller_name.'_new')));
		?>
		<?php /*if ($controller_name =='customers') {?>
			<?php echo anchor("$controller_name/excel_import/width:$form_width",
			"<button class='btn' style='float: left;'>".$this->lang->line('common_import_excel')."</button>",
				array('class'=>'thickbox none','title'=>$this->lang->line('common_import_excel')));
			?>	
		<?php } */ ?>
	</div>
</div>
<?php echo $this->pagination->create_links();?>
<div id="table_action_header">
	<ul>
		<li class="float_left"><?php echo anchor("$controller_name/delete",$this->lang->line("common_delete").' (alt+del)',array('id'=>'delete','class'=>'btn btn-warning alt_del')); ?></li>		
        <?php if($controller_name=='customers'){ ?>
            <li class="float_left"><?php echo anchor("$controller_name/reassign_card",$this->lang->line("customers_remove_all_card"),array('id'=>'remove_card','class'=>'btn btn-danger')); ?></li>
        <?php } ?>
        
        <?php /* <li class="float_left"><?php echo anchor("#",$this->lang->line("common_email"),array('id'=>'email','class'=>'btn btn-primary')); ?></li> */?>
        
		<li class="float_right" style="width: 250px;">        
		<img src='<?php echo base_url()?>images/spinner_small.gif' alt='spinner' id='spinner' />
		<?php echo form_open("$controller_name/search",array('id'=>'search_form')); ?>
		<input class="pull-right" type="text" name ='search' id="search" placeholder="<?php echo $this->lang->line("common_search"); ?>"/>
		</form>
		</li>
	</ul>
</div>
<div id="table_holder">
<?php echo $manage_table; ?>
</div>
<div id="feedback_bar"></div>
<?php $this->load->view("partial/footer"); ?>