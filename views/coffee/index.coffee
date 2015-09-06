$ ->
  $(document).on 'click', '.message', () ->
    $(this).toggleClass('selected')

  $('#channel_name')
    .on 'blur', ()->
      $submit = $('#submit')
      if $(this).val()
        $submit.removeClass 'disabled'
               .removeAttr 'disabled'
      else
        $submit.addClass 'disabled'
               .attr 'disabled', 'disabled'
    .trigger 'blur'

  getSelected = (parent) ->
    $(parent).find('.selected')

  getSelectedSrc = () ->
    getSelected('#src')

  getSelectedDst = () ->
    getSelected('#dst')

  $('#add').on 'click', ()->
    $selected = getSelectedSrc()
    selectedClone = $selected.map (_, e) ->
      $(e).clone().removeClass('selected')
    $('#dst ul').append selectedClone.toArray()
    $('#src li').removeClass('selected')
    $('#dst ul').trigger 'Komonjo.change'

  $('#remove').on 'click', ()->
    $('#dst li').remove '.selected'
    $('#dst ul').trigger 'Komonjo.change'

  $('#dst ul')
    .on 'Komonjo.change', () ->
      $(this).find('li').remove '.placeholder'
      if $(this).find('li:not(.placeholder)').length == 0
        $(this).append ->
          $('<li>')
            .addClass('message placeholder')
            .text('select messages and push add button')
    .trigger 'Komonjo.change'

  $('#show').on 'click', () ->
    msg = ''
    $messages = $('#dst li')
    return false if $messages.find('img').length == 0
    $messages.each ()->
      msg += $(this).attr('data-md')
    $markdown = $('#markdown') || $('<textarea>').attr('id', 'markdown')
    $markdown.val(msg)
    $('#viewer').dialog({
      width: Math.min(window.innerWidth * 0.8, 600),
      height: Math.min(window.innerHeight * 0.8, 400)
    })
    $('#viewer').dialog("open")
    false

  $('#viewer').dialog({
    title: 'selected messages',
    modal: true,
    autoOpen: false
  })
