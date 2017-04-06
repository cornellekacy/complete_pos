function get_dimensions() 
{
	var dims = {width:0,height:0};
	
  if( typeof( window.innerWidth ) == 'number' ) {
    //Non-IE
    dims.width = window.innerWidth;
    dims.height = window.innerHeight;
  } else if( document.documentElement && ( document.documentElement.clientWidth || document.documentElement.clientHeight ) ) {
    //IE 6+ in 'standards compliant mode'
    dims.width = document.documentElement.clientWidth;
    dims.height = document.documentElement.clientHeight;
  } else if( document.body && ( document.body.clientWidth || document.body.clientHeight ) ) {
    //IE 4 compatible
    dims.width = document.body.clientWidth;
    dims.height = document.body.clientHeight;
  }
  
  return dims;
}

function set_feedback(text, classname, keep_displayed)
{
	if(text!='')
	{
		$('#feedback_bar').removeClass();
		$('#feedback_bar').addClass(classname);
		$('#feedback_bar').text(text);
		$('#feedback_bar').css('opacity','1');

		if(!keep_displayed)
		{
			$('#feedback_bar').fadeTo(5000, 1);
			$('#feedback_bar').fadeTo("fast",0);
		}
	}
	else
	{
		$('#feedback_bar').css('opacity','0');
	}
}

//keylisteners

//input ditandai dengan angka
$(window).jkey('alt+1',function(){
    $(".alt_1").focus();
});

$(window).jkey('alt+2',function(){
    $(".alt_2").focus();
});

$(window).jkey('alt+3',function(){
    $(".alt_3").focus();
});

$(window).jkey('alt+4',function(){
    $(".alt_4").focus();
});

$(window).jkey('alt+5',function(){
    $(".alt_5").focus();
});


//button ditandai dengan huruf

$(window).jkey('alt+q',function(){
    $(".alt_q").click();
});
$(window).jkey('alt+w',function(){
    $(".alt_w").click();
});
$(window).jkey('alt+e',function(){
    $(".alt_e").click();
});
$(window).jkey('alt+r',function(){
    $(".alt_r").click();
});
$(window).jkey('alt+t',function(){
    $(".alt_t").click();
});
$(window).jkey('alt+y',function(){
    $(".alt_y").click();
});

$(window).jkey('alt+a',function(){
    $(".alt_a").click();
});

$(window).jkey('alt+b',function(){
    $(".alt_b").click();
});

$(window).jkey('alt+c',function(){
    $(".alt_c").click();
});

$(window).jkey('alt+n',function(){
    $(".alt_n").click();
});

$(window).jkey('alt+s',function(){
    $(".alt_s").click();
});


//warning button
$(window).jkey('alt+delete',function(){
    $(".alt_del").click();
});
$(window).jkey('delete',function(){
    $(".alt_del").click();
});

