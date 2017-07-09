class CreditDecorator < Draper::Decorator
  delegate_all

  # общая сумма оплаченного платежа
  def overall_sum
    (object.payed_credit + object.payed_percents).round(2)
  end
end
