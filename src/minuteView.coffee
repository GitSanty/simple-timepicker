class MinuteView extends SimpleDatepicker.View

  name: 'minute'

  _inputTpl: '<input type="text" class="view-input minute-input" data-type="minute" data-min="0" data-max="59"/>'

  _renderPanel: ->
    el = "<div class='panel panel-minute'>"

    for minute in [0..55] by 5
      el += "<a class='panel-item' data-value='#{minute}'>#{String("00" + minute).slice(-2);}</a>"

    el += '</div>'

  _onInputHandler: (e) ->
    value = @input.val()
    if value.length is 2 and Number(value) < 60
      @select(value, true, true)
    else if value.length is 1
      @timer = setTimeout =>
        @select(value, false, true)
        @timer = null
      , 800

  _onKeydownHandler: (e) ->
    clearTimeout @timer if @timer

    super(e)

  _onDateChangeHandler: (e) ->
    @value = e.minute

    @_refreshInput()
    @_refreshSelected()

  _refreshSelected: ->
    value = @value
    value = Math.floor(value / 5) * 5
    value += if @value % 5 >= 3 then 5 else 0

    @panel.find('.selected').removeClass 'selected'
    @panel.find("[data-value=#{value}]").addClass 'selected'

  _refreshInput: ->
    @input.val String('00' + @value).slice(-2)

SimpleDatepicker.View.addView MinuteView
