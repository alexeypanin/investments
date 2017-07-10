$ ->
  $("input.slider").slider({	tooltip: 'always' })
  $("input.slider_for_percents").slider({
    tooltip: 'always',
    formatter: (value) ->
      value + '%'
  })