#= require jquery
#= require jquery_ujs
#= require active_admin/base
#= require ckeditor/init
#= require just_datetime_picker/nested_form_workaround
#= require livequery.js
#= require twitter/bootstrap

$('.bar-success').livequery (e) ->
  $.each($(this), (i,e) ->
    if parseInt($(e).css('margin-left')) < 0
      $(e).css('opacity','0.5')
      $(e).prev().css('opacity','0.5')
      width = Math.abs(parseInt($(e).css('margin-left'))) / parseInt($(e).css('width')) * 100
      $(e).append('<div class="bar bar-success" style="background:red; opacity: 0.8; width:' + width + '%;"</div>')
  )

$('.bar-success').hover (->
    console.log('dd')
    $(this).addClass('active')
    return
  ), ->
    $(this).removeClass 'active'
    return
