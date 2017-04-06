<?php $this->load->view("partial/header"); ?>

<div id="page_title" style="margin-bottom:8px;"><?php echo $this->lang->line('recvs_register'); ?></div>

<?php
if(isset($error))
{
	echo "<div class='error_message'>".$error."</div>";
}
?>

<div id="register_wrapper"  class="radius-5px">
<div id="register-header">
	<?php echo form_open("receivings/change_mode",array('id'=>'mode_form', 'class'=>'radius-5px pull-left')); ?>
		<label class="item_label pull-left"><?php echo $this->lang->line('recvs_mode') ?> (alt+5)</label>
	<?php echo form_dropdown('mode',$modes,$mode,'onchange="$(\'#mode_form\').submit();", class="alt_5"'); ?>
	</form>
	
    <div id="search_item_form"  class="radius-5px pull-right">    
    <?php echo form_open("receivings/add",array('class'=>"radius-5px pull-left")); ?>
	<label for="item" class="item_label pull-left">

	<?php
	if($mode=='receive')
	{
		echo $this->lang->line('recvs_find_or_scan_item');
	}
	else
	{
		echo $this->lang->line('recvs_find_or_scan_item_or_receipt');
	}
	?> (alt+1)
	</label>
    <?php echo form_input(array('name'=>'item',' class'=>'alt_1', 'id'=>'item','size'=>'40'));?>
    </form>
	
    <?php echo anchor("items/view/-1/width:800",
		"<button class='btn btn-primary pull-right' style='margin-left:5px'>".$this->lang->line('sales_new_item')." (alt+n)</button>",
		array('class'=>'thickbox none alt_n','title'=>$this->lang->line('sales_new_item')));
	?>
    </div>    
</div>

<!-- Receiving Items List -->

<table id="register" class="table tablesorter table-striped table-bordered" >
<thead>
<tr>
<th style="width:11%;"><?php echo $this->lang->line('common_delete'); ?></th>
<th style="width:30%;"><?php echo $this->lang->line('sales_item_number'); ?></th>
<th style="width:30%;"><?php echo $this->lang->line('recvs_item_name'); ?></th>
<th style="width:11%;"><?php echo $this->lang->line('recvs_cost'); ?></th>
<th style="width:11%;"><?php echo $this->lang->line('recvs_quantity'); ?></th>
<th style="width:11%;"><?php echo $this->lang->line('recvs_discount'); ?></th>
<th style="width:15%;"><?php echo $this->lang->line('recvs_total'); ?></th>
<th style="width:11%;"><?php echo $this->lang->line('recvs_edit'); ?></th>
</tr>
</thead>
<tbody id="cart_contents">
<?php
if(count($cart)==0)
{
?>
<tr><td colspan='8'>
<div class='warning_message' style='padding:7px;'><?php echo $this->lang->line('sales_no_items_in_cart'); ?></div>
</td>
</tr>
<?php
}
else
{
	foreach(array_reverse($cart, true) as $line=>$item)
	{
		echo form_open("receivings/edit_item/$line");
	?>
		<tr>
		<td><?php echo anchor("receivings/delete_item/$line",$this->lang->line('common_delete'),array('class'=>'btn btn-small'));?></td>
        <td><?php echo $item['item_number']; ?></td>
		<td style="align:center;"><?php echo $item['name']; ?><br />

		<?php
			echo $item['description'];
      		echo form_hidden('description',$item['description']);
		?>
		<br />

		<?php if ($items_module_allowed)
		{
		?>
			<td><?php echo form_input(array('name'=>'price','value'=>to_currency($item['price']),'size'=>'6', 'class'=>'input-medium'));?></td>
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
        	echo form_input(array('name'=>'quantity','value'=>$item['quantity'],'size'=>'2', 'class'=>'input-mini'));
		?>
		</td>
		
        <td>
            <?php echo form_input(array('name'=>'discount','value'=>$item['discount'],'size'=>'3','class'=>'input-mini'));?>
        </td>
        
		<td><?php echo to_currency($item['price']*$item['quantity']-$item['price']*$item['quantity']*$item['discount']/100); ?></td>
		<td><?php echo form_submit("edit_item", $this->lang->line('sales_edit_item'), 'class="btn btn-small"');?></td>
		</tr>
		</form>
	<?php
	}
}
?>
</tbody>
</table>
</div>

<!-- Overall Receiving -->

<div id="overall_sale">
<div id="inner" class="radius-5px">
	<?php
	if(isset($supplier))
	{
		echo $this->lang->line("recvs_supplier").': <b>'.$supplier. '</b><br />';
		echo anchor("receivings/delete_supplier",'['.$this->lang->line('common_delete').' '.$this->lang->line('suppliers_supplier').'(alt+2)]', array('class'=>'alt_2'));
	}
	else
	{
		echo form_open("receivings/select_supplier",array('id'=>'select_supplier_form')); ?>
		<label id="supplier_label" for="supplier"><?php echo $this->lang->line('recvs_select_supplier'); ?> (alt+2)</label>
		<?php echo form_input(array('name'=>'supplier','id'=>'supplier', 'class'=>'input-block-level alt_2' ,'size'=>'30','value'=>$this->lang->line('recvs_start_typing_supplier_name')));?>
		</form>
		<div style="margin-top:5px;text-align:center;">
		<h3 style="margin: 5px 0 5px 0"><?php echo $this->lang->line('common_or'); ?></h3>
		<?php echo anchor("suppliers/view/-1/width:800",
		"<div class='btn btn-primary' style='margin:0 auto;'><span>".$this->lang->line('recvs_new_supplier')." (alt+b) </span></div>",
		array('class'=>'thickbox none alt_b','title'=>$this->lang->line('recvs_new_supplier')));
		?>
		</div>		
		<?php
	}
	?>

	<div id='sale_details'>
    <h4>
		<div class="float_left" style='width:45%;'><?php echo $this->lang->line('sales_total'); ?>:</div>
		<div class="float_left" style="width:55%;font-weight:bold;"><?php echo to_currency($total); ?></div>
    </h4>    
	</div>
	<?php
	if(count($cart) > 0)
	{
	?>
	<div>				
            <div id="Cancel_sale" class="pull-left">
            <?php echo form_open("receivings/cancel_receiving",array('id'=>'cancel_sale_form')); ?>
                <button class='btn btn-danger alt_c' id='cancel_sale_button'><?php echo $this->lang->line('common_cancel'); ?> (alt+c)</button>
            </form>
            </div>
                    
             
        
        <div class="clearfix" style="margin-bottom:1px;">&nbsp;</div>                
		<label id="comment_label" class="pull-left" for="comment" style="margin-right: 10px;" ><?php echo $this->lang->line('common_comments'); ?>:</label>
		<?php echo form_textarea(array('name'=>'comment','value'=>'','id' => 'comment','class'=>'input-block-level','rows'=>'2','cols'=>'23'));?>		        		
        <br />
        
      		<?php
            // Only show this part if there is at least one payment entered.
            if(count($payments) > 0)
    		{ ?>
            <?php echo form_open("receivings/complete",array('id'=>'finish_sale_form')); ?>
            <div class='btn btn-primary alt_s' id='finish_sale_button'>
    		      <?php echo $this->lang->line('recvs_complete_receiving');?> (alt+s)           
            </div>
             </form>
            <?php } ?>               
                  
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
        <?php echo form_open("receivings/add_payment",array('id'=>'add_payment_form')); ?>
        <table width="100%"><tr><td>
		<?php
			echo $this->lang->line('sales_payment');?> (alt+3)
		</td><td>
		<?php
		    echo form_dropdown('payment_type',$payment_options,'','class="alt_3"');?>
        </td>
        </tr>

        <tr>
        <td>
        <?php
			echo $this->lang->line('sales_amount_tendered');?> (alt+4)
		</td><td>
		<?php
		    echo form_input(array('name'=>'amount_tendered','value'=>'','size'=>'10', 'class'=>'alt_4'));
		?>
        </td>
        </tr>
        </table>
        <div class='btn btn-success alt_a' id="add_payment_button" style='float:right;margin-top:5px;'>
            <span>
		      <?php echo $this->lang->line('sales_add_payment');?> (alt+a)
            </span>
        </div>  
        </form>
        </div>      
        
        <br />
        <div>        

		</form>

        </div>
	</div>
        		
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
				echo form_open("receivings/edit_payment/$payment_id",array('id'=>'edit_payment_form'.$payment_id));
				?>
	            <tr>
	                <td><?php echo anchor( "receivings/delete_payment/$payment_id", '['.$this->lang->line('common_delete').']' ); ?></td>
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

    
	<?php
	}
	?>
</div>

<div class="clearfix" style="margin-bottom:30px;">&nbsp;</div>


<?php $this->load->view("partial/footer"); ?>


<script type="text/javascript" language="javascript">
$(document).ready(function()
{
    $("#item").autocomplete('<?php echo site_url("receivings/item_search"); ?>',
    {
    	minChars:0,
    	max:100,
       	delay:10,
       	selectFirst: false,
    	formatItem: function(row) {
			return row[1];
		}
    });

    $("#item").result(function(event, data, formatted)
    {
		$("#add_item_form").submit();
    });

	$('#item').focus();

	$('#item').blur(function()
    {
    	$(this).attr('value',"<?php echo $this->lang->line('sales_start_typing_item_name'); ?>");
    });

	$('#item,#supplier').click(function()
    {
    	$(this).attr('value','');
    });

    $("#supplier").autocomplete('<?php echo site_url("receivings/supplier_search"); ?>',
    {
    	minChars:0,
    	delay:10,
    	max:100,
    	formatItem: function(row) {
			return row[1];
		}
    });

    $("#supplier").result(function(event, data, formatted)
    {
		$("#select_supplier_form").submit();
    });

    $('#supplier').blur(function()
    {
    	$(this).attr('value',"<?php echo $this->lang->line('recvs_start_typing_supplier_name'); ?>");
    });

    $("#finish_sale_button").click(function()
    {
    	if (confirm('<?php echo $this->lang->line("recvs_confirm_finish_receiving"); ?>'))
    	{
    		$('#finish_sale_form').submit();
    	}
    });

    $("#cancel_sale_button").click(function()
    {
    	if (confirm('<?php echo $this->lang->line("recvs_confirm_cancel_receiving"); ?>'))
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
		$("#supplier").attr("value",response.person_id);
		$("#select_supplier_form").submit();
	}
}

</script>