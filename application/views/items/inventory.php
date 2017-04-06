<div id="required_fields_message"><?php echo $this->lang->line('common_fields_required_message'); ?></div>
<ul id="error_message_box"></ul>
<?php
echo form_close();
echo form_open('items/save_inventory/'.$item_info->item_id,array('id'=>'item_form'));
?>
<fieldset id="item_basic_info">
<legend><?php echo $this->lang->line("items_basic_information"); ?></legend>

<div class="field_row clearfix">
<div class="field_row clearfix" >	
<?php echo form_label($this->lang->line('items_item_number').':', 'name',array('class'=>'wide')); ?>

	<?php $inumber = array (
		'name'=>'item_number',
		'id'=>'item_number',
		'value'=>$item_info->item_number,
		'style'       => 'border:none',
		'readonly' => 'readonly'
	);
	
		echo form_input($inumber)
	?>
</div>

<div class="field_row clearfix">	
<?php echo form_label($this->lang->line('items_name').':', 'name',array('class'=>'wide')); ?>

	<?php $iname = array (
		'name'=>'name',
		'id'=>'name',
		'value'=>$item_info->name,
		'style'       => 'border:none',
		'readonly' => 'readonly'
	);
		echo form_input($iname);
		?>
</div>

<div class="field_row clearfix">	
<?php echo form_label($this->lang->line('items_category').':', 'category',array('class'=>'wide')); ?>
	
	<?php $cat = array (
		
		'name'=>'category',
		'id'=>'category',
		'value'=>$item_info->category,
		'style'       => 'border:none',
		'readonly' => 'readonly'
		);
	
		echo form_input($cat);
		?>
</div>

<div class="field_row clearfix">
<?php echo form_label($this->lang->line('items_current_quantity').':', 'quantity',array('class'=>'wide')); ?>

	<?php $qty = array (
	
		'name'=>'quantity',
		'id'=>'quantity',
		'value'=>$item_info->quantity,
		'style'       => 'border:none',
		'readonly' => 'readonly'
		);
	
		echo form_input($qty);
	?>
</div>
</div>

<div class="field_row clearfix">	
<?php echo form_label($this->lang->line('items_add_minus').':', 'quantity',array('class'=>'required wide')); ?>
	<div class='form_field'>
	<?php echo form_input(array(
		'name'=>'newquantity',
		'id'=>'newquantity'
		)
	);?>
	</div>
</div>

<div class="field_row clearfix">	
<?php echo form_label($this->lang->line('items_inventory_comments').':', 'description',array('class'=>'wide')); ?>
	<div class='form_field'>
	<?php echo form_textarea(array(
		'name'=>'trans_comment',
		'id'=>'trans_comment',
		'rows'=>'3',
		'cols'=>'17')		
	);?>
	</div>
</div>
<?php
echo form_submit(array(
	'name'=>'submit',
	'id'=>'submit',
	'value'=>$this->lang->line('common_submit'),
	'class'=>'btn btn-primary btn-block')
);
?>
</fieldset>
<?php 
echo form_close();
?>
<script type='text/javascript'>

//validation and submit handling
$(document).ready(function()
{		
	$('#item_form').validate({
		submitHandler:function(form)
		{
			$(form).ajaxSubmit({
			success:function(response)
			{
				tb_remove();
				post_item_form_submit(response);
			},
			dataType:'json'
		});

		},
		errorLabelContainer: "#error_message_box",
 		wrapper: "li",
		rules: 
		{
			newquantity:
			{
				required:true,
				number:true
			}
   		},
		messages: 
		{
			
			newquantity:
			{
				required:"<?php echo $this->lang->line('items_quantity_required'); ?>",
				number:"<?php echo $this->lang->line('items_quantity_number'); ?>"
			}
		}
	});
});
</script>