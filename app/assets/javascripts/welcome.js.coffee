# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  diameter = 25
  radius = diameter / 2
  trs = $ 'tr'
  $.each trs, (i) ->
    tds = trs.eq(i).children()
    $.each tds, (j) ->
      tds.eq(j).children().css('height', diameter).css('width', diameter).css('text-align', 'center').css('vertical-align', 'middle').css('line-height', diameter + 'px')

  $.each words, (i) ->
    cells = words[i].cells
    $.each cells, (j) ->
      cell = cells[j]
      div = $ 'tr:eq(' + cell.y + ') td:eq(' + cell.x + ') > *'
      div.append '<div style="position:absolute;top:0;left:0"><svg height="' + diameter + '" width="' + diameter + '"><circle cx="' + radius + '" cy="' + radius + '" r="' + radius + '" /></svg></div>'