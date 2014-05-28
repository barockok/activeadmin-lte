#= require jquery
#= require jquery_ujs
#= require admin-lte/jquery.velocity.min
#= require admin-lte/jquery.columnizer
#= require admin-lte/bootstrap
#= require admin-lte/app
#= require_self

$(document).ready ->
  $('.sidebar-menu .has_nested').tree()
  $('.filter-toggle .btn').click ->
    toNumber = (string)->
      match = string.match /\d+/
      match[1] || 0

    filterIndex = $('.index-filter-outer')
    isActive = filterIndex.hasClass('active')
    height = filterIndex.height()
    console.log filterIndex.css('paddingTop')
    unless isActive
      console.log height
      filterIndex
        .addClass('active')

      filterIndex = $('.index-filter-outer')
      height = filterIndex.height()

      filterIndex
        .css
          height: '0px'
      filterIndex.velocity
          height: height, ->
            filterIndex.removeAttr('style')
    else
      console.log height
      filterIndex
        .css
          height: height
        .velocity
          height: '0px', ->
            filterIndex.removeClass('active')
            filterIndex.removeAttr('style')


