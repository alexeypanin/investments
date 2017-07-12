$ ->
  $("input.slider").slider
    tooltip: 'always'

  $("input.slider_for_percents").slider
    tooltip: 'always',
    formatter: (value) ->
      value + '%'

  $('.chosen-select').chosen
      allow_single_deselect: true
      no_results_text: 'No results matched'
      placeholder_text_multiple: 'Необходимо выбрать компании для инвестирования'
      width: '200px'

  updateInvestField = (obj) ->
    $('#investment_sum').val(obj.value)
    calculateInvestment()

  calculateInvestment = () ->
    sum = parseInt($('#investment_sum').val())

    if sum > 0
      selected_companies = $('#companies').chosen().val()
      # data = gon.credits
      data = $('#credits_array').data('credits')

      if selected_companies != null
        optimistic = Math.round(sum * 1.3)
      else
        optimistic = sum
      $('#amount_optimistic').val(numeral(optimistic).format('0,0') + ' р.')

      payed_credit = 0
      payed_percents = 0
      realistic_percents = 0
      annual_income = 0
      credits_count = 0

      if selected_companies != null
        for company_id in selected_companies
          for credit in data[company_id]
            credits_count += 1
            payed_credit += credit.payed_credit
            payed_percents += credit.payed_percents
            annual_income += credit.annual_income_in_percents

        realistic_percents = payed_percents / payed_credit / 6 * 12 # формула корректна только если все кредиты по 6 месяцев
        # realistic_percents = (annual_income / credits_count) / 100.0

      realistic = Math.round(sum * (1 + realistic_percents))
      $('#amount_realistic').val(numeral(realistic).format('0,0') + ' р.')
      $('#real_percents').html("Годовая доходность (#{Math.round(realistic_percents * 100)}%)")

  $('.chosen-select').chosen().change(calculateInvestment)

  $("input#investment_slider").slider(
    tooltip: 'always',
    formatter: (value) ->
      numeral(value).format('0,0') + ' р.').on('slide', updateInvestField)

  elem = $('#investment_sum')
  elem.data('oldVal', elem.val())

  elem.on "propertychange change click keyup input paste", (event) ->
    if elem.data('oldVal') != elem.val()
      calculateInvestment()
      $("input#investment_slider").slider('setValue', elem.val())

  $('#invest-button').click () ->
     sweetAlert({title: "<h3>Мы с вами свяжемся!</h3><img src='/money.png'>", timer: 5000, showConfirmButton: true, html: true });

  $('#amount_realistic').readOnly = true
  calculateInvestment()