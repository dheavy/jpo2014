$ ->
  self = @

  $('#show').avgrund({
    width: 0,
    height: 0,
    holderClass: 'popin',
    enableStackAnimation: true,
    onBlurContainer: '.container',
  })

  reposition = ->
    $canvas = $('canvas')
    $canvas.offset
      left: ($(window).width() - $canvas.width()) / 2
      top: ($(window).height() - $canvas.height()) / 2

  $(window).on 'resize', reposition

  $('#show').click ->
    $modal = $('#myModal')
    $modal.modal()

    $dial = $('.dial')
    $dial.knob
      'rotation': 'counterclockwise'
      'readOnly': true

    self = @
    intv = null

    $modal.on 'hidden.bs.modal', ->
      $dial.val(59).trigger('change')
      clearInterval intv

    minutes = $('#minutes').val()
    totalSeconds = minutes * 60
    currentMinuteInSeconds = 60
    intv = setInterval () ->
      if totalSeconds > 0
        if currentMinuteInSeconds > 0
          currentMinuteInSeconds--
          $dial.val(currentMinuteInSeconds).trigger('change')
        else
          currentMinuteInSeconds = 59
        totalSeconds--
    , 1000
