<?php $this->load->view("partial/header"); ?>
<?php
if (isset($error_message))
{
	echo '<h1 style="text-align: center;">'.$error_message.'</h1>';
	exit;
}
?>
<div class="print-hide" style="width: 30%; margin: 0 auto;" >
    <a class="print-hide" href="<?php echo(base_url("index.php/receivings")) ?>">
    <button id="next-btn"  class="btn-block btn btn-warning print-hide" >Lanjutkan Transaksi</button>        
    </a>    
</div>
<hr />
<div id="receipt_wrapper">
	<div id="receipt_header">
		<div id="company_name"><?php echo $this->config->item('company'); ?></div>
		<div id="company_address"><?php echo nl2br($this->config->item('address')); ?>
		<?php echo $this->config->item('phone'); ?></div>
		<div id="sale_receipt"><?php echo $receipt_title; ?></div>
		<div id="sale_time"><?php echo $transaction_time ?></div>
	</div>
    
	<div id="receipt_general_info" style="float: left;">
		<?php if(isset($supplier))
		{
		?>
			<div id="customer"><?php echo $this->lang->line('suppliers_supplier').": ".$supplier; ?></div>
		<?php
		}
		?>
		<div id="sale_id"><?php echo $this->lang->line('recvs_id').": ".$receiving_id; ?></div>
		<div id="employee"><?php echo $this->lang->line('employees_employee').": ".$employee; ?></div>
	</div>
    
   	<div style="float: right;">
	<?php echo "<img id='barcode' src='index.php/barcode?c=barcode&barcode=$receiving_id&text=$receiving_id&width=250&height=50' />"; ?>
	</div>
    
	<table id="receipt_items">
	<tr>
    <th style="width:15%;"><?php echo $this->lang->line('sales_item_number'); ?></th>
	<th style="width:50%;"><?php echo $this->lang->line('items_item'); ?></th>
	<th style="width:17%;"><?php echo $this->lang->line('common_price'); ?></th>
	<th style="width:16%;text-align:center;"><?php echo $this->lang->line('sales_quantity'); ?></th>
	<th style="width:16%;text-align:center;"><?php echo $this->lang->line('sales_discount'); ?></th>
	<th style="width:17%;text-align:right;"><?php echo $this->lang->line('sales_total'); ?></th>
	</tr>
	<?php
	foreach(array_reverse($cart, true) as $line=>$item)
	{
	?>
		<tr>
        <td><?php echo $item['item_number']; ?></td>
		<td><span class='long_name'><?php echo $item['name']; ?></span><span class='short_name'><?php echo character_limiter($item['name'],10); ?></span></td>
		<td><?php echo to_currency($item['price']); ?></td>
		<td style='text-align:center;'><?php echo $item['quantity']; ?></td>
		<td style='text-align:center;'><?php echo $item['discount']; ?></td>
		<td style='text-align:right;'><?php echo to_currency($item['price']*$item['quantity']-$item['price']*$item['quantity']*$item['discount']/100); ?></td>
		</tr>
    <?php
	}
	?>	
	<tr>
	<td colspan="4" style='text-align:right;'><?php echo $this->lang->line('sales_total'); ?></td>
	<td colspan="2" style='text-align:right'><?php echo to_currency($total); ?></td>
	</tr>

	<?php
		foreach($payments as $payment_id=>$payment)
        {
	?>
		<tr>
		<td colspan="4" style='text-align:right;'><?php echo $this->lang->line('sales_payment'); ?> :
		<?php $splitpayment=explode(':',$payment['payment_type']); echo $splitpayment[0]; ?> </td>
		<td colspan="2" style='text-align:right'><?php echo to_currency( $payment['payment_amount'] );?></td>
		</tr>
  	<?php
	}
	?>
		<tr>
		<td colspan="4" style='text-align:right;'><?php echo $this->lang->line('sales_change_due'); ?></td>
		<td colspan="2" style='text-align:right'><?php echo ($amount_change); ?></td>
		</tr>

	</table>

	<div id="sale_return_policy">
	<?php echo nl2br($this->config->item('return_policy')); ?>
	</div>

</div>

<?php $this->load->view("partial/footer"); ?>

<?php if ($this->Appconfig->get('print_after_sale'))
{
?>
<script type="text/javascript">
$(window).load(function()
{
	window.print();
    $("#next-btn").focus();
});
</script>
<?php
}
?>