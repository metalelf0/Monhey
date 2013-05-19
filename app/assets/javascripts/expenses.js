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

  $('.expense-sign').click(function() {
    var newSign = ( $(this).text() == "-" ? "+" : "-" );
    var signInput = $(this).parent().parent().find("input[type='hidden']");
    $(signInput).val(newSign);
    $(this).text(newSign);
  });
});
