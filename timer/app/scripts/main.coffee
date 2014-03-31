$ ->
  self = @

  $timerText = $ '#timer-text'

  reposition = ->
    $canvas = $ 'canvas'
    $canvas.offset
      left: ($(window).width() - $canvas.width()) / 2
      top: ($(window).height() - $canvas.height()) / 2
    $timerText.offset
      left: ($(window).width() - $timerText.width()) / 2
      top: ($(window).height() - $timerText.height()) / 2

  setInterval reposition, 100

  $('#show').click ->

    $modal = $('#myModal')
    setTimeout(->
      $modal.modal()
    , 500)

    $('.container').animate 'opacity': 0.25
    $timerText.css 'color', '#FFF'


    $dial = $('.dial')
    $dial.knob
      'rotation': 'counterclockwise'
      'readOnly': true

    self = @
    intv = null

    $modal.on 'hidden.bs.modal', ->
      $dial.val(59).trigger('change')
      clearInterval intv
      $('.container').animate 'opacity': 1

    minutes = $('#minutes').val()
    totalSeconds = minutes * 60
    currentMinuteInSeconds = 60
    intv = setInterval () ->
      if totalSeconds >= 0
        minutes = Math.floor(totalSeconds / 60)
        seconds = totalSeconds % 60
        txtMinutes = ""
        txtSeconds = ""

        if minutes >= 0 and minutes < 10
          txtMinutes = "0#{minutes}"
        else
          txtMinutes = "#{minutes}"
        if seconds >= 0 and seconds < 10
          txtSeconds = "0#{seconds}"
        else
          txtSeconds = "#{seconds}"

        timing = "#{txtMinutes}:#{txtSeconds}"
        $timerText.html timing

        if currentMinuteInSeconds > 0
          currentMinuteInSeconds--
          $dial.val(currentMinuteInSeconds).trigger('change')
        else
          currentMinuteInSeconds = 59

        if totalSeconds <= 60
          $timerText.css 'color', '#FF0000'

        totalSeconds--

        if totalSeconds == 0
          $('.header').animate 'opacity': 0
          $('.timer').animate 'opacity': 0
          $canvas.animate 'opacity': 0
    , 1000
