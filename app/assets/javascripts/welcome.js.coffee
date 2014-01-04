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
      tds.eq(j).children().css('height', diameter).css('width', diameter).css('line-height', diameter + 'px')

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
      div = $ 'tr:eq({0}) td:eq({1}) > *'.format(cell.y, cell.x)
      dir = null
      if j == 0 || j == cells.length - 1
        if j == 0
          dir = getDirection(cell, next)
        if j == cells.length - 1
          dir = getDirection(cell, last)
        if dir != null
          div.append '' +
            '<div style="position:absolute;top:0;left:0;transform:rotate(' + (dir * 45) + 'deg)">' +
              '<svg height="' + diameter + 'px" width="' + diameter + 'px" viewBox="0 0 100 100">' +
                '<path d="M0,50 a50,50 0 0,0 100,0" fill="none" stroke="black" stroke-width="3" />' +
              '</svg>' +
            '</div>'

      if j > 0
        dir = getDirection(cell, last)
        if dir == 7 || dir == 0 || dir == 1
          top = -diameter
          height = diameter * 2
          y1 = radius
          y2 = radius + diameter
        else if dir == 3 || dir == 4 || dir == 5
          top = 0
          height = diameter * 2
          y1 = radius + diameter
          y2 = radius
        else
          top = 0
          height = diameter
          y1 = y2 = radius

        if dir == 5 || dir == 6 || dir == 7
          left = -diameter
          width = diameter * 2
          x1 = radius
          x2 = radius + diameter
        else if dir == 1 || dir == 2 || dir == 3
          left = 0
          width = diameter * 2
          x1 = radius + diameter
          x2 = radius
        else
          left = 0
          width = diameter
          x1 = x2 = radius

        switch dir
          when 0
            x1 = radius * Math.cos(Math.PI * 2.00) * +1 + radius
            y1 = radius * Math.sin(Math.PI * 2.00) * -1 + radius
            x2 = radius * Math.cos(Math.PI * 2.00) * +1 + radius
            y2 = radius * Math.sin(Math.PI * 2.00) * -1 + radius + diameter
          when 1
            x1 = radius * Math.cos(Math.PI * 1.75) * +1 + radius + diameter
            y1 = radius * Math.sin(Math.PI * 1.75) * -1 + radius
            x2 = radius * Math.cos(Math.PI * 1.75) * +1 + radius
            y2 = radius * Math.sin(Math.PI * 1.75) * -1 + radius + diameter
          when 2
            x1 = radius * Math.cos(Math.PI * 1.50) * +1 + radius + diameter
            y1 = radius * Math.sin(Math.PI * 1.50) * -1 + radius
            x2 = radius * Math.cos(Math.PI * 1.50) * +1 + radius
            y2 = radius * Math.sin(Math.PI * 1.50) * -1 + radius
          when 3
            x1 = radius * Math.cos(Math.PI * 1.25) * +1 + radius + diameter
            y1 = radius * Math.sin(Math.PI * 1.25) * -1 + radius + diameter
            x2 = radius * Math.cos(Math.PI * 1.25) * +1 + radius
            y2 = radius * Math.sin(Math.PI * 1.25) * -1 + radius
          when 4
            x1 = radius * Math.cos(Math.PI * 1.00) * +1 + radius
            y1 = radius * Math.sin(Math.PI * 1.00) * -1 + radius + diameter
            x2 = radius * Math.cos(Math.PI * 1.00) * +1 + radius
            y2 = radius * Math.sin(Math.PI * 1.00) * -1 + radius
          when 5
            x1 = radius * Math.cos(Math.PI * 0.75) * +1 + radius
            y1 = radius * Math.sin(Math.PI * 0.75) * -1 + radius + diameter
            x2 = radius * Math.cos(Math.PI * 0.75) * +1 + radius + diameter
            y2 = radius * Math.sin(Math.PI * 0.75) * -1 + radius
          when 6
            x1 = radius * Math.cos(Math.PI * 0.50) * +1 + radius
            y1 = radius * Math.sin(Math.PI * 0.50) * -1 + radius
            x2 = radius * Math.cos(Math.PI * 0.50) * +1 + radius + diameter
            y2 = radius * Math.sin(Math.PI * 0.50) * -1 + radius
          when 7
            x1 = radius * Math.cos(Math.PI * 0.25) * +1 + radius
            y1 = radius * Math.sin(Math.PI * 0.25) * -1 + radius
            x2 = radius * Math.cos(Math.PI * 0.25) * +1 + radius + diameter
            y2 = radius * Math.sin(Math.PI * 0.25) * -1 + radius + diameter

        div.append '' +
          '<div style="position:absolute;top:' + top + 'px;left:' + left + 'px;height:' + height + 'px;width:' + width + 'px">' +
            '<svg height="' + height + 'px" width="' + width + 'px">' +
              '<line x1="' + x1 + '" y1="' + y1 + '" x2="' + x2 + '" y2="' + y2 + '" style="stroke:black;stroke-width:2" />' +
            '</svg>' +
          '</div>'

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