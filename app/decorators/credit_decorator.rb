class CreditDecorator < Draper::Decorator
  delegate_all

  # сумма ежемесячного платежа по процентам
  def period_payment_interest_sum
    (object.sum * object.annual_rate_in_percents / 12 * 100).round(2)
  end

  # общая сумма ежемесячного платежа
  def overall_payment_sum
    (object.period_payment_сredit_sum + object.period_payment_interest_sum).round(2)
  end

  # общая сумма выплат за весь кредит
  def overall_sum
    object.overall_payment_sum * object.term_in_months
  end

  def display_name
    "#{object.sum.round} р. на #{object.term_in_months} #{Russian.pluralize(object.term_in_months, 'месяц', 'месяца', 'месяцев')}"
  end
end
