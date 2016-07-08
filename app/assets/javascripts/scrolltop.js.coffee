$ ->
  $(window).scroll ->
    element = $('#page-top-btn')
    visible = element.is(':visible')
    height = $(window).scrollTop()
    if height > 250
      element.fadeIn() if !visible
    else
      element.fadeOut()
      
  $('#move-page-top').click ->
    $('html, body').animate({ scrollTop: 0 }, '1000')