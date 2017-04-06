<?php $this->load->view("partial/header"); ?>
<div id="page_title" style="margin-bottom:8px;"><?php echo $this->lang->line('sales_register'); ?></div>
<?php
if(isset($error))
{
	echo "<div class='error_message'>".$error."</div>";
}

if (isset($warning))
{
	echo "<div class='warning_mesage'>".$warning."</div>";
}

if (isset($success))
{
	echo "<div class='success_message'>".$success."</div>";
}
?>
<div id="register_wrapper" class="radius-5px">
<div id="register-header">
<?php echo form_open("sales/change_mode",array('id'=>'mode_form', 'class'=>'radius-5px pull-left ')); ?>
	<label class="item_label" for="item" style="float: left;"><?php echo $this->lang->line('sales_mode') ?> (alt+5)</label>
<?php echo form_dropdown('mode',$modes,$mode,'onchange="$(\'#mode_form\').submit();" , class="alt_5"'); ?>
<?php
/*
<div id="show_suspended_sales_button">
	<?php echo anchor("sales/suspended/width:425",
	"<div class='small_button'><span style='font-size:73%;'>".$this->lang->line('sales_suspended_sales')."</span></div>",
	array('class'=>'thickbox none','title'=>$this->lang->line('sales_suspended_sales')));
	?>
</div>*/
?>

</form>

<?php  
// search_item_form
echo form_open("sales/add",array('id'=>'search_item_form', 'class'=>'radius-5px pull-right')); ?>

<label class="item_label pull-left" for="item">

<?php
if($mode=='sale')
{
	echo $this->lang->line('sales_find_or_scan_item');
}
else
{
	echo $this->lang->line('sales_find_or_scan_item_or_receipt');
}
?>
 (alt+1) 
</label>
<?php echo form_input(array('name'=>'item','id'=>'item', 'class'=>'alt_1' ,'size'=>'40'));?>
<?php /*
	<div id="new_item_button_register" >
		<?php echo anchor("items/view/-1/width:360",
		"<div class='small_button'><span>".$this->lang->line('sales_new_item')."</span></div>",
		array('class'=>'thickbox none','title'=>$this->lang->line('sales_new_item')));
		?>
	</div>

    */
?>
</form>
</div>

<div style="margin-top: 50px;">

<table id="register" class="table tablesorter table-bordered" >
<thead>
<tr>
<th style="width:11%;"><?php echo $this->lang->line('common_delete'); ?></th>
<th style="width:30%;"><?php echo $this->lang->line('sales_item_number'); ?></th>
<th style="width:30%;"><?php echo $this->lang->line('sales_item_name'); ?></th>
<th style="width:11%;"><?php echo $this->lang->line('sales_price'); ?></th>
<th style="width:11%;"><?php echo $this->lang->line('sales_quantity'); ?></th>
<th style="width:11%;"><?php echo $this->lang->line('sales_discount'); ?></th>
<th style="width:15%;"><?php echo $this->lang->line('sales_total'); ?></th>
<th style="width:11%;"><?php echo $this->lang->line('sales_edit'); ?></th>
</tr>
</thead>
<tbody id="cart_contents" class="table-striped">
<?php
if(count($cart)==0)
{
?>
<tr><td colspan='8'>
<div class='warning_message' style='padding:7px;'><?php echo $this->lang->line('sales_no_items_in_cart'); ?></div>
</tr></tr>
<?php
}
else
{
	foreach(array_reverse($cart, true) as $line=>$item)
	{
		$cur_item_info = $this->Item->get_info($item['item_id']);
		echo form_open("sales/edit_item/$line");
	?>
		<tr>
		<td><?php echo anchor("sales/delete_item/$line",$this->lang->line('common_delete'), array('class'=>'btn btn-small'));?></td>
		<td><?php echo $item['item_number']; ?></td>
		<td style="align:center;"><?php echo $item['name']; ?><br /> [<?php echo $cur_item_info->quantity; ?> in stock]</td>



		<?php if ($items_module_allowed)
		{
		?>
			<td><?php /* echo to_currency($item['price']); */ echo form_input(array('name'=>'price','value'=>to_currency($item['price']),'size'=>'6', 'class'=>'input-medium'));?></td>
		<?php
		}
		else
		{
		?>
			<td><?php echo $item['price']; ?></td>
			<?php // echo form_hidden('price',$item['price']); ?>
		<?php
		}
		?>

		<td>
		<?php
        	if($item['is_serialized']==1)
        	{
        		echo $item['quantity'];
        		echo form_hidden('quantity',$item['quantity']);
        	}
        	else
        	{
        		echo form_input(array('name'=>'quantity','value'=>$item['quantity'],'size'=>'2', 'class'=>'input-mini'));
        	}
		?>
		</td>
        
		<td><?php echo form_input(array('name'=>'discount','value'=>$item['discount'],'size'=>'3', 'class'=>'input-mini' ));?></td>
        
		<td><?php echo to_currency($item['price']*$item['quantity']-$item['price']*$item['quantity']*$item['discount']/100); ?></td>
		<td><?php echo form_submit(array('name'=> 'edit_item', 'class'=>'btn btn-small'), $this->lang->line('sales_edit_item'));?></td>
		</tr>
		<tr class="warning">
		<td style="color:#2F4F4F";><?php echo $this->lang->line('sales_description_abbrv').':';?></td>
		<td colspan=2 style="text-align:left;">

		<?php
        	if($item['allow_alt_description']==1)
        	{
        		echo form_input(array('name'=>'description','value'=>$item['description'],'size'=>'20', 'class'=>'input-small'));
        	}
        	else
        	{
				if ($item['description']!='')
				{
					echo $item['description'];
        			echo form_hidden('description',$item['description']);
        		}
        		else
        		{
        			echo 'None';
        			echo form_hidden('description','');
        		}
        	}
		?>
		</td>
		<td>&nbsp;</td>
		<td style="color:#2F4F4F";>
		<?php
        	if($item['is_serialized']==1)
        	{
				echo $this->lang->line('sales_serial').':';
			}
		?>
		</td>
		<td colspan=3 style="text-align:left;">
		<?php
        	if($item['is_serialized']==1)
        	{
        		echo form_input(array('name'=>'serialnumber','value'=>$item['serialnumber'],'size'=>'20'));
			}
			else
			{
				echo form_hidden('serialnumber', '');
			}
		?>
		</td>
		</tr>		
        </form>
	<?php
	}
}
?>
</tbody>
</table>
</div>

</div>

<!-- Overall Receiving -->

<div id="overall_sale">
<div id="inner" class="radius-5px">

	<?php
	if(isset($customer))
	{
		echo $this->lang->line("sales_customer").': <b>'.$customer. '</b><br />';
		echo anchor("sales/remove_customer",'['.$this->lang->line('sales_remove_customer').' (alt+2)]',array('class'=>'alt_2'));
	}
	else
	{
		echo form_open("sales/select_customer",array('id'=>'select_customer_form')); ?>
		<label id="customer_label" for="customer"><?php echo $this->lang->line('sales_select_customer'); ?> (alt+2)</label>
		<?php echo form_input(array('name'=>'customer','id'=>'customer','class'=>'input-block-level alt_2', 'style'=>'margin:auto','size'=>'30','value'=>$this->lang->line('sales_start_typing_customer_name')));?>
		</form>
		<div style="margin-top:5px;text-align:center;">
		<h3 style="margin: 5px 0 5px 0"><?php echo $this->lang->line('common_or'); ?></h3>
		<?php echo anchor("customers/view/-1/width:800",
		"<button class='btn btn-primary' style='margin:0 auto;'><span>".$this->lang->line('sales_new_customer')." (alt+b)</span></button>",
		array('class'=>'thickbox none alt_b','title'=>$this->lang->line('sales_new_customer')));
		?>
		</div>       	
		<?php
	}
	?>

	<div id='sale_details'>
		<div class="float_left" style="width:45%;"><?php echo $this->lang->line('sales_sub_total'); ?>:</div>
		<div class="float_left" style="width:55%;font-weight:bold;"><?php echo to_currency($subtotal); ?></div>
        
		<?php foreach($taxes as $name=>$value) { ?>
		<div class="float_left" style='width:45%;'><?php echo $name; ?>:</div>
		<div class="float_left" style="width:55%;font-weight:bold;"><?php echo to_currency($value); ?></div>
		<?php }; ?>

		<div class="float_left" style='width:45%;'><?php echo $this->lang->line('sales_total'); ?>:</div>
		<div class="float_left" style="width:55%;font-weight:bold;"><?php echo to_currency($total); ?></div>
	</div>

	<?php
	// Only show this part if there are Items already in the sale.
	if(count($cart) > 0)
	{
	?>
    	<div id="Cancel_sale">
		<?php echo form_open("sales/cancel_sale",array('id'=>'cancel_sale_form')); ?>
		<button class='btn btn-danger alt_c' id='cancel_sale_button'>
			<span><?php echo $this->lang->line('sales_cancel_sale'); ?> (alt+c)</span>
		</button>
    	</form>
    	</div>
		<div class="clearfix" style="margin-bottom:1px;">&nbsp;</div>
		<?php
		// Only show this part if there is at least one payment entered.
		if(count($payments) > 0)
		{
		?>
			<div id="finish_sale">
				<?php echo form_open("sales/complete",array('id'=>'finish_sale_form')); ?>
				<label id="comment_label" for="comment" class="pull-left" style="margin-right: 10px;"><?php echo $this->lang->line('common_comments'); ?>:</label>
				<?php echo form_textarea(array('name'=>'comment', 'id' => 'comment', 'class'=>'input-block-level', 'value'=>$comment,'rows'=>'2','cols'=>'23'));?>
				<br />				
				<?php				
				if(!empty($customer_email))
				{
					echo $this->lang->line('sales_email_receipt'). ': '. form_checkbox(array(
					    'name'        => 'email_receipt',
					    'id'          => 'email_receipt',
					    'value'       => '1',
					    'checked'     => (boolean)$email_receipt,
					    )).'<br />('.$customer_email.')<br />';
				}
				 
				if ($payments_cover_total)
				{
					echo "<button class='btn btn-primary alt_s' id='finish_sale_button' style='float:left;margin-top:5px;'><span>".$this->lang->line('sales_complete_sale')." (alt+s)</span></button>";
				}
				echo "<button class='btn btn-warning alt_t' id='suspend_sale_button' style='float:right;margin-top:5px;'><span>".$this->lang->line('sales_suspend_sale')." (alt+t)</span></button>";
				?>
			</div>
			</form>
		<?php
		}
		?>

    <table width="100%"><tr>
    <td style="width:45%; "><h5><div><?php echo $this->lang->line( 'seles_payment_total' )?></div></h5></td>
    <td style="width:55%;"><h4><div><?php echo to_currency($payments_total); ?></div></h4></td>
	</tr>
	<tr>    
	<td style="width:45%;"><h5><div><?php echo $this->lang->line( 'seles_payment_change' ) ?></div></h5></td>
	<td style="width:55%;" ><h4><div style="color: #f22;"><?php echo to_currency($amount_due); ?></div></h4></td>
    </tr>
    </table>

	<div id="Payment_Types" >
		<div >
			<?php echo form_open("sales/add_payment",array('id'=>'add_payment_form')); ?>
			<table width="100%">
			<tr>
			<td>
				<?php echo $this->lang->line('sales_payment');?>(alt+3)
			</td>
			<td>
				<?php echo form_dropdown( 'payment_type', $payment_options, array(), 'id="payment_types" class="alt_3"' ); ?>
			</td>
			</tr>
			<tr>
			<td>
				<span id="amount_tendered_label"><?php echo $this->lang->line( 'sales_amount_tendered' ); ?> </span>(alt+4)
			</td>
			<td>
				<?php echo form_input( array( 'name'=>'amount_tendered', 'id'=>'amount_tendered', 'class'=>'alt_4' , 'value'=>'', 'size'=>'10' ) );	?>
			</td>
			</tr>
        	</table>
			<div class='btn btn-success pull-right alt_a' id='add_payment_button' style='margin-top:5px;'>
				<span><?php echo $this->lang->line('sales_add_payment'); ?> (alt+a) </span>
			</div>
		</div>
		</form>

		<?php
		// Only show this part if there is at least one payment entered.
		if(count($payments) > 0)
		{
		?>
	    	<table class="table table-bordered table-striped" style="background-color: #fff;">
	    	<thead>
			<tr>
			<th style="width:11%;"><?php echo $this->lang->line('common_delete'); ?></th>
			<th style="width:60%;"><?php echo 'Type'; ?></th>
			<th style="width:18%;"><?php echo 'Amount'; ?></th>

			</tr>
			</thead>
			<tbody id="payment_contents">
			<?php
				foreach($payments as $payment_id=>$payment)
				{
				echo form_open("sales/edit_payment/$payment_id",array('id'=>'edit_payment_form'.$payment_id));
				?>
	            <tr>
	                <td><?php echo anchor( "sales/delete_payment/$payment_id", '['.$this->lang->line('common_delete').']' ); ?></td>
                    <td><?php echo $payment['payment_type']; ?></td>
                    <td style="text-align:right;"><?php echo to_currency( $payment['payment_amount'] ); ?></td>
				</tr>
				</form>
				<?php
				}
				?>
			</tbody>
			</table>
		    <br />
		<?php
		}
		?>

	</div>

	<?php
	}
	?>
</div>    
</div>
<div class="clearfix" style="margin-bottom:30px;">&nbsp;</div>


<?php $this->load->view("partial/footer"); ?>

<script type="text/javascript" language="javascript">
$(document).ready(function()
{
    $("#item").autocomplete('<?php echo site_url("sales/item_search"); ?>',
    {
    	minChars:0,
    	max:100,
    	selectFirst: false,
       	delay:10,
    	formatItem: function(row) {
			return row[1];
		}
    });

    $("#item").result(function(event, data, formatted)
    {
		$("#add_item_form").submit();
    });

	$('#item').focus();
    /*
	$('#item').blur(function()
    {
    	$(this).attr('value',"<?php echo $this->lang->line('sales_start_typing_item_name'); ?>");
    }); */

	$('#item,#customer').click(function()
    {
    	$(this).attr('value','');
    });

    $("#customer").autocomplete('<?php echo site_url("sales/customer_search"); ?>',
    {
    	minChars:0,
    	delay:10,
    	max:100,
    	formatItem: function(row) {
			return row[1];
		}
    });

    $("#customer").result(function(event, data, formatted)
    {
		$("#select_customer_form").submit();
    });

    $('#customer').blur(function()
    {
    	$(this).attr('value',"<?php echo $this->lang->line('sales_start_typing_customer_name'); ?>");
    });
	
	$('#comment').change(function() 
	{
		$.post('<?php echo site_url("sales/set_comment");?>', {comment: $('#comment').val()});
	});
	
	$('#email_receipt').change(function() 
	{
		$.post('<?php echo site_url("sales/set_email_receipt");?>', {email_receipt: $('#email_receipt').is(':checked') ? '1' : '0'});
	});
	
	
    $("#finish_sale_button").click(function()
    {
    	if (confirm('<?php echo $this->lang->line("sales_confirm_finish_sale"); ?>'))
    	{
    		$('#finish_sale_form').submit();
    	}
    });

	$("#suspend_sale_button").click(function()
	{
		if (confirm('<?php echo $this->lang->line("sales_confirm_suspend_sale"); ?>'))
    	{
			$('#finish_sale_form').attr('action', '<?php echo site_url("sales/suspend"); ?>');
    		$('#finish_sale_form').submit();
    	}
	});

    $("#cancel_sale_button").click(function()
    {
    	if (confirm('<?php echo $this->lang->line("sales_confirm_cancel_sale"); ?>'))
    	{
    		$('#cancel_sale_form').submit();
    	}
    });

	$("#add_payment_button").click(function()
	{
	   $('#add_payment_form').submit();
    });

	$("#payment_types").change(checkPaymentTypeGiftcard).ready(checkPaymentTypeGiftcard)
});

function post_item_form_submit(response)
{
	if(response.success)
	{
		$("#item").attr("value",response.item_id);
		$("#add_item_form").submit();
	}
}

function post_person_form_submit(response)
{
	if(response.success)
	{
		$("#customer").attr("value",response.person_id);
		$("#select_customer_form").submit();
	}
}

function checkPaymentTypeGiftcard()
{
	if ($("#payment_types").val() == "<?php echo $this->lang->line('sales_giftcard'); ?>")
	{
		$("#amount_tendered_label").html("<?php echo $this->lang->line('sales_giftcard_number'); ?>");
		$("#amount_tendered").val('');
		$("#amount_tendered").focus();
	}
	else
	{
		$("#amount_tendered_label").html("<?php echo $this->lang->line('sales_amount_tendered'); ?>");		
	}
}

</script>
