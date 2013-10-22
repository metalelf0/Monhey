$(document).ready(function(){
  $('#tabs a').click(function (e) {
    e.preventDefault();
    $(this).tab('show');
  })

  var nowTemp = new Date();
  var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);


  $(".datepicker").datepicker({
    format: 'yyyy-mm-dd'
  });

  $(".datepicker-end-date").datepicker({
    format: 'yyyy-mm-dd',
    viewMode: 'months',
    minViewMode: 'months',
    onRender: function(date) {
      return date.valueOf() < now.valueOf() ? 'disabled' : '';
    }
  }).on('changeDate', function(ev) {
    console.log(ev);
    if (ev.date.valueOf() < now.valueOf() ) {
      console.log("No buono");
    } else {
      $(ev.target).datepicker('hide');
    }
  });


  $('.expense-sign').click(function() {
    var newSign = ( $(this).text() == "-" ? "+" : "-" );
    var signInput = $(this).parent().parent().find("input[type='hidden']");
    $(signInput).val(newSign);
    $(this).text(newSign);
  });
});
