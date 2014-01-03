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
      last = null
      if j > 0
        last = cells[j - 1]
      next = null
      if j < cells.length - 1
        next = cells[j + 1]
      cell = cells[j]
      div = $ 'tr:eq(' + cell.y + ') td:eq(' + cell.x + ') > *'
      deg = null
      if j == 0
        deg = getDirection(cell, next)
      if j == cells.length - 1
        deg = getDirection(cell, last)
      if deg != null
        div.append '<div style="position:absolute;top:0;left:0;transform:rotate(' + (deg * 45) + 'deg)"><svg height="' + diameter + 'px" width="' + diameter + 'px" viewBox="0 0 100 100"><path d="M0,50 a50,50 0 0,0 100,0" fill="none" stroke="black" stroke-width="3" /></svg></div>'

getDirection = (cell1, cell2) ->
  if cell1.x == cell2.x && cell1.y - 1 == cell2.y
    return 0
  if cell1.x + 1 == cell2.x && cell1.y - 1 == cell2.y
    return 1
  if cell1.x + 1 == cell2.x && cell1.y == cell2.y
    return 2
  if cell1.x + 1 == cell2.x && cell1.y + 1 == cell2.y
    return 3
  if cell1.x == cell2.x && cell1.y + 1 == cell2.y
    return 4
  if cell1.x - 1 == cell2.x && cell1.y + 1 == cell2.y
    return 5
  if cell1.x - 1 == cell2.x && cell1.y == cell2.y
    return 6
  if cell1.x - 1 == cell2.x && cell1.y - 1 == cell2.y
    return 7