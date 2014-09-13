#= require jquery
#= require jquery_ujs
#= require admin-lte/active_admin_has_many
#= require admin-lte/jquery.velocity.min
#= require admin-lte/bootstrap
#= require admin-lte/bootstrap.wysiwyg
#= require admin-lte/picker
#= require admin-lte/picker.date
#= require admin-lte/picker.time
#= require admin-lte/app
#= require_self

class LTEDateTime
  constructor: (el)->
    @el = $(el)

    @defineInstanceEl()
    @buildPickerDate()
    @buildPickerTime()
    @setupListener()

  defineInstanceEl: ->
    @timePickerContainer = @el.find('.lte-date-time-container > .time')
    @datePickerContainer = @el.find('.lte-date-time-container > .date')
    @inputEl             = @el.find('.lte-date-time-input')

  setupListener: ->
    @inputEl
      .on('focus', @datePicker.open)
      .on('click', (e)-> e.stopPropagation())

  buildPickerTime: ->
    @timePicker = @el.find('.time-placeholder').pickatime({
      container: @timePickerContainer
      onSet: (item)=>
        @applyDateTime() if @_isSelect(item)
    }).pickatime('picker')

  buildPickerDate: ->
    @datePicker = @el.find('.date-placeholder').pickadate({
      container: @datePickerContainer
      onSet: (item)=>
        @applyDateAndShowTime() if @_isSelect(item)
    }).pickadate('picker')


  applyDateAndShowTime: ->
    @inputEl.val @datePicker.get()
    @timePicker.open()

  applyDateTime: ->
    @inputEl.val(@inputEl.val()+ ' ' + @timePicker.get())
    @inputEl.blur()

  _isSelect: (item)->
    ('select' in (keys for keys, values of item))

class LTEDateRangeFilter
  constructor: (el)->
    @el = $(el)

    @buildPickerPlaceHolder()
    @defineInstanceEl()
    @buildPickerDateStart()
    @buildPickerDateEnd()
    @setupListener()

  setupListener: ->
    @startInputEL
      .on('focus', @pickerStart.open)
      .on('click', (e)-> e.stopPropagation())

    @endInputEL
      .on('focus', @pickerEnd.open)
      .on('click', (e)-> e.stopPropagation())

  defineInstanceEl: ->
    @startInputEL = @el.find('.datepicker').eq(0)
    @endInputEL = @el.find('.datepicker').eq(1)

  buildPickerDateStart: ->
    @pickerStart = @el.find('.start-date-placeholder').pickadate({
      onSet: (item)=>
        @applyStart() if @_isSelect(item)

    }).pickadate('picker')

  buildPickerDateEnd: ->
    @pickerEnd = @el.find('.end-date-placeholder').pickadate({
      onSet: (item)=>
        @applyEnd() if @_isSelect(item)
    }).pickadate('picker')


  applyStart: =>
    @startInputEL.val @pickerStart.get('select', 'yyyy-mm-dd')
    @startInputEL.blur()

  applyEnd: =>
    @endInputEL.val @pickerEnd.get('select', 'yyyy-mm-dd')
    @endInputEL.blur()

  openPickerEnd: =>
    @pickerEnd.open()

  buildPickerPlaceHolder: ->
    html = '''
    <div class="date-input-placeholder">
      <input type="text" class="start-date-placeholder hidden"/>
      <input type="text" class="end-date-placeholder hidden"/>
    </div>
    '''
    @el.append( $ html)

  _isSelect: (item)->
    ('select' in (keys for keys, values of item))




$(document).ready ->
  $('.sidebar-menu .has_nested').tree()
  $('.filter-toggle .btn').click ->
    filterIndex = $('.index-filter-outer')
    isActive    = filterIndex.hasClass('active')
    height      = filterIndex.height()

    if !isActive
      filterIndex.addClass('active')
      filterIndex = $('.index-filter-outer')
      height      = filterIndex.height()
      triggerAfterOpen = =>
        filterIndex.trigger 'filter:opened'
      filterIndex.trigger 'filter:beforeOpen'
      filterIndex.css(height: '0px').velocity(height: height, triggerAfterOpen)
    else
      cleanActive = ->
        filterIndex.trigger 'filter:closed'
        filterIndex.removeClass('active')
        filterIndex.removeAttr('style')

      filterIndex.trigger 'filter:beforeClose'
      filterIndex .css(height: height).velocity( height: '0px', cleanActive )

  for lteDateTime in $('.lte-date-time')
    new LTEDateTime(lteDateTime)

  for lteDateRangeFilter in $('.filter_date_range')
    new LTEDateRangeFilter(lteDateRangeFilter)

  $('.index-filter-outer').on('filter:opened', (e)->
    el = $(e.currentTarget)
    el.data('original-overflow', el.css('overflow'))
    el.css('overflow', 'visible')
  )

  $('.index-filter-outer').on('filter:beforeClose', (e)->
    el = $(e.currentTarget)
    el.css('overflow', el.data('original-overflow'))
  )


