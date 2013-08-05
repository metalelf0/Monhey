$ ->
  reset_color_box = =>
    $('.color-box').removeClass("current")


  update_color_box = =>
    reset_color_box()
    current_color = $('#category_color_code').val()
    current_color_box = $(".color-box[data-color='" + current_color + "']")
    current_color_box.addClass("current")

  update_color_hidden_field = (new_color) =>
    $('#category_color_code').val(new_color)

  update_color_box()

  $('.color-box').click ->
    new_color = $(this).attr('data-color')
    console.log "New color is " + new_color
    update_color_hidden_field(new_color)
    update_color_box()


