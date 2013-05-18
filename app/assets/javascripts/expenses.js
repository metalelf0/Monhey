$(document).ready(function(){ 
  $('#tabs a').click(function (e) {
    e.preventDefault();
    $(this).tab('show');
  })

  // FIXME: var categories = #{@categories.compact.to_json}; 
  // var categories = []; 
  // for(i = 1; i < 11; i = i + 1 ) {
  //   $("#elem" + i + "_category_name").autocomplete({
  //     source: categories,
  //     minLength: 0,
  //     delay: 0
  //   });
  // }

  $(".datepicker").datepicker({
  	format: 'yyyy-mm-dd'
  });

  $('.sign-icon').click(function() {
	  $(this).toggleClass("icon-minus-sign icon-plus-sign");
	  var signInput = $(this).parent().find('input')
	  signInput.val( (signInput.val() == "-" ? "+" : "-") );
  });
});
